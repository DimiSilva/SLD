# sld.roadmap.sync

Sincroniza o roadmap da track com slices reais criadas/executadas.

## Papel da skill

Manter `roadmap.md` coerente com o estado real do diretorio `slices/` e do `.current-slice`.

## Entradas

- `.sld/current-track`
- `.current-slice`
- `roadmap.md`
- diretorio `slices/`

## Regras

- nao inventar slices inexistentes;
- mapear slices reais para itens planejados por similaridade de nome/intencao;
- quando nao houver correspondencia clara, marcar item como `manual_alignment_needed`.

## Saida esperada

- `status`: `synced` | `partial` | `blocked`
- `updated_items`
- `manual_alignment_needed` (se houver)
- `next_recommended_slice`

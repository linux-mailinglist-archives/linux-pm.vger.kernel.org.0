Return-Path: <linux-pm+bounces-38504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 202ABC82945
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 22:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E53384E2318
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 21:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F66F32FA0E;
	Mon, 24 Nov 2025 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8gbVOtl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496532F770;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021218; cv=none; b=hLK3RSHIuPemUwPKIt/khXUEAENOXPc6bkgPp0nQu+QkSxqdd5Bd1vk6p0h0zvz5uYrTQf6Wi82qfmSZ+uZB6LNmJ7I0MNK8JrqhwI2KWQJLq/VJakMVR+SwFAVUoSlJEAb9RrqKe/OH6yFjhVdHuSusGGN3T1Jhkrwj10cAGlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021218; c=relaxed/simple;
	bh=fOs/F2KMPPaBYV2HNCIjkY7xRCV4fqBF2vABwAXElzY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iRv9bonSp6XDoGToql+LGxnvoRhIc8P2xc0bop2MYRXlfqhKPIaDocO28g2pGQFVejnPhmTHsHbN+narJxvGmQMKnwBmYt2rhefVVQuPmRM58WOgE0PzkawNf2P1Z6TCaMY9RQWwh/Cgujgs8+LVONL+KApTvgNfS5ebE/LEh0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8gbVOtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19E3DC4CEF1;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764021218;
	bh=fOs/F2KMPPaBYV2HNCIjkY7xRCV4fqBF2vABwAXElzY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=b8gbVOtlNOUv8O/F6BChX6eijsjzIuNgzMjl1pRA1zGXK8omI5xvJFgxb+3Q/Z1WG
	 JgSw5/pmGLjCDaLUl7WGUSeLINXmdkA27Il/wpLk8U3wHl2JhS9Pb2yIL88uqz+94C
	 Du3/cRCZb6CxJB/uTpViZn1aFqnHEIutPZlMR9z1x1krG59HNTYI2pqlEiUUBvnYkR
	 nNUCD8iEMP2roSgjx1HfU6ZViJWvGeQcLd/qkc9UaafBZCWUBdk6wHF92JYctoDfqD
	 92mAsJDtvCds4J8EFV34VmOOOwrstFNF4Bwp5OgPUJBpDQTxrATlxnezPV8oqiuAkJ
	 gIO7s3hCBJTvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B488CFD31D;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH RFC 0/8] Qualcomm 3rd gen fuel gauge support
Date: Mon, 24 Nov 2025 22:53:33 +0100
Message-Id: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN3TJGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQyND3YLcTAtLS4v4tNLUnPj0xFKgiuS0xDRzi9QUQwPjFCWgxoKi1LT
 MCrCh0UpBbs5KsbW1AL1/tXFpAAAA
X-Change-ID: 20251121-pmi8998_fuel_gauge-cfaf78ed103d
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Casey Connolly <casey@connolly.tech>, Joel Selvaraj <foss@joelselvaraj.com>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Richard Acayan <mailingradian@gmail.com>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3930; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=fOs/F2KMPPaBYV2HNCIjkY7xRCV4fqBF2vABwAXElzY=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpJNPfwOh1DLgBnwM5ap8sRP0b+zJPbHFkktSum
 XctX7K9rImJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaSTT3wAKCRBgAj/E00kg
 clQaD/wLcC2yy+RovNymSJnl+/PabF4grDFGhltT7eYfv+WQZheqq3A557SPGOTEhAp2FF890Nf
 7K0d4Jbr+LM6k0uBGeme6zp0orTCk+eueWcBxLy4lAnBc3IyKts8nVHOZYmW7vkwFUq99SAtf4o
 251WGH4eEhBN3FqSi99IGCT9QFL0Zdl6AG8FmhcGmcPQvZr4Hcobq80zDdv04Li1bPoREr3fq75
 gHE3k6ecA6ql9L43Ph7Hn15TqoIJSnLeIEcMJNEehWOAPBhaoU5etPbHQfeaK5rNEShrtaOC5Td
 J0dpiHDnKaRog8swYIU+8tGosUeUdizfn75vcEu1XvWNLi1K4h7OTepyuehSFsQNkl+YiuNKkLh
 wS6cPQYL3XPyyO0C0YjmxhSLSht6Lax4CLF8Ly90OdDNBqTB8A8byK7GyYQFOAQB/hjTUtmPtgm
 Bcpy4Eo6sWnCJfRqrKPPsYdNeIBY2Ip5elf8OqqabfJD77UR8MBdBUqdRjjvj48BQzS2t8lnYSv
 JYTPikYAqwgkEdBckUoVassMaB9bcteNJHF4UEsmXa4ZA/By4TP3KYH4IkBj5WbQNkV/YnvHyXh
 98l27xBb+3XXCEYpp79+0GbLEySSwOZmrQolhzH2B4NmI99WxDp4VniX64CFbTHh4zVHGv+guXS
 8ak3MHdN/AIVYIQ==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

This FG (fuel gauge) can be found on Snapdragon 835, 845, 660, 670..

Series enables the FG, which is used on phones as OnePlus 6, 6T, Pixel 3a..

Since many downstream trees (sdm845-mainline, sdm660, sdm670) carring
these patches, after Barnabás dropped older gen support from the driver,
cleaned up the driver, I picked changes and cleaned up device-tree
patches and sending the whole bulk for review.

Note:
Usually I picked the oldest commits authors.
Since there was multiple patches, multiple names and modifications etc.,
if someone from the authors, co-developers, contributors etc. missing,
please let me know and I'll fix this up in the next series.

Currently some authors are unreachable or haven't given Signed-off-by
yet, thus RFC, when this get cleaned up, I'll sent non-RFC or leave it
to the authors to continue upstreaming process in case they want to.

Until merged (or taken over by the original authors), the series is
available at:
  https://gitlab.com/sdm845/sdm845-next/-/commits/b4%2Fpmi8998_fuel_gauge

Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v1:
- Clean and read charge full and max voltage from dts. (Joel)
- Dont put battery info on remove. All the battery info data is devm
  tracked so it will be freed for us on removal. (Casey)
- Invert charging current. Battery current should be negative for charging
  batteries, invert it so it's correct. Fixes upower charging status
  reporting. (Casey)
- Expose PROP_STATUS to fix upower not detecting charging status properly.
- Adopt battery info API changes.
- Silence -EPROBE_DEFER error. (Richard)
- Add present sysfs property. Required for battery drivers from
  UPower>=1.90.0 onwards to work properly. (Alexander)
- Drop support for older gen from the driver. (Barnabás)
- Rename the driver to pmi8998_fg. (Barnabás)
- Remove unnecessary batt_info. (Barnabás)
- Fix all checkpatch issues in strict mode. (Barnabás)
- Fixed naming, properties sorting, styling issues, few checkpatch
  warnings. (David)
- Updated Joel to "Joel Selvaraj <foss@joelselvaraj.com>" everywhere
  (patch author, author field inside the driver, dt docs). (David)
- Link to v0:
  - https://gitlab.com/msm8998-mainline/linux/ (very old)
  - https://gitlab.com/sdm845-mainline/linux/ (multiple branches)
  - https://github.com/sdm660-mainline/linux/
  - https://gitlab.com/sdm670-mainline/linux-patches/-/tree/main/stable

---
Alexey Minnekhanov (1):
      arm64: dts: qcom: sdm660-xiaomi-lavender: Enable support for battery

Casey Connolly (2):
      arm64: dts: qcom: pmi8998: Add fuel gauge
      arm64: dts: qcom: sdm845-shift-axolotl: Enable fuel gauge

Joel Selvaraj (2):
      power: supply: Add driver for Qualcomm PMI8998 fuel gauge
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable fuel gauge

Richard Acayan (2):
      arm64: dts: qcom: pm660: Add fuel gauge
      arm64: dts: qcom: sdm670-google-sargo: Enable fuel gauge

Yassine Oudjana (1):
      dt-bindings: power: supply: Add schema for Qualcomm pmi8998 fuel gauge

 .../bindings/power/supply/qcom,pmi8998-fg.yaml     |  77 +++
 arch/arm64/boot/dts/qcom/pm660.dtsi                |  10 +
 arch/arm64/boot/dts/qcom/pmi8998.dtsi              |  11 +
 .../arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts |  25 +
 arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts   |   7 +
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts  |   7 +
 .../dts/qcom/sdm845-xiaomi-beryllium-common.dtsi   |   7 +
 drivers/power/supply/Kconfig                       |   8 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/pmi8998_fg.c                  | 687 +++++++++++++++++++++
 10 files changed, 840 insertions(+)
---
base-commit: 422f3140bbcb657e1b86c484296972ab76f6d1ff
change-id: 20251121-pmi8998_fuel_gauge-cfaf78ed103d

Best regards,
-- 
David Heidelberg <david@ixit.cz>




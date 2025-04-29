Return-Path: <linux-pm+bounces-26400-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F77AA3BC5
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 00:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A11462491
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 22:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5422BCF7C;
	Tue, 29 Apr 2025 22:55:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1DA2BCF59;
	Tue, 29 Apr 2025 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745967308; cv=none; b=DEYjCkLCNWK4yenZpHSMtvqu8r73H6pGr/I4eY3Onu9lpdDrfCbMHJao0FJ7F6s6Rtw/CW3obcpvSjGWKhWkvJIO63mHuHaBbBcRlXWINZPhyuB0GXALtXBJ2sbr7ZftUF5SMWZqRkttSoLpS2KeVMEjgCcXbfbgAd4Kpn7gxy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745967308; c=relaxed/simple;
	bh=Qg7dbWo30d2R/S/bXavA5Q5cFMZ+5uXYXTvq8MvcP/I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YgH6muboJ4YS48iS3iu5o+OeEDSDm77XEL68czts/JeBZAuIRBVg5QVcaOdMNq/djxGZimHzwdOTOF42Qdip+HAB1gIGq8eNY/ViaeqsDEzQ+/lFI1313wT5irVHmUIJ3RkRe8MJ+Z5FnpAnAiAiV7Hyk+a+/tY0MKrWzlXCIeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB37C4AF09;
	Tue, 29 Apr 2025 22:55:07 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 98054180E71; Wed, 30 Apr 2025 00:55:05 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 0/5] power: supply: core: convert to fwnode
Date: Wed, 30 Apr 2025 00:54:22 +0200
Message-Id: <20250430-psy-core-convert-to-fwnode-v2-0-f9643b958677@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ5YEWgC/33NwQqDMAzG8VeRnJeh1QrutPcYHmpNZ8E1I5VuI
 r77OmHXXQL/HH7fBpHEU4RLsYFQ8tFzyKFOBdjJhDuhH3ODKpUularwGVe0LJRPSCQLLozuFXg
 kHLXRTaOcrV0HGXgKOf8+8Fufe/JxYVmPrVR9vz9W/2NThWW2qanbrqvbYbhanmczsJiz5Qf0+
 75/AJ0ysxnIAAAA
X-Change-ID: 20250221-psy-core-convert-to-fwnode-d5a5442fc3f9
To: Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-phy@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2174;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=Qg7dbWo30d2R/S/bXavA5Q5cFMZ+5uXYXTvq8MvcP/I=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBoEVjHHm+QZt24518eVkCGiIkUGogfduz7bAMMN
 yvsyzZuGiqJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCaBFYxwAKCRDY7tfzyDv6
 mrbED/9hlVlNL6cchpUTF8R47pd72Q/GXJxNpiukcKuEVW7zkhSwEwkxtnFH3gTUhmWO3oVO/GG
 AinO9drL7hN4N+j9sGDkp1Y8szwd4Cb0r9qS+bKnKOQFEIWB2z+y3Kp97QRCkvpbCwmS1wymK7S
 3nupzUOda5hk/CKGadQi/aroM+UmUMhD5Pk5arlqtRaF8uuhxto3kFe6S1Qn3kGOw5O9GjsbRxe
 j7rp8fkYtckUHR47ozkFHnl5RO1YaAHXfegxtHSoGM74BLZ15kEtRJvcbdKnU1I+6VgNnaefQ6b
 FI/gtWbrVx+H3AeMWdGEZ6eSPx9Gq41NGrIid7aLdvQYgpPaIAuxTor1Ds/kzNC/uVVX5QJUamX
 EjZqKUD6lqW0uj04aTzcS2tsrBYT+dTvofKxyOR8szCqn6CvrNJMQqRZbgUbRAcYMEpNgCCCjiQ
 r/eOlTd0zfLYmZ/7RvpUEIN+xdhWvCWkJ15ZPzyW7hMAF/4QPobdwEEBWLNIyysGccwE7bahFbd
 En8cNoMFe8tGwEHLp1jDM1sIG3oaVcuR5iYX0TtK1+ENh5QIy/hGJdkKeU6BHGPPBs8oYd/J92a
 oE1sT0gjY04CQ5VNq76W7GdgL3H0T2xThU7EmlpwdutuOu0wcXEX/YBxUXLxxYVJ4MZXQLZVwS8
 NC9cM/Jg+bxyM8A==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

The goal of this series is to replace any OF specific code in the
power-supply core with more generic fwnode code.

The first 2 patches of this series mostly take care of removing .of_node
from power_supply_config in favor of using the existing .fwnode.

Patch 3 replaces the OF specific logic in battery-info. This will
hopefully also allow Hans de Goede reusing the code with his Intel
Dollar Cove TI CC battery driver series.

Patch 4 replaces the OF phandle code with fwnode to have everything
converted.

Finally patch 5 renames some functions to remove the OF terminology
and allows using them without CONFIG_OF being enabled.

Note, that I do not own a single device making use of the
"ocv-capacity-celsius" and "resistance-temp-table", which means patch 3
is basically untested. I would really appreciate if somebody gives this
series a test run on an affected device.

Changes in PATCHv2:
- Link to v1: https://lore.kernel.org/r/20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com
- drop merged patches
- add new patch renaming power_supply_get_by_phandle to power_supply_get_by_reference
- rebase to latest power-supply for-next branch
- collected Reviewed-by
- rewrite cover letter accordingly

---
Sebastian Reichel (5):
      regulator: act8865-regulator: switch psy_cfg from of_node to fwnode
      power: supply: core: remove of_node from power_supply_config
      power: supply: core: battery-info: fully switch to fwnode
      power: supply: core: convert to fwnnode
      power: supply: core: rename power_supply_get_by_phandle to power_supply_get_by_reference

 drivers/phy/allwinner/phy-sun4i-usb.c    |   2 +-
 drivers/power/supply/bq2415x_charger.c   |   2 +-
 drivers/power/supply/power_supply_core.c | 193 +++++++++++++++++--------------
 drivers/regulator/act8865-regulator.c    |   2 +-
 include/linux/power_supply.h             |  16 +--
 5 files changed, 109 insertions(+), 106 deletions(-)
---
base-commit: fbc1d056d3f3d417bc9df521cb45a0f51758b64a
change-id: 20250221-psy-core-convert-to-fwnode-d5a5442fc3f9

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>



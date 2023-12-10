Return-Path: <linux-pm+bounces-869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6847480BB2F
	for <lists+linux-pm@lfdr.de>; Sun, 10 Dec 2023 14:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E43CFB20AC0
	for <lists+linux-pm@lfdr.de>; Sun, 10 Dec 2023 13:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAC5F9E5;
	Sun, 10 Dec 2023 13:47:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22CFEB3;
	Sun, 10 Dec 2023 05:47:28 -0800 (PST)
X-IronPort-AV: E=Sophos;i="6.04,265,1695654000"; 
   d="scan'208";a="189797746"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Dec 2023 22:47:26 +0900
Received: from localhost.localdomain (unknown [10.226.92.40])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6CDEB4003EBC;
	Sun, 10 Dec 2023 22:47:20 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Lee Jones <lee@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Support Opensource <support.opensource@diasemi.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Steve Twiss <stwiss.opensource@diasemi.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 0/8] Convert DA906{1,2} bindings to json-schema
Date: Sun, 10 Dec 2023 13:47:09 +0000
Message-Id: <20231210134717.94020-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the below bindings to json-schema
1) DA906{1,2} mfd bindings
2) DA906{1,2,3} onkey bindings
3) DA906{1,2,3} thermal bindings

Also add fallback for DA9061 watchdog device and document
DA9063 watchdog device.

Document missing gpio child node for da9062 and update MAINTAINERS entries.

Merge strategy:
Since there is binding dependency between input, thermal, watchdog and MFD
subsystem. it is decided that this series will go through the MFD tree.
So once the respective subsystem maintainers, DT and Renesas are happy
with the patch they can give an ack/rb tag, so that it can be applied to
MFD tree.

Note:

This patch series is same as v3.1 as it allows the tools (PW, b4)
to compare against previous versions.

The review comments/tags received for v4 + (a.k.a v3.1) will be
addressed in the next version(v5).

Link to v3.1: https://lore.kernel.org/all/20231204172510.35041-1-biju.das.jz@bp.renesas.com/

v4->v5:
 * Updated cover letter with merging strategy.
 * Added fixes tag for patch#1
 * Added Rb tags from Geert and Krzysztof for patch#1
 * Added Ack from Conor for patch#1
 * Added Rb tag from Geert and Ack from Conor for patch#2
 * Drop items and just use enum as it is easier to read for compatibles.
 * Retained the tags for patch#2 as it is trivial change.
 * Added Rb tag from Geert for patch#3
 * Updated commit header and description by replacing
   'watchdog property'->'watchdog child node'
 * Added Rb tag from Geert for patch#4.
 * Added Rb tag from Krzysztof and Conor for patch#5
 * Dropped Items, Just enum as it is easier to read compatibles.
 * Retained tags for patch#5 as the changes are trivial.
 * Updated commit description for patch#8
 * Dropped unnecessary ref from gpio child node.
 * Added gpio-hog pattern property
 * Moved gpio-controller,gpio-cells above child nodes
 * Sorted compatible in rtc child node.
 * Dropped status from example.
 * Updated the example.
v3->v4:
 * Patch#1 is merge of patch#1 from v2 + patch#8 from v2.
 * Dropped comment for d9061 watchdog fallback
 * Replaced enum->const for dlg,da9061-watchdog and its fallback.
 * Restored patch#4 in series 1 and dropped the thermal example
 * Added Ack from Conor Dooley for da9063 watchdog binding support.
 * Updated title DA9062/61->DA906{1,2,3} as it supports DA9063.
 * Retained Rb tag since the changes are trivial.
 * Added Ack from Conor for updating watchdog property
 * Dropped link to product information.
 * Patch#5(onkey) is squashed with patch#6 and patch#9 from v2.
 * Replaced enum->const for dlg,da9061-onkey and its fallback.
 * Dropped example
 * Restored the thermal binding patch from v2.
 * Dropped example
 * Replaced enum->const for compatible property.
 * Added Rb tag from Rob and retained Rb tag as changes are trivial.
 * Added Ack from Conor Dooley for patch#7.
 * Split the thermal binding patch separate
 * Updated the description
v2->v3:
 * Updated Maintainer entries for watchdog,onkey and thermal bindings
 * Fixed bot errors related to MAINTAINERS entry, invalid doc
   references and thermal examples by merging patch#4. 

v1->v2:
 Link: https://lore.kernel.org/all/20231201110840.37408-5-biju.das.jz@bp.renesas.com/
 * DA9062 and DA9061 merged with DA9063
 * Sorted the child devices
 * mfd,onkey and thermal are pointing to child bindings

Biju Das (8):
  dt-bindings: mfd: da9062: Update watchdog description
  dt-bindings: watchdog: dlg,da9062-watchdog: Add fallback for DA9061
    watchdog
  dt-bindings: watchdog: dlg,da9062-watchdog: Document DA9063 watchdog
  dt-bindings: mfd: dlg,da9063: Update watchdog child node
  dt-bindings: input: Convert da906{1,2,3} onkey to json-schema
  dt-bindings: thermal: Convert da906{1,2} thermal to json-schema
  dt-bindings: mfd: dlg,da9063: Sort child devices
  dt-bindings: mfd: dlg,da9063: Convert da9062 to json-schema

 .../bindings/input/da9062-onkey.txt           |  47 ----
 .../bindings/input/dlg,da9062-onkey.yaml      |  38 +++
 .../devicetree/bindings/mfd/da9062.txt        | 124 ---------
 .../devicetree/bindings/mfd/dlg,da9063.yaml   | 248 +++++++++++++++---
 .../bindings/thermal/da9062-thermal.txt       |  36 ---
 .../bindings/thermal/dlg,da9062-thermal.yaml  |  35 +++
 .../watchdog/dlg,da9062-watchdog.yaml         |  12 +-
 MAINTAINERS                                   |   6 +-
 8 files changed, 298 insertions(+), 248 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/da9062-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt
 delete mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml

-- 
2.39.2



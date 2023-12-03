Return-Path: <linux-pm+bounces-649-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1C480230D
	for <lists+linux-pm@lfdr.de>; Sun,  3 Dec 2023 12:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FA81C208EA
	for <lists+linux-pm@lfdr.de>; Sun,  3 Dec 2023 11:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB9EB670;
	Sun,  3 Dec 2023 11:32:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29E83B6;
	Sun,  3 Dec 2023 03:32:10 -0800 (PST)
X-IronPort-AV: E=Sophos;i="6.04,247,1695654000"; 
   d="scan'208";a="185128626"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Dec 2023 20:32:08 +0900
Received: from localhost.localdomain (unknown [10.226.92.30])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A373A403E66D;
	Sun,  3 Dec 2023 20:32:02 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 00/11] Convert DA906{1,2} bindings to json-schema
Date: Sun,  3 Dec 2023 11:31:48 +0000
Message-Id: <20231203113159.92316-1-biju.das.jz@bp.renesas.com>
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

v2->v3:
 * Updated Maintainer entries for watchdog,onkey and thermal bindings
 * Fixed bot errors related to MAINTAINERS entry, invalid doc
   references and thermal examples by merging patch#4. 

v1->v2:
 Ref: https://lore.kernel.org/all/20231201110840.37408-5-biju.das.jz@bp.renesas.com/
 * DA9062 and DA9061 merged with DA9063
 * Sorted the child devices
 * mfd,onkey and thermal are pointing to child bindings



Biju Das (11):
  MAINTAINERS: Update da9062-watchdog bindings
  dt-bindings: watchdog: dlg,da9062-watchdog: Add fallback for DA9061
    watchdog
  dt-bindings: watchdog: dlg,da9062-watchdog: Document DA9063 watchdog
  dt-bindings: input: Convert da906{1,2,3} onkey to json-schema
  dt-bindings: mfd: dlg,da9063: Update watchdog property
  dt-bindings: mfd: dlg,da9063: Update onkey property
  dt-bindings: mfd: dlg,da9063: Sort child devices
  dt-bindings: mfd: da9062: Update watchdog description
  dt-bindings: mfd: da9062: Update onkey description
  dt-bindings: mfd: da9062: Update thermal description
  dt-bindings: mfd: dlg,da9063: Convert da9062 to json-schema

 .../bindings/input/da9062-onkey.txt           |  47 ----
 .../bindings/input/dlg,da9062-onkey.yaml      |  60 +++++
 .../devicetree/bindings/mfd/da9062.txt        | 124 ----------
 .../devicetree/bindings/mfd/dlg,da9063.yaml   | 221 +++++++++++++++---
 .../bindings/thermal/da9062-thermal.txt       |  36 ---
 .../bindings/thermal/dlg,da9062-thermal.yaml  |  78 +++++++
 .../watchdog/dlg,da9062-watchdog.yaml         |  12 +-
 MAINTAINERS                                   |   6 +-
 8 files changed, 336 insertions(+), 248 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/da9062-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt
 delete mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml

-- 
2.39.2



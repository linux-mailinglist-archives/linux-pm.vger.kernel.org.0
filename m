Return-Path: <linux-pm+bounces-32732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92519B2E428
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 19:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FD51BA271A
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 17:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53A225BEE5;
	Wed, 20 Aug 2025 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LSvBakml"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA1525A325;
	Wed, 20 Aug 2025 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711666; cv=none; b=giAmujY/llRjr9J3LECn5KOwaozjScSVds9AC8Qsrlos8RgOPm05deperGu96LhSqAB+jWvcMOq1s7sN/MVA0OtbdSzYtceeabe/AGd/Dt1VnMa823yYSdQockeQ7keTkHq7Y1YV/TOxlX1fDrm4uQitnkMhEjF09kYeroaKDfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711666; c=relaxed/simple;
	bh=lSpNz/HktqKbyem+gTYF2HAmO6093ZOlrVZxX0qJrOo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QKCnNOBejeFqMGKw8xcRCxp2HgWOHASAlf2YK+JHfCEpcXaSjX06YOBUTy4FFq3IfLXVwe6y+Nh07P4ThALStd1O7FtKdj06PRka9M1aguMn3PsUX0y5mg4U+r+WRvpZ4OBLYoHs4UBye0nNK8h1HJ77VzOsOmm3tkcxuzwTgGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LSvBakml; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755711657;
	bh=lSpNz/HktqKbyem+gTYF2HAmO6093ZOlrVZxX0qJrOo=;
	h=From:Subject:Date:To:Cc:From;
	b=LSvBakmlGm4j4cdc9EExHD+IVEZ2JZrQdKzylNb9vO6Y3UNuTIGGRPxr2ONLEAKZH
	 SNoEkIlJw+ZINATwunwlgPNsCcuOey5/UtYCwA4dCqDg1HB4ncl/Bng8QGVtuMR7ip
	 D/WI8EnIl5n4SvjoVb7DIXJBEzjbOlAq8TDc3YI556+r5IR6ag37udk2ogpGFCDPxt
	 FfYCJADisNIhrI5rNZucmOPozKb2ZtZkhlxq9N/RveztNa70vPweXnnix3wp7fzAA3
	 AOR84wZBG6IVOT9d5oXTyeFwCiZxVd+2I0jLNA+BQ9hirJqledXKa0BzSVpPHl5CbA
	 qT20cuH1NUdmg==
Received: from jupiter.universe (dyndsl-091-248-213-114.ewe-ip-backbone.de [91.248.213.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E476017E0593;
	Wed, 20 Aug 2025 19:40:56 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id A325B480044; Wed, 20 Aug 2025 19:40:56 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 0/3] thermal: rockchip: shut up GRF warning
Date: Wed, 20 Aug 2025 19:40:46 +0200
Message-Id: <20250820-thermal-rockchip-grf-warning-v2-0-c7e2d35017b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ4IpmgC/42NSw7CIBRFt9IwFgMo/Y3ch+mA4ANeWqF5NFXTd
 O9iV2Du6NzBORvLQAiZ9dXGCFbMmGIBdaqYDSZ64PgozJRQWrSy5UsAepqJU7KjDThzT46/DEW
 MngvtGqdr1dZGsaKYCRy+D/19KBwwL4k+R22Vv/dP8Sp52eUqtbJdI7rmNgJFmM6JPBv2ff8Ci
 FWvmckAAAA=
X-Change-ID: 20250818-thermal-rockchip-grf-warning-05f7f56286a2
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, 
 Diederik de Haas <didi.debian@cknow.org>, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=sre@kernel.org;
 h=from:subject:message-id; bh=lSpNz/HktqKbyem+gTYF2HAmO6093ZOlrVZxX0qJrOo=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGimCKhcek5TEXx6SJzgH2OCzYml2zCBymbdF
 OVFOevcyrgLw4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJopgioAAoJENju1/PI
 O/qaYUYP/jokdAyYlbnf5HoMZGOaszy67FqML+1rs26JJ8L1LvGfB0CVCfB2ud2C/A1f/DASFnn
 OwQWGFfiaPPCd3qLseid+Pg2KIXAjmXbTxp6+COktH9zxURSGq5yp8+KqamWzJvjPImY1rS5NDr
 8A3t47KQwB0ZUDh3c0gGvaw01c0DcufGYBe9BNIxrzO4gZYkBQ5/sBRp35bgblXpz4+4kSFpd1e
 pDj81omftLgdufy11mUMlZ4TcFbmE1RhscUiN5R/vNeCyvmQTrecsiaKuWEgAkWKVlmrzgIC9xd
 4SD1ka04o5gepajeE4HYorTYPPkbEHp2Bv9iu8OS4fWRD42nZ427EPN/jwyx22fSps1WSg+2lpq
 Cyqcy2mc2TILchmprs/jTqY7l85UKrSMo3tD+a+VD7wTh1uFOvjwgOF+Vqr2pj0wm3l5HXaH3kZ
 IygsRczBZpXuDf40c6VgBk6nmPG5L6/bfn4HI2uI+MH8g2O4P/LX/KTgLFUJ55LOVHBKevqqISK
 Lhvdw3EzHHqpX4o3bICJEn9bt8LM/w/ggb3MJN3Ms5RoG9YaOmHxHSq/GXYET645UrSjGWAvEKK
 Z2VCsd7CZJ08iFtrIJM5QDiRmxMphToR/ibwOmE7kfATDQVHDVuNKZDAmXi3fgrmes9l3gNWLtl
 IFgynaZXRb5vRI7zJ/c0vZA==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Changes in v2:
- Link to v1: https://lore.kernel.org/r/20250818-thermal-rockchip-grf-warning-v1-1-134152c97097@kernel.org
- Add patch droping extra newlines in older chip info structures (Heiko)
- Add patch updating DT bindings to make GRF either mandatory or unallowed (Heiko, Robin)
- Update previous patch to only differntiate between mandatory and no GRF (Heiko, Robin)
- Update struct documentation (kernel test robot)
- Do not collect Tested-by from Diederik, as too much changed in this version

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Sebastian Reichel (3):
      thermal: rockchip: unify struct rockchip_tsadc_chip format
      thermal: rockchip: shut up GRF warning
      dt-bindings: thermal: rockchip: tighten grf requirements

 .../bindings/thermal/rockchip-thermal.yaml         | 15 +++++++
 drivers/thermal/rockchip_thermal.c                 | 50 ++++++++--------------
 2 files changed, 33 insertions(+), 32 deletions(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250818-thermal-rockchip-grf-warning-05f7f56286a2

Best regards,
-- 
Sebastian Reichel <sre@kernel.org>



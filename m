Return-Path: <linux-pm+bounces-38837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AACC8FFA7
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 20:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E83EF34BA3D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 19:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C28A30277E;
	Thu, 27 Nov 2025 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="h/ey+QDy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CE5245020;
	Thu, 27 Nov 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764270202; cv=none; b=H1j0R6joMum3/hc3PjoiHg9J+p8Bws7VyMTi4ZEA6BudChjhWCELMRxnqZ0k053CO8JiNNEUg52Fw/1Z7PNCFi6WbBU4k16KUCLIrQAU1rXjUjGpRA4bVztjyiWqX/SFNlLQ4Ow8CXoEYCNH52UtllVHw/AV5eCHNFSB+2j0wTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764270202; c=relaxed/simple;
	bh=Hq+ia8yuvWeSgRBSknYS+Lxj4lqFaONNtRJe0qwPyDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SROc27k9GO3wjqhL+ay77+GvnmSnNL1UnY6lbbDjjXl4h8Yc3L8rWd0OElQiYCB1TtFxTogiKDo8T0kRBniNa1fLWqyEkz1HKwx4LINLLf7cqcdvhsP76QrX+tR666dDr80ZK1atfXq4dEbwZxAFGMoB1Q0/g4+SIuvve+iANtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=h/ey+QDy; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560+5C/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1764270174; x=1765570174;
	bh=bbDeeML+5/PqsYJ+tyaJ3n3d7uxwNPB/ux5rFNomCWA=; h=From;
	b=h/ey+QDyOMcWQcdbkE8ek4GGzy1XZshTm5L0n32Yl3nI/SmWo7NrnIYNYNzqOlN+h
	 zuT4nzBeYjCaZTrZ5EYPLqr74Yi1ViAODeVDK6LV55/BCS9lPG3zbqXMT2HZPi5ZvO
	 WrBglNjewAq4elAGQQ6XecpIK/IwEABTiMAEtc+0g9+eNrteL5w6+kwd0hdkyis61r
	 mYSAzyNOPAybpJtVIbHoMVzbs0xCtUAv7BtDZ5w1HwYDRYzzG3M6QKC4mOQyy7tIA4
	 Tn9ZIKGLR+9ydOKGCTL0agcr/gUHoTnAOWsT0DrkiJXh9NXdNKn73bpv8AVE2TFy62
	 h3WMxBNXLw1IA==
Received: from localhost (nat2.prg.suse.com [195.250.132.146])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.18.1/8.18.1) with ESMTPS id 5ARJ2rYV008156
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 20:02:54 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
From: Karel Balej <balejk@matfyz.cz>
To: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Karel Balej <balejk@matfyz.cz>
Subject: [PATCH 1/2] dt-bindings: power: define ID for Marvell PXA1908 audio domain
Date: Thu, 27 Nov 2025 20:02:02 +0100
Message-ID: <20251127190237.745-1-balejk@matfyz.cz>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****

Define an identifier for the SoC's audio power island so that it can be
referenced through device tree.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 include/dt-bindings/power/marvell,pxa1908-power.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/power/marvell,pxa1908-power.h b/include/dt-bindings/power/marvell,pxa1908-power.h
index 19b088351af1..173f47e0e69d 100644
--- a/include/dt-bindings/power/marvell,pxa1908-power.h
+++ b/include/dt-bindings/power/marvell,pxa1908-power.h
@@ -13,5 +13,6 @@
 #define PXA1908_POWER_DOMAIN_GPU2D	2
 #define PXA1908_POWER_DOMAIN_DSI	3
 #define PXA1908_POWER_DOMAIN_ISP	4
+#define PXA1908_POWER_DOMAIN_AUDIO	5
 
 #endif
-- 
2.51.2



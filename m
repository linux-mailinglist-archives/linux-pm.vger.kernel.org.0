Return-Path: <linux-pm+bounces-39480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD0DCBA753
	for <lists+linux-pm@lfdr.de>; Sat, 13 Dec 2025 09:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFFAC306EED0
	for <lists+linux-pm@lfdr.de>; Sat, 13 Dec 2025 08:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A812C11F1;
	Sat, 13 Dec 2025 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="W4plroK2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD1D2C11C7;
	Sat, 13 Dec 2025 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765615796; cv=none; b=iKs4BKvPiyysBPlDtwWK0W9OU1BnUWK4ux2RrkkHbzsrEWWvVtV9KxX18nMN4pumpyU42Nex+t8vbowW8FdEhBDTk7fZZFLzqfc79eFWWeO+phdLCG206mx0gmCRh0nguNI4ujpE7F5UESLYuInQXhe10XIURaxPmmzsrgTzPDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765615796; c=relaxed/simple;
	bh=Lmg1bqIhkrWTJCAPgB5H4cWELl/ZFtQzVJyDAiq3pR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BfQM7uMhzHBZHVXsNlhn1RMbP4PPKlLgnniy2TrX8myuxhNwQ0WNoOGOmtdttwVLVWyCa0UM0h/olJIwvdiRvawxhJeo5+ZPgKYCl4ykvPwJzilPZ+DwkdnV2WTZ3woPsif9qytoqeO/ML63QNoPfadZ0LvKw74O0cAfSCwqrR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=W4plroK2; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560+5C/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1765615742; x=1766915742;
	bh=MsJ/bbje7wscSwZPWlgEMlKtiOAlEmU0N4goIajw7B8=; h=From;
	b=W4plroK2aGc8coBxZGC4nza2c3SitcVOSLEzgydCidHCuBrNBvMdJusVb6S0JkMZW
	 f9znjwQmGI8xG32cViAoN53pCDhdLse5wWjjBOz2jwFsp1vZEHAKXakXCTJt/e4Lqe
	 mUMZ7cA4KPmmvsQkNfPlJmkuZSNFZIHKwde8GM9veZEgkn/vlmfqEFxHvYrwroKiGL
	 RWtKVRG5KUtgapKmHrAnrJ9OjST1PhDT9t6Z7cXujlO++l7h/wu9gs/d06qmG1VUPO
	 WxBn+pfWI2RmGIOMfa9IZ8OB1KejQtQ3l+wgolCuZvggNAIVtj4Bz40J/d7wJ2uaQ+
	 S9sR/aobENiJA==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.18.1/8.18.1) with ESMTPS id 5BD8n1tx051949
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sat, 13 Dec 2025 09:49:02 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
From: Karel Balej <balejk@matfyz.cz>
To: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Karel Balej <balejk@matfyz.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 1/2] dt-bindings: power: define ID for Marvell PXA1908 audio domain
Date: Sat, 13 Dec 2025 09:48:12 +0100
Message-ID: <20251213084843.7491-1-balejk@matfyz.cz>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****

Define an identifier for the SoC's audio power island so that it can be
referenced through device tree.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Duje Mihanović <duje@dujemihanovic.xyz>
Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    v2:
    - Add received trailers (thanks!).
    - v1: https://lore.kernel.org/r/20251127190237.745-1-balejk@matfyz.cz/

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



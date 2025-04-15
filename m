Return-Path: <linux-pm+bounces-25494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983B4A8A76F
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 21:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399493B24C0
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 19:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D7C23BCF1;
	Tue, 15 Apr 2025 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="rMm8JcPs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8515323BCE3
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744028; cv=none; b=JNVhmOLWerWUvBvNKH+sUD4ectwxYxu+7ccNlCOyhv3Kpc8wEqhc8LODwiySoTiMdDafu+nft3vGooSYPBrkD9xASZxdIpcXnIUORpVoMlo7icy0o/GKvIOmXoDZ/gZBgPIEsTtZcGyC9w1k9qQBOEdLJoZyXLMv/vbszRbhSUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744028; c=relaxed/simple;
	bh=5B6W5Axa39RNsrZ2LH3YQVItpHCkdqV7bT/xrL18WtM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OAi1pwq3aKl8zFNrS4zRAWF3hRGXUiiX8JZEigsVAI2+j0lvKsXppJqYBUTIPMHZ/VULP1TO6xYmNud6Ctgq3c9/izO3AX3kg8zl06ZXApX7Ssssr/A5SDUiXnf+U0LtJLWRTmghNU9P7bNazfAoEciPKmhIE9tZWPgn4ntcg1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=rMm8JcPs; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744744019; x=1745348819; i=wahrenst@gmx.net;
	bh=cCwQ5OH7HpSnUA2I8u4CYx4eXCk/wLDgHDTozLOqFa4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rMm8JcPsD9eIcYoM7mcg8A2tbPHmA0EuXtg+IChQXevsjkTmDvh/c2UExHWqcjxf
	 EYat+yHz88qj+Cg+jb0eR92MLIJK95+znroZQ+j81IXManVxKt7pqVHLV2Yv9mKEF
	 edOfy9HW6WKmbfMZ1tzcq6zmwH1jbYBRlNKVvvIHmDcLdQXvrmNTVbaivh1f64xDD
	 4PN+sUGjtOpMS4rn+z+89z4C09MTEUWA0ief2xHkx4BUkJ/oUgewuVuC33OB+L5Xo
	 pD9Kg2bxSsI4a4Ur8edJNexJ09EBIpyT8loMpw959Qp1HLddKs90JVQwVrPK2IbxJ
	 otugwQia/hIdKVwomg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3Rs-1tjN7d0IbG-00WfDO; Tue, 15
 Apr 2025 21:06:59 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com,
	kernel-list@raspberrypi.com,
	linux-pm@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] pmdomain: bcm: bcm2835-power: Use devm_clk_get_optional
Date: Tue, 15 Apr 2025 21:05:58 +0200
Message-Id: <20250415190558.16354-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N7eX0O4lhHyMarYIfuL6NEPeVTyAPdwwF3hR3mycEBbzWEDXOaP
 ql47yOiJHaCTexnzb1pytCdUGaOoZE5xArW0VcQeVqCddVsrzz8TNEZR/Y2n+weh5Baq7YU
 PeUPkWkW1cdWU+qmqy/d6eCJzkovU1ko3PQ6q08dRMgqXH3U+YhVIE5fEsEdaVnfEI67W/M
 NBF6pJbEvCYv3iNakmJaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CdB8VSxBqBQ=;nexugSgrq6pyo0EVvAkWB/FXzcE
 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
 pe7eE++pZJSkl2XxOegaCg=

The driver tries to implement optional clock handling with devm_clk_get.
It treats all errors except EPROBE_DEFER as a missing clock, which is
not correct. So use devm_clk_get_optional here and get the corner-cases
right.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/pmdomain/bcm/bcm2835-power.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/b=
cm2835-power.c
index d3cd816979ac..f5289fd184d0 100644
=2D-- a/drivers/pmdomain/bcm/bcm2835-power.c
+++ b/drivers/pmdomain/bcm/bcm2835-power.c
@@ -506,18 +506,10 @@ bcm2835_init_power_domain(struct bcm2835_power *powe=
r,
 	struct device *dev =3D power->dev;
 	struct bcm2835_power_domain *dom =3D &power->domains[pd_xlate_index];
=20
-	dom->clk =3D devm_clk_get(dev->parent, name);
-	if (IS_ERR(dom->clk)) {
-		int ret =3D PTR_ERR(dom->clk);
-
-		if (ret =3D=3D -EPROBE_DEFER)
-			return ret;
-
-		/* Some domains don't have a clk, so make sure that we
-		 * don't deref an error pointer later.
-		 */
-		dom->clk =3D NULL;
-	}
+	dom->clk =3D devm_clk_get_optional(dev->parent, name);
+	if (IS_ERR(dom->clk))
+		return dev_err_probe(dev, PTR_ERR(dom->clk), "Failed to get clock %s\n"=
,
+							     name);
=20
 	dom->base.name =3D name;
 	dom->base.flags =3D GENPD_FLAG_ACTIVE_WAKEUP;
=2D-=20
2.34.1



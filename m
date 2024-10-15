Return-Path: <linux-pm+bounces-15719-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB4399FBEE
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 01:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DFFDB23828
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A841D95B5;
	Tue, 15 Oct 2024 23:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="IwLBXrrb"
X-Original-To: linux-pm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D981D9A4F
	for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2024 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729033199; cv=none; b=CdxBsC85Sy6Imbz+AQbYpOKnvPziyAiOvt6J6+OlOjfvW9RnrIBur59oBmNXACSzR1bnHaGZQp8A5pRdMtiRL83W4Lp+614craQHkTiFQK2M9E3uK5W7gx2ZPCvg4ByIq1ApYrr421KLrcjxs7S5iMx4Qr1LRh7LVgADVfiZDBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729033199; c=relaxed/simple;
	bh=/5WU5hCQX2Z1jlwxDKcyoCYzwu2CjAChxHZethJ6+8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQUgpscROtghiWgdqX+3tBwgv2ckjcCrkPZYVfl9JcrrirOHayLbO9wPQSA/4iy7k16KWnsEB0KvnCFIwnGLW5UbQazcT1qp12p9nfYpRUMHvr1b99f6UBoKuesUNsh7aNXw6iUy1ffvZ+MX42o/cjSqzF7M8+Um4NQZJ9N7EPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=IwLBXrrb; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C32262C03E8;
	Wed, 16 Oct 2024 11:59:52 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1729033192;
	bh=zn1mz/1EORt+bpdlJq0OQONh/PaoueiogkKlddA61BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IwLBXrrbULeReN3FBrk9298MxwbPJIUByD7c83joFFFfMiUGBzZDtwmtJYAmyXZyb
	 MYThRUqAkdzcqIm5mPKyjz8gc+Jqs9In/7pKBV0MByGYzEZHRVDX14GomTQdzCGQ1Y
	 k6xgb3dZ7jHEsxsfwls1bMJsZE/azExMGfAZOhVMqiK23RG37asG6RwKT3uhNIF/SU
	 9fGeKOCvVpV6FV7MUO/BBPIFMKoG2CWyzEHgmTVAqO/AkFX+UMeQAvGeFiTQdpw0lC
	 ZL8LujjwnsNFMO2RgLSZZvMTDeUId402cyNPdvmgPcelW0ME41UXuRLsB3RIoEEqwv
	 wsEhA78emkLlg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B670ef3e80002>; Wed, 16 Oct 2024 11:59:52 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 3ED4613EE9B;
	Wed, 16 Oct 2024 11:59:52 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 3B15628247E; Wed, 16 Oct 2024 11:59:52 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lee@kernel.org,
	sre@kernel.org,
	tsbogend@alpha.franken.de,
	markus.stockhausen@gmx.de
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v6 2/6] power: reset: syscon-reboot: Accept reg property
Date: Wed, 16 Oct 2024 11:59:44 +1300
Message-ID: <20241015225948.3971924-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015225948.3971924-1-chris.packham@alliedtelesis.co.nz>
References: <20241015225948.3971924-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=670ef3e8 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=KKAkSRfTAAAA:8 a=GF1LeCK7rlvhbTvQy6cA:9 a=3ZKOabzyN94A:10 a=cvBusfyB2V15izCimMoJ:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

For historical reasons syscon-reboot has used an 'offset' property. As a
child on a MMIO bus having a 'reg' property is more appropriate. Accept
'reg' as an alternative to 'offset'.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Notes:
    Changes in v6:
    - Add r-by from Krzysztof
    Changes in v5:
    - New, making the driver accept the updated binding

 drivers/power/reset/syscon-reboot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/sy=
scon-reboot.c
index 4d622c19bc48..d623d77e657e 100644
--- a/drivers/power/reset/syscon-reboot.c
+++ b/drivers/power/reset/syscon-reboot.c
@@ -61,7 +61,8 @@ static int syscon_reboot_probe(struct platform_device *=
pdev)
 		priority =3D 192;
=20
 	if (of_property_read_u32(pdev->dev.of_node, "offset", &ctx->offset))
-		return -EINVAL;
+		if (of_property_read_u32(pdev->dev.of_node, "reg", &ctx->offset))
+			return -EINVAL;
=20
 	value_err =3D of_property_read_u32(pdev->dev.of_node, "value", &ctx->va=
lue);
 	mask_err =3D of_property_read_u32(pdev->dev.of_node, "mask", &ctx->mask=
);
--=20
2.47.0



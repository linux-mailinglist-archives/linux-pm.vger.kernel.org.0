Return-Path: <linux-pm+bounces-19242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F9C9F21FE
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 04:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49DDD1662C4
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 03:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA1E3FE4;
	Sun, 15 Dec 2024 03:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="JKNJGjmk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20732819
	for <linux-pm@vger.kernel.org>; Sun, 15 Dec 2024 03:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734231728; cv=none; b=JFlnpQ4+e3Ak7aDFxbcK4Pz9bVtRPIX7m5++bxTcUlghYg/+SiVd1SsZAQoIdC6iiZAz1dZSoZtuvppW4eCrv8knjpLwxROORu8rvlJoFKuhkm531dWtReB81OFX6+EVXWn/zgrjk/PO4LMVkxWjzkXogXEMm+SzoVQHtHnVezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734231728; c=relaxed/simple;
	bh=x8xuQpmI911N6/z8+wan7mk7Rc19wrL8583yNP/A/50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y/iBg78dRGzvFq1IIkRsxJCMikQ+AF4Cdu4X2MK4QB3JwulO4WWBBuzEN1POYoPisfL8AN4KZk68S81JIYkBJ2YkDmlbn4zvPuB3K2K2zXKC+UuMJGFHYaXxJ+eTxTp0tu74y5M8bpIlKGU/DYFUFA6CCPUDzrWYXhPn5CSiJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=JKNJGjmk; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725e71a11f7so3033113b3a.1
        for <linux-pm@vger.kernel.org>; Sat, 14 Dec 2024 19:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734231725; x=1734836525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vl7lKPW1qE5L4XaM5bRx0bz9XE8xwXi+QHXi5N/vNEU=;
        b=JKNJGjmkqxMJsMp3jfYN9d08ZsxQDBV579nCeiePMMBIelgcX2MdkJbP0IArqaUdYV
         2nvo1Dg43xPqkGPpU7TA6O6JAJlnaDuxuXfu9SEBrhddHVpxjGpPZBoptBYnorhBnCTV
         TpD45eb5DApuB0emO/eNvrBIq92P1E2p/QI+gRiwWMPGnIujt8V+LWaYhfQuLiZeJwQg
         X/FdGdrdiSDmd//oP8+IVnb5eNHExTBPuzeXk3NGtk9uZrFefne3+3N827dYsY+8MMf5
         36GneZW6J6ecppl4Ogrkv6+wJlMhRVQ+TAsRHPooguEyNcDT5CaEef5Tvr5A6r28rMcv
         4FLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734231725; x=1734836525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vl7lKPW1qE5L4XaM5bRx0bz9XE8xwXi+QHXi5N/vNEU=;
        b=vKdcbfXuu0rsTtP4TDG31ksIs1cc0xtyHAF/qmTqTUMiAxMEmei6jrlfL1q5XB013b
         QDkvLt7Rbc+lTFTZ00qDVn8PL0Bjx+ikZPaGHFx3TlxICYoA20p80Czer1bSkxtd64S7
         Is5CRPrwGrhRahy47bLbBqr+d/yCldLS2VRTYH6y0EDzAeV79JueJYThsurYmc7rLksv
         WXdmrIUUKTO3EhxX3yQoYYSWqumU2i/HNNymd3t5yCmZNyC3ed6P7uTBWS4qojZOFJs1
         PE+tbwHWDGY2esa7HIBukhHYe9FSMliCVJjdEgwtBdsYneoeOa6zYiK5veH5mOQcv7a5
         gmzA==
X-Gm-Message-State: AOJu0Yx3rOha/7yI4gYFhk3VkrsS6/CHa1y85H4H9ZEDvtPcK/CqNLPD
	qwIjBmGTs/6R7PTCsD4cRoRnCj11PQTBylFJC7JtfdmCOVmttcR07r56m0IO8Sw=
X-Gm-Gg: ASbGncsZgdlMjVSvR98Bg19f7e+TEyCu5mJnivoHtre5gsjv6DazKNbpSGGSyUuT1Sg
	+Gn/PKcvHRizzEh5EpKpTmvpReKZb1rxQ3GQjDZmDlO4cbLBIimjDNBq6p5+Ki+z82h12Vx95Ss
	wUZWyktPeNBWWfRhFfDrIeP/nN11NKs3yvF5dgz+hZeRyGGWOllZdgc7REkH8PDAKF2hapLUnh3
	c51qfJZInaz04bPwRVDgXjhoMdeO0UL6HwxMjzDqfNLcrarBn8XgDaY+pfPhWIr8OoFKRvFqqux
	wfZL3Zb4gnNCft+aWEQ3B8hujsQT9XP6Gvp/bmR38hk=
X-Google-Smtp-Source: AGHT+IGb/DKHpfkJ4fHb4QuacSVV0/b29LHCFdo57+48jHc5w93Wjd9d+chSex+I5e5ZbfiRV2RdEQ==
X-Received: by 2002:a05:6a20:6a1a:b0:1d8:c74d:1ca0 with SMTP id adf61e73a8af0-1e1dabef51cmr12815267637.11.1734231725272;
        Sat, 14 Dec 2024 19:02:05 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5aaf3e6sm1872841a12.23.2024.12.14.19.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 19:02:04 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: ulf.hansson@linaro.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pm@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] pmdomain: imx: gpcv2: fix an OF node reference leak in imx_gpcv2_probe()
Date: Sun, 15 Dec 2024 12:01:59 +0900
Message-Id: <20241215030159.1526624-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx_gpcv2_probe() leaks an OF node reference obtained by
of_get_child_by_name(). Fix it by declaring the device node with the
__free(device_node) cleanup construct.

This bug was found by an experimental static analysis tool that I am
developing.

Fixes: 03aa12629fc4 ("soc: imx: Add GPCv2 power gating driver")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/pmdomain/imx/gpcv2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index e67ecf99ef84..9bdb80fd7210 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -1458,12 +1458,12 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 		.max_register   = SZ_4K,
 	};
 	struct device *dev = &pdev->dev;
-	struct device_node *pgc_np;
+	struct device_node *pgc_np __free(device_node) =
+		of_get_child_by_name(dev->of_node, "pgc");
 	struct regmap *regmap;
 	void __iomem *base;
 	int ret;
 
-	pgc_np = of_get_child_by_name(dev->of_node, "pgc");
 	if (!pgc_np) {
 		dev_err(dev, "No power domains specified in DT\n");
 		return -EINVAL;
-- 
2.34.1



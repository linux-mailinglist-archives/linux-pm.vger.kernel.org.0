Return-Path: <linux-pm+bounces-18729-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A619E7E25
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 05:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A665018858D6
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 04:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE7D1A28C;
	Sat,  7 Dec 2024 04:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3zPHHx5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F01A48;
	Sat,  7 Dec 2024 04:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733544224; cv=none; b=jLT59/n/f/pPv5yTEWFOgV4oshuTjnW95Njt8CigeNpmPmaG1UBL2ZsP5uAqdn7fCY2mPbuuVir1HC42ct30xa/BSFPjW78cMl+HZuBbS08rVKJ6Geg8EbqAeR/B596quAJLjD7ULKUKtrB9N9JnFGoKKLJM8/yIy/5H+qUr32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733544224; c=relaxed/simple;
	bh=4RlvqMTU9HOz51t+4LuZNogBP/7G9XL+0b7859+52rE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WCga5sIr1OOCfdmOKy1W8gluQLC2Na0z7IUjW+6q10HjepcV78Mj5txvhVd4XOgyVFkvdrapeGgHpvPvBCJteqRKKZeRpWjsoy6OWY20oEYkRcODwzzK3xztgFqiHrOHQCoP6flVWBXWAO5oRWpT9o0ZNEGpzwaL45+CJdtHEbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3zPHHx5; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d8a3e99e32so23236116d6.2;
        Fri, 06 Dec 2024 20:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733544222; x=1734149022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=02lDdtpT/lKjI8tL6uwlMK+INEuKJZDy985KEGjX8WU=;
        b=b3zPHHx56hmwYpNq9pgILz8k+G/7yTUWB1ri+H85R+IiR7OpD/q18qZEZO+fEW0U7o
         j69VUbE4AvBiIz2w1CpT7uWbekaff2ASbkle1HF6x95CsRMgSB2p/HDVCJfgXB6Szw17
         /CK42mb88AU84tMdZQ1Q5R539gesQaFcQnNhN7iBqaceapdjmrYpxKb74CprRkf19Wy2
         JoZV1nlVtVJqVSoRK8WFIfMnSg7VywnIzgZk3EZiNYM9/ZLrFwlx3H2zRaewWEV7T3MM
         +p39i5/th/cXgXTcpAdGh9BEQbRdhyxhAhiD9Z8CLP6IsrNfaEprtlSmuIqmAbDo8yiI
         2RFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733544222; x=1734149022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02lDdtpT/lKjI8tL6uwlMK+INEuKJZDy985KEGjX8WU=;
        b=EBCb8TO4O6ml+ucvVo4MZzWuu6LGlwJ5JF6b9CVT/8wBSYlZtO/VCV9v6hqQJYw6Jt
         ZA5Qima7HYwa4tEEUTHaK8os0/ckkStoDv1mvu1vwZtPoofdma3wQ4Qp6qoiuU6+fGWx
         vae7ODp+K5o2+55p2uyjchWVKwwZTbq4SxeJ39lVpCoX9PBG4+uvje3CfslIIAYVnQ7s
         VNWK6I/W7gP4OlwsJiD7b5iurOBLiKtumEO+HAJe5O53v1bToJ5jKzXEEEuyW+50g2uU
         y6/SmIlVouKNKMA10M/sXdCirLvxhZE3QuGeCRSG87o8mzBVwDLnwQ4r3pQUdceyaOHZ
         Oy5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHSC7AjT+IjOZgvds9AI8ySFCmiFSz4TlhdjroCvazXI2/4RW7y45OX8U+CrPSxndzDoA7jq0u3THG9Q==@vger.kernel.org, AJvYcCVs/3ocK/8cqr1p4JEwa65RJTxQ43piRVqwGe8flDjEJIRcFPKs6FumLwz8miZDuzQiWq/0/4vBN555k9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG3ZDzKzcOKCzAzdcE2oT+S4F+o7CLn/rs3JWx0IrsAHcGigAI
	k8335z3fQZJt5ZRWkafQqRZV8TWOMrZaat3MzBVAcl0fbIaBPUNQ
X-Gm-Gg: ASbGncsJ/GLJt7HdTwcFQ2N7567G0oHaHbVK/m+z9+C2uup/XIVPEnn3GkKg9gp0DTt
	Sc50UFwxxs4Nprz/LzIyhJjeDSsaZXQIY6l7d6dD1xTIyLpehzDHR9mTz6tBBtt/vaCWSGigPpN
	khzu15yQQmUbRRBhprA5pWpwlQ2+mWRehIRC+GJx+ZWH0TiJe1RSdIe9kGVmMi2K8B+NVF7TiX2
	8P1U6hGIVr9ISkSL0FnVoiB8CyYsJ5wfDoyycTRKvn+103+FkGFAgPvF1FReg==
X-Google-Smtp-Source: AGHT+IHFEkPerHwP6yCxf3ANfLes1TowE4jo7/D+KJYqa58QiNfj2wWA5MuV3T84faKmInh/rlO2KQ==
X-Received: by 2002:a05:6214:b6a:b0:6d8:aa52:74a3 with SMTP id 6a1803df08f44-6d8e71ad674mr83014906d6.28.1733544222419;
        Fri, 06 Dec 2024 20:03:42 -0800 (PST)
Received: from localhost.localdomain ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8ff0231c0sm168556d6.65.2024.12.06.20.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 20:03:42 -0800 (PST)
From: Mingwei Zheng <zmw12306@gmail.com>
To: edubezval@gmail.com,
	j-keerthy@ti.com,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	aford173@gmail.com
Cc: linux-pm@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingwei Zheng <zmw12306@gmail.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] thermal: ti-soc-thermal: Add check for clk_enable()
Date: Fri,  6 Dec 2024 23:07:02 -0500
Message-Id: <20241207040702.4075128-1-zmw12306@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for the return value of clk_enable() to catch the potential
error.

Fixes: 5093402e5b44 ("thermal: ti-soc-thermal: Enable addition power management")
Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index ba43399d0b38..da3e5dec8709 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1189,6 +1189,7 @@ static int bandgap_omap_cpu_notifier(struct notifier_block *nb,
 				  unsigned long cmd, void *v)
 {
 	struct ti_bandgap *bgp;
+	int ret;
 
 	bgp = container_of(nb, struct ti_bandgap, nb);
 
@@ -1206,8 +1207,11 @@ static int bandgap_omap_cpu_notifier(struct notifier_block *nb,
 	case CPU_CLUSTER_PM_EXIT:
 		if (bgp->is_suspended)
 			break;
-		if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
-			clk_enable(bgp->fclock);
+		if (TI_BANDGAP_HAS(bgp, CLK_CTRL)) {
+			ret = clk_enable(bgp->fclock);
+			if (ret)
+				return NOTIFY_BAD;
+		}
 		ti_bandgap_power(bgp, true);
 		ti_bandgap_restore_ctxt(bgp);
 		break;
-- 
2.34.1



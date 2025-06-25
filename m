Return-Path: <linux-pm+bounces-29528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48BDAE8B84
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 19:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F2D17AEA8
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E3326B76F;
	Wed, 25 Jun 2025 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7+QRJ7T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407EC1DE4F6;
	Wed, 25 Jun 2025 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750872769; cv=none; b=mLqmU5hD7/nxo1jHYWTvh1b0QiCVIDYIfEuc3DHBV0iHf5VJJO4PEh05rx/Af+ZJMW5ccbzeAmYyWuzyeZ2tOz8wR5Bw2vPX4axG5ywsqxN3MIhjLXosupr9VbGoxQtROnp+F4nrQSDKHlliudX0+W0EXuNAWRO/c4/Gfp7sCEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750872769; c=relaxed/simple;
	bh=EISUxnpIWHu4hrckTW+MYmq12v/BtlCMrfnj+rWuQMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RHakQ9fkz0DYuOgihOGbPyWLS+A98se9l/uFbztVRIuwbMgbpgh9E+rFUxFHiaTDDzowcB9PuByXgRo1mTgA042xgkXnDGLSVNSRHqai3JL6B4x0ke962SAqx58qYCqjNoYo7a/gCeoL08M3z3aBHQGgjwF8ByAq1sKnV9cFs9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7+QRJ7T; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a53359dea5so71189f8f.0;
        Wed, 25 Jun 2025 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750872766; x=1751477566; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iT4DMHtGBn9NgzcOhabgnsoKG/OUrJjaTKc+3/rEiC0=;
        b=Y7+QRJ7T5ymp1h2K7Rkts8bxYJp+GEar5bd3gV1imABUKN6KkShfaJSwW6RvoPqzqA
         2/r4lwJq90JbOQW9qtX4utXH/W9JNeDf8pKPyn2zid1DJlcj7WuoY6w+otGxKJtsuWdw
         OAncj1gVl+lEHGG3AGHuCk8p1M4uydphrhGxhiHd4BJ9IlauLkR4HzgR1iLmk7Sgnazr
         UApGP1M/DsN2Ipq3Up5dARFr9AXJ+CRpB3HnojMG33pLG3nemV2nBO5K8LMtxLjVnft+
         oZqkYAtHitPbJmQ4sNekiX9cQwaDTCcfJWFSvY9SgVYNFAN+WV5j57odUsvNA+fY9HLy
         qQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750872766; x=1751477566;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iT4DMHtGBn9NgzcOhabgnsoKG/OUrJjaTKc+3/rEiC0=;
        b=aB2YERAg4zCHSqyFiUyADkZ+xvY3SCQXJ53EUds3lj/Z3lQtxbkIQkub+RIEvFu2B6
         EOy7EHPznbTMbBbVBmfZzzOb2urHKNxmuj+3CATrE761xKS2sjhNpGLXWDa/ALXpyKxV
         y9L5wY6UaBZD6Ee7RPGPpF9W1Wyxkmx8XKjfRnqTLCFbI83Gv+Mx+RLy0tGjDG9Ut7Wv
         E/wT8GQpo3R716EnLy4rXR+KCvZ/f//i6LNyQmUFb5tRlPSdD0on9/LUWrZJQ6dJZkZl
         bWnSjADq252rD3IAfZ2NZw+9kIock3txn6ugI6Ie3tOWut8R0aJHqgFpbjhznvt6sx+y
         WKEg==
X-Forwarded-Encrypted: i=1; AJvYcCUXsnme/TgfkT/3+QSZ8hT3B1eVBTuqSqnFe/XoXnSo+3rUHheBJSbUA0WfbTP/LhFWXM1EKpRTNbiSv2hg@vger.kernel.org, AJvYcCWwQoxwo4gAm2AOdDUaSBcqHTtKdhmfvH24DQjLK39WKlZjnwi6H7PBZEa3wAPoR7pS+FJPgBwZnR/ZYXZ7@vger.kernel.org
X-Gm-Message-State: AOJu0YzM+mCDMSxpMrnXUtVwRlnuwWo4mDQjye4LMNxXRimJBgVAk9ID
	J7WoTNf5bqT9BU+wQv9mcAvawpFLCIYZH7iFf6D/B7DBicfj2y6j0FdY4SrgLQ==
X-Gm-Gg: ASbGncvl8wAfPOrxs4q5vty9q7sXvrRQfeEtx6l29GITcMoGlCdL9fm34bmCKMVOY0m
	vr8x9l4x/bcwYxG/MDB8L02mxpwIZIQjBA1maVv4i3pLpeJEVkSQYtGvf+Jp5a2EbgkdwfioCtx
	Sz83/RQp83yrDwpgbYcG5QkJ84oaPUbwNUDClR4pfXlyLmL92eFlVHXPIgzT894CvZdtDPqR4Od
	qL7afDDkr4Pf09Y85bJuaFm+z9tdPO6TcfSu2hrT4kjNRcANKj93Qaux9o8Oyjpwr0bgYmYCSua
	akwAbU2IOV/Ba2a/2R6c8mh804EXBcFbV9CkU/x3Cq4DSAq5p0ci/mggt5lGMvGbuEyJeYprdz6
	A/Jy90E4Z2ZSeXPI=
X-Google-Smtp-Source: AGHT+IE24H8yzbVgSbARWWCY6LBY8tm8b+sjyEHvnDZu7tS1kpGs3b2aEUL9oSco2tXuriUgneZxGQ==
X-Received: by 2002:a05:6000:4105:b0:3a4:edf5:b952 with SMTP id ffacd0b85a97d-3a6ed66a540mr2932759f8f.36.1750872766354;
        Wed, 25 Jun 2025 10:32:46 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a6e8069d78sm5107251f8f.45.2025.06.25.10.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 10:32:45 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Wed, 25 Jun 2025 19:32:35 +0200
Subject: [PATCH] interconnect: icc-clk: destroy nodes in case of memory
 allocation failures
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-icc-clk-memleak-fix-v1-1-4151484cd24f@gmail.com>
X-B4-Tracking: v=1; b=H4sIALIyXGgC/x2MQQqAIBAAvxJ7bkEtjfpKdCjbaikrFCIQ/550n
 IGZCIE8U4CuiODp4cDXmUGWBdhtPFdCnjODEkoLozSytWiPHR25g8YdF36xro2atNRV2wjI5e0
 p6//aDyl95MEwkGUAAAA=
X-Change-ID: 20250625-icc-clk-memleak-fix-4462b5153970
To: Georgi Djakov <djakov@kernel.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

When memory allocation fails during creating the name of the nodes in
icc_clk_register(), the code continues on the error path and it calls
icc_nodes_remove() to destroy the already created nodes. However that
function only destroys the nodes which were already added to the provider
and the newly created nodes are never destroyed in case of error.

In order to avoid a memory leaks, change the code to destroy the newly
created nodes explicitly in case of memory allocation failures.

Fixes: 44c5aa73ccd1 ("interconnect: icc-clk: check return values of devm_kasprintf()")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/interconnect/icc-clk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
index 88f311c110207757f0609e5cec7d377a91133c6d..93c030608d3e0aad7d9c1ed81a51dcde0d3f85ab 100644
--- a/drivers/interconnect/icc-clk.c
+++ b/drivers/interconnect/icc-clk.c
@@ -117,6 +117,7 @@ struct icc_provider *icc_clk_register(struct device *dev,
 
 		node->name = devm_kasprintf(dev, GFP_KERNEL, "%s_master", data[i].name);
 		if (!node->name) {
+			icc_node_destroy(node->id);
 			ret = -ENOMEM;
 			goto err;
 		}
@@ -135,6 +136,7 @@ struct icc_provider *icc_clk_register(struct device *dev,
 
 		node->name = devm_kasprintf(dev, GFP_KERNEL, "%s_slave", data[i].name);
 		if (!node->name) {
+			icc_node_destroy(node->id);
 			ret = -ENOMEM;
 			goto err;
 		}

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250625-icc-clk-memleak-fix-4462b5153970

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>



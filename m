Return-Path: <linux-pm+bounces-27039-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441ACAB31A7
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 10:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C331E177E31
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 08:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154D1847B;
	Mon, 12 May 2025 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d5LM0G3O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98733257436
	for <linux-pm@vger.kernel.org>; Mon, 12 May 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747038591; cv=none; b=WCbdxp48guPJgYfqK2Nq//UDltabRpYFfIntp/YTZQ8FbBmkxUsub9C7//oaRLnLOXhZOwFAOProeNdjiKFDkGNPVXL1Hqyges5RlRA4a2RJAX93DODFU1TIC1JlCIuJNZG9M2PqU7jfasjqLs3W9OgYw76YPZWly8SdiT0GEAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747038591; c=relaxed/simple;
	bh=nsQ1fQPsHSZmJleoO7Mt48MPFFf+ROc5x7XavMNRl9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hyw7MkfMAKtRB4ek1YLnLfSM8SWd/1SyPsV9itjl8cbsLMgwF6vADfwW/jT4lVD2CrnaRQFBBqwuzACbObGtqS8Wz5ifZDiBej+af3ZQiS5zhh4U7HUjdskwy6F38xmu5W5/Zk2RURQtok2hARgsWHFKoUStRNe0+Zgvo5wzsaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d5LM0G3O; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a0b9625662so3348018f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 12 May 2025 01:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747038585; x=1747643385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKf9j4izYTToqxyJBnoPFJwtfX8Vyf7TI0IyG8+OfBo=;
        b=d5LM0G3Ouh8VnQzUwS5gVmwihAGbM9Ck+5YG56xgRZpNP5AzzMyEyokhW4AeGBgPGH
         YvlW1AFLrjZw0QYwe2bi8FsFtYbfZR6x02dzKOBhbIQIuBu9appThCXj9dNfSn5iyvPS
         3xVF2upYP93ZZ1ADNYHvNFErdLKP9HJuYVqiTCfu/Mk45TlCPqKaEg6DHV5vnCu/iwkJ
         bW8NzD8YyhPDkU9wGkA+zqk/NndrZcsDcmMnvXKmuUVMWljwONSJB6CyOH5K1i3y4oWW
         nlChYZGwW6Hvm39uvvMGldM3lUiIa3Fgbu049XdTg7az6Kh2j4DFJLUW4Cr6iHoFv96t
         GvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747038585; x=1747643385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKf9j4izYTToqxyJBnoPFJwtfX8Vyf7TI0IyG8+OfBo=;
        b=orN/TrpjldKxnjzVtk38PpIT33SHwrBHbHD+y2M/yzgii/hXQnpkWqnzDCP0B4NkhJ
         FwhuZno8DLDys4EF1NgK7liLs6CgoMUKXLmO+PKbYx93WYuB7EP+gQfgrHLfv4u4Bs0l
         jXG42hFWtrW2nGd3K4Rz4LCF21b1w9bgsfj8MtRjG3b6tdGBjI6svYx0A3nPYhYPzV4F
         v9CZTPE4LvLC/Ad/odSVutL7obkTa4ztIalZxSyT93gyCD2hcGw82waWvdqlr4FKLZS+
         3ztIgMdeuHXWfb4JqP7z2m6aHof3P0DQQQoePfwJ4mmFIeUpoShKpblHzEjNNnc7eK4L
         2ODg==
X-Gm-Message-State: AOJu0YwBhnK0xfXk+DPl7snX6Uz1dS1Peu/0omnKdc+a1RLxehiXlm59
	oH+vqd9Xhkx1cAaVIPz1yQmgmUCZ/Hi188df2ezsJTP+NzkXUZV6xgOqWpmLxzA=
X-Gm-Gg: ASbGncsIOiiKTazHaLmb+O98hxUrPiMY1++MVWhPWN7l7JJiXYmPaxiDb2mBqX1VD6/
	WCiSfxcZbnzvR5+kmSqt45NnZcGXhHhdMg1NuTvRAVawzbP++d5Ev37cM64imHd/0A2crnp+KSS
	WcKjuNIDKyNf9tFTNZgYZ+ADfve0CCZ3W17iZFdJ/QXuUgub7nG+xY41KSlYzc+15wzaeN5RhF3
	6KXNU7SGS0Z8qfC9wW0yc4NYpvBQMxN74/pVtpoIOjCe4MJBZgKqaRK2tAMjeMQQBaRdUzCvxCu
	3djDEl6CRi9PVsfeBTmeHZXLyCtq1qkOys7w7VedBqIqbHRg14lhtOzpD6s1Xe8wzcJdqe1mDPb
	i5R6ioOrEwvNJZbm2ug==
X-Google-Smtp-Source: AGHT+IGjXf4Unrsm51GneUC4EPZLhzeiZxLlsfKl0xT/3O5OvpeiW/E4y6GXvGgQgbxcg2NnnSkTSw==
X-Received: by 2002:a05:6000:2dc4:b0:3a0:7b07:157 with SMTP id ffacd0b85a97d-3a1f643a5b4mr9645069f8f.9.1747038584869;
        Mon, 12 May 2025 01:29:44 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a1f5a4c78fsm11763007f8f.97.2025.05.12.01.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 01:29:44 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] PM / devfreq: sun8i-a33-mbus: Fix misconversion to devm_clk_rate_exclusive_get()
Date: Mon, 12 May 2025 10:29:37 +0200
Message-ID: <20250512082938.97110-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=nsQ1fQPsHSZmJleoO7Mt48MPFFf+ROc5x7XavMNRl9c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoIbFyhHzB+aUSUSLbeEfCi7zZNiGMzqylXq1y6 BZtbx09WSaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaCGxcgAKCRCPgPtYfRL+ TjvxCACXb0Ra2nxVT2aRbH4y33njLOk77dLGEOKSuZuC6RvYPXBRJaYPERDFCcN8ThbkctuNlcB 8MzqXk64dU729rhg9d3XRtlK8VVh979WSWXCBdoOQDvYkql6JPq+kvKedRHNWQdqBQ5l+9ZTWGO rqLBa/EzAjtJmrqVKUyiwRgZXCeQapTIvA3sBZh9pDq9WPZKdohivdRkiJ9572ecLjtOAKpnunI feKUi0eYyknRJf/pSh7PMO5sablBeN0xTRGlHaFJwIK2Gb6PpyCjuGQTxIfzcx294uLUdyAopWr NinBeJr4sSRu6NxXB7DatG/3cZGftmm94Nn5KjdyGAIQw12T
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The patch converting the driver to make more use of devm functions got
one conversion wrong making the driver not compilable any more. I have
no excuse, mea culpa!

Fix this by adding the needed device parameter.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202412070231.MzXdNrLv-lkp@intel.com
Fixes: bc253b28a365 ("PM / devfreq: sun8i-a33-mbus: Simplify by using more devm functions")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/devfreq/sun8i-a33-mbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33-mbus.c
index f99af530211d..4bd5657558d6 100644
--- a/drivers/devfreq/sun8i-a33-mbus.c
+++ b/drivers/devfreq/sun8i-a33-mbus.c
@@ -381,7 +381,7 @@ static int sun8i_a33_mbus_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "failed to lock dram clock rate\n");
 
 	/* Lock the MBUS clock rate to keep MBUS_TMR_PERIOD in sync. */
-	ret = devm_clk_rate_exclusive_get(priv->clk_mbus);
+	ret = devm_clk_rate_exclusive_get(dev, priv->clk_mbus);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to lock mbus clock rate\n");
 
-- 
2.47.2



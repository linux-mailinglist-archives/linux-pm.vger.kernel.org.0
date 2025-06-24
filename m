Return-Path: <linux-pm+bounces-29442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C12D8AE6910
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 16:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3B319243A8
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 14:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586C92D878D;
	Tue, 24 Jun 2025 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Q3JQBv8A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE192D8766
	for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775559; cv=none; b=X5ujAVex5YsqS6D2gBeB2CYliOmivSddIgJkB+Y8WIXvfwrQ/kfdMbKMJZhBNIdHVLlhdX9MrWa7WJqKc86JnUsSTlFt6j7SySGr02DzO0Ks9B+VmJity2+0QvxCFMDFCeOeVEqlfdcMQSpwcxugjOhx1V+mROYwdeGlDRqZpzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775559; c=relaxed/simple;
	bh=iLYKM5JKB26am82HXGWbhN5RKHqdXM5CcMWlQP2QiyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fhtDIeA48nIlcRpVPYXjxaKk8qu+BafNvI6Gove2vnvgEgPchsOdoITXWuJCZHdBsqvbgvQSO0cH64/vJ6wGSUgpxCp45MOMeI7JCIoONjJUQRMHGd6Kf55tnr3aeFlVuTLxvwVwnEsoQxvuyKMKGi1ceO72IN1HS+/1rfSVbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Q3JQBv8A; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-453608ed113so48019305e9.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 07:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750775553; x=1751380353; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9CNIW5cNjKjCoab6AIakbGKNTJu3VYBmTvjInHO0Kug=;
        b=Q3JQBv8AbiHZ2nKJ/U8E83dqgOWOuiQ67ojQcO2JcQ4Aod//xFjiNmXqHibKLENrLe
         Px7TIIUTifkjREXkSoE0sf4B2EnkFa/70NwS1pcPHYugINOcvWcaysXKNf6uag+FFzfI
         mgcev4nAV8gy00+F/iGS16xszo2McrK3zQLUZc5V5zkbk8WC4VH8DL0A3ye+8+x3KgQy
         i1GWcavpjE7ApGgV2wSV5KlVZNFZpdbIukq+DYHqr49bw2AZIR+L3+FWOEybQn5LtEY4
         aeepJPqnwdlELRuKl5n1Yr5XwmqwvHY4EQg0w67AWhPbXVEQ6InslPsBA4CDbjarp2X9
         xwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750775553; x=1751380353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CNIW5cNjKjCoab6AIakbGKNTJu3VYBmTvjInHO0Kug=;
        b=ccvPzwPdZdM+ngSLlHhpqvhDIpkAc34ladpxl0HPJtUFVtMalJgROrSgjVuDcI4ZwA
         YcTqxHvhee4xnlqByg06OZs5wmncuP8AZstv5dlNV+X/3r3SRBPa2ETSbULKcRJnVqio
         8kcFCxLhX0CE2NkiKb5Lsufw+OVoJTxhU7ytDd3hIeneHt4hi8u+9O+Pt1NIjmbcBz2t
         VJ2rNp1YNSQchV7NfKHahfLUjeMAGzQYaPbMWaOXSaDjv+epVvhCzjugTicOpqC9zoTF
         WbQq6bkyv8yP/6oHCfgoF41H6ExhD6+UEDxPF+YbGhkcKhSbxupHHSKw14+P48w/JKaU
         S8LQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8i6q3tyiwHdu9VKGFTRde9eHGt5Um/khRuFXY65C/2g/vD14FLMIpxoRukT7IYm0Tbld7i4AsHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ4xHXi5z0K5dRcFoJEZDjHvKXm0omxAHMg4YIoRUyfeynCC3I
	L/vHKEsLRr8E0aTS56VmZPPo2n48IPbXyq4PG14Kdg8r/ltcnAmZmwdKKIAUshA8EJF0BQ7X5h8
	6cLmfni4=
X-Gm-Gg: ASbGnctjKrupoEfvkMzPBU2qjIRWyUMIk8xAuerSExDFpDrXIWN+Xc+uhaq3M75tiIZ
	/G5m5F2gJcKLlWj7eP1xlLpK/7G6JgeRbIUOQiRKXEeshSKmYTNZB43O/AoO1m+4+S4FAAsmQ8Q
	+OA4Rqa5MdyS6w8g2rJvmg6wtOc7SJge/cC+y2Fg54AGcALI7Vtor/MNoXzN694UB/AUJ+3cJ8g
	GVA5a0j27I383pkhvsDccC3p6W+JqTGXGOV2LYtd8WEcrc9XyaZxXU3AQYOjZO+D4eUYG8gzMuY
	SC0ha2uDmnlZtMeluAxqFeb33RlqJfCPFKoHlljZN4n+PGdjT80qqO9f
X-Google-Smtp-Source: AGHT+IGpuQeND4OkNgfppr4DzG+xyz0jUMqc4qLMdr3DGhKhUgWRg/xb9I4Kd3VA/X3bAzgBxw7ciQ==
X-Received: by 2002:a05:600c:8594:b0:453:9b3:5b67 with SMTP id 5b1f17b1804b1-453659f8324mr83368095e9.24.1750775553416;
        Tue, 24 Jun 2025 07:32:33 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:34d2:109c:3293:19e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ead2a84sm178512935e9.32.2025.06.24.07.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:32:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 24 Jun 2025 16:32:22 +0200
Subject: [PATCH 5/5] pwrseq: thead-gpu: use new defines for match() return
 values
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-pwrseq-match-defines-v1-5-a59d90a951f1@linaro.org>
References: <20250624-pwrseq-match-defines-v1-0-a59d90a951f1@linaro.org>
In-Reply-To: <20250624-pwrseq-match-defines-v1-0-a59d90a951f1@linaro.org>
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1879;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=yIgDwVNP75QjxnnqZUB0eGQftgqLdSGUdNGqQ1mRb+U=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoWrb6qvHHx1tWdZ36+EKv6o8uu1Y32EArBy66E
 w7IaTlvyISJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaFq2+gAKCRARpy6gFHHX
 csZVD/9fv5ytgmoZV9N33yr8RMxpPBdNHbhkZf5RLOhy3kaBXhDurMDLG8dJ5gKQFjqAlE3EfXF
 eJv5toKg4IJYqISkg5O5CnP2z5+DYZLrVhsvD50ZTLF/SxmuoJr+Nm761WUIotQm/fyaVlG5L16
 YpuTxlQx32/iAfiz5p2zcoR3as535Y4h0/uPtpvx96MA+K4G/8iv3m416K1ucMaFiGKXFhLLdxG
 pAtEFKVWU4znKw8FzQfdwGV5D4Vpx0GpBGSz1VIT1hkhnLjgUgjXMOUmeWuvJtPm+lGH7zp5f/F
 83VVNmuppn2vC1clDinjXBZxHEyX6X2nZ/tDgXXJr3UI0QeOrJH8cq3Yz9sgkFlHKd/Vw8/N9nA
 G1QqG+Prg1iL8tX0ntGheLYp52P4yVg2LCc+G7T5btmiuvWE9gsU/hU/4eW7ogsbrWHCDwJ1dYj
 i6mxMhkOLxVjNB8GnhbYq3D/kNwAcJHyaUIebLmPmjgf2iaioEnWBTJajwEr0CsJCq851pDlCPg
 7uQrZiFWMv3OVzsX653lXcONTHxlEZM/yTNo+UcguuyUI66JQY3pRu5H4NHxUwXRtnu01VcND7q
 uZnFMJVi4uupkyRhrVT7h6v7UGwdJhtA0BsQXRbI+gveepJ+I2hjVNjbzRo+SBDsDh6O61455YC
 +QHJk5DawusRH0g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Replace the magic numbers with proper defines we now have in the header.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/pwrseq-thead-gpu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-thead-gpu.c b/drivers/power/sequencing/pwrseq-thead-gpu.c
index 855c6cc4f3b5bd1aa6e93305af0417d5791b092d..7c82a10ca9f6917e673711c55dd5e58e58dc8f5c 100644
--- a/drivers/power/sequencing/pwrseq-thead-gpu.c
+++ b/drivers/power/sequencing/pwrseq-thead-gpu.c
@@ -124,24 +124,25 @@ static int pwrseq_thead_gpu_match(struct pwrseq_device *pwrseq,
 
 	/* We only match the specific T-HEAD TH1520 GPU compatible */
 	if (!of_device_is_compatible(dev->of_node, "thead,th1520-gpu"))
-		return 0;
+		return PWRSEQ_NO_MATCH;
 
 	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
 					 "#power-domain-cells", 0, &pwr_spec);
 	if (ret)
-		return 0;
+		return PWRSEQ_NO_MATCH;
 
 	/* Additionally verify consumer device has AON as power-domain */
 	if (pwr_spec.np != ctx->aon_node || pwr_spec.args[0] != TH1520_GPU_PD) {
 		of_node_put(pwr_spec.np);
-		return 0;
+		return PWRSEQ_NO_MATCH;
 	}
 
 	of_node_put(pwr_spec.np);
 
 	/* If a consumer is already bound, only allow a re-match from it */
 	if (ctx->consumer_node)
-		return ctx->consumer_node == dev->of_node ? 1 : 0;
+		return ctx->consumer_node == dev->of_node ?
+				PWRSEQ_MATCH_OK : PWRSEQ_NO_MATCH;
 
 	ctx->num_clks = ARRAY_SIZE(clk_names);
 	ctx->clks = kcalloc(ctx->num_clks, sizeof(*ctx->clks), GFP_KERNEL);
@@ -163,7 +164,7 @@ static int pwrseq_thead_gpu_match(struct pwrseq_device *pwrseq,
 
 	ctx->consumer_node = of_node_get(dev->of_node);
 
-	return 1;
+	return PWRSEQ_MATCH_OK;
 
 err_put_clks:
 	clk_bulk_put(ctx->num_clks, ctx->clks);

-- 
2.48.1



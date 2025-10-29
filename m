Return-Path: <linux-pm+bounces-37033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFD7C1AEB7
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 14:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722E1189BC04
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 13:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AD225A328;
	Wed, 29 Oct 2025 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THiaqa9J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AAF22B5AD
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744818; cv=none; b=Ak7cH/7Yurx/LrCHpEU8Qo7IgpUY1xggLSQq8aHUz0w0b0u3lfpZ2msM4YB1VFq76MYnmwxAvxMLv7XUqNiKzxVPhXH7FZY2aYeGCc/P1W8jOV8IqUzN3wXFLuhv8f1gtv9o7d/xrKzeq8AHECs+kL80wIgA+CKh0gLWTgoA7EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744818; c=relaxed/simple;
	bh=Y8ZLQ/SYOzXImyS22Ym7aiIdnHdMzavchNbXR3fIpBs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgXt/rVV21UeMbSANeqdcdVZdggfIV/3ZGykGJkMeK4elq7MFGMQqNOuBcg2lF56uYaM9xh94WVteOO8T22NVwCGRH5S6g1N2yxRGRVAJytX3AWeHrn/XcKywXH71vYzx/eG6+iDT5Bc/R9z4Y8bwTYKhXRxk8s3US17benfqME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THiaqa9J; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475d9de970eso39459505e9.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 06:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761744815; x=1762349615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4H4p7cAGznM+u0vakSfKHlmdigUWGLnzD2FSausLfI=;
        b=THiaqa9JVIb7gHrsYfX/YS+y4WVAi3Cd8dNd985JoCbtHCldDzuPTo1UrDQNxJ6wy/
         OSBp/e28WY9s6ucsKpnoV4ZMzCwTGWXANQ/KafXU/JErVv6L65yGmlmeTUHyisWr4soi
         iXJq7Bz52TQ6H+jmBDpI1ZDhe22zRTKb89ImOgws6BGhimbTWlJoIo6eb8nOEiLGv80M
         umGtbj1W9iHtZ5MPn4Lgs80wqmGizqwq+I+ZiHaOf8h+ItQyYuyX0nSLbOAPXmnPJBA0
         TNQhsWsc5pgrUWBLB1YX6CfLD/iPY7tip/igGV2egvbR7C/ZNP9omuFdjZDErSWAc3lU
         2m9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761744815; x=1762349615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4H4p7cAGznM+u0vakSfKHlmdigUWGLnzD2FSausLfI=;
        b=OKzWuwW478DHlSr7ZGHoIRNL08EJfckGDWJGv9HEncDGFDQY2eEXpHR8rUgWhhyZw2
         YTEuGCEZK1fvUVN5ITrncxpBHKj+hAHbs3oQ5vcFrIMOeTGnLtbBqjt9CSXYNqHwIGeT
         2kp/r3Hjh8X/w3jh6M6TfD7CnGtKCU/rWmLDjrLNqEHEFoTBC0H7rZa6rToCK+HprmqD
         qBCWKsnSbeYYo3NC0WnCefWXtHxYw2pUWuIyziOcI9G1MUJ9AtBuUL/JmtuLRA1Bwb8u
         VQ8AKTr6XcQY+KSh5oNveaxE+1+1EI1ifJ0HHiXQBbkegV7pBi8i7ss2zeWya4dtyjw4
         Sn3g==
X-Forwarded-Encrypted: i=1; AJvYcCXvp1CiThdJte3tX98r3slkqiHLVMufkJFmybvdYljwTdFVMVl8kHsJ0rNyfNwcY0AzgnNGLofCHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCA29N/tmxBDPZhy9Jm/nXtVIIbyNFn9JbNddY7/cy4PwbtWjw
	dQbHdtzxrVMUA2n9ei4VYdEGmZsxOW4cI0r57ey/RGBe2HhuKD7JFzM8
X-Gm-Gg: ASbGnct3rYFY8KGJNrzOs1c6hRJvpfb1XMzX5WHRmBZJC5BTfsIWXBiPipM8KZN9rfC
	KawBCYVi8SsqWNf+IdBWu8ZcBuW7tH/xReDRSwxws+XMRi8lIK4yR02/ONV/CQOvmWFswUe/ABt
	eCsdd1+PER5btDu+UtpuGrOvRN3wokRWaY/3aCrx1Rl9S+Q9wSxAFeh3oAJaozZktXz/GMs8r9Q
	mGtUnhOaVUVz0jdiPn7CRLpk1mfhA1krWIN5tyDiupRq0851yeL9Jt0web8dTfUvZkQt+UaJDjA
	crYAij31hCbuY8WDG42++HjuGtBc8COw9H+YMiNZj2DID4BDXRSeMKOiOqMjTPMBVEjXM02W2KJ
	TENcGT0I6JZ8PZz8em/0rmRoqFm4RSvzRPPmvb1QcovMnC6baYDv/K0+jqEYlPvI/VhpFU9PyMt
	zZciEInzzpU5J8GRx4r12acqXsuhsenQ==
X-Google-Smtp-Source: AGHT+IGKTaGAZFOPryBpj8t36omqPXrDXVW3wtFaTSngpELE8eCJOJgMukJnq0llCfEkdriy+fkMCQ==
X-Received: by 2002:a05:600c:46ca:b0:475:da13:2566 with SMTP id 5b1f17b1804b1-4771e20b2famr26010825e9.35.1761744814695;
        Wed, 29 Oct 2025 06:33:34 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4771e387a14sm47955195e9.3.2025.10.29.06.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:33:33 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] soc: qcom: smem: better track SMEM uninitialized state
Date: Wed, 29 Oct 2025 14:33:20 +0100
Message-ID: <20251029133323.24565-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029133323.24565-1-ansuelsmth@gmail.com>
References: <20251029133323.24565-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is currently a problem where, in the specific case of SMEM not
initialized by SBL, any SMEM API wrongly returns PROBE_DEFER
communicating wrong info to any user of this API.

A better way to handle this would be to track the SMEM state and return
a different kind of error than PROBE_DEFER.

Rework the __smem handle to always init it to the error pointer
-EPROBE_DEFER following what is already done by the SMEM API.
If we detect that the SBL didn't initialized SMEM, set the __smem handle
to the error pointer -ENODEV.
Also rework the SMEM API to handle the __smem handle to be an error
pointer and return it appropriately.

This way user of the API can react and return a proper error or use
fallback way for the failing API.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/soc/qcom/smem.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 592819701809..d6136369262a 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -353,8 +353,12 @@ static void *cached_entry_to_item(struct smem_private_entry *e)
 	return p - le32_to_cpu(e->size);
 }
 
-/* Pointer to the one and only smem handle */
-static struct qcom_smem *__smem;
+/*
+ * Pointer to the one and only smem handle.
+ * Init to -EPROBE_DEFER to signal SMEM still has to be probed.
+ * Can be set to -ENODEV if SMEM is not initialized by SBL.
+ */
+static struct qcom_smem *__smem = ERR_PTR_CONST(-EPROBE_DEFER);
 
 /* Timeout (ms) for the trylock of remote spinlocks */
 #define HWSPINLOCK_TIMEOUT	1000
@@ -508,8 +512,8 @@ int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
 	unsigned long flags;
 	int ret;
 
-	if (!__smem)
-		return -EPROBE_DEFER;
+	if (IS_ERR(__smem))
+		return PTR_ERR(__smem);
 
 	if (item < SMEM_ITEM_LAST_FIXED) {
 		dev_err(__smem->dev,
@@ -685,10 +689,10 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
 void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
 {
 	struct smem_partition *part;
-	void *ptr = ERR_PTR(-EPROBE_DEFER);
+	void *ptr;
 
-	if (!__smem)
-		return ptr;
+	if (IS_ERR(__smem))
+		return __smem;
 
 	if (WARN_ON(item >= __smem->item_count))
 		return ERR_PTR(-EINVAL);
@@ -723,8 +727,8 @@ int qcom_smem_get_free_space(unsigned host)
 	struct smem_header *header;
 	unsigned ret;
 
-	if (!__smem)
-		return -EPROBE_DEFER;
+	if (IS_ERR(__smem))
+		return PTR_ERR(__smem);
 
 	if (host < SMEM_HOST_COUNT && __smem->partitions[host].virt_base) {
 		part = &__smem->partitions[host];
@@ -1182,6 +1186,7 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	if (le32_to_cpu(header->initialized) != 1 ||
 	    le32_to_cpu(header->reserved)) {
 		dev_err(&pdev->dev, "SMEM is not initialized by SBL\n");
+		__smem = ERR_PTR(-ENODEV);
 		return -EINVAL;
 	}
 
-- 
2.51.0



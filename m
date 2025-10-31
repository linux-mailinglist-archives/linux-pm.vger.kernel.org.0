Return-Path: <linux-pm+bounces-37185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D28CC252FB
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3EB50351743
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 13:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B92034B43A;
	Fri, 31 Oct 2025 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH+yK8mH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB3F34B187
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916130; cv=none; b=Kr3IeAdVtItVmormCyk/+wpg17Yx/l79exaoy0V6MBUtzOBu5N+F/V/tygZSqbD3oJTiyf4ED3AJp48ySJfSL/H/gVcrRMWUSBBq7TFXyNltr0VjiEhXkITvyEMfWPWDnRSUTuIh7luiUhDveNCV5yP6Acv6ZdFzD7aVF1V5ljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916130; c=relaxed/simple;
	bh=ZQib5/2OIcg170vq6islUB2C6zYKAesFa9FfnPagCaw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzYq1C27ShvTSzwVWKNvUGnXtsLJsFqZ5qtIxEIGKrD1v846wKcm4dJ7v7WPRm3PM/rAE3Baev/8ColiEQOBwMGXZcPoDWKANNInT5SvypHFd+bePSbFHA7VwB4M5hq8Th37xKq3f445s19X/+Xern6U9Dg8JSM3Xv1CG5gcQ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH+yK8mH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso14227005e9.0
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 06:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761916127; x=1762520927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccJbH/4yvf5LooWJONtpx85HNAeF1FVpVodVplgG0co=;
        b=lH+yK8mHDeN8Lnxa2SRF2CPPMQ72Hr5Z2zIskJzy+lRC9sDwE5FvV5pnsPl/SZyKUN
         GNYIYuuzn7PD/CCufD/inl61u8MCBKsljTxSqjdxKYfszVEG2xldQIdz3xAkWgfsz6MZ
         K+P/lSk0d6nstDzeO/88iS2rBMvMaQD+XJLf2WwnNd+r97wGuRUgE7dAwe6OhSogKPUR
         QFVYnxrOGTn9gWJwLm8BG6FWQzAKHaz5hfFAJFKdQqaSk4xk3IrrRn7YfF+YagH/TD1J
         0n4FsbHQpmHaGac+mkRRnCSqx1dYLETpY2gwIchTMq+qzUAGznLBC0f/aAWm7fStjEQ5
         QJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761916127; x=1762520927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccJbH/4yvf5LooWJONtpx85HNAeF1FVpVodVplgG0co=;
        b=N3q80CrEEMwGXKwfOfPU7T9e3kzqcXMnTfyHIGgggglwY76/WPQcM5ZqNZtqCTOWp2
         4gFJGYrhiTeFAxHnEa8EDU/9TR1IyEUQCvPB/Ast1sX8z0Q+gV6ibc7ddTJBoXHd7fMZ
         zmONghwI3HGzkLXRfAjtDrqA3q+t6sZ4nZOaan6/+T6rKHzRB7rG0glvI1qvsszmMe7G
         KO3ERmkuFtB57ATdLsZOzS5O4dlKncjOBuBFhodMG/OkSdzdW0hp1CYg8C9El4hwnPUR
         OoTrh10SyXie2W88pI9ze+QQ2jn+VFgqYU1ifEvKg7bZjHblNpXYU1XHTHhvlovtdY5g
         4CNw==
X-Forwarded-Encrypted: i=1; AJvYcCWlP69iIw/OvTPhKdThBV1vIu5qFmiQuBN+tudMyJJmaaLCZdTM2/eBfGdlpB186t8Z+7PtcQHZwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwViXKbS5xZSdlY6Q5IYhra6/DHUKO0SCogMJMs2/8hpdIo83E6
	lyhilRBR2TfvDS7+oeplGCBaiwdMuFlQeoLIXnOsJMfWisOCX4lt4BFwpoevQw==
X-Gm-Gg: ASbGncsb0AbUEfdjDn/1UxRBXL0jrnhTiAFMnyjkbmtOUtIBlW1y0MZBXoJ8E8ALMDD
	mVBjhMV8DhrWtoWAxHOu9zS9YF4F0iQX824rB3yVgMNXbGbZ09s34Lol/+gqfhsYsVxVY6FRsgC
	9QYwCz0wZtkCBaYhapGaccpkiE80v8PBOrEZafDtV6YoRzP4penm93dZw3AN5zvWLgEsJJXA1kj
	U6/hY3NHSRqqwZ9CUO284dJ/JE2slY4443EnN/qdfAlarR1+tVxbVxxbTgLfi1KhPqB9FvWenvZ
	DXYh/iXRxXym+3FGiiH1ZzHdYnvxIaIk4T9K2SS6atISsZt/SUhZGYeNFsSlcxzXVGPv5Jxp6VZ
	DxvHvRxMNh8cGl+9qRXb27DU24BPRk6BBObc86xIQIECjEJ8oJ6q697PaECPqB1vk+e317DW6EV
	ALYkrqbhiokP80DR1eQzeF3jgv74/4lkMuTo8KsS0M
X-Google-Smtp-Source: AGHT+IEpqCi0U/FCAxr0qt6blcRF9KKyqDlQ3rl1LSf7EM78bkfX9BWRYm6r2uYHW58AaeO2vgpvHA==
X-Received: by 2002:a05:600c:848d:b0:471:12c2:201f with SMTP id 5b1f17b1804b1-477308b5986mr32940345e9.32.1761916126441;
        Fri, 31 Oct 2025 06:08:46 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-477289adc18sm98339815e9.6.2025.10.31.06.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:08:46 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Raag Jadav <raag.jadav@intel.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] soc: qcom: smem: better track SMEM uninitialized state
Date: Fri, 31 Oct 2025 14:08:33 +0100
Message-ID: <20251031130835.7953-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031130835.7953-1-ansuelsmth@gmail.com>
References: <20251031130835.7953-1-ansuelsmth@gmail.com>
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

While at it, change the return error when SMEM is not initialized by SBL
also to -ENODEV to make it consistent with the __smem handle and use
dev_err_probe() helper to return the message.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/soc/qcom/smem.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 592819701809..5b7626528284 100644
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
+static struct qcom_smem *__smem = INIT_ERR_PTR(-EPROBE_DEFER);
 
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
@@ -1181,8 +1185,8 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	header = smem->regions[0].virt_base;
 	if (le32_to_cpu(header->initialized) != 1 ||
 	    le32_to_cpu(header->reserved)) {
-		dev_err(&pdev->dev, "SMEM is not initialized by SBL\n");
-		return -EINVAL;
+		__smem = ERR_PTR(-ENODEV);
+		return dev_err_probe(&pdev->dev, PTR_ERR(__smem), "SMEM is not initialized by SBL\n");
 	}
 
 	hwlock_id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
-- 
2.51.0



Return-Path: <linux-pm+bounces-20920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD17A1B21D
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 09:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9722516D9C2
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 08:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED8721ADAB;
	Fri, 24 Jan 2025 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QUvWnzG2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B141D21A45A
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709123; cv=none; b=Hv694M0yyt3r9U8OggLdl9MucQdIfc4YpQtx4XRIqZ7mml1EhtrrLWC/Dhog2BV5cMp7aNJwX4LdPN4vzPs/FpE3ehK2suJTEwt33JVvsuwW7zImyx4N0WZi2Fw0JFmejjkInb+JlrBTfQhDA/bKJYNNtZcF6JQ7y9vnAVZ93cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709123; c=relaxed/simple;
	bh=znSW+w1v4+BqQtTVGnLiRgqkgsqi1gEv9fB8ofPO/uU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hxfSEUAoO5SbSORpSYrcTEwuWT0bfVGy5WWbaDElTh7e5V47Ga3EEOHWhRexT8ZnTTAw9jzWXJYBPHScMSi7ci1Ay71cz+p5FLYX9ZR7v6hwQJkus5+VQL06BXs8X/ScrVW6gbCWt48CHeoZTAVZFGSBR3WxsZ/xvuVmiAaVu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QUvWnzG2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21c2f1b610dso40079455ad.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 00:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737709121; x=1738313921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvdbY4/AKo15uXXJkPA6XTvZrqE667hU3K6CfKEA8Zo=;
        b=QUvWnzG2uRk7llsHOmyqcxSpgNSLVNjh9lV6T3MJgOzcc5z512u/JtKBunB2lZL0av
         h15w8m736r2Bd6RAPw8IfF2Y482Z+bv87+21D/T5zk4Ef21DnizuThdOhM9qJaMLJH6i
         k8MMJUuDgcj7xn/GWmSdMIYrJtyYwRLDx7dNCeFPaXBxZZEXDPJ4jotGZLRjlZdUmWTl
         X8mTyqUB7wgMPeXnqVTWQcMJbuvbRrQlUvk/j/EWWllpQvvqJKf4FYOb4wyxqXVl4P91
         NgnPVda/bxTFRBix06jWp3o7qDtdc1SXBvW4+NgtDZeccOID3hiA8t+LanmDqueUJppJ
         ZtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709121; x=1738313921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvdbY4/AKo15uXXJkPA6XTvZrqE667hU3K6CfKEA8Zo=;
        b=ghfYTfK48AzqAGSFRNQ57EHx8++8oE6eecOXp8DFygr9ZCfTlC3RJ32Tw88liRotJv
         3jxq96V32BT+jIuNySNLyqS6vTftEcfBgp6tV3capx8RiMICGFalKNOyrLf/tQuS2Fre
         /d2aAT2G+S8WeKg+vfqDzTDD51mNuI06BJR2COGfJRIiJJZ56tadNw+gvegI7whyAdGh
         KT0yHKprGJ07ku8TQBTNGVtW7R3se2cRQUTe7U6ym1N81pNxocZKPvcIfZVNXSY+Ui9q
         pSbps1UbRH5Q551/SJmXnqS0riXv7leCx5KFj+kCjzYgYUVaGcGZTUbHqN259nOV9JSX
         T22A==
X-Gm-Message-State: AOJu0YxlgrZS8dahX12NmJKy5NyKer+sAQEiBEM6gaNaO7wd5DZvIjL1
	sdtGWZeZNy1Ggl7fG4zxj+3Ltdt06wQi4MHA2RA/RRAsSy3Etw+oUo9ZgzXkOhQ=
X-Gm-Gg: ASbGnct3rhAR/HyDi4jUjwfVSmGc90WfJW4R9eTtY/HgCefCmvk3zjRMaEt4zlLBEv1
	d1/vyf/qsFkI27mVO+Vd6cwtLo8MXozmcwiPO78s5+w9ggDQ/uLoE+n3uRxPWy8SNm6pgoDtDCB
	dsbOzbbB1/C517LY2DlKvwhrK6Colw95f0jI9yUSU0kbNogL8hz+9mxNtH6UtryvflK1ISwA5Sp
	q+FMVaitKTaF/Xq6pmWGXt9WMPm1lc7MHn5YX/rath8CqKX7nPJt68lt4sV0W30fNFzZrydbu0D
	ym8rhDM=
X-Google-Smtp-Source: AGHT+IHuCYPoMveSKfSnW64isYzqBc1It/cW98VCzyz0WynpxJ9l951hdasMB8SxE5p49YNv5MjiQA==
X-Received: by 2002:a05:6a20:734e:b0:1e1:ac4f:d322 with SMTP id adf61e73a8af0-1eb214a0817mr46368460637.14.1737709121060;
        Fri, 24 Jan 2025 00:58:41 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a69fb24sm1322219b3a.8.2025.01.24.00.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 00:58:40 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] cpufreq: Introduce policy->boost_supported flag
Date: Fri, 24 Jan 2025 14:28:07 +0530
Message-Id: <97f0694fc5a3b408251ec5456b17bd8692938f02.1737707712.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737707712.git.viresh.kumar@linaro.org>
References: <cover.1737707712.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible to have a scenario where not all cpufreq policies support
boost frequencies. And letting sysfs (or other parts of the kernel)
enable boost feature for that policy isn't correct.

Add a new flag, boost_supported, which will be set to true by the
cpufreq core only if the freq table contains valid boost frequencies.

Some cpufreq drivers though don't have boost frequencies in the
freq-table, they can set this flag from their ->init() callbacks.

Once all the drivers are updated to set the flag correctly, we can check
it before enabling boost feature for a policy.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/freq_table.c | 4 ++++
 include/linux/cpufreq.h      | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 16e56f2fcee4..185070052b41 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -359,6 +359,10 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
 	if (ret)
 		return ret;
 
+	/* Driver's may have set this field already */
+	if (policy_has_boost_freq(policy))
+		policy->boost_supported = true;
+
 	return set_freq_table_sorted(policy);
 }
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c7d1fe5ebf7a..b017af4398b9 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -144,6 +144,9 @@ struct cpufreq_policy {
 	/* Per policy boost enabled flag. */
 	bool			boost_enabled;
 
+	/* Per policy boost supported flag. */
+	bool			boost_supported;
+
 	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
 	unsigned int cached_target_freq;
 	unsigned int cached_resolved_idx;
-- 
2.31.1.272.g89b43f80a514



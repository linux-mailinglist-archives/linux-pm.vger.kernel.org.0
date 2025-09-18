Return-Path: <linux-pm+bounces-34959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5448B84AE6
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 14:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ECB81C20533
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 12:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58F12FB622;
	Thu, 18 Sep 2025 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4qE3o8h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE4F191F72
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199973; cv=none; b=FvrwINESrFBFVsd1qfQ1ZYELJOHVD2pI13XpSwmHaPgQFx8pE4TdPDJzNJO6EX5X7QYAYjrZqcisVgm7R1YUQ73Nn4g9a2mB+9K8zbLxuShjqs2HBIq5DLzGiHgzzD1Ghy2CHWluQHsH5FAHz+m6w1sqvqFVNbWPwocvpHLFiNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199973; c=relaxed/simple;
	bh=l4jvn6aXx33cUflG4BWjr4dX1HYkZKhcsuT1j8BtDbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O+nqSxih7Pd6w7V0dfvghMtgsfUOgfCgotl/qGqZCsFTz7EBVda/cjuS1zjpbwZ8HjjTUrN4zrDOAH8B9PB36Ex8A1eaDJjmqeDMZ8kQgcQ/XTq9g+eapKbTo3BgcJ7x2DdYfB7G13KHn/rV4/zEgJYxrXmFDsV5AKzKT4QqnDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4qE3o8h; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77287fb79d3so940858b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758199971; x=1758804771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+soGoTKEKPCIsNMCnKS6u8d5Eq71cxzpukoczL5FpQ0=;
        b=G4qE3o8hpp+Hg1oJy9A26Jo+K9pYwhwA2tstfjpbU7LnO/U1fyIF7dkvWC31Hm4wiE
         9rhMAZXy8ReINFlkRIPb/EKRJU8TDXq1gh2lNNWgQCAKmAFGae1QG/yGFXA5mEbhpKR6
         DrypkorhvN9730KVp9RLvglXzmtC7pIdFdccE3HElReQ7ZivP+pufsdyvCY8DGDLSwXK
         QWKPPVDXNWDvCFp3uF3wyoe7/LqI79bamDw/b+HfTkX9F9DsQ87Nm9RF9ZzSgOznzCIM
         yE2NaIpli2XmcM33CThydG2I847J8PbKtXlt7XQujIgcdgxhrJwI19l3nuIsrPZ6rNqr
         btNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199971; x=1758804771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+soGoTKEKPCIsNMCnKS6u8d5Eq71cxzpukoczL5FpQ0=;
        b=O79Gs+FFIvSiLVNta+tFVY/gbuJ5d6/u65HvNFSaOPmrOvaVo5mD8UQKdcuLZ4FBXE
         J3npXfpkKaROwl4u6tZyIvb6X2kBfwt83rUX/+IMMRhD76/6XwtE1lyS2keiU5105gfm
         n4+7QuhoZztAdEDvucw4lnxR9/oLjBu7qDkIl1uxT/4QzjFMMwZNVEm8H0GlgatVQKVR
         02iFrmj9ABKtxwqW63Qbk+Wk7gzHQIQi3wU0PT9h+SbHmDOKalNQO9HR9XhGvySnpwG9
         LxQwlhdr5x1M6HnTXxH9VuwbrMOz+iu3I0O+e+jaHn+w42xrm+l78z+es0CDh9706U8a
         BL0g==
X-Gm-Message-State: AOJu0Yxu4ZLaSa+mAvdhIta2olPgmW9bwidpBL+xkZ4kYMeKWjM9atJB
	NJJ+P9pSXdO1+kv6AVjEvRu9C9QAq4TjYWh5DTddCH7VRevZAM8lmMu8nD07thyp
X-Gm-Gg: ASbGncvmM1WsOj76Toyv/+DL0g/Fb8EqoxYZdcUR9l+DzOqACZDkfRHvjrIscUyzSct
	pDMCHDr5xShCRVk4iJtzSSZyPZhivovsc0DDLWZznKNt4hXtQS7TWwCqNP/XVkag/MHuQ1fXvbj
	zh+LXp4eNQfKtbAHW2MPdNwBB+ERph53Z05cfh+UPesrlKJFXTH6nO6RTe7idZhUfwAJezPsTh7
	XlBNmYKGV2Pevw0vAESJqFku0tNhIB7Z5hkm7cwD2+erhq/DHB+YKcb7Eu3jBfZOCNzklAWcxFy
	bCQkwXj7cz1rDDQATmq1yl9RLPhROPlI6QImc8woLTy2CHneeKt/Nimvct8yNKNM9PVXniEfFeA
	ZkGzOB1uPNUTMAQiV/pcBf4wQT0Zi2w45wCIa21YZ0FTmEZr8j5FR2ySKNaGrPHgWe0eydbtp
X-Google-Smtp-Source: AGHT+IESQJcBetHwGqWeWnfiLA0N9lJ/u4rM5jArsuldA1nsqCJOm5/erhH2PKpvmc6TYrRuKdn0Nw==
X-Received: by 2002:a05:6a20:2591:b0:245:fdeb:d261 with SMTP id adf61e73a8af0-27aac4ce90amr9585400637.54.1758199971435;
        Thu, 18 Sep 2025 05:52:51 -0700 (PDT)
Received: from zojnhg-virtual-machine.. ([112.3.192.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cff22ba98sm2333201b3a.91.2025.09.18.05.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:52:51 -0700 (PDT)
From: Jinghao Zhou <zhoujinghao24b@gmail.com>
To: linux-pm@vger.kernel.org
Cc: rafael@kernel.org,
	viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org,
	zouyipeng@huawei.com,
	Jinghao Zhou <zhoujinghao24b@gmail.com>
Subject: [PATCH] cpufreq: ext: fix NULL deref in ext_gov_update()
Date: Thu, 18 Sep 2025 20:52:41 +0800
Message-Id: <20250918125241.80968-1-zhoujinghao24b@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927101342.3240263-1-zouyipeng@huawei.com>
References: <20240927101342.3240263-1-zouyipeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switching to the 'ext' governor can trigger a NULL pointer dereference
in ext_gov_update().

Two problems were present in this function:
  1) policy_dbs was derived via container_of(policy, ...), which is not
     a valid way to obtain CPUFreq dbs-governor per-policy state. Use
     policy->governor_data instead.
  2) When the BPF hook returns 0 for get_sampling_rate, the code fell
     back to gov->gdbs_data->sampling_rate, which may be NULL or stale
     depending on initialization/teardown ordering. The robust pattern
     is to fetch the per-policy sampling rate from policy_dbs->dbs_data.

This patch switches ext_gov_update() to the per-policy path
(policy->governor_data -> policy_dbs->dbs_data) and adds minimal NULL
checks. After this change, switching to the 'ext' governor no longer
panics in testing.

Observed on: Pixel 6 (oriole, arm64), Android kernel
  6.12.0-mainline-g0a53f54ba5c5 (Jun 11, 2025), after applying the
  cpufreq_ext RFC series. Also revalidated on a PC build.

Reproducer:
  for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
      echo ext > "$cpu"
  done

Link: https://lore.kernel.org/linux-pm/20240927101342.3240263-1-zouyipeng@huawei.com/
Signed-off-by: Jinghao Zhou <zhoujinghao24b@gmail.com>
---
 drivers/cpufreq/cpufreq_ext.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ext.c b/drivers/cpufreq/cpufreq_ext.c
index 310f13aca70a..c79068e86c27 100644
--- a/drivers/cpufreq/cpufreq_ext.c
+++ b/drivers/cpufreq/cpufreq_ext.c
@@ -409,11 +409,18 @@ static unsigned int ext_gov_update(struct cpufreq_policy *policy)
 {
 	struct ext_policy *ext;
 	struct policy_dbs_info *policy_dbs;
+	struct dbs_data *dbs_data;
 	unsigned int update_sampling_rate = 0;
-	struct dbs_governor *gov = dbs_governor_of(policy);
 
-	/* Only need to update current policy freq */
-	policy_dbs = container_of((void *)policy, struct policy_dbs_info, policy);
+	/* Get policy_dbs_info from policy's governor_data */
+	policy_dbs = policy->governor_data;
+	if (!policy_dbs)
+		return 0;
+
+	/* Get dbs_data directly from policy_dbs for better stability */
+	dbs_data = policy_dbs->dbs_data;
+	if (!dbs_data)
+		return 0;
 
 	ext = to_ext_policy(policy_dbs);
 
@@ -431,7 +438,7 @@ static unsigned int ext_gov_update(struct cpufreq_policy *policy)
 		update_sampling_rate = ext_ops_global.get_sampling_rate(policy);
 
 	/* If get_sampling_rate return 0, means we don't modify sampling_rate any more. */
-	return update_sampling_rate == 0 ? gov->gdbs_data->sampling_rate : update_sampling_rate;
+	return update_sampling_rate == 0 ? dbs_data->sampling_rate : update_sampling_rate;
 }
 
 static struct policy_dbs_info *ext_gov_alloc(void)
-- 
2.34.1



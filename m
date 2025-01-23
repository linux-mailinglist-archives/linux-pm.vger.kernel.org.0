Return-Path: <linux-pm+bounces-20859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 712CDA1A35F
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7937F160FBD
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360F92165F8;
	Thu, 23 Jan 2025 11:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHe2EOq4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADC12165EA
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632361; cv=none; b=SUD3G8CjV1EEed2Tdp9xsg9oTkLAQnmxa0dFL3bmAPKB15/8t/Le3/mo34hFWFbLakqzgxjdI+yofjmaZvGSb40KbQ46YCPlvc2XCwTT8+ak8OjNmuMDBrBqFB8i2s1r64FSz1I93rKMrKE/1oF3GpdWHtxtf3GtJZKbMgXPI+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632361; c=relaxed/simple;
	bh=UH1tpNt6VbcCT0ZrE3SxdKh5LKux9R4FiQ78W9CUXSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D61rx34jCB5hSgEdHn23O68Y9+6pc07pwpMikVUOObqhyyAj20eX8eRsY9rH7oufsic72B1zR+lAg0q24zaONfUfG7VEom79ck27NwsdNIYJ028qea2SD1fYI53hQErqz5I5SK2VzkYYy+4GJ045ZuZmeynvtyhE5fkV6Y3Wmfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yHe2EOq4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2165cb60719so12428525ad.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632359; x=1738237159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw5eLVV+9z3dLXaoxWtpMTsTyt1/ZfCdP5QemkFoNNA=;
        b=yHe2EOq41ZfmGr0psiX70WMim9yL0HQ9zITiUFhbMESWQdckAuYFlHiuhC2rVIWk0o
         oVHHcXhg6wuJNEJJGpxr3C41MjAHowyZ57JZVcUS+jJELGmCAdzfvEYp/elMNBC06cNF
         QvB9JZZ/Ygbk9GxsoG1Lq7qqexWn3QbHiSuoW9pJx+q0yc8+wAJkvdJduPi55Xx3dN9b
         MNLm+XqJDUkUpvG9a40klRYVAzN9FpnpLY0wSRNZAiqJkmkoazTUFvJBHVeNohRJZqXk
         gmGwxlEZOTQC8/ddNuqVwU++Ep8BsTlFiBMfTI8p2pVg/dvZf1y2sD8270BKYXxft27K
         YA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632359; x=1738237159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qw5eLVV+9z3dLXaoxWtpMTsTyt1/ZfCdP5QemkFoNNA=;
        b=byIHb+BCg5Z5Xd+YI7i9FE4ilX5nGuKth/kXh83wk/Fb+Cekfm/PUiDDXJ571NpEHu
         bMqUdA6Z34FsDKeUTp+yoU5LS5m9GDf8XdL6UclSAfUeNtTv5FnXc2zU6KeGr6YUkghd
         mS6jdo7sXNYhYrRmw3PlvJZjrD1f0ricaZSaTX3hCchGz29JLruiT3HEmL7W/87bJW0f
         YSxB00GOtbb6C13rvpvybCZayNciCbyFEjgrc4+klWyLr/MSh/gwxEzbL1gBFqc1VNsB
         Yz7vcGSVQM4IBNwYIv4ZFkYQT28IhKQSxEDfpLHFcy+87DU7WlMNrvYi/EDL52GyfpSw
         XGEQ==
X-Gm-Message-State: AOJu0Yy/QAGm16FkesX7IChrRu2WRCS8+6GDmdwyyYH+xL4KeGSD+k36
	zVX9WFFbMuF93J6lKQ6dhebC5H4x5IQ8HTDJ1YATGldXp6yjF/NBbeMryH1F6fg=
X-Gm-Gg: ASbGncsfnQsP6eRUWuught1Q7GDE4mRGlJexmm9YXJVLIO3jOf7VyswDVBQHT6Sj+Le
	yPBM6yYKplqkvTC0eSXr/fAUz4DRZOEFVcxZuBziIGbQDLzZ+ShNslklVFSCh2kxo4ObJJUwH1R
	Nk2joI3Gdd/4tnoSidsqHVp/NMizof5z5Y5BO4tl5XoiItFdHmvxaXsTty6EtFHvNyB5vX9iVkA
	xi5gXUAqtEgItNskKDVxcWPXN8H9GPD7efpnrouP8ybnx9xAlD8RNIipLacgPkzlcNXXwsxzYR5
	Sok4j3U=
X-Google-Smtp-Source: AGHT+IG35bHKpPtBqyWEN4vjNem7enzw9Cfzq+hJCua4U03cU32W+2jXl1Mmp4lHTbPlx0N5HnW7XQ==
X-Received: by 2002:a17:902:d2c9:b0:21a:8ce5:10e7 with SMTP id d9443c01a7336-21c35530380mr379841305ad.23.1737632359102;
        Thu, 23 Jan 2025 03:39:19 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bcaa3a4dbsm12429106a12.12.2025.01.23.03.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:39:18 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 23/33] cpufreq: sc520_freq: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:05:59 +0530
Message-Id: <2ead2cb17391d12fed69785f0eea4c56210a524d.1737631669.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737631669.git.viresh.kumar@linaro.org>
References: <cover.1737631669.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpufreq core handles this for basic attributes now, the driver can skip
setting them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sc520_freq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/sc520_freq.c b/drivers/cpufreq/sc520_freq.c
index 330c8d6cf93c..103d2519dff7 100644
--- a/drivers/cpufreq/sc520_freq.c
+++ b/drivers/cpufreq/sc520_freq.c
@@ -92,7 +92,6 @@ static struct cpufreq_driver sc520_freq_driver = {
 	.target_index = sc520_freq_target,
 	.init	= sc520_freq_cpu_init,
 	.name	= "sc520_freq",
-	.attr	= cpufreq_generic_attr,
 };
 
 static const struct x86_cpu_id sc520_ids[] = {
-- 
2.31.1.272.g89b43f80a514



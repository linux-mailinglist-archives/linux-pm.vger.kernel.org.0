Return-Path: <linux-pm+bounces-36562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF44BBF6193
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 13:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83208487930
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 11:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8791C32E73D;
	Tue, 21 Oct 2025 11:37:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00292F3607
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046678; cv=none; b=msBc3F+28Pc9/5IoqHe9RGPre4JTDOXgUx/cvn4IBJ0E0tX8xlNmxdjqh89xhhwNrDyhOSijShsqjNrJ7bkEriWM49jRCOGY+jq1YTBEvGYaay/ep3UDogujeqxkQ6El7YmzTltm4zdu5mb+UxztLQkfvfHTxorOx4Op7alQtIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046678; c=relaxed/simple;
	bh=LwlKlFHSEbNrVRvKsond5796RbxaXrrqKSRSObBmQZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HM/hVxheAajgN6oNOaZXKaMnpbu0O7LlYju8+90RT3RQBWdc7DOtfsGs3f6TIiOQze8+7g9VKQmQCg9Hx6tbn3hIVC5RXf6ns86T3qjJJ6H2Gs8gnFZpe1CffpkXwJ1h6c+WEA8LT85RiPf6ZPYYPo5xh4SUU6i/RopGE6QLkgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-269639879c3so51820705ad.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 04:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761046676; x=1761651476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zb/P39EN0zTHeWlEc7WRQeworU4Q/PPx2G1j0YfRkmU=;
        b=piXZaHzY3uPTMA4FHd+PlueGqy9I8Vw1VMluvTqB55COi06sX58JfvuyvsOeWLS4fN
         nEMYoFAJ7rOFCK5pxYEPkZuA0I8N2Q/uyMNYVaFyOs+SJ2wups4uWxJe+lU1Rgj/r6tx
         s30NEhQvd7UDwNKtG1xS7CTDWz4SPudEqIkuPjKJFAJ7r2oMWOZv+JIT7kONE5QH6OdQ
         JIdnpewVcvnM4bywKXzbZlQmgJ/shAwAz3SaJnqF/SQyDY8wzEgKraCPmmAZEokWvpZ/
         TozxC3IsE+Pwj69J9Ff4KWLrXmUC+9Bjus61xbCSuRzJ+BCpjAgJUebY7mZk6QsrohoL
         In5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0LMUDEz487bHSImfu6A+eplWwv5G4/SUiaKR6Uv9A2G7qyjplEEqRMnvv3fCzBVc5l9hQXWsbGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeK5FcoPn5Y9IBth6xL5+0bWirBMppcIWO8X+p//QGZBRpMInL
	ti0a3gbMJI97teTIDHdQREolEL2HGlnIOO7pMPDqE4zMNMjvyf7skhvB
X-Gm-Gg: ASbGnctz87YdDuV5B7+0a8rw8ltLVI9LZ/pE6m47lrDzO6ylSWchkrbQlhTv1a1ipPs
	VjFF4zOToykITZ9OOg69tFNxh87F1t+cfk/G7SwTMTBooqM6qOCFNqlYEdMj6qfyKhzXoTxyb4C
	sxQlBvpJZ3PGJO1WpjNDWKTjXif+KT2ejoQIrNBkvyR0rQbPR4cHZ1OGyOW2/mL+zKejGOvm3UV
	4uS6gWO1Gmt4Od75OakWzCssNrEbdJSqXZMyXyNMgJLpSpjjZLTHtwiaVZcllwVY4d9Jux3qJmx
	M4zXQ/rNK95v1X6WWkj/Hl5pAXQKAEUYsR8xmL8OIVgDSak8qouR3VCi3hyUSRNm3DoHRyGcquN
	vAuIVIAQu1vuO6kO6sRXrTic32LAr1g3q+pGyE9E24cK740G++vjcOTrLMvxNXNvL2+o2oFWGfX
	ZSUYCD4DXx3dr+GyKzy/w1b4hvS1iG3bVccQ==
X-Google-Smtp-Source: AGHT+IF6cl/LBwyaFNUn13dpXkGP8NioeG262Y8OPcKXHmKGNZPKgVCEeAVM6LjaxPs3Wd2eic9dVQ==
X-Received: by 2002:a17:903:287:b0:24b:4a9a:703a with SMTP id d9443c01a7336-290c9cbc0d7mr203876085ad.17.1761046676061;
        Tue, 21 Oct 2025 04:37:56 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5874sm107138825ad.54.2025.10.21.04.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 04:37:55 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v5 3/3] PM: hibernate: add sysfs interface for hibernate_compression_threads
Date: Tue, 21 Oct 2025 19:37:28 +0800
Message-ID: <c68c62f97fabf32507b8794ad8c16cd22ee656ac.1761046167.git.luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761046167.git.luoxueqin@kylinos.cn>
References: <cover.1761046167.git.luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sysfs attribute `/sys/power/hibernate_compression_threads` to
allow runtime configuration of the number of threads used for
compressing and decompressing hibernation images.

The new sysfs interface enables dynamic adjustment at runtime:

    # cat /sys/power/hibernate_compression_threads
    3
    # echo 4 > /sys/power/hibernate_compression_threads

This change provides greater flexibility for debugging and performance
tuning of hibernation without requiring a reboot.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 Documentation/ABI/testing/sysfs-power | 16 +++++++++++
 kernel/power/swap.c                   | 38 +++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index 4d8e1ad020f0..d38da077905a 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -454,3 +454,19 @@ Description:
 		disables it.  Reads from the file return the current value.
 		The default is "1" if the build-time "SUSPEND_SKIP_SYNC" config
 		flag is unset, or "0" otherwise.
+
+What:           /sys/power/hibernate_compression_threads
+Date:           October 2025
+Contact:        <luoxueqin@kylinos.cn>
+Description:
+                Controls the number of threads used for compression
+                and decompression of hibernation images.
+
+                The value can be adjusted at runtime to balance
+                performance and CPU utilization.
+
+                The change takes effect on the next hibernation or
+                resume operation.
+
+                Minimum value: 1
+                Default value: 3
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index aa11576e92a9..d173e276b494 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1689,8 +1689,46 @@ int swsusp_unmark(void)
 }
 #endif
 
+static ssize_t hibernate_compression_threads_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", hibernate_compression_threads);
+}
+
+static ssize_t hibernate_compression_threads_store(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t n)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	if (val < 1)
+		return -EINVAL;
+
+	hibernate_compression_threads = val;
+	return n;
+}
+power_attr(hibernate_compression_threads);
+
+static struct attribute *g[] = {
+	&hibernate_compression_threads_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group attr_group = {
+	.attrs = g,
+};
+
 static int __init swsusp_header_init(void)
 {
+	int error;
+
+	error = sysfs_create_group(power_kobj, &attr_group);
+	if (error)
+		return -ENOMEM;
+
 	swsusp_header = (struct swsusp_header*) __get_free_page(GFP_KERNEL);
 	if (!swsusp_header)
 		panic("Could not allocate memory for swsusp_header\n");
-- 
2.43.0



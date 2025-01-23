Return-Path: <linux-pm+bounces-20837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83224A1A31B
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B318188C6E7
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6769E20E703;
	Thu, 23 Jan 2025 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JVcqKHoT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEBC381AF
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632286; cv=none; b=Leb9RYTG2zXHgDqpjXKK0NqNh0BccnQJx309XtMKp5sqHV8GkXHDxOmzQrLercEn9BwQ+GKSuAFi7AFUV7vbnYVbLq5RMjnixemn8SvOCqhzf8mqUmuVO1XLUEBNmxkurp+yuTOW6eWkSk5CysYeFOoEYrSLk6KKf/X71DOxyUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632286; c=relaxed/simple;
	bh=MbK+HOv1UjD+nx0NPWZX+6e2GlX2Tr4E6xZ7vZCDKeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gaQdDTp/zQ6b5Hm2pRJ14Rwh0zIej4aY8duFzMK/2FTJVt8/WWU/MJDiDUKaEk4VcLaPl+jsoLSu1UeJpjp22yzMkJeh9RIH90yMNBL4YgLkLkwrLgz7JXtE8LpDQ7pKUmLJdO74tbqMzm4BgCljILwyYHZG/taXCHY/wgpyDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JVcqKHoT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ef6c56032eso1102918a91.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632284; x=1738237084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BURswXzavwBUBL8SbuuWIsmTTY6DE3SqcuzUjfY2Q8=;
        b=JVcqKHoT3RfMWBUOTCT0stlYLnEhDNayuahPk1b/zRzqtLueXlsp4UJI0kgLb81W+f
         DkZgmgLW57uhJGg3AoFK8uV2K8YTF+LoLMgssXF8DB2R6qGJMFQp6D+cNavP7cj3Mauq
         hZ569cDG8/yqEhunVlMXzrNj82mj6V4IBxOnzOzGHo5XfaG7WgA25SV3EOqh75a+HAWt
         hnHkQxxl3jbmz7DUU87Hhz59pf+iDAHUaAZoiVdyKdat/gQn1Z+DzDcZKfvQFgTZY6n8
         gGKvx4Vdxd3Ll5T7oIJhfZgCPP/f0sRKgM55q7xC0BjGWmxtc9FosA7Jce5neeq28A2H
         ii0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632284; x=1738237084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BURswXzavwBUBL8SbuuWIsmTTY6DE3SqcuzUjfY2Q8=;
        b=vJDAe+9ehHSgemJDimpJuJtBwP4dZIq/06JJ+RIbcoV4cVmHnxLa7476ds71+OR9IC
         1U0DyUAVB1irv6ieVwiGCKmwtA0yZ1cg89Dh1gSxclCrbZszdL+kA4c+5a8RBSg5kLOQ
         oKvBUhQfDRINXyHlU/7mHDj85XImWsI5jRIXpe4Ugq6eCwhVcoEB5zspuCGlU2JYnSni
         2T7MrwaqaWFb/1Mh8HYHINHJvJt+RE4L0GIFHwSMwZHqilUb4RYLnlcRvlNYQAKFDzBD
         Kxzt1UBzKk9HNImzdGREO5HU5F9n14R7/3sMd4aVUl8q/7fwWXgU5AGOfj7vwm1t+UYG
         ST0g==
X-Gm-Message-State: AOJu0YwxCPHQcnJ9RBHQuozjFNV1dk3hbKDoSTW1PZttcrYORk4GVjNJ
	zNWiny/yxaH9L12Ua3Rui8hjHRA0gUyJ1MwrZUJLi7oZfs3Gmwa0OGUthOw4Ytg=
X-Gm-Gg: ASbGncsvG9o4AMxXtNoL+zoH5MqnHGqIBLYCrDK0ULVIVsX/6lRcVWJ2xn+mhPRDNol
	wTjSIPJ1RKwUaledXWHfgNv+vUyJCA0+N7ws3z+BXUBkmxEJfBeIw5RusJoHYxR3MIpT/WoJIXw
	jseiD/36ExQ5o1xnO7CgKdu6FuuXtpjxUB7x02g/t6LT7+CrwtIDnUCVUK16Kvik36Ay7TlNZFi
	lonHET+mzrcN6t9i12XQT8G8HYQ34cjC9Rea7I6w/XNvGv59S6LMtl/1ff6LAuzJQp1gIQ8n9o+
	N0tEWlc=
X-Google-Smtp-Source: AGHT+IFgWLpTY7shOq2EOCNH+GW2Avz6xkQDFCiT2sjaDUy/K+cOgLyTwIWgYwmf3aC2gRP7McjPdA==
X-Received: by 2002:a05:6a00:21c8:b0:727:64c8:2c44 with SMTP id d2e1a72fcca58-72dafa68820mr38895508b3a.19.1737632284107;
        Thu, 23 Jan 2025 03:38:04 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabaa751asm12843539b3a.162.2025.01.23.03.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:38:03 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/33] cpufreq: Always create freq-table related sysfs file
Date: Thu, 23 Jan 2025 17:05:37 +0530
Message-Id: <22b68afa4ce5a0a2e77bb3a08e1cb7ac75f70f72.1737631669.git.viresh.kumar@linaro.org>
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

Currently it is left for the individual drivers to set the available and
boost frequencies related attributes in the cpufreq_driver->attr field.
Some drivers provide them, while others don't.

A quick search revealed that only the drivers that set the
policy->freq_table field, enable these attributes. Which makes sense as
well, since the show_available_freqs() helper works only if the
freq_table is present.

In order to simplify drivers, create the relevant sysfs files forcefully
from cpufreq core.

For now, skip adding them twice. This can be removed once all the
drivers are updated.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1a4cae54a01b..973bd6e4bdd4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1058,9 +1058,31 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy)
 	struct freq_attr **drv_attr;
 	int ret = 0;
 
+	/* Attributes that need freq_table */
+	if (policy->freq_table) {
+		ret = sysfs_create_file(&policy->kobj,
+				&cpufreq_freq_attr_scaling_available_freqs.attr);
+		if (ret)
+			return ret;
+
+		if (cpufreq_boost_supported()) {
+			ret = sysfs_create_file(&policy->kobj,
+				&cpufreq_freq_attr_scaling_boost_freqs.attr);
+			if (ret)
+				return ret;
+		}
+	}
+
 	/* set up files for this cpu device */
 	drv_attr = cpufreq_driver->attr;
 	while (drv_attr && *drv_attr) {
+		/* These are already added, skip them */
+		if (*drv_attr == &cpufreq_freq_attr_scaling_available_freqs ||
+		    *drv_attr == &cpufreq_freq_attr_scaling_boost_freqs) {
+			drv_attr++;
+			continue;
+		}
+
 		ret = sysfs_create_file(&policy->kobj, &((*drv_attr)->attr));
 		if (ret)
 			return ret;
-- 
2.31.1.272.g89b43f80a514



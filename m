Return-Path: <linux-pm+bounces-19079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED759EDD41
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 02:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8A7168215
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 01:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A9013541B;
	Thu, 12 Dec 2024 01:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VscK2q5O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F8C7FBAC;
	Thu, 12 Dec 2024 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733968661; cv=none; b=ayAjEcsbSh6Rpynvos59STA81JR2rJsYktr3K4geqIZGE2v58FQJYIOuekIHsw/a/tBfmNrfBAgfiXlcU46kL7+LzdE1yu6mc760VGC4KvUqdgigptONgaA5xi/g3qm3aREV/dHkIc1pNXB0vemoxTfLN7fLijFoUnK/vjHwdyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733968661; c=relaxed/simple;
	bh=Bz9SD0S4ih/0WGt3sKvD75BXOA7xvusCYRJ6XvQZeBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYlPmPAYohOp/dSUAwFbvgP0S0jHTg0ZqgBOMBFNO7EweI87bZJp6UoirNcpZIC2Ro+C5PTjozOvCORx6OImPwdND6QY3TOHoG3Jx4YUs7LSVrbKSepYEI2ENJYugOvm4Q/6/cdEV1WM9UAK7+AfiCYQoEnZFnT4tXLdnFSLDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VscK2q5O; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fd2ff40782so128795a12.2;
        Wed, 11 Dec 2024 17:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733968659; x=1734573459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIIEH4/iFa3/TdDh0MQgQz7IigAr1CH+cv3VD+qL854=;
        b=VscK2q5O3gKynQgxuHJwU5ftgwy9zi6Fjw1zBrA7a5Ngw3uDcZZczlDCreNvk4BsMV
         0VSbDLQpFUKqd4QvFGOEnvIm3JwWG61j0hjAF/EGYmts5uHX7Ci5VUECg4FyWXJNZXN/
         P2UkAAWel0fTA8BKaFfxTBnf0bHE4rGjwryIxsTZxWUdeAVqp8nxgNfLa3nVYD398Wrq
         RnANLtQN6W5F8R3ilTodDfa819UOYmeSPlDeP/zoEtkgbmDbx9ljYge39Z/7M0CffxdX
         WPyX0xWmr5UIJLhIy8+n0ud7Er1keCPCY3ZkAqtuCYhLYUlhQ/vCVBITfrAxtw/hp9DT
         w60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733968659; x=1734573459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UIIEH4/iFa3/TdDh0MQgQz7IigAr1CH+cv3VD+qL854=;
        b=MnOvFfvvFMjfuSFKAPzAE+EfvqTGLOWN29ZoMvJwyobNW34pn2wII7CQCH/pQPdWtb
         eDL4jH5qLSkHnee1A6nMiMlb8kWLbkwqCmP/IKERyrtnMcLEFDKAQ1QgsZ3AGzwr18fy
         ZEmFiDp+Qo+5jhdt/+s0H5S7M3QQGUUP1R7Zzw8o21JX36fyIUsUIpGuiTGl7+AGT3Tf
         LCShXRk95bhHSnRTbGPSkpPEtwPAxFWspN+FAbKqg42a37EETrMaqq2QFVBgs7MPq8KJ
         zUEvTejIjiR6aw7if1fZlPJ0+R4GEC8Bxoa8HUMNafFT3nqFyN8A7DokLOKXm6xssmuz
         MRuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyudaP5fqcWrKBWiVJ8sDWj+U+7TjYEvILHiV/ovg9adEj0s1XFo7Mkr8Lk+7v1g63CT0pM4wyceQ=@vger.kernel.org, AJvYcCXXo76xGX71JTLD03xPU6gSZ2SwyEEHtrfpkQ7CaXmoh3Hc+xcZZvJsf08YNT9XLnjy+lWQfqA2nU1xxa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLb+k+ty270Xi7yGqwN2TnVZNrcs2mrQ4Qc6nAJaPPMZNqqueC
	cgYSa7DC6YU9h6tFFt5wXCopU5HyUZISp2RB5mdbUjfx9He911o4
X-Gm-Gg: ASbGnctHHNJHiJwq3KXFHT7iZ9OtkPjNCwQDaMaRzZSqjqEMi4igHqrXxZWhU+7NOms
	ldws5n/rAur/QsJvEg7D9B87MNtUNV5xmg/SQ2+84FuqxwK0Y8q8vS6ZD3C7ShXZ3G7xW5dNj9N
	ID/gGezZ7U2WMqFqd2zvbOvbFB+abFXtFzZqc7K3une8mHUYTVikYitErGZr8B8HDKaxWlBC7Oy
	X/afZCGqys/kqHYnZfz9CH9YF9gJU6poQQ=
X-Google-Smtp-Source: AGHT+IE9I1p8dQJuK436AUBm2uffVmP97hAVngfmOadxV6DnkxeR2VumK0NurxR6A846OfPDvOn9Ag==
X-Received: by 2002:a05:6a21:32a5:b0:1e0:d867:c875 with SMTP id adf61e73a8af0-1e1cebdeb94mr2059856637.36.1733968659061;
        Wed, 11 Dec 2024 17:57:39 -0800 (PST)
Received: from sultan-box.lan ([142.147.89.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd41a128ebsm7086456a12.85.2024.12.11.17.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 17:57:38 -0800 (PST)
Sender: Sultan Alsawaf <sultan.kerneltoast@gmail.com>
From: Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf (unemployed)
To: 
Cc: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: schedutil: Fix superfluous updates caused by need_freq_update
Date: Wed, 11 Dec 2024 17:57:32 -0800
Message-ID: <20241212015734.41241-2-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212015734.41241-1-sultan@kerneltoast.com>
References: <20241212015734.41241-1-sultan@kerneltoast.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>

A redundant frequency update is only truly needed when there is a policy
limits change with a driver that specifies CPUFREQ_NEED_UPDATE_LIMITS.

In spite of that, drivers specifying CPUFREQ_NEED_UPDATE_LIMITS receive a
frequency update _all the time_, not just for a policy limits change,
because need_freq_update is never cleared.

Furthermore, ignore_dl_rate_limit()'s usage of need_freq_update also leads
to a redundant frequency update, regardless of whether or not the driver
specifies CPUFREQ_NEED_UPDATE_LIMITS, when the next chosen frequency is the
same as the current one.

Fix the superfluous updates by only honoring CPUFREQ_NEED_UPDATE_LIMITS
when there's a policy limits change, and clearing need_freq_update when a
requisite redundant update occurs.

This is neatly achieved by moving up the CPUFREQ_NEED_UPDATE_LIMITS test
and instead setting need_freq_update to false in sugov_update_next_freq().

Signed-off-by: Sultan Alsawaf (unemployed) <sultan@kerneltoast.com>
---
 kernel/sched/cpufreq_schedutil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 28c77904ea74..e51d5ce730be 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -83,7 +83,7 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 
 	if (unlikely(sg_policy->limits_changed)) {
 		sg_policy->limits_changed = false;
-		sg_policy->need_freq_update = true;
+		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
 		return true;
 	}
 
@@ -96,7 +96,7 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 				   unsigned int next_freq)
 {
 	if (sg_policy->need_freq_update)
-		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
+		sg_policy->need_freq_update = false;
 	else if (sg_policy->next_freq == next_freq)
 		return false;
 
-- 
2.47.1



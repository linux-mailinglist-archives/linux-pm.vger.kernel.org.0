Return-Path: <linux-pm+bounces-17581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A7D9C9502
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 23:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B06BEB24E44
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 22:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A42A1B0F1E;
	Thu, 14 Nov 2024 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKmQs4r2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0381B0F17
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622175; cv=none; b=usi4R8vFln4gFyy6ZsvTBJalcmtXWEFF+FUokDTuCGOlTS6b8OleyptwMIt9sCK5ifihEmm6ouWgCAfsYRzZQegJpKXzmEmTAD6VLeOhXhxBxStlBnjsKyyrJRXfp1jpdVL6f2GbWLrPSjfFR0lVmrNOU+k56znFQLGxhUHl1yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622175; c=relaxed/simple;
	bh=FXF39w61mNxxA37BRFFzg13pzMbcauk0JxD5udDvbNs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=sDBhuS2nZoGahDhL5MSGHSzsz8XMDx2bUcjhhPp4a9hoRhBSPTkuUUTFdhlq27kKJIxdY0E3K+zp00gysxjGIWUE2bOiSuXUdGuonJgtGaDMjM6gDjjnNh9tcmpBl4p/S3luDBgfNoPXtHz88Kf4J4ooTt3j1BwnxD9N07CXKaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uKmQs4r2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8901dff1so21939977b3.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 14:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731622172; x=1732226972; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ltTqN1vUYgDIEjeUsRotinFDZNC54N+YNek7x4otQhk=;
        b=uKmQs4r2sfC3N2Mm7T2NPt45wuhEGXkAJMkPw7WbYrUDhKq7XytcCvX+dG6PAm3ARv
         BUqfTU4MmipuMSBC4cGnYPJ3lUaoz/MQcrUeRGdogxjxPkZnoH1ywkUHPK8NjHxHLaKS
         hqURQBeQoCRKxMEEJ+edmHiMsuPMqrTuPyKLAloP1l2aEySylV6qBYlAeMXqrSM+DYAL
         8pBVh6acwfE2t+muBWyg+gwXSWeBm70ZksAY280ICgADkfwJfl4HVQ3PCeOb2o6UmgoI
         jcI0WmpsXMCs8Ka5vw50qV5ZKceb9h/j2GmBxm0SDIP+lENi4951lz9pazRNBHSxqs9d
         1s3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731622172; x=1732226972;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltTqN1vUYgDIEjeUsRotinFDZNC54N+YNek7x4otQhk=;
        b=QkpVFajJWhwPA1CUz8QtLzkvyXdu2YLMIrlJmdMLn2QVQoF5k6FP6XWsfUUKvTrCto
         ApAF+S+/NulRc6J/E8mRcLI/hcW1sX2rZJoQjY+Ish6ueRMt9ywQhP6pRQ777vrPHh8x
         oujNonai45P9lPMhsF0WT3lzpSd1lCJOHiVmF6Lb9ve6vlY8zzCpCE4zmNa9s0jE3gzv
         7B38IugBbYVBwI4tMlb6sn/XVXZh3++ogUeaIOrVAgF1D3wkr+s1XFA2xjwfMMChqNkh
         N9laS0Ohy3ibRSW5zu5tBzv2E9GC1AW1FzJBs9LWXgzH9aMwDpbnKcT2DbAJhOPBcmmX
         oZiw==
X-Forwarded-Encrypted: i=1; AJvYcCUOPvjLVPcur9PED571T7oZI8i8kx+fmEgCugdmoeIpfCuG9B76l4GxHqrs1PZ0HDJOX5bURAyHMg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Rq6Nk6QuKKiDYDxq3SwFydrN/Xfqxk7yjgkuOZEVpLAZbL1I
	COm6ho0+hJW8wQ2TbjgUan7oFYLZWDBKQDvwnWRIAdt+KBjNhqrmXF4+BZFjqicCranFP4Q4c+a
	N1L9JEvDrfUHLEw==
X-Google-Smtp-Source: AGHT+IGJ/4jVZ1/xg/LGCl3APYeAMNbxGDbBEvRotblohLu+ttsAW0UM3N5LDvfVv2yeayzGHKI14yjv6HYVEP4=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:3e23:8355:c37:686e])
 (user=saravanak job=sendgmr) by 2002:a05:690c:6806:b0:6ea:8dad:c3b1 with SMTP
 id 00721157ae682-6ee55c9b324mr496857b3.3.1731622172602; Thu, 14 Nov 2024
 14:09:32 -0800 (PST)
Date: Thu, 14 Nov 2024 14:09:15 -0800
In-Reply-To: <20241114220921.2529905-1-saravanak@google.com>
Message-Id: <20241114220921.2529905-2-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 1/5] PM: sleep: Fix runtime PM issue in dpm_resume()
From: Saravana Kannan <saravanak@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Cc: Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Marek Vasut <marex@denx.de>, Bird@google.com, Tim <Tim.Bird@sony.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some devices might have their is_suspended flag set to false. In these
cases, dpm_resume() should skip doing anything for those devices.
However, runtime PM enable and a few others steps are done before
checking for this flag. Fix it so that we do things in the right order.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/power/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 4a67e83300e1..86e51b9fefab 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -913,6 +913,9 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
 	if (dev->power.syscore)
 		goto Complete;
 
+	if (!dev->power.is_suspended)
+		goto Unlock;
+
 	if (dev->power.direct_complete) {
 		/* Match the pm_runtime_disable() in __device_suspend(). */
 		pm_runtime_enable(dev);
@@ -931,9 +934,6 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
 	 */
 	dev->power.is_prepared = false;
 
-	if (!dev->power.is_suspended)
-		goto Unlock;
-
 	if (dev->pm_domain) {
 		info = "power domain ";
 		callback = pm_op(&dev->pm_domain->ops, state);
-- 
2.47.0.338.g60cca15819-goog



Return-Path: <linux-pm+bounces-4479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E895486A3C9
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 00:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8910D1F25AFA
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 23:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB93155C3B;
	Tue, 27 Feb 2024 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="CmbxMUtl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8695256449
	for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076902; cv=none; b=TTtMExXgVIWFrwvo6wMmUzilzeS280MK/tjNB1zD0hU0moomExelcWersLBFk5Of2li37srRtz9i75OLY89gI7QtuNwg29xU8Fy+1CEYx5wS0CneuWocGetmtLP2LuxAV1Pu4UiQedZM3iPrWL8ndLwzceHeZed+rVCSs0eNaTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076902; c=relaxed/simple;
	bh=gRC6j0K7LFqSQU/6DlrnOPqvA92Esl5PB0v8SpJNck4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OOGg8yOBM917MU/b3bgvxaTVcsnm6O0pf8RdKA622SyvRyZreOKWU9MqnUtgs0e6LlXSEqpwNBePvdpX9wDqyEsG0wSblaixte8TvFDJU/y0GWjOTvmTLWDlflQAuKaE8W6dCahYG/3FWepbvywnHuW7XnC4vPu4WALdPZ9pLYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=CmbxMUtl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so38579515e9.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 15:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1709076898; x=1709681698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGIQk7rXip9tFvcYlcm0hZ25TTGnFG/+FGuOb/CLIyI=;
        b=CmbxMUtl/oc5YY4bbtYxNsqdh9qAfRL8e3u+xNX4TbtQasqC5OyvT/WrXuNMyUd1+5
         AzqViT0hENn8MCVD4oCfU32ED0/0tDUZ9zHCdkN68ZYO0PLj7sYOxg5nP9r0aD+WQVVd
         vGLu9UqFLgcLZCn6ZMlH7bttnqzM53yHkO4vo84xCilqItqf2qTby6XJGqht1XNnEY/Z
         LvYrzwHfDTQTF0gk0zpZQZf4B5AseEle0qUs7BN6EUV+pdidi3KaM0LPfdjDzLAVRUGM
         NNIht1+nIj7BHYeWzawh0vFIlAadhy6fXThdAJWOVgAusbKRvssG6BHLDi1CwIC3bgzH
         8THQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709076898; x=1709681698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGIQk7rXip9tFvcYlcm0hZ25TTGnFG/+FGuOb/CLIyI=;
        b=wOXZJvWd2lh+3A90rYwm671jAHp1rby5vw2fZXzStobPg5VprrxRKMXRY7Wye6MfLa
         SWZ0tRTkGA5ayF6cwqSiIs9LEfiBADBXjtWkSTUD4boSjzj6gWWM5obqVObWyPPAKuAz
         BC1KN+cMbuUeIzjCcwLdYqfIRndiQWahhWHPLLvwqTKK08fWJJCjUWmmJ3ZY28oHyMFt
         la1WqmNWlUP4JS8LiouX7Pvg5rKvDI791qlWmwchJ2Hcu2Eb5bsLR7kU06zRpba7R8uA
         pc41V7KmwMM4iYPcnVt400j7P4ziFbL3I8wAPVnNzjjHm/3nj0VQXbHkRbmapIOCvp/G
         AL5A==
X-Forwarded-Encrypted: i=1; AJvYcCVDuUUCZZmN+2NNOoWfSxwLC7WmVAdGri6h8gbwhaC8Dz6CucAGXZsuydv/gyr0A/lxxX3gLyJa6f3ISR2ZxCrA8fgqWM0LoiE=
X-Gm-Message-State: AOJu0YwKr1/zmlDkZelz2vORUi6xUzqpsYBzNK5mNx3sY9NVnjFTGiaQ
	YABkeuxmLO8zaqUS12bz25YX/K+AO8YnnilJW0trEhsUodMUwgFPNqvbH6MHe/uTv2OTIhrJeVh
	q
X-Google-Smtp-Source: AGHT+IGg1FSvvzccob9cPmft0pC6SQzWbuVqjhsNI3ds3NgQAIKqZvkwXFy5iTWYwDXmIfcb7BxZGg==
X-Received: by 2002:a05:600c:4f55:b0:412:880e:7659 with SMTP id m21-20020a05600c4f5500b00412880e7659mr8060055wmq.32.1709076897700;
        Tue, 27 Feb 2024 15:34:57 -0800 (PST)
Received: from airbuntu.. (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id k7-20020a7bc407000000b004126e26f756sm220756wmi.43.2024.02.27.15.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 15:34:57 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>,
	Pierre Gondois <pierre.gondois@arm.com>
Subject: [PATCH] cpufreq: Honour transition_latency over transition_delay_us
Date: Tue, 27 Feb 2024 23:34:52 +0000
Message-Id: <20240227233452.405852-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222233947.sl435tvhhpe5iqzw@airbuntu>
References: <20240222233947.sl435tvhhpe5iqzw@airbuntu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some platforms like Arm's Juno can have a high transition latency that
can be larger than the 2ms cap introduced. If a driver report
a transition_latency that is higher than the cap, then use it as-is.

Update comment s/10/2/ to reflect the new cap of 2ms.

Reported-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 drivers/cpufreq/cpufreq.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 66cef33c4ec7..926a51cb7e52 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -576,8 +576,17 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
 
 	latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
 	if (latency) {
+		unsigned int max_delay_us = 2 * MSEC_PER_SEC;
+
+		/*
+		 * If the platform already has high transition_latency, use it
+		 * as-is.
+		 */
+		if (latency > max_delay_us)
+			return latency;
+
 		/*
-		 * For platforms that can change the frequency very fast (< 10
+		 * For platforms that can change the frequency very fast (< 2
 		 * us), the above formula gives a decent transition delay. But
 		 * for platforms where transition_latency is in milliseconds, it
 		 * ends up giving unrealistic values.
@@ -586,7 +595,7 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
 		 * a reasonable amount of time after which we should reevaluate
 		 * the frequency.
 		 */
-		return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2 * MSEC_PER_SEC));
+		return min(latency * LATENCY_MULTIPLIER, max_delay_us);
 	}
 
 	return LATENCY_MULTIPLIER;
-- 
2.34.1



Return-Path: <linux-pm+bounces-25005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD08AA823EF
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 13:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A3517EE2E
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 11:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22612253E4;
	Wed,  9 Apr 2025 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFOwpdYl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF701CDFCE;
	Wed,  9 Apr 2025 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199299; cv=none; b=aL46zVJbfHkxz/I8ehIeU7a0uro1YO6iT4b5E2YI8A4G/HpJdiavL1AcfA8BARS+lLfJa5i11NqJa2fw8yeH92T5N+/bShrMhpOcXXyMnHmFluVh0jjGwtj3spzpcMeFv+nUZ4CB93rzNi3LB3tucGPZGd3WEA6rGn6U5AAJfRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199299; c=relaxed/simple;
	bh=+oMoXLBfa87YPe/UNOg7aaY6mbyRAPo+nUe66s5gpds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nf6vlSE2pxtDYfLO+js9fFR7TigATtS/iGHTs9yKHw2XPW8DaYWO2Cv6lo2Gz8Z7Uq5zvo1sfIlr4SVXKFi8pfM33+Q/jxMt1t4Jsrez7Flb7PT6SLbnR9k2/6YhWTe5vQrnMtWz4ICxLLC+rjqmq1Pnn1ZAS6f1sDUtnAwIBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFOwpdYl; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4772f48f516so6179051cf.1;
        Wed, 09 Apr 2025 04:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744199297; x=1744804097; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tHSDlEdPwKlUtCjkffb48g0X0GykFB7y5RiiSKGZcyQ=;
        b=jFOwpdYlSNo7mKZbV9QgztSMW3Ibc0/OOOVN8/6WEzRma3tcPfjracerZeceNXxOVj
         e1csUnv3r6AJn0or57VV31jqDxX3phkP2ht1yVoaslfsYSL6qtv8qeu6ZNt4C+nNeWT4
         ZKeJ7KJ/AsRt4FKDdj/WUhdSnjxOZirK/0S/Bb2WMpHchJm72Oom0VJXtz1HdAxOv2cP
         6ygta/XgkZfby9r/cA3nO++yt0Fgn/w+Rd/whk51JBsPMZdLij8uyVeeBamhbTHdarAE
         CkZl2e8fTDHawsg/CswhjEHugCgItpkrBaDhBbA1EqcU1AU25ifOCovHTeJetwVSdH7B
         iKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744199297; x=1744804097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHSDlEdPwKlUtCjkffb48g0X0GykFB7y5RiiSKGZcyQ=;
        b=MoOgzvyZMK8Pxf5V6tyNt8VCVowwx1UcPrxCr9pqAsCvM+wXG05HE8iBemZ8AVgYsi
         hag+zepdzh4ojjj3YOE5rQfIFvpo+ccWJfEXEyN1x9ND6dVHRTWvUHkCEZkksfNVDj2y
         Hg6XMgQNdwO/nxPkTJR6iAFsmU81PCLUYaXt+lH4NT5m0HBMh3+H/RbCHkmSkEpzVb8h
         BHPQ/FjXAjih/rlZ+XCVNLXHbnH9O44rZqVVPpr0A004VURcSL8aN0frSpvIifGd1Z/F
         utOtgc3TbEk9ucVvCxg3x+e/Zi2EAxWs6vgOAb1tWmvO8r4QT63Q5RXQ0LVXXQdiY5t3
         MUTg==
X-Forwarded-Encrypted: i=1; AJvYcCVgVows+SGR9u21TtxTl0zC4MCljWnJpf2K1eTmpMpG00C+jSVZLlvIpatB5I1oGKAF4eHY8MV5sco=@vger.kernel.org, AJvYcCXiChmp0CJLQYpza9Io9Ek58Xu7fSP8lT88Xqmr5AhR/S9TUBCaiZMTisja881DwcNSh952eNBz3yn2iSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFBiLWCqrxKTfw0p+XHz4v1ryvrfTYbuBP6nnPRPpAVVvFpxz5
	zhtOtaH4gi1RA5PhaH47RuJxuHAPuiVqO3L4d1NsJsODlp3soKfOooMvqO0bAotEntn5BpE8dBH
	f6mHJyuWWzJ3tkt0VmiSPbzSj+GrlOPYp
X-Gm-Gg: ASbGnctY0dcCMA+t3ACHA8PSldN2UlTjpooFbss3395sR2qJsR9hzHgVs46UGk7nRvu
	qr1jXvTSOHM6gucQ2luu739G9Ii2GPtZUJjqvNVq2vVBm3z8Thqu7kRs+JQTywQA4vKV+fOGP1y
	aWmDswu+ghpXiCeYdFveH1aXpAeBxIWQ9iRg==
X-Google-Smtp-Source: AGHT+IH6eUbNeyGRk027zF9EhS6NwfHmHuH42uSvLp7fAFVN+UVc1L1H7PMlVrQr24+zxeRAG2OjCnP3jVGMNN/aNmY=
X-Received: by 2002:a05:622a:114:b0:478:f69b:ac9 with SMTP id
 d75a77b69052e-4795f0b83fbmr38688751cf.11.1744199297071; Wed, 09 Apr 2025
 04:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212015734.41241-1-sultan@kerneltoast.com>
 <20241212015734.41241-2-sultan@kerneltoast.com> <Z_Tlc6Qs-tYpxWYb@linaro.org>
 <Z_U_LN0AtH_n4YtE@sultan-box.localdomain> <Z_VTRspvmOUfrawh@linaro.org> <CAB8ipk8ARRdR8UPgLqJ3EcAzuE4KNEO=cmLNJLk6thTxdBSHWw@mail.gmail.com>
In-Reply-To: <CAB8ipk8ARRdR8UPgLqJ3EcAzuE4KNEO=cmLNJLk6thTxdBSHWw@mail.gmail.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 9 Apr 2025 19:48:05 +0800
X-Gm-Features: ATxdqUG5KB4LocopZgCp1oV_viz4WDlRXxnLxwjzi5vXxKdUwROIw059B5MhYhQ
Message-ID: <CAB8ipk_Ayqmh=Ch2aH2c+i-q+qdiQ317VBH1kOHYN=R9dt6LOw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: schedutil: Fix superfluous updates caused by need_freq_update
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Or can we modify it as follows?

-->8--

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 1a19d69b91ed..0e8d3b92ffe7 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -83,7 +83,7 @@ static bool sugov_should_update_freq(struct
sugov_policy *sg_policy, u64 time)

        if (unlikely(sg_policy->limits_changed)) {
                sg_policy->limits_changed = false;
-               sg_policy->need_freq_update =
cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
+               sg_policy->need_freq_update = true;
                return true;
        }

@@ -95,11 +95,15 @@ static bool sugov_should_update_freq(struct
sugov_policy *sg_policy, u64 time)
 static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
                                   unsigned int next_freq)
 {
-       if (sg_policy->need_freq_update)
+       if (sg_policy->need_freq_update) {
                sg_policy->need_freq_update = false;
-       else if (sg_policy->next_freq == next_freq)
-               return false;
+               if (cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
+                       goto change;
+       }

+       if (sg_policy->next_freq == next_freq)
+               return false;
+change:
        sg_policy->next_freq = next_freq;
        sg_policy->last_freq_update_time = time;


Return-Path: <linux-pm+bounces-25062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5372AA8367B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 04:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1488C27E4
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 02:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453591D63F8;
	Thu, 10 Apr 2025 02:22:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946861D5CE8;
	Thu, 10 Apr 2025 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251760; cv=none; b=Wn5nkFfQPe6D9Jd9ubh8Tkc/bK8YWK8UQOks1YPz8D1pOAP5yEobKK1jxoS0y2O63W7muepagk7Q6T/ASiqNUDX5wDZrf7O98ZXqiRZljs4phQryX4PFfBoyFuVpTw0Ap1Wtw4VUnyKLVSMo6AWFQJBA3emv2cqkbs5kva3eqr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251760; c=relaxed/simple;
	bh=TynPGdAb63B4UsxmATz2ZTCj66atvpV90vkCQ2IdeiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMR8+34QCe76RaYQM6TkSPmoH0ECqg0c/DIg4m2GRMz2o0jMTCVLJGECZXPcfSqL3i+Yha/Ij43+J5H9RjUEYgUa6RMup2ibdi+h3H3ZxrMt0Xmt1M5R/YvK3NcmijqmnwCj2SQIZPKyuTxqQturXSFrwljd6O9xLLgmR/fvytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2279915e06eso2783965ad.1;
        Wed, 09 Apr 2025 19:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744251758; x=1744856558;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIr+mC1fO6LkSb3ZOhdC8i0ipLDLm1eqpXFxb8ZVEQw=;
        b=QT2qnVGeoWQyKiMBqw749Z2PqE7yAMFwoZ23n+303WZNKYoyYXsCSsPwRkY7XijSh0
         9lMFlpfq9uZfN4mNc3EmN4l9IzGBiTDbtZfNY5EDEWGRHyPRRNSS5/FR/p5ZIORkMXYT
         aoVkfP5brFcSp1W+jhuZTAnMKNhxsIdSnby9kHB2gNz1sTfChLbEbUYHetwd9JRr9nbY
         fWcDCsDYVJVrndPcR9xZJWmzlnY4knRemHGu5tQh78gWZBGDgo5VAnKqqX4zQDFgTVaX
         ZylYtrZ+KIuvm4DZEKUTtqtqmCbyYRZdTz6I99LzmswXS4u4bNNUm5PJiILPk4etOeEt
         CoHg==
X-Forwarded-Encrypted: i=1; AJvYcCWPjNpc7bTRM79MKme9y0hX3yM6GYqqXmPI+mKVCWifV/4N4Fr9FZaIKlYdRk1CgKOLoBYejbtUL8Xsguk=@vger.kernel.org, AJvYcCXOm10jvfnYiT6agAect5sLKFCUX+Fb7Wwuy0MVvZWg/WY6ZaYHLIjfXCqZU3O9engfm9+n5BXxuqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzElPMcdXvlNlMN8ZP4v8aeQQdxJLEHnjb3RrFvbpLnZoHnZrNd
	DdZ8Pke51FyCRpbpGYNEioLNaIrY91KhcUsgo6unTJ3sLkj0e9Un
X-Gm-Gg: ASbGnctXaDLbAasdOLqEwhyd4hNvUECYUpDsgdbDPNdRHvvLFBLsr8LTpCGE3zwGglp
	Kds6U9KB2ocy8gvq4npIO4vOa6stK4FEqfMO6nnafmvBVnCIcDac+V97HT2rijEoFR1hP/pQGbt
	Shi27VAQtkEpftHoRfBOm0+bHpIW1arm8SUEmo6EcE8bQjqJ5TkSBGm7fRjipHQ6fjR3aRPvsBq
	4zDg9610pT45MtjPTAkjBrpTIB6RmOnPEII765JhPqnEa1FDpvMqawGn+9ujP+k459CNi9AI+da
	Q1i4Pf+9f9ORdJ/29gtyFg5Hv0StbZdPIg73ILdz/I9+ZjTJb5gwEmkpUo++ll3JSwzZ9A==
X-Google-Smtp-Source: AGHT+IFZHQQqw4sZWzNWH0yG0EKerIkJXfP6ZMCi6Ewbi6upzfzLq13xirC41miWfZY1k7nOOkUKaw==
X-Received: by 2002:a17:903:246:b0:223:66bc:f1de with SMTP id d9443c01a7336-22b2edd566bmr18732045ad.21.1744251757639;
        Wed, 09 Apr 2025 19:22:37 -0700 (PDT)
Received: from sultan-box.localdomain ([142.147.89.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb0400sm19496045ad.160.2025.04.09.19.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 19:22:37 -0700 (PDT)
Date: Wed, 9 Apr 2025 19:22:33 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/2] cpufreq: schedutil: Fix superfluous updates caused
 by need_freq_update
Message-ID: <Z_cracmQRfB8hF06@sultan-box.localdomain>
References: <20241212015734.41241-2-sultan@kerneltoast.com>
 <Z_Tlc6Qs-tYpxWYb@linaro.org>
 <Z_U_LN0AtH_n4YtE@sultan-box.localdomain>
 <Z_VTRspvmOUfrawh@linaro.org>
 <CAB8ipk8ARRdR8UPgLqJ3EcAzuE4KNEO=cmLNJLk6thTxdBSHWw@mail.gmail.com>
 <CAB8ipk_Ayqmh=Ch2aH2c+i-q+qdiQ317VBH1kOHYN=R9dt6LOw@mail.gmail.com>
 <Z_cjv0EJ45NShYOp@sultan-box.localdomain>
 <CAB8ipk8WOh5_XvRYJrPi6b6wf8G4=zjoFRWpXk3viv3gkHCn1g@mail.gmail.com>
 <Z_coNmh-CabcfIWD@sultan-box.localdomain>
 <CAB8ipk8AAFFtV3OA4S=g9X9AXsC4Ntr911DLLRkhgQtvMvXAvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk8AAFFtV3OA4S=g9X9AXsC4Ntr911DLLRkhgQtvMvXAvg@mail.gmail.com>

On Thu, Apr 10, 2025 at 10:13:04AM +0800, Xuewen Yan wrote:
> On Thu, Apr 10, 2025 at 10:09 AM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> >
> > On Thu, Apr 10, 2025 at 10:06:41AM +0800, Xuewen Yan wrote:
> > > On Thu, Apr 10, 2025 at 9:49 AM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> > > >
> > > > On Wed, Apr 09, 2025 at 07:48:05PM +0800, Xuewen Yan wrote:
> > > > > Or can we modify it as follows?
> > > > >
> > > > > -->8--
> > > > >
> > > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > > > index 1a19d69b91ed..0e8d3b92ffe7 100644
> > > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > > @@ -83,7 +83,7 @@ static bool sugov_should_update_freq(struct
> > > > > sugov_policy *sg_policy, u64 time)
> > > > >
> > > > >         if (unlikely(sg_policy->limits_changed)) {
> > > > >                 sg_policy->limits_changed = false;
> > > > > -               sg_policy->need_freq_update =
> > > > > cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> > > > > +               sg_policy->need_freq_update = true;
> > > > >                 return true;
> > > > >         }
> > > > >
> > > > > @@ -95,11 +95,15 @@ static bool sugov_should_update_freq(struct
> > > > > sugov_policy *sg_policy, u64 time)
> > > > >  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> > > > >                                    unsigned int next_freq)
> > > > >  {
> > > > > -       if (sg_policy->need_freq_update)
> > > > > +       if (sg_policy->need_freq_update) {
> > > > >                 sg_policy->need_freq_update = false;
> > > > > -       else if (sg_policy->next_freq == next_freq)
> > > > > -               return false;
> > > > > +               if (cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
> > > > > +                       goto change;
> > > > > +       }
> > > > >
> > > > > +       if (sg_policy->next_freq == next_freq)
> > > > > +               return false;
> > > > > +change:
> > > > >         sg_policy->next_freq = next_freq;
> > > > >         sg_policy->last_freq_update_time = time;
> > > >
> > > > If CPUFREQ_NEED_UPDATE_LIMITS isn't specified, then there's no need to request a
> > > > frequency switch from the driver when the current frequency is exactly the same
> > > > as the next frequency.
> > >
> > > Yes, the following check would return false:
> > >
> > >  +       if (sg_policy->next_freq == next_freq)
> > >  +               return false;
> >
> > But what does that change fix? In fact, that change causes a limits update to
> > trigger a frequency switch request to the driver even when the new frequency is
> > the same as the current one.
> 
> We set the sg_policy->need_freq_update = false instead of
> sg_policy->need_freq_update =
> cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS),
> to fix the original issue, and then add the
> +               if (cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
> +                       goto change;
> 
> to allow cpufreq to update when CPUFREQ_NEED_UPDATE_LIMITS is set.

Please take a closer look at this snippet in sugov_update_next_freq():

	if (sg_policy->need_freq_update)
		sg_policy->need_freq_update = false;
	else if (sg_policy->next_freq == next_freq)
		return false;

The 2nd if-statement is an else-if. Therefore, when need_freq_update is true, it
is set to false *and* skips the (sg_policy->next_freq == next_freq) check.

Sultan


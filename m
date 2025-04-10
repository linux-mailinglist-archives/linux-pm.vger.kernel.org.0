Return-Path: <linux-pm+bounces-25060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 392E0A83635
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 04:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359D61B62BAA
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 02:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D1B1B0F20;
	Thu, 10 Apr 2025 02:09:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD40136327;
	Thu, 10 Apr 2025 02:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744250941; cv=none; b=Vp6LceR/KG54CHLkCrIapFsdIBTZbFY9dm1SjXLnxoz3t48oWG3CJlUA9IA+fFpRqWMFb3K/+4Hyo1yM9EmJ0ijpROMe/JjjEWS79e5epSjsbKL2nGdwXA1TloSfv3akrtzvoXylM+EVyNWs61k147mfj7YkQK3ZUGRDm2U55Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744250941; c=relaxed/simple;
	bh=OWxvDq0xLF62t+kJ/TW280ebsUTjmdjm/t9fGFNlrWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxbTecqRVLpB1imz4kq86j+c+/4y4OCvy2R5UCEADOQmOVE15BfZMNPEdKVhE34V8HiNY5MsRdKu2V49eUB8e9Xupjq1+d8k5SGIGsFiJQ5bKfxN5ZF72Ea2Z8/e6nHX1CHzULjLRYiJiCfXnqpHY9s6MmsiaIhF2h0LxDSdeak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224171d6826so3866745ad.3;
        Wed, 09 Apr 2025 19:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744250939; x=1744855739;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Txiqytx0Wp53kAXxmDPoXRLQIOc45Em2+G1d9SexqmA=;
        b=V/jwRiD18DBoep6Ctect146YvGxZAczYNTguAIaVGWVFTuGKIldE9eOmiA8C79OmHn
         FxJWY2eL5Dd6D8Jx3UsV2l2KDcPDXj7XrGWwnjpDOiDY18NmQu9DYyuxP2q5nJANZ7xe
         ehcbj6S4JGb5OXajbU2BrrKmR20PMmByK+Z5VI2pQUo+iIrYY4rlihNv1YyazWJZMV1K
         FmEsQJPjsnqWmnhErasrbQ/di0Nlk+2c3CjotvryFpeVD0kqhF31epMbJ5KFQG8OcbPX
         SWsBOTsgPZ+0nCYvtyXHYkHfACJSt5SrWHoiD6YLx62LYWDET0aDoPUBCExDfFg27wHp
         egvA==
X-Forwarded-Encrypted: i=1; AJvYcCWSvN280F1jUrLCGPsnfrVXftrfZgVH6v6ppUp1oWZdfd0JGzMzMSaZ/Tf5vT8EZRc0h0Ijs0f5Dq8=@vger.kernel.org, AJvYcCXHecMso+A/LsGHBAKjH0DFpWTFDUQr/luS+DtEL+AWIKmOJs063sj3vgFIFnhLkQuQ7WsUyCyAiMGQC9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZfXbBpDuaUkITP5h5Gf3/bi6xHMjFpsUJFQ/srtwCGFR5eTci
	jLIfuUajY8nCpFkuBAqKmu0SZchWhuPkDbZZ75SfVrDq8Hw/yzgj
X-Gm-Gg: ASbGncveuUYKS0sNLiZWaWYtr6qOY/RDiMsM1tYv/hAvBk64Woa27BTMGA7SA4mtpJJ
	enGA2iq4whLhpGxQ4BGRxmO+1avAbiYG/XF5hZC+dNYN03Qvzk8YtTZV/NIsoK1H2uJFFPl2ChH
	0hBI3dsZeXTRskjLMz8MXdSbr7pwvkv+zgc5mj0lkWmqrg3IXPfWgyDZ4Oua2MXbDlQTJcIfMxj
	W0zKqr+pOseWdAkbMgpSd651GvkqhvTHw8DiHGm1KDwt81wgKqcMqy15LLCPJmqLX3A+CCuXJbO
	XjzjRcO0FqY+CWCuQIWzeZXYuohVEnuo9TsOj9fJ6rqrGupa7+yMOmP/dALAZKFQO8PbAA==
X-Google-Smtp-Source: AGHT+IHVdM9094na2XKxAQkFa6++MinqhWaWMEfO9/pwOC/RYQ2ceyatiBtQ0Jm2SIE2SJe1piWHUw==
X-Received: by 2002:a17:903:238a:b0:21f:c67:a68a with SMTP id d9443c01a7336-22b3654e89dmr17463825ad.31.1744250938880;
        Wed, 09 Apr 2025 19:08:58 -0700 (PDT)
Received: from sultan-box.localdomain ([142.147.89.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b628desm19379025ad.20.2025.04.09.19.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 19:08:58 -0700 (PDT)
Date: Wed, 9 Apr 2025 19:08:54 -0700
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
Message-ID: <Z_coNmh-CabcfIWD@sultan-box.localdomain>
References: <20241212015734.41241-1-sultan@kerneltoast.com>
 <20241212015734.41241-2-sultan@kerneltoast.com>
 <Z_Tlc6Qs-tYpxWYb@linaro.org>
 <Z_U_LN0AtH_n4YtE@sultan-box.localdomain>
 <Z_VTRspvmOUfrawh@linaro.org>
 <CAB8ipk8ARRdR8UPgLqJ3EcAzuE4KNEO=cmLNJLk6thTxdBSHWw@mail.gmail.com>
 <CAB8ipk_Ayqmh=Ch2aH2c+i-q+qdiQ317VBH1kOHYN=R9dt6LOw@mail.gmail.com>
 <Z_cjv0EJ45NShYOp@sultan-box.localdomain>
 <CAB8ipk8WOh5_XvRYJrPi6b6wf8G4=zjoFRWpXk3viv3gkHCn1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk8WOh5_XvRYJrPi6b6wf8G4=zjoFRWpXk3viv3gkHCn1g@mail.gmail.com>

On Thu, Apr 10, 2025 at 10:06:41AM +0800, Xuewen Yan wrote:
> On Thu, Apr 10, 2025 at 9:49 AM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> >
> > On Wed, Apr 09, 2025 at 07:48:05PM +0800, Xuewen Yan wrote:
> > > Or can we modify it as follows?
> > >
> > > -->8--
> > >
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index 1a19d69b91ed..0e8d3b92ffe7 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -83,7 +83,7 @@ static bool sugov_should_update_freq(struct
> > > sugov_policy *sg_policy, u64 time)
> > >
> > >         if (unlikely(sg_policy->limits_changed)) {
> > >                 sg_policy->limits_changed = false;
> > > -               sg_policy->need_freq_update =
> > > cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> > > +               sg_policy->need_freq_update = true;
> > >                 return true;
> > >         }
> > >
> > > @@ -95,11 +95,15 @@ static bool sugov_should_update_freq(struct
> > > sugov_policy *sg_policy, u64 time)
> > >  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> > >                                    unsigned int next_freq)
> > >  {
> > > -       if (sg_policy->need_freq_update)
> > > +       if (sg_policy->need_freq_update) {
> > >                 sg_policy->need_freq_update = false;
> > > -       else if (sg_policy->next_freq == next_freq)
> > > -               return false;
> > > +               if (cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
> > > +                       goto change;
> > > +       }
> > >
> > > +       if (sg_policy->next_freq == next_freq)
> > > +               return false;
> > > +change:
> > >         sg_policy->next_freq = next_freq;
> > >         sg_policy->last_freq_update_time = time;
> >
> > If CPUFREQ_NEED_UPDATE_LIMITS isn't specified, then there's no need to request a
> > frequency switch from the driver when the current frequency is exactly the same
> > as the next frequency.
> 
> Yes, the following check would return false:
> 
>  +       if (sg_policy->next_freq == next_freq)
>  +               return false;

But what does that change fix? In fact, that change causes a limits update to
trigger a frequency switch request to the driver even when the new frequency is
the same as the current one.

Sultan


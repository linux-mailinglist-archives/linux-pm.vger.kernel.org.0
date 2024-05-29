Return-Path: <linux-pm+bounces-8356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BACD8D3480
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 12:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1864282048
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 10:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AD3178387;
	Wed, 29 May 2024 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="NN6yjY2e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B3F16D9DD
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978222; cv=none; b=rj+rhNxln2uurxlTLcVD8KOalh5lzBTJ7uATeXuSx47IzHJpgka0+2m2Q1YmTLEJSq8V5TOzMp0oeJyE3afgG5Yc2l77aitA/4hj0JhlAWZxTjqw+s39i711u5DIqBHbGHeXzidk0IVRnBXRgSDYoSVQnX3kH1kKiizjKSq1Vpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978222; c=relaxed/simple;
	bh=ZWnaqU12DGlat8tVH6v5xnZf2eRxhrhZhvJpIuTLNa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVFWCZSSa0KgxK3XKnPPRYnb0BqEV/LRDFr5NZDFIJzanSvFg/p2afn+I1n8GsFmPj2CMSuzQPkmcJ9Epa2bhVSYobJT1h5zTht+uuqC6yIu7dlcC082xvOQuKTYWlrYNMGZ74vrRoYpBpKodXjTWi03HWxtbAmIBIQt8jylv7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=NN6yjY2e; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-357d533b744so1900211f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 03:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716978219; x=1717583019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0b3KbV2faZuFMsnwxH5H7RwR4rLuDhMKKTd0Kx+x/U=;
        b=NN6yjY2eQyKxqX78wNqHDsPJiTR8VoUVqcyKYrp7ZAEom3GyE3+WlridTw5m3Yn40V
         J4bwzoSTxQ85SxJVAKspqtYKBMtnlMXvgfcrT0MEZuXWToDKJRplvZjh6JC4kEwRUVjg
         muRYoZ75tNDXLtNdmr5GutJ3Q4v26LhuB7tVRWNoo+K2aorWYThjdkRZTzCb/pm6PtVf
         q1QTDPRNzZjXxrNP13UH/b9AJDiLsxuCHjD5Nrji91nEfyJzesJhCyZ4gFwfYEiJhgmX
         0Srdmvn7kmSBfrsrphoH7omGWpjeIVmIk7IlVoZ8xR4yzFScBoYzIq2298QYTmX1+GSr
         zHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716978219; x=1717583019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0b3KbV2faZuFMsnwxH5H7RwR4rLuDhMKKTd0Kx+x/U=;
        b=bD1qXp/9Nd5dG9hUO/i2vwxeZWmELqlyYw2VcapLXRuwzF1NWiRo2mKORrMj1J5+DZ
         q6TxUgdu57h+4gNTBwFwXsjI4+5nfiBzDwtlPJ4IqsR6XmEqpBIBSKw7D70NuF9vyqI1
         DCNLBdczg+HHF6X3OEGjECMdK7CY40KtpxSNCDBHtbUEf7bhw7fWG+o2xxGmtxSP/6zP
         W6Cv+gIPUO6Aj7uzZhYtvR03m7bJigGzaSDAtQcTpOXHfAgzcnU7LsH2+rtc3pfSKAEb
         v/w4XojHPdPV1c/ZDX1c/pO6KKS+HFQJHNIr8yknPdbmv4AXefN4RRgxBF13JrsEw4cu
         6k2g==
X-Forwarded-Encrypted: i=1; AJvYcCVfmC8zIGk9ZS1LQH8bXYwJ2x9GQmtNSLYpykf0CBxEYL+uiMlm7Vq/B65kJZh6koeQWJfWB6hmFMsbrslk0vPpT91bmVCtudU=
X-Gm-Message-State: AOJu0YyT8oWNLkQdufvzdCKdLO7JDN/rrMcdX/K5bWH5v1mc5PLO3/EA
	n3it0qPEltwDE2T0Yq8Yeu0RpIrx6/tyNb1jDEzq6C7BekNMW4ZKfMKZtSJH4N0=
X-Google-Smtp-Source: AGHT+IHTRONIUqtg7tNhL1JAmH99IU9uvpOjh/4jndRd6OB/PEDKEXO7HjjbQ7aw2gNFw8NQH+iznQ==
X-Received: by 2002:a05:6000:1541:b0:359:733c:c8d6 with SMTP id ffacd0b85a97d-359733cc9fbmr7464981f8f.67.1716978219336;
        Wed, 29 May 2024 03:23:39 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3564b762ca8sm13780737f8f.112.2024.05.29.03.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 03:23:38 -0700 (PDT)
Date: Wed, 29 May 2024 11:23:37 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, rafael@kernel.org,
	daniel.lezcano@linaro.org, lukasz.luba@arm.com,
	Dietmar.Eggemann@arm.com, dsmythies@telus.net,
	yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
Message-ID: <20240529102337.ddap2ej7pbxurgax@airbuntu>
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com>
 <20230711175814.zfavcn7xn3ia5va4@airbuntu>
 <ZLZ/btJw5LNVxVy8@e126311.manchester.arm.com>
 <20230718132432.w5xoxbqm54jmu6n5@airbuntu>
 <20230917010516.54dgcmms44wyfrvx@airbuntu>
 <CAKfTPtA6ZzRR-zMN7sodOW+N_P+GqwNv4tGR+aMB5VXRT2b5bg@mail.gmail.com>
 <ZlXKLOnVkegQfdKA@e126311.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlXKLOnVkegQfdKA@e126311.manchester.arm.com>

On 05/28/24 13:12, Kajetan Puchalski wrote:
> Hi Vincent,
> 
> On Tue, May 28, 2024 at 11:29:02AM +0200, Vincent Guittot wrote:
> > Hi All,
> > 
> > I'm quite late on this thread but this patchset creates a major
> > regression for psci cpuidle driver when using the OSI mode (OS
> > initiated mode).  In such a case, cpuidle driver takes care only of
> > CPUs power state and the deeper C-states ,which includes cluster and
> > other power domains, are handled with power domain framework. In such
> > configuration ,cpuidle has only 2 c-states : WFI and cpu off states
> > and others states that include the clusters, are managed by genpd and
> > its governor.
> > 
> > This patch selects cpuidle c-state N-1 as soon as the utilization is
> > above CPU capacity / 64 which means at most a level of 16 on the big
> > core but can be as low as 4 on little cores. These levels are very low
> > and the main result is that as soon as there is very little activity
> > on a CPU, cpuidle always selects WFI states whatever the estimated
> > sleep duration and which prevents any deeper states. Another effect is
> > that it also keeps the tick firing every 1ms in my case.
> > 
> > IMO, we should at least increase the utilization level
> 
> I think you're most likely right on this, the reason why I ended up
> leaving the threshold at cap/64 was that at cap/32 it would be too high
> for the mechanism to actually have any effects on the device I was
> testing this on.
> 
> The issue then of course is that if you tailor the threshold to little
> cores it becomes too high for big cores, conversely if you tailor it to
> big cores it becomes too low for small ones.
> 
> We could get around this by making sure the threshold doesn't end up
> being lower than a certain capacity-independent minimum, how does that sound?
> 
> cpu_data->util_threshold = max(MIN_THRESHOLD, max_capacity >> UTIL_THRESHOLD_SHIFT);
> 
> And we set MIN_THRESHOLD to something like 10, 15 or 20. Not sure which
> one would be more appropriate but I think this could help alleviate some
> issues with the mechanism being too aggressive.

I'm afraid this is not a solution. The whole threshold logic doesn't work I am
afraid. And there's no magic number that we can come up with to make it work.
The whole approach needs rethinking.

> > 
> > Regards,
> > Vincent
> > 
> > On Sun, 17 Sept 2023 at 03:05, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > Hi Kajetan
> > >
> > > On 07/18/23 14:24, Qais Yousef wrote:
> > >
> > > > These patches are in GKI. So we'll if there are uncaught problems I guess :)
> > > >
> > > > No appetite for a knob, but the very low value for littles did strike me and
> > > > thought I better ask at least. Today's littles are too tiny for their own good
> > > > and it seemed the threshold could end up being too aggressive especially in low
> > > > activity state. You effectively are saying that if we have few 100us of
> > > > activity, normal TEO predictions based on timers are no good and better to stay
> > > > shallower anyway.
> > > >
> > > > Note that due to NOHZ, if we go to idle for an extended period the util value
> > > > might not decay for a while and miss some opportunities. Especially that when
> > > > it next wakes up, it's enough for this wake up to run for few 100s us to block
> > > > a deeper state before going back to sleep for extended period of time.
> > > >
> > > > But we shall see. I got the answer I was looking for for now.
> > >
> > > Unfortunately not too long after the patches got merged I got regression report
> > > of worse power. As you know on Android things are not as mainline, so I need to
> > > untangle this to make sure it's not a red herring. But if you want to take my
> > > word for it, I think the chances of it being a true regression is high. I had
> > > to introduce knobs to allow controlling the thresholds for now, so the good
> > > news they do help and it's not a total revert. I don't have a lot of info to
> > > share, but it's the low activity use cases that seem to got impacted. Like
> > > video playback for instance.
> > >
> > > Generally, I'm trying to remove some hardcoded values from the scheduler that
> > > enforces a behavior that is not universally desired on all systems/workloads.
> > > And I think the way the util awareness threshold are done today fall into the
> > > same category.
> > >
> > > As I tried to highlight before, it is easy to trick the threshold by a task
> > > that runs for a short time then goes back to sleep for a long time.
> > >
> > > And when the system runs full throttle for a while, it'll take around 150+ms
> > > for the util to decay to the threshold value. That's a long time to block
> > > entering deeper idle states for. I'm not sure how NOHZ and blocked averaged
> > > updates can make this potentially worse.
> > >
> > > In my view, the absolute comparison against util can be misleading. Even when
> > > util is 512 for example, we still have 50% of idle time. How this time is
> > > distributed can't be known from util alone. It could be one task waking up and
> > > sleeping. It could be multiple tasks at many combination of patterns all
> > > leading to the same outcome of CPU util being 512.
> > >
> > > IIUC the idea is that if we have even small activity, then erring on the
> > > shallow side is better. But given that target-residency is usually in few ms
> > > range, do we really need to be that quite? With a target-residency of 3ms for
> > > example, even at util of 900 there can be opportunities to enter it.
> > >
> > > Can't we instead sample util at entry to idle loop and see if it is on a rising
> > > or falling trend? When rising it makes sense to say there's demand, let's block
> > > deeper idle state. But if it is falling, then if the decay time is longer than
> > > target-residency we can say it's okay to permit the deeper idle states?
> > >
> > > I need to think more about this; but I think it's worth trying to make these
> > > thresholds more deterministic and quantifiable. There are too many workloads
> > > and system variations. I'm not sure if a knob to control these thresholds is
> > > good for anything but a workaround like I had to do. These hardcoded values
> > > can be improved IMHO. Happy to help to find alternatives.
> > >
> > >
> > > Cheers
> > >
> > > --
> > > Qais Yousef


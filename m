Return-Path: <linux-pm+bounces-8239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AC88D1743
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 11:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD406B20D8C
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5D8155A57;
	Tue, 28 May 2024 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="toqHVMvg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64135155A2F
	for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716888555; cv=none; b=ClfR9JMmHR4alrptIvn/U1ADla8INqVdsXh1S2jNG3xdjbjoM8dDAK3SuNynrEzx8Ji4pRDpHsxcXLqftDZnwH8IGFG8tOyXhk1IUbVAhRqUbqV9yEpZbQcNWRMGk97B3b1JhZkUnBRBaBpf//5gwEpkJwxVFa/wovIXDE8DQrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716888555; c=relaxed/simple;
	bh=FW+O/dnOrX2cRzlvBKosMIgX6/Jg/BO6pQfm9wfnB2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIFYts1M0L8HgWYIf3aOPDMwjcr8ZDwP81hm0/5Iqm9rHSXZ7FIOM6SIObXaWpSVFK8108EePZVUF46OfnXqQzZFXGvHAfXBGZef1EyPBF4rZYb2haS8CxKHECyYz/HYfdm6k9pUQ3UHtOSvRyLSnC+bgJIlQglvpiZHSt7TXzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=toqHVMvg; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2bf5e09d500so2573012a91.0
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 02:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716888554; x=1717493354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fpXBqoA8ceS6poGGWklE+vI0T/nfCFs37lamBJ9RBv0=;
        b=toqHVMvgr+bixKmX/pXrpdFLR0Vk1EpLGxt/R5vphbAl8SHcu7wgxyhjo4XFWbFZlW
         cGgqTXhlbGi2aMx6vkDCCEicD6pXAEUFmdbdkbfNgd2Tne2jlrE2Rk94ZcdTZwHVBWN+
         f12jDhIvTzo1X8VRhaA3cDFWFw5NXtnpLizBRaiDA5qmABc2zg/ZRrl/emkwcOHCxOhj
         7efrvS469F8t9TLRi2np42bTONgdEMOR/KECzl+ZxTCy/zMvw4VubA1oob4nIu7WqxNz
         kbnKNvyrtLY7oBiqMNddWusXTVpUPj9JUNO3ShoW0T6/joEnHzoQDo0EgMrULlhIf0Nk
         S1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716888554; x=1717493354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpXBqoA8ceS6poGGWklE+vI0T/nfCFs37lamBJ9RBv0=;
        b=tc4IXSSThG8017OXYf0xBVHJIdvimi6/uExE8caPGWDcUBbveXzWH/mHTFl2n1yiq2
         RICUgutXITbjTTkmD9bQKcW6QaS8Avryj/aZmLyeX/+gze1zNn6hoKji/1gdbq4eeRcv
         6t9KlbS+VZ2AIAp/EEDWvv+9pfYlhmmGIhu3gQdWqictP9jfYTKfWK901y1R5RvhltAl
         GnFFB/aL7FbYhJnNqzchQzeXd+2XTbprzXmrxVes/k6Wx55KZ7m6/CMDJ48rmEiu33eT
         BiYt+wKLtiSAo40g91drgqMlNWEzBZRF6bqHNBsFR5gPTI1PaKsdWVMLCQJ8/6UWi2J6
         /7ug==
X-Forwarded-Encrypted: i=1; AJvYcCVjf1D9/fkiM9MD4JCC/dFF8fjeO+kZ/fdggytAax1DJqB0Dukmck4WBm6TPjryQgb1G5n1BmVv6nlGMVKeTow9uAZmDf/ry7I=
X-Gm-Message-State: AOJu0YzCfNiLKAxMkkV6uw2fj2IJ/fCpdMisTTRez6q3HKtGFwuugfH1
	cYlizbXRMTbMhb/A+Ain4skTJkcEfhhToD/rj5RKqr4ceWWr+a6y68EVMITeasiS44I1gn9G5fW
	7cplbR4SNXooomqhMIUqsN1nxm5RYG/7gxdWaUw==
X-Google-Smtp-Source: AGHT+IFnV6sdZzDEvuU6cJqJjxl/hxM/YpZRWUDj3UQJPXey8HfB4wQltmFu18Cyo2aWW6Kcc44xPc2JWTf+PIGRkgQ=
X-Received: by 2002:a17:90a:f2c1:b0:2bf:8824:d0a5 with SMTP id
 98e67ed59e1d1-2bf8824f30amr11307027a91.6.1716888553554; Tue, 28 May 2024
 02:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com> <20230711175814.zfavcn7xn3ia5va4@airbuntu>
 <ZLZ/btJw5LNVxVy8@e126311.manchester.arm.com> <20230718132432.w5xoxbqm54jmu6n5@airbuntu>
 <20230917010516.54dgcmms44wyfrvx@airbuntu>
In-Reply-To: <20230917010516.54dgcmms44wyfrvx@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 28 May 2024 11:29:02 +0200
Message-ID: <CAKfTPtA6ZzRR-zMN7sodOW+N_P+GqwNv4tGR+aMB5VXRT2b5bg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
To: Qais Yousef <qyousef@layalina.io>
Cc: Kajetan Puchalski <kajetan.puchalski@arm.com>, rafael@kernel.org, daniel.lezcano@linaro.org, 
	lukasz.luba@arm.com, Dietmar.Eggemann@arm.com, dsmythies@telus.net, 
	yu.chen.surf@gmail.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi All,

I'm quite late on this thread but this patchset creates a major
regression for psci cpuidle driver when using the OSI mode (OS
initiated mode).  In such a case, cpuidle driver takes care only of
CPUs power state and the deeper C-states ,which includes cluster and
other power domains, are handled with power domain framework. In such
configuration ,cpuidle has only 2 c-states : WFI and cpu off states
and others states that include the clusters, are managed by genpd and
its governor.

This patch selects cpuidle c-state N-1 as soon as the utilization is
above CPU capacity / 64 which means at most a level of 16 on the big
core but can be as low as 4 on little cores. These levels are very low
and the main result is that as soon as there is very little activity
on a CPU, cpuidle always selects WFI states whatever the estimated
sleep duration and which prevents any deeper states. Another effect is
that it also keeps the tick firing every 1ms in my case.

IMO, we should at least increase the utilization level

Regards,
Vincent

On Sun, 17 Sept 2023 at 03:05, Qais Yousef <qyousef@layalina.io> wrote:
>
> Hi Kajetan
>
> On 07/18/23 14:24, Qais Yousef wrote:
>
> > These patches are in GKI. So we'll if there are uncaught problems I guess :)
> >
> > No appetite for a knob, but the very low value for littles did strike me and
> > thought I better ask at least. Today's littles are too tiny for their own good
> > and it seemed the threshold could end up being too aggressive especially in low
> > activity state. You effectively are saying that if we have few 100us of
> > activity, normal TEO predictions based on timers are no good and better to stay
> > shallower anyway.
> >
> > Note that due to NOHZ, if we go to idle for an extended period the util value
> > might not decay for a while and miss some opportunities. Especially that when
> > it next wakes up, it's enough for this wake up to run for few 100s us to block
> > a deeper state before going back to sleep for extended period of time.
> >
> > But we shall see. I got the answer I was looking for for now.
>
> Unfortunately not too long after the patches got merged I got regression report
> of worse power. As you know on Android things are not as mainline, so I need to
> untangle this to make sure it's not a red herring. But if you want to take my
> word for it, I think the chances of it being a true regression is high. I had
> to introduce knobs to allow controlling the thresholds for now, so the good
> news they do help and it's not a total revert. I don't have a lot of info to
> share, but it's the low activity use cases that seem to got impacted. Like
> video playback for instance.
>
> Generally, I'm trying to remove some hardcoded values from the scheduler that
> enforces a behavior that is not universally desired on all systems/workloads.
> And I think the way the util awareness threshold are done today fall into the
> same category.
>
> As I tried to highlight before, it is easy to trick the threshold by a task
> that runs for a short time then goes back to sleep for a long time.
>
> And when the system runs full throttle for a while, it'll take around 150+ms
> for the util to decay to the threshold value. That's a long time to block
> entering deeper idle states for. I'm not sure how NOHZ and blocked averaged
> updates can make this potentially worse.
>
> In my view, the absolute comparison against util can be misleading. Even when
> util is 512 for example, we still have 50% of idle time. How this time is
> distributed can't be known from util alone. It could be one task waking up and
> sleeping. It could be multiple tasks at many combination of patterns all
> leading to the same outcome of CPU util being 512.
>
> IIUC the idea is that if we have even small activity, then erring on the
> shallow side is better. But given that target-residency is usually in few ms
> range, do we really need to be that quite? With a target-residency of 3ms for
> example, even at util of 900 there can be opportunities to enter it.
>
> Can't we instead sample util at entry to idle loop and see if it is on a rising
> or falling trend? When rising it makes sense to say there's demand, let's block
> deeper idle state. But if it is falling, then if the decay time is longer than
> target-residency we can say it's okay to permit the deeper idle states?
>
> I need to think more about this; but I think it's worth trying to make these
> thresholds more deterministic and quantifiable. There are too many workloads
> and system variations. I'm not sure if a knob to control these thresholds is
> good for anything but a workaround like I had to do. These hardcoded values
> can be improved IMHO. Happy to help to find alternatives.
>
>
> Cheers
>
> --
> Qais Yousef


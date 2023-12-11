Return-Path: <linux-pm+bounces-914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E3480DB87
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 21:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67B62824A2
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 20:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0637153E37;
	Mon, 11 Dec 2023 20:21:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D68C4;
	Mon, 11 Dec 2023 12:20:58 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5907b9c3fd6so407938eaf.0;
        Mon, 11 Dec 2023 12:20:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702326057; x=1702930857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdR2OSdlfkd+7aN8MdL4iIUqAicY4t8Ra3rktJ3z8SE=;
        b=tJRUYbsXOW31TXaf6p1jCDSBV56XVDINPMmvMkAFpy8+EyMeuDKAEPM0E7Dab+GTu5
         93GRqxXv/0BwXCXOnLsSKd1Gy32m3GGx95wslMqvcbqdoAt6KLVyxUnyK5G7QqMlgoJB
         KTHh8m5y24oepm17LsJcJRoiSJ9EWhXXjUDf9woiDtWcsqkF8wThcKyCqlpJ/W4viW1P
         /AnjaCPYsb97q6ixNGzJ1AEI6V4gIx5t5o4cCnRMjfCO1hm+KUdE/MA9DBlOPKeTwTA0
         mHBGoRcc0jP7ZHfBeF2UW0PqvOy8dbOJ4f7Qz+SpyeT2NeBJ66W+sMCgkBs5hXMu08sN
         XRrw==
X-Gm-Message-State: AOJu0Yx0aVLnqSuOwW6sogzy7LIVnl5QGqxuQ7VDIOi2kCrzxhWfS+L9
	dOjUUzoQu1AHy1VNkd8H+1rfzI1RMfpmnRNs0es=
X-Google-Smtp-Source: AGHT+IEQRGRF5nvWrjxXfEGtm15kh9H0lNY8Rthoy64xk0jPRWIg20xykSPP6T/ww8c2kWzq33udXAnpjkj7vrW2OME=
X-Received: by 2002:a05:6820:220d:b0:58d:5302:5b18 with SMTP id
 cj13-20020a056820220d00b0058d53025b18mr10519759oob.1.1702326057573; Mon, 11
 Dec 2023 12:20:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208002342.367117-1-qyousef@layalina.io> <20231208002342.367117-8-qyousef@layalina.io>
 <CAJZ5v0iYUY-LrL3LNdMqxyMntBij_pkpETB2esYPraPekqtbhw@mail.gmail.com> <20231210204032.fficzltp2gq66pne@airbuntu>
In-Reply-To: <20231210204032.fficzltp2gq66pne@airbuntu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Dec 2023 21:20:46 +0100
Message-ID: <CAJZ5v0iKwcwkUBYaKkSkz0sPoHxrG_5pD295v_Z0jFDhR4FRFA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] sched/schedutil: Add a new tunable to dictate
 response time
To: Qais Yousef <qyousef@layalina.io>, Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>, 
	Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 9:40=E2=80=AFPM Qais Yousef <qyousef@layalina.io> w=
rote:
>
> On 12/08/23 19:06, Rafael J. Wysocki wrote:
> > On Fri, Dec 8, 2023 at 1:24=E2=80=AFAM Qais Yousef <qyousef@layalina.io=
> wrote:
> > >
> > > The new tunable, response_time_ms,  allow us to speed up or slow down
> > > the response time of the policy to meet the perf, power and thermal
> > > characteristic desired by the user/sysadmin. There's no single univer=
sal
> > > trade-off that we can apply for all systems even if they use the same
> > > SoC. The form factor of the system, the dominant use case, and in cas=
e
> > > of battery powered systems, the size of the battery and presence or
> > > absence of active cooling can play a big role on what would be best t=
o
> > > use.
> > >
> > > The new tunable provides sensible defaults, but yet gives the power t=
o
> > > control the response time to the user/sysadmin, if they wish to.
> > >
> > > This tunable is applied before we apply the DVFS headroom.
> > >
> > > The default behavior of applying 1.25 headroom can be re-instated eas=
ily
> > > now. But we continue to keep the min required headroom to overcome
> > > hardware limitation in its speed to change DVFS. And any additional
> > > headroom to speed things up must be applied by userspace to match the=
ir
> > > expectation for best perf/watt as it dictates a type of policy that w=
ill
> > > be better for some systems, but worse for others.
> > >
> > > There's a whitespace clean up included in sugov_start().
> > >
> > > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> >
> > I thought that there was an agreement to avoid adding any new tunables
> > to schedutil.
>
> Oh. I didn't know that.
>
> What alternatives do we have? I couldn't see how can we universally make =
the
> response work for every possible system (not just SoC, but different plat=
forms
> with same SoC even) and workloads. We see big power saving with no or lit=
tle
> perf impact on many workloads when not applying the current 125%. Others =
want
> to push it faster under gaming scenarios etc to get more stable FPS.
>
> Hopefully uclamp will make the need for this tuning obsolete over time. B=
ut
> until userspace gains critical mass; I can't see how we can know best
> trade-offs for all myriads of use cases/systems.
>
> Some are happy to gain more perf and lose power. Others prefer to save po=
wer
> over perf. DVFS response time plays a critical role in this trade-off and=
 I'm
> not sure how we can crystal ball it without delegating.

I understand the motivation, but counter-arguments are based on the
experience with the cpufreq governors predating schedutil, especially
ondemand.  Namely, at one point people focused on adjusting all of the
governor tunables to their needs without contributing any code or even
insights back, so when schedutil was introduced, a decision was made
to reduce the tunability to a minimum (preferably no tunables at all,
but it turned out to be hard to avoid the one tunable existing today).
Peter was involved in those discussions and I think that the point
made then is still valid.

The headroom formula was based on the observation that it would be a
good idea to have some headroom in the majority of cases and on the
balance between the simplicity of computation and general suitability.

Of course, it is hard to devise a single value that will work for
everyone, but tunables complicate things from the maintenance
perspective.  For example, the more tunables there are, the harder it
is to make changes without altering the behavior in ways that will
break someone's setup.


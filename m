Return-Path: <linux-pm+bounces-37381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61131C3275A
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 18:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EA24606BD
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 17:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4186C32F75A;
	Tue,  4 Nov 2025 17:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfVCOmmQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD60265CAD
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278835; cv=none; b=tvt7GOPgwE9iLMq+5fnoHVQ7+GFZqsDleDcuqqcH+hyTv8dhDl5VMz2JulJK1mCnmQu5T2KA/PqTwhr+AXw7NMmwuiWNdiQKGoMDktUg1Gve3tJltauWvV2ljdU+w+a+Y5AF94KMMlaF/aDibNsBttwWX7+kwJtL/WHpFxRX7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278835; c=relaxed/simple;
	bh=4hzRU6ss8U4fWqin9nFCaI1qV2IBedG+xi67mTxhfaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TiZMjo6H3X8+YShTTEN98272pFAzJfEr82dfBGfWnwAiVSo2pXnoKl19BZ3Dx6ZyEqxtOv98LgjcCvtmlztmUbuJV7S7/35Ce34nTHrUlIQ0ddUY13n1TZygDasg/BMYwDiHY+9J7vQdyArkMTcF7GQSvi/lEXdy/OcIajA7lwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfVCOmmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC07C2BC86
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 17:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762278834;
	bh=4hzRU6ss8U4fWqin9nFCaI1qV2IBedG+xi67mTxhfaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hfVCOmmQP9my7tztW2X3uNkkzAMrEXVQLAhzZEqQ4wwo83P9U/3qgh8fcVVf5buN2
	 2GnXS/+AXcvUq1cefO3FtsMeAbSyQRBNPoquZQMxSKtLKwMUx0mwR2S2T4F2CwHvJm
	 coYCaalAZ9E9farbt951E7ZJMc8Qouvps76C9gCYB9JVJVcDBWW3W6a1yk3HSM6MUZ
	 bvbnx1A5doYxaInpx7KzlBcxkgBDgTOncWtnp7kB02Yis9//ep4UMtwZn4xpq1vTQp
	 q36gkwI9QnxfOEUXsufWXGdS+QA8DOSU/pOcr9IT1AlslwRImihnO1QBz6u+Ikq5kP
	 jV7fZXn0XxT6A==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-44fe3f9c5easo144937b6e.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 09:53:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXLkzx5lsRjJ2WKFwu+2D/9BG6rIPaHc58L83uvIKEVe246lJR2dXwy84B1RMfy5BCYpfSWnSjn8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl96kV9TFPdpTmbdQYIxcEypkyg++296TpdY1cJ+qX6ulmczpE
	zjbnSh4AaVMTyCJcYu0IR/DqFpNVTm3TpC9mDjFrODn2HpZMgd8AXrZzoUJjQcITH9fZDIRB6N3
	mS/NHpZ8Mj0R2eL9KX1F2kGswk+MGGOI=
X-Google-Smtp-Source: AGHT+IGFLqkcQhOUrzEwptPqwx82pkPWkJsPcVzdUWOMk7xclq7T/jTZ1hHNBQ3utDZS0Ipkng83GkWOb8pRiRw79ew=
X-Received: by 2002:a05:6808:4f6b:b0:438:40c3:8765 with SMTP id
 5614622812f47-44fed10da20mr141549b6e.0.1762278833950; Tue, 04 Nov 2025
 09:53:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-3-ulf.hansson@linaro.org> <7h1pmik3w9.fsf@baylibre.com>
 <CAPDyKFr1bC1=3psegT0DM0tPQaCUm1DoOxV3xBa-gVV6oSuRVA@mail.gmail.com>
 <CAJZ5v0gfd+nvvkthtjtKgw22kek02K68rOLYTy=a39D0uZYpMw@mail.gmail.com> <CAPDyKFrgJf05H8S8_p9+w3V3ND7NPpHSU=bpEBk75-goO+FUjA@mail.gmail.com>
In-Reply-To: <CAPDyKFrgJf05H8S8_p9+w3V3ND7NPpHSU=bpEBk75-goO+FUjA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 4 Nov 2025 18:53:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hbpKBd7jFJKPG80o3TAgXSX9JZ5cCALkTu055VgDnMww@mail.gmail.com>
X-Gm-Features: AWmQ_blgBgFORxei_JYnBfMjTHZJZd9ppgNZnqJJz09mTdSEqIPO8xPE-u6TFh4
Message-ID: <CAJZ5v0hbpKBd7jFJKPG80o3TAgXSX9JZ5cCALkTu055VgDnMww@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] pmdomain: Respect the CPU system-wakeup QoS limit
 during s2idle
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@baylibre.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:52=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Tue, 4 Nov 2025 at 17:37, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Nov 4, 2025 at 5:10=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> > >
> > > On Sat, 1 Nov 2025 at 01:11, Kevin Hilman <khilman@baylibre.com> wrot=
e:
> > > >
> > > > Ulf Hansson <ulf.hansson@linaro.org> writes:
> > > >
> > > > > A CPU system-wakeup QoS limit may have been requested by user-spa=
ce. To
> > > > > avoid breaking this constraint when entering a low-power state du=
ring
> > > > > s2idle through genpd, let's extend the corresponding genpd govern=
or for
> > > > > CPUs. More precisely, during s2idle let the genpd governor select=
 a
> > > > > suitable low-power state, by taking into account the QoS limit.
> > > >
> > > > In addition to a QoS limit requested by userspace, shouldn't any
> > > > per-device QoS limits from devices in the PM domain with CPUs/clust=
ers
> > > > also be considered?
> > > >
> > > > Right now, if a device is in a PM domain that also contains CPUs, a=
ny
> > > > per-device QoS constraints for those devices should also impact the
> > > > state chosen by s2idle.
> > >
> > > I am not so sure about that. The existing dev PM QoS latency is
> > > targeted towards runtime suspend of a device and the genpd governor
> > > also takes it into account for this use case.
> > >
> > > If we would start to take the same dev PM QoS latency constraint into
> > > account for system suspend (s2idle), it may not be what the user
> > > really intended. Instead, I think we should consider extending the de=
v
> > > PM QoS interface, to allow the user to set a specific latency limit
> > > for system wakeup. Then the genpd governor should take that into
> > > account for s2idle.
> > >
> > > >
> > > > I just tried a quick hack of extending you cpu_system_power_down_ok=
()
> > > > function to look for any per-device QoS constraints set all devices=
 in
> > > > the PM domain (and subdomains).  It takes the min of all the per-de=
vice
> > > > QoS constratins, compares it to the one from userspace, and uses th=
e min
> > > > of those to decide the genpd state.
> > > >
> > > > That has the effect I'm after, but curious what you think about the
> > > > usecase and the idea?
> > >
> > > It makes sense, but as stated above, I think we need a new QoS limit
> > > specific for system suspend.
> > >
> > > Rafael, what's your thoughts around this?
> >
> > Well, it's analogous to the CPU latency limit case, so if a new
> > "system suspend" QoS limit is introduced for CPUs, that also needs to
> > be done for the other devices.
>
> Agreed!
>
> >
> > However, as in the CPU case, my personal view is that the "system
> > suspend" latency limits should be greater than or equal to the
> > corresponding latency limits for runtime PM.
>
> Right, we should treat general devices similar to CPUs.
>
> >
> > One more thing that has just occurred to me is that there are systems
> > in which I don't want to enable the "system suspend" limits at all.
> > IOW, all of this needs to be disabled unless the platform opts in.
>
> Okay. So are you thinking of using a Kconfig for this or better to
> manage this in runtime?

Hmm, Kconfig might be a good fit because, for instance, I don't quite
see how this can be made to generally work on x86 except for some
corner cases.


Return-Path: <linux-pm+bounces-1117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D8A8123D6
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 01:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090301C20F78
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 00:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DDA377;
	Thu, 14 Dec 2023 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WtsnaCHo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2B1DD
	for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 16:21:25 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso2654a12.1
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 16:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702513284; x=1703118084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Dk44llL5frLVzJ7EOB7jUdTH7K6htN00csZRzwZRwE=;
        b=WtsnaCHoTyReGu2bxDzxyW6L5s1tBTROuBtPlG+f+j25NZTYn03J9fsoLlxDLtyaon
         9tDfqZLnB4m3PMpKFFTvnsTALweVwNNRwKsFkc/A/7SADMD/YGvaulIMgz06tOiXh8IF
         +ZQLVEIBLgr96WcWNnRs2pz5Dw0l4jRxM+8SDQMTseQELC2/TPEP/AS1d+vU3F+zHt21
         YdysYfL4QoGW1BuIYE0MnOwgEFFbtecx1jMXgImBEz+1jyKCB42jjHNUv2SWrKCe9C0H
         NfnDc4WG7c28w3KyAYpy91A5NCco/xerIj/sru1Mzcg5yjcKpZji2egSlGDSSlxv/bOw
         9MSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702513284; x=1703118084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Dk44llL5frLVzJ7EOB7jUdTH7K6htN00csZRzwZRwE=;
        b=wln0k7sWExtEPl2PjrW+wRUv3YT9INxDkLgvrGlKpW4ZnFit/rO38jK6PDzX5ipdlA
         itpquWH9hElw2aV3UrWGlOGhHhoQRFVoCDh7+NJa0qe4URmYVt4+/BN7mkdVOe/O/EV3
         VmeqjkG+OiC8Vur/wcwqXbgLqPr5agaUWU14wFivy3Xg6K4ArBn+vWvU7618vEA8t5pM
         935FlVs15QaaM1p6EzRis+fEPY2oqzKnSI6GWo7DF9u4XIU64jZLdVWCv6IBuwTzF2s4
         unlpsBIRFahKZ8NZxMNE33k4i49RxJiypoN5oZf+x7V9ucVOqRE3CUZk9VmJJk/pcvDX
         925w==
X-Gm-Message-State: AOJu0Yz8JS8pfqqVT658hdOXRIfZXkUuYqqg8pPPzmPRL+ch+3uQ4+no
	/P0VEWEfCUo1pqM1Ww/wRiDscmxw/5D1Km+Ijf3o2A==
X-Google-Smtp-Source: AGHT+IEIT2VmjyL/LDfNdthG/hfkLrrnyXPBdJ6+AXpBgT/UA/QT5nlYmVafbKBZNmUv0L3OFNrnwWuuiDbgcsUr894=
X-Received: by 2002:a50:ccde:0:b0:54c:384b:e423 with SMTP id
 b30-20020a50ccde000000b0054c384be423mr543462edj.5.1702513284297; Wed, 13 Dec
 2023 16:21:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120234015.3273143-1-radusolea@google.com>
 <9d1009d9-b95b-4152-841f-19470a17ba97@linaro.org> <CAPpbzyhEkqjA0Kv=f_O1hy-dT8o-O4tPB_KpQqbE9b7vwC+2NA@mail.gmail.com>
 <570c9777-3d89-4f3c-b856-3e821883a7e2@linaro.org> <CAPpbzyiZmxhfQDOukEeuDv+B6j3CH43ugx_WyAvR3B-riRZChQ@mail.gmail.com>
 <0412fada-037d-47ea-bc3a-4634d134232c@linaro.org>
In-Reply-To: <0412fada-037d-47ea-bc3a-4634d134232c@linaro.org>
From: Radu Solea <radusolea@google.com>
Date: Wed, 13 Dec 2023 16:21:13 -0800
Message-ID: <CAPpbzyiUEc0_5mDOWGQyXGbN4J4x8PHHBVRRUq4bSmqFdp4XtQ@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] thermal core: add option to run PM_POST_SUSPEND asynchronously
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 11:00=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 12/12/2023 00:25, Radu Solea wrote:
> > On Wed, Dec 6, 2023 at 3:23=E2=80=AFAM Daniel Lezcano <daniel.lezcano@l=
inaro.org> wrote:
> >>
> >>
> >> Hi Radu,
> >>
> >> On 06/12/2023 02:20, Radu Solea wrote:
> >>> On Wed, Nov 29, 2023 at 4:20=E2=80=AFAM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>> On 21/11/2023 00:40, Radu Solea wrote:
> >>>>> Some thermal zones are bus connected and slow to resume, thus
> >>>>> delaying actions which depend on completion of PM_POST_SUSPEND.
> >>>>> Add optional execution path to resume thermal zones on the system
> >>>>> unbounded workqueue.
> >>>>>
> >>>>> Signed-off-by: Radu Solea <radusolea@google.com>
> >>>>> ---
> >>>>
> >>>> This async change may have a lot of hidden implications.
> >>>>
> >>>> Could you elaborate more the issue and how the async will fix the pr=
oblem?
> >>>>
> >>>> If you have a platform being slow to resume, can you provide numbers
> >>>> with and without this option?
> >>>>
> >>>> Thanks
> >>>>      -- D.
> >>>>
> >>>> --
> >>>> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software f=
or ARM SoCs
> >>>>
> >>>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >>>> <http://twitter.com/#!/linaroorg> Twitter |
> >>>> <http://www.linaro.org/linaro-blog/> Blog
> >>>>
> >>>
> >>> In multicore systems PM_POST_SUSPEND is executed on a single core.
> >>> Any work done in the notification chain delays all subsequent actions
> >>> in the chain with respect to system time, including the completion of
> >>> the write() to /sys/power/state.
> >>> I didn't include numbers from my system since they are likely
> >>> irrelevant for other systems out there. The particular number I'm
> >>> chasing is ~50ms.
> >>> This comes from having on-board peripherals as thermal zones, they
> >>> execute async and significantly slower than the main core, add a/d
> >>> conversions and bus delays to that and it's easy to see those numbers=
.
> >>> Making the entire sequence synchronous to itself and async to
> >>> PM_POST_SUSPEND isn't that much of a change, it allows the sequence t=
o
> >>> run on any core with spare cycles delayed with whatever the system
> >>> unbounded queue load is at the time.
> >>> (on my target system) I've seen consistent time gains (those same
> >>> 50ms) to PM_POST_SUSPEND completion with this sequence actually
> >>> completing before the chain finishes, this will vary from integration
> >>> to integration.
> >>
> >> Sorry but I don't see how you can have a gain of 50ms by doing the
> >> restore asynchronously.
> >>
> >> Can you give a more detailed description of the hardware? How many
> >> thermal zones?
> >>
> >>
> > I can't go into much detail about the hardware. But let's put it this
> > way, if thermal_zone_device_update() takes 5 ms for each device (read
> > temp, get trips, set trips, etc). Assume 5 onboard thermal zones, on a
> > good day, ignoring system churn you'd get to around 25ms (already
> > significant).
> > Now on top of that add that these devices have multiple functions,
> > like a PMIC for example. The resume sequence is the perfect time frame
> > where you'd encounter more than one operation aimed at any one of
> > these devices. Unless you have uncommonly smart drivers and devices,
> > these will be queued.
> > The driver in most cases will spin (hardly ideal, but realistic), even
> > if they would yield the effect on the completion of the chain is at
> > least the same or, likely, worse.
> >
> > To the patch itself, I realized I've been somewhat hamfisted.
> > thermal_zone_device_init() should not be deferred, and likely should
> > execute for all zones before the in_suspend lock-out is released. I'll
> > correct that once we've landed on something.
> >
> > To my 50ms, it's almost the worst-case, but it happens way more often
> > than would be comfortable.
>
> If you call monitor_thermal_zone() instead of
> thermal_zone_device_update(), does it speed up the resume time ?
>
Looks like it does, I'll rework the patch. Don't think the config
switch is useful anymore.
>
> >> --
> >> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs
> >>
> >> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >> <http://twitter.com/#!/linaroorg> Twitter |
> >> <http://www.linaro.org/linaro-blog/> Blog
> >>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>


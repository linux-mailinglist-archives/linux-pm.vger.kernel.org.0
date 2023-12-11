Return-Path: <linux-pm+bounces-923-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E004480DF6E
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 00:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43458B20F9E
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 23:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A7356751;
	Mon, 11 Dec 2023 23:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JPSAzeXD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E086D2
	for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2023 15:25:27 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so5067a12.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2023 15:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702337126; x=1702941926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X66+QcAEOG9iJe3K8i1JCw/eDlEUqo8fzha7bTT/SxA=;
        b=JPSAzeXDr7Hg+mbZB/9W2Igr1bRlsVPQ2Yh29UE7mw7R81fTxntzTlJkeq60D/hbuk
         ZBt+exIG9RWZf/PnltldFzoxMSn4FYFOYt7bRHAB8/qD7M0k84EOyUiDnpVnbLsj0gsM
         JetBpfnLsGEQSk3dySMcP0/XmSOcGOBALAMCtTVBE/OovDBFIwuUYQkYMy79GP4Kzdcm
         rXPCGt44a0l6QxYmXapHZh9l9RZY+qfKKbi48tUT5a09XAiwIHUd83CMBlWlOzS9OQ42
         tkRs1WX1xm7UMEM69ygAXn2uy0ZTfMKRSb2G4XMfNO6ZL8vF7Ped3MhZYjGu0aTzweyL
         XGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702337126; x=1702941926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X66+QcAEOG9iJe3K8i1JCw/eDlEUqo8fzha7bTT/SxA=;
        b=EDTgTQGbGe2fQGsCwHj/d6lSmIKEkvsQ5yILe4y+RCtuaTb4pHxEZXvHM3a4HO8u2Y
         5xUR2K5z3/j8pDX2WSW8FhFIP+dpdbUWijBjotgAixQWeIOha5n5xREMTnf2RL0RvIv/
         xvBgkSfRYWDtpF7VAogfbsgYkI9EAZajqconef2AbxhizchCGm7jA0XJac00ybfh4LKa
         C57sf/233tK9bKNM7JVKBIzyXgsLB+0Osr2kcv1sf1dNn3jR44Fgl1NCFcAk48zLxTF2
         WttnTRgfnE8aLf1KUUq2BsEjds6KhWKcibXZE5eU4gn7f8TfxpGtJIx4wM+C3DPW/VfU
         +23A==
X-Gm-Message-State: AOJu0YwFI+pIdd3e30FE+kgBuT8j2zElWFcN8wDbN4ipklDJnU0/YOni
	WLTE9AVNRnuC55+0TtgH93XAmqFapOHYNNd7IysMMg==
X-Google-Smtp-Source: AGHT+IFlzHo0ZdGVF0+Jg+5TDIxODfS7REgVEx33a3f+YWyFDho/oy0q/PNEz5jk272uI5RsepaAKEdEFmEkvRXtWho=
X-Received: by 2002:a50:f618:0:b0:54b:8f42:e3dc with SMTP id
 c24-20020a50f618000000b0054b8f42e3dcmr301144edn.2.1702337125881; Mon, 11 Dec
 2023 15:25:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120234015.3273143-1-radusolea@google.com>
 <9d1009d9-b95b-4152-841f-19470a17ba97@linaro.org> <CAPpbzyhEkqjA0Kv=f_O1hy-dT8o-O4tPB_KpQqbE9b7vwC+2NA@mail.gmail.com>
 <570c9777-3d89-4f3c-b856-3e821883a7e2@linaro.org>
In-Reply-To: <570c9777-3d89-4f3c-b856-3e821883a7e2@linaro.org>
From: Radu Solea <radusolea@google.com>
Date: Mon, 11 Dec 2023 15:25:14 -0800
Message-ID: <CAPpbzyiZmxhfQDOukEeuDv+B6j3CH43ugx_WyAvR3B-riRZChQ@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] thermal core: add option to run PM_POST_SUSPEND asynchronously
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 3:23=E2=80=AFAM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
>
> Hi Radu,
>
> On 06/12/2023 02:20, Radu Solea wrote:
> > On Wed, Nov 29, 2023 at 4:20=E2=80=AFAM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 21/11/2023 00:40, Radu Solea wrote:
> >>> Some thermal zones are bus connected and slow to resume, thus
> >>> delaying actions which depend on completion of PM_POST_SUSPEND.
> >>> Add optional execution path to resume thermal zones on the system
> >>> unbounded workqueue.
> >>>
> >>> Signed-off-by: Radu Solea <radusolea@google.com>
> >>> ---
> >>
> >> This async change may have a lot of hidden implications.
> >>
> >> Could you elaborate more the issue and how the async will fix the prob=
lem?
> >>
> >> If you have a platform being slow to resume, can you provide numbers
> >> with and without this option?
> >>
> >> Thanks
> >>     -- D.
> >>
> >> --
> >> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs
> >>
> >> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >> <http://twitter.com/#!/linaroorg> Twitter |
> >> <http://www.linaro.org/linaro-blog/> Blog
> >>
> >
> > In multicore systems PM_POST_SUSPEND is executed on a single core.
> > Any work done in the notification chain delays all subsequent actions
> > in the chain with respect to system time, including the completion of
> > the write() to /sys/power/state.
> > I didn't include numbers from my system since they are likely
> > irrelevant for other systems out there. The particular number I'm
> > chasing is ~50ms.
> > This comes from having on-board peripherals as thermal zones, they
> > execute async and significantly slower than the main core, add a/d
> > conversions and bus delays to that and it's easy to see those numbers.
> > Making the entire sequence synchronous to itself and async to
> > PM_POST_SUSPEND isn't that much of a change, it allows the sequence to
> > run on any core with spare cycles delayed with whatever the system
> > unbounded queue load is at the time.
> > (on my target system) I've seen consistent time gains (those same
> > 50ms) to PM_POST_SUSPEND completion with this sequence actually
> > completing before the chain finishes, this will vary from integration
> > to integration.
>
> Sorry but I don't see how you can have a gain of 50ms by doing the
> restore asynchronously.
>
> Can you give a more detailed description of the hardware? How many
> thermal zones?
>
>
I can't go into much detail about the hardware. But let's put it this
way, if thermal_zone_device_update() takes 5 ms for each device (read
temp, get trips, set trips, etc). Assume 5 onboard thermal zones, on a
good day, ignoring system churn you'd get to around 25ms (already
significant).
Now on top of that add that these devices have multiple functions,
like a PMIC for example. The resume sequence is the perfect time frame
where you'd encounter more than one operation aimed at any one of
these devices. Unless you have uncommonly smart drivers and devices,
these will be queued.
The driver in most cases will spin (hardly ideal, but realistic), even
if they would yield the effect on the completion of the chain is at
least the same or, likely, worse.

To the patch itself, I realized I've been somewhat hamfisted.
thermal_zone_device_init() should not be deferred, and likely should
execute for all zones before the in_suspend lock-out is released. I'll
correct that once we've landed on something.

To my 50ms, it's almost the worst-case, but it happens way more often
than would be comfortable.

>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>


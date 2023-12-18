Return-Path: <linux-pm+bounces-1322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31A4817AC3
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 20:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BCAE286641
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 19:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700BB49899;
	Mon, 18 Dec 2023 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3zWuQXFQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF23A4FF9A
	for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-552eaf800abso2043a12.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 11:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702926897; x=1703531697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNpYr419SHpnA91LgqU+sPKJUI14VGiXGrBhdYoDPNA=;
        b=3zWuQXFQ/ECQgRLlCHw035sI4O+1XZuFWUaBpkUcwMwRq+6c/97qJOzoNtAmDM8vzJ
         L287eanCCTfycXAFxZkPVrDIwRl0hdcL6TNyUT1hK/nt+lEdXyUwZW5g3To4paLbZzNo
         BrwAe/R3LGXZFI3yng0DrrcZdECCH+nYu9DAjFYr7O0QeRRAAzOZE9uS8rshVBNpNM2E
         XgY+dlU5cRLtJt/WIuM1/MHFxm7lXIXyAIoVIyszBHQXLYGF8OSK7KsKO42dD6JId7tW
         Xer59Q5V/wtcUTOawWCIWRKdTAXa+k2j5zHXZ8qYnw7yYdFpkvR7i07nNBzwuDitrFWY
         xH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702926897; x=1703531697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNpYr419SHpnA91LgqU+sPKJUI14VGiXGrBhdYoDPNA=;
        b=E/anwXkqR4cPwolxkOImXoCTxCT3x02tULvVTRuVP4KV7EZRZMD42BkPHVr3OmMrOB
         Bst92Xt3qtpoOMa0N9+Omz69T8wchFYgBzMhTNDmwY/2UM/Lb1lZsM552pKtFAm3EUz6
         5LP16DIRPJnmrF2aStH+frYvrimLR5KhbMPzEIrFRBs0NDiJCtCiRYMVzFiMtLSipTk5
         f8PSqwQWBZhE70KD4e2ey9QTJqKB2IiBqlccPgKxLPWrvnY2zwioEjXwCS9YIRsC2vDm
         IumpW0gSTJvgxn2IABVMiNUDs2MZpRIfXFrABFtbtc6Vnrz1QkxyuyHPF7qVEKzuOEfb
         vIeQ==
X-Gm-Message-State: AOJu0Yy8YOa2aeqNo3jJGT9psyCZ6l9NNZxsGURRwplAoJORgNjXJlXY
	jwIEC3rP9GAVAgTK/DmwNHoD0rKicH/X374sQWBLYBiD62Fg
X-Google-Smtp-Source: AGHT+IEkv8jZZJriA4wx0GJWunIvhpMmkRJZ+mRaAkxemnVSlrPj6+RAhRBwC1SC7sKbW+h9EDGaGgBGf0f6CcAl7ZQ=
X-Received: by 2002:a05:6402:1c98:b0:553:7668:506 with SMTP id
 cy24-20020a0564021c9800b0055376680506mr23139edb.5.1702926896901; Mon, 18 Dec
 2023 11:14:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120234015.3273143-1-radusolea@google.com>
 <9d1009d9-b95b-4152-841f-19470a17ba97@linaro.org> <CAPpbzyhEkqjA0Kv=f_O1hy-dT8o-O4tPB_KpQqbE9b7vwC+2NA@mail.gmail.com>
 <570c9777-3d89-4f3c-b856-3e821883a7e2@linaro.org> <CAPpbzyiZmxhfQDOukEeuDv+B6j3CH43ugx_WyAvR3B-riRZChQ@mail.gmail.com>
 <0412fada-037d-47ea-bc3a-4634d134232c@linaro.org> <CAPpbzyiUEc0_5mDOWGQyXGbN4J4x8PHHBVRRUq4bSmqFdp4XtQ@mail.gmail.com>
 <b5d75de8-2006-40fa-add7-2db59f3e6cc4@linaro.org> <CAPpbzygHs7Z2S9TJ7vwmhZUtRqfCnxAwFdRRG4q37yetNCPWMQ@mail.gmail.com>
In-Reply-To: <CAPpbzygHs7Z2S9TJ7vwmhZUtRqfCnxAwFdRRG4q37yetNCPWMQ@mail.gmail.com>
From: Radu Solea <radusolea@google.com>
Date: Mon, 18 Dec 2023 11:14:45 -0800
Message-ID: <CAPpbzyjfXM06UwRHLVX665nphpH4_-rwXYFDpyh-pxC7f-ui-A@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] thermal core: add option to run PM_POST_SUSPEND asynchronously
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 10:26=E2=80=AFAM Radu Solea <radusolea@google.com> =
wrote:
>
> On Thu, Dec 14, 2023 at 12:25=E2=80=AFAM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 14/12/2023 01:21, Radu Solea wrote:
> >
> > [ ... ]
> >
> > >>> I can't go into much detail about the hardware. But let's put it th=
is
> > >>> way, if thermal_zone_device_update() takes 5 ms for each device (re=
ad
> > >>> temp, get trips, set trips, etc). Assume 5 onboard thermal zones, o=
n a
> > >>> good day, ignoring system churn you'd get to around 25ms (already
> > >>> significant).
> > >>> Now on top of that add that these devices have multiple functions,
> > >>> like a PMIC for example. The resume sequence is the perfect time fr=
ame
> > >>> where you'd encounter more than one operation aimed at any one of
> > >>> these devices. Unless you have uncommonly smart drivers and devices=
,
> > >>> these will be queued.
> > >>> The driver in most cases will spin (hardly ideal, but realistic), e=
ven
> > >>> if they would yield the effect on the completion of the chain is at
> > >>> least the same or, likely, worse.
> > >>>
> > >>> To the patch itself, I realized I've been somewhat hamfisted.
> > >>> thermal_zone_device_init() should not be deferred, and likely shoul=
d
> > >>> execute for all zones before the in_suspend lock-out is released. I=
'll
> > >>> correct that once we've landed on something.
> > >>>
> > >>> To my 50ms, it's almost the worst-case, but it happens way more oft=
en
> > >>> than would be comfortable.
> > >>
> > >> If you call monitor_thermal_zone() instead of
> > >> thermal_zone_device_update(), does it speed up the resume time ?
> > >>
> > > Looks like it does, I'll rework the patch. Don't think the config
> > > switch is useful anymore.
> >
> > Well, we probably have to go a bit further in the concept.
> >
> > There are some thermal zones which may need to be checked immediately
> > and others no. That depends on the temperature speed behavior.
> >
> > The higher is the temperature speed for a device, the lower is the
> > polling (including zero).
> >
> > So the monitoring delay can be used as a criteria to check if the
> > thermal zone needs an update or postpone the monitoring.
> >
> > As we don't want to change the current behavior, we can add a global
> > option telling the polling delay above which we call
> > monitor_thermal_zone() and defaulting to zero.
> >
> > Does it make sense?
> It does, alternatively we add a device tree flag to the tz and not add
> a side effect to the delay.
> Either works imo.
>
On a second, more careful look, I don't think using polling-delay is
going to work as expected here. A 0 delay is used for interrupt-driven
systems. thermal_zone_device_set_polling() will cancel work if the
delay is 0. So it looks like we effectively end up without a resume
update for those devices. We could reuse the delay-based approach with
a resume-specific work item so it doesn't get cancelled. On the other
hand I suspect that the threshold which we would add for async will
never move from zero.
> >
> > --
> > <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for =
ARM SoCs
> >
> > Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> > <http://twitter.com/#!/linaroorg> Twitter |
> > <http://www.linaro.org/linaro-blog/> Blog
> >


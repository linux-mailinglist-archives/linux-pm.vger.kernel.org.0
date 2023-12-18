Return-Path: <linux-pm+bounces-1327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C175E817B1A
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 20:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1471F22855
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 19:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE497144F;
	Mon, 18 Dec 2023 19:37:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E825D759
	for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-203aa9c19ceso232741fac.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 11:37:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702928239; x=1703533039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I31zxM3MjFqf3MO9vvnpXINs/bXT2+GkDNdJRS3gag4=;
        b=jaQhPWtvCXd6k2pIJ4XB3IMlMk5IefiQoZMokRVU+6UYnohWh4mbuBMR68TNkf31vk
         y2V9Jg/i30P8ZS8efWADRwgaCiSrgoDGTjGOFAKIV4mvwwsgiBKz7DMBzanV8ceFHXMF
         jC9K6UfZvBzAmSHX5Tqnmc0wNSj3wipzXCGIXsM2OfsAlQHyU96SSg9poqfWhHRXZb5V
         yVfYqZVI6fcI9yvb7y6OVDbB7okh04fO6psdt/gFl5eVIyRRJQL3RUWvm71wU/q3xgcM
         aQ+Q23PUDD/g+jga7rN62SzMXQMvn9keFUBPMhZEK+llRyW9ql7La3Q633WcIehwiw6a
         GOuw==
X-Gm-Message-State: AOJu0YyBhSnOBHBIk3gBk6dbe0Q/x++Mh7GLw4xqjb0gHH3EB8HSa4fJ
	EY1Mtzg1LnoNu2SvUBBORwuBzZ1yIdspXYbGSXci6WfqdCs=
X-Google-Smtp-Source: AGHT+IHDic3ImvGqbZEmS5V5HByvYYMKU3r0rvgPPhZWk3Sk84C4HjhbbYSoAvZHH6dzsYlz75cpls2xGANm1wJtimc=
X-Received: by 2002:a05:6870:214:b0:1ff:a3d:f750 with SMTP id
 j20-20020a056870021400b001ff0a3df750mr32842965oad.5.1702928239327; Mon, 18
 Dec 2023 11:37:19 -0800 (PST)
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
 <CAPpbzyjfXM06UwRHLVX665nphpH4_-rwXYFDpyh-pxC7f-ui-A@mail.gmail.com>
In-Reply-To: <CAPpbzyjfXM06UwRHLVX665nphpH4_-rwXYFDpyh-pxC7f-ui-A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Dec 2023 20:37:08 +0100
Message-ID: <CAJZ5v0gnv99AH+y0OYECDPe+w-f=M_mJsmGzatErAkzRoFPR2A@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] thermal core: add option to run PM_POST_SUSPEND asynchronously
To: Radu Solea <radusolea@google.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 8:15=E2=80=AFPM Radu Solea <radusolea@google.com> w=
rote:
>
> On Thu, Dec 14, 2023 at 10:26=E2=80=AFAM Radu Solea <radusolea@google.com=
> wrote:
> >
> > On Thu, Dec 14, 2023 at 12:25=E2=80=AFAM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> > >
> > > On 14/12/2023 01:21, Radu Solea wrote:
> > >
> > > [ ... ]
> > >
> > > >>> I can't go into much detail about the hardware. But let's put it =
this
> > > >>> way, if thermal_zone_device_update() takes 5 ms for each device (=
read
> > > >>> temp, get trips, set trips, etc). Assume 5 onboard thermal zones,=
 on a
> > > >>> good day, ignoring system churn you'd get to around 25ms (already
> > > >>> significant).
> > > >>> Now on top of that add that these devices have multiple functions=
,
> > > >>> like a PMIC for example. The resume sequence is the perfect time =
frame
> > > >>> where you'd encounter more than one operation aimed at any one of
> > > >>> these devices. Unless you have uncommonly smart drivers and devic=
es,
> > > >>> these will be queued.
> > > >>> The driver in most cases will spin (hardly ideal, but realistic),=
 even
> > > >>> if they would yield the effect on the completion of the chain is =
at
> > > >>> least the same or, likely, worse.
> > > >>>
> > > >>> To the patch itself, I realized I've been somewhat hamfisted.
> > > >>> thermal_zone_device_init() should not be deferred, and likely sho=
uld
> > > >>> execute for all zones before the in_suspend lock-out is released.=
 I'll
> > > >>> correct that once we've landed on something.
> > > >>>
> > > >>> To my 50ms, it's almost the worst-case, but it happens way more o=
ften
> > > >>> than would be comfortable.
> > > >>
> > > >> If you call monitor_thermal_zone() instead of
> > > >> thermal_zone_device_update(), does it speed up the resume time ?
> > > >>
> > > > Looks like it does, I'll rework the patch. Don't think the config
> > > > switch is useful anymore.
> > >
> > > Well, we probably have to go a bit further in the concept.
> > >
> > > There are some thermal zones which may need to be checked immediately
> > > and others no. That depends on the temperature speed behavior.
> > >
> > > The higher is the temperature speed for a device, the lower is the
> > > polling (including zero).
> > >
> > > So the monitoring delay can be used as a criteria to check if the
> > > thermal zone needs an update or postpone the monitoring.
> > >
> > > As we don't want to change the current behavior, we can add a global
> > > option telling the polling delay above which we call
> > > monitor_thermal_zone() and defaulting to zero.
> > >
> > > Does it make sense?
> > It does, alternatively we add a device tree flag to the tz and not add
> > a side effect to the delay.
> > Either works imo.
> >
> On a second, more careful look, I don't think using polling-delay is
> going to work as expected here. A 0 delay is used for interrupt-driven
> systems. thermal_zone_device_set_polling() will cancel work if the
> delay is 0. So it looks like we effectively end up without a resume
> update for those devices. We could reuse the delay-based approach with
> a resume-specific work item so it doesn't get cancelled. On the other
> hand I suspect that the threshold which we would add for async will
> never move from zero.

Please see https://lore.kernel.org/linux-pm/1886695.tdWV9SEqCh@kreacher/


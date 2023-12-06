Return-Path: <linux-pm+bounces-727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B27E806428
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 02:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B546E1F21725
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 01:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF24EBC;
	Wed,  6 Dec 2023 01:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qxr5YYqf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B6C109
	for <linux-pm@vger.kernel.org>; Tue,  5 Dec 2023 17:31:19 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54c79cca895so5729a12.0
        for <linux-pm@vger.kernel.org>; Tue, 05 Dec 2023 17:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701826277; x=1702431077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41Rwl3x/2TllNeIxmSP3STbN+r6kbYcCTNLj/gCvstc=;
        b=qxr5YYqfneLIGrNBGgvvNbn3hLvjav3P97Io/83AQNonAtkz9na7fMq7WrD3W4Ds7g
         SnyNPZAh7OtiqL3DlURQfL6qLAZb+53QEtXl9845Nkwsi1NdwjvMfn2+CPeZmyIDmJZ/
         DdficFvcVS0vFpuZio2injfCdCuJt4/M0EriUPHuWZ0s2NAT6zC15qceUNdQVQn0UFQC
         uyFqfRT1QZscAsEbgoFmV7nR/4JfeMX9Q6MKd292T3UfDPvhyMZbumjvO2u0uG5kcq6y
         sSi7wnF3gcbG8L57BvuanBFm8c2g0+JEISz5JWgyvNVK1telHwd6CXfigyxWi4yg3TS9
         bQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701826277; x=1702431077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41Rwl3x/2TllNeIxmSP3STbN+r6kbYcCTNLj/gCvstc=;
        b=snv8yWVdvR4zjHHIOrw+enxxrULzm3F0aMDgqv/hJAkmEGNc0qso5xxLoJJBnpR+7H
         fcHjjQ6KZt2CVGRM6AJ+aBamsq5Ujl+JfxL8OcSl/tvqJaM8HFeqZydy1l3viy3Q9FY8
         ZO/DCUicMOjO78j1EYeBhslE7p9FNNceyTL1RtVvCjvn2MYIy/eV1GpnNoy4zZbk27vc
         jejnJvKa4GbMKqxMTmyZHJX4oJtvUDZ/r3pttJ3XtK53t6jgyTFlHIMx0N1Pj48hWIIy
         FcHbnGIGiryU1djHbLdxpRH+fG49y7YMxdtTrT6PZsSFsbkAJJceEYxccAGycDk00Ilh
         Dzjg==
X-Gm-Message-State: AOJu0YzHNboZxdl5eFkVWyR03P+IDpt+qPOUw3ZgQZAqj0F54xa+gfRl
	zOMs6sQOb9IdpP5k+Wt6kkfaINdGWQka3ucQLNdmXg==
X-Google-Smtp-Source: AGHT+IHPUyyKIOpIh4hKlOlmwKZ2CgeUY/dRodSUu49fZ4S2tGD6hSYp+sdKAY51i16SDBrJgseIWz3gUmlFd7pzrQg=
X-Received: by 2002:a50:bb03:0:b0:544:466b:3b20 with SMTP id
 y3-20020a50bb03000000b00544466b3b20mr28726ede.5.1701826277296; Tue, 05 Dec
 2023 17:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120234015.3273143-1-radusolea@google.com> <CAJZ5v0jB9ObOWR5xWme--DZxFdjCYpdf9K6=KpywYxuq6F2c3Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0jB9ObOWR5xWme--DZxFdjCYpdf9K6=KpywYxuq6F2c3Q@mail.gmail.com>
From: Radu Solea <radusolea@google.com>
Date: Tue, 5 Dec 2023 17:31:06 -0800
Message-ID: <CAPpbzygvYSR6grEzwmKY3ebCRJr4aURf2zeBFhLG3F035Z4=-w@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] thermal core: add option to run PM_POST_SUSPEND asynchronously
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 5:09=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Nov 21, 2023 at 12:40=E2=80=AFAM Radu Solea <radusolea@google.com=
> wrote:
> >
> > Some thermal zones are bus connected and slow to resume, thus
> > delaying actions which depend on completion of PM_POST_SUSPEND.
>
> What actions in particular?
Anything in the PM_POST_SUSPEND chain coming after this sequence and
the completion of the write() to /sys/power/state.

>
> > Add optional execution path to resume thermal zones on the system
> > unbounded workqueue.
>
> Why optional?
I proposed the change as optional because I'm not certain I can
account for all possible system loads.
However, in the specific context of embedded devices, custom kernel
configurations are the norm and it is expected that the integration
team validates system assumptions (such as system unbounded queue
load).

>
> This is only useful for people building their own custom kernels.
>
> > Signed-off-by: Radu Solea <radusolea@google.com>
> > ---
> >  drivers/thermal/Kconfig        | 11 +++++++
> >  drivers/thermal/thermal_core.c | 58 ++++++++++++++++++++++++++++++----
> >  2 files changed, 62 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index c81a00fbca7d..148d6e9734c6 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -91,6 +91,17 @@ config THERMAL_WRITABLE_TRIPS
> >           Say 'Y' here if you would like to allow userspace tools to
> >           change trip temperatures.
> >
> > +config THERMAL_ASYNC_RESUME
> > +       bool "Thermal async init zones on system resume"
> > +       default n
> > +       help
> > +         Re-initialize thermal zones asynchronously on system resume.
> > +         Thermal zone sensors may be attached on slow buses, impacting
>
> "Slow" relative to what?  How can it be determined?
>
> > +         the duration of PM_POST_SUSPEND. If that is a concern enable
> > +         this switch.
> > +
> > +         If in doubt, say N.
> > +
> >  choice
> >         prompt "Default Thermal governor"
> >         default THERMAL_DEFAULT_GOV_STEP_WISE
>
> In the first place, I would like to know the exact motivation for this ch=
ange.
Immediate value to me is a significant reduction(within my particular
system context) in the time it takes to complete the write() to
/sys/power/state.
In general this would move the execution to the next available core
when the queue gets to the work item spreading (some of) the resume
load across cores.


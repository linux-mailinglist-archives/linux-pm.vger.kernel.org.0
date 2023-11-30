Return-Path: <linux-pm+bounces-581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022597FFC8F
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 21:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F3E1C20EC7
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 20:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7F755764;
	Thu, 30 Nov 2023 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQTSg8BV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C80D50
	for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2023 12:33:24 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54bfa9b4142so5372a12.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2023 12:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701376402; x=1701981202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JOHwWZNK5Q3e8sr71Y6XMFknuLJI2l0A7nIp7oAbrc=;
        b=IQTSg8BVmWJhlZJCVBXEFPMNxkA6ccumfOa5M4/8bY8C8wvtdw5ObK98ZPAMQol/xp
         CZ3T67QcRKTzZNKqJRbRor4KFHsBhNnJ6a1arwDDYqkFDTtePF/utgSErbNQSg7q5+tE
         HQ4ImkEKUgFAazRH0B7VEw/q+6t72t9rnHKiGlWvk/A2GWgpHSt7Nj5jxgHWmVmet+T2
         EMhiMjjoRi4gE0qtWaftEvDeSKI5FUmaQFll1GnFzLdyaWNUuPQvTagd8dEMH9sMrdfw
         I3ZlviaOQKDekDTYJIr/b8B/4nsSAXrlMou4ZVmApV8p2vEph4bxkkYEX5lVTp+PO1ik
         YCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701376402; x=1701981202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JOHwWZNK5Q3e8sr71Y6XMFknuLJI2l0A7nIp7oAbrc=;
        b=fJD0jAm6lMoLzCbSHJNKcsXoaCM4fOHWQl51VHD7Jz3I2ihJHcogQd2S/rsqqaMHp8
         edUto68+ZimVqNFd2F8xO88tfGUfevDjzRh7ScRfKrjiO/R/3/mgyKKU5ABy969Rc1Mw
         BL2kPndrcSyGhb4YCeN0RBwt4Znj43HS+xZ18KS/hlN8XmZNZXVmyOkjJQWlsb8nHEq/
         f2JPOMicGi+qxBcrjB8WxWGTkNUZhlSl04l+6B2TYnAXmpMw/ghCfZbs+6n3BcMJbYmW
         bn0a8tU+chgZTXcB781Yz3QdTP4uT5FYgBljQBu1gQ5sHCH8gvLfr+Fkb3cPXXWAtBiQ
         ABrA==
X-Gm-Message-State: AOJu0YyzujZ+MScX8YKAm1Sc9tEdvVNZeiDLuHSlzJ6licnlgeeezXC6
	Li7UyJzsYyWTOscH1iYW6cuGZdAnm6UR9fmFp8NZQQ==
X-Google-Smtp-Source: AGHT+IEXhSDbwvWGNgz65zSoTjlKPiZArP5lxKWvFh/OLzAHKPCU956/+tLGQjiV0OEh48ATJUcCbz9FY5wu9FQAlA0=
X-Received: by 2002:a50:aacf:0:b0:54b:321:ef1a with SMTP id
 r15-20020a50aacf000000b0054b0321ef1amr16022edc.6.1701376402549; Thu, 30 Nov
 2023 12:33:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120234015.3273143-1-radusolea@google.com> <CAJZ5v0jB9ObOWR5xWme--DZxFdjCYpdf9K6=KpywYxuq6F2c3Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0jB9ObOWR5xWme--DZxFdjCYpdf9K6=KpywYxuq6F2c3Q@mail.gmail.com>
From: Radu Solea <radusolea@google.com>
Date: Thu, 30 Nov 2023 12:33:11 -0800
Message-ID: <CAPpbzygYCRR1OQTXSGZATU_U0bcL1t_vMu4foPiWah0C2C3-=Q@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] thermal core: add option to run PM_POST_SUSPEND asynchronously
To: "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for taking the time to discuss this.
In the context of PM_POST_SUSPEND, there are not many guarantees. It
mainly just guarantees that the code is executed at a particular step
in the resume sequence and, implicitly, that the execution happens
before another power transition. There are no order or timing promises
made.
Doing work on the notification chain impacts at least two things
relevant to this change: triggering of the next items on the chain and
completion of the write() to /sys/power/state. In a multicore context,
both of these matter.
The system context is battery-powered embedded devices with thermal
zones on-board. These thermal zones are bus connected and operate
asynchronously to the executing core, introducing delays.
I proposed the change as optional because I cannot account for all
possible cases. However, in the specific context of these devices,
custom kernel configurations are the norm and it is expected that the
integration team validates system assumptions (such as system
unbounded queue load).
The ultimate reason for this change is that I want my 50ms back.
Joking aside, there are not many ways to determine that the system has
completed a resume cycle. The write() to /sys/power/state completing
is important in signaling that to the system at large.
I did not include numbers in the initial submission because I do not
expect that the numbers I see on a particular integration are easily
replicable in other situations. However, the 50ms I am currently
chasing are important in user-interactive systems and impact overall
power consumption.
Thank you,
Radu

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
>
> > Add optional execution path to resume thermal zones on the system
> > unbounded workqueue.
>
> Why optional?
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


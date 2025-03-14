Return-Path: <linux-pm+bounces-24008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B675A60CB0
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 10:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F58917E144
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 09:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429A21DE4D6;
	Fri, 14 Mar 2025 09:05:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863801D619D;
	Fri, 14 Mar 2025 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943102; cv=none; b=TWye5p7t/9p5UXuQ77HeVOICYXwG6VDa9CdINj35oJqVrXvXk9X5wOfwFjQjvkiGuKyuT2FysK9wbpmI41D1yD8P+pjZafv1YstejQFRUSq+dfMHnCSwbwmF2XYYY28AbzzvcqYepV1lLcVoOV4lxrIga8sHXG23xttbFjoNXbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943102; c=relaxed/simple;
	bh=nvH3uncH0bvUPmkr8rI3ncI1+kzq869QL35edx2aCwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXjBPAnYL6Vdnc8lwGZUwOVxsFUsXZBb/uviCQPis+6jPuAyGL8YMW/jQY2gZ2MOE93QnCpQhwIHPMjRjSv4lz3v0eIfSumffRpbrZybAqvYKytF8xzmFSBrUNDU81JWgJqn0OyLUF+YmBtUHK3ePTrMRosuNPTJgtsPvPEAch8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86c29c0acdfso899474241.3;
        Fri, 14 Mar 2025 02:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741943098; x=1742547898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKbt8iHgwdEIoDOURXW5r6Dn/HIhQtmrAuFwAE1RJos=;
        b=DubRuh68kb5za9dSnD1kCn4JOGqwwdwv/Dcw1IwhuXG/czaMoWGChMPWid40m5g6JX
         iVRBfcJHE0SwSB3h86bo0GMfV8LyVxUrrDn4GLA3s40aCkqYoyhHYiwxP0QTpNgq0T/j
         RZPR/PWWXBT5FbQIz65gGPINZ6iT+GhhVCMsjE4jfdKjsgd4AZywhZOytlK7h6g4hE9K
         CczZKtxRR5sWOk1X9UgGD0jBnhIWChgDwHYzlxt2xd2roUiReQVNxfhduQbluSwh90Hb
         bxoS2Mkuhz6lf1SL4q6bffI5LOhnKWVBDdJrP3tmKhm+CgNfKCMkA3llnpsV0An29kn5
         Wg8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUUjYXcIUFPG2IMqTAR/JYcI9XYufwQTZQ17hvY5WEbdUSEXs/BkErHRVToa3XKbm2IFNDUMTnEcAAclSfR+MH+XE=@vger.kernel.org, AJvYcCXmBaMxO1TtoKWnBzLfuea6AtIvg01IlutkaThPY+rWurDAzPdd+LuKU1kXK91aN5ljBkrXCRr7IA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcEh/fJAuyUNV+64yfc6vW78wn5osgaVx/Ckd3b6IB0LS35Ngr
	fuYvfBbIu5PY5bZyFB/1VHCoKWg6MDsQSLi7Zmem1QaCOys2DdUABbeeaNOcpuI=
X-Gm-Gg: ASbGncvhSnxw/QVCLhEsIMrVjszUsrUNOjGnfj9kbl5EhDg1vGYj+s+Sy9RP3JMP9rU
	apGnv+RzTmGbrcxEv5luF8RGCBx3EWBb1N65D9mb0ToIxwFnY0vGCM9TYL/L0LN4zmpKCNtg0Zs
	dhbo2nv0xjHBD45oqy5pGgaNVb4ryo8g2s78eTEoTmjtYhfdyVHSDbrlbM4P/9WXwyZJ2IrVQEd
	5tlMYmgWunwMbthdJ1b7NXA2jLBj74+QgwCOsfxolKQFvQq28I9i9ryjExHXXA69pBdnk/D3ApO
	5CT1SSAxbi1h18930fy78ackAEsAt1GbTO5L/IcySvkd+cIPJ/IEjk7mSijPwBvNj93rE7ep4Fx
	HGgq2Ylk=
X-Google-Smtp-Source: AGHT+IFh8jVDYLHsw1RJbUy9qWXtrKYXLTC16EiVEaCOXvCJ7lzORvCDrpXHgaeB9RHb3fQqqw/s5g==
X-Received: by 2002:a05:6102:5126:b0:4c1:9e65:f90b with SMTP id ada2fe7eead31-4c3831f7ae6mr740815137.17.1741943098271;
        Fri, 14 Mar 2025 02:04:58 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d90e748efsm508899241.24.2025.03.14.02.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 02:04:58 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86718c2c3b9so826150241.2;
        Fri, 14 Mar 2025 02:04:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRmEopnRIxyJl68KRQk9RVPIObslhBpzna89gymkynLeyrmOEG1bD7O51EpTLzL/3raKULirjOXw==@vger.kernel.org, AJvYcCWC1cQ6qpKVdWLO+VM1lpMnT/QOXC+7Q5eNC7E0eoc5yXEl91xRn1qd8MlcfjSxulq4bP46gXBtQB7yAdbkDuTyAc8=@vger.kernel.org
X-Received: by 2002:a05:6102:2ac8:b0:4c1:9695:c7c with SMTP id
 ada2fe7eead31-4c38322a29bmr584595137.24.1741943097598; Fri, 14 Mar 2025
 02:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdXN9A-1P_qe=BwKjLaoqxU8iJUQK6h8=s-apR4Y0em_0Q@mail.gmail.com>
 <CAMuHMdXXWH0Do5zXWJ1Uc6dyEb9o1chGSyeyzgDrX+v1wZ7e_A@mail.gmail.com>
 <CAGETcx_wA9RB9QhMPqsLHDFZ4cwOFgE8dBL9ssFkT=J6DEgjGg@mail.gmail.com>
 <CAMuHMdUCXJkg3rkngXf7cqa50u-TEAOntV6O=Nvg33Q9diPJPw@mail.gmail.com>
 <CAMuHMdWLEHwjaNnysDZ_Unqj-SwmUdwRao_oJvYvVsQ9SCn06A@mail.gmail.com>
 <CAMuHMdXcJN5M7PqJ1eABOOCfeMjvs51rMRzMxU=d2L=3LVgh_w@mail.gmail.com>
 <CAJZ5v0jKOeZxzUXu9bHA4=SDio1FT3ZmfoOGqNNZO2+DN+U21Q@mail.gmail.com> <CAJZ5v0iJqUGX8cL2ZEm3420VMP0nWY2rPwCNsLLCs+sCaDDtbQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iJqUGX8cL2ZEm3420VMP0nWY2rPwCNsLLCs+sCaDDtbQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Mar 2025 10:04:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVTbf60gk-sfyHME6Xi_9wiW_VNvgsH0+Uy54WWpg4jiw@mail.gmail.com>
X-Gm-Features: AQ5f1JrKtr8q2avG9v70wyHagbS1NGd5KOIiQj7W2tyN_HZ61QF50EafRHY3vbk
Message-ID: <CAMuHMdVTbf60gk-sfyHME6Xi_9wiW_VNvgsH0+Uy54WWpg4jiw@mail.gmail.com>
Subject: Re: s2idle blocked on dev->power.completion
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, 
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
	Linux PM list <linux-pm@vger.kernel.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

On Thu, 13 Mar 2025 at 18:35, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Mar 13, 2025 at 6:27=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> > On Thu, Mar 13, 2025 at 5:48=E2=80=AFPM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > On Thu, 13 Mar 2025 at 15:32, Geert Uytterhoeven <geert@linux-m68k.or=
g> wrote:
> > > > On Thu, 13 Feb 2025 at 11:26, Geert Uytterhoeven <geert@linux-m68k.=
org> wrote:
> > > > > On Thu, 13 Feb 2025 at 09:31, Saravana Kannan <saravanak@google.c=
om> wrote:
> > > > > > On Mon, Feb 10, 2025 at 2:24=E2=80=AFAM Geert Uytterhoeven <gee=
rt@linux-m68k.org> wrote:
> > > > > > > On Fri, 7 Feb 2025 at 16:08, Geert Uytterhoeven <geert@linux-=
m68k.org> wrote:
> > > > > > > > Instrumenting all dev->power.completion accesses in
> > > > > > > > drivers/base/power/main.c reveals that resume is blocked in=
 dpm_wait()
> > > > > > > > in the call to wait_for_completion() for regulator-1p2v, wh=
ich is
> > > > > > > > indeed a dependency for the SN65DSI86 DSI-DP bridge.  Compa=
ring
> > > > > > >
> > > > > > > [...]
> > > > > > >
> > > > > > > > Looking at /sys/devices/virtual/devlink, the non-working ca=
se has the
> > > > > > > > following extra entries:
> > > > > > >
> > > > > > > Note that the SN65DSI86 DSI-DP bridge driver uses the auxilia=
ry bus
> > > > > > > to create four subdevices:
> > > > > > >   - ti_sn65dsi86.aux.0,
> > > > > > >   - ti_sn65dsi86.bridge.0,
> > > > > > >   - ti_sn65dsi86.gpio.0,
> > > > > > >   - ti_sn65dsi86.pwm.0.
> > > > > > > None of them have supplier:* symlinks in sysfs, so perhaps th=
at is
> > > > > > > the root cause of the issue?
> > > > > >
> > > > > > Sorry, I haven't had time to look into this closely. Couple of
> > > > > > questions/suggestions that might give you some answers.
> > > > > >
> > > > > > Is this an issue only happening for s2idle or for s2ram too? I'=
d guess
> > > > > > both, but if not, that might tell you something?
> > > > >
> > > > > The two (very similar) boards I could reproduce the issue on do n=
ot
> > > > > support s2ram yet.
> > > > >
> > > > > > The only reason the wait_for_completion() wouldn't work is beca=
use the
> > > > > > supplier is not "completing"?
> > > > >
> > > > > Yes, the diff shows ca. 70 additional calls to "complete_all()" i=
n the
> > > > > good case.
> > >
> > > >   4. When the issue happens, /sys/devices/virtual/devlink shows 3
> > > >      more links:
> > > >        A. platform:feb00000.display is a supplier of platform:fed80=
000.dsi-encoder
> > > >        B. platform:fed80000.dsi-encoder is a supplier of platform:f=
eb00000.display
> > >
> > > Their status file report "dormant".
> > >
> > > >        C. i2c:1-002c is a supplier of platform:fed80000.dsi-encoder
> > >
> > > Its status file reports "available".
> > >
> > > >   5. What happens in dpm_noirq_resume_devices()?
> > > >
> > > >        /*
> > > >         * Trigger the resume of "async" devices upfront so they don=
't have to
> > > >         * wait for the "non-async" ones they don't depend on.
> > > >         */
> > > >         i2c-1 (i2c bus) and 1-002c (bridge device) are async,
> > > >         thus triggered first.
> > > >         After that, the remaining devices are resumed.
> > > >
> > > >      In the bad case:
> > > >
> > > >        device_resume_noirq(fed80000.dsi-encoder, async=3Dfalse)
> > > >          dpm_wait_for_superior()
> > > >            parent soc: skipping wait_for_completion()
> > > >            dpm_wait_for_suppliers()
> > > >              supplier feb00000.display: skipped, DL_STATE_DORMANT
> > > >              ^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > Cfr. extra link A above (harmless)
> > > >
> > > >              supplier e6150000.clock-controller: skipping wait_for_=
completion()
> > > >              supplier 1-002c: wait_for_completion() =3D> BLOCKED
> > > >              ^^^^^^^^^^^^^^^
> > > > Cfr. extra link C above, but the bridge device hasn't been resumed =
yet.
> > >
> > > Changing the test for "DL_STATE_DORMANT"[1] in dpm_wait_for_suppliers=
()
> > > to also include "DL_STATE_AVAILABLE" makes it skip supplier 1-002c,
> > > and fixes the issue.  Does that make sense?
> >
> > Good question.
> >
> > DL_STATE_AVAILABLE essentially means that the consumer hasn't been
> > probed yet, but it doesn't mean that it can be suspended before its
> > supplier.
>
> I really meant "resumed before its supplier", sorry for the confusion.
>
> Generally speaking, suppliers need to be resumed first regardless of
> the status of the consumers.

Exactly, and that's being violated here.
Before resume, dpm_noirq_list contains:
     [...]
   - fed80000.dsi-encoder
     [...]
   - regulator-1p2v
     [...]
   - 1-002c
which is the order in which devices are to be resumed.

regulator-1p2v is a supplier of 1-002c: OK.
1-002c is a supplier of fed80000.dsi-encoder: NG.

As devices are resumed in the inverse order they have been suspended
before, suspend order is also wrong.  Hence checking also for
DL_STATE_AVAILABLE would just fix the symptom, and not the cause, right?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


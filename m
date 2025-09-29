Return-Path: <linux-pm+bounces-35542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49925BA8537
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 09:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA3F189C373
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 07:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FE2261594;
	Mon, 29 Sep 2025 07:53:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9611825FA2D
	for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759132423; cv=none; b=AgxmFOHc+Iixkv8EIMIR7Mn48kq0Y130QWB2bbrhgo947se0raCJNITguULQqLoeMibftNUkUfXLjmvnMrppV146vme48M5Z3d8338VCs2euwFymD/Zg6LI0k+f/6gbspxpbpgrzsblUXsbHwotNDyCr/StN3pDiOd1LNa8H79I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759132423; c=relaxed/simple;
	bh=SmgJ4nQra9wq+wT+HKrmsX9lGBzE0orNDzbN6LeqaVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfeoaFDgXBy79W88DC/+I+lco+GdNpu5yi+fDk8OogqRZPFPY3dMuIoHj7rznX7+IsSfCtXx9QUK9xKBh3WZ3rvvwPerHgjLHhw0V+dxtCfU+FTYYxp0ISqvaL+Tm4uOOCvR+EuiYRiztL3JnTEig6E/udgKl8R/RvdGdYSe/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5a392946c4aso2481614137.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 00:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759132420; x=1759737220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUXSFceWb25g9n2jWqeSmoB7pNwdYGNyiAtsuATGVG8=;
        b=E/4YZApEVYwyY5iVY3Xd56vX+lCzlwTToufRJZTUquKMoW7wyiFo2urZa1u7mnIqk1
         EugZO84Tdp5tJEaEmpgiz5pExgCsHgXidCZtYQLOtTfLvCcg0+i02JezhTnxHTFf7ngM
         tj1eOzo4BTERaLRLnmjH4rbRvwHZACLiBAvuKjZ2IQx3j2HCrG0d2KpIbCeoudZaH5UX
         3HFzihjQMUjZ3ns10cl9edmv3e1W1/jqdCFL4pc0QZj7gwJ/Yom8lDJyo0UwHWv50jus
         BbbV9zWbD9lEhdVEhDUpoUfCsm7bkMXsgHMl5ETa64ZS0fZBfJbaws7LomH3ps2Vti/N
         Buog==
X-Forwarded-Encrypted: i=1; AJvYcCW7EZjd2CZCXjw7996YVVpFFUNrmi6k5kRRMs/LKsLDOQMW0SQlARAkNpfuV0ZEJUFBuN0YKZScEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtVOwGezmjc0+54zoJiOUzKDRBiuwM8HzoOravgAjMhBMlopq
	TOqq0hCZQIeuSjmc7Zsbq7MJDegbriSIkMULnSkP9JBWIDEV8Y8NCS1qWlKCxTz3
X-Gm-Gg: ASbGncvqpYskSnJXHs0R09Fk8nF1uayQT559VigoIFO0zG3FhnOCAmM+1ve0HvuMmnM
	xwcFLOg2ZLoFz9JXv4hT0c/mrw3vjL1HmmX9fs/UEDGP2d3k3rkRlzVggFaUHUrfIBm/S1x0SSm
	JVrn7KydQd9GCgIlFEvIo457a50eY3Cxd0zJUlp1FllDyMbzHnfA/jwEut5jq6Chm5ucqLVmbiq
	hemwaWZ1mkk7aOuBQeYr+6upEKSmJK3cgS0Xkdr35U3dPxyyQQTgV3RYDM5nWW/TrdLSLWnSZ+a
	V76sjzLfb6T7JFs9a2p36WSx5QztxWZdiycOPeijWusxoUuL3+xdDr5fDbDuDf51mX5DcvH1joT
	zgy+iTO/yQIdixu0Tnh2Ck3/mClctxK7ZxHgf1o/LITsx6Gh7wJRRFsmm2cpiQdzaTgDtQn4=
X-Google-Smtp-Source: AGHT+IGXuHWmQCm2xXHNHOuHwzDCmwd7XTjQR0qNgTig58Y1XkMPgItYhvKTby+tNCQYpxX81KS1kQ==
X-Received: by 2002:a05:6102:442c:b0:5a3:6a6f:21ad with SMTP id ada2fe7eead31-5acd0182a34mr5492501137.30.1759132420221;
        Mon, 29 Sep 2025 00:53:40 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ae39eff1b3sm3209660137.15.2025.09.29.00.53.39
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 00:53:40 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5b59694136bso1919705137.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 00:53:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+GWB2yH1/ZN6WFQedvF2zjDf/dsQ+0AVDtgFjyd26Znq/V7MqV+6dRAfsXXuQfYeANb05bgRIog==@vger.kernel.org
X-Received: by 2002:a05:6102:304c:b0:55d:b35e:7a58 with SMTP id
 ada2fe7eead31-5acce758205mr5685599137.23.1759132419534; Mon, 29 Sep 2025
 00:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <CAPDyKFr=u0u2ijczExkntHK1miWZ6hRrEWBMiyUwShS3m6c29g@mail.gmail.com>
 <CAMuHMdX1BacUfqtmV8g7NpRnY9aTdL=fh+jC7OryMLz4ijaOCg@mail.gmail.com>
 <CAPDyKFqANQZmGXd8ccA5qWiGrCor2N=W_7dmV+OK8hMd_+zmmw@mail.gmail.com>
 <CAMuHMdVrkr56XsRsbG7H-tLHVzmP+g-7=5Nrv9asC25ismwiYA@mail.gmail.com>
 <CAGETcx-L-KypYZEkdKRBfZHDhFMTUuwKEGVQ-7QPv=++6uwLSw@mail.gmail.com>
 <CAMuHMdWjhXjjw9wFw5Me-wAX0nA+gK2mdGxLyBJJCWDHZ58LeQ@mail.gmail.com> <CAPDyKFr4t7KjV+bSB2_4wRM0tsSNB7fosoJHAN+yDgc1g=7FgA@mail.gmail.com>
In-Reply-To: <CAPDyKFr4t7KjV+bSB2_4wRM0tsSNB7fosoJHAN+yDgc1g=7FgA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 09:53:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXYs1w=GtQEQ=iMYxCfAnY4MDrrEQYV+_dNc_sKWCz6zA@mail.gmail.com>
X-Gm-Features: AS18NWDHIeKax_oc2j3zUm5LN96ZK89sUlSKJb1MXuYCTNKdArFExfgAY_xANms
Message-ID: <CAMuHMdXYs1w=GtQEQ=iMYxCfAnY4MDrrEQYV+_dNc_sKWCz6zA@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support to genpd
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Fri, 26 Sept 2025 at 14:23, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Fri, 26 Sept 2025 at 08:57, Geert Uytterhoeven <geert@linux-m68k.org> =
wrote:
> > On Fri, 26 Sept 2025 at 00:41, Saravana Kannan <saravanak@google.com> w=
rote:
> > > On Thu, Aug 7, 2025 at 2:43=E2=80=AFAM Geert Uytterhoeven <geert@linu=
x-m68k.org> wrote:
> > > > On Wed, 30 Jul 2025 at 12:29, Ulf Hansson <ulf.hansson@linaro.org> =
wrote:
> > > > > On Wed, 30 Jul 2025 at 11:56, Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> > > > > > BTW, the "pending due to"-messages look weird to me.
> > > > > > On R-Car M2-W (r8a7791.dtsi) I see e.g.:
> > > > > >
> > > > > >     genpd_provider ca15-cpu0: sync_state() pending due to e6020=
000.watchdog
> > > > > >     renesas-cpg-mssr e6150000.clock-controller: sync_state() pe=
nding
> > > > > > due to e6020000.watchdog
> > > > > >
> > > > > > ca15-cpu0 is the PM Domain holding the first CPU core, while
> > > > > > the watchdog resides in the always-on Clock Domain, and uses th=
e
> > > > > > clock-controller for PM_CLK handling.
> > > >
> > > > Unfortunately the first PM Domain is "ca15-cpu0", which is blocked =
on
> > > > these bogus pending states, and no PM Domain is powered off.
> > >
> > > Can you explain why you call these as bogus? Sorry if you already
> > > explained it. But the reason I'm asking is to see if you can set a
> > > flag for the watchdog device so fw_devlink will completely ignore it.
> >
> > "bogus" refers to "1." below.
> >
> > Furthermore, devices that are located in an alway-on domain should
> > not block the sync state.
> >
> > > It looks like there's a driver for this watchdog node? Why is it not
> > > probing then?
> >
> > Because this particular revision of the SoC has a hardware bug that
> > prevents the watchdog timer from rebooting the system, and the driver
> > detects that.
> >
> > Anyway, if the driver is not available, unused power domains should
> > still be powered down, like before.
> >
> > > > If I remove the "sync_state =3D false" above, genpd_provider_sync_s=
tate()
> > > > considers all domains, and does power down all unused domains (even
> > > > multiple times, as expected).
> > > >
> > > > Upon closer look, all "pending due to" messages I see claim that th=
e
> > > > first (index 0) PM Domain is pending on some devices, while all of
> > > > these devices are part of a different domain (usually the always-on
> > > > domain, which is always the last (32 or 64) on R-Car).
> > > >
> > > > So I think there are two issues:
> > > >   1. Devices are not attributed to the correct PM Domain using
> > > >      fw_devlink sync_state,
> > >
> > > Is it a fw_devlink issue? Or is this a multi-domain controller?
> >
> > This is a multi-domain controller.
> >
> > > >   2. One PM Domain of a multi-domain controller being blocked shoul=
d
> > > >      not block all other domains handled by the same controller.
> > >
> > > This is going to take a while to sort out. But the current behavior i=
s
> > > the safest. How grumpy will you be if we don't fix this :)
> >
> > Depending on your definition of "safe".  Keeping all power domains on
> > increases power consumption and heat generation, and may cause e.g. CPU
> > frequency throttling to kick in, slowing down operation of the system.
>
> FYI, I agree that we need to address these problems, in one way or the
> other. I am trying to summarize them and have also proposed a CFP for
> LPC (power/thermal MC) to discuss and try to solve them.

OK, CU there! ;-)

> Now, as I also proposed in the other thread [1] just now. How about
> changing the default behaviour from FW_DEVLINK_SYNC_STATE_STRICT to
> FW_DEVLINK_SYNC_STATE_TIMEOUT? I think that would solve a lot of
> problems for us, as it would provide a more similar behaviour to what
> we had in genpd originally, hence it would be a smoother transition.
>
> I think this would be true when trying to add ->sync_state() support
> for other subsystems too, like clocks and regulators.
>
> In the end, when platforms are ready to move to the "strict" mode,
> they can do that via the command-line parameter, for example.

Thanks, changing the default to timeout sounds good to me!

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


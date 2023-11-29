Return-Path: <linux-pm+bounces-523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD977FE184
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 22:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E00B20EC3
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 21:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D62461668;
	Wed, 29 Nov 2023 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EE4D67;
	Wed, 29 Nov 2023 13:06:43 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6d8572850d3so33630a34.0;
        Wed, 29 Nov 2023 13:06:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701292003; x=1701896803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHRmRPtF9D4nRminD67tB3n7RvHkt7lPmAjYFdqVXkI=;
        b=nFSa5jFKpN/+nD3bKwHE2ACeVyJOEPeYX1+tPM6riYxo67fYiz1k/KYGx96QZEkU/y
         OXx19Mjjp5ox1S7B3nUkSh42+81VCyCgUogaP2dk6eCa6oDR8bwbQctqoI1JqjCypUbs
         Vc4XsYYjXGtm0x6gBg73ndrtge4M8Fg+YT06wiTv+KhNAHPS5Llup+R221o+Gjluw2ha
         uxRzXldP2BU0sO2Fse33lWFkYGXKoQaEUM615908izE5lFoj3HuZQ2xDFBy+3kG5IniD
         1fgAEbcr2JmZlSvoRlUQl438T++JtW1glcvVDWnBOpPcR9d6P78l91ksVIqALpeyu4pO
         TXgg==
X-Gm-Message-State: AOJu0YwLJQJJJ0kRA1jGRtuTtZM9nWaCgyUWPM69lRN2aHISDR8molM3
	RrvNi2gQiChK8Ay5b+A4W8ukJV1NndnXVOZla0vdSWx5
X-Google-Smtp-Source: AGHT+IGwyfMzZjKTdJY4xh9sk9EhES/5kV1h/HBOm7BFnvM4b89jcHmt2KzdaDWF0SY6YavpL8ByJfhMclEBpl+XLHA=
X-Received: by 2002:a4a:d4c4:0:b0:58d:e3d3:ec72 with SMTP id
 r4-20020a4ad4c4000000b0058de3d3ec72mr563003oos.0.1701292002971; Wed, 29 Nov
 2023 13:06:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103094815.16141-1-ayush.jain3@amd.com> <ZUTEnneqNcosb/1R@amd.com>
In-Reply-To: <ZUTEnneqNcosb/1R@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Nov 2023 22:06:31 +0100
Message-ID: <CAJZ5v0jdy+L-2+WH8sOVdM4WrUek5atqUohqj0MJRzwHi2w9Qw@mail.gmail.com>
Subject: Re: [RESEND PATCH] amd-pstate: Only print supported epp values for
 performance governor
To: Huang Rui <ray.huang@amd.com>, "Jain, Ayush" <ayush.jain3@amd.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, 
	"Yuan, Perry" <Perry.Yuan@amd.com>, "Karny, Wyes" <Wyes.Karny@amd.com>, 
	"Limonciello, Mario" <Mario.Limonciello@amd.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 11:00=E2=80=AFAM Huang Rui <ray.huang@amd.com> wrote=
:
>
> On Fri, Nov 03, 2023 at 05:48:15PM +0800, Jain, Ayush wrote:
> > show_energy_performance_available_preferences() to show only supported
> > values which is performance in performance governor policy.
> >
> > -------Before--------
> > $ cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_driver
> > amd-pstate-epp
> > $ cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
> > performance
> > $ cat /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_preferenc=
e
> > performance
> > $ cat /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_available=
_preferences
> > default performance balance_performance balance_power power
> >
> > -------After--------
> > $ cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_driver
> > amd-pstate-epp
> > $ cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
> > performance
> > $ cat /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_preferenc=
e
> > performance
> > $ cat /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_available=
_preferences
> > performance
> >
> > Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support=
 for the AMD processors")
> >
> > Suggested-by: Wyes Karny <wyes.karny@amd.com>
> > Signed-off-by: Ayush Jain <ayush.jain3@amd.com>
> > Reviewed-by: Wyes Karny <wyes.karny@amd.com>
>
> Nice catch, thanks for the fix.
>
> Acked-by: Huang Rui <ray.huang@amd.com>

Applied as 6.7-rc material, thanks!

> >
> > ---
> >  drivers/cpufreq/amd-pstate.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.=
c
> > index 9a1e194d5cf8..e6c5a57662e4 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -850,11 +850,16 @@ static ssize_t show_energy_performance_available_=
preferences(
> >  {
> >       int i =3D 0;
> >       int offset =3D 0;
> > +     struct amd_cpudata *cpudata =3D policy->driver_data;
> > +
> > +     if (cpudata->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE)
> > +             return sysfs_emit_at(buf, offset, "%s\n",
> > +                             energy_perf_strings[EPP_INDEX_PERFORMANCE=
]);
> >
> >       while (energy_perf_strings[i] !=3D NULL)
> >               offset +=3D sysfs_emit_at(buf, offset, "%s ", energy_perf=
_strings[i++]);
> >
> > -     sysfs_emit_at(buf, offset, "\n");
> > +     offset +=3D sysfs_emit_at(buf, offset, "\n");
> >
> >       return offset;
> >  }
> > --
> > 2.34.1
> >


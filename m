Return-Path: <linux-pm+bounces-28012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C51ACC667
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 14:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC9F18859B3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 12:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55432228CB0;
	Tue,  3 Jun 2025 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQjE+ct9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBFD1B393C;
	Tue,  3 Jun 2025 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953444; cv=none; b=TMpXECWct9cYst34mOIhX3aOStTqltt9eFiWsvCy6xvJqFK4l7xc1QZJvFXGRI4w6czlFIZ6zSN0A7Bp/yh0YHJdHNWViTQWokdLTJNcUTtfe988nT/mbACJ2sQEW6IstN+EBV4hEMRGZvL7w7rV6cAk4U2fGZ8jxUEMCiPe/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953444; c=relaxed/simple;
	bh=7QLGbXdkxks7XLfFk2zDgD3AFaXdmO+aci/PG1X2O+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcSb5GMioJY6RRlb+QmmMmbQQjoJGWgw3u4QjuJY816U4MpDmiflOXaoDukkgOI1ls1egqLwji5zUKLUa2YqR1kFlOjOxONXl3j/N1FBevJFYbe+V7w0RZf1+M3YfwNhjMVC8bt2LXkF0tSOBBgtiJgGu4zv0cTjfFwhpBfIXRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQjE+ct9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909BEC4CEF0;
	Tue,  3 Jun 2025 12:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748953443;
	bh=7QLGbXdkxks7XLfFk2zDgD3AFaXdmO+aci/PG1X2O+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WQjE+ct9AxxT9/mOMimmEdNtBD3/0al0sOHnJeZzg6GgT7qj1wXzmicAf56V8CgWi
	 xigwCrFjQeUVK+EmR3jcmZd5k43XhzIQOcmdIEK7wzvNFcUR2VkOv4wlxGZMLtoOeM
	 2owVfSUzh8coCfjaOFr25c5BEZhTP4918VPH6CzWgekllHlt+KfNn6VahP5EOzGh89
	 D5uFfa0muoMxj55JYfQjH/u7jLMzhy5zkTMWKhndb9AjawGLCb1UiKkAVah6uMFKH6
	 CI3AT+1W16FkiM0eJqH5ITgUqR39SSlpoBRdmDvlV/BvctnUx/k3HLhubtruBh9LMc
	 Bw5P8wIzZSwug==
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4e5aa697e7eso3313870137.1;
        Tue, 03 Jun 2025 05:24:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvoDSfljc3QCNKVj7A7QoVxzZV/4MrfN83z6En05rx4SJ5iGkp8GCYyg4oXftMK0eVuDNAm2M+naI=@vger.kernel.org, AJvYcCX79OokpFABvf41+1l8zp5dUW79jbRfBBX6Pyb2vAyz0Vv/BDuHRpmAefn7iCUKWAGBftzD7jXG/k/vhgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyJJ8Q3EI74VEkwWi4VPHAN5KRhHnX0GeLKx1okSUjS99EJ/zg
	gfMZDoHefqRXG5MQlFPQDp6BPOLIWteg0uzbnYEPrxnN2Wah/bvVeFcylMLt1p22xafJ46zhN6g
	3WT09r3FaxZasy+gh6ZR+UJS3kHtS8yk=
X-Google-Smtp-Source: AGHT+IFNf83vfCXnhXoj7PNcjEM/Y3fO7C/IOPvyM+NChi36n2vzN7U3cpUD1bzhXl7kFo1Bgst8AhF8A2fRgZjJTMU=
X-Received: by 2002:a05:6808:1789:b0:401:bb42:700c with SMTP id
 5614622812f47-408e36c0748mr1412570b6e.19.1748953431946; Tue, 03 Jun 2025
 05:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aD2U3VIhf8vDkl09@debian.local> <CAJZ5v0h-nrVamqiAJ957aYjHqaeAZUUW7BRi0WxPgCFc40M5cQ@mail.gmail.com>
 <7f0e2865-d35e-4a13-8617-8679afb4b23f@kernel.org> <CAJZ5v0gL3rW8dOxXdPWYjZuq5kAaD8qTa4vZ5++k9+0WniNAdQ@mail.gmail.com>
 <CAJZ5v0jDZQaR8S6Kn_RoXHBU86+tpjp=qgyxm5h03YEe2S=nPg@mail.gmail.com>
 <aD7L0RD4HT-mEtBc@debian.local> <CAJZ5v0h65Gt1Fw35vp2k8kKu62+goCD8WF8u-tvhfWW6a7xHxQ@mail.gmail.com>
 <CAJZ5v0ggPHhYcdNos2o8savvq+-zpPTaQunjOkR36k3VwF3_CA@mail.gmail.com>
 <CAJZ5v0gF=ewooE0cUrNfe5_inhnzq6bqw8VTjkFwr56_wrptJQ@mail.gmail.com>
 <CAJZ5v0hpJSVdiCN29=kbV8KfgU1y1d3hFfshtBoMpVFXf+LvBQ@mail.gmail.com> <aD7nOMP3xA9BR781@debian.local>
In-Reply-To: <aD7nOMP3xA9BR781@debian.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Jun 2025 14:23:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gAcohRWuSZbFWvyfAU9Vjc7nRyj+AFRYQ7hcGEXdPxyQ@mail.gmail.com>
X-Gm-Features: AX0GCFtHfgoEkBkaJCucBFxe92zc09KeHz7xeAlRFNLtr6kTo9V07rizcEW5UeM
Message-ID: <CAJZ5v0gAcohRWuSZbFWvyfAU9Vjc7nRyj+AFRYQ7hcGEXdPxyQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] PM: sleep: Suspend async parents after suspending children
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mario Limonciello <superm1@kernel.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, 
	Saravana Kannan <saravanak@google.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 2:15=E2=80=AFPM Chris Bainbridge
<chris.bainbridge@gmail.com> wrote:
>
> On Tue, Jun 03, 2025 at 01:39:01PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Jun 3, 2025 at 1:37=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> > >
> > > On Tue, Jun 3, 2025 at 12:30=E2=80=AFPM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> > > >
> > > > On Tue, Jun 3, 2025 at 12:29=E2=80=AFPM Rafael J. Wysocki <rafael@k=
ernel.org> wrote:
> > > > >
> > > > > On Tue, Jun 3, 2025 at 12:17=E2=80=AFPM Chris Bainbridge
> > > > > <chris.bainbridge@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 03, 2025 at 11:38:37AM +0200, Rafael J. Wysocki wro=
te:
> > > > > > >
> > > > > > > Chris, please check if the attached patch helps.  I'm going t=
o post it
> > > > > > > as a fix anyway later today, but it would be good to verify t=
hat it is
> > > > > > > sufficient.
> > > > > >
> > > > > > This did not fix my test case, pstore crash log was:
> > > > >
> > > > > OK, so can you please enable PM debug messages:
> > > > >
> > > > > # echo 1 > /sys/power/pm_debug/messages
> > > >
> > > > This should be
> > > >
> > > > # echo 1 > /sys/power/pm_debug_messages
> > > >
> > > > sorry.
> > > >
> > > > > and enabled dynamic debug in drivers/base/power/main.c:
> > > > >
> > > > > # echo "file drivers/base/power/main.c +p" > /proc/dynamic_debug/=
control
> > > > >
> > > > > repeat the test and capture the log?
> > >
> > > Actually, no need to do this, there is an obvious bug:
> > > list_splice_init() should be used instead of list_splice() when the
> > > emptied list is going to be used again.  Ugh.
> > >
> > > Please check if the attached patch along with the previous one makes
> > > the issue go away entirely.
> >
> > Really attached this time, sorry.
>
> > ---
> >  drivers/base/power/main.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -1458,7 +1458,7 @@
> >                        * Move all devices to the target list to resume =
them
> >                        * properly.
> >                        */
> > -                     list_splice(&dpm_late_early_list, &dpm_noirq_list=
);
> > +                     list_splice_init(&dpm_late_early_list, &dpm_noirq=
_list);
> >                       break;
> >               }
> >       }
> > @@ -1660,7 +1660,7 @@
> >                        * Move all devices to the target list to resume =
them
> >                        * properly.
> >                        */
> > -                     list_splice(&dpm_suspended_list, &dpm_late_early_=
list);
> > +                     list_splice_init(&dpm_suspended_list, &dpm_late_e=
arly_list);
> >                       break;
> >               }
> >       }
> > @@ -1953,7 +1953,7 @@
> >                        * Move all devices to the target list to resume =
them
> >                        * properly.
> >                        */
> > -                     list_splice(&dpm_prepared_list, &dpm_suspended_li=
st);
> > +                     list_splice_init(&dpm_prepared_list, &dpm_suspend=
ed_list);
> >                       break;
> >               }
> >       }
>
> This patch does fix the list corruption, but the "Unbalanced
> pm_runtime_enable" still occurs:

Have you applied it together with the previous patch?


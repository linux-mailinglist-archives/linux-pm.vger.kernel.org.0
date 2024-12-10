Return-Path: <linux-pm+bounces-18944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 651759EBAAC
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E138F16678C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 20:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE0B226883;
	Tue, 10 Dec 2024 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmLkVM/7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E58633A;
	Tue, 10 Dec 2024 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861572; cv=none; b=qVYj2nUU6jiBqcLKdVdtta9JG+eHXkLg8dQ7AX6MHxlXqij/XZywklz1MKfoCJJp31jvX9DmygcMc7B6Bacd6yiux24HPVDt6QFmv2J9uwGeyK/9HOLsJHLGZMb2D0a6aUu/d6gbKmovi6tztR9XB/jjKzK/S98IthrQVe+0DRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861572; c=relaxed/simple;
	bh=8amKu6S5ARdj771WQ62rtbtoxNf+lJl/eHouAKRMmX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRo7vZwKCxb70FlSI6Epf0179KmlKBHq1/36/2j64bZjhI42yLVNCp/Vd2QSnCpxdm4GmTG63+n48G7aK/SvxD20nXlrT06FMboJaf5wpTBE/qAKmlkjQji6VFFL+CKcUkWmE9nNGbMoIrcr5Yxzax7/6PFPX1JI6OWn7p87Z0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmLkVM/7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so883841066b.3;
        Tue, 10 Dec 2024 12:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733861568; x=1734466368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9lbLBBO8kM2n2jRi2Qb1qwlvQ3SeySuQW/fRe7E1eA=;
        b=fmLkVM/7mq1S9y4dbUzV0VgThGtGmC9Pz7raTrQo+Uo8o6640Q1LsU0JeGmw09LJbo
         xeCD6j4vomftvUJT4si92BSk3UyTpO5D7NZ3Fsu5bzWJHjDBqRGoT1naF6gpB5a13I9K
         HXA22iNC0RcJH+h7CL8hFPXREcs/Cdmv6gQPnRxZTllWIOKJr/xlsAV/t1gf2+1wT25I
         CW+b3dPBfLk8CPxCuCaPefPh7agZLVxtmZ5zoxC8E9fZUkhJJpxC5KM9UZdSb9N4uTCX
         Ec4FmqvVwrzR4f4ww4PTv6WI4qUZrNfc196O67U4RoQwlN4wv4Wjr94r0VguBlS+JDKJ
         rZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733861568; x=1734466368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9lbLBBO8kM2n2jRi2Qb1qwlvQ3SeySuQW/fRe7E1eA=;
        b=WAdCzB6Nf8QM9wXXvxDbXQo6wKCb/H5kLdTD+AWZUmtN+ob/rhfeBhNU+YcRjFSPiT
         kykECqzTXk1qIPxV442ocnhpyPA+nLDlH1C7lDT3dHgRjbCce1NzfKQV3JOEX87j6iEA
         Ws8MSiKYmP/kDxk5EXuiCxC50X7urLBzMZ4of85AC//BYLSmqTIXF9BtB40JaPGyebyq
         M9XvrsecF1UxwMaHBuI3PiPw0M/rpUUNBocx59vF1gJwFKxuaqNixEcbpGFksXVWl9r/
         /ME6vQWuwKKg23PLJdP7QnxN62LKgls5YT6xcLkGyrkrwDXjUKJe/0mr7DcdWKam+hsp
         PLcg==
X-Forwarded-Encrypted: i=1; AJvYcCU3E04enslu81ljV7sxWJygy+Fe4mfTj9aOP9r7dWMX9ig7hZcfXByY+M+wgJYKHn9RzYPmgwk1m1s=@vger.kernel.org, AJvYcCWOFYABfQdUi0rwNURrn32bnI0PCTkC2HtgHPOJ/av36qNgjJM2Ae6eFldgVPU5Yej0Ks22u2YXldTdDpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ISaiH4xlGm6I05pyNRNrA0jN4QV4LKz/SAG00fapQ1WEiLo7
	saH6Xmq4/vvgEFfZQYUBuOXPLBYGhN7T3UyH/6MB8mHaoIXKGP2WAIQPvTCxcJmN4CWYjMbmlMz
	4XeeHCzqXVLQYTt9/OmRYIzMslyw=
X-Gm-Gg: ASbGncut8Yz30JU61cpRaqXQ6fnV5T16tsF/xWAmuAS6AU2BTPaCMnrmXgPLBvL7ye/
	l5toPA815C1+GqySkbhczLh2ZvuffOblgsQKu
X-Google-Smtp-Source: AGHT+IGiPfuPBW3oKmG36OHVBhNiaww+/ndbWSRkgdBaXKVg4Zbsas+aQCY8I9lvfIp5/gr9+wqDTDl1YykwOSpcYwM=
X-Received: by 2002:a05:6402:2808:b0:5d3:ce7f:abdf with SMTP id
 4fb4d7f45d1cf-5d433163d71mr192647a12.29.1733861568260; Tue, 10 Dec 2024
 12:12:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210013010.81257-1-pgwipeout@gmail.com> <20241210013010.81257-2-pgwipeout@gmail.com>
 <1b323d6e9ef873bfc770e9d54b7a3a64@manjaro.org>
In-Reply-To: <1b323d6e9ef873bfc770e9d54b7a3a64@manjaro.org>
From: Peter Geis <pgwipeout@gmail.com>
Date: Tue, 10 Dec 2024 15:12:36 -0500
Message-ID: <CAMdYzYqmn0UktNfz7L352zcjgmxf4tsRs2fwiFXF7NbfPY4zSg@mail.gmail.com>
Subject: Re: [PATCH 1/6] pmdomain: rockchip: fix rockchip_pd_power error handling
To: Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Caesar Wang <wxt@rock-chips.com>, 
	Detlev Casanova <detlev.casanova@collabora.com>, Finley Xiao <finley.xiao@rock-chips.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Kevin Hilman <khilman@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 3:18=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Peter,
>
> On 2024-12-10 02:30, Peter Geis wrote:
> > The calls rockchip_pd_power makes to rockchip_pmu_set_idle_request lack
> > any return error handling, causing device drivers to incorrectly
> > believe
> > the hardware idle requests succeed when they may have failed. This
> > leads
> > to software possibly accessing hardware that is powered off and the
> > subsequent SError panic that follows.
> >
> > Add error checking and return errors to the calling function to prevent
> > such crashes.
> >
> > gst-launch-1.0 videotestsrc num-buffers=3D2000 ! v4l2jpegenc ! fakesink
> > Setting pipeline to PAUSED ...er-x64
> > Pipeline is PREROLLING ...
> > Redistribute latency...
> > rockchip-pm-domain ff100000.syscon:power-controller: failed to get ack
> > on
> > domain 'hevc', val=3D0x98260, idle =3D 0
> > SError Interrupt on CPU2, code 0x00000000bf000002 -- SError
> > CPU: 2 UID: 0 PID: 804 Comm: videotestsrc0:s Not tainted 6.12.0-rc5+
> > #54
> > Hardware name: Firefly roc-rk3328-cc (DT)
> > pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > pc : rockchip_vpu2_jpeg_enc_run+0x168/0xbc8
> > lr : device_run+0xb0/0x128
> > sp : ffff800082143a20
> > x29: ffff800082143a20 x28: 0000000000000140 x27: 0000000000000000
> > x26: ffff582c47a313e8 x25: ffff582c53e95000 x24: ffff582c53e92800
> > x23: ffff582c5bbe0000 x22: 0000000000000000 x21: ffff582c47a31080
> > x20: ffffa0d78cfa4168 x19: ffffa0d78cfa4168 x18: ffffb755b0519000
> > x17: 000000040044ffff x16: 00500072b5503510 x15: a7a6a5a4a3a29a99
> > x14: 989796959493928a x13: 0000000051eb851f x12: 00000000000000ff
> > x11: ffffa0d78d812880 x10: ffffa0d78d7fbca0 x9 : 000000000000003f
> > x8 : 0000000000000063 x7 : 000000000000003f x6 : 0000000000000040
> > x5 : ffff80008010d000 x4 : ffffa0d78cfa4168 x3 : ffffa0d78cfbfdd8
> > x2 : ffff80008010d0f4 x1 : 0000000000000020 x0 : 0000000000000140
> > Kernel panic - not syncing: Asynchronous SError Interrupt
> > CPU: 2 UID: 0 PID: 804 Comm: videotestsrc0:s Not tainted 6.12.0-rc5+
> > #54
> > Hardware name: Firefly roc-rk3328-cc (DT)
> > Call trace:
> > dump_backtrace+0xa0/0x128
> > show_stack+0x20/0x38
> > dump_stack_lvl+0xc8/0xf8
> > dump_stack+0x18/0x28
> > panic+0x3ec/0x428
> > nmi_panic+0x48/0xa0
> > arm64_serror_panic+0x6c/0x88
> > do_serror+0x30/0x70
> > el1h_64_error_handler+0x38/0x60
> > el1h_64_error+0x7c/0x80
> > rockchip_vpu2_jpeg_enc_run+0x168/0xbc8
> > device_run+0xb0/0x128
> > v4l2_m2m_try_run+0xac/0x230
> > v4l2_m2m_ioctl_streamon+0x70/0x90
> > v4l_streamon+0x2c/0x40
> > __video_do_ioctl+0x194/0x400
> > video_usercopy+0x10c/0x808
> > video_ioctl2+0x20/0x80
> > v4l2_ioctl+0x48/0x70
> > __arm64_sys_ioctl+0xb0/0x100
> > invoke_syscall+0x50/0x120
> > el0_svc_common.constprop.0+0x48/0xf0
> > do_el0_svc+0x24/0x38
> > el0_svc+0x38/0x100
> > el0t_64_sync_handler+0xc0/0xc8
> > el0t_64_sync+0x1a8/0x1b0
> > SMP: stopping secondary CPUs
> > Kernel Offset: 0x20d70c000000 from 0xffff800080000000
> > PHYS_OFFSET: 0xffffa7d3c0000000
> > CPU features: 0x00,00000090,00200000,0200421b
> > Memory Limit: none
> > ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---
> >
> > Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain
> > driver")
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>
> This patch is obviously correct, because not checking what
> rockchip_pmu_set_idle_request() returns was simply wrong.
> Thanks for the patch!
>
> Though, shouldn't we improve further the way proper error
> handling is performed in rockchip_do_pmu_set_power_domain(),
> by "rolling back" what rockchip_do_pmu_set_power_domain()
> did after powering up fails?

Eventually, but the reality is if we hit this path the hardware is
already broken. I wanted to provide a fix with the least amount of
risk of breaking things further. I'm open to suggestions for further
improvements here.

Current behavior with this patch with the example above causes
gstreamer to wait indefinitely. I'll trace the return path and see if
returning an error other than -ETIMEDOUT triggers more robust
handling.

>
> > ---
> >
> >  drivers/pmdomain/rockchip/pm-domains.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pmdomain/rockchip/pm-domains.c
> > b/drivers/pmdomain/rockchip/pm-domains.c
> > index cb0f93800138..57e8fa25d2bd 100644
> > --- a/drivers/pmdomain/rockchip/pm-domains.c
> > +++ b/drivers/pmdomain/rockchip/pm-domains.c
> > @@ -590,14 +590,18 @@ static int rockchip_pd_power(struct
> > rockchip_pm_domain *pd, bool power_on)
> >                       rockchip_pmu_save_qos(pd);
> >
> >                       /* if powering down, idle request to NIU first */
> > -                     rockchip_pmu_set_idle_request(pd, true);
> > +                     ret =3D rockchip_pmu_set_idle_request(pd, true);
> > +                     if (ret < 0)
> > +                             return ret;
> >               }
> >
> >               rockchip_do_pmu_set_power_domain(pd, power_on);
> >
> >               if (power_on) {
> >                       /* if powering up, leave idle mode */
> > -                     rockchip_pmu_set_idle_request(pd, false);
> > +                     ret =3D rockchip_pmu_set_idle_request(pd, false);
> > +                     if (ret < 0)
> > +                             return ret;
> >
> >                       rockchip_pmu_restore_qos(pd);
> >               }


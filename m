Return-Path: <linux-pm+bounces-24512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F4EA71A15
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 16:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356633BB873
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 15:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF86D1F3D56;
	Wed, 26 Mar 2025 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rudeU4Qa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829921F3BB9;
	Wed, 26 Mar 2025 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002083; cv=none; b=U9uq10pmRvUG94h0Stp+4e/Hb+IXBAsP64jXbMqV+M9gpO8vjOjxENdrhoNER0J5eIV4fH02r9dLq93nD3aLs2slHidlzFWJArXJXPV7pJ0WeVOA+mC/vxSKLnyHauwScCI0I9afQHmSgCuXc3z2ygfhCVm+YsEHSXGCAuIw6Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002083; c=relaxed/simple;
	bh=clXRRE7P99qJIW1KMW0rtmhzGOaWWbyCDHQF+LEaRmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRXwJKN4fSFrUV6fDSKS5BByHSnLFcEU4s+ziYwO/XPMIAy8cxdJj+ICEVWNtN4SZFqpoBj5kFpp9Vgo34QDCpkmzGUcApfqmu0e+v53eX4CAATY8wDpahBgBc03I7JcCuxLHcbtFabO8xsnTSSbhrbEZdcbFObolYfVxkbzE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rudeU4Qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0006AC4AF09;
	Wed, 26 Mar 2025 15:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743002083;
	bh=clXRRE7P99qJIW1KMW0rtmhzGOaWWbyCDHQF+LEaRmQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rudeU4QaDTFwA3RNeMAdJ4wKCqJWG3Dlh8iPNjqkfau/Pel6lEH7ovkQQ7yWpW0oF
	 IqWcLAzzczeMbSRvFSyOS6dUBKJGWImQgchw8/yJ/hoeVTmDfE+ea+d+4fWtfunslL
	 09AHLgaTXUX1ySwjEEnYthtsduBUcPDSYnXq2bxedttc6LrobxYOIB5DNa1aHpz38x
	 GsYvpwLLN/faBqO3OllBW+Yl83YyUsoqCvEjR4uFTqkjosx6TYuPOJjZshpFQ/NO96
	 R/HhssPHaTJljWUyg9GZGDVfnjwg+ct7pIKo/mDJcoIUJdA3vkj2wpVPGtpRYqeUmp
	 ew4JlXm4n58Jg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2c2dc6c30c2so1709600fac.2;
        Wed, 26 Mar 2025 08:14:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/wvOfHboVKxI4uzftK4mFXx2EsO8ud3NrFdqxIqMXxO20tx4bFuk24/TGmsZSrqaFkbHrewHaVAhVgg==@vger.kernel.org, AJvYcCVV2UpHzV+9hs4c/gA2kP6Ovle+X57FhFuLtJav5PSeKd4KdCUoQ9zeiTQ7YwBVmeWi78uJmYz/ZDc=@vger.kernel.org, AJvYcCWEyqgCg2slFGAgcCwhMVI0Eszpr5wRpLUQFaC+ZIiGwy1rjJg0Oc/3g2vVKm6iU/p94PPRh0sKtEinzU3T@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7uB/2CuCLyB3n8zrCh4pKk2Ocn/7KDtezbag6lwGI6BDtCZIf
	G1SdEnrIeOuFrZWs3c8MiCnFHOzSc4x9V2GCn/2HwMKDJYMqy2KhMZfgMOAu+6fzw/1TXEQhcMv
	ee5YZHTNxG7nsCQ4msXlGGBm3ZO4=
X-Google-Smtp-Source: AGHT+IGkvK5pixztn9sJQZu79MCLs0d1XQzhe7H8Fef8sG/DUFLsNJk2g2tAT5VnVICglfEBKYmGRG/dZJU0jOPs8Vc=
X-Received: by 2002:a05:6870:6b0b:b0:29e:5e83:150e with SMTP id
 586e51a60fabf-2c78051a8a4mr13924028fac.27.1743002082280; Wed, 26 Mar 2025
 08:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <33882f284ac6e6d1ec766ca4bb2f3b88@intel.com> <f18607ca-30dc-43de-be77-fec69968aeec@arm.com>
 <SJ2PR11MB7670F63C7052C88637D305DF8DDF2@SJ2PR11MB7670.namprd11.prod.outlook.com>
 <1ae51ccc-66cc-4551-b649-2f5883e2f5a2@acm.org> <SJ2PR11MB7670B2AEFF7C0DABE6856F258DA62@SJ2PR11MB7670.namprd11.prod.outlook.com>
In-Reply-To: <SJ2PR11MB7670B2AEFF7C0DABE6856F258DA62@SJ2PR11MB7670.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Mar 2025 16:14:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j3zPJEi668m4Gmf_0Z+6pyg4=HXTVuNJ4FwzZJWbVcYQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoQyitOx9WQOleqtV5zU36LAXSsEfsxPh3YcfUmrndZM6dk-5HrHuzMrvA
Message-ID: <CAJZ5v0j3zPJEi668m4Gmf_0Z+6pyg4=HXTVuNJ4FwzZJWbVcYQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psd: add power sleep demotion prevention for
 fast I/O devices
To: "King, Colin" <colin.king@intel.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Christian Loehle <christian.loehle@arm.com>, 
	Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 4:04=E2=80=AFPM King, Colin <colin.king@intel.com> =
wrote:
>
> Hi,
>
> > -----Original Message-----
> > From: Bart Van Assche <bvanassche@acm.org>
> > Sent: 23 March 2025 12:36
> > To: King, Colin <colin.king@intel.com>; Christian Loehle
> > <christian.loehle@arm.com>; Jens Axboe <axboe@kernel.dk>; Rafael J.
> > Wysocki <rafael@kernel.org>; Daniel Lezcano <daniel.lezcano@linaro.org>=
;
> > linux-block@vger.kernel.org; linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] cpuidle: psd: add power sleep demotion prevention =
for
> > fast I/O devices
> >
> > On 3/17/25 3:03 AM, King, Colin wrote:
> > > This code is optional, one can enable it or disable it via the config
> > > option. Also, even when it is built-in one can disable it by writing =
0 to the
> > sysfs file
> > >    /sys/devices/system/cpu/cpuidle/psd_cpu_lat_timeout_ms
> >
> > I'm not sure we need even more configuration knobs in sysfs.
>
> It's useful for enabling / disabling the functionality, as well as some f=
orm of tuning for slower I/O devices, so I think it is justifiable.
>
> > How are users
> > expected to find this configuration option? How should they decide whet=
her
> > to enable or to disable it?
>
> I can send a V2 with some documentation if that's required.

It would be useful because the original patch didn't get to linux-pm
(among other things).

> >
> > Please take a look at this proposal and let me know whether this would =
solve
> > the issue that you are looking into: "[LSF/MM/BPF Topic] Energy- Effici=
ent I/O"
> > (https://lore.kernel.org/linux-block/ad1018b6-7c0b-4d70-
> > b845-c869287d3cf3@acm.org/). The only disadvantage of this approach
> > compared to the cpuidle patch is that it requires RPM (runtime power
> > management) to be enabled. Maybe I should look into modifying the
> > approach such that it does not rely on RPM.
>
> I've had a look, the scope of my patch is a bit wider.  If my patch gets =
accepted I'm
> going to also look at putting the psd call into other devices (such as ne=
twork devices) to
> also stop deep states while these devices are busy.  Since the code is ve=
ry lightweight I
> was hoping this was going to be relatively easy and simple to use in vari=
ous devices in the future.

But I'm generally wondering why this is using a completely new
mechanism instead of CPU latency QoS which is there and why is menu
the only governor targeted by it?


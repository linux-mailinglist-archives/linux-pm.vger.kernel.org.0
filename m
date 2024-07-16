Return-Path: <linux-pm+bounces-11146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 761C59325C8
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 13:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989C11C22602
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 11:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F571991C5;
	Tue, 16 Jul 2024 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjL081Wu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20DC15491;
	Tue, 16 Jul 2024 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129805; cv=none; b=G+8r6U+zH75VZ8pg4A0v69aolO41HYm86W5ut3v4bMyH93n0zVYYu2jE2XZSq1oOVZyU2fz/fhQuLqLpCsEm4a0hrm8ygXj13eK0USieglPQDTdrNkek9OXVNU1q1ZHoe/1BQmkW2cxm8gPrM30wAMAvrLmiQBgXe+kDG7/rePY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129805; c=relaxed/simple;
	bh=YoogwUfXxUBk+1CS11WqVO/G9/wXXAA1h/+2yjXFWe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXyhSyntJjXkcMUCPan99N0xyvegq++WbwO+Pvmuj3DIiTrOc/cGDfVcsEfc30lb7suS3cfORJdpmsLF3xFvRUE+KwTfAiRf/RXaYmXV/rdQlRMAxozVnbQiGg+QskaWrPWwNPC5P3H6c2DcZMDfJFgNFMwuf0dmXvlEdMkLqxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjL081Wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F04C116B1;
	Tue, 16 Jul 2024 11:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721129805;
	bh=YoogwUfXxUBk+1CS11WqVO/G9/wXXAA1h/+2yjXFWe8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RjL081WuhqSNhE9RW7Y4we/6E6s9MDpT+roQpySr4yk/WtOFzSkshF/MFD4FKK0K4
	 mnEkykRQY1tsfNGbLbQ6bvXAfFSVKXNEsc86HpOzeGClONFQcsAwgZ5OeeiXZe3vNa
	 pt6GkRupzxU9x/yXYCBMwQO1GgRTnKPFHGlVkEJTOFRtFmAx4nqDVPFyJSgtNihxCN
	 EiKwW6WRqgEGVAoSOpdIt4AZhtRuDr//sUkCsHJn4fXjH+62Dg6URZrElwYECUI7Yi
	 j9XVrpK19Jltt+l3Z+3iX7645vvMDz/6wliC9i4Ta4yw0TiGw/Fb1PSco4PwAoEorv
	 1IAh8mcvcEpEw==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d9dd8bc70dso482464b6e.2;
        Tue, 16 Jul 2024 04:36:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2vPoHQbuSlr7SbWBhF+5rgTX+b/Ul4Q4oXsefhaFpF3a1MxNESsZ0z5FIOgSWlwzx7NGM+iApYNxjJAoZcEAcMd/eJ0+q/QCSg8eKRNVVf2Xvhx0LzRjxEQXVCwP2uLUX8qp7T/o=
X-Gm-Message-State: AOJu0YzZ6KZ39zaYkP6vSvuHwVMfVzkbj9BS5xOiDgADc2aTwL0R1o5D
	NZZDM+74XUYDBxEmF2TRCOq3gMxBZnZ/dG7Kfv4lsagn1f91ULD0mftnWlmy8IYMyjuQIFzyuNd
	vbjKmDpK+tcNOf0mMxlsIcBZUr7E=
X-Google-Smtp-Source: AGHT+IGFySywAJ/ePXHY1qUDpP+S++4rDb9b+dHjDso32weFwIaQLytsfo1Y/ZtvrRcRWH2DKRkG5GeqUveRgN2b02M=
X-Received: by 2002:a05:687c:2ba1:b0:25e:24d5:4d69 with SMTP id
 586e51a60fabf-260b89c4041mr1836938fac.2.1721129804640; Tue, 16 Jul 2024
 04:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6064157.lOV4Wx5bFT@rjwysocki.net> <20240715044527.GA1544@sol.localdomain>
 <4d7e11a7-b352-4ced-acee-b5f64e3cd0b6@linaro.org> <CAJZ5v0gx6GyKBYt7YMFwmUQ4OCG49d9k2H=P-4Awr-mJ=eFHKw@mail.gmail.com>
 <20240715145426.199c31d0@mir> <CAJZ5v0gPiwkNczZhCf_rkxVoUX33tS9c6irMf_7=Rg48Nw9C4w@mail.gmail.com>
 <20240716014830.243bb0cf@mir> <CAJZ5v0jkA72=avuthGkrS5iu_UGEQeaEp7LjedXCpzamcnRKsA@mail.gmail.com>
 <20240716125538.09f716d1@mir> <20240716131500.35cf4f00@mir>
In-Reply-To: <20240716131500.35cf4f00@mir>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Jul 2024 13:36:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j2w-8c83Lw6OdJGg53pOKQMdeWiwaNkEEThwE6fXLiHQ@mail.gmail.com>
Message-ID: <CAJZ5v0j2w-8c83Lw6OdJGg53pOKQMdeWiwaNkEEThwE6fXLiHQ@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Eric Biggers <ebiggers@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 1:15=E2=80=AFPM Stefan Lippers-Hollmann <s.l-h@gmx.=
de> wrote:
>
> Hi
>
> On 2024-07-16, Stefan Lippers-Hollmann wrote:
> > On 2024-07-16, Rafael J. Wysocki wrote:
> > > On Tue, Jul 16, 2024 at 1:48=E2=80=AFAM Stefan Lippers-Hollmann <s.l-=
h@gmx.de> wrote:
> > > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > > On Mon, Jul 15, 2024 at 2:54=E2=80=AFPM Stefan Lippers-Hollmann <=
s.l-h@gmx.de> wrote:
> > > > > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > > > > On Mon, Jul 15, 2024 at 11:09=E2=80=AFAM Daniel Lezcano
> > > > > > > <daniel.lezcano@linaro.org> wrote:
> > > > > > > > On 15/07/2024 06:45, Eric Biggers wrote:
> > > > > > > > > On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J. Wysoc=
ki wrote:
> > > > > > > > >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > [...]
> > > > > > Silencing the warnings is already a big improvement - and that =
patch
> > > > > > works to this extent for me with an ax200, thanks.
> > > > >
> > > > > So attached is a patch that should avoid enabling the thermal zon=
e
> > > > > when it is not ready for use in the first place, so it should add=
ress
> > > > > both the message and the useless polling.
> > > > >
> > > > > I would appreciate giving it a go (please note that it hasn't rec=
eived
> > > > > much testing so far, though).
> > > >
> > > > Sadly this patch doesn't seem to help:
> > >
> > > This is likely because it is missing checks for firmware image type.
> > > I've added them to the attached new version.  Please try it.
> > >
> > > I've also added two pr_info() messages to get a better idea of what's
> > > going on, so please grep dmesg for "Thermal zone not ready" and
> > > "Enabling thermal zone".
> >
> > This is the output with the patch applied:
>
> The ax200 wlan interface is currently not up/ configured (system
> using its wired ethernet cards instead), the thermal_zone1 stops
> if I manually enable the interface (ip link set dev wlp4s0 up)
> after booting up:

This explains it, thanks!

The enabling of the thermal zone in iwl_mvm_load_ucode_wait_alive() is
premature or it should get disabled in the other two places that clear
the IWL_MVM_STATUS_FIRMWARE_RUNNING bit.

I'm not sure why the thermal zone depends on whether or not this bit
is set, though. Is it really a good idea to return errors from it if
the interface is not up?

> $ dmesg | grep -i -e iwlwifi -e thermal
> [    0.080899] CPU0: Thermal monitoring enabled (TM1)
> [    0.113768] thermal_sys: Registered thermal governor 'fair_share'
> [    0.113770] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.113771] thermal_sys: Registered thermal governor 'step_wise'
> [    0.113772] thermal_sys: Registered thermal governor 'user_space'
> [    0.113773] thermal_sys: Registered thermal governor 'power_allocator'
> [    3.759673] iwlwifi 0000:04:00.0: enabling device (0140 -> 0142)
> [    3.764918] iwlwifi 0000:04:00.0: Detected crf-id 0x3617, cnv-id 0x100=
530 wfpm id 0x80000000
> [    3.764974] iwlwifi 0000:04:00.0: PCI dev 2723/0084, rev=3D0x340, rfid=
=3D0x10a100
> [    3.769432] iwlwifi 0000:04:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 8=
9.3.35.37
> [    3.873466] iwlwifi 0000:04:00.0: loaded firmware version 77.a20fb07d.=
0 cc-a0-77.ucode op_mode iwlmvm
> [    3.907122] iwlwifi 0000:04:00.0: Detected Intel(R) Wi-Fi 6 AX200 160M=
Hz, REV=3D0x340
> [    3.907886] iwl_mvm_thermal_zone_register: Thermal zone not ready
> [    4.032380] iwlwifi 0000:04:00.0: Detected RF HR B3, rfid=3D0x10a100
> [    4.032392] thermal thermal_zone1: Enabling thermal zone
> [    4.098308] iwlwifi 0000:04:00.0: base HW address: 94:e6:f7:XX:XX:XX
> [    4.112535] thermal thermal_zone1: failed to read out thermal zone (-6=
1)
> [    4.128306] iwlwifi 0000:04:00.0 wlp4s0: renamed from wlan0
> [    4.369396] thermal thermal_zone1: failed to read out thermal zone (-6=
1)
> [    4.625385] thermal thermal_zone1: failed to read out thermal zone (-6=
1)
> [    4.881416] thermal thermal_zone1: failed to read out thermal zone (-6=
1)
> [    5.137377] thermal thermal_zone1: failed to read out thermal zone (-6=
1)
> [    5.394377] thermal thermal_zone1: failed to read out thermal zone (-6=
1)
> [    5.649412] thermal thermal_zone1: failed to read out thermal zone (-6=
1)
> [    5.905379] thermal thermal_zone1: failed to read out thermal zone (-6=
1)
> [    6.161380] thermal thermal_zone1: failed to read out thermal zone (-6=
1)
> [    6.418381] thermal thermal_zone1: failed to read out thermal zone (-6=
1)
> [    6.673381] thermal thermal_zone1: failed to read out thermal zone (-6=
1)
> [    6.929377] thermal thermal_zone1: failed to read out thermal zone (-6=
1)
>                [...]
> [   21.009413] thermal thermal_zone1: failed to read out thermal zone (-6=
1)
> [   21.265496] thermal thermal_zone1: failed to read out thermal zone (-6=
1)
> [   21.521462] thermal thermal_zone1: failed to read out thermal zone (-6=
1)
> [   21.777481] thermal thermal_zone1: failed to read out thermal zone (-6=
1)
> [   22.033468] thermal thermal_zone1: failed to read out thermal zone (-6=
1)
> [   22.213120] thermal thermal_zone1: Enabling thermal zone
> [   22.283954] iwlwifi 0000:04:00.0: Registered PHC clock: iwlwifi-PTP, w=
ith index: 0

Thanks for this data point!

AFAICS the thermal zone in iwlwifi is always enabled, but only valid
if the interface is up.  It looks to me like the thermal core needs a
special "don't poll me" error code to be returned in such cases.


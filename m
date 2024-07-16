Return-Path: <linux-pm+bounces-11150-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA62932665
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 14:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787881F22A9C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 12:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBDF17CA10;
	Tue, 16 Jul 2024 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6oFMW57"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680B413C690;
	Tue, 16 Jul 2024 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721132328; cv=none; b=KKsLd7mnbLcQK2IuOf7iodi/eZ8xnOuk0aIWHGEu4Sel7FbtD4HoLX2On2AvidEVc4ElK9Y8u1do2MpwP0Fvpp3PfKp5GSFLzn0EA6iJXHnT+CU44BK75G9d4nY6NYRfbfb/HHRCA0YbaXfsbBUJ9f6oWvOSLz94uJYE8R2fJdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721132328; c=relaxed/simple;
	bh=FDLsFj/j7/0aJWOvOswPbb/rMJRj8vsDAO8E+cJk9XY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeD5TACv/3JyOGREA88GfRTYzGiNinTqyf5SlqxZVqQ9nGXFkITGhjcvlnzlOVdR5h09xZ+rNgu6AvM2gfVWNIVrVSi6fuyfWix6PDxgZ9/eqM/0cvzRN/Nb/6MfSDtDKfMuiB/GzMFQfYGf9xBJwQ9phc9BWy3xwGX0pyqOl9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6oFMW57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE490C116B1;
	Tue, 16 Jul 2024 12:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721132328;
	bh=FDLsFj/j7/0aJWOvOswPbb/rMJRj8vsDAO8E+cJk9XY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X6oFMW57qgQ5YpqnjZoPBYDc6f3j3r9NrAynIONY/WxXKY5aIFsZILq0Ct/AbSoim
	 pWFN1rV35QsQ7ORxDO8dRm9IxR2iTrYm5xjbay7SUI021SxnUfMO8CafepESCXeHw/
	 N6Gt7GruNVwF/5eR+7i+Y0Q+/zSmLBCifDYK01L4f84zF7bnaIafC80u0Oq7C7iojM
	 4fOxhvJ5GuTMjtUY4pyWhk+XprtPG5nDoFt9g4XX59tV965klln4pXzm7JCW6GLPRo
	 +MlH34uRTwG3Us66WcCyoHX9hL2EKJU5FtoA3r4Nipdy0arnxBD4t2vmwXXrBsiyhf
	 7CC/HvRbXvC3w==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5cf146a82a5so94890eaf.3;
        Tue, 16 Jul 2024 05:18:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUE1WPzlTLIxFlN1I4AGY48ePxpDNW8vie1VhmY9oiYYpdIDDgn4Ri0/Ri64QDYix2M7Ry7upm/6i+yLueqq2LjyBt95RjL8FCfMK/DLuVy+vFHGEWtzkgPSujV3AdpNwD5AovWT0U=
X-Gm-Message-State: AOJu0YxpGxVQ4VzF7c6FTJN9kSTpLSXAp/UzIbt0RCkU9vp8YPlhVNeO
	7iF/G2PjjkHVUbWL3i8wu9Pr6ZGRVyVyTWPbPdVNtqVO0TiDwq3ODO6eL04O4aXH/ys2qCX7CrW
	HHUOTa4TewZJMvecnBbw/1M4aLuY=
X-Google-Smtp-Source: AGHT+IGRuW3fPMDNKIDP464lg/EsyFgzKv+qXxHQoeyl4NruNjCNpP0eDkGH37+kFiig+YoZznBTCUTcdbIjQX4QaAM=
X-Received: by 2002:a4a:4308:0:b0:5c7:aeba:77a0 with SMTP id
 006d021491bc7-5d25035be58mr2055249eaf.0.1721132327279; Tue, 16 Jul 2024
 05:18:47 -0700 (PDT)
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
 <CAJZ5v0j2w-8c83Lw6OdJGg53pOKQMdeWiwaNkEEThwE6fXLiHQ@mail.gmail.com> <3238291f-9d2a-4308-98fe-4765d7e1bcfb@linaro.org>
In-Reply-To: <3238291f-9d2a-4308-98fe-4765d7e1bcfb@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Jul 2024 14:18:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jk+VCO7mk9Ox=t1ijn7cMbto5qNbEgc9V0qPswSY_Ezw@mail.gmail.com>
Message-ID: <CAJZ5v0jk+VCO7mk9Ox=t1ijn7cMbto5qNbEgc9V0qPswSY_Ezw@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Stefan Lippers-Hollmann <s.l-h@gmx.de>, Eric Biggers <ebiggers@kernel.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 2:10=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 16/07/2024 13:36, Rafael J. Wysocki wrote:
> > On Tue, Jul 16, 2024 at 1:15=E2=80=AFPM Stefan Lippers-Hollmann <s.l-h@=
gmx.de> wrote:
> >>
> >> Hi
> >>
> >> On 2024-07-16, Stefan Lippers-Hollmann wrote:
> >>> On 2024-07-16, Rafael J. Wysocki wrote:
> >>>> On Tue, Jul 16, 2024 at 1:48=E2=80=AFAM Stefan Lippers-Hollmann <s.l=
-h@gmx.de> wrote:
> >>>>> On 2024-07-15, Rafael J. Wysocki wrote:
> >>>>>> On Mon, Jul 15, 2024 at 2:54=E2=80=AFPM Stefan Lippers-Hollmann <s=
.l-h@gmx.de> wrote:
> >>>>>>> On 2024-07-15, Rafael J. Wysocki wrote:
> >>>>>>>> On Mon, Jul 15, 2024 at 11:09=E2=80=AFAM Daniel Lezcano
> >>>>>>>> <daniel.lezcano@linaro.org> wrote:
> >>>>>>>>> On 15/07/2024 06:45, Eric Biggers wrote:
> >>>>>>>>>> On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J. Wysocki wr=
ote:
> >>>>>>>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>> [...]
> >>>>>>> Silencing the warnings is already a big improvement - and that pa=
tch
> >>>>>>> works to this extent for me with an ax200, thanks.
> >>>>>>
> >>>>>> So attached is a patch that should avoid enabling the thermal zone
> >>>>>> when it is not ready for use in the first place, so it should addr=
ess
> >>>>>> both the message and the useless polling.
> >>>>>>
> >>>>>> I would appreciate giving it a go (please note that it hasn't rece=
ived
> >>>>>> much testing so far, though).
> >>>>>
> >>>>> Sadly this patch doesn't seem to help:
> >>>>
> >>>> This is likely because it is missing checks for firmware image type.
> >>>> I've added them to the attached new version.  Please try it.
> >>>>
> >>>> I've also added two pr_info() messages to get a better idea of what'=
s
> >>>> going on, so please grep dmesg for "Thermal zone not ready" and
> >>>> "Enabling thermal zone".
> >>>
> >>> This is the output with the patch applied:
> >>
> >> The ax200 wlan interface is currently not up/ configured (system
> >> using its wired ethernet cards instead), the thermal_zone1 stops
> >> if I manually enable the interface (ip link set dev wlp4s0 up)
> >> after booting up:
> >
> > This explains it, thanks!
> >
> > The enabling of the thermal zone in iwl_mvm_load_ucode_wait_alive() is
> > premature or it should get disabled in the other two places that clear
> > the IWL_MVM_STATUS_FIRMWARE_RUNNING bit.
> >
> > I'm not sure why the thermal zone depends on whether or not this bit
> > is set, though. Is it really a good idea to return errors from it if
> > the interface is not up?
> >
> >> $ dmesg | grep -i -e iwlwifi -e thermal
> >> [    0.080899] CPU0: Thermal monitoring enabled (TM1)
> >> [    0.113768] thermal_sys: Registered thermal governor 'fair_share'
> >> [    0.113770] thermal_sys: Registered thermal governor 'bang_bang'
> >> [    0.113771] thermal_sys: Registered thermal governor 'step_wise'
> >> [    0.113772] thermal_sys: Registered thermal governor 'user_space'
> >> [    0.113773] thermal_sys: Registered thermal governor 'power_allocat=
or'
> >> [    3.759673] iwlwifi 0000:04:00.0: enabling device (0140 -> 0142)
> >> [    3.764918] iwlwifi 0000:04:00.0: Detected crf-id 0x3617, cnv-id 0x=
100530 wfpm id 0x80000000
> >> [    3.764974] iwlwifi 0000:04:00.0: PCI dev 2723/0084, rev=3D0x340, r=
fid=3D0x10a100
> >> [    3.769432] iwlwifi 0000:04:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version=
: 89.3.35.37
> >> [    3.873466] iwlwifi 0000:04:00.0: loaded firmware version 77.a20fb0=
7d.0 cc-a0-77.ucode op_mode iwlmvm
> >> [    3.907122] iwlwifi 0000:04:00.0: Detected Intel(R) Wi-Fi 6 AX200 1=
60MHz, REV=3D0x340
> >> [    3.907886] iwl_mvm_thermal_zone_register: Thermal zone not ready
> >> [    4.032380] iwlwifi 0000:04:00.0: Detected RF HR B3, rfid=3D0x10a10=
0
> >> [    4.032392] thermal thermal_zone1: Enabling thermal zone
> >> [    4.098308] iwlwifi 0000:04:00.0: base HW address: 94:e6:f7:XX:XX:X=
X
> >> [    4.112535] thermal thermal_zone1: failed to read out thermal zone =
(-61)
> >> [    4.128306] iwlwifi 0000:04:00.0 wlp4s0: renamed from wlan0
> >> [    4.369396] thermal thermal_zone1: failed to read out thermal zone =
(-61)
> >> [    4.625385] thermal thermal_zone1: failed to read out thermal zone =
(-61)
> >> [    4.881416] thermal thermal_zone1: failed to read out thermal zone =
(-61)
> >> [    5.137377] thermal thermal_zone1: failed to read out thermal zone =
(-61)
> >> [    5.394377] thermal thermal_zone1: failed to read out thermal zone =
(-61)
> >> [    5.649412] thermal thermal_zone1: failed to read out thermal zone =
(-61)
> >> [    5.905379] thermal thermal_zone1: failed to read out thermal zone =
(-61)
> >> [    6.161380] thermal thermal_zone1: failed to read out thermal zone =
(-61)
> >> [    6.418381] thermal thermal_zone1: failed to read out thermal zone =
(-61)
> >> [    6.673381] thermal thermal_zone1: failed to read out thermal zone =
(-61)
> >> [    6.929377] thermal thermal_zone1: failed to read out thermal zone =
(-61)
> >>                 [...]
> >> [   21.009413] thermal thermal_zone1: failed to read out thermal zone =
(-61)
> >> [   21.265496] thermal thermal_zone1: failed to read out thermal zone =
(-61)
> >> [   21.521462] thermal thermal_zone1: failed to read out thermal zone =
(-61)
> >> [   21.777481] thermal thermal_zone1: failed to read out thermal zone =
(-61)
> >> [   22.033468] thermal thermal_zone1: failed to read out thermal zone =
(-61)
> >> [   22.213120] thermal thermal_zone1: Enabling thermal zone
> >> [   22.283954] iwlwifi 0000:04:00.0: Registered PHC clock: iwlwifi-PTP=
, with index: 0
> >
> > Thanks for this data point!
> >
> > AFAICS the thermal zone in iwlwifi is always enabled, but only valid
> > if the interface is up.  It looks to me like the thermal core needs a
> > special "don't poll me" error code to be returned in such cases.
>
>  From my POV, it is not up to the thermal core to adapt to the driver.

The core provides a service to its users, not the other way around,
and this is a valid use case.

The owner of the thermal zone knows that it is only useful when the
interface is up and so it should be possible for them to indicate to
the core that, for the time being, nothing needs to be done.

> Usually network devices have ops when they are transitioning to up or
> down, would it make sense to move enable / disable the thermal zone in
> these ops ?

Not really, because it can be enabled and disabled via sysfs in the meantim=
e.


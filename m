Return-Path: <linux-pm+bounces-11145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3D3932578
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 13:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 276B5B20A03
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 11:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2332A199246;
	Tue, 16 Jul 2024 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoCLo+Iv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF62F199249;
	Tue, 16 Jul 2024 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128762; cv=none; b=BhBvr/QDG0fUgww11T7C4aVzabVuJaZmfFuxRLQs0oOnJZ9VNwupC+TUrZIBO5IfhtZFAj8+tDSBYSfNdSIOY3KLilpERa3+OXg511f75y6J2YB6Kq0O0x31wy+flkc0k3JlYj+LsIfvO71SBkwWbBIyly+NPyfptqLXlldcKCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128762; c=relaxed/simple;
	bh=+bjtpk/WZ9ZTNUZo45tPUtHqBKNRWIGmjPImF3wpBP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXajG+Kt42rwriJgd5Xl0o/6a82l/bl6sL53kzsRH4rqRjxtSan/G1zAU5Den0iLtUaZHBKkpaXtdTM1NZGf6oX7xJ3MuljysoWT4rt4cC4/vXu5+xqCfw0DWmtStX1vohuYsM24zF3wWgE8L9qLRxYaYE+e4wrrYrzEFDfrFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoCLo+Iv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C12EC4AF09;
	Tue, 16 Jul 2024 11:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721128761;
	bh=+bjtpk/WZ9ZTNUZo45tPUtHqBKNRWIGmjPImF3wpBP0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HoCLo+IvxhFVMKhZguRiZ580DBTrG7IQu1TSBh1M0OTYfAD3hnzCa21o9fcFu817r
	 f/SIEcIaxalYfGZm6cCOvdatLbMD6QUXTsA5Y4HfA1pU2KpZo5JDXff/rNilIINiwq
	 QIEtxpN93vmfd3Ht8T+EAqWXsQtyC7RqGMmASVZkwR1eUlqDTKDC04D++5cF6YqDOo
	 YGK/YFNielWgDiBNKg/QWmkWwOwnV9BB+MAZh+UXb5T7MEssoPq3fBi0oh0SGhLVhh
	 RMuRqWG8HqTLdBl/XqdD3WrODkAbQguz2ETap855EHeRp19p52vgF9woO86IAQlcUX
	 wdEDUWbUAtcKg==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ce3accb2c4so95895eaf.0;
        Tue, 16 Jul 2024 04:19:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdaZkvDilO/eVO87ejYOVrRrtfQPECiTMFKXOCO7o3qJj+JvTFg2zVc/JM5pq7HXtUxfHd150w1Xs=@vger.kernel.org, AJvYcCXh2xqy3uAtdNFoqcdr6qVKNyGdwrcOviEz5XdVWQzaQv6imeMVtiF5EiyOuafrofWXLzexhfmsRDs8r/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxERRulTGwGV3H6ioEZHYnuhmvun+6jRJ2/tuVaMLV6WHlfhsun
	JtAjIbDbQgFFj8oPWMowRYX6aayA/YRPlYz9jzdrUF5lX5ttPh14yB9zAt0IsnqMLjWOzpGbvvH
	06+8NgH1F9+deNztbmi7JRp2vLoE=
X-Google-Smtp-Source: AGHT+IFB+toAcJ9oQF6PgHtOqv1KXVYqpoNwhEt+PppTRqRvBU6hlWufOC2Jib8xWsrNHnmJQj3IxmaUFk0IZTzgik8=
X-Received: by 2002:a4a:4308:0:b0:5c7:aeba:77a0 with SMTP id
 006d021491bc7-5d25035be58mr1942823eaf.0.1721128760733; Tue, 16 Jul 2024
 04:19:20 -0700 (PDT)
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
 <20240716125538.09f716d1@mir>
In-Reply-To: <20240716125538.09f716d1@mir>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Jul 2024 13:19:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gPz6RzJfEerDghbm=3zv6cjwUM+r26ywo+rO0dYduM5w@mail.gmail.com>
Message-ID: <CAJZ5v0gPz6RzJfEerDghbm=3zv6cjwUM+r26ywo+rO0dYduM5w@mail.gmail.com>
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

On Tue, Jul 16, 2024 at 12:55=E2=80=AFPM Stefan Lippers-Hollmann <s.l-h@gmx=
.de> wrote:
>
> Hi
>
> On 2024-07-16, Rafael J. Wysocki wrote:
> > On Tue, Jul 16, 2024 at 1:48=E2=80=AFAM Stefan Lippers-Hollmann <s.l-h@=
gmx.de> wrote:
> > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > On Mon, Jul 15, 2024 at 2:54=E2=80=AFPM Stefan Lippers-Hollmann <s.=
l-h@gmx.de> wrote:
> > > > > On 2024-07-15, Rafael J. Wysocki wrote:
> > > > > > On Mon, Jul 15, 2024 at 11:09=E2=80=AFAM Daniel Lezcano
> > > > > > <daniel.lezcano@linaro.org> wrote:
> > > > > > > On 15/07/2024 06:45, Eric Biggers wrote:
> > > > > > > > On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J. Wysocki=
 wrote:
> > > > > > > >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > [...]
> > > > > Silencing the warnings is already a big improvement - and that pa=
tch
> > > > > works to this extent for me with an ax200, thanks.
> > > >
> > > > So attached is a patch that should avoid enabling the thermal zone
> > > > when it is not ready for use in the first place, so it should addre=
ss
> > > > both the message and the useless polling.
> > > >
> > > > I would appreciate giving it a go (please note that it hasn't recei=
ved
> > > > much testing so far, though).
> > >
> > > Sadly this patch doesn't seem to help:
> >
> > This is likely because it is missing checks for firmware image type.
> > I've added them to the attached new version.  Please try it.
> >
> > I've also added two pr_info() messages to get a better idea of what's
> > going on, so please grep dmesg for "Thermal zone not ready" and
> > "Enabling thermal zone".
>
> This is the output with the patch applied:

Thanks for testing!

> $ dmesg | grep -i -e iwlwifi -e thermal
> [    0.081026] CPU0: Thermal monitoring enabled (TM1)
> [    0.113898] thermal_sys: Registered thermal governor 'fair_share'
> [    0.113900] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.113901] thermal_sys: Registered thermal governor 'step_wise'
> [    0.113902] thermal_sys: Registered thermal governor 'user_space'
> [    0.113903] thermal_sys: Registered thermal governor 'power_allocator'
> [    3.917770] iwlwifi 0000:04:00.0: enabling device (0140 -> 0142)
> [    3.926543] iwlwifi 0000:04:00.0: Detected crf-id 0x3617, cnv-id 0x100=
530 wfpm id 0x80000000
> [    3.926551] iwlwifi 0000:04:00.0: PCI dev 2723/0084, rev=3D0x340, rfid=
=3D0x10a100
> [    3.936737] iwlwifi 0000:04:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 8=
9.3.35.37
> [    4.021494] iwlwifi 0000:04:00.0: loaded firmware version 77.a20fb07d.=
0 cc-a0-77.ucode op_mode iwlmvm
> [    4.347478] iwlwifi 0000:04:00.0: Detected Intel(R) Wi-Fi 6 AX200 160M=
Hz, REV=3D0x340
> [    4.347616] iwl_mvm_thermal_zone_register: Thermal zone not ready

So this means that iwl_mvm_thermal_zone_register() sees that the
thermal zone is not ready and returns without enabling it.  So far so
good.

> [    4.478749] iwlwifi 0000:04:00.0: Detected RF HR B3, rfid=3D0x10a100
> [    4.478777] thermal thermal_zone2: Enabling thermal zone

This means that iwl_mvm_load_ucode_wait_alive() has called
iwl_mvm_thermal_tzone_enable() for thermal_zone2 after checking that
the firmware image type is IWL_UCODE_REGULAR and after setting
IWL_MVM_STATUS_FIRMWARE_RUNNING is mvm->status.

> [    4.543601] iwlwifi 0000:04:00.0: base HW address: 94:e6:f7:XX:XX:XX
> [    4.559564] thermal thermal_zone2: failed to read out thermal zone (-6=
1)

And interestingly enough, iwl_mvm_tzone_get_temp() sees that
IWL_MVM_STATUS_FIRMWARE_RUNNING is not set in mvm->status or the
firmware image type is not IWL_UCODE_REGULAR.  I'm guessing the
former.

> [    4.602339] iwlwifi 0000:04:00.0 wlp4s0: renamed from wlan0
> [    4.810373] thermal thermal_zone2: failed to read out thermal zone (-6=
1)
> [    5.066381] thermal thermal_zone2: failed to read out thermal zone (-6=
1)
> [    5.322385] thermal thermal_zone2: failed to read out thermal zone (-6=
1)
> [    5.579377] thermal thermal_zone2: failed to read out thermal zone (-6=
1)
> [    5.834375] thermal thermal_zone2: failed to read out thermal zone (-6=
1)
> [    6.091372] thermal thermal_zone2: failed to read out thermal zone (-6=
1)
> [    6.346400] thermal thermal_zone2: failed to read out thermal zone (-6=
1)
>                [...]

Since there is only one place where IWL_MVM_STATUS_FIRMWARE_RUNNING is
set and that is in iwl_mvm_load_ucode_wait_alive(), I think that it is
cleared somewhere after iwl_mvm_load_ucode_wait_alive() has completed
and before iwl_mvm_tzone_get_temp() runs.


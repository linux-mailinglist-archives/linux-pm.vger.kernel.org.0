Return-Path: <linux-pm+bounces-10599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F06F92753E
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 13:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D1D1F24B17
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 11:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CB81ABCCE;
	Thu,  4 Jul 2024 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQZ2UcmW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CF916A397;
	Thu,  4 Jul 2024 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720093117; cv=none; b=qBgvOccrWpUM42jE0DfTcnHvl430Wfo3hYULdZYBYME/aqFfmQ4XDI2B8xNm42xu9eCHMwWlHCtZjsCa0aAG7j8QKqCgnHGh6f26dRYvNpbcH0tOprKSlLCRWOFQoXMbBZIVrDFXRCtqvyFPw6MlJFFT/IyYs9GH/+OQy2+ssXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720093117; c=relaxed/simple;
	bh=UxjWql28toiPuz8U2UObVRmU6by2h2Dosj9Dk8engTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Buc1tqb6pL7rOQTkK6GaXqBgPrhVyJ0tnk8sQHgu6I4hYNXfcwkoIx8w9v+wO6TU9NfSi98BDT5q2Px7czaq1XIU86rmMb440PnPX12Qc3vSsnZQq6LQRWUMeQyL93o6Hd1TpW88pUWZ2o+o6ZA5KzPjGTwvEhkgr0XFucdlaso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQZ2UcmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACF3C4AF0B;
	Thu,  4 Jul 2024 11:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720093116;
	bh=UxjWql28toiPuz8U2UObVRmU6by2h2Dosj9Dk8engTE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QQZ2UcmWC0iKCTuBPp/fZF2G/l+dOwDvSgs713TfHV3qDm+NCNRRrZ5dj8iWFnWwR
	 WmAaIkmr7E/h4uoW6WXxAPF04+EDH0t6EP0/AHV6mTWJXlD/i8j/XvfP65rqK9rmef
	 ovfuovl6IFK9tzdv1pkt/n30kJ3figByYu/KSwHMqqe/4dC98XkCW+5EXtsd46aAwP
	 LFrjo+odw/bJoCDI6d9tR6mxYoveWjTO7TUZ3NvBaYlqVljvCmIxCgrtygTiqot3A9
	 y4W+B9orN2+DfPzzRdl3zKpqXJEiKFZGUJuSBt3dw3hTJFCbMh/2qEr6UlDJHs6DPZ
	 ITaaEA1fEtVAw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-254925e6472so107043fac.0;
        Thu, 04 Jul 2024 04:38:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGZrh/4ZZHbdu3fOaLKQoIs6BHXMwFON8eCm8WeJZT3VEFWvuqL+PAt1AN20upEBrAD5VRAno9sCXXDIy/Ev/B4sXt46K4kHvvLN0SsEqv1RmWizpGb5itCAgFrpQXXJ5sFdZ6t1U=
X-Gm-Message-State: AOJu0YzPDwhVPpoBGgnimD+PGxZHKSYx7o2lj9Y4rBWllX0rt1wf9BAL
	lKlVgadTqhIhUtv2h1+P3Ixn6hdmxF5u7aaa1HfXO8+UH6KSis3rUrWf+e13fgZ8edtbmxXgksL
	ofX2PhPF7pthkODayPTKtHkcBFdQ=
X-Google-Smtp-Source: AGHT+IEicJ7mapfZzDhtYfCdNktn/cvbLbJKh2NZkvRmakchSZIBd9AXbsvAYwIm/M7PcXxBGxSL09djGQp4fmGtFhA=
X-Received: by 2002:a05:6870:5590:b0:25e:1817:e4a8 with SMTP id
 586e51a60fabf-25e2bf93ebcmr1381939fac.4.1720093116076; Thu, 04 Jul 2024
 04:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-power-allocator-null-trip-max-v1-1-47a60dc55414@collabora.com>
In-Reply-To: <20240702-power-allocator-null-trip-max-v1-1-47a60dc55414@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jul 2024 13:38:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gO45HrVkO5cqh2B3p_emsAyhf-G1HWfprc2cEzXkZu6w@mail.gmail.com>
Message-ID: <CAJZ5v0gO45HrVkO5cqh2B3p_emsAyhf-G1HWfprc2cEzXkZu6w@mail.gmail.com>
Subject: Re: [PATCH] thermal: gov_power_allocator: Return early in manage if
 trip_max is null
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Nikita Travkin <nikita@trvn.ru>, kernel@collabora.com, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 11:25=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Commit da781936e7c3 ("thermal: gov_power_allocator: Allow binding
> without trip points") allowed the governor to bind even when trip_max
> is null. This allows a null pointer dereference to happen in the manage
> callback. Add an early return to prevent it, since the governor is
> expected to not do anything in this case.
>
> Fixes: da781936e7c3 ("thermal: gov_power_allocator: Allow binding without=
 trip points")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> This issue was noticed by KernelCI during a boot test on the
> mt8195-cherry-tomato-r2 platform with the config in [1]. The stack trace
> is attached below.
>
> [1] http://0x0.st/XaON.txt
>
> [    4.015786] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000000000000000
> [    4.015791] Mem abort info:
> [    4.015793]   ESR =3D 0x0000000096000004
> [    4.015796]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [    4.015799]   SET =3D 0, FnV =3D 0
> [    4.015802]   EA =3D 0, S1PTW =3D 0
> [    4.015804]   FSC =3D 0x04: level 0 translation fault
> [    4.015807] Data abort info:
> [    4.015809]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
> [    4.015811]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> [    4.015814]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> [    4.015818] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000010980900=
0
> [    4.015821] [0000000000000000] pgd=3D0000000000000000, p4d=3D000000000=
0000000
> [    4.015835] Modules linked in: mt8195_mt6359(+) mt6577_auxadc snd_soc_=
mt8195_afe mtk_scp_ipi snd_sof_utils mtk_wdt(+)
> [    4.015852] CPU: 2 PID: 13 Comm: kworker/u32:1 Not tainted 6.10.0-rc6 =
#1 c5d519ae8e7fec6bbe67cb8c50bfebcb89dfa54e
> [    4.015859] Hardware name: Acer Tomato (rev2) board (DT)
> [    4.015862] Workqueue: events_unbound deferred_probe_work_func
> [    4.015875] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [    4.015880] pc : power_allocator_manage+0x110/0x6a0
> [    4.015888] lr : __thermal_zone_device_update+0x1dc/0x400
> [    4.015893] sp : ffff8000800eb800
> [    4.015895] x29: ffff8000800eb810 x28: 0000000000000001 x27: 000000000=
0000001
> [    4.015903] x26: aaaaaaaaaaaaaaab x25: ffff07a0461c15a0 x24: ffffb5853=
0ca67c0
> [    4.015911] x23: 0000000000000000 x22: ffff07a04098fcc0 x21: ffffb5853=
2eec848
> [    4.015918] x20: ffff8000800eb920 x19: ffff07a0461c1000 x18: 000000000=
0000b4b
> [    4.015926] x17: 5359534255530031 x16: ffffb585310352e4 x15: 000000000=
0000020
> [    4.015933] x14: 0000000000000000 x13: ffffffff00000000 x12: 000000000=
0000040
> [    4.015940] x11: 0101010101010101 x10: ffffffffffffffff x9 : ffffb5853=
0ca8d78
> [    4.015948] x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : 000000000=
0001388
> [    4.015955] x5 : 0000000000000000 x4 : 0000000000000384 x3 : 000000000=
0000000
> [    4.015962] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 000000000=
0000000
> [    4.015970] Call trace:
> [    4.015972]  power_allocator_manage+0x110/0x6a0
> [    4.015978]  __thermal_zone_device_update+0x1dc/0x400
> [    4.015983]  thermal_zone_device_set_mode+0x7c/0xa0
> [    4.015987]  thermal_zone_device_enable+0x1c/0x28
> [    4.015991]  thermal_of_zone_register+0x43c/0x498
> [    4.015996]  devm_thermal_of_zone_register+0x6c/0xb8
> [    4.016001]  gadc_thermal_probe+0x140/0x214
> [    4.016007]  platform_probe+0x70/0xc4
> [    4.016012]  really_probe+0x140/0x270
> [    4.016018]  __driver_probe_device+0xfc/0x114
> [    4.016024]  driver_probe_device+0x44/0x100
> [    4.016029]  __device_attach_driver+0x64/0xdc
> [    4.016035]  bus_for_each_drv+0xb4/0xdc
> [    4.016041]  __device_attach+0xdc/0x16c
> [    4.016046]  device_initial_probe+0x1c/0x28
> [    4.016052]  bus_probe_device+0x44/0xac
> [    4.016057]  deferred_probe_work_func+0xb0/0xc4
> [    4.016063]  process_scheduled_works+0x114/0x330
> [    4.016070]  worker_thread+0x1c0/0x20c
> [    4.016076]  kthread+0xf8/0x108
> [    4.016081]  ret_from_fork+0x10/0x20
> [    4.016090] Code: d1030294 17ffffdd f94012c0 f9401ed7 (b9400000)
> [    4.016095] ---[ end trace 0000000000000000 ]---
> ---
>  drivers/thermal/gov_power_allocator.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_=
power_allocator.c
> index 45f04a25255a..1b2345a697c5 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -759,6 +759,9 @@ static void power_allocator_manage(struct thermal_zon=
e_device *tz)
>                 return;
>         }
>
> +       if (!params->trip_max)
> +               return;
> +
>         allocate_power(tz, params->trip_max->temperature);
>         params->update_cdevs =3D true;
>  }
>
> ---

Applied as 6.10-rc material, thanks!


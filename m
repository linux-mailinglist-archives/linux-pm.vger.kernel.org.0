Return-Path: <linux-pm+bounces-10619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809ED927837
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 16:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357A5285C7A
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 14:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B091AEFF1;
	Thu,  4 Jul 2024 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QncApyWa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C62D2F5;
	Thu,  4 Jul 2024 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102998; cv=none; b=HvHeusSBkghQAmVin5hAtkqm2OKYczzmuYbi295gLvwR/En3orsbvc/2VyUURGlrnNJS5hQrndA+4tAaSfUs9QWFRPPfsZ2LAZwGrtXiYiYh3ZAViogSTfSAXUys/9vKLI1dkeCRkEZrso1YnMuad9Uk+IxEk3/sKc5IgZX6f+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102998; c=relaxed/simple;
	bh=aloMNONeHzWM6pJ4HQSv5bqmYxFhyM9yR/5jEjl6sqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwYFcybMfP4ojXYR8Wlx+W/3I4wtPqAh7Yr1dU4DAaTupgENU66xgfBMVXPTOxjZIklrAB0++INBeihTc9PjN1pK+KhIJGKZS76mWqzGiH8YGrwxRNGdPnZ9nHeavruyw8FwwT7o1OSKKqEHEUAqEi3MZXo5Ej5DrwWScaqEAKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QncApyWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BDBC4AF0A;
	Thu,  4 Jul 2024 14:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720102998;
	bh=aloMNONeHzWM6pJ4HQSv5bqmYxFhyM9yR/5jEjl6sqg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QncApyWa9O3ymuqzzz93GQKUZsd/HhdxSFA4EWtrTRbuElJZftqcSGzph7tPOQ4sM
	 +SKKrbIyptc4Tm9KkIp/NYIE9t5t2cAYAapMhMsu2rQkpi3/hglmEzHx4aSltwxr+Y
	 edbPhnUY8xoqiogF+Igt4jtkWXAAHsPMJ92wYibObVwSYLhdeD7uU7h2YCUgUIKh+3
	 /besecoVENgRVp+tVHVB6fQbbXJGt3JDwDUvt62oOfx1FmmFS++e/Sds9ZM8eLBoJe
	 SwVWEcjxW6mWVQc8VXshGYWtIPNJXHUdzerVUNfSvAQPbfzV7PM/FJJTFLH2r3viHp
	 qPvtUK/LsgU+Q==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-25dff23459cso84166fac.3;
        Thu, 04 Jul 2024 07:23:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUb+ohe+FGfJffyan3HSu5+7EYjfIMYMG8FhfWCKp616Lt+bHU1c/DcTpaBxIr26w1SiuR6vB0rlNY0NHDO8PiydPVAWe17EklxZ1p5xzUTH16r8Nj7mLIaOlnFYwMczM9pyZe9/Fs=
X-Gm-Message-State: AOJu0YxOuI9+ByOs9thrwGhuzUUHLtlJ8kDTYJGwBt/9Yl7gkxmNnfiT
	shpWDBfbvKglrKBAXVfsuSTGX76H7a0DGQHQ2XdR3vCSuKvV79MYSS+e7TKdaMmCfRWmtQdRicg
	cannPE+dv0aMf6SJGFx/NujFIqSg=
X-Google-Smtp-Source: AGHT+IEoPeWu5U/8WuycyyeUAGmCbKV+CCAS0ThNU2eyTx2eRQ7nrKoYCb7jtf7rLAoM9ZkN+/lGswx4MwGFhCcZf7U=
X-Received: by 2002:a05:6871:7988:b0:254:a7df:721b with SMTP id
 586e51a60fabf-25e2c06c433mr1928362fac.5.1720102997436; Thu, 04 Jul 2024
 07:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6064157.lOV4Wx5bFT@rjwysocki.net> <218d45a8-4c3d-453b-aded-d232c366da2c@linaro.org>
 <d30068aa-b0df-4ec7-9a6b-9d5c6b49b74e@linaro.org>
In-Reply-To: <d30068aa-b0df-4ec7-9a6b-9d5c6b49b74e@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jul 2024 16:23:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iSm7P23hC7C3PS98ES==7g=rEHgKtwtZihSH5W6ODu9A@mail.gmail.com>
Message-ID: <CAJZ5v0iSm7P23hC7C3PS98ES==7g=rEHgKtwtZihSH5W6ODu9A@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: neil.armstrong@linaro.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 4, 2024 at 2:52=E2=80=AFPM Neil Armstrong <neil.armstrong@linar=
o.org> wrote:
>
> Hi,
>
> On 04/07/2024 14:49, Daniel Lezcano wrote:
> > On 04/07/2024 13:46, Rafael J. Wysocki wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip()
> >> if zone temperature is invalid") caused __thermal_zone_device_update()
> >> to return early if the current thermal zone temperature was invalid.
> >>
> >> This was done to avoid running handle_thermal_trip() and governor
> >> callbacks in that case which led to confusion.  However, it went too
> >> far because monitor_thermal_zone() still needs to be called even when
> >> the zone temperature is invalid to ensure that it will be updated
> >> eventually in case thermal polling is enabled and the driver has no
> >> other means to notify the core of zone temperature changes (for exampl=
e,
> >> it does not register an interrupt handler or ACPI notifier).
> >>
> >> Also if the .set_trips() zone callback is expected to set up monitorin=
g
> >> interrupts for a thermal zone, it needs to be provided with valid
> >> boundaries and that can only be done if the zone temperature is known.
> >>
> >> Accordingly, to ensure that __thermal_zone_device_update() will
> >> run again after a failing zone temperature check, make it call
> >> monitor_thermal_zone() regardless of whether or not the zone
> >> temperature is valid and make the latter schedule a thermal zone
> >> temperature update if the zone temperature is invalid even if
> >> polling is not enabled for the thermal zone (however, if this
> >> continues to fail, give up after some time).
> >
> > Rafael,
> >
> > do we agree that we should fix somehow the current issue in this way be=
cause we are close to the merge window, but the proper fix is not doing tha=
t ?
>
> I've tested this patch, but I have no opinion about it.
>
> I sent https://lore.kernel.org/all/20240704-topic-sm8x50-upstream-fix-bat=
tmgr-temp-tz-warn-v1-1-9d66d6f6efde@linaro.org/ which
> fixes the warning print, leaving the option for thermal core to update th=
e tz once it becomes available,
> which is the initial goal of this patchset.

Thank you!

I gather that I can use the v2 of the $subject patch without worrying
about the problem you have reported.


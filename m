Return-Path: <linux-pm+bounces-8863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332CF902033
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 13:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB381C21A89
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 11:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCE774414;
	Mon, 10 Jun 2024 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdO3U8Gg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B06BFCA;
	Mon, 10 Jun 2024 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718018242; cv=none; b=LMQDXVdksqAxGwcP6asE6gRhPDtwC0WJcxvofwKpD9WBXbm1u/dTgcaJNyzhyrxbH0WQMLsyx54TT8XMjMl0gAjlRgM2QOpjqZooTYP6MiV50BIXKDGCWg8jt0oUMNuh+MMWqGeQi8cOnGRk2rPvHF4DN6feP3o8vQFo3d8IVH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718018242; c=relaxed/simple;
	bh=13XDtHa++hblwzo5voNHyIdjeLfCecpFY2EvEAXlaUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiNruA/Fm3S1jvbTydeW1PsIlX7xC1zVgcQiWludMhu6+1P65kfCMhFLD8NqYAdbt9EvJkaWyrJ3x7uIltBIbGVzRGZ0UfWvAV1E/lGvMCeCnWEYiuORSRJN9uZ5WYhXUQNC6l3FUs0aKaE8KbAsWicOEqvFX0eUNNZWPlh33/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdO3U8Gg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34CDC4AF1A;
	Mon, 10 Jun 2024 11:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718018241;
	bh=13XDtHa++hblwzo5voNHyIdjeLfCecpFY2EvEAXlaUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mdO3U8GgcMVnEmenD0E2KE5VIuf7i5JEwdlVbPv/Ksu3YvJi5FQ9k7c00Syi4pgdB
	 r0MO9CmZCKrxlq84+ScTH7CMgQsrTMSd+xVni2sB2WkBP13GIv6ciXhox7z+YBRudR
	 6U806fEvLxVfsMcUsPoL/GaquSvmFDcn73b6O6va/xG523ytgunzwo2SZOGjxoLK4Z
	 L3dNPFz3t9DQ6t3TisHXD2gKzTTRKtdYM4DC//alfF/RwBgz2I/dWwj72oDTMB2fVd
	 yQrWeZH/3tJ+li41Zx48VhBxA5EyE/veaNK6yBEcs0EAy2j5V/38Arsysx1RVUXe+G
	 Ci/EC/stdakrg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5bad112b623so68725eaf.3;
        Mon, 10 Jun 2024 04:17:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfHDdn6sp6QWEQnJ4yJl55hrbgVq3KyGAV41VLY6DPREHlIsBevvL2yPdz7x1KKdIZkkFORf9sVyxoJHXFvUC1miIzglPoSebycPuke/wYF1fTIQL2Lh2003VehtgWAWWkQLv0fIQ=
X-Gm-Message-State: AOJu0Yzu1168X46i3+tFdtZqVz5j1l6AaZI2/fILbr7nnYjTTg3rn/8u
	UtkNI+FAVBKV82fevq5AbqUjVhhvI1tlOVKEpWVP8b+qtWngT+7md4iY8ZMJsEAESFz75Q4kvoC
	XKAll5LpYT6crnu90ibPdHzCTJ7U=
X-Google-Smtp-Source: AGHT+IGKTwIlArAccS9HgIz/8nmcoXpGpdoSZs+F7qWC1cGHjBg63X0hu0TYfvhL91x9MfV4eUmkHghgY9+oDM12Kkw=
X-Received: by 2002:a4a:d0c6:0:b0:5ba:ead2:c742 with SMTP id
 006d021491bc7-5baead2eb7emr4437542eaf.0.1718018240856; Mon, 10 Jun 2024
 04:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZmVfcEOxmjUHZTSX@hovoldconsulting.com>
In-Reply-To: <ZmVfcEOxmjUHZTSX@hovoldconsulting.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 10 Jun 2024 13:17:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gVnjVyd_O6KgXy2sXr3b3M3vyTLyUCasyxP0GrAXro4Q@mail.gmail.com>
Message-ID: <CAJZ5v0gVnjVyd_O6KgXy2sXr3b3M3vyTLyUCasyxP0GrAXro4Q@mail.gmail.com>
Subject: Re: cpufreq/thermal regression in 6.10
To: Johan Hovold <johan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Steev Klimaszewski <steev@kali.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the report.

On Sun, Jun 9, 2024 at 9:53=E2=80=AFAM Johan Hovold <johan@kernel.org> wrot=
e:
>
> Hi,
>
> Steev reported to me off-list that the CPU frequency of the big cores on
> the Lenovo ThinkPad X13s sometimes appears to get stuck at a low
> frequency with 6.10-rc2.
>
> I just confirmed that once the cores are fully throttled (using the
> stepwise thermal governor) due to the skin temperature reaching the
> first trip point, scaling_max_freq gets stuck at the next OPP:
>
>         cpu4/cpufreq/scaling_max_freq:940800
>         cpu5/cpufreq/scaling_max_freq:940800
>         cpu6/cpufreq/scaling_max_freq:940800
>         cpu7/cpufreq/scaling_max_freq:940800
>
> when the temperature drops again.

So apparently something fails to update its frequency QoS request.

Would it be possible to provoke this with thermal debug enabled
(CONFIG_THERMAL_DEBUGFS set) and see what's there in
/sys/kernel/debug/thermal/?

> This obviously leads to a massive performance drop and could possibly
> also be related to reports like this one:
>
>         https://lore.kernel.org/all/CAHk-=3DwjwFGQZcDinK=3DBkEaA8FSyVg5Na=
Ue0BobxowxeZ5PvetA@mail.gmail.com/
>
> I assume the regression may have been introduced by all the thermal work
> that went into 6.10-rc1, but I don't have time to try to track this down
> myself right now (and will be away from keyboard most of next week).
>
> I've confirmed that 6.9 works as expected.

Well, I'd need to ask someone else affected by this, then.


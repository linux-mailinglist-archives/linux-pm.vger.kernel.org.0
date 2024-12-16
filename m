Return-Path: <linux-pm+bounces-19345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 883449F3AD9
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 21:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8C3188ADC3
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 20:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160D71D514B;
	Mon, 16 Dec 2024 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2Krjm/j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07861B5EB5;
	Mon, 16 Dec 2024 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381127; cv=none; b=qriTJEJbsT1H2hHyTSmC/ZZ4gGziCgRF4LgWA8kqK0mye8G+YmqY5ojEK/YF+S4LjcPwXgQGcI4ezZ5cUbBOQQQAGDH2FXXEW8yVb7z6ND3/RJXY0qri2iyXqe4QqRF6qU4RLOMHwplA65iE8q5quccxgkD/NZfQ0a5N6L3b0rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381127; c=relaxed/simple;
	bh=YoDwpDg5wL+h3+JEES2IJsYumsHTKiC2bi13W/WVk1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCl9MY04avtptDBgM9C4yGWHJiptlaqo1qzhEnCNTGPfkcDaNH6FoFON4172t9DqO7t0x6z5herHSPGLjMx8ecYRoH9mmCFI0c+/q6tSANVVlDdhU8nAaz4u/PANA+rS5yYACDPq3udV2/018ea63EtyYjNsJ36VdTGTQh56Xkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2Krjm/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F2BC4CED4;
	Mon, 16 Dec 2024 20:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734381125;
	bh=YoDwpDg5wL+h3+JEES2IJsYumsHTKiC2bi13W/WVk1E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P2Krjm/jUlHewxZJOqNX6Z+DWJIj7KMjMxafFyvZwr8gtGNYL8ChS/zX8VSJFXuY8
	 PZvDH5vhEt5n7m4j4io9GgzDkTiZDpfSBf0ElxTVESqlvoOP4/Lrisql+aFdToj0NA
	 CfoRBg2/Aq6vTfHXtVvVAiS8BJWhU/L+rz2ZCbmWnufMhTbwkN3mfMLlinwT/e9N95
	 9NQWUaANA+ky1R6/Y6Ejzt5sQQPiIByAGvQr+4LcL+UDNQcCm4d1H4vf6qjoNSUNh0
	 R+vFNPfHRwyuIPKDsHexa9hAc8oV5YPm2RuXwdshBcsa1Z2FJa53BaaAu2w71dYO8M
	 YGkvZCnG+qFAw==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3eb9ba53f90so1223263b6e.1;
        Mon, 16 Dec 2024 12:32:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRiF4u8nzIOYiKuaZ9Wq+ls57ZxraL+THJa+FuxlWFGf+uofp+Ya+K5DJXXWskqmKlIe5N30LTzIryysw=@vger.kernel.org, AJvYcCXzOUe8UkYxjDStYL5eRRDak7hHMV/0v5GZJ2R2OwAkJ04soOJvZSp+TLFQU8nCA7bHxFJUdF2/pPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGKQJS5O3/wg6HnRWz+OsYIMYjoke2UVNkKaNIjYFst07U47od
	IgaTwf9Le4DP/var4pVFxSp4mHBy/PUlSSO239++zgxbPoX7ChU5V2pXLwMonXJ9nHtdsDDBjEX
	xZb9w0ViRlzHvRm9xVANBGHAsz0k=
X-Google-Smtp-Source: AGHT+IEV0jHVogR7cEvWEznRvlOMAGrERxbxtAthU39if2duFiGRMbAaH9Nkg37RHIcRnvOP5SotvRexw3QLIhh5fjA=
X-Received: by 2002:a05:6808:3307:b0:3e9:2090:c030 with SMTP id
 5614622812f47-3ebcb32489dmr99702b6e.25.1734381124895; Mon, 16 Dec 2024
 12:32:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212201311.4143196-1-daniel.lezcano@linaro.org>
In-Reply-To: <20241212201311.4143196-1-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 21:31:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iJ1-sYxR8zEPa4YPEwrTXw+VxtUXnMEBhw2PJbLTueuQ@mail.gmail.com>
Message-ID: <CAJZ5v0iJ1-sYxR8zEPa4YPEwrTXw+VxtUXnMEBhw2PJbLTueuQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/thresholds: Fix uapi header macros leading to a
 compilation error
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 9:13=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The macros giving the direction of the crossing thresholds use the BIT
> macro which is not exported to the userspace. Consequently when an
> userspace program includes the header, it fails to compile.
>
> Replace the macros by their litteral to allow the compilation of
> userspace program using this header.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  include/uapi/linux/thermal.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
> index ba8604bdf206..349718c271eb 100644
> --- a/include/uapi/linux/thermal.h
> +++ b/include/uapi/linux/thermal.h
> @@ -3,8 +3,8 @@
>  #define _UAPI_LINUX_THERMAL_H
>
>  #define THERMAL_NAME_LENGTH    20
> -#define THERMAL_THRESHOLD_WAY_UP       BIT(0)
> -#define THERMAL_THRESHOLD_WAY_DOWN     BIT(1)
> +#define THERMAL_THRESHOLD_WAY_UP       0x1
> +#define THERMAL_THRESHOLD_WAY_DOWN     0x2
>
>  enum thermal_device_mode {
>         THERMAL_DEVICE_DISABLED =3D 0,
> --

Applied as 6.13-rc material, thanks!


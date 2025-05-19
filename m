Return-Path: <linux-pm+bounces-27378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A8FABC799
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 21:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7AE1B64637
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 19:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47E420E310;
	Mon, 19 May 2025 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBuGTRVL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D9D13635C;
	Mon, 19 May 2025 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747681860; cv=none; b=Wit2Gh8j3vc/sWNUL1iRWQkJ8ammYrR42fONhm3RyPphbpqlusPyrgu0mVwbOaxx4sVfm1K3tAZ14r3UHmpoDYIBqQ400qu9Kolg+W4Xh46NjEpNWiC6oOqazXitYKnrVNj2aYv7ezQYldIoudl2WmNIGcDtEhGSu2L8pbB1k94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747681860; c=relaxed/simple;
	bh=5UpWvRtyyVKCNBvlRnU6EYbY0K1yCTIYPFLr2mvenlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zy69l633tuGptpZeg0UcVWsZYUbe5SGUo+xl9jxoDvzU1iD9kXD+x3t5T8Ovc+ztBAWqTsgFqresfU1IMFti6UDabmytwFhi9rppX8S3hkJ0d8nVFxLz+ZneugydkGiexgY4BIPV4Wd9xnWi2H8B9PJrOoL52IKdrKZWPlL8VQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBuGTRVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BE0C4CEE4;
	Mon, 19 May 2025 19:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747681860;
	bh=5UpWvRtyyVKCNBvlRnU6EYbY0K1yCTIYPFLr2mvenlE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bBuGTRVLg4fWt2z/M81jOfcC2axuGKzLH8jCjG9ZIUD4C0k9d6gA3PWuexagWjAsc
	 c3t4H6TRTrTvp3qESekKOxsFvCyHZiFmvchlBUGSRwYU3NVANrDIPRD43I60RCvMQ1
	 1V2rrM6X/lqEaGHwdwpkSDfVGJEef4YkE71sZmsruyO25zC5VBuijXq1atBeVGmr5L
	 +agZOhd2+vyehkFufLbOx9S/PbQCRlizJOTAHv3ZBayb6MZ1ooNrcTjnGRl8EoJVIh
	 z1qx//JslcW+aucVeFFEEin3Q2JiWe3KUqnOkOLdpyw58wvu32FxCUPxv5JCQdApk2
	 czgRMwv8Q8FYA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-606440d92eeso2516139eaf.2;
        Mon, 19 May 2025 12:11:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVG3SKeJosPZ16xwtz8wUmHeTtYrw3tgE4xIOH7XfuE8J5XqMVs+LQ29+szuO6VwUfVbAyKoaDaR4uLNUc=@vger.kernel.org, AJvYcCXX1/lw8YTd2318ByfPT/MQC9GDF0t6jwu/u8YRzK8RiZoJTSx1SQuP28uP0oKfVMMwSG2wE6Ub9Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySMO/sbmX+lDCIrvp3rON8FGH2Vfl/J32HM4qXhR3PRep9KZ5p
	Thh5COmRblg6V9Qmhl/TmKVRjHDO2RHgAzeZBo7fyyQG0xNcT1d1Y8C9/ZMLlpsKHI0fO/I270p
	cD9yVgdCFk8uFMgl+FGTEfxlkEOpiVQk=
X-Google-Smtp-Source: AGHT+IG8HY1pU0LJCDkdPqsrocfW1VbvRMSWOddpdCXa87vWDDROVqAHWs5AtZqDwRfqdWn3T++3IzYKm2pPhOqCRSE=
X-Received: by 2002:a05:6820:2705:b0:606:26bd:7208 with SMTP id
 006d021491bc7-609f37bc37dmr8119192eaf.7.1747681859874; Mon, 19 May 2025
 12:10:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519070901.1031233-1-rui.zhang@intel.com>
In-Reply-To: <20250519070901.1031233-1-rui.zhang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 May 2025 21:10:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iZVjbnJKfpzWsmz_j978FRpw+ocQKjUU+u2e2OZQOZMw@mail.gmail.com>
X-Gm-Features: AX0GCFuODlhskytFNMsfpAga0_WiJT1WXXb9MMNg-aSgbgO4B9N4ZwC1K7l1zKE
Message-ID: <CAJZ5v0iZVjbnJKfpzWsmz_j978FRpw+ocQKjUU+u2e2OZQOZMw@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: x86_pkg_temp_thermal: Fix bogus trip temperature
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, zhangn1985@outlook.com, 
	daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 9:09=E2=80=AFAM Zhang Rui <rui.zhang@intel.com> wro=
te:
>
> The tj_max value obtained from the Intel TCC library are in Celsius,
> whereas the thermal subsystem operates in milli-Celsius.
> This discrepancy leads to incorrect trip temperature calculations.
>
> Fix bogus trip temperature by converting tj_max to milli-Celsius Unit.
>
> Fixes: 8ef0ca4a177d ("Merge back other thermal control material for 6.3."=
)
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Reported-by: zhang ning <zhangn1985@outlook.com>
> Closes: https://lore.kernel.org/all/TY2PR01MB3786EF0FE24353026293F5ACCD97=
A@TY2PR01MB3786.jpnprd01.prod.outlook.com/
> Tested-by: zhang ning <zhangn1985@outlook.com>
> ---
> Commit 983eb370cb87 ("thermal/x86_pkg_temp_thermal: Use Intel TCC
> library") converts tj_max to use the standard API without switching the
> Unit, which is a bug. This was mitigated by the next commit 58374a3970a0
> ("thermal/x86_pkg_temp_thermal: Add support for handling dynamic tjmax")
> which uses the Celsius tj_max for failure check only.
>
> This may confuse the maintainer and the bug was introduced by commit
> 8ef0ca4a177d ("Merge back other thermal control material for 6.3."),
> when addressing the conflicts with commit d3ecaf17b586
> ("thermal/drivers/intel: Use generic thermal_zone_get_trip() function").
> ---
>  drivers/thermal/intel/x86_pkg_temp_thermal.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/therm=
al/intel/x86_pkg_temp_thermal.c
> index 4894a26b1e4e..3fc679b6f11b 100644
> --- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
> +++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> @@ -330,6 +330,7 @@ static int pkg_temp_thermal_device_add(unsigned int c=
pu)
>         tj_max =3D intel_tcc_get_tjmax(cpu);
>         if (tj_max < 0)
>                 return tj_max;
> +       tj_max *=3D 1000;
>
>         zonedev =3D kzalloc(sizeof(*zonedev), GFP_KERNEL);
>         if (!zonedev)
> --

Applied as 6.15-rc material, thanks!


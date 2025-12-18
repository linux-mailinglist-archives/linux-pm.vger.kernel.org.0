Return-Path: <linux-pm+bounces-39684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D9BCCDBD1
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 22:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 573ED3015E32
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 21:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4005134252D;
	Thu, 18 Dec 2025 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/73E1rV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774A6342520
	for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2025 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766094414; cv=none; b=iOPj1gNWu33aXJL8kPrE775BrzT4+IQZWNfWUP+uIO/Ka0svMvMpqHRt681f0b4aq0RQlD94MB8UCIFyPoS35yYKKrHRzHHciHN6B1tWRI+fbkweYNcm9DPli+Ur/8swoLeIjMohWUKgNidmjdz3IeemRUssF1veSqeWXRrPsZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766094414; c=relaxed/simple;
	bh=FVb+75/2k5Cfg8wax4LgqGlIPnhWXDFu152By5+cBUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrtrdgQeGwHAGj/hORTFEyNFbcbrYDL63wdOz92pXxfPMBw9f+Giox+QRGKNXsUsK5FFATg9CVFFd55ZcCdUJEENUf209fhLfgjoGcoBmkvfji7yOWainTfDmipAwg3bsNwmteZd3HWz7YmNC/ubQ+x8uFwQoB20EpqIdEp1ElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/73E1rV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-598f81d090cso1210134e87.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2025 13:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766094411; x=1766699211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQpe3keIcuKcpcqadHHR990EwQPixfFdbcJZXmBoUrA=;
        b=N/73E1rV6EtsnAefhPOg8xsLfmyCUWyE2ts9w0nzauoc9UME5iAE/BzjnWzJOKexjh
         zbnp5D6z9jRUZKpt6UQKTX7WJtAbUMUe/3QDyZ+OcxMB1JrRM6Gj7TZ6UycrhMLSHA6e
         DYkls6jqGzE2+v9v6Yb/zr5qqG5CQAfAyeTa6iOt3in3YTmye4QV09ShJd51AY14RRmQ
         1u3qSZJRET/0qazJuG2gij4Eog+D7qNgBZVo4SUqAa031CG4XkFRGeCdOI3te5Jm8z5C
         T1y5lsCbZZ2FR7hF2lNCDbn7C/1C7XFZyRlagiXNPJ+k/q120bY69HjfqEZAfjshRwAM
         Q9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766094411; x=1766699211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rQpe3keIcuKcpcqadHHR990EwQPixfFdbcJZXmBoUrA=;
        b=iwQHWBOo+iec7mckRXAIMGjY7AxcudSJ3/AZWrsrNjwLmKC1LdKYBRvMAM4jsP8J3+
         ysQCjPeF6Eiga8/KiNiXBRpzfvSuzTzpO5flczpWqYKv70RqszGEzOjGKg5MSjYWskbt
         q6zD9aZIbHhNXdSFph84NAc4yBSL+hjLobj382rpzO3rNUfKgz92KbdrPwNGTujk4u5Z
         dUcusL7d4sbN9YMtvE7enUTc1QVrxzpqdxN4oPWAJ4/6jRMeXG3T+gS1qGUAqpR15OAe
         jTLCTvOh7qx4nDvSV7iSkEn0XcrdZFsyIOIRMflD1sSXZ8Nnb+MLTt6yrQBkAvvTrfuC
         Lg2w==
X-Forwarded-Encrypted: i=1; AJvYcCXDpf48+sz/3zpaPRC3mMerRbNtC/2ImUZPhByaisQWknYdZPTi3tsddf3GU1gpxeYlG3Hhtkl6Ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNu1BwERgLTsUkO1bTfnNOy1nH3Cj+PiE+WedroCfzVfC4PFjm
	qMUypwRj0BFG/dl02Er2CkDoAG/+Ww1n9TbA06rNu2u3jFiZayGrslAQGAVRw5wPOcqEG8t02+8
	DwGseyvbn/kDE9r8u1cJLFFPHga/u1x0=
X-Gm-Gg: AY/fxX6o89BXL97sdySWe64wN9jFPvUQ5PTmg7HS0n4jgC5f05iX2sv+OCPPZH3qFRP
	kgrAxuWSC7laT37YJgwyX8FUmJT0xr2hCRkc4uROH4zIgah1hyAB48Kk2URGp4stEKKKal2oSCG
	qrK/zAu0wBa/UQvfAGDHOBWo2X68aIaHxxtt6pmaJ/tgRlen6d4mqs98tv9BZPXvJja0Ohf7Yxt
	ylxI0XDOb/ArPiDxPzDGCcU7gPcu95sOnDs+043+v/2To5F3Uheyls++40OFfxftV6b+zoGHByR
	UGhToJpvzFij3ko9ZGc+DQKL1kEYJ5KSeWUzstngAAvyK1N0TDZpvd9J
X-Google-Smtp-Source: AGHT+IHOYreMWyFl6zo4s8v5sO5wA2iqT//3JW+BxXasD+pPDFQuaVJefBBK0bpJiwyohs+IlPyuf8X4oLh2IGC4Dow=
X-Received: by 2002:a05:6512:3088:b0:594:2e7b:6f9 with SMTP id
 2adb3069b0e04-59a17d3df9dmr378324e87.27.1766094410476; Thu, 18 Dec 2025
 13:46:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218-cpufreq-dt-block-tegra186-194-v1-1-24adeea10b86@gmail.com>
In-Reply-To: <20251218-cpufreq-dt-block-tegra186-194-v1-1-24adeea10b86@gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Thu, 18 Dec 2025 15:46:39 -0600
X-Gm-Features: AQt7F2qjx60eBEt8dT3QxbXqn4vb-aB-gy1dAOxtEbk8x0B1JPwrleFptFVJs-U
Message-ID: <CALHNRZ-ohCFkaWTT37juaWB6DJ_CobTyZDnu7_=6nqcCrat+oA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Add Tegra186 and Tegra194 to cpufreq-dt-platdev blocklist
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 3:40=E2=80=AFPM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:
>
> From: Aaron Kling <webgeek1234@gmail.com>
>
> These have platform specific drivers.
>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufr=
eq-dt-platdev.c
> index b06a43143d23c6365e1e0b26d4299ef4b0c3482f..1708179b2610bca6035d10f0f=
4766eee6f73912e 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -147,6 +147,8 @@ static const struct of_device_id blocklist[] __initco=
nst =3D {
>         { .compatible =3D "nvidia,tegra30", },
>         { .compatible =3D "nvidia,tegra114", },
>         { .compatible =3D "nvidia,tegra124", },
> +       { .compatible =3D "nvidia,tegra186", },
> +       { .compatible =3D "nvidia,tegra194", },
>         { .compatible =3D "nvidia,tegra210", },
>         { .compatible =3D "nvidia,tegra234", },
>
>
> ---
> base-commit: 1058ca9db0edaedcb16480cc74b78ed06f0d1f54
> change-id: 20251218-cpufreq-dt-block-tegra186-194-cf2f6ecbe1de
>
> Best regards,
> --
> Aaron Kling <webgeek1234@gmail.com>

cc: Jon Hunter

Changes are on deck [0] to add cpu opp tables to these soc's, causing
cpufreq-dt to try to manage them, which is causing problems during
regression testing.

Aaron

[0] https://lore.kernel.org/r/20251021-tegra186-icc-p3-v3-0-68184ee8a89c@gm=
ail.com/


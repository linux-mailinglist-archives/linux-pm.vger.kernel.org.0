Return-Path: <linux-pm+bounces-23787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093D9A5AAD1
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 00:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32F53AEDE2
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 23:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125FC1F8745;
	Mon, 10 Mar 2025 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9v/N/No"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEA01DE3D2;
	Mon, 10 Mar 2025 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741647910; cv=none; b=UT0dqdkgJhW2iywTmpDoNxDSXkBsfzbPGQel618hgDyE5UjZafjXGWneBnKm44CrC2eWPHWrQcKI51IZY/0bWRI+iW7SM+ltiWFIDVo+BDZ6Qme1vxF5I60R2KrKY8KupY2/HAj7aPJCUT23BZkG+vQemKCMnY/DbvIbQX/YTXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741647910; c=relaxed/simple;
	bh=nYy0n35w8J/4aF7MVdZQR6X3w5M3vPLdoazR6ifT8yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q42WqkjH2kV3GLH/XLTT5lu4wTugPivyVERkj3nOc7G0Ok0d6u3zx+qwTJei23MJr7R57NTL2D5pNOCP/Ap+Xbt+VPIMPsAQiGuutrroV9hUqRN/ajWz1+HNJbv2O/nlLRp21bE4A0pxNXYuna5gKHigUwMu0lkTrPLHPiYnP8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9v/N/No; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c542ffec37so231271185a.2;
        Mon, 10 Mar 2025 16:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741647907; x=1742252707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeArYs7E3iNBbYq1flgNf+/C0MnZEZNo3VaP51YRBrw=;
        b=d9v/N/NoK3J9oiNV0ioQlEB6tvDzdYshdxLfwcDzMD+ewr9tUliu6ExRDgiyHXlBfG
         F6DQAbwAXdyOxYcm7m2/Gu72pMF05+0jPJS/+r4BN8KkEmoaWdiZV0nzQjEDXaUbqU66
         GeQ1xdmBAPqDAO33t+kqGEkSDfE4swcPZMpjKKvkbIvSbAufeS5gg3WBuZcm3XdlKnUM
         l2RWZLGwSJtQgRA2sinYKZ18wvRwMGhuX/moMbj0UsAlE01RSZjSmmTABZyQAgZQGS/1
         DuwjL3OfG3BnXm+8we8QJIhJSYSfWVRVvUA3VNFhKq/ZoyP/AoFp5x/V5bua2NglHG0b
         a6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741647907; x=1742252707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeArYs7E3iNBbYq1flgNf+/C0MnZEZNo3VaP51YRBrw=;
        b=DyEcYJD0Tq5cnXuUWfl1nHqtZ8Mlt8/4MyDyhSQyAwqy6mzS6uLLjwhRaPnxPzsBC8
         cMnccY+MnToNU/THPF3u2UsHpLpBJ8WyiRgJ0FQ71G4tUYPPot7hnGKta2Ol6qR+vBCo
         DQbMGrOgMI81x6/yCubb6L8lu4KMZ6AW/o8IB4LfRzfFZkJqtvK7i0vzHvMqHJFYgpkp
         8yUtZg8ekjYOMUYszm5Ngo4LDp4Z2ukdWl4Iey59HcYiEFdIthhG+E2yD/vgzg5Aq6/r
         dzWHI38dq2AZPe+gZKeTRJUavL0dVQiPgrFfOWp/Q7tOQ59HVIjRdlTgnoZIv87T9knM
         iw9g==
X-Forwarded-Encrypted: i=1; AJvYcCVYE2MpnXuugcoW2LArQiWSahFvA9WvV+BbSrbbb85jQOHam1VzT76LqUu2uiwUWKX/NpSmybLbpCBjKrI=@vger.kernel.org, AJvYcCViG5c9L5TLk1rv19vkUeR8RaBQZ9zt5jSEOh2hBgNk97ipYiX7nejaNvQupT5AoXgQwH1Dh+pnx1o=@vger.kernel.org, AJvYcCWtfePyqNdZX3Mb2O0MUwnrOudvArIkwW50eIQFAY6iYfbTRfsqJh0OHrM89AuMddudWexhpAYbAik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtHQaiPzZ4EfX1jKQDqOAFJBKujkEbrkv80gRiOm5qi3KRRtep
	xlfF+mR9Hl/XtX6XUg1yjPB6WWmrw7xHEI2cConJyUQ1tiKy8531CduSo3Gm2gmiGSS/ZzoYft2
	I0UX9HHou9MC5WOBic/8ZsxVigaM=
X-Gm-Gg: ASbGncut9RBF6kedk8xSHENbXyLmrOfYCDOgWlaxSAsXXbZq+xzbKK2VSbgqkAmgfY5
	Zwot7Jp40+0kNEG2xm8Iw49EEbfpRAtqwZy6Yw2CVEaXuuH4l4T8bAppVNiHohm4s7a/JGQ2MuH
	ZugFifaDvnTYieALWzhdr1tTd1ChM=
X-Google-Smtp-Source: AGHT+IHseeC4LW9zHhyh6Vus9zlbD1jzAdLLHMjgqo9ijfORYdoCA8rv4OQFat2uD5vm9oN9t8lPlhj5rvNgGpM9Kqk=
X-Received: by 2002:a05:6214:2b0d:b0:6d8:8a8f:75b0 with SMTP id
 6a1803df08f44-6ea2dd20283mr20084776d6.14.1741647907160; Mon, 10 Mar 2025
 16:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309112114.1177361-1-lkml@antheas.dev> <20250309112114.1177361-2-lkml@antheas.dev>
In-Reply-To: <20250309112114.1177361-2-lkml@antheas.dev>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 10 Mar 2025 16:04:56 -0700
X-Gm-Features: AQ5f1Jq9VwFHNEFU7lLeGSmJ13yn7Ad4XC2XKVKvsKkS3lqYQS6EMX9mR_VPSb8
Message-ID: <CAFqHKT=9mfqEVT5XHbKnspAwJ_mcd1Q4gf7DxHXL33bLaxTBvw@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] hwmon: (oxp-sensors) Distinguish the X1 variants
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Joaquin Ignacio Aramendia <samsagax@gmail.com>, Kevin Greenberg <kdgreenberg234@protonmail.com>, 
	Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>, 
	Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 4:21=E2=80=AFAM Antheas Kapenekakis <lkml@antheas.de=
v> wrote:
>
> Currently, the oxp-sensors driver fuzzy matches the X1 variants. Luckily,
> X1 and X1 mini share most hardware features so this works. However, they
> are completely different product lines, and there is an expectation that
> OneXPlayer will release more devices in the X1 line that may have
> differences.
>
> Therefore, distinguish the 3 devices that currently exist in the market.
> These are the OneXPlayer X1 AMD and Intel variants, and the X1 mini which
> only has an AMD variant. As far as registers go, all three support the
> current driver functionality.
>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/hwmon/oxp-sensors.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index 83730d931824..5a4230ad3757 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -205,7 +205,28 @@ static const struct dmi_system_id dmi_table[] =3D {
>         {
>                 .matches =3D {
>                         DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> -                       DMI_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1"),
> +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1 A"=
),
> +               },
> +               .driver_data =3D (void *)oxp_x1,
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1 i"=
),
> +               },
> +               .driver_data =3D (void *)oxp_x1,
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1 mi=
ni"),
> +               },
> +               .driver_data =3D (void *)oxp_x1,
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1Pro=
"),
>                 },
>                 .driver_data =3D (void *)oxp_x1,
>         },
> --
> 2.48.1
>

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>


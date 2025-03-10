Return-Path: <linux-pm+bounces-23793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63949A5AD83
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 00:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8358A174513
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 23:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C141EF38C;
	Mon, 10 Mar 2025 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAYEDqcn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F93199FBA;
	Mon, 10 Mar 2025 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741649466; cv=none; b=MLzqaWd75sVgQAp9+8OaVuQLs14t8hJeWlX9OfGP4EHbOmO07fV61tTbr6aVzu8WZLLVV4mknD9ulXgh5sF0dl9zu9eM74g4YxWsr3w5ZPYfEBxYEtlyZ5XRSU2WKK78PxbAGpAgzgcRIqrm1ZxAt4MwPFbGjVG5YHD+lSZZ1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741649466; c=relaxed/simple;
	bh=SJeiI4qQMbS0e1M8w+GxQ7XXqXSuZKvN7g2ax1GIHpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGj/6icEuiACQq4zlwyLS3eZWD5T6C2pZCEaz+CYRrJrUU/sAvsUFmUYEv0BAgk7ZX75X9XtOsX3NVTChDy6gRlo3XHYgtdF53Obuvqe/XZEAotfVTsf8IoaQ0sRYhLva3LUcJ/weIkLYTYBG0fG8kZ1MoitYsIrDOVrjflheQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAYEDqcn; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dd0d09215aso34749046d6.2;
        Mon, 10 Mar 2025 16:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741649463; x=1742254263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nLKvOs1O8QbVUt7gWTM204+7oRMGK4JbaArMUxhl/g=;
        b=DAYEDqcn+ul8KFWJ8fwb620omnNe+DoZMSKlUIL6p+y66vFyWkaPx1ahy7yEMOmYZk
         4Ks/oXCztw7jGVCrCVhNGNChGjkJ3VJJcIPYsK6G89aQx3CaZpPZLULl/f033efxLHfJ
         XdoVnBZvGoFaAW+6dttc1mG6nDt7uprUu61IueuOvyEcvjCZ0/f1qS2x0XItO78aeDDj
         izHuPLihNiov8uRlPun3LcP5C5sStvhz1myyGs24U0ftO087vJJwGt63G+G5lhckrpba
         uhQHpUzv6ivilhiL72MZd3TXXwxRs9SVO9vkOUHWjfedWGw2PotqIx35eqywUBOwXh9Y
         wPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741649463; x=1742254263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nLKvOs1O8QbVUt7gWTM204+7oRMGK4JbaArMUxhl/g=;
        b=GQDmp92Y0QZJsI1TGBtGI3d8GCs4ID3BeYwci3BC6Pa9/5t9ZqMpdSEDxlifuM2hL3
         y3lTcZSO6ugGBd3HeqTtOIsysEgceIinuwWGc7j92T85Rp42ci46zpv/Qi2M2cqcy0LC
         rRmosNSrEm2UnsAPN30MeeNhKbawUcymZ9a4/I7wX9JcawhtGTG45OOrwib1N5tcWPbn
         FpgOP+Ml6fuyBhJrNrqh7sImaFySE3Bi8mlBN6WDU+YSfj809CNipEILCERMIfXuUwzx
         PmcVZPuUQfwcaNJh1Mrgdl+3Khcpqbr3cX3GoeUgS0MlVNCAoq5OsTDfy4f/vLEhDcYQ
         qiNw==
X-Forwarded-Encrypted: i=1; AJvYcCU7AlF6bDyzpxZo2OxdPYGXJfU/QjytmHjBwUGhxmb5/sf8mmGG7OYNsUDklS4N9o99yffXedDZb/4=@vger.kernel.org, AJvYcCWZo0KbdwPD2Bznd34tMojcb5CBBIt91YpmqDM/otCMiMVCh/cIY7zzoZg1YWeVdxYpwamvYIdmXTw=@vger.kernel.org, AJvYcCXZtmFDRVuUox23waBELcJ+PYLVQXvk/D7pSEgfm+Osn21QFxkUXJGg293uVwk0XRsgpK3HThc9/ctvkTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQkWdHlg+3AOGod3swiHas64SNI7OAn9CmdJnxDHUai3tssSbZ
	TbKd+PF36vnlA/Ygo1jV69+RUsN0puz4+lAKQ74QO9yzqipd11F+36nPOj6EJX8kv/n5InZEtey
	Nb7EfiKaDS1tyARNTy5H02QCjPws=
X-Gm-Gg: ASbGncu6rT7H+rmihX9gqrsdGqA1IcBF1QHB+EQq12r6TdJu7YsB2Ih8Jj5rCkt/2ob
	DpwY2U72HqzgJbXV1NToSBDitsSqU3197CJNADVf0ZsYqtta/l4yFa9qCwXr0qjq8YfvYtDDw12
	jYcw9pUBrrHNOOeBYm8F1CxAWE0Jw=
X-Google-Smtp-Source: AGHT+IF8fjdqoiYSEfEKhFRV96omzqPbOAJsYlw/VG/1472oA8pHBSJ6q5sc2FyGASXdpXQwlSzcO2eRtlCosUIyEOk=
X-Received: by 2002:ad4:5cae:0:b0:6e8:f940:50af with SMTP id
 6a1803df08f44-6ea3a6ad9aemr22198496d6.44.1741649463384; Mon, 10 Mar 2025
 16:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309112114.1177361-1-lkml@antheas.dev> <20250309112114.1177361-6-lkml@antheas.dev>
In-Reply-To: <20250309112114.1177361-6-lkml@antheas.dev>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 10 Mar 2025 16:30:52 -0700
X-Gm-Features: AQ5f1Joj9IS9fGPA-pyAxRUWh9qPihL9oGWUfo4IH9lowCZyfLkuOL4YHJjt-aU
Message-ID: <CAFqHKT=ZUsydWkV96+00TyofxWQqmNPZRzVhhGxDsdjYKf8yzg@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] power: supply: add inhibit-charge-s0 to charge_behaviour
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
> OneXPlayer devices have a charge bypass feature
> that allows the user to select between it being
> active always or only when the device is on.
>
> Therefore, add attribute inhibit-charge-s0 to
> charge_behaviour to allow the user to select
> that bypass should only be on when the device is
> in the s0 state.
>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 11 ++++++-----
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  drivers/power/supply/test_power.c           |  1 +
>  include/linux/power_supply.h                |  1 +
>  4 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index 2a5c1a09a28f..b5daf757a559 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -508,11 +508,12 @@ Description:
>                 Access: Read, Write
>
>                 Valid values:
> -                       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -                       auto:            Charge normally, respect thresho=
lds
> -                       inhibit-charge:  Do not charge while AC is attach=
ed
> -                       force-discharge: Force discharge while AC is atta=
ched
> -                       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +                       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +                       auto:              Charge normally, respect thres=
holds
> +                       inhibit-charge:    Do not charge while AC is atta=
ched
> +                       inhibit-charge-s0: same as inhibit-charge but onl=
y in s0

S^

> +                       force-discharge:   Force discharge while AC is at=
tached
> +                       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  What:          /sys/class/power_supply/<supply_name>/technology
>  Date:          May 2007
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index edb058c19c9c..1a98fc26ce96 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -140,6 +140,7 @@ static const char * const POWER_SUPPLY_SCOPE_TEXT[] =
=3D {
>  static const char * const POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[] =3D {
>         [POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO]            =3D "auto",
>         [POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE]  =3D "inhibit-char=
ge",
> +       [POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0]       =3D "inhi=
bit-charge-s0",
>         [POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE] =3D "force-discha=
rge",
>  };
>
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/tes=
t_power.c
> index 2a975a110f48..4bc5ab84a9d6 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -214,6 +214,7 @@ static const struct power_supply_desc test_power_desc=
[] =3D {
>                 .property_is_writeable =3D test_power_battery_property_is=
_writeable,
>                 .charge_behaviours =3D BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_=
AUTO)
>                                    | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_IN=
HIBIT_CHARGE)
> +                                  | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_IN=
HIBIT_CHARGE_S0)
>                                    | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FO=
RCE_DISCHARGE),
>         },
>         [TEST_USB] =3D {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 6ed53b292162..b1ca5e148759 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -212,6 +212,7 @@ enum power_supply_usb_type {
>  enum power_supply_charge_behaviour {
>         POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO =3D 0,
>         POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE,
> +       POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0,
>         POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE,
>  };
>
> --
> 2.48.1
>

With the small typo fixed in next ver:
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>


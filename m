Return-Path: <linux-pm+bounces-23790-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46731A5ACF1
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 00:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D983AF27A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 23:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A451322154D;
	Mon, 10 Mar 2025 23:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V52qsO32"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C182206AE;
	Mon, 10 Mar 2025 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741649159; cv=none; b=qudKXljOjmMq2okYEp5r+74WztkQYSH9cyuNi+aqELqqBPGQjAZ9i6mYkl+j/zYiRXIheZY/uD1TEo9afOdwWaBbKciy8fyn3pthZGSLRcCL1wvOlUUheTuZidp5uD3KNPUXz3dfmbNcl/5qmVsd0VHsvJRKy6MdqGjqruxtM+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741649159; c=relaxed/simple;
	bh=xc2FkzdcKvogky7tbs9cVvXJbKb+JT2qIskr1rBe1lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfT4WztC/hawscC2R5/zW1LSuG7u9HTRTrBLx4eFfaFmSjWF39BemcC5JZNcg3xV5mQOQNsEsHaz/Y6PS9NA01J9ZR9G9VaCmypol6fbIM/btTouQvtZYWYa7pCoGiCCRIA8D+xjwXijrnwwIWo8oiVk+MGygjzVedGeig+JsAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V52qsO32; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6df83fd01cbso21338676d6.2;
        Mon, 10 Mar 2025 16:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741649156; x=1742253956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Lr89eEuhBzZoZAHpEMRqTP7qesjfu7BBpvvzXDgz4U=;
        b=V52qsO32b1zCXGFPbqvdgaZx7DIGem6jeA0+L1OaeI5irRSG5QOu+B9sh79fMG0BWV
         MLye1k418L4Bimu9DvBpYfL4Mh2HM0ZdN5AQgBH5A1sFgTLevKdGDHjBTXST30I5OLvB
         0rfFF+8Z0HZaXhZiyM1vmgb5k+zEkkNkfrrR6Qewab6xXEP2ojS0O6OuIw7ggzFQI5ac
         0YM8jaVj1LhkgoEgoiQlFrHC01oo8UhR3HF2/2YEFTkiqXALTwSs0/ePtt+OJs2fdk73
         WId1oGDCNtjKhGEBo/arAkvw30DUjcVGEfeJQ11Qe4de4s3TZ0apVx0rpq8e6P70UvIJ
         3lKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741649156; x=1742253956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Lr89eEuhBzZoZAHpEMRqTP7qesjfu7BBpvvzXDgz4U=;
        b=TKJ5E6GPnkLw+/VjsgZWc/WDwKvYgEfGpTicjFX9JJodo1X6ZtFiH+j8COihe7feSA
         tqrn6Dr+LrviefDja8DSVK11M5pNovLUIuIHsZl5jKKJ3W641lLn8cWuOEgm8JMxOhUE
         5YWPzUk2djy1PepAR/lGIRhAcxSSyVGrUeijFF9hJxt5stfo8x1X/dL5fxgmPow/wDLS
         aXWZrdwRor344IKv/YnuY9oeDysULKSkcLZzek0MdvkG8+7Teyw0FMLQfHQ06nhbXfMU
         +PF0pFzINOZ/vbt76a8ZfeGlK3yGe6I+ZtDbckbF5nh7zVUczz9bdzl/X3Fzk3q7qEeE
         uQ1A==
X-Forwarded-Encrypted: i=1; AJvYcCV/FgJAaDtz8IfMslMe5T8oP8v9h/ijqPtMU2JqrBaUql3uCY8bDh7WXthaaAmrWPIz/vEH6wV+xRmpPLI=@vger.kernel.org, AJvYcCVXkfH6vK8RtqP+nUvZ98E9G6Afp9IRhaYNPI6szqE/XL4H6yVj+wxuh9YrryxJN3FdDZ1Kz1MAJQA=@vger.kernel.org, AJvYcCXJcOe2kjKoQy/AOJTpvzPsNVA45yjUmEbpu61gB99ZJS/r4/hNE/aDP6DnQMfkYNNw9PTJGCS7H7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YztqWfdmFo0VV4q8ycavbMIXZ/EdQvYxaNPkbX6PwQO8pv2OyIG
	LrDPLKc0PBQCwPxBaVXaWFu5IaNrsSjCfd+pkoMG2GQgrnxeMU772TRq2V4nN038rAFdPEyuzQS
	Wc+efUHaNcTxK1aa8iGaXm7kjzWE=
X-Gm-Gg: ASbGnctTLt1O0QN3phoX5moB1IIwBtNj6w66djToannAX41ZYbi1HtYSztPEc7lhK+d
	fUtuf6Jb1QOzvXaEEKRBsFw/Tli5BWcIqgTNV/NulAImfYrWvO2X9QXJDlFPByDSpjQzKgOOXHZ
	bSTYX0A4kM4sNIN8cEyx9S0BOc8Fg=
X-Google-Smtp-Source: AGHT+IH6eDV4ffoQYuA6cB3B7dAYpivHpL97tNADur9UBjrWdWefOGeWzTEPxwOrdixFpaz59E8dKfTgXdWUsIfvGNw=
X-Received: by 2002:a05:6214:226f:b0:6d8:9d81:2107 with SMTP id
 6a1803df08f44-6e90064fb9fmr223330266d6.20.1741649156376; Mon, 10 Mar 2025
 16:25:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309112114.1177361-1-lkml@antheas.dev> <20250309112114.1177361-5-lkml@antheas.dev>
In-Reply-To: <20250309112114.1177361-5-lkml@antheas.dev>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 10 Mar 2025 16:25:45 -0700
X-Gm-Features: AQ5f1JpB1mK9aB6HRfuBfiGFj9QIeZ5CfKJEnQUIiiwnudg3HVpq9P0OuPYfS-o
Message-ID: <CAFqHKTn0pTm_vjq0Vdw1qHeiubSrHJ_QJyM37K+eLTpAy_XQ-w@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] ABI: testing: add tt_toggle and tt_led entries
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
> When tt_toggle was introduced, it was not added to the platform sysfs.
> Add it, then add documentation for tt_led. Remove the documentation
> from the hwmon entry, then update its readme to be current.
>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  Documentation/ABI/testing/sysfs-platform-oxp | 29 +++++++++
>  Documentation/hwmon/oxpec.rst                | 62 +++++++-------------
>  2 files changed, 49 insertions(+), 42 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-oxp
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-oxp b/Documentation=
/ABI/testing/sysfs-platform-oxp
> new file mode 100644
> index 000000000000..8727d5ecaab5
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-oxp
> @@ -0,0 +1,29 @@
> +What:          /sys/devices/platform/<platform>/tt_toggle
> +Date:          Jun 2023
> +KernelVersion: 6.5
> +Contact:       "Antheas Kapenekakis" <lkml@antheas.dev>
> +Description:
> +               Takeover TDP controls from the device. OneXPlayer devices=
 have a
> +        turbo button that can be used to switch between two TDP modes
> +        (usually 15W and 25W). By setting this attribute to 1, this
> +        functionality is disabled, handing TDP control over to (Windows)
> +        userspace software and the Turbo button turns into a keyboard
> +        shortcut over the AT keyboard of the device.

> In addition,
> +        using this setting is a prerequisite for PWM control for most
> +        devices (otherwise it NOOPs).
> +

Is this accurate? This wasn't the case for the mini pro/A1/A1 pro when
we added them. If it is accurate, we should check for this in the pwm
_store functions for affected devices so we can inform the user it
failed (-EOPNOTSUP or similar).

> +        This attribute was originally introduced in 6.5, without a
> +        corresponding documentation entry.
> +

This last line doesn't provide anything useful to someone reading the
ABI docs for implementation. Please drop it.

> +What:          /sys/devices/platform/<platform>/tt_led
> +Date:          Feb 2025
> +KernelVersion: 6.15
> +Contact:       "Antheas Kapenekakis" <lkml@antheas.dev>
> +Description:
> +               Some OneXPlayer devices (e.g., X1 series) feature a littl=
e LED
> +        nested in the Turbo button. This LED is illuminated when the
> +        device is in the higher TDP mode (e.g., 25W). Once tt_toggle
> +        is engaged, this LED is left dangling to its last state. This
> +        attribute allows userspace to control the LED state manually
> +        (either with 1 or 0). Only a subset of devices contain this LED.
> +
> diff --git a/Documentation/hwmon/oxpec.rst b/Documentation/hwmon/oxpec.rs=
t
> index 581c4dafbfa1..0a0a7c5d0263 100644
> --- a/Documentation/hwmon/oxpec.rst
> +++ b/Documentation/hwmon/oxpec.rst
> @@ -1,35 +1,41 @@
>  .. SPDX-License-Identifier: GPL-2.0-or-later
>
> -Kernel driver oxp-sensors
> +Kernel driver oxpec
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
>  Authors:
>      - Derek John Clark <derekjohn.clark@gmail.com>
>      - Joaqu=C3=ADn Ignacio Aramend=C3=ADa <samsagax@gmail.com>
> +    - Antheas Kapenekakis <lkml@antheas.dev>
>
>  Description:
>  ------------
>
> -Handheld devices from OneNetbook, AOKZOE, AYANEO, And OrangePi provide f=
an
> -readings and fan control through their embedded controllers.
> +Handheld devices from OneXPlayer and AOKZOE provide fan readings and fan
> +control through their embedded controllers, which can be accessed via th=
is
> +module. If the device has the platform `tt_toggle` attribute (see
> +Documentation/ABI/testing/sysfs-platform-oxp), controlling these attribu=
tes
> +without having it engaged is undefined behavior.
>
> -Currently supports OneXPlayer devices, AOKZOE, AYANEO, and OrangePi
> -handheld devices. AYANEO devices preceding the AIR and OneXPlayer device=
s
> -preceding the Mini A07 are not supportable as the EC model is different
> -and do not have manual control capabilities.
> -
> -Some OneXPlayer and AOKZOE models have a toggle for changing the behavio=
ur
> -of the "Turbo/Silent" button of the device. It will change the key event
> -that it triggers with a flip of the `tt_toggle` attribute. See below for
> -boards that support this function.
> +In addition, for legacy reasons, this driver provides hwmon functionalit=
y
> +to Ayaneo devices, and the OrangePi Neo (AOKZOE is a sister company of
> +OneXPlayer and uses the same EC).
>
>  Supported devices
>  -----------------
>
>  Currently the driver supports the following handhelds:
> -
>   - AOKZOE A1
>   - AOKZOE A1 PRO
> + - OneXPlayer 2/2 Pro
> + - OneXPlayer AMD
> + - OneXPlayer mini AMD
> + - OneXPlayer mini AMD PRO
> + - OneXPlayer OneXFly variants
> + - OneXPlayer X1 variants
> +
> +In addition, until a driver is upstreamed for the following, the driver
> +also supports controlling them:
>   - AYANEO 2
>   - AYANEO 2S
>   - AYANEO AIR
> @@ -41,29 +47,8 @@ Currently the driver supports the following handhelds:
>   - AYANEO Geek
>   - AYANEO Geek 1S
>   - AYANEO KUN
> - - OneXPlayer 2
> - - OneXPlayer 2 Pro
> - - OneXPlayer AMD
> - - OneXPlayer mini AMD
> - - OneXPlayer mini AMD PRO
> - - OneXPlayer OneXFly
> - - OneXPlayer X1 A
> - - OneXPlayer X1 i
> - - OneXPlayer X1 mini
>   - OrangePi NEO-01
>
> -"Turbo/Silent" button behaviour toggle is only supported on:
> - - AOK ZOE A1
> - - AOK ZOE A1 PRO
> - - OneXPlayer 2
> - - OneXPlayer 2 Pro
> - - OneXPlayer mini AMD (only with updated alpha BIOS)
> - - OneXPlayer mini AMD PRO
> - - OneXPlayer OneXFly
> - - OneXPlayer X1 A
> - - OneXPlayer X1 i
> - - OneXPlayer X1 mini
> -

As in the previous patch, I don't think we need to pre-stage the move
of those devices until the other driver is ready to be submitted.

Cheers,
- Derek

>  Sysfs entries
>  -------------
>
> @@ -79,11 +64,4 @@ pwm1_enable
>  pwm1
>    Read Write. Read this attribute to see current duty cycle in the range=
 [0-255].
>    When pwm1_enable is set to "1" (manual) write any value in the range [=
0-255]
> -  to set fan speed.
> -
> -tt_toggle
> -  Read Write. Read this attribute to check the status of the turbo/silen=
t
> -  button behaviour function. Write "1" to activate the switch and "0" to
> -  deactivate it. The specific keycodes and behaviour is specific to the =
device
> -  both with this function on and off. This attribute is attached to the =
platform
> -  driver and not to the hwmon driver (/sys/devices/platform/oxp-platform=
/tt_toggle)
> +  to set fan speed.
> \ No newline at end of file
> --
> 2.48.1
>


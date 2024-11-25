Return-Path: <linux-pm+bounces-18073-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082C89D87AC
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A838C1613C0
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C861B413F;
	Mon, 25 Nov 2024 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSFQdhsg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE481B4126;
	Mon, 25 Nov 2024 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543978; cv=none; b=LKG6sFopCGiC7ySZUHSlPFUnhpiPt8XFQwAFmDqmaiBuVH+MM7vt3jV95e0Vnwq432jv9HepckpO0lSyPiXw8tV+ImWhjYF/40Gge/sGUdwCmhzzuwzwtzoGApXtWn4bN8MFU53zCN8N1NnMvSYgDXPmI/glI8MItRPm1Y723Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543978; c=relaxed/simple;
	bh=xrivQPMZdpaUD1ZOIgTpZSgKNYbghzMeckLij8AhdtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXDoEBkGRGyqDYd5QIQ19gWgQ3ynhaLvFEElBzsnTbKBSQ81rDJ4DNw12w1fMfsmr67a+NYLALpeckjfba6N840Q+9S99+kAoCnxXQ+mSnXiiX+COjGTU5wXzSHryMGbzxlY+q0505sZHmU9dgzF5IoSS0NVcze68NlltGlfQrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSFQdhsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7119CC4CED7;
	Mon, 25 Nov 2024 14:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543978;
	bh=xrivQPMZdpaUD1ZOIgTpZSgKNYbghzMeckLij8AhdtE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pSFQdhsgO7C7SbaCYAT0sEf0PgN9M1hO9eAxRycrZDtMnz6Fkvzk74Vy70b/WVO6a
	 J1i3doiYw08TH0Yr4T1SNAusPwxAQAUInG/z9qg6mRaGo1kCB1/xgLjcD+QvpesTO/
	 X40jrYisnN/5cifsQy0BuKlqI3fXG/ukpTsC4Qs1tozIU2F3Aavsrkjvk3jU+J/gI1
	 GBMe2cij10xWF1zIXHYNoR7B79vHeQwKGZWJYitlMlzhxtWQnc+KAyPL64vcW4R0/s
	 NDWrzeU8o1NINIXfrZr46IRc1lkDCyMUBHwKVBuzTC0fXL4R61WScSys0LakJJrRXZ
	 V+IGaEUE5g+ew==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2967fb53621so2537860fac.0;
        Mon, 25 Nov 2024 06:12:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmJqipkGXsPVpYgHgYUGPFwduSkFW1O5UAL2G7sCvFmnOj7ZbvMf8oi0x4f3EwLsXHCQata7HH8tC75Q==@vger.kernel.org, AJvYcCUwo4DdTaiuSvffTwxd4FwGSUqgIU60E+tqkKByeATGlDZ6gXF2mTNKjDghs7ORv7UXqssIiVvjfCJvhZ8n@vger.kernel.org, AJvYcCXPhZmxz1LxuYc5sW608WZqOnoVYSH7UyYQYfOdvHtAzRI+LDpH13VcPs522WC8bCaGAUBLEoIIbdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJRuF63JesD988Y4YMd95U+MhmtoYognrAJrXWD7l7clUIJVMz
	5GxvGK2JpYVjWN+UuYMQxlGV1G6rrbsmNFTt1YA/vZGSZczhLVHpNf7pSHRqLYyCKO9SivL7S1R
	mXespVEDXyB/hfwhiNFeVwUJyyAI=
X-Google-Smtp-Source: AGHT+IEUalT/+k/nt8RXO9y4VhfUvKEe3Mx8CnrfxRbIyWHtuU76FKGn8hkRZey+URZ5mKbXbG0YRRnXwz4CLPlladw=
X-Received: by 2002:a05:6870:5d88:b0:296:bc75:6c6a with SMTP id
 586e51a60fabf-2971e9b1c9dmr7634787fac.17.1732543977707; Mon, 25 Nov 2024
 06:12:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-hwmon-thermal-v3-0-9c17973e7342@weissschuh.net> <20241118-hwmon-thermal-v3-1-9c17973e7342@weissschuh.net>
In-Reply-To: <20241118-hwmon-thermal-v3-1-9c17973e7342@weissschuh.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Nov 2024 15:12:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i8p=jxnWepLHpH3uuxrtkpPhuWcPYwHQnQnzX=hTERRw@mail.gmail.com>
Message-ID: <CAJZ5v0i8p=jxnWepLHpH3uuxrtkpPhuWcPYwHQnQnzX=hTERRw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] thermal: core: Add stub for thermal_zone_device_update()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 7:16=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> To simplify the !CONFIG_THERMAL case in the hwmon core,
> add a !CONFIG_THERMAL stub for thermal_zone_device_update().
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

and please route it through hwmon.

> ---
>  include/linux/thermal.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 25ea8fe2313e6d0a53192974a80d92f50f0ff03e..455e0814b9165dbb96d698e67=
0f160136a017cc4 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -289,6 +289,10 @@ static inline struct thermal_zone_device *thermal_tr=
ipless_zone_device_register(
>  static inline void thermal_zone_device_unregister(struct thermal_zone_de=
vice *tz)
>  { }
>
> +static inline void thermal_zone_device_update(struct thermal_zone_device=
 *tz,
> +                                             enum thermal_notify_event e=
vent)
> +{ }
> +
>  static inline struct thermal_cooling_device *
>  thermal_cooling_device_register(const char *type, void *devdata,
>         const struct thermal_cooling_device_ops *ops)
>
> --
> 2.47.0
>


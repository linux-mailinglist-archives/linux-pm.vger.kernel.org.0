Return-Path: <linux-pm+bounces-23798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB45A5B02C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 00:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25173A4EA2
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 23:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C264F2222B6;
	Mon, 10 Mar 2025 23:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwR1AQxn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F8C1922C0;
	Mon, 10 Mar 2025 23:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741651040; cv=none; b=CcSet0SGKVtMrZnvG7Z4j+geHBv7doPbQL2U0m4WkIZoCInUi06/PSZ7L+rIyHCntQBww+p64TUvsEPiaKPpUcnbT5rOhekH/C+cWkvxG8U0UZKxT8M7q7zjEqlUTamIyXtG6rD/jdaky6QjMlD3LGJvb6cdp0lmYXvsxe3SXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741651040; c=relaxed/simple;
	bh=LHIBZoBaAAaXrVjJ9T/CLYaRmabk4Ow+YUrOyOYIOAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNgcJ+zFmTNdHYaJXSdxf29R+wZeHdsdzshcMkQK8aAQ3/2vJHspfiRHSaTMiNGZfdGT/c4egMbIozY0R4G7VTez9LOUe8KwpC5dWLNDAV3RxZUNOGQMIQSfUrrY9iIYfqlQTltq95WHIVTBuXrGKLSVMDANzorpwZTULBpV3cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwR1AQxn; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c081915cf3so646695085a.1;
        Mon, 10 Mar 2025 16:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741651038; x=1742255838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hg1V2HSj+1Zm7WIe6YKpRhNoPetsjI54NAswVDfgmzU=;
        b=TwR1AQxnyA31JLuYD7dnois4CdUyWababcXDLfClnuCG4I8d7hlEifeT7Qen922vTq
         2ABXHa8lIy2GVzkW7/BXhwn0qpTK+gxatPRP9/LpnpbBzkOimCaUYw6vhZkS0rcylkF/
         Ezh6fkJzKasRsm0lcvWi3RDfsiuk5yeVniLQ+LdF+Mf+YroXXpYvAqYFaamI80YsUFvB
         wHei4vN7HWC7zkGPJT5lVaEb1WADKEvXnlQ1JOQjY14cZBXsCQHVBPfdZ0aHeO0t0foe
         v3Kzr7F1x0uwcJ0GxJ1wDLYAZ+mI1mSwHPNSGBzxjVAFWhctKU4mRpQaaMiIxidPKqzg
         YknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741651038; x=1742255838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hg1V2HSj+1Zm7WIe6YKpRhNoPetsjI54NAswVDfgmzU=;
        b=itY+oPWrzK1ULrhl9xXYLZAG6HgNOQF64UUbwzMnBC6KXcVD3Ahy2BB7KQumrbsFCn
         Iyjf/s7TNg9eZiLEGmb9UbVdrcys9vpCON5+eeHirI+sKcYfXytreXOwn0+JoPlGSfZS
         FgqN5ON3arazw5E0EbsCKjsS9wYYKj2Ztc8akrRTDEfRh3PmzOjyLH5UQ1fIMRAMDdEj
         mhJ3gyPeRoBZoMFMsPSU/okhez84OrvPjfttX+1pCcCSjJqGQ0PS7Tvlb7ythPoasLiQ
         jeXACJarP8c3hZdRaDu8Qi0eCZNt/1uvPPuxtQcWCAf2mUW3c0RwILwebpJvRCD7cDoL
         2O7A==
X-Forwarded-Encrypted: i=1; AJvYcCUTdkPhp6J/yRsuE8mKgk/N8pONHogx1yh39L4kh38zVPt1dkJjy4ED2/hsOQfkXyDu5SDFsmpRm+o=@vger.kernel.org, AJvYcCUheoeJjl9KQYlFPh/Inu8hE+L18YlO3sTpAZs+ecQu7PMLzGiqNZHwR9Zu9T6Omyq/yP3EyTtKrSY=@vger.kernel.org, AJvYcCV4lzPARI/bb5uwuHw1eFFDc2Tem77mw+yWlptlHPw0/JhmUpM+HHgqsrUAOonXf9bwn6m/IR7QnWevoLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWEqQIUktwTOZ0d6+MLs+X0C8bRg+nz98yK0tav+6tZNuOpBD/
	EfCgXL5ambbHrz/RZ4x9Odwm/pjAau5u9sf7CAch0QpOD+znWVBwr+AQW8bGp/NBcePiS2yEXB5
	WuJox8KutGLnM89s0wB9SyBfHkYM=
X-Gm-Gg: ASbGncua/9Qv2Ea4DLZkzGCojsHfvH/GGlOfIZhi0B7s8LjFfAyPkXN3SHVNY8F82Fy
	mRc0IcEwA6kgyfjxA60A4B/y038x6YfhR64XAjtftU4P+hNmb1lAdZDEj8RsUsD/hSeNvEoKbnU
	Fn4LQsXy4pi6QsjOlv2GUSjES/cLE=
X-Google-Smtp-Source: AGHT+IHJQB70TMRcKrxGbh73L1d7g8c8xIrDGBk9SbswNFTjxM/pnURf/ci+TNSsVsRzCNpX2S2muXON29V8ec8HzoA=
X-Received: by 2002:a05:6214:5014:b0:6e5:a0fc:f65c with SMTP id
 6a1803df08f44-6e9004dc909mr237018266d6.0.1741651037908; Mon, 10 Mar 2025
 16:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309112114.1177361-1-lkml@antheas.dev> <20250309112114.1177361-9-lkml@antheas.dev>
In-Reply-To: <20250309112114.1177361-9-lkml@antheas.dev>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 10 Mar 2025 16:57:07 -0700
X-Gm-Features: AQ5f1JqKEEg9QUZAyvaHHkMrBjHKKjWjYLjhuiBA48FhVy_GfA0f8TQcxBCUEjM
Message-ID: <CAFqHKT=-H61jsit90C3p34BkrhodeU9=KAXeByPoNzCi698TNA@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] platform/x86: oxpec: Add turbo led support to X1 devices
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
> The X1 and X1 mini lineups feature an LED nested within their turbo
> button. When turbo takeover is not enabled, the turbo button allows
> the device to switch from 18W to 25W TDP. When the device is in the
> 25W TDP mode, the LED is turned on.
>
> However, when we engage turbo takeover, the turbo led remains on its
> last state, which might be illuminated and cannot be currently
> controlled. Therefore, add the register that controls it under sysfs,
> to allow userspace to turn it off once engaging turbo takeover and
> then control it as they wish.
>
> 2024 OneXPlayer devices, other than the X1s, do not have a turbo LED.
> However, earlier models do, so this can be extended to them as well
> when the register for it is found.
>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/oxpec.c | 84 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index 9cb024325da5..eb7eafebbd37 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -106,6 +106,12 @@ static enum oxp_board board;
>  #define OXP_X1_CHARGE_BYPASS_MASK_ALWAYS (OXP_X1_CHARGE_BYPASS_MASK_S0 |=
 \
>         OXP_X1_CHARGE_BYPASS_MASK_S3S5)
>
> +/* X1 Turbo LED */
> +#define OXP_X1_TURBO_LED_REG           0x57
> +
> +#define OXP_X1_TURBO_LED_OFF           0x01
> +#define OXP_X1_TURBO_LED_ON            0x02
> +
>  static const struct dmi_system_id dmi_table[] =3D {
>         {
>                 .matches =3D {
> @@ -453,6 +459,73 @@ static ssize_t tt_toggle_show(struct device *dev,
>
>  static DEVICE_ATTR_RW(tt_toggle);
>
> +/* Callbacks for turbo toggle attribute */
> +static umode_t tt_led_is_visible(struct kobject *kobj,
> +                                   struct attribute *attr, int n)
> +{
> +       switch (board) {
> +       case oxp_x1:
> +               return attr->mode;
> +       default:
> +               break;
> +       }
> +       return 0;
> +}
> +
> +static ssize_t tt_led_store(struct device *dev,
> +                              struct device_attribute *attr, const char =
*buf,
> +                              size_t count)
> +{
> +       u8 reg, val;
> +       int rval;
> +       bool value;
> +

Reverse xmas tree.

> +       rval =3D kstrtobool(buf, &value);
> +       if (rval)
> +               return rval;
> +
> +       switch (board) {
> +       case oxp_x1:
> +               reg =3D OXP_X1_TURBO_LED_REG;
> +               val =3D value ? OXP_X1_TURBO_LED_ON : OXP_X1_TURBO_LED_OF=
F;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +       rval =3D write_to_ec(reg, val);
> +
> +       if (rval)
> +               return rval;
> +
> +       return count;
> +}
> +
> +static ssize_t tt_led_show(struct device *dev,
> +                             struct device_attribute *attr, char *buf)
> +{
> +       int retval;
> +       u8 reg;
> +       long enval;
> +       long val;
> +

Reverse xmas tree.

Cheers,
- Derek

> +       switch (board) {
> +       case oxp_x1:
> +               reg =3D OXP_X1_TURBO_LED_REG;
> +               enval =3D OXP_X1_TURBO_LED_ON;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       retval =3D read_from_ec(reg, 1, &val);
> +       if (retval)
> +               return retval;
> +
> +       return sysfs_emit(buf, "%d\n", val =3D=3D enval);
> +}
> +
> +static DEVICE_ATTR_RW(tt_led);
> +
>  /* Callbacks for turbo toggle attribute */
>  static bool charge_behaviour_supported(void)
>  {
> @@ -898,8 +971,19 @@ static struct attribute_group oxp_tt_toggle_attribut=
e_group =3D {
>         .attrs =3D oxp_tt_toggle_attrs,
>  };
>
> +static struct attribute *oxp_tt_led_attrs[] =3D {
> +       &dev_attr_tt_led.attr,
> +       NULL
> +};
> +
> +static struct attribute_group oxp_tt_led_attribute_group =3D {
> +       .is_visible =3D tt_led_is_visible,
> +       .attrs =3D oxp_tt_led_attrs,
> +};
> +
>  static const struct attribute_group *oxp_ec_groups[] =3D {
>         &oxp_tt_toggle_attribute_group,
> +       &oxp_tt_led_attribute_group,
>         NULL
>  };
>
> --
> 2.48.1
>


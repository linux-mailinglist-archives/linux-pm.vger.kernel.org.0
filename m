Return-Path: <linux-pm+bounces-21203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BE7A24873
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 12:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0128166084
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 11:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A4014C5A1;
	Sat,  1 Feb 2025 11:05:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671811448C7;
	Sat,  1 Feb 2025 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738407955; cv=none; b=GdHSg+e2luEQJexeMJpmO32ablMy+jgzcmSIIPsfte/Jt1djhybRN3Bn8MSdKpv4RNpPNLvjcj9742ZbcMb6DkxwYOjmdIkvneMpBeTKp74IvPFFYCtSAQybfp4oJfP/1LAIvwCUQAdCo3Ly5FB3t9WeNwukRJVZUwaqAUvjTyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738407955; c=relaxed/simple;
	bh=QeyoZ9JZh4ldAcSoJnAO6EQhHF4J+fpIS05dmP1aGBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6EM7jSqFCPfnv3Lp0oiVm+dIvXykYRCodPYDXAl9coHd5Y+yb0yV/OPMBH7ZVQkfbgEM16AUWf+UKxs6jLDfKfPi1Mj5Qs2HVmVXyxa4FpCLr9gKtkD8JLUuSMJmG1g4NE986BoorO6kEJY/cwxX3XujI7BXzy8O0EkUmIE1sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53f22fd6887so2930537e87.2;
        Sat, 01 Feb 2025 03:05:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738407949; x=1739012749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8U+1tpqHzLh27GaClK8FP8Rq3KYuov9AdiNEVI21x8w=;
        b=rsG4HKFIpwKG+TcsP5Bzl9J5cqn4Zo5nh2C++oVRCBzjyzMkDaVEKO4yOrUxlwyIs1
         cPZz1DIoQCWxvWT5eBrIckOp2inJZo0C7Awx1P29Iz2oUa4e07HyajIfPSclTWKKi/00
         j5C4G2/zxgBpkt6YW0MHjAIOri3pq4sttEne5xwJ4fULA6hZVdFrH7uC5gPWIIUAv+P4
         QCnwgv6LAuuG09JjR/+rjw8AQccooBClCDi9+62jOoLR293hS3zDL2RHDnp1wWQhaomp
         yKxSQ9ywFpTg5YoyfI8x6ZGsTw6+cisdpCT2NCYWIbvUHuk646CTOfbjZgC7mzL2kfTl
         MNSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0YqujmG2qBZ9B4ce14YHjnjDDcN4ebqBK3psHITZ7QHiSHf4D+k7iFxRF/c0n1fXIwhoNe6Zv2DU=@vger.kernel.org, AJvYcCXap7La8LhlsB+gh1i2GJh3f5LXBpnKJ9FGQqNVghrCLFdy1TkMee3GxKWkiSg5uvXoS08AC2mPtLoR@vger.kernel.org
X-Gm-Message-State: AOJu0YxcIILhmuZICsXkMUcxP+9DbZ1R6q0gxLc+ot2WIfSZAWRTTFxW
	fonb81qw2Asl9LDhLURvpVMBdt6HprScB5fifjUzrFvaOxVu3sEupY4zOJlt
X-Gm-Gg: ASbGncvHy7ei0jck0txaR17ObW1C1jaT+viHElfy5e6Rc+cM/RZKXcholYktq53SV/5
	WvnZjJi7F3fzzB4Hv1BHKKD9nNxBdEneBveV4TXCcAi0RtL8goUw3lmhnL+4hmOh8iEhn0Fnis/
	MwUkh49eShGCQavJ6bO1q8ntsBk0IngKK4/H/0TbTuBOaAskrklcUPqFL1GPQuoSPC517EEJtSm
	+kp2YKWIAWnvuXTCi2TxD0+rwcv4nnL5fVtkhdcb/7KSlKEb//bWNpz77ZWkCJjLZGQONEVSk0L
	JRzkHNWjpAG/cMTCTnsz7v0tpI7PZy8Q2uqLZL34dmPVhO5u
X-Google-Smtp-Source: AGHT+IH+k8/FsTLeUwmzncP3Lfy1CqYrW4OX7YX24cuZ9VmF2MsajIZJKLgdcTlrCX4Sudkq1jnxfA==
X-Received: by 2002:a05:6512:3d10:b0:540:30df:b3ea with SMTP id 2adb3069b0e04-543e4be9c81mr5132006e87.15.1738407949326;
        Sat, 01 Feb 2025 03:05:49 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebebef3fsm710440e87.257.2025.02.01.03.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 03:05:48 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30797730cbdso27390101fa.3;
        Sat, 01 Feb 2025 03:05:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3WcYKUsc6Th+X01r3YDLhO5xUUX4h9YzCcpoB/fXKAFqU2b8mUjpe2LAbWpO0HvoYICJdNU89CqY=@vger.kernel.org, AJvYcCWQBA5sw5UMjaKVJE6Csyz5WJALzrhCyRzjCEqUA7hBEpNbqaxVj1XwYxxGluuHgafQ8nUWZ8JDY2p/@vger.kernel.org
X-Received: by 2002:a2e:2283:0:b0:304:68e5:eabf with SMTP id
 38308e7fff4ca-307968c9b71mr42859311fa.23.1738407948632; Sat, 01 Feb 2025
 03:05:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131231455.153447-1-macroalpha82@gmail.com> <20250131231455.153447-5-macroalpha82@gmail.com>
In-Reply-To: <20250131231455.153447-5-macroalpha82@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 1 Feb 2025 19:05:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v64Bi__en5iw0Bv4=17MrJ2+HxbdDppoHiAxApPStjPw4Q@mail.gmail.com>
X-Gm-Features: AWEUYZnfWFSX1_fTI8oxEiVO5dHsIJ_LtTRZxZgbPDCntorA83Cj4iF28Ip2qHM
Message-ID: <CAGb2v64Bi__en5iw0Bv4=17MrJ2+HxbdDppoHiAxApPStjPw4Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] power: supply: axp20x_battery: Update temp sensor for
 AXP717 from device tree
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, lee@kernel.org, samuel@sholland.org, 
	jernej.skrabec@gmail.com, conor+dt@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, sre@kernel.org, Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 7:17=E2=80=AFAM Chris Morgan <macroalpha82@gmail.com=
> wrote:
>
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Allow a boolean property of "x-powers,no-thermistor" to specify devices
> where the ts pin is not connected to anything. This works around an
> issue found with some devices where the efuse is not programmed
> correctly from the factory or when the register gets set erroneously.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/power/supply/axp20x_battery.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply=
/axp20x_battery.c
> index 3c3158f31a48..345a1bbe50ad 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -89,6 +89,8 @@
>  #define AXP717_BAT_CC_MIN_UA           0
>  #define AXP717_BAT_CC_MAX_UA           3008000
>
> +#define AXP717_TS_PIN_DISABLE          BIT(4)
> +
>  struct axp20x_batt_ps;
>
>  struct axp_data {
> @@ -117,6 +119,7 @@ struct axp20x_batt_ps {
>         /* Maximum constant charge current */
>         unsigned int max_ccc;
>         const struct axp_data   *data;
> +       bool ts_disable;
>  };
>
>  static int axp20x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_=
batt,
> @@ -984,6 +987,22 @@ static void axp717_set_battery_info(struct platform_=
device *pdev,
>         int ccc =3D info->constant_charge_current_max_ua;
>         int val;
> +       axp_batt->ts_disable =3D (device_property_read_bool(axp_batt->dev=
,
> +                                                         "x-powers,no-th=
ermistor"));
> +
> +       /*
> +        * Under rare conditions an incorrectly programmed efuse for
> +        * the temp sensor on the PMIC may trigger a fault condition.
> +        * Allow users to hard-code if the ts pin is not used to work
> +        * around this problem.

AFAICT this function won't get run if there is no "monitored-battery"
property under the PMIC node. So if someone were to unfortunately have
a dev board that has a PMIC with incorrect efuse values, this won't
save them.

This should be exceedingly rare, so I only ask that you mention this
in the comment so if someone does unfortunately run into it they will
have some clue.


Thanks
ChenYu

> +        */
> +       if (axp_batt->ts_disable) {
> +               regmap_update_bits(axp_batt->regmap,
> +                                  AXP717_TS_PIN_CFG,
> +                                  AXP717_TS_PIN_DISABLE,
> +                                  AXP717_TS_PIN_DISABLE);
> +       }
> +
>         if (vmin > 0 && axp717_set_voltage_min_design(axp_batt, vmin))
>                 dev_err(&pdev->dev,
>                         "couldn't set voltage_min_design\n");
> --
> 2.43.0
>


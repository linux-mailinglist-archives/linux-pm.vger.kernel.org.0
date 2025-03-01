Return-Path: <linux-pm+bounces-23217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B87A4AC8B
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 16:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045D918967D6
	for <lists+linux-pm@lfdr.de>; Sat,  1 Mar 2025 15:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C4F1E2007;
	Sat,  1 Mar 2025 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaCnTMM8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F851DF252;
	Sat,  1 Mar 2025 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740842480; cv=none; b=HjkUBoSWpUwOktPW+jV6rdDTolrPwMHv16GTbvb6znyP9Mbr+N4IPbDHqko3DvqsTVPfebWH0X9SjGZgUc2As/QjEdhqarLt+Cym9+Ec0P6SsqC3nDJj2K7085hJnMddRzGvokEsvvOuFIfBIDSr5rUMRUSXFmX+JXl3uq1rUxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740842480; c=relaxed/simple;
	bh=nrX2EwoJan/x6c4cV0ZYpxhmtXF4sqUCXV2N34w/5gQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=lXHvUN69hPdAQfhS5vtut+GRAKHmHTvAUV30hMlOIt+6urLnokS5KpbaQcFU6L3eOdaGB+jDn+b6ThGkGWlxtBqpNzJjVlJQ/N17tXb0jTQFghvykw3/SmwplC0TGZVo3GlRY/BulWysNQ+DrgQerNstIocgfERRavwzX/M6Fnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaCnTMM8; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2feb91a2492so3186775a91.2;
        Sat, 01 Mar 2025 07:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740842477; x=1741447277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+vzDpo5jVOQKxgjljPggE2Ez9BaG6Ry38DHKxfVt+G4=;
        b=gaCnTMM84NGMbIWTHAftLHFOdcouTFQIbwwqR3NC0y9S4zC/kx68qotps84P9kl1O2
         mLWmnh98NAUDCplx1B6/0DL4YhX0pAHlVIQjsJYoyh6TjwlUEzCgZh21sAXfj7mVCMRv
         Pav516/8wXLTFi8s2gP9S6yecqADDHSeZv0t5OkWlTFyUtN24WMehHh1IFxkFI2sm5Fk
         CvdLxu39ZCT2kmdiPzTo6uVB3L54K3vTrCkc/88+uPYD4yyxoMAv1YfnbBGr6rNx6wff
         pYo0VcTc117qQRHLlsdrxm9B5ir+vmQ0og6X1d1i3wmkJ8bmbpLKnuxgEja68+2a/Q7u
         qb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740842477; x=1741447277;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+vzDpo5jVOQKxgjljPggE2Ez9BaG6Ry38DHKxfVt+G4=;
        b=BgQqasdX6TRWKIkOFvR3b1bQpW2KNbF+Wr24pgie8zlq7vgmnTrQAO5Lxvt+fFWx9O
         QJPSsh0TkGj/klWYGky0OTQquw7Ex7GBdsiDYtl5XNSmrzXXiS9/Sv9Cda0Ad+lbGSPB
         OVIOshYkoQME0EZ/+PekEWgRyl8KniK7y6BSPsx8yG6Umy4PxyyoABzubC4LRa1xl0Is
         OPwWwkDH8ZAx5jEG6qnpLw2jv/A4Z4me6o8mRikusU7xcnq4wYBU4x9oF8Ob0IoyAsIG
         TPpN76UnEBF7S/qiTqM0l1xgzNcSLsdEYNhpbGj/+xo7xs71NVrJMgQBPum4jG/YikLv
         2QMA==
X-Forwarded-Encrypted: i=1; AJvYcCVHWwIDkp/oQHPDvLM/Bjgba7nYnPLLin9bZoZDzQCua0XORuT2IZ+qvh/WuThSdi1QZudzBh/p8c2se0P+gB/HuWv+kQ==@vger.kernel.org, AJvYcCVTl5exjttxEuv27feDX66pANsCX3rXtHjyodVYSFoQ2WTNxW1xFxzVmwg+LwKY8/vLbvYvbWMU3vg=@vger.kernel.org, AJvYcCVgimd8WdS4EqUKkYtmhVcl9G3lNDusM8d31asxD0jIoZ5rGpbPBTe3brEZVOh2/u4+gj4X/JQkqAFzbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRf6aLm2BB4pox4blNq7LUcuI43dtXdCVel2lxCZIXl5gzcYzK
	SKxrkjYxYRMt5TXHL/nXcmjgq18XXURSdEI1DligmnLfxn5l00K5FKT2ag/h
X-Gm-Gg: ASbGncsSs+UZh02sF+a8V3WU86Qxt9jIHEE5hTHYyck27966Jycl6865Cry48vq8Z2N
	oXWA1ESsjw+yBm6JvVPTGiwwY3/A4rUQQbJEQ1jziKODTP4yzQMvcN476w9IHfyMhlGP7ALKkNj
	4xSLVzG1kkkCAqfTqKGxJecdo1ney5/U2Eq0dtmgqK1J5Ux8r3rSgOGQJXgkW9dJ2v4vN/WhY5n
	vf4f9MYDlQtVUtJvfQ1yLLY9er/TXSzCFhycENdXVQJm3fIJ6ZpYeh6HvgpoVAPTnISMube9k0r
	w08bBcOyneZAee8+cFC/kbR6Ds9QUTVZI7xBqtVzmlhh8rF6tFM=
X-Google-Smtp-Source: AGHT+IGQN9RCsFZ0yvhm8kAOFeVLuQRliQ//1wtm0H8YUBCstl42QDRPPjwYi9ADHGz2K8rSYOzgvQ==
X-Received: by 2002:a17:90b:4c07:b0:2ee:5bc9:75c7 with SMTP id 98e67ed59e1d1-2febab2ec91mr11039455a91.5.1740842476800;
        Sat, 01 Mar 2025 07:21:16 -0800 (PST)
Received: from ?IPv6:::1? ([2607:fb91:161:844d:ad2:fe52:5203:b867])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe82840ac4sm7753341a91.36.2025.03.01.07.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Mar 2025 07:21:16 -0800 (PST)
Date: Sat, 01 Mar 2025 07:21:07 -0800
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Antheas Kapenekakis <lkml@antheas.dev>, linux-hwmon@vger.kernel.org
CC: linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
 Eileen <eileen@one-netbook.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_07/12=5D_hwmon=3A_=28oxp-sensors=29?=
 =?US-ASCII?Q?_Move_pwm=5Fenable_read_to_its_own_function?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250222161824.172511-8-lkml@antheas.dev>
References: <20250222161824.172511-1-lkml@antheas.dev> <20250222161824.172511-8-lkml@antheas.dev>
Message-ID: <45CB603E-1CD9-4BC8-80C4-107A4943E9CC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 22, 2025 8:18:18 AM PST, Antheas Kapenekakis <lkml@antheas=2Ed=
ev> wrote:
>Currently, this driver breaks sysfs by using auto as 0 and manual as 1=2E

It breaks hwmon ABI convention, the sysfs is fully functional=2E Please be=
 more accurate as maintainers may misunderstand the problem here=2E This co=
mment applies to 8/12 as well=2E You should probably link the discussion wh=
ere this was identified as well for context=2E

<https://lore=2Ekernel=2Eorg/linux-hwmon/20241027174836=2E8588-1-derekjohn=
=2Eclark@gmail=2Ecom/T/#u>

>However, for pwm_enable, 0 is full speed, 1 is manual, and 2 is auto=2E
>For the correction to be possible, this means that the pwm_enable
>endpoint will need access to both pwm enable and value (as for
>the 0th value, the fan needs to be set to full power)=2E
>
>Therefore, begin by moving the current pwm_enable read to its own
>function, oxp_pwm_enable=2E
>
>Signed-off-by: Antheas Kapenekakis <lkml@antheas=2Edev>
>---
> drivers/hwmon/oxp-sensors=2Ec | 50 ++++++++++++++++++++-----------------
> 1 file changed, 27 insertions(+), 23 deletions(-)
>
>diff --git a/drivers/hwmon/oxp-sensors=2Ec b/drivers/hwmon/oxp-sensors=2E=
c
>index 9c43ec0fc994=2E=2E1da1e1655f96 100644
>--- a/drivers/hwmon/oxp-sensors=2Ec
>+++ b/drivers/hwmon/oxp-sensors=2Ec
>@@ -762,6 +762,32 @@ static int oxp_pwm_disable(void)
> 	}
> }
>=20
>+static int oxp_pwm_read(long *val)
>+{
>+	switch (board) {
>+	case orange_pi_neo:
>+		return read_from_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, 1, val);
>+	case aok_zoe_a1:
>+	case aya_neo_2:
>+	case aya_neo_air:
>+	case aya_neo_air_1s:
>+	case aya_neo_air_plus_mendo:
>+	case aya_neo_air_pro:
>+	case aya_neo_flip:
>+	case aya_neo_geek:
>+	case aya_neo_kun:
>+	case oxp_2:
>+	case oxp_fly:
>+	case oxp_mini_amd:
>+	case oxp_mini_amd_a07:
>+	case oxp_mini_amd_pro:
>+	case oxp_x1:
>+		return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
>+	default:
>+		return -EOPNOTSUPP;
>+	}
>+}
>+
> /* Callbacks for hwmon interface */
> static umode_t oxp_ec_hwmon_is_visible(const void *drvdata,
> 				       enum hwmon_sensor_types type, u32 attr, int channel)
>@@ -859,29 +885,7 @@ static int oxp_platform_read(struct device *dev, enu=
m hwmon_sensor_types type,
> 			}
> 			return 0;
> 		case hwmon_pwm_enable:
>-			switch (board) {
>-			case orange_pi_neo:
>-				return read_from_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, 1, val);
>-			case aok_zoe_a1:
>-			case aya_neo_2:
>-			case aya_neo_air:
>-			case aya_neo_air_1s:
>-			case aya_neo_air_plus_mendo:
>-			case aya_neo_air_pro:
>-			case aya_neo_flip:
>-			case aya_neo_geek:
>-			case aya_neo_kun:
>-			case oxp_2:
>-			case oxp_fly:
>-			case oxp_mini_amd:
>-			case oxp_mini_amd_a07:
>-			case oxp_mini_amd_pro:
>-			case oxp_x1:
>-				return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
>-			default:
>-				break;
>-			}
>-			break;
>+			return oxp_pwm_read(val);
> 		default:
> 			break;
> 		}

- Derek


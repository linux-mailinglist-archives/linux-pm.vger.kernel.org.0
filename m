Return-Path: <linux-pm+bounces-21202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E171A2485E
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 11:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD063A206A
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 10:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7B1153838;
	Sat,  1 Feb 2025 10:52:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6EC43179;
	Sat,  1 Feb 2025 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738407161; cv=none; b=pzpPDxWDIMZAbfMt7pykCUU/o42PMl3sp6vYgQKriOQzOinf/iFYs9j34irySY+n31d+92NpDw/kpUa2+Cth/P2oXMC6GjdrcpL9hKgIwC0YYxBvJT+Lktf+I4lNJ+1WA5EXXqc7aWKIuRLfuKgd5CFVpP+Dqed0mCu0XJibMDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738407161; c=relaxed/simple;
	bh=GftBZ8rMZl72TpEgFZw+F1ogkNcPyAqM9PkddAl2/cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vgvs7jnHGAGdDHalvj3OMq6LxyAvMl4np6Y99c6aFTNRqmGheEUi4dcOdNSNrVe/mVSIrkApCxu7oiYrVCHq9cOxK1vgFPORGo8OO1NWHefod9+1/zSImTkTSEh7qpzVDxmifJG0loCJeARrSB6tjKg49gQYFp0XrNBllaSABxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-303548a9361so20854361fa.0;
        Sat, 01 Feb 2025 02:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738407156; x=1739011956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kRwFI5d8wyEyXjJelLyWqjx7Awrgh8zTXgtWY1JnNlU=;
        b=X8OTknu3yKff9aa1GmAcg+mswUN2TUNT882ozCY8rPDOBI555hzUjKz/afFQDblX0d
         dn5vtAX0VBmX6j7WSTMm603mUo2IafeslU7KinT5oEvuRNveXXBV+b4heSOWAvEXaj3k
         FptIgE5no3SoB2820puSRJKOkBEXq4GrUKDumu6+1ZU71oNXuk8makzgC3UU2H0mi1My
         QleS7hG3Wk5wZo8sN2nobWKSZzLVTc1l3ZJHvnUCUsEex49675Yy6uSIiqu0GPk2+R7j
         hYI14MMJmlCEPImzWvVg76ZlOfjyDQaHw/B2NYQVap8uakR//Pc9hmRCH6OiPxhH34e+
         OkVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+dVDQf9EK0Sk4uEO4t8oCfYU2yZm6RW2frEwOrdimbbUQx6KLo3ctXl0QFI4fV1ud0TXpEYiLME0Z@vger.kernel.org, AJvYcCVo97Rj2rM0wINYQfxvZ08ItCiPzrk+wnsi18xta7ICWhzEzJC6Lq6yRek6bYjL3BkPQIbb9GvQ6dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxfWhJFdahYRWILla8tI4ac0RY5+0uSmnuONSHpOeD/IXwZOBc
	+zyH4wByA9r1c1fnv6HPlmrKZ6n+d2BOsQn4EkPPVSUJOuEMCN1akWZXt+Iv
X-Gm-Gg: ASbGncsr8BHd+FjrzDg56LFS6V2/YTPKMdBTd1Qts/cpEEhIk1MK0ufiEapkMSM+VNt
	CnqP0g47h1wSgg0W2pbJbFOCZrRXbpdO7OhWq6CPKkccDpG2yF6HY7Kp+IFhMaLyELcHX3FV+Y/
	ORY82cKhxhNwk4Di3pl9p5tMWWZ+zB4jPIEVXVQayQl73AdtSUdbd/CdMbG1l0KzMGpb3NgCpAA
	5vkQJL1zzm2JoLfngo83XhlUOY8HfmK3AYQGppEAQcjrXmW+dFmP8HFmJhKYATJW7iwkTrAB94N
	fzTChbzEjGsrJtVCeQ7kACFKv/huE3AOtzpIns+ZZjJ7GC/D
X-Google-Smtp-Source: AGHT+IH/PPNHWI3Tkoic6SIzL9t9xmsPWm8yqRwHJi3qr69nfc8BYcHtYID8+EHSgcZKFKBPDIMC1g==
X-Received: by 2002:a05:651c:198b:b0:302:3356:3a98 with SMTP id 38308e7fff4ca-3079690e18emr52232371fa.37.1738407156161;
        Sat, 01 Feb 2025 02:52:36 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307a3088d3asm8427871fa.39.2025.02.01.02.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 02:52:35 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30613802a04so27097161fa.2;
        Sat, 01 Feb 2025 02:52:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4jLhvb+e25Uu3T7+X9xkoOK+MXVC0ddlBGClnSJrw2h/LkRe68MCUH5GL5BhBn29qZ/yhYWbGKl0z@vger.kernel.org, AJvYcCUNGEMQK4TddHMYhqp8l2ez0jjuGT8kt2cbqA3RVVwz3kb9oTv8SpFJhbF+4U24841aPSlExK4KQnM=@vger.kernel.org
X-Received: by 2002:a05:651c:502:b0:304:4e03:f9d9 with SMTP id
 38308e7fff4ca-307968e0a20mr54218521fa.28.1738407155636; Sat, 01 Feb 2025
 02:52:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131231455.153447-1-macroalpha82@gmail.com> <20250131231455.153447-4-macroalpha82@gmail.com>
In-Reply-To: <20250131231455.153447-4-macroalpha82@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 1 Feb 2025 18:52:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v65p+_woYGKRrQs2aKRJO1LdYW4eA0h2kiyMTUhgZ9DNrA@mail.gmail.com>
X-Gm-Features: AWEUYZmavIApcVldzJqk3l2AkjKAa_El4sfI4mNDa0tSr-IA5hYLt6odr6wR63o
Message-ID: <CAGb2v65p+_woYGKRrQs2aKRJO1LdYW4eA0h2kiyMTUhgZ9DNrA@mail.gmail.com>
Subject: Re: [PATCH 3/5] mfd: axp20x: AXP717: Add AXP717_TS_PIN_CFG to
 writeable regs
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
> Add AXP717_TS_PIN_CFG (register 0x50) to the table of writeable
> registers so that the temperature sensor can be configured by the
> battery driver.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/mfd/axp20x.c       | 2 +-
>  include/linux/mfd/axp20x.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index cff56deba24f..baf51dea98b0 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -222,7 +222,7 @@ static const struct regmap_range axp717_writeable_ran=
ges[] =3D {
>         regmap_reg_range(AXP717_PMU_FAULT, AXP717_MODULE_EN_CONTROL_1),
>         regmap_reg_range(AXP717_MIN_SYS_V_CONTROL, AXP717_BOOST_CONTROL),
>         regmap_reg_range(AXP717_VSYS_V_POWEROFF, AXP717_VSYS_V_POWEROFF),
> -       regmap_reg_range(AXP717_IRQ0_EN, AXP717_IRQ4_EN),
> +       regmap_reg_range(AXP717_IRQ0_EN, AXP717_TS_PIN_CFG),

Please add a separate entry. As you can see immediately below,
there is a separate entry for the IRQ status registers. We're
not allowing writes to unknown registers.

ChenYu

>         regmap_reg_range(AXP717_IRQ0_STATE, AXP717_IRQ4_STATE),
>         regmap_reg_range(AXP717_ICC_CHG_SET, AXP717_CV_CHG_SET),
>         regmap_reg_range(AXP717_DCDC_OUTPUT_CONTROL, AXP717_CPUSLDO_CONTR=
OL),
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index c3df0e615fbf..3c5aecf1d4b5 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -137,6 +137,7 @@ enum axp20x_variants {
>  #define AXP717_IRQ2_STATE              0x4a
>  #define AXP717_IRQ3_STATE              0x4b
>  #define AXP717_IRQ4_STATE              0x4c
> +#define AXP717_TS_PIN_CFG              0x50
>  #define AXP717_ICC_CHG_SET             0x62
>  #define AXP717_ITERM_CHG_SET           0x63
>  #define AXP717_CV_CHG_SET              0x64
> --
> 2.43.0
>
>


Return-Path: <linux-pm+bounces-20105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1DDA062AA
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 17:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5015C16529A
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAA01FF608;
	Wed,  8 Jan 2025 16:53:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAF219AD90;
	Wed,  8 Jan 2025 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355188; cv=none; b=Aqt8RFWvULXaR5AwsDbX8FeJ7wHJJP+uePhCucnCA172UgF46AUGP+TGJkhMYizPYFaRPJnn2k4p6tkPcrb1GgF5a7bhBCB3sxo+Vn1446Ljl6xUFb4D4Gi6AKv4trHPM6QYxLnnHLpDN3QqDUnj7SrTu9IoINS8EBI+/zWa5RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355188; c=relaxed/simple;
	bh=xrHb5M/ZA4Z98nlMieaSv4x7qELzO4tPhnQnYmeSNVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aV74cirA3X9mAJElhVY1MPMigMTcLljuTmV4/S6/gYi4LIS4iUdBkewHfAS+yVhob7//tkPx4n8pqSUkWjhK8GvsWAxMsjR+INTFr/c4XaFhFvKbs2DXku83mcykZ7g1XH+UjdRnVTAqdzOg14wTOun2ZepLijBsqS3u33L3600=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso223009251fa.0;
        Wed, 08 Jan 2025 08:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736355182; x=1736959982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jx0eMDBUFN8OZ3Iife5XjSsJKU6lJXng+Kzs65bz5do=;
        b=o/OGLUcZw5/9noznhA2Ic9OUC3GTEaJa6+lDwMayyTOeSCWSDjbuA2tkVaKsshfNH6
         keRRYKQk87dhxs692jc+DD7VMvuINyraZZJ2q2aaejs5k6U4tBv2O6U7LJiVB3cPtA+G
         iFqRf6dpYJIDfbRcGbtCe1S3xImkYilaOsX2ntj+KjzTAkgqPXer5XPiobDE4+5LBPam
         7QgwU9DdD13v97ibe3dXo6lOIGgzzqXN1dU4QxzOo/lgrtsHHoJqeW/QP9tQW42ODt1T
         GNtR0o8sNRT53tiEGVIdDk9bfN1jrUZyZQzKVXjXq2xkb/UlGrZP6WVIfWEplDhe6efl
         c/QA==
X-Forwarded-Encrypted: i=1; AJvYcCV9rmqyriOHeHdijDppfCzJ9hJBBWcSKjbkk8sJ7oCqFBOuO3o/JuyKCbZUBpdJSyBn95HmYWcbsTPaqQ8=@vger.kernel.org, AJvYcCXG2kNPlJPeZAH5TZTBSYBtOH92BnIsqVkRe2x5nmXtOgCu/Nv6OBQ5kzxOnjI4lYPEBjwjqejf+iA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsarr80Lm2DVNWLvrtJLZgK80xeUAGH+TAjaVy/S7h113Zhyrj
	NT/O2hKjgb8iEI+pBIhSYbQo65M3HyAdrc2TTTbgJFWCo5pb72vTLM0bOVNw
X-Gm-Gg: ASbGncuGO03FwyiEnXSeB4d8rBkaaKaREq8EG7/CSN7Kb6JZXQVU/yk68bpUpL1MHeJ
	S4y9Rvyks7HxX1/edVkCdvK8xKEKZse4u/nt3kszh+c3bW4u25K7TuW1dWNWY4n8jPc4ny74aYF
	tGfrK6UhvWsZ3rb+uP6hJ9EKe8b7bL6pUDEXI7m75ugb8xOCq0TUXbNESj+jB2YiZu4YXFgvIau
	KUJUFLNNYRpqhCIrKXHj6UqoFhKT0fLMD+0p38mg6+UX3/WTMYVOGqz4UWHDRocM48OOUC8mY/F
	vs58z7aw6uSQaA==
X-Google-Smtp-Source: AGHT+IFLFwabH84cvJGTa2NVfaLgERbLr714wpTb9qW7QgJQvvjgWliEKR0yp8r25IM53e9XONsVyA==
X-Received: by 2002:a2e:a692:0:b0:300:17a3:7ae7 with SMTP id 38308e7fff4ca-305f45f005emr6774341fa.36.1736355181465;
        Wed, 08 Jan 2025 08:53:01 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045b082e31sm60727181fa.110.2025.01.08.08.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 08:53:01 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-305d843d925so33631161fa.2;
        Wed, 08 Jan 2025 08:53:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQQUDBd3ESHZypdbKRw+aIhSUVXxgtc+8QeJLq6f/bzqAuwptGVn1NpCNmk9IfAblfd9wDwuclRM0=@vger.kernel.org, AJvYcCXbdPYU5xd0MWNql9LGbyqndAGyWNnt9Hwhx8Z15yj1K3w1dgitCsCph88G6c70IxbzCQBtl02D0sqe+aI=@vger.kernel.org
X-Received: by 2002:a05:651c:602:b0:300:3307:389d with SMTP id
 38308e7fff4ca-305f458e846mr7855991fa.19.1736355180052; Wed, 08 Jan 2025
 08:53:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108164359.2609078-1-andre.przywara@arm.com>
In-Reply-To: <20250108164359.2609078-1-andre.przywara@arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 9 Jan 2025 00:52:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v66jTH+aiCHQyic0hYUWQ3wiZFa3a6f9U1NickAfZPizYA@mail.gmail.com>
X-Gm-Features: AbW1kvYf6FaWmHcSx5PlJ4_54WBtFGt_VFk4l8WJnSU8vd7BgjPLUbQr4KhZAEw
Message-ID: <CAGb2v66jTH+aiCHQyic0hYUWQ3wiZFa3a6f9U1NickAfZPizYA@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "mfd: axp20x: Allow multiple regulators"
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lee Jones <lee@kernel.org>, linux-sunxi@lists.linux.dev, 
	Chris Morgan <macroalpha82@gmail.com>, Vasily Khoruzhick <anarsoul@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andrey Skvortsov <andrej.skvortzov@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 12:44=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> As Chris and Vasily reported, the attempt to support multiple AXP PMICs
> in one system [1] breaks some of the battery and charging functionality
> on devices with AXP PMICs. The reason is that the drivers now fail to get
> the correct IIO channel for the ADC component, as the current code seems
> to rely on the zero-based enumeration of the regulator devices.
> A fix is possible, but not trivial, as it requires some rework in the AXP
> MFD driver, which cannot be fully reviewed or tested in time for the
> 6.13 release.
>
> So revert this patch for now, to avoid regressions on battery powered
> devices. This patch was really only necessary for devices with two
> PMICs, support for which is not mainline yet anyway, so we don't lose
> any functionality.
>
> This reverts commit e37ec32188701efa01455b9be42a392adab06ce4.
>
> [1] https://lore.kernel.org/linux-sunxi/20241007001408.27249-4-andre.przy=
wara@arm.com/
>
> Reported-by: Chris Morgan <macroalpha82@gmail.com>
> Closes: https://lore.kernel.org/linux-sunxi/675489c1.050a0220.8d73f.6e90@=
mx.google.com/
> Reported-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Closes: https://lore.kernel.org/linux-sunxi/CA+E=3DqVf8_9gn0y=3DmcdKXvj2P=
FoHT2eF+JN=3DCmtTNdRGaSnpgKg@mail.gmail.com/
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

> ---
> Hi,
>
> just replacing the old -1 with the respective macro name, as Lee asked
> for. Also adding tags to acknowledge the reporters.
> Lee, feel free to change the subject line if you think the "Revert" in
> there is not justified anymore.
>
> Cheers,
> Andre
>
> Changes v1 .. v2:
> - use proper name for the formely used -1 value
> - add Reported-by: tags
>
>  drivers/mfd/axp20x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 251465a656d09..bce85a58944ac 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -1445,7 +1445,7 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
>                 }
>         }
>
> -       ret =3D mfd_add_devices(axp20x->dev, PLATFORM_DEVID_AUTO, axp20x-=
>cells,
> +       ret =3D mfd_add_devices(axp20x->dev, PLATFORM_DEVID_NONE, axp20x-=
>cells,
>                               axp20x->nr_cells, NULL, 0, NULL);
>
>         if (ret) {
> --
> 2.25.1
>


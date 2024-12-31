Return-Path: <linux-pm+bounces-19873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6089FF18E
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 20:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605AC3A3112
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 19:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BCA19D89B;
	Tue, 31 Dec 2024 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6/vaJVK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC05188591;
	Tue, 31 Dec 2024 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735673510; cv=none; b=ngbstWpicbmEPlsUEmEHCnHurxVt3AGc++1jwetQGGedlMAvsx1NeLT2Gm9iBjwUUQc2w69s0tiw27o+j9Z4AU1t9LbUVvmUX7sSJ4KB00FVKH3pPEyN4eQJiCuzQa5j1lGdu6qzqKqs40MPDDBVQ/UcL4APjEpAVE8T1PhA71c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735673510; c=relaxed/simple;
	bh=1IBP/CbWOe8XNYy1yhGQC0nEhfBHuxql2uqOe/kJnSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uzuTGJf0TxPkmz5P/zdRPoEHmfUU3ZcsyvNOzF/KVoVNV/N11Rv0kpxtLon4lMqexJlyI6OXgbqrNkkjDzadjBxyfRtsZ0P0ipYj6lPHOj0alE5gCan7OYGE9kqPFf5F1jNyNFNmvp+S9cBLVkCk4+6SqRVmPa3Uxm2j2DKgtTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6/vaJVK; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5f2e13cb356so4380390eaf.2;
        Tue, 31 Dec 2024 11:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735673508; x=1736278308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivUPqyCU6yjFi/yyaL60jmScG9p289+S/O0luR0dfiU=;
        b=T6/vaJVKwHqusU7dp7MN/srZvp510kxl2C78pDzHAqlMARlOQIf/gtSe6vDyXKmaUV
         Z8ZuWEbajNWZi1j3tq5VT3n7miBVASaz12DkooIl87DG6SBoasZ/FJ7L4Fqv45dkAO0U
         amP6Ot8xeWa5mzKPsNKcgI/01uEvRjZH0QTrfRqY6ZISoN1U0sY90BzTiOpFF9OA2ATH
         OTWWzpx9gNygqOd5Rli9IP5jfKs0I9XpNWfTbM5inn/QRr17CE19NS558d7FW5K63h2g
         IZKYbAgFYoyONGhd9UyKUahQIDRs78/rCYsx0uNuPMG+HwQgSFODKu0nfW7X/ka8UU95
         JfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735673508; x=1736278308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivUPqyCU6yjFi/yyaL60jmScG9p289+S/O0luR0dfiU=;
        b=crszh6+/xHu5R//ao2k2xX1ypQ2fIfLxf7MyulZcucMCYGxd2vuk13TrKZAIWq4kFE
         eIYT19mpKYz9lbCxbRm/hJJtw4l7HdLUZCZPHR1VjScLDOVsWpcHfgKwQeZcjBcZcthh
         VEb4yEnJgnOFSKiHe9rwIgzBg2vy/NTTFjcA2xjXMAOonyF2ie4ngNSg55ua++jkwMAl
         9mTuNNBhGLEVGwHOMz4BHz+uKG/JxLoHSPFtX8elKoKQhz/Ilz6f7zlPtTHMuY091tvr
         m0OpOJkWMCwa1GczFwpQ9E70GBPamiCiBhE0fiWINRtctzqbK2KBQYoihxcaJbUry+/b
         DDMw==
X-Forwarded-Encrypted: i=1; AJvYcCUxxCFNuBta4fZ37yE1zO0c6iX9YfjgEAPi2AcxgUev9eKx5SnMUJGTT+BL+mHzUhO8DU9jPMfqmRA=@vger.kernel.org, AJvYcCWJX1y8BqyA/+jaT4yleuqTxAzG3/WuZvkmPjyF1YGk6TR88malYoCfuJWiHV5ZDwn+FlwsztFJLIRHzjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOQno1fRCZuJNbBG708pGod7qiqUKl0beDsEdczzs0vr3gzGfY
	UH1HlUhFp9o3exkFym3N2LeFylWiM9NDS4WYSOZkcwS9YjJKWp7zBSO1N76L1PlFQL0h6ZDuzhw
	ZvdWTqI5qdvfVbaEdjle25mY52SM=
X-Gm-Gg: ASbGncvcQMCKwiWHCfloQiwUiXBzzWwx/yE8XWw/WxZy+AshwyZBUmMyCsXVf9EMW+r
	Ntil6a6qUNiiAT/u7dNvLH+bUakRHnjI1gsneUYkgyZDq4w8pjz9D
X-Google-Smtp-Source: AGHT+IFiaHDkPu6NWg+9kL19uqrO69oJjfD/9cD76ZjPsLNZz5UXh21bTOnwF6Jt2Y9g2MV/ab8KjAxo8UaDb2It1xM=
X-Received: by 2002:a05:6871:7c03:b0:296:b638:1b1a with SMTP id
 586e51a60fabf-2a7fb3fed8bmr20848926fac.42.1735673507851; Tue, 31 Dec 2024
 11:31:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241231165103.800752-1-andre.przywara@arm.com>
In-Reply-To: <20241231165103.800752-1-andre.przywara@arm.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Tue, 31 Dec 2024 11:31:21 -0800
Message-ID: <CA+E=qVc+v_io04u2zvF7cjqkYhZKt=KB4+VRtQqOK4BJ2PJx_w@mail.gmail.com>
Subject: Re: [PATCH] Revert "mfd: axp20x: Allow multiple regulators"
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev, 
	Chris Morgan <macroalpha82@gmail.com>, Jonathan Cameron <jic23@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 8:51=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
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

Doesn't it need a Fixes tag?

Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>

> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/mfd/axp20x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 251465a656d09..5b8e88341a305 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -1445,7 +1445,7 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
>                 }
>         }
>
> -       ret =3D mfd_add_devices(axp20x->dev, PLATFORM_DEVID_AUTO, axp20x-=
>cells,
> +       ret =3D mfd_add_devices(axp20x->dev, -1, axp20x->cells,
>                               axp20x->nr_cells, NULL, 0, NULL);
>
>         if (ret) {
> --
> 2.25.1
>


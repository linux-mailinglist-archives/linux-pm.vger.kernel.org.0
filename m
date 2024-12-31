Return-Path: <linux-pm+bounces-19872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6052D9FF113
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 18:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6525218829AD
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 17:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D361ADFE4;
	Tue, 31 Dec 2024 17:44:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7156E1ACEB8;
	Tue, 31 Dec 2024 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735667079; cv=none; b=ZDn7/+U++5DwhoS6R0tSQV09nYIQbP06bXuXP3LhUf/EZRySENs4GYzAUKc6MiDZswNvttMe68hTKEjS89W5aV75A8GutP8Yq4fq5fkk1YT5RGbsnyvAlxl+EKJBk6ca22t0wURB5clv4VYIQ4x0/KFCOsAXXY7EQ67i9zphAb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735667079; c=relaxed/simple;
	bh=m/cyulKYXjgyG+TRTLjmVT7aw8fJhM9C4kpDOC7tjYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HS71y0ooWGHvmZx3fJaeMMUrjV9Y6EaA+wTrlJSFOFqTL5fR2osdXNfiVIKsYXRWWa58pYW9Iw1x2gkq1bkDUHuorvbXdVI2ei7b3e4ZtAhf8vTljLcgDQBaIf5oR8BGPCbBJap43M4j0Ncc6PQyk64lSufMyxapVVNjmG+dZMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3023c51146cso105783491fa.1;
        Tue, 31 Dec 2024 09:44:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735667074; x=1736271874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JGqGCFlIfyNjV9vijKIVvvUaUnOHqLjovjeWAK57WWU=;
        b=PA+CjQaQQCj/na8brJQ6dEdxthMqqaqLo4gisMePV2YyzrHqVaA97m18i71sxGDTRL
         lAdAF7OEydlKB5Qx0i8Q767kFP4U/+psRhGjhED9ffhz2p5kda4djc/u7kcdDT7vTR6i
         vbo9pfiN7KQPez0gZp0bb7blGtFITlLSZnmUbroZqvj0xljSWsylvcDOYFv4ud/MGO9e
         ykA29+fr1T74BCseMlQetG/snxJo5YFC8KdhQrfkjwvjH+TrZmagYMDUqkqD5SBEuBhU
         IZTeQvbSXkCCvkw/4yL33q9wrxuUUSqoFdX+pJIeptbdjbRTsfpkwYoaxnVLlkt/hsIB
         0sKA==
X-Forwarded-Encrypted: i=1; AJvYcCWs/q65KFksJuGU1z8iRG5Furt7+c/QkCr4fusaVvlPBzMrNdl7Q5EBY7/xcE+E5RyJsY5nx4FE564=@vger.kernel.org, AJvYcCXawnSO0EzK+yHk+vSFxwdpJy5KbQYNY5bR1kj7mZfyIoSRIloTcXJO4oICzjUgPX2hEieHH28Aobmu+QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm6ZxrfT907fomJOpHfGTpzhM+f0gWJ9vTBUWTAC/vyX657UJ3
	GIALg21pCx5PeZiX9yrnGuy4qJ9VJ36VbX6KwwlZbBQo41D1u55e1/HO+IWF
X-Gm-Gg: ASbGncs9SwnuhgaY4yL2I0/5zguSClXxRqNLOfRYTFSBwgfmgtgyjeYA5a3VFmJI9nw
	Ai3m/j0CUH1uIr5U9kOVkR6AtFmhuo+xFATRVfvAFs74gYKivk3zYXKWJIaxKBse1baUp6FreqG
	/yPXxu/VOnTjO2eJY7LV9jek2ZiOb3YfHxUG6vqX/LtCoLscLoEmAtOL5zuDzafuiPHl6lARRLH
	k30U5bZA2QrpTjjtcC+jw7qh2GiELHFc511dCz3f2utuhV9ebDw4Qj3OTUCu83R2WZspofpfYEU
	Mbc1ZmFpI8oF4g==
X-Google-Smtp-Source: AGHT+IHpjVr3pIEKSrBmVGhiJCdzVELYjBxJQyboYdDZGthIq5SakPQP7sYLwq1x7ap8j55PPplPbw==
X-Received: by 2002:a05:651c:551:b0:302:23a7:1ee8 with SMTP id 38308e7fff4ca-3045833755bmr150012961fa.3.1735667073969;
        Tue, 31 Dec 2024 09:44:33 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad9bdb4sm38935351fa.47.2024.12.31.09.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Dec 2024 09:44:33 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30219437e63so119628691fa.1;
        Tue, 31 Dec 2024 09:44:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/u4iuryffIwk4wIx1mBXOkEAX5ZIrVNxx/wAmC1oHLM1R1RqUbhfWVD3ZefF5ke2T3ML110ZdiJw=@vger.kernel.org, AJvYcCXOTliRtFH+XfKljs/c5jiP8qtP9ue2OtrgHNQAO/OTdgDmgCyeEKBB48iDPVWAM4ODcrC7Y5HbhoNONlI=@vger.kernel.org
X-Received: by 2002:a05:651c:a0a:b0:302:2202:14f0 with SMTP id
 38308e7fff4ca-3045837109emr118075391fa.11.1735667072958; Tue, 31 Dec 2024
 09:44:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241231165103.800752-1-andre.przywara@arm.com>
In-Reply-To: <20241231165103.800752-1-andre.przywara@arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 1 Jan 2025 01:44:19 +0800
X-Gmail-Original-Message-ID: <CAGb2v67zRWx7U6wABkyPKG49c071KoMJDgfCS-NA7wj00-ReyQ@mail.gmail.com>
Message-ID: <CAGb2v67zRWx7U6wABkyPKG49c071KoMJDgfCS-NA7wj00-ReyQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "mfd: axp20x: Allow multiple regulators"
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lee Jones <lee@kernel.org>, linux-sunxi@lists.linux.dev, 
	Chris Morgan <macroalpha82@gmail.com>, Vasily Khoruzhick <anarsoul@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 1, 2025 at 12:51=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
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
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

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


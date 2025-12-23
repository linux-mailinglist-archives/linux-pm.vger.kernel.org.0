Return-Path: <linux-pm+bounces-39834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F4FCD8E61
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 11:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 731A430657B3
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 10:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5083234CFDB;
	Tue, 23 Dec 2025 10:40:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com [209.85.217.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D12321770B
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766486456; cv=none; b=kmMZ20Z7CA+Lepk12uEcd3iZqCjKoGGmGuO4kt0kmwpu6ZjFx6QHmcPWJHj6O4yBFzBTUeD/vldFRb3p7JlEVDCGIKRxId6yCrvWXE+o1NnIiwKfxLikSbhLsvCR4lcofTNof3QNUpn41rAM5o8SV0+/V/JcbgmRe+ng/A9cWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766486456; c=relaxed/simple;
	bh=He4BjfuJKlOVZCSqBFYthIZfM2I1ZkSLAml5bdxckng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELvyPK1IIkRnR8q3WnPIdxv6icpV24FSiW/4XcFA9bRfRHy8LiVQsFARCKJzgoH0Sm9JvGwto8y3c/yv+5PXR1IrxnadFCDA+IfOZlGZPRSuHwjN9dTM0IZ+UCsHWdsntAsGMdt33S809HS9YRmdFUzMKP1CLw0kUSpM+MVDoTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f66.google.com with SMTP id ada2fe7eead31-5dbd1421182so3911691137.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 02:40:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766486451; x=1767091251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ju2WEPZhFSwJDfyX+hF0G6cQfKmw2zuzSQc8O9oxIig=;
        b=HfnpDte66zD0gTO35RfjaDd5aeouc16wLr3l2qFB3r9I8lP2AyuTZMXcfmNHh0QnEO
         X3qyYxub3msbg+dqGeCc1tmwNjoWqg5pBpmlfhDsbzjotvX+5VjZQUdWmv/5X7ejMrT8
         Fk0h5ur6epN4kmcTXq0zYdTGY1LN60fuZRlZxETzYsRD5C9LZmG8MnQ6rZOgjfGUbOv6
         XCfZXPrdfX5oZDpqmjwnKMmGleEktkbYFRyFswLSze2Q21L9x0fRNCdFFDewhsyCX0Lp
         TAhDeSQZRLSNet4HWytiQYilQTLZr2R1U7o3e6G35OX4ZJP2mNb6EX9u6TIpwpT4Iuk0
         7qdg==
X-Forwarded-Encrypted: i=1; AJvYcCUjOlL8nZ/ndFimPMn1ZsAnk9NHv0kPJVwmQcygCCm9L6zGY66+zXfSXY2plH/tqXu+/ijkhwcC4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYCkDuDslrDPb8h3ljG3oE3yz17w7DtxkoDQcP8+EvqzQqqe7b
	yRNgN4nN8OL1pAFBuxTzn0S35ew+AzRs14aG7AHKnKvn4DiydW2+Lpn8fxAVHl78hto=
X-Gm-Gg: AY/fxX6FG0GaGBgjQQ8u3c3r66gmtItK6Ye7Pe0KF+USVCQ1XCQFU6lGdNikooPBHZY
	Bq8Iv0ffVzVBk4TRlDKfR6cgTjUCJ/9H/kAhVePUFOBJqjGkO+CBrxq4xy8EMgoKw+ETnQli240
	ge0BiULzzDF/HDyz0mr+zcEJHjMCp/t03C58g/RgzvHDARUqlP47wZxmCYJXQC9sIN+3vkl/8qM
	nDBnxTJVJGcZkKvK1SYWZKviL8GnRGksKwr9q1cd3LqvtG+8jVZstVIawx+iu6rrZiCSs9Q7ujg
	f7PxGJ4uWEQZnLbdsE8FrcLExVtGB6KfYAkYaUx29vUbwf6dOgZbvFp+JokF1d8N1J1ZQxEI9Tc
	6Ecv7PChRUJsFLxLfjMglIr87FaSXzFxHdUn/RT+6GZivKoMepX/mzN1Im7vYfk1HeryCRibIIo
	6sjboE1KZQ5LluUm2ZDtOwigXvg9i18xnX9/SNRY/f4voekUSj
X-Google-Smtp-Source: AGHT+IFpH63ajJOje4j+O5POqzZtaeWEKrGB7Uc+gFnjcXV9M0UDapD/Z/ORVZ6oHfDnz3Rk2UQ4Ug==
X-Received: by 2002:a05:6102:9d9:b0:5df:b7f3:5875 with SMTP id ada2fe7eead31-5eb1a6259a2mr4619804137.3.1766486451513;
        Tue, 23 Dec 2025 02:40:51 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5eb1aa4f338sm4336911137.1.2025.12.23.02.40.49
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 02:40:50 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5eb3c50c688so1872785137.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 02:40:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXFxPr1DL2T/hrH+HMiMmGayeHcHYN2RO2IW6p6DXuTAVh8yCv07fp5fLbKiKiLoC13xrD6AkJ9Bw==@vger.kernel.org
X-Received: by 2002:a05:6102:688c:b0:5df:c10a:6683 with SMTP id
 ada2fe7eead31-5eb1a817ff8mr4650551137.35.1766486449690; Tue, 23 Dec 2025
 02:40:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209091115.8541-1-ovidiu.panait.rb@renesas.com> <20251209091115.8541-2-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251209091115.8541-2-ovidiu.panait.rb@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Dec 2025 11:40:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX1QQWf4mTDRPgOdRGLttUMPewbRaq1GrksBK6xA-mi+Q@mail.gmail.com>
X-Gm-Features: AQt7F2rxebZz2lpc976a4wNX_gG9-mxMoPf2hgGvnyD8PTUzp05nnW-kYeuYB18
Message-ID: <CAMuHMdX1QQWf4mTDRPgOdRGLttUMPewbRaq1GrksBK6xA-mi+Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2N TSU
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: john.madieu.xa@bp.renesas.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Dec 2025 at 10:11, Ovidiu Panait <ovidiu.panait.rb@renesas.com> wrote:
> The Renesas RZ/V2N SoC includes a Thermal Sensor Unit (TSU) block designed
> to measure the junction temperature. The device provides real-time
> temperature measurements for thermal management, utilizing two dedicated
> channels for temperature sensing.
>
> The Renesas RZ/V2N SoC is using the same TSU IP found on the RZ/G3E SoC,
> the only difference being that it has two channels instead of one.
>
> Add new compatible string "renesas,r9a09g056-tsu" for RZ/V2N and use
> "renesas,r9a09g047-tsu" as a fallback compatible to indicate hardware
> compatibility with the RZ/G3E implementation.
>
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


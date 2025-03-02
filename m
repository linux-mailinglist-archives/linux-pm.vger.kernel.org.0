Return-Path: <linux-pm+bounces-23248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B9DA4B553
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 23:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0BF216956D
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 22:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9693E1EEA5F;
	Sun,  2 Mar 2025 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXXYIkrk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4641C5D5E;
	Sun,  2 Mar 2025 22:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740955455; cv=none; b=SRJrN0I+yiFlqgikHR0GX8g3Ydah0K7jHuKQqjeiUfurwACi5cuGmHdnByO4hMBbCMZMi7eZwEAipNRWI5a/e4e/G/qAGx+9MdWHXjfTUcQ/GVT3l9HqrUzX71WWX7J4irx1O+D+FD4u/0ReXjmD0CD1Iy5Njcr5jLucqJ3OWfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740955455; c=relaxed/simple;
	bh=ni4JewE3sYVZYisMRjfTJPtBp8jUfifzDt0C7xVMFik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIPbTdqrPaUb4uk/P9a0nD2HmH4euYsD969EMewdKPlcsrlmeRbVU9l6vvg2U5mDF612fSlj9sn1Qv5MXQEYnDZhjBpq+Vzfp9vT9/WP6M6vMRV2nLWvTdNGwaaEmqcL/yoIMGrnbcHkQ1GvNpW2pGQnhE9eB5cO8rkyw4UThrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXXYIkrk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-390eebcc371so1190730f8f.0;
        Sun, 02 Mar 2025 14:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740955452; x=1741560252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B3nSz0Tm/9ALfIco44Ttp6VO9zHRPvQciCEJvIO+PRY=;
        b=KXXYIkrkk6uHcpnCFFehYPmbjCOlVoNv9zp4hwdfjKJiufnbKTKKkNd89EioxXdu1V
         WOt5NyljJiaxeKo3L0wQ6UBV25fMPQEmPeq5MrFZ86VLDerM84TA1A/fIc7bI8wxcsP7
         zuzubaypgFWZafyjA19UsZe1aQ1+GQnEhDhVVyHCitc3jmxTPKtDROhSGpmXxM8sn0HT
         mznz7lrIdFzIWMHaCSDeeOWeqSo4xZZsNpbu9N6MInFcy7Xoa2hbYGXT0OhQ+tEi8Kbp
         71fskTaQZf6tGfZ2+Y0LYttgywqI3z6Z+XxhFIjnbrJ3jcSMsVk/Zr+jKQx4QZW0soUo
         6cqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740955452; x=1741560252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3nSz0Tm/9ALfIco44Ttp6VO9zHRPvQciCEJvIO+PRY=;
        b=JMMzn2vQWmfohMd2Q/2tf7hXksQ/AspwiUesis9Ww0SaZfwm6u/jZ3/JSDoMbdiaaq
         6dE3xSpmyvTy1x979K+l3IAQKigphvqlCzoEHbacXDeCqHh0zHWHKhFJozbwM8q9yJtS
         ROjSvw9j9NTZRPmtH34NdJctnadWUbPjuScOHl9tzWgy72tqg1g5WJXhMIlEbUjxvCOy
         aha8FuMmcNXQEI/YewZlr+VpbbCtqRiXRaUb60Ogw0vqkTdJ/RszrM0wUp3+a5Yn99Cv
         HZfRi8vChqlhgVJXWiE6dAVD2fCNNlu4n4gzrbtqjK5ei89J9OBmnPK9eYXnAZ6XYp9s
         sN5w==
X-Forwarded-Encrypted: i=1; AJvYcCVquMdbZYXTL5uTovvSeevl+aIr3kgy7SiIY6OyHgzsEFKyd5x6GwdkfuwLxBzwuh5rkw9NshEllOA=@vger.kernel.org, AJvYcCW6UiBJk4cGoUlElY6K4mCm6IKtwAY5WQYBNmSQkG+wQ+kMGMtZxosQoPcQSBqonJMG9DN6AoRQWVOU@vger.kernel.org
X-Gm-Message-State: AOJu0YzCURiPi/moDKaNcFB5Gxgd5q4ai80D8sy8VUJolLyb8/ibe6NZ
	+yvAaI55j3oiGPq3cvWAfhqmFgb+euMtjdcN0MnoZgeLISnuxxal
X-Gm-Gg: ASbGncuBA73W6E4QBmeaLgSdootgz/KeVZkEXdbZJMzx+fqe8HXRarAQZtOd3SdKFro
	5X+/qmDK3pqpXORmN02lKvttqgNsrdFKWSt5bQnW737ZyFTM4iHCmmLzyBWfum3wGQbb9lo0IZM
	OlUrz/RvkM0LTHHEiuUJ63fpzW7VxhPeWsc7miVc4qV4MBh3gPcurWxRYNL+fOfrh6SbCEwbTq1
	IEtwiApdtE/jFaGUNgJ9driE99qRz4D8VCq23tIxshdwoNrsHjGkHrJoaosR9mZ2Zt5Bb+0sAlW
	EZHKwdxHcUmG+UIr1zGVWlqM0QxasbaIBA3p6f+f+gVvWu4yHzhRjFsqN3+BWN1QhD91J7ErDOP
	zLsYOFRL9YjpZCIVEX60=
X-Google-Smtp-Source: AGHT+IFSwDgCyqBHbrq2Yl2rg5agQteOsniIG4r4DpFhXYFaxZR5xy7+52k8VXpQGVa6zUoKmIRgVw==
X-Received: by 2002:a05:6000:1789:b0:391:ba6:c066 with SMTP id ffacd0b85a97d-3910ba6c216mr967773f8f.35.1740955451848;
        Sun, 02 Mar 2025 14:44:11 -0800 (PST)
Received: from [10.13.13.3] (146.10-240-81.adsl-dyn.isp.belgacom.be. [81.240.10.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844ac6sm12407954f8f.71.2025.03.02.14.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 14:44:11 -0800 (PST)
Message-ID: <01775d74-d72e-4a93-8a02-c13f7365d385@gmail.com>
Date: Sun, 2 Mar 2025 23:44:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] arm64: sunxi: h616: Enable Mali GPU
To: Andre Przywara <andre.przywara@arm.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org
References: <20250221005802.11001-1-andre.przywara@arm.com>
Content-Language: en-US
From: Philippe Simons <simons.philippe@gmail.com>
In-Reply-To: <20250221005802.11001-1-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Tested this on a RG35XX-H (H700),

launching glmark2-es2-drm completely hangs the board.

No kernel oops or error messages.

Philippe

On 21/02/2025 01:57, Andre Przywara wrote:
> The Allwinner H616/H618/H313/H700 SoCs contain a Mali G32 MP2 GPU. This
> IP is from the Bifrost family and is already supported by the panfrost
> driver, so enabling support for 3D graphics on this SoC is rather
> straight-forward.
> However Allwinner added some bits in the PRCM block, that control the
> power domain for the GPU - on top of its power *supply*.
>
> This series enables the Mali GPU on those SoCs, by first introducing a
> power domain driver for that SoC (patch 1/5: DT binding, patch 2/5:
> the actual driver). For the Mali GPU to work we literally need to flip a
> single bit (the BSP does this in the bootloader), and this full featured
> power domain driver is admittedly a bit over the top for that purpose.
> However it seems to be the right thing to do architecturally, and while
> at it I added the other power domains (for analogue, PLLs, and the
> management core), even though we won't use them in Linux and they would
> be always on. I have a simpler version of the driver which just covers
> this single bit controlling the GPU, please let me know if you prefer
> that.
> Please also note that this supersedes an RFC patch I sent a year ago,
> which included this power domain in the R-CCU driver:
> https://lore.kernel.org/linux-sunxi/20240225160616.15001-1-andre.przywara@arm.com/T/#u
>
> The rest of the patches enable the Mali GPU on the DT side: patch 3/5
> adds the compatible string to the Mali DT binding, while patch 4/5 adds
> the purely SoC specific DT nodes, for both the power domain and the Mali
> GPU. The final patch 5/5 then enables the GPU on all existing H616-family
> boards.
>
> There seems to be an existing problem with powering up the GPU, after it
> has been turned off by the kernel. Chances are this is a problem with the
> proper power-up (or power-down) sequence, where clock gates, reset lines
> and the power domain must be asserted in a specific order.
> A workaround used so far downstream is to keep the power domain enabled,
> by ignoring the power-off request. Observing any assumed "proper" sequence
> is a bit more tricky, since there is no Allwinner specific glue driver
> or anything, so things would need be changed in the generic panfrost
> code, where they have the potential of breaking other Mali users.
> I would be interested in hearing opinions about this.
>
> Cheers,
> Andre
>
> Andre Przywara (5):
>    dt-bindings: power: Add Allwinner H6/H616 PRCM PPU
>    pmdomain: sunxi: add H6 PRCM PPU driver
>    dt-bindings: gpu: mali-bifrost: Add Allwinner H616 compatible
>    arm64: dts: allwinner: h616: Add Mali GPU node
>    arm64: dts: allwinner: h616: enable Mali GPU for all boards
>
>   .../bindings/gpu/arm,mali-bifrost.yaml        |   1 +
>   .../power/allwinner,sun50i-h6-prcm-ppu.yaml   |  42 ++++
>   .../dts/allwinner/sun50i-h313-tanix-tx1.dts   |   5 +
>   .../sun50i-h616-bigtreetech-cb1.dtsi          |   5 +
>   .../allwinner/sun50i-h616-orangepi-zero.dtsi  |   4 +
>   .../allwinner/sun50i-h616-orangepi-zero2.dts  |   4 +
>   .../dts/allwinner/sun50i-h616-x96-mate.dts    |   5 +
>   .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  21 ++
>   .../sun50i-h618-longan-module-3h.dtsi         |   5 +
>   .../allwinner/sun50i-h618-orangepi-zero2w.dts |   5 +
>   .../allwinner/sun50i-h618-orangepi-zero3.dts  |   4 +
>   .../sun50i-h618-transpeed-8k618-t.dts         |   5 +
>   .../sun50i-h618-yuzukihd-chameleon.dts        |   5 +
>   .../sun50i-h700-anbernic-rg35xx-2024.dts      |   5 +
>   drivers/pmdomain/sunxi/Kconfig                |  10 +
>   drivers/pmdomain/sunxi/Makefile               |   1 +
>   drivers/pmdomain/sunxi/sun50i-h6-prcm-ppu.c   | 191 ++++++++++++++++++
>   17 files changed, 318 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/power/allwinner,sun50i-h6-prcm-ppu.yaml
>   create mode 100644 drivers/pmdomain/sunxi/sun50i-h6-prcm-ppu.c
>


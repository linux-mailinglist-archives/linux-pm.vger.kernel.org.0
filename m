Return-Path: <linux-pm+bounces-40474-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F52BD048C5
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 17:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84C2531A6F59
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 15:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D792B347BBE;
	Thu,  8 Jan 2026 15:30:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f66.google.com (mail-ua1-f66.google.com [209.85.222.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF6C3451A3
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886206; cv=none; b=YkaJik77vrNz65KXOcWEl6W/efVtzU3XKjoZz4DQENWZr9deNqNJZWpHqssdrk9XDIm3ce/AaYmz7icvGIS2VPT3EBM+/Kp+j9HTL2nGMXT85chZk/9drvgp2Sioz1EDrDsu1UaxP3EbMh8RePUQhPVOE7yE8nOwIhTARZ/Ug9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886206; c=relaxed/simple;
	bh=H92scwhcHsTzYF+JJDH8TYSFfm64EL5HDb8BXyhP6pQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyvCZ9hBY0rCJwPtLJ2WHUZ+vdMwgKcpy0p/fNHbFqZpwlpwMj4k5iX6kvBbBUCbYQJRuc92zhbCSp76eYifG2e0EII+jBuTYmfe0Lnz40sib4XKWE1c70YwLNBN9LyeRgxUa4QhloZeHlLnPqEHTd6MJKOm+YPJG2aSWxULMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f66.google.com with SMTP id a1e0cc1a2514c-93f5761e09aso1869440241.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767886204; x=1768491004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rovq4lx6YcS995FtLIZSuYUGfhyo5V2P5Hen4vNwCUQ=;
        b=ezVbTDN3rZuT6/oxA7vrIFJS1dS+CRYyCb76RUVwbS//ogbLXy5ai3g+Q39ugoz85R
         O5FHqxy5gi0P4BX+W5s00JQTnOvJmTaK8luV5907WwUXYLzIZoTyCEckxAsG2IAUCOpL
         AV0WBKgNIEo0ALDV6L+szZdVr/2Kur1j/Y1oUPFDalYP2HoTSoTUTQFEvPKC5U7ZJfxI
         0bc8qKvCFmi0q7Zr6iX304CzVr1eI8wfRxoCZ3dwpszSeqT3huqXUGqJqjibXznKH9sj
         Gb2QTV7WmgvuN5oXNA5M8aPa5xd7GUb77mTHJAgXXFB+u9ej1DBUxQRiRPoNw3as9BpY
         gHYw==
X-Forwarded-Encrypted: i=1; AJvYcCX4nmrrKaLlrW33vZ4nvnBnVUE4ioymfOuDfRlPyvun0fHSj07RjKYwFBdJTyQZgd0xjhwldG3X6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzphPymck0/IWRwleUIqeWmoXLu0krWpLogHu7oiKAKAq4jttB3
	G2afazPy3UO+fw/JIfrCiCXVOZumkbGisAqKEnWEQVBM1Wh333/Z5fHzQBYjckEPQlw=
X-Gm-Gg: AY/fxX43vESfZDX2Vp/4rMK6hLqUFF8T3Aq+xKQCwJ3OL7FF20oObvLH2gU/9kvTn7b
	U3eYSausd2TViEdqXbv56W+nwc2L0VAiv6M5x5LsLo9hxPJnSOo9fHhmfCIzjYCq+8k2J5fpa6P
	/lp85vi+87uqrALIrXJ/SllxafWsA4Cpdx8VRHq2TZjN7dbjDRXBpUqeRq6cYIRhCQS63vsLjBv
	cT+phIkTB9onEXrWfskhG6eY4CrbtMKVIVENbMs4BewIS03K6ONfxT71SJ0Yu2iALqLJLiyqhr2
	bUd0PRVSdHzn/nJ0yVshHxnwRYWdNWOLOSivjiPxG4LFtkmBMaM94ERTMfr0hjt1spSX6LGY70Q
	0DoIXj91C01SMPUAb1X460xJFZUnsbbhkGS9uv3MA2B4RFTsxi5nlEnWHnyImYVi8bYKfmMQXMK
	+9/s88J528Si116ox/risUOjb/Oj8fdDZbJfUo+ajbsj7Lzv/Z
X-Google-Smtp-Source: AGHT+IG2bqN1h2rJ49jxbCwf+yHvu0/QGCeB3/K4ooZhI1+pnyyfOKxkIH2ONHlvqNO4/wdM9fUmug==
X-Received: by 2002:a05:6102:161e:b0:5e5:5ed7:60af with SMTP id ada2fe7eead31-5ecb90b08d7mr2462777137.38.1767886204120;
        Thu, 08 Jan 2026 07:30:04 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944122ae554sm6119368241.2.2026.01.08.07.30.03
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 07:30:03 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-93f5905e60eso1977529241.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:30:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW38nG7anT9a0XopDTp9Uc45hQRqKnKugJjL8sq1SsMIR2kFvyexLJ1GPnUQFzmmnm/uR2BjUUD0A==@vger.kernel.org
X-Received: by 2002:a05:6102:4412:b0:5db:f352:afbe with SMTP id
 ada2fe7eead31-5ecb5cbb3e6mr2954223137.6.1767886202897; Thu, 08 Jan 2026
 07:30:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251126130356.2768625-5-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251126130356.2768625-5-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 Jan 2026 16:29:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWtq7Pgc5rcbqJFT3BcL-MvHyuVih+g1iASbCSTOOcq0g@mail.gmail.com>
X-Gm-Features: AQt7F2qqUb7XWItwy_vEzBypL3W9hCnaGdamO5-CeWaKe53eXmGweAS7Tn7G13I
Message-ID: <CAMuHMdWtq7Pgc5rcbqJFT3BcL-MvHyuVih+g1iASbCSTOOcq0g@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] dt-bindings: thermal: r9a09g047-tsu: document
 RZ/T2H and RZ/N2H
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Nov 2025 at 14:05, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs include a
> Temperature Sensor Unit (TSU). The device provides real-time temperature
> measurements for thermal management, utilizing a single dedicated
> channel for temperature sensing.
>
> Compared to the previously supported RZ/G3E, the RZ/T2H and RZ/N2H SoCs
> do not have a reset for the TSU peripheral, and the OTP data is exposed
> via ARM SMC, as opposed to a system register.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


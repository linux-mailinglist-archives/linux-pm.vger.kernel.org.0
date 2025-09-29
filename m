Return-Path: <linux-pm+bounces-35556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8B3BA90E1
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 13:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DC01C4222
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 11:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0679E301022;
	Mon, 29 Sep 2025 11:37:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7542C1A239A
	for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145870; cv=none; b=SCw6Q4SOKO23u22GNK1T/DbBQ9UIe9UJB+PGgr+C9uV+88lK65+McBEiLnXqw1UzhXXJ7W8g/+TI6wZLv0Bly/uHZMoLitJ7kA5et7DKrbSnST10lauvOhNuReA/IxdWPcGrxFESqag/gEKCSi+M2L2MZNCpo7W+YNAVFNcUSXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145870; c=relaxed/simple;
	bh=14SGPZS9nPNEndJRTPYwlhVvLeiJWTHVwacGI0l7DKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8XT0Dtkh9XTQ/KulMtIkXdtFWZBwy0qPRC7Hi1bbza2QnOHK6J1SXieKg51Y+Yelbl4MHIByMn2z52IoE/3fn1ruFFqknxn/MXXScfOBqTIEcqx3DY12e17h3TAcDvkhxcBTOHa+MxZHTzbH2rlnrLP2ovZVNqWuUEM2W7J5jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-54bc04b9d07so2000609e0c.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 04:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145868; x=1759750668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=weWdXbQxCnMJeHS7B7BXqXEXqPpjTdZBAI+JQlcZ3Pc=;
        b=CCEINmwhjjG/XUZsmAdarvFaGXKOB8dGTI8x7/kDdwt3B07eqZ9UOHK1p5S53MIRLb
         /l/9AmOFGRxSL1sbQaiENSzSqcGlTOjdgYvO0cPXLJN3B4mwWB9mM87Zgs9/gY4PDKM+
         snO0/tKhJxPkCi6nXuANJ8mEzqyREMvhv8Kh5HpKig9kR72vyXYuyXu4rl4OBbNfTU0K
         SoAHrN9zIB2iCR3Gk6Spq8HLtkR0p2FwPbg5TvoYfmb3q5sQskExsn/PMegt6y7a/Oa2
         oY8ec8Xhrra96jkBPWKntxP19cBoRTNX9qhxh6MgzdZ8m5PTGi+Zu9cldtqEvcbgW0Ls
         9b3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPTY723wDlhKOi9Sd1uspU2bm3Ih/Dq4bJnmcjpAk2fZ1Za1Ua9jDA3HiUPm45zA6OZ+NNTmQ7TA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCyavtFbsOo5Et8nKeBGY5xCaRW+hB8BuvsTqR3xkdHj5aehVq
	CgP/+CSUk4dd9Yen3JwaD0/tG2c4BSlDxXtOqHm2LTZWMCgrt/nhBVlwCbaTg8T1
X-Gm-Gg: ASbGncurMnpwQwhbUpyNJav8UlISaQIhWz9031U1OlvlNIDSvwKyIlD8m/Xfxx5Hl1g
	N22GmhbrAgyngvSAr4MYqJVwf4o20BYgQFErTYWV5OD/8ms2vunviBpFbMJB0xvfM1D0Gny14Su
	tJG506Dn+Uq3HxxS5ImTYDV/DGDQLTvS4nLcYjWKQJ5TOzEwXMZJGFA6IgZTua7b/xuxT5iSwCy
	aP8KTi3lzhAvKYb++brfBu5KzOT3dP4tEMnogCFIGhjykXGDZDkoP9MQMHRaSe52ZdrWDwdDyOm
	82tHkkbtIA0ViW/dT5HYvyjRi564McoPf8QZTSTNZb3GaYKHq23KqqamtQhCLV+9xs4dtDwMZVf
	vex52djMuX9j9ZPS8We5pKzrVTsiCvdZ46JAO/gG6FbwLH4j8yNZc56eab7c3IcpptYRBjS/GtL
	k=
X-Google-Smtp-Source: AGHT+IHeF4gCRcGxrrRkzQkMUBN4aYeKU3rPyo71NWsvmdcHEGurrumYuh5QLxcjwyW66r+YMBPevA==
X-Received: by 2002:a05:6122:3c4d:b0:54a:dcde:fa5b with SMTP id 71dfb90a1353d-54bea1e1d1bmr5459549e0c.12.1759145868192;
        Mon, 29 Sep 2025 04:37:48 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-916db3be313sm2330568241.20.2025.09.29.04.37.47
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 04:37:47 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-54a8f6a2d80so1615697e0c.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 04:37:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWL4vSHNIVZtQfiCOai8OiG0tpXHZb2y9r9KAhIyKbOugL0Kmh14tstH0x/VYFKSXxFHjx2D59QhA==@vger.kernel.org
X-Received: by 2002:a05:6122:7cf:b0:544:8d16:4541 with SMTP id
 71dfb90a1353d-54bea102e5fmr5636901e0c.7.1759145866822; Mon, 29 Sep 2025
 04:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810122125.792966-1-claudiu.beznea.uj@bp.renesas.com> <20250810122125.792966-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250810122125.792966-4-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 13:37:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX5zSX5URg4vY3Mm8zo9ghE9cTBOMg8ozLZJ2QevF=7uQ@mail.gmail.com>
X-Gm-Features: AS18NWCeuTWOa-ri5Qlkxi0ZocAYLNnINdMinkM81tK5_mT4fKgbcdtjVA380a0
Message-ID: <CAMuHMdX5zSX5URg4vY3Mm8zo9ghE9cTBOMg8ozLZJ2QevF=7uQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] arm64: dts: renesas: r9a08g045: Add TSU node
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	niklas.soderlund@ragnatech.se, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 10 Aug 2025 at 15:02, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add TSU node along with thermal zones and keep it enabled in the SoC DTSI.
> The temperature reported by the TSU can only be read through channel 8 of
> the ADC. Therefore, enable the ADC by default.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks, will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


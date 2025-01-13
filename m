Return-Path: <linux-pm+bounces-20299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8607BA0B191
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 09:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3840A3A1CB1
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 08:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEE8233D93;
	Mon, 13 Jan 2025 08:45:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005192327BA;
	Mon, 13 Jan 2025 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757931; cv=none; b=hGjsEF86eTKqgUWoSSxIY/n5trLvrB3gUBKFM4cv9m1WqMsiw7P3TcqqI1SWwV2rI3H0q6/IEytfz1JR1BH03fq9fmrrVbsxbEbomIgGjhvrG+uVR1ClMaliYldRSIrpG4BA/oXqA/gAaoHu9ZSb7vSoOvKMQMEU5WHrfShLz44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757931; c=relaxed/simple;
	bh=85JIzD3dBKg6S5CVubuGChnys/7Jgrel2vwRVe+85Ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FILoECGA6HyNPAS69TYYyRUeGFLnt8BEJhtPfZ/FpjwDejbHvzbKhMUu+ECY6438+1mtpef4XG79bmJlzOCb5KX71BPRv0MrwnJLGfDDBbBJ491ew+6oOLtoUg7ISBaZpu4b99kNGsOH18NLAfrYWXIAu/d9eYN2iZ62CxJMz08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-304d9a1f198so32967171fa.0;
        Mon, 13 Jan 2025 00:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736757924; x=1737362724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WASk+gE3NJv8dH2tIoBohA4wKX3eYlj864c+8gk1xzY=;
        b=CneZYDvkHAnyAX4kTZDEfb5Ah9xUkCS9QW+XIoIT65uw7UWj04CRmgx8vkFNQqA/qI
         CAiNfQrku8u1Rfe36VuTLbLemFK/9imwVxYfp6XolLEqhSBKDOdMzc9ALCmmJyRftMkv
         e31ZpJoKB5rRStGnbI+klGpEe7XtgiTu+KjTWW181CJtG+S38v2Rl9JahAUg1fwfVB3z
         0+Lr0QO3hMMFWixwM77d544Kf3a4hDxMblXbDy8CwlYXNyWd7ASyhT19jNoZLWXxZBFD
         uU32O3zWaeQvPiT8qTBH9eeK7AGUSm5nlLfQ1PeTf1P3DbJpnILyizvxA3tBDNVZWHl1
         mzyA==
X-Forwarded-Encrypted: i=1; AJvYcCURfYDgXsLB8Q3ANFx1ZMVd+kDy52oU7ymSEckU3hWGhXd8n/kVHbb4sjnbT8JAfmAnWwIlnBfn/Dq6@vger.kernel.org, AJvYcCVgH3Go9AqqH+3ThxU1KZc1vhnUT4ez+GKJ9nxu7huukGQvh+afQyXLKO3CDeS6QEDuYSRLunrVO+3R@vger.kernel.org, AJvYcCVqexIH9FmqZnlGNDA2lk3g2NAhtkN+QptGpy9qzVYHc++HqoCjBDroNp+FE11aIRs4opd3xa6kqqQ=@vger.kernel.org, AJvYcCXOQfquBpt6+uj6CfsI3JotyrRpMZUkYojy2Vck7286SqhYh7L7N2oAqkEqdMa65oiw8Ic1HA3Jw1cWfQ==@vger.kernel.org, AJvYcCXwu5DxS21Fy8evN0JuHNiqQIPdH9Fpx2POqw+YdWOiiE2+3N8To9WOt9Ljx9CnEGLXT5QlNQeEWOIVvZnz@vger.kernel.org
X-Gm-Message-State: AOJu0Yylc2gH6AAOfB+uPSlvFfDMVICgrypRd6saWBgQZNUMNMXz3X3j
	CNwfFE3Wry9+fXrlH9OpFXvImunXdCqLAJFR5lwjYQfGGn3029IaFQavQcd0GmI=
X-Gm-Gg: ASbGnct2Jl5PcugfQlRlv+I2TwxOZAdq454PthZZ6cjklcLgb0ocNn6eGm8Lg3KmFY+
	tadlZMBbgVYlpZrt7/xAi96UGaqlg/Mh1qw5bTi2HUVj1rKZ+ofMpBJGLQuwoILaHmWspHzTurB
	Rg3p7H/cgFxLO4RMk7TdwvDSGG3AfuNkpIUYWJdnv3JYxDWBY6VNKgKNYZZgtW/59MOX/MaJ5xn
	GbsmZxszMpdUZpRV58CXYfyhRnwa8a9LcBh6LJdZlQLwgtrKuf0qJo04nQskYheRF2QRrPm3AyL
	IQIr8aKYwzURnw==
X-Google-Smtp-Source: AGHT+IGnbe1zdyBEZq6jXOWCz9p+/eYXnTe4yuUFEE54Hc3ZP05Px5scSWRCax4y/c9lh8KM/+g8nA==
X-Received: by 2002:a05:651c:4cb:b0:302:1cdd:73c2 with SMTP id 38308e7fff4ca-305f45a73d2mr67856031fa.20.1736757924022;
        Mon, 13 Jan 2025 00:45:24 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-305ff0cf0cfsm13730391fa.30.2025.01.13.00.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 00:45:23 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-304d9a1f198so32966701fa.0;
        Mon, 13 Jan 2025 00:45:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUs/PtvQCk/DD0ER2Z0TcDv9P/F1XEtUufVYVmwdRVQzVevp2ypHSolKvPyGyrO2DK5TxRsUchWuKa6I7UW@vger.kernel.org, AJvYcCVcd/CYv6GFWNOgxDsqFgxQVtp+pw0mDLh96ev+s+F5RSgeswjFyPx4a4kHhpXIZ6aLH9eRd4L40yM=@vger.kernel.org, AJvYcCWTpHvd75e8YOhpE3DtyPT63IBGOSKbBMYcILCrT0PS52wuBdxxrwbxTrBvdhsDXArmu72aowMZqiyh@vger.kernel.org, AJvYcCXZkh1o3TSf9LtMmd3FZ1taQlxTSfwLIVo1m3ap2/uQJG6JML69FoUN0Cbe3sZtvv4WCd5O5upq/IeZ@vger.kernel.org, AJvYcCXcg5NeoMnjLpfeZNToCHi/MfZZhdPIeMeYsKMtEUIhqwihbRb+iOBM1mqFbMnYclNfc04b3XvbHs3ZHw==@vger.kernel.org
X-Received: by 2002:a05:6512:e93:b0:541:1c48:8c17 with SMTP id
 2adb3069b0e04-542845b0a66mr5904614e87.46.1736757923296; Mon, 13 Jan 2025
 00:45:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
 <20250110123923.270626-7-szemzo.andras@gmail.com> <de280eed-bcc8-4802-9734-5e95ad1f6611@kernel.org>
 <CAGb2v65arvBMg+reReVqK-Y6dL+CSrSx4618msiRKcNf=Vk1=A@mail.gmail.com> <fef71e03-489f-4503-9d1b-d61051d45dde@kernel.org>
In-Reply-To: <fef71e03-489f-4503-9d1b-d61051d45dde@kernel.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 13 Jan 2025 16:45:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v67_yMB_4SCjFOR5S6nDxX9=zbX-mDM6YjjL_NRxrEMUFg@mail.gmail.com>
X-Gm-Features: AbW1kvZtDHwSmVGYxqRRgoOst1sjetl-67if_VRPdIRHwhs3tGpanfWm11zl1N4
Message-ID: <CAGb2v67_yMB_4SCjFOR5S6nDxX9=zbX-mDM6YjjL_NRxrEMUFg@mail.gmail.com>
Subject: Re: [PATCH 06/12] dt-bindings: clk: sunxi-ng: add V853 CCU clock/reset
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andras Szemzo <szemzo.andras@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maxime Ripard <mripard@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 4:21=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 13/01/2025 09:06, Chen-Yu Tsai wrote:
> > On Fri, Jan 10, 2025 at 9:56=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On 10/01/2025 13:39, Andras Szemzo wrote:
> >>> As the device tree needs the clock/reset indices, add them to DT bind=
ing
> >>> headers.
> >>>
> >>> Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
> >>
> >> That's never a separate commit from the binding.
> >>
> >>
> >> ...
> >>
> >>> --- /dev/null
> >>> +++ b/include/dt-bindings/clock/sun8i-v853-r-ccu.h
> >>> @@ -0,0 +1,16 @@
> >>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> >>> +/* Copyright(c) 2020 - 2023 Allwinner Technology Co.,Ltd. All rights=
 reserved.
> >>> + *
> >>> + * Copyright (C) 2023 rengaomin@allwinnertech.com
> >>> + */
> >>> +#ifndef _DT_BINDINGS_CLK_SUN8I_V85X_R_CCU_H_
> >>> +#define _DT_BINDINGS_CLK_SUN8I_V85X_R_CCU_H_
> >>> +
> >>> +#define CLK_R_TWD            0
> >>> +#define CLK_R_PPU            1
> >>> +#define CLK_R_RTC            2
> >>> +#define CLK_R_CPUCFG         3
> >>> +
> >>> +#define CLK_R_MAX_NO         (CLK_R_CPUCFG + 1)
> >>
> >> Nope, drop. Not a binding.
> >>
> >>> +
> >>> +#endif
> >>> diff --git a/include/dt-bindings/reset/sun8i-v853-ccu.h b/include/dt-=
bindings/reset/sun8i-v853-ccu.h
> >>> new file mode 100644
> >>> index 000000000000..89d94fcbdb55
> >>> --- /dev/null
> >>> +++ b/include/dt-bindings/reset/sun8i-v853-ccu.h
> >>> @@ -0,0 +1,62 @@
> >>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> >>
> >> Odd license. Did you copy the file with such license from the downstre=
am?
> >
> > AFAIK all the existing sunxi clock / reset binding header files are
> > dual licensed. OOTH all the YAML files are GPL 2.0 only.
> >
> > IIRC we started out GPL 2.0 only, but then figured that the header file=
s
> > couldn't be shared with non-GPL projects, so we changed those to dual
> > license.
> >
> > Hope that explains the current situation. Relicensing the whole lot
> > to just MIT or BSD is probably doable.
> That's not what the comment is about. Dual license, as expressed by
> submitting bindings/patches and enforced by checkpatch are expected. But
> not GPLv3, GPLv4 and GPLv10.

I take back my statement. It seems we have a lot of GPLv2 or later going on=
.

include/dt-bindings/clock/sun20i-d1-ccu.h:/* SPDX-License-Identifier:
(GPL-2.0+ OR MIT) */
include/dt-bindings/clock/sun20i-d1-r-ccu.h:/*
SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
include/dt-bindings/clock/sun50i-a100-ccu.h:/*
SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
include/dt-bindings/clock/sun50i-a100-r-ccu.h:/*
SPDX-License-Identifier: GPL-2.0 */
include/dt-bindings/clock/sun50i-h6-ccu.h:/* SPDX-License-Identifier:
(GPL-2.0+ OR MIT) */
include/dt-bindings/clock/sun50i-h6-r-ccu.h:/*
SPDX-License-Identifier: GPL-2.0 */
include/dt-bindings/clock/sun50i-h616-ccu.h:/*
SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
include/dt-bindings/clock/sun5i-ccu.h:/* SPDX-License-Identifier:
GPL-2.0-or-later */
include/dt-bindings/clock/sun6i-rtc.h:/* SPDX-License-Identifier:
(GPL-2.0+ OR MIT) */
include/dt-bindings/clock/sun8i-de2.h: * SPDX-License-Identifier:
(GPL-2.0+ OR MIT)
include/dt-bindings/clock/sun8i-tcon-top.h:/* SPDX-License-Identifier:
(GPL-2.0+ OR MIT) */
include/dt-bindings/clock/suniv-ccu-f1c100s.h:/*
SPDX-License-Identifier: (GPL-2.0+ OR MIT)
include/dt-bindings/reset/sun20i-d1-ccu.h:/* SPDX-License-Identifier:
(GPL-2.0+ OR MIT) */
include/dt-bindings/reset/sun20i-d1-r-ccu.h:/*
SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
include/dt-bindings/reset/sun50i-a100-ccu.h:/*
SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
include/dt-bindings/reset/sun50i-a100-r-ccu.h:/*
SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
include/dt-bindings/reset/sun50i-h6-ccu.h:/* SPDX-License-Identifier:
(GPL-2.0+ OR MIT) */
include/dt-bindings/reset/sun50i-h6-r-ccu.h:/*
SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
include/dt-bindings/reset/sun50i-h616-ccu.h:/*
SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
include/dt-bindings/reset/sun5i-ccu.h:/* SPDX-License-Identifier:
GPL-2.0-or-later */
include/dt-bindings/reset/sun8i-de2.h: * SPDX-License-Identifier:
(GPL-2.0+ OR MIT)
include/dt-bindings/reset/suniv-ccu-f1c100s.h:/*
SPDX-License-Identifier: (GPL-2.0+ OR MIT)

Is there a requirement that new files have to be GPL 2.0 only, not
GPL 2.0 or later?

Documentation/process/license-rules.rst says:
The license described in the COPYING file applies to the kernel source
as a whole, though individual source files can have a different license
which is required to be compatible with the GPL-2.0::

    GPL-1.0+  :  GNU General Public License v1.0 or later
    GPL-2.0+  :  GNU General Public License v2.0 or later
    ...

Aside from that, individual files can be provided under a dual license,
e.g. one of the compatible GPL variants and alternatively under a
permissive license like BSD, MIT etc.


ChenYu

> Best regards,
> Krzysztof
>


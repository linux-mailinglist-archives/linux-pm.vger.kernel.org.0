Return-Path: <linux-pm+bounces-24160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E0BA65038
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 14:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 073EB7A2080
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 13:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AAB23AE96;
	Mon, 17 Mar 2025 13:06:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5742356B0;
	Mon, 17 Mar 2025 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742216812; cv=none; b=G7vM8i8fI1UT9k/oJLQswkuGfW5aX+71sCFWfluuJIzMFJRxIvoMzzlUWgSp1CPAPDXsZRpX/kBrWKTvcatr6wTJRnhlCSX9PjN2OqvBkQ/DlT3V/Fr3nuf1JNqgz1wSK4mh6dNVwqcBm9W4tfq3/8dGXKvOlD038+vhGPb8hGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742216812; c=relaxed/simple;
	bh=qLLnqbUdQc9QQW9rNrgFZooAzxlpgOV67H1WdYcrmsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcUEpvElYTARkHU3MXJMC66Q7GjyL1pSRgZUQmaz0FNkAR8Irt5yhLL5JcSKlRe3HlmuAs2zaaxNPqCSPK+EQYRavqERfpeoZozDM1jRVPmlAGqA6Zelr1YADONRyQryggopk3eqVsoA9TkIUVFitgmnVwd9j+EcPwDbC49zNbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c592764e24so56387885a.0;
        Mon, 17 Mar 2025 06:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742216808; x=1742821608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O716qHSqjIZ+TTPaEOmQdWi3YCLXAx4bTootKFbaaeY=;
        b=HHPNNUreEhVYIraK/+vx7FjSVCRrrcJuXaYVls6w7NPjKT9cT5zg4l2pwMqkBLKfrE
         k1KE4g+Pn4ZcOnsKhKlDy08IDWfl+Ht/qJncCrUZzwmTedS+laWbV5Dfik7InsoUuwUm
         GUru64Sd/m6MOcuzbbaVVcIySGkU6LRMzdTL0yD9wadwCLe4ScmT96o1qxx3Q7t9WuDt
         gMHj5taPgJ6Zor1rlbqRqfYDv9tQqA599HW5YBWKpK1Dl2iO5CHrwAfHfew3zrqTNGx6
         dFuWyYyQcw1SW82lA5rKL0K5DEMjOqdMEgaqq4htbGzdGho2qmoWUZagNNZvC9E8xVEI
         2Acg==
X-Forwarded-Encrypted: i=1; AJvYcCVH6YW4iyrlm9tU1K/0NjB57d3qSZmUP0fNz0gmK9ubSIiJUPUCRpfwNxcED1xoKBInYPPa3OVuOuk+FpvO10MW7HY=@vger.kernel.org, AJvYcCWWD0tEBXd/8V98zAvh91xJW9bvexsRTv9iZobHS+KiZQ1450bosS45NHyAQPWIyVIeY+tHJ4Tz2BO/bkpv@vger.kernel.org, AJvYcCXQJtUMn+esj5194f31C9ATpgZ9wmHpLjmy/s1+PsNE9Rih1nO5IwtcxLaqr4D5gAAcIdL3p4r3STg=@vger.kernel.org, AJvYcCXRF20itvs01v8LQkgknkjynO0QsViiubOG9pcLzy4gskIU7SAe7Z9Qx6KJj77YvyWpLx9FVYM5vaW1@vger.kernel.org
X-Gm-Message-State: AOJu0YzmR+Cak5U6aC5iByn5NZNbJn3+nBsI32IP+lazV41LzL8zyS0f
	otkO+UgTXZMD75bic9VEV9VqosaLN+jSD8oQ3OAaI4v/d8qcNAwvfdswqpcr
X-Gm-Gg: ASbGnctrjCi/7dl8afpradCzIoT07XXH4nADEWvgu58r8hCW/+15Jutx6QBOOXGTIBs
	4UcClrWv0USPi/ef8MQchodTY1DHsRaCAOq04PfOgYAjYJ+hj3lfDAwtBpUW0+alRQGbp/KCNYk
	CiCB1r28mievatzqHLyj4ycjNaehsjFGsayhUgpaYZFNhT7XCvN5pm+K51qAOIQA2EEMEmyhD7O
	QSACbMF6Zl5wqykZVkbP6XL39hTz0ecg151RTg3dzkYi27DvGB70qG7rVv2kQSFP+2Xj0YwCtt5
	JlaYlZxhQ7vN8As51TiW3qU3rNurFudMDZ7UZba8xAy6pEyLjoTj3HfUGiG+XPfF2cztFBPNGaD
	mqAqdNOQNC5E=
X-Google-Smtp-Source: AGHT+IEfq4DsBnaJ1NgW3Gz9MymASWkZW2hXaU0TsChLfQTAs2T+Vz6ILemYCBZRX9uH8vE88cZaUQ==
X-Received: by 2002:a05:620a:d93:b0:7c5:95cb:59ac with SMTP id af79cd13be357-7c595cb5b5fmr154355185a.28.1742216807784;
        Mon, 17 Mar 2025 06:06:47 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d6fb39sm581509585a.85.2025.03.17.06.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 06:06:46 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4766cb762b6so40845161cf.0;
        Mon, 17 Mar 2025 06:06:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQZ7EsvYjt42HFcQgO+Cx8LMfOwvRp0KIrYitloSISDUsUro7vqECEvOzKvrktddzEzJeeW4/R+mk=@vger.kernel.org, AJvYcCVbh9DNqfQaMZN8uzvJit8onyLgwcdEjiLP2oV56iSSfxFuDuvi9wNX0t79a49Kt2fHdKQAFl7utnswuK98GoLfHYs=@vger.kernel.org, AJvYcCWYmRwy5cuJFIwB63PLpK8i5NXLUMrFkMZ77b1LHH7qobHk0XHiicN8MbOxCTIX8EYlzE7WIi2Dbo0gzZ8D@vger.kernel.org, AJvYcCXhCXBWlOT2yNKU+5fDvz/lb7sM/Dcf3TQZioh+0eiwoLHBFBINP0fGhvC2a8qqqOcWZDKmwifgDHwC@vger.kernel.org
X-Received: by 2002:ac8:7d4d:0:b0:476:add4:d2c7 with SMTP id
 d75a77b69052e-476ba3a2503mr286445171cf.0.1742216806135; Mon, 17 Mar 2025
 06:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315081225.92118-1-john.madieu.xa@bp.renesas.com>
 <20250315081225.92118-7-john.madieu.xa@bp.renesas.com> <20250317-bipedal-inchworm-of-poetry-b60fc9@krzk-bin>
 <OSBPR01MB2775B7252468BCE234BFF7D5FFDF2@OSBPR01MB2775.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB2775B7252468BCE234BFF7D5FFDF2@OSBPR01MB2775.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Mar 2025 14:06:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXxWCG-9tE7MsO3i+VXSjj6cZvH50fnQA=xvNfcQw842g@mail.gmail.com>
X-Gm-Features: AQ5f1JqJN9njXYPbrlhYUCLeIXSPDCUMX-_U49TlAyAAPE5dm5sX_GhqYhuToiE
Message-ID: <CAMuHMdXxWCG-9tE7MsO3i+VXSjj6cZvH50fnQA=xvNfcQw842g@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] arm64: defconfig: Enable RZ/G3E thermal
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, 
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"john.madieu@gmail.com" <john.madieu@gmail.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "sboyd@kernel.org" <sboyd@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Mon, 17 Mar 2025 at 12:14, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > On Sat, Mar 15, 2025 at 09:12:16AM +0100, John Madieu wrote:
> > > Enable the CONFIG_RZG3E_THERMAL flag for the RZ/G3E SoC.
> >
> > s/RZ/Renesas RZ/ and which *upstream* board uses it? This is not your
> > platform defconfig, but all platforms and all users defconfig.
> >
>
> Noted for the fix.
>
> However, most thermal drivers use SOC-specific config options,
> as we can see in arm64 defconfig:
>
> [...]
> CONFIG_IMX8MM_THERMAL=m
> CONFIG_K3_THERMAL=m
> CONFIG_QORIQ_THERMAL=m
> CONFIG_SUN8I_THERMAL=y
> CONFIG_ROCKCHIP_THERMAL=m
> CONFIG_RCAR_THERMAL=y
> CONFIG_RCAR_GEN3_THERMAL=y
> CONFIG_RZG2L_THERMAL=y
> CONFIG_ARMADA_THERMAL=y
> CONFIG_MTK_THERMAL=m
> CONFIG_MTK_LVTS_THERMAL=m
> CONFIG_BCM2711_THERMAL=m
> CONFIG_BCM2835_THERMAL=m
> CONFIG_BRCMSTB_THERMAL=m
> [...]
>
> Hence my choice for RZG3E_THERMAL, or did I miss something in your comment?

I think Krzysztof is complaining about "RZ/G3E SoC" in the patch
description, not about the name of the config symbol (which is fixed).
In addition, he asks for mentioning the board this will be used on.

E.g.:

    Enable the Renesas RZ/G3E thermal driver, as used on the Renesas
    RZ/G3E SMARC EVK board.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


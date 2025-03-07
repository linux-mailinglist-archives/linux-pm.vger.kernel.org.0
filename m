Return-Path: <linux-pm+bounces-23626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EABAA5679A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 13:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80301740EB
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 12:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54701218ADC;
	Fri,  7 Mar 2025 12:14:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C6121884B;
	Fri,  7 Mar 2025 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741349667; cv=none; b=m8Ti4tbbGjXgia9kA3PPa4c9I9ei8w4iFq8WQ/WnOLp9tC+68wzpvy+C8t6Hj2JKHgxFgSGu0s7YfvilbfAjm6oPn+skfzFg0+8+4aodcri7rZk8cB210fW+JsWis+EunZwp+wcop6Hyw+Zw2MAMjzuWFOgATfUY9KdGc12+ksM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741349667; c=relaxed/simple;
	bh=d6LwsuB/pKfHcnCjCLWid82o180yQ1+EKXGCVoTCee0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXBbPSOrNM9+2jBOm39BWKZbI7U6oQu01qTN5wvEU08oPL2CkxRhfp1RhtBF07S2wu+DxP+YT3G72vyS0Ykf9OVmCa4wVO4lgRnekyXeqgk1/mxKAkVV0qvU+lYoEhSI2yG6b5CpXn2Og30EH8e3WVMhwMZ/ltTgEM0fwuCsbEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abf6f3b836aso278315166b.3;
        Fri, 07 Mar 2025 04:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741349660; x=1741954460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ROcyeVCYncbaGDV5GQ7+90dm5cD3FAezni/Ys9hsv1U=;
        b=hgwi6kcXGWCtBGK4eXw2ZWm6oJCkPFUzxz7aS0NBZvaEZTlw9eHv7HqPRYc4z95WwE
         X6U6YLFMucp8U8Rnf8Ar4hY7GiVnhgSlAQJZtnsa6EWKQhdPVayM/J7tiTTB+/fDakPW
         nEGT1bfuKqNMeOtKVzGCklIsZiEMTUBOzFOtbluwJIzawzWgk4Lfj3l228ts9ka4sMKu
         0wePAVCsZSmDsH9XDn2goXgceSL8zclkY0vf5MfT3fza4rR77cFFiTm3ItjGAYk9Wbcv
         +HXaSj/kyuI58SeZZFFRpSsfzYSQwS3apJbRbxOzpWE7aSdTr7UFc1RHeotZyDBd56Qd
         rQsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd6yFyVH/wydYXYMCS1+O3MVvjkeUDuFfekAIJPkkkIQe/aWb+RVf3iHZUoSgh7OiCK4HWScmjxPA=@vger.kernel.org, AJvYcCWDmo1nbQOdmvkrdAac+RYcDRriTZiZTTwvqTVAeO1O/EkUi3pSxSoPL1qjoDbbUnGVA15Vg0Ya7RG8@vger.kernel.org, AJvYcCXNVMLwgMQek9RKmZNK35dP6hAwfsIOyiuFo/2KReNEcp8ybWvTAZf3xOEQfiwsvdtSbgKsBWmFBtAKzzu+@vger.kernel.org, AJvYcCXaY2OZyKgcjwTUv+F8nYJGS4/r8s3zpfkTozECtp63sXruAehYkbHe4JINvVEOF6IMYJu7GERdKYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR4J8MkqHGcqA/PmM+CLQVmbgHiMSig9BZ0I73Fn65Lc/iuSZ4
	sCX0pR4YfTOWlN/6YotlmQA6L9W9IaHOyyKqf2/eAvpMYYfpnIQhQjaY9MDyvBk=
X-Gm-Gg: ASbGncvq7xXDzPylpG/EGU8MT0KXKOK1DDQE0DYBYnZyrOF8x/7cW+DBcmk+0dt1CyS
	VZabVjdGeB/o/cxmOLhM3KEz+AtVPeFUszG8mVpDECQIn2nwW5LOWXhMGlQRs/kFTqkJsD4yk8q
	QzNhSzCnQhM1rG2AB2wSemAlHzbr/MuMuUALbu9yIAu3EPMUNGGvt6+yaxYKTZpe4oT0fJFSIs0
	rOT8GYJNRO0lQMBoVi72rMikXf1GEatIkldQZHBkJDmuM3xLPeiK27YSlfci7nC2Y9Ru6DGFZln
	P0RoF+sVwwC+OSYeOoDRmym4ZlBri4/A+h7UcRXAs/ZP/rI+RiThR198HLmZNrPysb8gvp1YTem
	TLkIU2fg=
X-Google-Smtp-Source: AGHT+IGhyBm4VxwLB9R59pyPN1k6D1rwG6U3sz7ZFxW3lDMsmhOoaQOmVMRf1M150bAh9RT48l+3ZQ==
X-Received: by 2002:a17:907:2d88:b0:abf:55d1:67f4 with SMTP id a640c23a62f3a-ac25274a9f4mr341862066b.7.1741349659466;
        Fri, 07 Mar 2025 04:14:19 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239887693sm264943066b.126.2025.03.07.04.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 04:14:19 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac1f5157c90so282092866b.0;
        Fri, 07 Mar 2025 04:14:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/Qhn1t+kyBkNCuf3jnd/iHXIkxDBb+MXwpcq410/QOpHk/+DFZae7/7SMqQ7eAHIzoKmguRLOPnM=@vger.kernel.org, AJvYcCV34Zro8RkcMzobK0HB+lbJ+pYsNrQFSYp0K3W0BjHIazVnpXr/DGWbaXdKgsPx72tJkVuiTVNtfs+M@vger.kernel.org, AJvYcCVgIjyEn8FX23TwLurYZW1siQomqVwqvz02KGBsXm/F/SBOrK2lPMzK9h/PpAjD2iwSUZMp1OKWzZXWRoSX@vger.kernel.org, AJvYcCWETUNXPYz5Zpc+X6YLG0Ec4q3G/c7O5JyE4+Sb59bGN/snLiQWY9HEqFDf3PCLIXa/e6BwBQOrOZw=@vger.kernel.org
X-Received: by 2002:a17:907:3e8f:b0:ac1:f5a4:6db3 with SMTP id
 a640c23a62f3a-ac252b59b7fmr392509366b.33.1741349657119; Fri, 07 Mar 2025
 04:14:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-vsprintf-pcn-v1-0-df0b2ccf610f@bootlin.com> <20250307-vsprintf-pcn-v1-1-df0b2ccf610f@bootlin.com>
In-Reply-To: <20250307-vsprintf-pcn-v1-1-df0b2ccf610f@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Mar 2025 13:13:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVzQfGUr-wyHW3z=KN65OFpXWgfqBru9e_z8MKtk3pmfA@mail.gmail.com>
X-Gm-Features: AQ5f1JrXAoSReqv06x2VIYWRPdg-xCyJZ1PBeew-FyYu-xLixRBhXK4dP3ysYK8
Message-ID: <CAMuHMdVzQfGUr-wyHW3z=KN65OFpXWgfqBru9e_z8MKtk3pmfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: bcm2835: use %pC instead of %pCn
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Liu Ying <victor.liu@nxp.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Mar 2025 at 12:19, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> The %pC and %pCn printk format specifiers produce the exact same string. In
> preparation for removing %pCn, use %pC.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


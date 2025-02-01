Return-Path: <linux-pm+bounces-21204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF37A24876
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 12:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE331885781
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 11:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1F4153838;
	Sat,  1 Feb 2025 11:08:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D4B19A;
	Sat,  1 Feb 2025 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738408126; cv=none; b=HrvJpTteaZMc1o0fh7gqbcXt+clTAZedKBYsJ267o4Xd/X4HfC4RUduJ9g5CTUZbQY/6lg2zHdbfVtTehiPqrxb/4ptOjwh4XKbLCV3Axrv+p8okUE6uK/07+tWQ+7ZQ6THdPFgC5pDKWqEei89AHqHu9SLI0OimyTGi4QyykjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738408126; c=relaxed/simple;
	bh=lV2M1tUa4SWHGmKYz293Rfyic2j7Zxh3fh/VhcUO9mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRAULcVARkwLgaEHgScR+h2JViMMXdH2H5pFRwe54Cmsb0UUjpMI0J5HCZdICnaoT0Y8ippdo8UZOUY01gVTTNSVvAsVH9Cc/1r+wyiOLt+i4wY5cVWXUqK2+w3eyHE2b7BMNuZs+rDhSl9ALV+1N4xNSagRnX3utw34mxAeAW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-543cc81ddebso3234822e87.1;
        Sat, 01 Feb 2025 03:08:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738408122; x=1739012922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zJdFRpY9/VgrRdJOyKoz6hilS+1z3UkKtKPtOxUttZo=;
        b=K2hOsnNAjpsApCJ8p9+FL7pORg2ZujoXpNtAFiSVw+cn12E9bIWNVR/deXAYS8lVEn
         1AIOkf64h3UEYX5wfN/6FiedTf4a1UaoOLsLBi1FBXXF4aIZ3kuprpvXC/2nkXnYE0MO
         IjTYdtChLPh0wM1WAHNQaH7CRjYyqEFnMWga0vptYlzE9lMrDvq/tYVUUDqE4aFQvWqp
         29PcceknBAvdrPYCImKtf4C6s69jYmxIHag+wGgcW0mBSZ1cbkV4Vj2BaFE08lL4ED75
         OlNfVOCxNnZxnwMUxK2HJQhjUoKw4bXflu4167lReLkHoaD5aAGJPD6psOkVN2taYka3
         EKJg==
X-Forwarded-Encrypted: i=1; AJvYcCVuMECbUblC06KwWhe3JU1D+x9cJw+c/VafjhSyEgc7+M+b/axvEiR1iWW5zHKO0QFj8/TYCQJjU1Tm@vger.kernel.org, AJvYcCXbtgnOpS/KHPpp4/izYbVgf/qpaojpYlShlPQIi47Br3lBclMo5byrdDjwAnFtCXYyN18jXP/SAJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkPPwtX+FfrTRJCfPZl0egodrF5wex4UtIIhEvhFC8/Y4WdocC
	UygtKX0sPcK0YoQxDnhamn7s1c3Fv6JyilUeUZwQWmHoIBMg5fs/OwI8Ev2g
X-Gm-Gg: ASbGnctS96F0tVUzQE3bZ9gEjK4bo/nB3eET+ye9xKQExKLe48NG3PtNh+LjxstntDG
	hJsPW8KHODaXr3fBuzjGoh1ZDWtCwiSNUxJDwidEIo1Ou2V5tkVaVztNFY1YnMs6FfExAtA5Pfm
	zbgg/4RgkTjCWJP01vvEa2IDWsBGw03TBvqBbOGYu1E1KLTHV9SKacyHvNQN92n29mzUOJ43ZGL
	6GbaRlr/Y+fc6vY4l65jaqgb5VRu+WukreZ4iPDp3ipgXBVW93pMfrWj4ZFpySkDtAwd1Y0eFun
	hnD7an8NB3LcwFN2epK5j9lBXQkhg0PIDUipQdtVOyhm0q5z
X-Google-Smtp-Source: AGHT+IEvvGuT9l7QynQdhRuG0fHwjiOstf8aganqygVYeT4w2Nb2XESEv7Ek0z6f1SAy/Zx4wjQrOw==
X-Received: by 2002:a05:6512:118b:b0:542:2e04:eb6f with SMTP id 2adb3069b0e04-543e4beaafbmr4711851e87.14.1738408121638;
        Sat, 01 Feb 2025 03:08:41 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebe219c4sm728947e87.105.2025.02.01.03.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 03:08:41 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30229d5b21cso20665351fa.1;
        Sat, 01 Feb 2025 03:08:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIEhTGe3u9T0VijWY8xNvvmdhEqP+z0jdlrWZYVkKUa6sZMHd3UX+SfiQBJlZbTHQMeQfuy+fXIZxS@vger.kernel.org, AJvYcCVOWoNKQYxmiEtE6NooUUgCOL+We+WfYcVkAI/bL3vrmfm3Sj/5h1cranO1vjrFSfuI19NM2PqqL50=@vger.kernel.org
X-Received: by 2002:a05:651c:50e:b0:305:d86a:4f01 with SMTP id
 38308e7fff4ca-3079696b37fmr54303631fa.31.1738408121144; Sat, 01 Feb 2025
 03:08:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131231455.153447-1-macroalpha82@gmail.com>
In-Reply-To: <20250131231455.153447-1-macroalpha82@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 1 Feb 2025 19:08:28 +0800
X-Gmail-Original-Message-ID: <CAGb2v67YFBoTaDb2_M9w5zVgDrc0dQofg1B=tOrO23zjUQncEQ@mail.gmail.com>
X-Gm-Features: AWEUYZmt5WAKw7Sa62l6O-dikObFL-05KwH7Ig2AS6totJP4XZ-9LOk_VWKpsrQ
Message-ID: <CAGb2v67YFBoTaDb2_M9w5zVgDrc0dQofg1B=tOrO23zjUQncEQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Fix RG35XX Battery Charging Issues
To: Chris Morgan <macroalpha82@gmail.com>, lee@kernel.org
Cc: linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, samuel@sholland.org, jernej.skrabec@gmail.com, 
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, sre@kernel.org, 
	Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 7:17=E2=80=AFAM Chris Morgan <macroalpha82@gmail.com=
> wrote:
>
> From: Chris Morgan <macromorgan@hotmail.com>
>
> The Anbernic RG35XX devices sometimes fail to charge when the register
> for the battery temperature sensor is set to the incorrect value either
> by user error or an incorrectly programmed efuse. Allow users to
> hard-code if a temperature sensor is not present (which is the case for
> all Anbernic RGxx series devices) to prevent this issue from causing
> problems. Additionally, a bug was identified with the handling of PMU
> faults while this fix was being tested.
>
> Chris Morgan (5):
>   power: supply: axp20x_battery: Fix fault handling for AXP717
>   dt-bindings: power: supply: axp20x-battery: Add x-powers,no-thermistor
>   mfd: axp20x: AXP717: Add AXP717_TS_PIN_CFG to writeable regs

>   power: supply: axp20x_battery: Update temp sensor for AXP717 from
>     device tree

Lee, FYI this power supply patch has a compile time dependency on the
mfd patch, due to the new register offset macro.

Chris, in the future, if you are aware of build time dependencies,
please mention them in the cover letter. That would help maintainers
sort out how to land things.


Thanks
ChenYu


>   arm64: dts: allwinner: rg35xx: Add no-thermistor property for battery
>
>  .../x-powers,axp20x-battery-power-supply.yaml | 22 ++++++--
>  .../sun50i-h700-anbernic-rg35xx-2024.dts      |  1 +
>  drivers/mfd/axp20x.c                          |  2 +-
>  drivers/power/supply/axp20x_battery.c         | 50 +++++++++++++------
>  include/linux/mfd/axp20x.h                    |  1 +
>  5 files changed, 56 insertions(+), 20 deletions(-)
>
> --
> 2.43.0
>


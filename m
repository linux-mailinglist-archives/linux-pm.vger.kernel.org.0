Return-Path: <linux-pm+bounces-31432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C868B12D03
	for <lists+linux-pm@lfdr.de>; Sun, 27 Jul 2025 00:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2934C3AAE02
	for <lists+linux-pm@lfdr.de>; Sat, 26 Jul 2025 22:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DB81E4AE;
	Sat, 26 Jul 2025 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrH1isPo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A54410F1
	for <linux-pm@vger.kernel.org>; Sat, 26 Jul 2025 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753569934; cv=none; b=kh+mS26jvat2bgl4cwW6zTvjLMVcqUusZyD2cV1NrKI8cv2iQmFuLe5YD/JYpcX/w2nxVazFWAyiEI1pyWURO2sMVb3Bjd0Sd5JV2ycnXsIArDEu+Ou5g3JegpY17HAN7ny5SB3t/hkB+hekLtFRAyUIiSw/Ko0PlXJ4avtdgLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753569934; c=relaxed/simple;
	bh=qmDR7sUtxbX2aqwBv04bQW1j/3FM8tlbnnNqBB37Fp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XixhvhEXMdIlJG6jMpsHa7A7P9HlZAZ7hLLDwG+PhkbvVduuB9lwKKMT5FckSaxfQHijl7Y2l1UZVeIduBEy7hjbTFPjZEy3//1WDpdnpC1Dw8LsTefiRtcd7xCLlQaLQwUftYhzno8PJ0ifc/CzVvTX1BegqzvwUAJBGyac220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MrH1isPo; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553b3316160so3393991e87.2
        for <linux-pm@vger.kernel.org>; Sat, 26 Jul 2025 15:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753569930; x=1754174730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmDR7sUtxbX2aqwBv04bQW1j/3FM8tlbnnNqBB37Fp0=;
        b=MrH1isPofJixnI7Xknj6jbQvmpyo0KEnqBz01TQa7D2mK1jrBGV5lwqR9KYMPQmNuW
         9m7ryUr9uMoudNEe5RnX8g7VKFGSIpN1vcT/kR3hzyjW2fUIQHtA368XPC8QbdvJqK3Y
         JKjIoogDLHauQSSjhkZ0MEFpaoTX4AItWe8YFQE+NJcy7iTrr5u/Cwy/AlzUS2P+lP8v
         jujPByido4vEsnWrqZm7MqmGtiy+kf75gWL0QE8jpDmtwV04IUnTp77e6yUSRpj6FOaO
         HXp5/db98zuCNT9g40zJAgEKKRhARKMKv6/V+UncH0/A3cWAygja8nFiH7WDfssJx+fR
         IUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753569930; x=1754174730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmDR7sUtxbX2aqwBv04bQW1j/3FM8tlbnnNqBB37Fp0=;
        b=Ua0asgc9ijk+LJJHhpiCntEF9ftvtTXn3bv22hlVUlj8F2aX37w+UlxLAjA1yh0x0n
         bZyL+UJpPBN1ChCbjUqpfuYj2tPgTKwgIKgvtZGOPrTz5NrcAk1++aR9xS8pCyddHHJX
         mgtkztiSqzJJ7f1BAZJj6ztQqxKmR5zAsNMqVw859F5c/RjkuuJrAicG1bV9jyjRfOH6
         /NhA6cqLz2UVn/Jb8AXZJ+0WQHpTFUPyAg+Kdu5NMZ7oqmhG5eBApNaqBdrgaDFpSKzZ
         6vX4/43sUsuqfdWXXoWX3vIHNfzlO9PmfHG4BllghCVhJ3u9qHtGcVGxPdm3nN8gpAcd
         tK+w==
X-Forwarded-Encrypted: i=1; AJvYcCVwGZkqM9wi25ZnsZKzNL591N7hO40xI/mybstW95VUCIRTs57RAP9a7J/1LI5y9lt6WpU8qEhzvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj/fp4gj9IwxUmnPzRxhgvBtJNm3RrzuRTZ89i5NlQpQPFzhgn
	X4GBPTpSGCE2/ZO5aeUjYeTgzJS2GZ8QQE+ZmV8fD1SOfIDn35Q4nZF+d3s8KvU21T0iIEqV7il
	nrQK1hK2OHI7VVhdPjCckcR/1iJ1Eb/aAR7TCjlcuwaxkihXDGJ78uHk=
X-Gm-Gg: ASbGncu05m2nl9zMu6+F0mGYtMyrICAGh1FT7/TBuuCNttpdjCyM+msPcbBAe9oSbTU
	ti5sl/yzvihYZXWAxrZaZ7fDI+YacSZ/9QDKIJoNM03NWkoads1haNTk1NvI4nskkXhNSB9YjRV
	9ow+HfR3VTgOqsNXyPjnEj3Pkh4qkGXvCsTQZJcjo5Vcqb8eU2mYTm//sYjO+rpj6DgdCTyH10/
	pJ+6S4=
X-Google-Smtp-Source: AGHT+IEt4xHbmlJLVHWSttJnwNemt8jztUxEXanOFN0yhr4/YXsyufEauagGSILc4bmhmYtCzs5l78drjAKyPAixKJA=
X-Received: by 2002:a05:6512:3b10:b0:553:2cef:2d2e with SMTP id
 2adb3069b0e04-55b5f3fc3bamr1770822e87.22.1753569930004; Sat, 26 Jul 2025
 15:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721122605.46724-1-hansg@kernel.org> <20250721122605.46724-6-hansg@kernel.org>
In-Reply-To: <20250721122605.46724-6-hansg@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 27 Jul 2025 00:45:19 +0200
X-Gm-Features: Ac12FXzKbcCxt2t4WQF9y1QEwCBfRMZ5O-Fb9Ybfzc5SauarXLSYkhdnWslUD2U
Message-ID: <CACRpkda7vBATqaXfkUhHxu-K91Zm2rf+-cC1-4hdvpdGz_=thg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] power: supply: Add new Intel Dollar Cove TI
 battery driver
To: Hans de Goede <hansg@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 2:26=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:

> Intel has 2 completely different "Dollar Cove" PMICs for its Bay Trail /
> Cherry Trail SoCs. One is made by X-Powers and is called the AXP288.
>
> The AXP288's builtin charger and fuel-gauge functions are already
> supported by the axp288_charger / axp288_fuel_gauge drivers.
>
> The other "Dollar Cove" PMIC is made by TI and does not have any clear TI
> denomination, its MFD driver calls it the "Intel Dollar Cove TI PMIC".
>
> The Intel Dollar Cove TI PMIC comes with a coulomb-counters with limited
> functionality which is intended to work together with an always on
> micro-controller monitoring it for fuel-gauge functionality.
>
> Most devices with the Dollar Cove TI PMIC have full-featured fuel-gauge
> functionality exposed through ACPI with the information coming from eithe=
r
> the embedded-controller or a separate full-featured full-gauge IC.
>
> But some designs lack this, add a battery-monitoring driver using the
> PMIC's coulomb-counter combined with the adc-battery-helper for capacity
> estimation for these designs.
>
> Register definitions were taken from kernel/drivers/platform/x86/dc_ti_cc=
.c
> from the Acer A1-840 Android kernel source-code archive named:
> "App. Guide_Acer_20151221_A_A.zip"
> which is distributed by Acer from the Acer A1-840 support page:
> https://www.acer.com/us-en/support/product-support/A1-840/downloads
>
> Signed-off-by: Hans de Goede <hansg@kernel.org>

Nice, looking good!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


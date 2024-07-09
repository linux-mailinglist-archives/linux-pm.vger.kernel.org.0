Return-Path: <linux-pm+bounces-10854-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1312A92B69C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 13:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EB428520F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 11:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCB9158A11;
	Tue,  9 Jul 2024 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="we/KRAhE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE4515886A
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523716; cv=none; b=nJsmf7gw4BUkT4aJvRVHZcwFLjsedZv9W6vRsqRQHinYNz9Ltr2G1/cyk5efmYkK1BPLE50uQkpfpYmRThhTuFkQ0/8q6p72ub3YW2wlBNmT7VCAAXlg7Udkbo3XHZHxhya/Y0Ju2rYC0vgv+9SXumIozr8AEvliSrZV0NkEfgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523716; c=relaxed/simple;
	bh=a1z9aXVH0jD/Ns99p9cnjXyxouNm3dQ2gvZ1e148jWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDMTyNr6OJlHLDJ1mc2sJKN744oPz+9uLidtC8mnEzmCFYwZwhm+K0uFtglF/n3P/9nP+i0n7jZV6wcEDwVWlM1NbMoyvwwAxLxa33pOXUog7mtkpqSxu94GZwpCmeR26JhdpsZ0pG78paCfcMOp74L4QTElk06RPHkX5h0ECRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=we/KRAhE; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-64789495923so42166117b3.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2024 04:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720523713; x=1721128513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JRnxn5kBog1S4c87fuPJ8CVw2ogmUFe7KoQqF9HGur4=;
        b=we/KRAhEuF/YgHgY85BnisOG1Vgur+POcRbi7uJp2gSTb357E6r4ZScnZ7UQv0vSNH
         ZvGD6gB8aJr1RbfSFQxCHEUbkksODOTT2LtW9mUGMV3g4BliEr2KwnffFYhya6q9PEje
         7acmZVnvudpRt5YTL3zsuOj8IBIofIPu3mXevczEEDgLozpYqn8eWMZE9S0ucDvXJO3w
         JsRsqcvelD6Nt/oZkzQB/svpQZeMvHFKav+Mxp0HOjzKjIWlTcWFALDBhY8Gyf9pVG5r
         DwYJm5G5ey7ZRfxVpexRxmZacjBUKNJrTiOuhXHLsZzluUtdegiIL3Dg6KLJ+yE4DDC9
         geuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720523713; x=1721128513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRnxn5kBog1S4c87fuPJ8CVw2ogmUFe7KoQqF9HGur4=;
        b=G9/wKQPseAreoxBJSD5pxw62ifJUFtywJIuf8j0nWdr0vng7JWs7vYF2sq76RyP/p1
         //ivc2CoxLXg3R8v8zsGIwEMuZWFcOFWi6bEiICBrtbeZxyVcPT2NOZZjVuywnNdubnc
         h6oSbJqQtDnXjclcPN/bZ9CzUo/x30P03md+9zfTBVTeDRU2PYwU9y6935fBjHPfNlvE
         jLYCafDvoIvgOznhNsmYxkt3aY7I5uy4NFnjDdUXksifb78TCh6fp+LyCC5ryQcvL07A
         yfMKQOS5qULUWKEplyrNokzAIRIHpT33+0ueXl6QEEFtGFSqDjLZ7aeYlpxFyV28Kcpp
         UJlw==
X-Forwarded-Encrypted: i=1; AJvYcCX136IkBDuqL5N2BzgvXqMaktQi88yarxW3mk1Kq2I/Bc3SvqHGA7GPtvmnd5FslKB86xOqlciMELQUXl0XEB9KeM98bCe6V+M=
X-Gm-Message-State: AOJu0Yz7JkNuUCtyjnLiJgAv/EIiNWD0uD1xR9+JDDNHKUGICNZq1cP6
	9B4KeXREr2+oogL+QBXkp7vJKfdwzgRlLsA0EbpN3CMcSo98TgrVuI34qk5v8O+ppKQjRHE1b2n
	bukO3Ijv1DaD0omhhhx3zDuZe9cknsuG2/aYo6A==
X-Google-Smtp-Source: AGHT+IHvO18cEkcdgxI9LdmOavq97SRmsNIECRYT+ECXAWD9UTP9pFQ6ZQOwH4TjXmRjZ21qPReOQ/XXVr1I24f4iJ4=
X-Received: by 2002:a05:690c:4b06:b0:62c:c684:b1e1 with SMTP id
 00721157ae682-658ef249fc6mr31666527b3.29.1720523712710; Tue, 09 Jul 2024
 04:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627-a5_secpower-v1-0-1f47dde1270c@amlogic.com>
In-Reply-To: <20240627-a5_secpower-v1-0-1f47dde1270c@amlogic.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 9 Jul 2024 13:14:37 +0200
Message-ID: <CAPDyKFrY6rL-aCo=GtmRBoJNBH=p3DteWWfBmWkFnWhpwHLnLA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Power: A5: add power domain driver
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Jianxin Pan <jianxin.pan@amlogic.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Hongyu Chen <hongyu.chen1@amlogic.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Jun 2024 at 13:47, Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> Add power controller driver support for Amlogic A5 SoC.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> Xianwei Zhao (3):
>       dt-bindings: power: add Amlogic A5 power domains
>       pmdomain: amlogic: Add support for A5 power domains controller
>       arm64: dts: amlogic: a5: add power domain controller node
>
>  .../bindings/power/amlogic,meson-sec-pwrc.yaml     |  1 +
>  arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        | 10 +++++++++
>  drivers/pmdomain/amlogic/meson-secure-pwrc.c       | 26 ++++++++++++++++++++++
>  include/dt-bindings/power/amlogic,a5-pwrc.h        | 21 +++++++++++++++++
>  4 files changed, 58 insertions(+)
> ---

Patch 1 and 2 applied for next (patch 1 is available at the immutable
dt branch too), thanks!

Kind regards
Uffe


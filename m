Return-Path: <linux-pm+bounces-26635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43084AA8ED8
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 11:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830993A6271
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 09:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422EA1E5219;
	Mon,  5 May 2025 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MlL7nBW/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF901DED40
	for <linux-pm@vger.kernel.org>; Mon,  5 May 2025 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435955; cv=none; b=PDdAvawul6BvLhSup9YIJPF/nSXwKeVDCtwe8MIzqLV9gk9kWscr3yXRL2nCb0PM/rvVUcfvpZna+mfO6XqIKa59prvtVtf80VaQjTkI7T7KfhMfLuo7w/g1zYe/sJ3w9z4Y0AZQdtGvVwTv4/Z9kIaIjAe9BL9N3MKp4bm3LSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435955; c=relaxed/simple;
	bh=jaVB3sx5ejThu8wEUg5nUqvMM3/yIkqZP4MpKH/Gvus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkZ9t8t5T8jxSjaXkomraYAB3sVW66l2S6St5waIMOMFT5sT9oYT8D+3Io+unnE1L/e67JdFf0IchKm0amwkynX/arTTtTg2NSJ0pcXV1umrigTaBfLVy8y4NKlqZ2NPBkltKPAKUFX9b9fuqsmx4erJBStINusqRSdiRK7gncE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MlL7nBW/; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5499659e669so4881141e87.3
        for <linux-pm@vger.kernel.org>; Mon, 05 May 2025 02:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746435951; x=1747040751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaVB3sx5ejThu8wEUg5nUqvMM3/yIkqZP4MpKH/Gvus=;
        b=MlL7nBW/px4/CIrOcDVdTNLRXOHn8yS4tkl8gahouAGayJGPJqKG7TovPRz6OZflQ7
         HrxkSxMMF2EGr29W1/2JgxnxPb/qX9uIb23pv7gXw8tqn0fB/SaqXK1Lp+p0Vk2xU23l
         LZZRy5uq+6LmDkYfAOtc4U3E8P4ZaMU0hFF6m9aX03TaP3+twc2rXMw+f83YhOABl0S3
         hB0EUgKimx8KloaODdiVeQ0hw9ejIGmwvHM23m4Jy6jqECJthkTg9Nq4OFj7UcJIREOw
         ZJUDneEhIBtERekDd9C4bih9FI56DBBCMu2BDfDBp9vbmYYAurypYzemB/N3Co+b9dlc
         +E7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746435951; x=1747040751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaVB3sx5ejThu8wEUg5nUqvMM3/yIkqZP4MpKH/Gvus=;
        b=e6M3TBQirx8GP0wzjCLkws0DgPAEOxTwcBkLBz6pidbG/DGPEBsk5WNvCyMWKX5zcZ
         OT1ld99wk1n6MWSsnzORG2ucqEPb66XENezag+XpTKTeOcpeLtKpEPRgSjx1uooxL3xf
         AW0aZsSNszdIr78DphK6BEy/V0HsUE2n6ZuvhefLdcSONehPyaJKAA3U1lMArfmvN2w3
         PlzPa6QelMkjatmonJr3Qy5sLksUhs0D30CKoY0nkHW4QbSRwJsBPC8u92V/u/EnaIQM
         Xj/6Re9tPOOjG55setunpR037mIWR553E0u2TYt1221NzNcNTtHpA58j7KLBkeE9qvXZ
         HfjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqO7c3w7KYVo9T+1AvZ6pGvuCCX3A8rML/XyldojArwf3G6OQqWzF19+vWmwfu/qMwrMI9e/mpZw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yynp41AZvpvRe8BMaYQq4L2T0EgFDwsIdC+X3YgnqBxgEz8DDF/
	rGmjZPyB7dUBt9AlDZRaY7tHOq4D8jQpSuahN1Vj+Gcb8U9ETnphOhh56M5OBvJoPzj9LfXGx2g
	zQFuWi90nl0bihLxM+s4BIvOioFPA31sbQRfVYg==
X-Gm-Gg: ASbGncs6C2fBx71RHhZbHhpCVTzP9IAjwCV05cmjysuOuuCNs38ETMb+2zm9SkdogTp
	YlR2mPjG1V1hDo3kRAOrPq2IEyHKWLT5U1GPJC66gDcO1FhPPHjDVJPeIgbM9NYMmKsxfLvu6in
	9qtVm0lU43X8Sui32rBzJdrw==
X-Google-Smtp-Source: AGHT+IG1Gg4cqaY2027Xkt9vszcojc1RUUWP69uzjNjCzPb0+lNxfxbfad5R/RgzScrc0f+PobFDAQA8A6a3BcrID1g=
X-Received: by 2002:a05:6512:118d:b0:54a:f76a:6f83 with SMTP id
 2adb3069b0e04-54eac200d31mr3042013e87.13.1746435951218; Mon, 05 May 2025
 02:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503-smc-6-15-v4-0-500b9b6546fc@svenpeter.dev> <20250503-smc-6-15-v4-1-500b9b6546fc@svenpeter.dev>
In-Reply-To: <20250503-smc-6-15-v4-1-500b9b6546fc@svenpeter.dev>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 May 2025 11:05:40 +0200
X-Gm-Features: ATxdqUG40K92Q6cLhA-jiK9adWrE64up9leFqXIiQtBvPLIG9_nqRk1Z9BFEJZw
Message-ID: <CACRpkdbCfUEZd06yeZTNecGFPwBgJkpMH3hqkvJw4J+iSENG=Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] dt-bindings: gpio: Add Apple Mac SMC GPIO block
To: sven@svenpeter.dev
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 3, 2025 at 12:07=E2=80=AFPM Sven Peter via B4 Relay
<devnull+sven.svenpeter.dev@kernel.org> wrote:

> From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
>
> Add the DT binding for the Apple Mac System Management Controller GPIOs.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

LGTM
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


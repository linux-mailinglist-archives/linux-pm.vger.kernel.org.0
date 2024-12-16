Return-Path: <linux-pm+bounces-19309-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2CA9F32F9
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 15:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5CEA16275D
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688B5206F09;
	Mon, 16 Dec 2024 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m17/HW5I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F636205E31
	for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358534; cv=none; b=XuzMLPdYme1plCF/eE1ZG5hOtNbjRdlT/NWxzf+ZKe+0E5AYub7pusJmm5annTp8RZoqvQT7fp3u6xHNJPfqBjOq78a6ixU2OQD34/JApaMlf2FdT0ZckMWQL29KQizJzBl34VGZsKOR8GW6MZSM+Io2ibnyeUR/oV0vZo3OkQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358534; c=relaxed/simple;
	bh=sTO6XsUM1EpoRAEqG+118QEinm0VU7febgtSY5QZvgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msPtNkZHziylaYe/ozy2NaX6aPQKRHSRumtJu2fl+x4B13aXVkZ11cS48A/MDTH9o9Z/atQ50q0H00bq501u3fjzZmsqq2XbR/HV/53WIjbP/4NynAPbm/Ym4yiQvgkkqKTvno6tql24Ku01B62NICMNObGdFZDmi2BH89tvFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m17/HW5I; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53f22fd6887so4301269e87.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 06:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734358530; x=1734963330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTO6XsUM1EpoRAEqG+118QEinm0VU7febgtSY5QZvgg=;
        b=m17/HW5IwrPEQZeBbryXELBTFih7Ga9IOKlDsoYGbyOiSwXbXVaqWz5exJYTrni2Xk
         umEvcaqQ1s66AnQFQdaLb0Qodv2+BGtJr6nnXwPl9T9RudE3PqfuKCvCSSEfr/WVezyB
         CCNYa7+OPtwYuKXg3Bbi+cUFghVUdPgTGACrOoTHow8JmRc2kM5D+mYE2pKpEPMhWrRy
         Y+7plP6et/zmWy8340E1pd6N8uPh7L6EZYTeG6sJOPBqqQ9VdChEmXw1pLxI9AEVtGcl
         P0a/MplRVZqPjXgm701/6wR7U4tD4zbpc4ecrs6gi9rj+yYU6b1fpyEGyuISAJ8/tq7x
         suDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734358530; x=1734963330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTO6XsUM1EpoRAEqG+118QEinm0VU7febgtSY5QZvgg=;
        b=RxcY50ieWE+QaWAJuHKGb3jjNh9XgKw4/8Jra45CYXkaRrwjTHtBwzaIr9CTbYvIE/
         z/U72s43qUkWurPF1PwxaHc0qny8+Q8IckmsP48AHbK/3pQAwzSM6sgqb6e7AcIEeSe2
         15XKs+4UjaDouy84N8rc3MOcR2PdJ5XnFF+qkvqVzUQV2ECkkPa6Z65jWqdb1OcQs8Ju
         P3m9CeQD0rDbQWYs+aZXrwkQP5H9Gptqp58zQnSHOK/GwXWCK+LwPiZI0qyxBqEqLiV+
         NkD3Ne2SIltvb7N4ZaAjZf39TpqBUPOgPZgbD0cd1L59/HhQ/1E+bX2MOk1VSturYATw
         uynQ==
X-Forwarded-Encrypted: i=1; AJvYcCU15WhtvU6iW4Dn09cQvdZ/IkaPHkOz3nk3aLICGuManRyFgzxLhRTEUYoH6/dDyLFNA0cpwcYZ8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvqRUT+yOSC7JohcSghD8fXz4RLwq4svjNMg1I+J5djSfXfkyG
	cHPrJoq8PrGmz+KuOwP48ghS+GdwxHg1j7kLenrCwR2iPMVhS7Rek90zqo0VGnaavofqTxy+1N5
	WSUUUB3f800s66nNXrnrSUZCxPOAyknp5Qlgx5g==
X-Gm-Gg: ASbGncvm5RjuNzU2iTqn02hWoafN0hCXXGmQPsJS0EiIq8oSUvLXppjNe6MjXryHDrl
	5por3hnL6rcr9OOUYd6GnC17537UWSVItOnZ9
X-Google-Smtp-Source: AGHT+IFSDin9hEAGn8eapDBqSokmqU+717wu2Ivl65JkmX77qI/TxAECHXYsu5Why+LBdm1Fd6dvz/dzpSuP0U1zgxo=
X-Received: by 2002:a05:6512:39d4:b0:540:2549:b6ca with SMTP id
 2adb3069b0e04-54099b71afamr3494300e87.55.1734358530311; Mon, 16 Dec 2024
 06:15:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org> <20241215-msm8917-v9-2-bacaa26f3eef@mainlining.org>
In-Reply-To: <20241215-msm8917-v9-2-bacaa26f3eef@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 16 Dec 2024 15:15:19 +0100
Message-ID: <CACRpkdbNKqOmsO=Bownp9HNs=tZfiR5rO95G50oJTo_jnusoAQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/8] dt-bindings: pinctrl: qcom: Add MSM8917 pinctrl
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 12:15=E2=80=AFPM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:

> Add device tree bindings documentation for Qualcomm MSM8917
> pinctrl driver.
>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>

Patch applied to the pinctrl tree.

Yours,
Linus Walleij


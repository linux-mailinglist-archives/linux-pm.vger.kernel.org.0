Return-Path: <linux-pm+bounces-17185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A299C176E
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 09:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDAEF1F231B3
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 08:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858A71D1731;
	Fri,  8 Nov 2024 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BF77jXdG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80851D07BE
	for <linux-pm@vger.kernel.org>; Fri,  8 Nov 2024 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053217; cv=none; b=P4ICoUn4Lyg5hZHCR13W0Ct1iA6lWPugrxeMqj5LWQum+jbDAC6zGe80R4oeptI1pg1hC43LY5bA0QYCEe2dhSfk7Jv18ufhVV5B7HV0qYX0wmTpYAgETiCosBjuL8qecXcr0yYEyArcfUC2nWlQfwX+/SqNb9wt97eVM3qX/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053217; c=relaxed/simple;
	bh=FcZP0o3PSmNumtKGO1ItgMWJ55M55pvygKyoPpk9axQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjC7XDzZ+Zb2FBtphtEqHnlQOIW5u/8zF0roapxtM3PLh/L0gXfsDgMsXdKJnYMU2B1uqeYUuVQgZC4ZJSNBEk1n0ZXbjnDA4LvEzcJgF9o049JnXzMlksJm27ZuqbTz6O2pcdRglKN1eitE25/N4+GgOdAc1N+vKAFO9rVCl1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BF77jXdG; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb5a9c7420so17735941fa.3
        for <linux-pm@vger.kernel.org>; Fri, 08 Nov 2024 00:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731053214; x=1731658014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcZP0o3PSmNumtKGO1ItgMWJ55M55pvygKyoPpk9axQ=;
        b=BF77jXdGM/E9hr4mO5nKkSms4Fo94BCnH2IZz7/p0h4MF18Kv0nxEegISeyKDw7o1e
         Px9JaeACwPK/hU10///qDmXOabcUQKJbgAHup6FkEGbFbVACyIhtoZPkYeq4R0giPfXs
         JSm+Ez3QRd8ewauj0TaHjFZwWQ6EpXCB8hypXkHF7P5nnQIrmNENdwUSUM/yGMBqwovN
         SYSXMA47nizkDYcW8JawnqYnUt1lH/mmVKvuvK7zkdxE+XpiX55qs7avtCy2MKD4BKn5
         4sQxG4r0Eit+MGdin/EgEhjQXwEHa/2dsfElz4KuRv4ZJhoN8+rlHSTFhCc4i/6TzA3C
         qFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731053214; x=1731658014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcZP0o3PSmNumtKGO1ItgMWJ55M55pvygKyoPpk9axQ=;
        b=Gf7QLhPBacW9XCCfkHNXySOafGeYjICvoJZl136QAoXZpBuLnn3V+psCfZffro1+V9
         L8qxE3LAlmp58bi0Sv9y8nZk/P30gQbvD1EqCVSq/gItNtO1E8Iec4zNP1/KC5MEZVWl
         dI6ltNQ/HxuEiRiQCZ7Yv+glSaU0jl62m+8A2uZ+zZZzqP7+BWOMnunsqpcixMvEI+Jj
         l8zTkMSq11maB3k8/jVpGvk0mhrpViBkdWkvu4eZi+bO+5ThCMN6jgjjXiVmdonGg06q
         J4OfkK5RiHGm94sfE7Zh/t3VOvSZxSaut0h6+tEUnv+vRzaeN5EuEI3Pygfh0Z/GPANV
         MAHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrkfdkpshz97sNWDoi70yBJ/R6OO/K02LyQmJKuPQCd0P28YI2ATIca28HwYGfXOA0ny7JYbbDIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7jJ8BsA1s68q5yofUO8/WzbM9ahiLsvBm1s4gpepu5p9tN5vk
	dQtckUrIyMY/8Q49HhSFuBTTJ30HPY3CYO9ykoRi6KcfCr7sXiWZ/Xg7tDe1VL1GnTBGUrDodSf
	Mi9bSTNV3yQ1SFBtGE90Bhtv5ieAe/GuRn8M6rA==
X-Google-Smtp-Source: AGHT+IHwi4PwmyQyG/lANiqFNPWg55NWKh714pI2y79atgBsJL4Lz22ORZxxpFfE7bWCRIAG4Z7yTBnCOgDUxjCiJmo=
X-Received: by 2002:a05:651c:991:b0:2fa:c4d4:ec44 with SMTP id
 38308e7fff4ca-2ff202230e0mr9679541fa.28.1731053213879; Fri, 08 Nov 2024
 00:06:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org> <20241031-msm8917-v2-1-8a075faa89b1@mainlining.org>
In-Reply-To: <20241031-msm8917-v2-1-8a075faa89b1@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 09:06:42 +0100
Message-ID: <CACRpkdbtNomOHe=Jd+0Xfm1sr9=DzvGSy6uS7jxZm4Mri8Bb3A@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] dt-bindings: pinctrl: qcom,pmic-gpio: add PM8937
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 2:19=E2=80=AFAM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:

> Document the 8 GPIOs found on PM8937. It has holes on
> 3,4 and 6 pins.
>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>

Patch applied for v6.13.

(So we cut the patch pile and you will not have to reiterate this once you
rebase your work on v6.13-rc1...)

Yours,
Linus Walleij


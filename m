Return-Path: <linux-pm+bounces-19310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2875D9F32FA
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 15:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3845B167516
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E8C2066E0;
	Mon, 16 Dec 2024 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0ITHNvc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B06206292
	for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358575; cv=none; b=WsLb5vZtuwaU4Sugcr85TGAijbdZ9fi01wR0j3qMLsTJhDys257G75849l2YpPlJY2w8yqhFc0HgVoUjFVg9ivRdk1Bzg3XiQlRqIBWB0vs5nc6Kdd/0c2TK8GbvvLQ4Vb3XVSLJFJnPeFBjWk8Ehkm9ILo9U+Ro7JN2dOCCC/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358575; c=relaxed/simple;
	bh=9F8Sq5ILmO/gzqNtjAPdIn6tThxcdWj/OBrH8RrPyDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsoFjjEEMKzKhO7HA5BGuSc+bFNvUluusCYDx+D/uGYFCt7o6is67VoU0TC+TB/cRKcilMJD+5US8Noxv3lWOw6veByYN2puCivfKKRqdKrVy/RvEo+mFuckW3ObOdDP3zOJDQvvqSkjL/E6d/dY4xpy6Lk9eqg2cI27oZdWI00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s0ITHNvc; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53e384e3481so3857437e87.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 06:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734358571; x=1734963371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9F8Sq5ILmO/gzqNtjAPdIn6tThxcdWj/OBrH8RrPyDg=;
        b=s0ITHNvcy7ZbVHfgZ+/hNGxetKPcYSjLKyHRGOuHA13RJc71cAxaZ4fbJQt13+KR0f
         wqh1cnMA6Yn71bzZ+xcZw9sVOXiCmL3SNsb0cDNTEJABuy1Qu5RxwdE0TRlUHLPa0oeC
         d1hb2FJO4GoRmucnFRvZf69+k4+nHBksgHOO/RYuJ2tIlmac9dbX5giGWT0TU+4zRfVm
         qmSu93fa/vcKeIWse9V3l/HpBEitGOjz2TFX3mb/35l6oPVCHbaMgFYKxWTwpiA1nDD+
         NRcZv6lqWpb1OtsgFtF+5+pQfHAkmHci0Uu/cK9TGyPhpiicg2m/v88pwg7YGSdZRmQl
         ROdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734358571; x=1734963371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F8Sq5ILmO/gzqNtjAPdIn6tThxcdWj/OBrH8RrPyDg=;
        b=JoqEq5j77tModNEQowkSXVNM/McM3Wbxj5B5cu4mAZJ1lRm2Q2q9OWQD7CkTxZwCsa
         LC/dQfUYOlk8lkh3kCEd5ROxdtRAgCMlqh2STOJzBCnLgbtdE7hM3IMGUYyxiC3pbrXl
         jerl83QrcYT3Q6HZvGYLo/JDYRGcLEPtm8HbzvZ7BArcNziUkPj66MwErlA61GrhB/oD
         9F/jI70e5bu9FiuWfdFTguECLbfAEOtAA0YI329LNFaE/rd4vxTVXLehPohbf3GsfKPt
         3Wkd2KLP3QHmws1f5gI27p5pJbOnawhrNFUsx6OVPjbhUMiR+BMTsXkaHH9JQD3K0vFW
         2yjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJpdyjI1YPxTtpobEbCoV80vXqFL+iz5AsHG1cF28VBYO0486qboByR2VViaOCX4E0Em900B1Kvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx80EC2dVAh9AKm3EaWk9cZz/3sHcx52OPwvou4zAvnRTS4OfZ8
	ByPu6TgS4MTRWcsk8PNfzCgS6QUd0TRxa/syZDdShmv5UC1gDFlp1Xq5QhDEEd4tke/NURYpk5e
	tVHiV4f5JcAsAslWxVWAOCPGmNIgMHyaG/LxUJQ==
X-Gm-Gg: ASbGncvE8FN2lAR3+9E3lod4YzDr9Ujb8NXVnnkQ9VdoVOjtleOaWQVVT8rWgvZzqqf
	lLM1HVJsbqAPYTY8XocfeU65+Wkh477Hv7kUL
X-Google-Smtp-Source: AGHT+IHrQd48Xs7QoUHIoEZ8phO8rM8S7YX0SBFWBJmTRPojYCc8OVEoWykulhJ01DH0iWUq+AcjAkdRGx/EZIl7tsM=
X-Received: by 2002:a05:6512:318b:b0:53e:3a79:1ad2 with SMTP id
 2adb3069b0e04-540917cb6a0mr4002662e87.40.1734358571463; Mon, 16 Dec 2024
 06:16:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org> <20241215-msm8917-v9-3-bacaa26f3eef@mainlining.org>
In-Reply-To: <20241215-msm8917-v9-3-bacaa26f3eef@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 16 Dec 2024 15:16:00 +0100
Message-ID: <CACRpkdbKrf=AXGT1PmjQ6=HFKZ-8qCy7eG6fQ2NVUUK3gJoVTw@mail.gmail.com>
Subject: Re: [PATCH v9 3/8] pinctrl: qcom: Add MSM8917 tlmm pinctrl driver
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
	=?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 12:15=E2=80=AFPM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:

> From: Otto Pfl=C3=BCger <otto.pflueger@abscue.de>
>
> It is based on MSM8916 driver with the pinctrl definitions from
> Qualcomm's downstream MSM8917 driver.
>
> Signed-off-by: Otto Pfl=C3=BCger <otto.pflueger@abscue.de>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>

Patch applied to the pinctrl tree.

Yours,
Linus Walleij


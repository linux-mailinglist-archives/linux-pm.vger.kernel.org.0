Return-Path: <linux-pm+bounces-30794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91429B03EBD
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 14:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3885173F98
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 12:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A9A24A046;
	Mon, 14 Jul 2025 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="3gZln2wO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E1248893
	for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2025 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496345; cv=none; b=KsPnNclesatOdvJFmCjC6SoYn+xa4ioAuetVUt3ut069XIKW8jjuT+GWVQLIOWsSNJnxGJ4TPTFDrkpl38yYyUqAdkMjrrnQS2gi5tX8KcSMhWihgRY7twIoTbGrOKWCmBOZWijT/6AGoKEr5O5kHOmjtlNVc/DzNneMClH7lmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496345; c=relaxed/simple;
	bh=qYiuoKRE2NxLGDxKz6WhuSPkGY9D7Tn+i7spILVLy8k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ru1K16ZMYxUbzFOGDNKn4IM3J1Gjq/KGAo4C/ZRHWl8mBKwq46WX2XUmmQ/1RPdfeRSrMQxuMSJQsQziC7jqR8ANQSF3ycrRbN1E6niJ9BXOOVRIuRV/7P0LzLLj/uw+gEHgX7FLPRUeJnb3vSiqW+88+zKTWFVhWLs5JI0+SbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=3gZln2wO; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so869431066b.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2025 05:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752496342; x=1753101142; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GT+QfWaXLUz2plhdm6tzk3KnJrg30pcNVb5s5dMBoo=;
        b=3gZln2wOOI7lo/l7dUww2B9kfi7qpXoKtRHky3EZuBYaRsEKbOD1gxKJ+KOzRTwEGw
         uxqeWFJP1S5LlA2+tHfxdWvH8VfMPVHseW865DX3UmLf61AuVZn/TIlDyy/1c5JLB0VK
         V7cSSNyVjqSxLe+VUJ1PuTTjdyUk6OwAP9lHdnuay1znB9Tk+s/GtHQSni4pzoYhby/v
         FFmAE3/lcu0FaNBdZoBtx7sLc+LJM7p/jGcd+OQ14e8Vfx5i4zVmY5CzPhNH73URBNCx
         LdXSO6WSC/CfdWtBxpd/t9WSmpmQvKz5kcOhNzBFCeQf4gVjRBa/lJS0zKqj9GOR73X4
         Lz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752496342; x=1753101142;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6GT+QfWaXLUz2plhdm6tzk3KnJrg30pcNVb5s5dMBoo=;
        b=dMAl9uo2V75t+wz6w90AIlRFWzEy9bhmCSrwe5RC00PhjDlcU+uYeGOoLVCUBP1dMR
         ndwBJxnIpMK3DflMHPUHFmKTfeIsWlSZKZVDjd68kAMWG56vLTUORi4ErLt2DC2Qv50M
         3qRX6a9nBAWmS9nkQ4+cdpDXcCankiz4VXVtr5k9OVVF6w3jjOkQtJMoiLspOv9VhfUi
         99e1xlzv4yxgJdr4DCrPQ1AW6d79EawvoEm6vg4umr9drs5jJ5ZurxTA293n/Ipc1qm0
         fiSEIGo4n+Hgph5KxQUhrBSmbw3vDyQfg6R4NGaPT18WcLCXdgMtP94EfV9aKSGurnI5
         Aw9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSJYP1rS3zsiVugtZFi8oW1HdL9zsaj33MqKQ8WcvsJwHNkNtGme2NSb3w/YHuMovSYdzp7yKHEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRamDC8TXcoamQ37+yvzeVBipHXe25XpzLR9jdaZygSa2LlbP+
	TgOWWe6ILxXgD1fVcpZYfpZXnbMS4nuD1yVRrKPehl53bRfbiBOUgki5Nf3otuz1DFM=
X-Gm-Gg: ASbGncvuPJKzphOLbP/9r06MCASY8M3oiD0jjfZAd+EnGthGxBVIK0XP7K3dUMdUBdI
	pDg4t8js3m9giB9ZS26RwlOO7z5c8vnC0I+IBfAgykinKCA5a03KOv8m5mxB2hbMigdVMsDlXKz
	sMACInxfvwCuiafKAq9n3evud+5lGQ6+zjF+iYsFe22ji6BKtdxDxEf2VCSRToaKGoh/9VzWI9X
	K3B05/wGaZTRobSI8St1GaONihFdaHly2abDHjh2i2lzvdf6hsSKpJXAgEA6pi9GHJvTA7TAhpN
	NWJlCEL80Ux3t9XrNmMJ3O+9ytmyAVgCvMdawTbsftsOYVh/k8m1pVrcbZJOCdAlSEOX38ICFF5
	+Mu97RmafTquWUQJl+FEB9/gz5COnWABy0Q11KaSNXTWaliok+3sDQApWUrByO6s0d+6l/8cEPd
	G+RPNtzoyLi1p1viQVIRoaGP4RZeP3DXZGwg==
X-Google-Smtp-Source: AGHT+IEdIUlKAIUoH3odRS/w1x3zJL/78SxmRMa+QOLnmU3zwNSH9f5FMxlA1f2U3nn/eb6t4vkm0Q==
X-Received: by 2002:a17:906:7956:b0:ae3:cd73:e95a with SMTP id a640c23a62f3a-ae6fcbc356cmr1271518666b.36.1752496341821;
        Mon, 14 Jul 2025 05:32:21 -0700 (PDT)
Received: from localhost (2a02-8388-6584-6400-d322-7350-96d2-429d.cable.dynamic.v6.surfer.at. [2a02:8388:6584:6400:d322:7350:96d2:429d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82962acsm818540766b.139.2025.07.14.05.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 05:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 14:32:19 +0200
Message-Id: <DBBS3S38CWTN.32RLYB9VEZAB@fairphone.com>
Subject: Re: [PATCH v2 15/15] arm64: dts: qcom: Add The Fairphone (Gen. 6)
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Will Deacon"
 <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>, "Joerg Roedel"
 <joro@8bytes.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Vinod Koul" <vkoul@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Robert Marko"
 <robimarko@gmail.com>, "Das Srinagesh" <quic_gurus@quicinc.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Jassi Brar" <jassisinghbrar@gmail.com>,
 "Amit Kucheria" <amitk@kernel.org>, "Thara Gopinath"
 <thara.gopinath@gmail.com>, "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
 "Ulf Hansson" <ulf.hansson@linaro.org>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-15-e8f9a789505b@fairphone.com>
 <6f8b86c7-96a5-4c7c-b54e-25b173084d95@oss.qualcomm.com>
In-Reply-To: <6f8b86c7-96a5-4c7c-b54e-25b173084d95@oss.qualcomm.com>

On Mon Jul 14, 2025 at 2:19 PM CEST, Konrad Dybcio wrote:
> On 7/13/25 10:05 AM, Luca Weiss wrote:
>> Add a devicetree for The Fairphone (Gen. 6) smartphone, which is based
>> on the Milos/SM7635 SoC.
>>=20
>> Supported functionality as of this initial submission:
>> * Debug UART
>> * Regulators (PM7550, PM8550VS, PMR735B, PM8008)
>> * Remoteprocs (ADSP, CDSP, MPSS, WPSS)
>> * Power Button, Volume Keys, Switch
>> * Display (using simple-framebuffer)
>> * PMIC-GLINK (Charger, Fuel gauge, USB-C mode switching)
>> * Camera flash/torch LED
>> * SD card
>> * USB
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>
> [...]
>
>> +	reserved-memory {
>> +		/*
>> +		 * ABL is powering down display and controller if this node is
>> +		 * not named exactly "splash_region".
>> +		 */
>> +		splash_region@e3940000 {
>
> Was it not possible to arrange for a fw update after all?

I've made a patch to support both 'splash' and 'splash-region' but not
sure when it's going to be included, I've sent the patch to the correct
people internally last week. Since Android build cycles are always super
slow, it'll take a the very least a month I guess.

>
> fwiw the rest looks good

Thanks!

Regards
Luca

>
> Konrad



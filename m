Return-Path: <linux-pm+bounces-30249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EEFAFAE29
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179D03A8CB3
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 08:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3011B28A72A;
	Mon,  7 Jul 2025 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OrAeMbWM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516E228A40D
	for <linux-pm@vger.kernel.org>; Mon,  7 Jul 2025 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875460; cv=none; b=kGnEpZZ0bxXpsDw0chVvgaGKDJXmfFh7vM8Yj8jhWlcKmqCTkzsdxpXtXJZsGPX0pT1tjrtygzq39HXApWclxdp7Xwon5/qUASX/9bElgLs3hIafs0kduSqvXtdHGY9EFc9k8N3umTHs8ks8OYkutVKUhgIm/+hKskRJpV/gGuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875460; c=relaxed/simple;
	bh=IEoYgZVPqV6REtyvNEYkqmdU4AlOYV3bBv9n+zrtW+0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GPuZ2zMOLbpcEvcSC2+wfAsL5rz7V4B/Z38HcXbEMzbrh+yDp4Qjx3SbUpVlPDg0KQMXRIj/j75bvKtak+cviBPMFbAL2RaMWWJUVFMDbbHFJOut1v83WerzAt9DHNlik1W+zmwbnFOdv7zA9R4h9HI56R4Nvb/72+0P+OAZcKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OrAeMbWM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a5257748e1so2263381f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Jul 2025 01:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751875457; x=1752480257; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IEoYgZVPqV6REtyvNEYkqmdU4AlOYV3bBv9n+zrtW+0=;
        b=OrAeMbWMGSqIdFhUjy2qNfv5YBKOfuqvgNPSGBqk9aclu0IZgqRwttTG3akD7TAlst
         Dr5vjqlBcG8iOK4ZN9kQdgO4ShCmi2l1UBC4Tq9UWqGgHsu0p5ysxA+9Rlov7EXp1QdR
         4CYbcr+MD9/bdV6BagNrbqx7CTKPA0V8mlIT6FmTTMaJjJ9jSxSMH0plhbJH+rfDxIg2
         2Ze63+yXKmr991n7Z6jHYBientUxswE8D0AYyPNPpbZ37lPiOCYFzIWmMPVQKhw+ojAM
         kJzuyeSna28MRFSTRuIEnSR22BtxHG7bH9mx1pi7qckY50/UzjDA7bhQcpwAWLonaBOb
         0ikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751875457; x=1752480257;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IEoYgZVPqV6REtyvNEYkqmdU4AlOYV3bBv9n+zrtW+0=;
        b=va+BT6WaBuEh5oQxJ+sFwFdK/3KSUSbgMjTqCJW3KuTa91RUW57W16QxxA9Aj2EgUG
         uobkupIUK2UgmjCS28FHTLrVTfs6nGizlGHVCTY5ZJg+g+NuO4rcfvwJ0w8rCL7ARBJI
         f6q1qFWSwDhdDLjWg92W50hKazTa0aq6ye9yxCScMgwkroWTVmTUILRV39mgSQy57f+w
         BmXDDN3CROeccoJzbJCFGFFp/jBinYUZl7rEslRsZNHYEsvRuxoc3hKpvcuqW10CT2k7
         GnIWetVZ0juXPkWMiJ3s9nkfLdt94biUSPOGWp8mpWVfNbvhS5S6Tg1xKjfqXxKXBgt9
         CeVw==
X-Forwarded-Encrypted: i=1; AJvYcCUMiX/SaVo4HP9kmDbfqUcyR8yHuo0wEqAU+Wx00dSH8pGmDx5Ruu7NgfUVhjRwcquh62IP3c0T0w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Dm3yjIm65jtZ32Xb1Ij/GSsaa7FuwtEhVBVWZUk2zDECp/E9
	ozullM5s+hMqIa78n4dDlaJctiC9AXX/3IZCH4DqaXErOG3GKVjWVAaiMEvQhB+/wHI=
X-Gm-Gg: ASbGncv3MB3cU8PUmm1z9g3oN35NnSy9GS18Yc+o3HDRCfKsnv4kjA1kOn4K5A4cEb/
	5XO38osbdVrauJcmfVnEsCwOk3WiJg5VAju2GjEqeLe5cQVPOmRv7DqVPUXbxqolEy+jZlAqctq
	QMehxs5jOgju4V7blgq7HWIedPlXZWq0dsVgdKTVXe912hI9S8WxvqGsqcbDJM50Ij4jYiPFomF
	oDlsmvvCcLj0yGyN/FOQMXtYWLBoRD+++iiUhXvjEneqGOEne2f99AAZQF5CnjO7ytXfrH3AAiu
	9QaP0+PvLfVXbgGvFOqJjUHbOHgtf8oFYWj03D+MZ24+UD4rh2kizqJhATE325QONg==
X-Google-Smtp-Source: AGHT+IHEIeX1O24CgOzuWsNBfkxeH6TOmmWEVLZJcsdlbgvxYrZII56COdsRCTeJJ4eyH1AmqDGCWg==
X-Received: by 2002:a5d:64e5:0:b0:3a4:e609:dc63 with SMTP id ffacd0b85a97d-3b49701fd14mr7926081f8f.20.1751875456566;
        Mon, 07 Jul 2025 01:04:16 -0700 (PDT)
Received: from [10.1.1.59] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1698f54sm103519225e9.33.2025.07.07.01.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 01:04:16 -0700 (PDT)
Message-ID: <2e26f8f534284b280e9d5e8d4ae556a452e93ff5.camel@linaro.org>
Subject: Re: [PATCH v4 2/5] power: supply: add support for max77759 fuel
 gauge
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Thomas Antoine
	 <t.antoine@uclouvain.be>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dimitri Fedrau	 <dima.fedrau@gmail.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon	 <will@kernel.org>, Tudor
 Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar	 <alim.akhtar@samsung.com>,
 linux-pm@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
Date: Mon, 07 Jul 2025 09:04:14 +0100
In-Reply-To: <CADrjBPo2=FajKA0t7TTMdH6iK_qbWCSJK-hEqh+UWEuzC7wyGQ@mail.gmail.com>
References: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be>
	 <20250523-b4-gs101_max77759_fg-v4-2-b49904e35a34@uclouvain.be>
	 <CADrjBPqOMOyHP=aQ1+fg2X58NWRp-=MJBRZfpbEhQsTzaZ9LHw@mail.gmail.com>
	 <bc40326f-db40-4657-84a7-152def2ca9e3@uclouvain.be>
	 <CADrjBPo2=FajKA0t7TTMdH6iK_qbWCSJK-hEqh+UWEuzC7wyGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+build1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Mon, 2025-07-07 at 08:16 +0100, Peter Griffin wrote:
> Hi Thomas,
>=20
> On Tue, 24 Jun 2025 at 16:45, Thomas Antoine <t.antoine@uclouvain.be> wro=
te:
>=20
> > I am unsure about what to do about this initalization, especially for v=
alues
> > which slightly differ from the devicetree. I think for next version, I
> > will have the same parameters be passed in the devicetree like android.
>=20
> We don't really pass register values like the downstream driver is
> doing in the device tree. I think you will likely need to add a
> max77759-gs101-oriole compatible to the driver and then have the
> application specific values, and m5 gauge model algorithm as static
> info in the driver applied from the dedicated compatible. It would
> also be worth checking whether any more of those register values can
> be represented by the standard power-supply binding properties that
> already exist.

I believe these are likely battery specific values, and were obtained durin=
g
battery characterization by the vendor (or Maxim). They can change (with a
different battery supplier etc, hence I don't think basing this on a
max77759-gs101-oriole would be correct here.

As we learned from the Pixel 6a battery updates, the same phone may use
batteries (e.g. from different suppliers).

Either it needs to know about the specific battery model, or the values
should be passed from DT in some way.

Cheers,
Andre'


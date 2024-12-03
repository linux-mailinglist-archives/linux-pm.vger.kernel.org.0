Return-Path: <linux-pm+bounces-18435-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED2A9E18D1
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 11:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AA0280E9D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 10:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5E51E0B87;
	Tue,  3 Dec 2024 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCwMQb0S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC81E0B6F
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220448; cv=none; b=nlp5Ak/srsbKYmWP6TGPYF2fdtHXsh+vyeARHG/Nr5/uyCdmNO4Ep/6DZ4YMxVH8V/+kTEazudXK+1sjWwakGaQrqZnVGhZ9HZrc0JCGcHh5BBpWElHzfRYPjC6gwInIGbRGs1H/mHsPdeYEQ5p1chbnoq+url0BqvcV+lqfrK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220448; c=relaxed/simple;
	bh=rDhrWjqsitQOm02p1yx3Crr6aSKeDzrUUQOFa0Mc4Mk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qLWJ5jNYUq4XPvo+GF5vpWbG5MaS+QwOr18m/geBfRKQkk1XAcmqlWBvgSUSYXWtlFTH/X4RWKUbds1wGaA1Uv3pmOVs/J9eD2yi49kQ7Zx6/JsuoS+21eAUsj/MFRDLNm7LKmm8hR+Q0/+503WZfZwvZ2TvHyUA9fY2uWfirCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vCwMQb0S; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434acf1f9abso48828775e9.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2024 02:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733220445; x=1733825245; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rDhrWjqsitQOm02p1yx3Crr6aSKeDzrUUQOFa0Mc4Mk=;
        b=vCwMQb0SpDy6GVSKib02Jg57j7HApfpkqcfpQS/BnOjiGD1ZCy9h4w3Thg3lFz5yzT
         WgrawZDKABwPc0125SnoRrjb0be25/+d4vBzHHMswGAhraylixSKGley+BADQ9f5l78g
         /OMn7BvXNx5kwNCub+dOGTxz383LRO9rKHt6sQAyvam5g+j9p9WDIR/lkcWFwWKXj85Q
         eKODLwywcm/r0oTnochlw0Ly9EbNhzKTKG4Z0R2f8W5pAyXsCNl4PYQzDCR7Yh2QriH1
         HULh2sPg6Zts1OCcopPRSW867orysHWB6sa7IIEzzZJKJUa/FTYUxY+rh0EQgzubUHX0
         loKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733220445; x=1733825245;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rDhrWjqsitQOm02p1yx3Crr6aSKeDzrUUQOFa0Mc4Mk=;
        b=fRuZvbxWjRwJBOlZM1peZvZC4WT9mbmc1lFP0ASzLme5a5l0GkAK7Hp6F6EOD2Hg8h
         6IGWwIqZHSInGsktvKYW0kIr5jk1tiQGod+Z7PhLsTQbKl1f2r5gugA23+IQMWCyDtxx
         FcPmSJqe7PhmRXHH0r64blke8WvjPLXvRp0JCpr37Rl0F13hO3dy2ZLireiPOvFWsU1e
         YYOZlp4PJfPeaEhhNwiqTGPCkQo+72uhn1ALiZ5M50TPcHi9YByVW9M6VtqxTNsp/TGB
         n535PPf1jy4j+ssowze0bkIYOs1LBPwKoduJSznuyzVsPq+MOcYaw3mtNbtupqExLbRW
         X40A==
X-Gm-Message-State: AOJu0YzcR4WODbE/0IMKW337qXWLya+J3CaDSxdQf3UIUyI271559tu1
	uqod1j7GqSIhKztCiT5DZ9Z2rP+HU4mlxIzL3G0EBXhtiRSdh3diETp9NEA8rkI=
X-Gm-Gg: ASbGncuAW693L764hFzB5mvykbWTqXXhbz1Qo8apQ3tsTamSU7T5m1/SkZHaeUWqny6
	qc7zYXOK+Qm3vl7CbwrNQ0zqasy9Tg1wgVMAom3LsRIN4bMDt4S4LVXrYwZXMezUkIFNARtPa01
	rkBcGuEKNAoSzysvoHc3PljZzz478SkaPp93YOIbpcKNP3lD62dOAIBJU/z0NhFfDvotHGVp9Tn
	qUsXsm36kQRF8BhkR+4ndLopgyMnqC1dd+hx5jgzlOp0Q0Cw+32Dto=
X-Google-Smtp-Source: AGHT+IEX3CBzUR11qB9xMFFVxV7orqiKJB6nzE3kEEtb8duUyFuW0fDSGHNnay9m/wWpgm8QQt4SVg==
X-Received: by 2002:a05:600c:1f8e:b0:434:9efd:26b0 with SMTP id 5b1f17b1804b1-434d09c0c12mr16633575e9.13.1733220445220;
        Tue, 03 Dec 2024 02:07:25 -0800 (PST)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e5b9csm215194865e9.43.2024.12.03.02.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:07:24 -0800 (PST)
Message-ID: <b311b50e0f54959cd8dac1ef21dd798dd6204331.camel@linaro.org>
Subject: Re: [PATCH 2/4] dt-bindings: power: supply: add max77759-fg flavor
 and don't require nvme address
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Thomas Antoine <t.antoine@uclouvain.be>, Sebastian Reichel
 <sre@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Dimitri Fedrau
 <dima.fedrau@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>,  Peter Griffin <peter.griffin@linaro.org>, Alim
 Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Date: Tue, 03 Dec 2024 10:07:23 +0000
In-Reply-To: <20588923-a660-49fe-8efb-766bee22f215@uclouvain.be>
References: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
	 <20241202-b4-gs101_max77759_fg-v1-2-98d2fa7bfe30@uclouvain.be>
	 <fe254a002000f2bbfbe51d074cf28f7427a27f9a.camel@linaro.org>
	 <20588923-a660-49fe-8efb-766bee22f215@uclouvain.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-03 at 10:32 +0100, Thomas Antoine wrote:
> On 12/3/24 07:57, Andr=C3=A9 Draszik wrote:
> > On Mon, 2024-12-02 at 14:07 +0100, Thomas Antoine via B4 Relay wrote:
> > > From: Thomas Antoine <t.antoine@uclouvain.be>
> > >=20
> > > As the Maxim max77759 fuel gauge has no non-volatile memory slave add=
ress,
> > > make it non-obligatory. Except for this, the max77759 seems to behave=
 the
> > > same as the max1720x.
> >=20
> > It also needs an interrupt line, and the previously mentioned shunt-
> > resistor-micro-ohms, and probably a power supply.
>=20
> I will try to add the interrupt line for v2. About the power supply, I
> didn't see anything about it in the devicetree from Google. Even it
> there is one, I guess it would be a single power supply for the whole
> max77759, not just the fuel gauge. Wouldn't it be more logical to have an
> mfd which activates the supply when other functions of the max77759 have
> been implemented?

I've looked it up now and for power supply nothing indeed seems necessary.


Cheers,
Andre'



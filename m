Return-Path: <linux-pm+bounces-40211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1202CF4B68
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 17:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DFB7300A9A8
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 16:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287D933D6C7;
	Mon,  5 Jan 2026 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kzkj8ilV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2BE33D6E6
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630880; cv=none; b=DqY+akyWBX7qfFy491kFTNieMi9CcAsIUSyjxje4sV8IxVOCk8tY+OOs8SMUQVIyj/7yHdyRuSSHc5ipUhbb2vqsSOhepYbmTwbsIqt5OBNT2eVf3AEKM9W/SGZUe9Yj3RHgux3OcdcvfVnCr2/vrsGNeaMe5AeaNRduN+h595E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630880; c=relaxed/simple;
	bh=fonikX7z7K1ohHQZl6vZ41UkDK6dK2RBIq07hZiimXM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jufqm8QI6B+uK0i+B6pqwB0E3E4bUl4wRtSPyqQFMliLPqliBR7Gdr5h3sqLQBKdn3appqFrHAsADgzgcXWJwgmbuA5EOFgL6Jumv0CFAMoqretYJrwiPc4AjpDqSv29jbH9VZlKRIqC5U8JVtkAh/RMKVRPzVILfnOFOP5TAXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kzkj8ilV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64ba74e6892so109561a12.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 08:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767630876; x=1768235676; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fonikX7z7K1ohHQZl6vZ41UkDK6dK2RBIq07hZiimXM=;
        b=Kzkj8ilVNzMJFRW1nbm2QkX1jFeSKl5WkENFpQPkTe6EfrRyB4/2A5M3hGGHB8uyNm
         RVnxTbxgCEXDZthOXFVd/ohUQ8eH/gvIbNkjERHjJgVCBoEoLZrfj8SH4U9/2OuUBiHG
         lycvPdYAIjkB4nBjVEUMDHuD/wQMijclKtxYmSHkIbWPYRKGichS5cMGSmeCGMiHA4jS
         GyDuZXVdd6ZzjRVHA4VqYbib0xmmABB3FDdbgKEG24kM3ewUXFg+Ui+LC3XhztVQsjOy
         fY5YNig0nJEtLyuFN24S0aFYzIM2sCIccS1E1qxCtCL4iy+OYMI53Y9nB6h3K83FLqUM
         t6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767630876; x=1768235676;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fonikX7z7K1ohHQZl6vZ41UkDK6dK2RBIq07hZiimXM=;
        b=giEIgex6yuX4xgJeE1MyR2Ma5A6ukdFq0ozTrv3E6VQmhtEh56Uqu/rY31iAnB+sTT
         YqteU7ucp4tT5KRVeVDkLbUMtfGmAeyTadWwxFmyvY+EXcxWTdjOgq59p8Y8b0jZdHKi
         M3ifTT8SnLHOlaWEnWbHHLrAGwEfM+iZ03BVl6JS6HiZwIFnlBuJzk2CuEHQGvjJK3Pc
         1YhHy1h13oPsFo+xgHzSbVC97787dXGSA0Kq0zXxXxmisF9ZapV1dTXhN7bt/aw+y7e+
         wqbcFi9nwPczXyuq9sHzk9aVmMyaM3gjaAJLM5yd+Fc25myzDdmp/menprBEcWRtfVh2
         IZ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVx5VHFgs6iEAOho+5v6s/V7X6f+QNVMgp3eGx0vbACcMxRL1vlD/s4Xi5hUH3ZDRF9mXZ5baVrnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMbJFy4jGzG6/E1PnmEbwJw5lbVoGVDSkS3/PEK6QJCZ61pIju
	SbgFAVeP1oPBlp+A4stlci7swuo0DpfyBMKjwWfcNhvg+tOMX7yCnodPsUYMQRvnS8vzEeOVxC7
	Ze2dohYPvUw==
X-Gm-Gg: AY/fxX7YvditlpXhv57FI8gWKN8fyU5ZMMvoY/N2oJFePAKS+C4KV8fg5Rqhk75jJa6
	oWGYyFtr9jVo/Dj1hhxrSHijaN1eGUl8ZwLOoK/cR8x7Q3x2N4UQuZKE1J9hgoa4UY6OeeYAY7U
	cAeGv3GD4WUvzhOZdbCv8oLsnpQUgoGogbCWPT4jywSLqG60x8xJhBILNDRmf1QoRJK9rTNW1Fm
	nY4TT7wsPq9XC47d5AbQDRmcw+boAH4nmVItyBSgglFCa+OzY7KPGWrw+M07fAvPGd/u/z3ZDZb
	3obYR35VKwtldBBZV+VdsULcOG+M0zHqHeKXzskkXh2EEIFCRbV1sODkDzJGFyluw2Ksk0eTmbx
	4EWmENo6h091FX3jySkzeOZhODpVvMPOBISrBvUkQ1SFzH3hsjCH/wWidbdxTDIr22CO0ISMl1u
	jDZ10p/glVKAsh1fOBOQ==
X-Google-Smtp-Source: AGHT+IHIyW6EL5Qeds3ppqsne/ep5l8vVI6WL/+6EbkwC3Ri0haHzlrCKUwNVD3J8FuYeN4YtG8RdA==
X-Received: by 2002:a17:907:a43:b0:b76:74b6:dbf8 with SMTP id a640c23a62f3a-b8426a67855mr36978666b.14.1767630875838;
        Mon, 05 Jan 2026 08:34:35 -0800 (PST)
Received: from draszik.lan ([212.129.74.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b84265ac3ecsm40253166b.11.2026.01.05.08.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 08:34:35 -0800 (PST)
Message-ID: <6eb57ad14908ae894f090ce83c756e4cbc834aba.camel@linaro.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: mfd: maxim,max77759: reference
 power-supply schema and add regulator property
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: amitsd@google.com, Sebastian Reichel <sre@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus	 <tudor.ambarus@linaro.org>, Alim
 Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, RD
 Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Date: Mon, 05 Jan 2026 16:35:09 +0000
In-Reply-To: <20251227-max77759-charger-v3-1-54e664f5ca92@google.com>
References: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
	 <20251227-max77759-charger-v3-1-54e664f5ca92@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-12-27 at 00:04 +0000, Amit Sunil Dhamne via B4 Relay wrote:
> From: Amit Sunil Dhamne <amitsd@google.com>
>=20
> Extend the max77759 binding to reference power-supply schema, so that
> PMIC node can reference its supplier. Also, add regulator property to
> control CHGIN (OTG) voltage.
>=20
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
> =C2=A0.../devicetree/bindings/mfd/maxim,max77759.yaml=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 +++++++++++++++-
> =C2=A01 file changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


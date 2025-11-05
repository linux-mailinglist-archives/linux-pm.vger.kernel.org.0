Return-Path: <linux-pm+bounces-37453-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23827C356CA
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 12:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E41560D7B
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 11:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D2D311C05;
	Wed,  5 Nov 2025 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+8aIDFv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834E2311977
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 11:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342791; cv=none; b=Yo+D2stiJSErXMotxn3c+EMvWcq9sLN/TIhRY6FmcYZQLf+LwjspZbXzBaQAnHTDk5upGJBSu49hGPJVUm+OlkD9aPiZ/XrGaMXhnwBuYukC1NC2nRq9VskyG41Bp/p9YZPdSAfaowIEA5PG/oGHRhUED+vyndu/RB/+a7bKV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342791; c=relaxed/simple;
	bh=XJnQ8QAutR/Qjzuilm6RbMyIh+omr6OWVKRLZO5Bnf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nF6FRBjAkh2XJJ8nh7aNjp40ueprsy65i7v62F5P/BFSTPo7bsw02S6XtPj+lcaXC0LmuJ0svtNdtTNJLc7sdqOdOIRlVGoSycY+2EZh4LPiOHKt98YBIbMcV/1xQ/Y5RjAJ6f79+pOsqfafAEkIqGvYI0LVwjXKHsixl1NCWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+8aIDFv; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59428d2d975so3558264e87.3
        for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2025 03:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762342787; x=1762947587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFKcDBz895P+pKkilzGMv1j9zQS86el4sifmVfoozzk=;
        b=c+8aIDFvmDBT2m9qrApKXIPP5ZWbMlGjuGw7Ydi1dQbEBjvjkBMarrqMs873nBfg8r
         XrhS9wNgWvynhPI2oe7svQsP/VzKTvzPhgCI4sAJDUOvokYyh1/T+P2OSxApp12e14E8
         HSUR32nwsRw0Vzy5GXuwYGK4NoNkLgKUi0I8Otk7YlbKNYzXXc9rBAnjJffY58im5I9P
         U7zW6mlVCI1rcpqcvpg/y68ibb0rvnXdyFJZxCt/FsBwf8+TpVNE/telUBvYja2Tq930
         bEKcEHQWHXHCESOmRkIYGx1F7KjoHHl/m4Gv/amVBwnB8gZemmD4fMZh3rCeoxkz8I5q
         l50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762342788; x=1762947588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFKcDBz895P+pKkilzGMv1j9zQS86el4sifmVfoozzk=;
        b=XgzPOFqsMcY7emMbsbJa9o8dsCfWybyKzvyynhJU0GIg48W1FJJyJe1NjD6OB5B2Ds
         zMTvGUfpV8qCjbNnpo9/HchzqbkdF+Bqv0q3f9MbsmwnSxi9RktMtTnnBBeIostJmSNq
         0Hw5MQRRAmVzKucsI4WU3875lBbMZD/EHG0sydEOzbsiOMAVhbxQsEd569wnFX2g2n83
         BwvvQcwZqzqv73Dtp+qLg4nkVT1GUG3dldJrHZRRnIoLXEK7JWqUD5mK2Ruk2w2ur8t6
         AMaIN4iFg57FvNdyas2DZ09p/MWLxeQG143PzFM6TrAyURCaq9uUagJUzBrY+oMDCc/t
         2ZYA==
X-Forwarded-Encrypted: i=1; AJvYcCUk0X1zX611H5bh0t0Gna8JKV763uGWRJKnIsrsNmtwvJhMHeF4CKl6WgddawYorxAmQLGYObllgw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9mdpGKKpLMJasBYsvP7m/KfxkbgdOAvViukBeXHCRPOYqpZ9D
	IF92q/PyPs3wBNcM44l8RQrj9vMLznvlt90tyCAU2InWlCeco+IY7bGBbTiniHkjGk0=
X-Gm-Gg: ASbGncttvKIZqMuGmaHM6f052SkbGmNbGDWXAK/kW4RSkKywwd58Elb8dA+glKodZhm
	JNuxHrz78qrg3KXg0wsS/QcudAqlboFa8WRsdWS5pI7vCxepl+QZdjf9dm32b9vfOP7+BpkCqTL
	4bBB6GqA/Cf6AnoncQBmKnnHHObP55v6VlzBbDKaXZeoDNBVsE9fTogFimBQBe7iTb7DyuCG46x
	u8LVhYG+sssPGaMocw/2KqiM1vTZvjWPIEQqxgX+SL7vC3dc4llUnMifZ6an8/lHaEqQ9Iy8BvB
	nrn5Ns7Z1cKOEsYFXGgzE573MAxsfa3++cDI1ROWIpMWJreoXUDVMFcNo3fWJiws+Yo2HO9sci/
	4RnxBgfdgkctratusZR+bPHzp/gTG+ugbj9ugIyvejOC1Z252ZS3ZdH7wxOlGk+mjSQpRVULB2s
	7EJZPBaI3xYcjQfdFGxi8R7tkDSUZI1u8cdze01y3z1ZvF2nOz4j07gSC9eQ==
X-Google-Smtp-Source: AGHT+IGG31UsLd4o1FDm3BbiPL0QtqwK8nPiQHx1dRUKJ4gb8AV+HvnhJfY8a3mxdgTF9YlyblMwPQ==
X-Received: by 2002:a05:6512:1395:b0:592:f8aa:c06 with SMTP id 2adb3069b0e04-5943d7f3f74mr1019404e87.57.1762342787278;
        Wed, 05 Nov 2025 03:39:47 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5943443992fsm1652172e87.60.2025.11.05.03.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 03:39:46 -0800 (PST)
Message-ID: <aa55cba7-1f7a-4c44-a101-cb991387fa55@gmail.com>
Date: Wed, 5 Nov 2025 13:39:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/16] dt-bindings: mfd: ROHM BD72720
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-clk@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-rtc@vger.kernel.org,
 linux-gpio@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 devicetree@vger.kernel.org,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Mark Brown <broonie@kernel.org>,
 Andreas Kemnade <andreas@kemnade.info>, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <cover.1762327887.git.mazziesaccount@gmail.com>
 <4c7ea0c83f4bb4af65439a9b8951d50ee705d22c.1762327887.git.mazziesaccount@gmail.com>
 <176233321210.143104.455177775703669783.robh@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <176233321210.143104.455177775703669783.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/11/2025 11:00, Rob Herring (Arm) wrote:
> 
> On Wed, 05 Nov 2025 09:37:05 +0200, Matti Vaittinen wrote:
>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> The ROHM BD72720 is a power management IC integrating regulators, GPIOs,
>> charger, LEDs, RTC and a clock gate.
>>
>> Add dt-binding doc for ROHM BD72720.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> Revision history:
>>   v2 => v3:
>>   - Styling
>>   - Document all pin functions
>>   - use pattern-properties
>>   - re-use existing Rsense binding
>>   - correct the example
>>
>>   RFCv1 => v2:
>>   - Typofixes
>> ---
>>   .../bindings/mfd/rohm,bd72720-pmic.yaml       | 273 ++++++++++++++++++
>>   1 file changed, 273 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml: Unresolvable reference: /schemas/regulator/rohm,bd77270-regulator.yaml

Not sure how this slipped through. I'll fix this in next version. Thanks.

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


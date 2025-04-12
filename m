Return-Path: <linux-pm+bounces-25303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F27E0A86A9E
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 05:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1F03AE963
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 03:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AA2155C87;
	Sat, 12 Apr 2025 03:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYHifKYE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F018208AD;
	Sat, 12 Apr 2025 03:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744429840; cv=none; b=seoR2CTeg2ItlIsBpB4bdriHLd7qURtvrNrBqAcDp4TBHpttsme7Nbqx6WWBkG9N8E4bbkgKT0zQLqQIDNAqthns+AJSE12ylAjjdYKRE6tPqbqKQqvpIt2irosdPxuGv24EJ282RSsnGUox2PQJvScHJmjsigKnXQEOkw07wK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744429840; c=relaxed/simple;
	bh=LxzxpLuFqzA20rKYrlVYVZ1GYPBQpHk0m8ab776NZFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxkXR4JWPQ+yPkv+bmq0vEVbZQx+doy91EOZEcJ9dw6E/Gx71zoQ+sxTqvcnG9N/2dQXAxD90n+24wiQGXTYZ/CVhiZZqh2WIPmAL3kXkvjBY7R6jWPIeIDoVdXnKcO/LaoDSO+i1F+6z/1HKPaBNdsABgd/A3esTdJigEDoWPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYHifKYE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736ee709c11so2176468b3a.1;
        Fri, 11 Apr 2025 20:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744429838; x=1745034638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uxgICOMpj0NVx3WYcPGVSamgvQ2YeH2wLMAPVBj+n7M=;
        b=NYHifKYE3iUFeYsFfvnvhGPikuX5ZE88vGSrJQfNtz7WEEE631Wy/hoBqktvTZx2Hv
         M9GileS+C+d6oCCYsKuLbKSg3afIQsyGDE965/ARTezueY6E4VXgG3qEKNXSxsUZ7aMZ
         rmtJhhL37XUlSGEq7ieOCxGAJuyL3wtsn7L+LKPINLerm99ryCyn7aCWgmc3PNPUJjbf
         Mi7xFSDW/lc5G2Gc8qjLm24QwTaBqh80yi5X7avR6XszQcnkd/aYKUttIuXhRBNaRWey
         WY7ye22ftVi7R2tlcJxtPYEOeMYhfHyUrlkdz2bv941qugoCfbn+va++EbsUT6ScKeC8
         dzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744429838; x=1745034638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxgICOMpj0NVx3WYcPGVSamgvQ2YeH2wLMAPVBj+n7M=;
        b=J7Bsc+bdCyWFu7CXG/BeGITlC7ga4Rs0aE9/QHQjHBK6Oh6jLtsWHminVwRCuL+s/f
         7Rw07zlrSoUrqHaf8WZOXMbrgV8R3EoBUkV6N01hcON+dgGhRu0jouJkht30/JWF4gmv
         FPeKvgdAZmbsDPs2dN8drtQgg5FDahDpWWixiFh/LbxpsrFpdUvCUf6eRfAv9e2wFyPd
         8CUmYQdKbYZmmACfok5USit9uOz/IgmH+Lf0Qg5Rk1mE40FJ1ZCdU/wMeDYapPIVIsFG
         QwYagUV+3IDPud+7a622zhzeyfA+OjoiLDbB+MBok3WkFoQOEoWhKkW9YeX7VSwmO+Xt
         fqFA==
X-Forwarded-Encrypted: i=1; AJvYcCVyh/dloFc2ETIIJ6T5m8OSk+q8ci2risnHOcTt2TA2sMJLwyWWmS+Oha5QyjPLROo+lWt/sTHhH6xp9v+J@vger.kernel.org, AJvYcCWD8U+ERe+4Jf8q+xW2J8dvwXpuEWSnmn6t2WHkW7MlJ+YeVxdzO8Qb5/Ihh1A8Z9OwGn4p4Tv/NdZx@vger.kernel.org, AJvYcCX8jVzq2oc0HBgBKJG1ObP0Yu1FRP9DI1ITdxVrB6BefJVfjmWigpZc2OKSCtZEWlY/zP2fawlII2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAxRpHi5XGSKRXRtBQTfcKsMj82/iEQ8vQJ32c8c0Ns7m/ptZC
	IFgaTczXduAwHSgQobcXok0kfgXD10nlGEtx30NopqEVbTD512bEyCVdI5DyCTGqMQ==
X-Gm-Gg: ASbGncvyfp3hKhGfSLBRHpexQQ/sdjmgrF8VgTTCo3PROGaEWgmiyRxKZNjwUaM5eCq
	f0A67GFNOphr/zpX2gc8Toy70xnw5B+1tmZbCnX1tpESQV1Tni4ZChx5ac5RcY4+NSPKm/xDHn/
	JLZmbP15bVO0roiDGzD42Fkba5KeGVD2UGnpxQx0nymt0KVek/VQuWfTISqeSxU988HVXMC0lfy
	W1aJhCZFjAYAj3TCqi5reEI+ABVOufTPsZfKJr+7ifa6Yg91OPoSNSayh+JBmfoKiuRS+UnudxG
	SeAghdBISuzttUgVACxg
X-Google-Smtp-Source: AGHT+IHEPw9l2lckImW21hc5WfLjuKibfw20oGZVWj/fM/Sh5wIaMnFrYyjNGc7ye9/ekqZxC0bumQ==
X-Received: by 2002:a05:6a21:3a4a:b0:1f3:194b:30ae with SMTP id adf61e73a8af0-20179780638mr6529548637.1.1744429837641;
        Fri, 11 Apr 2025 20:50:37 -0700 (PDT)
Received: from [192.168.101.248] ([2605:e440:15::152])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c210esm2476926b3a.41.2025.04.11.20.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 20:50:37 -0700 (PDT)
Message-ID: <dc4cc121-9e75-45af-98c1-5a4c0802e2ca@gmail.com>
Date: Sat, 12 Apr 2025 03:50:17 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] dt-bindings: thermal: sun8i: Add A523 THS0/1
 controllers
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
 Andre Przywara <andre.przywara@arm.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Yangtao Li <tiny.windzz@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, Conor Dooley <conor+dt@kernel.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
References: <20250411003827.782544-1-iuncuim@gmail.com>
 <20250411003827.782544-7-iuncuim@gmail.com>
 <174433447237.1635065.9681378963946489764.robh@kernel.org>
Content-Language: en-US
From: Mikhail Kalashnikov <iuncuim@gmail.com>
In-Reply-To: <174433447237.1635065.9681378963946489764.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/25 04:21, Rob Herring (Arm) wrote:
> On Fri, 11 Apr 2025 08:38:26 +0800, iuncuim wrote:
>> From: Mikhail Kalashnikov <iuncuim@gmail.com>
>>
>> Add dt-bindings description of the thermal sensors in the A523 processor.
>>
>> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
>> ---
>>   .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml           | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.example.dtb: thermal-sensor@1c25000 (allwinner,sun8i-h3-ths): clock-names:1: 'gpadc' was expected
> 	from schema $id: http://devicetree.org/schemas/thermal/allwinner,sun8i-a83t-ths.yaml#
Thanks for the reply, I didn't know about this tool, I will use it in v2.
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250411003827.782544-7-iuncuim@gmail.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
Yes, I forgot to point out that the patches are based on 6.15-rc1 using dts
patches from that series that didn't make it into the latest rc:
https://lore.kernel.org/linux-sunxi/20250307005712.16828-1-andre.przywara@arm.com/T/#t
I'll add that information to the cover letter.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>


Return-Path: <linux-pm+bounces-19805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A452E9FDA07
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 11:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293423A121B
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 10:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB29B14B087;
	Sat, 28 Dec 2024 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifHwLxDD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD54433A4;
	Sat, 28 Dec 2024 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735383095; cv=none; b=bUB/CiBt9LGmLrqCtquXa6O5sPcFZDOFP29yrU5LJ6BhersipV0+E3rKJJPQ/pPYLR6obpG/4ykhvax/atvGhO/GjuIlA59jZgvrCYF/OaUofaQSkkI4Eb80YsY0kHHk2hVS9PaOpxAg6DaghGqYqij9w4qL24Jzs37sl2T6E3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735383095; c=relaxed/simple;
	bh=F4OW7q6w0LpoeF4mBM4Of8a2c2N+QqBWxeMjl2oPuxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7LuJRy8BJIiXMu1HtCL659Lq4ID+hmOyP6jNnxwaSY3AnzOvaEVkxESsGbiFQFOm/1xzSZJHAnJX3Mxt2HCfMoz/HMcmd1KtzA95s5JYS9BE8x1yI9Lqc6S5UlNUuSCG0sXUpzMx7ZQ9YFDAYf8/ZhVi8wImyzCS6FDpb5Ahlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifHwLxDD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2156e078563so87312985ad.2;
        Sat, 28 Dec 2024 02:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735383093; x=1735987893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cslFju+KUWqOvyz1Tf67pxAH0XjE9f44GrOT+Lx7mYw=;
        b=ifHwLxDD1JfZXxDctBc8E3fVpziIX2TWYR3uq9mlQVcWv6JUPTZBQjbqT0xeY9syRh
         Eo4FhRetVXFeUlVYCRZDSEZ5tRKWSuR6XsISc/Bm975s+awJpJJABJ/e3R66FcycSQly
         7T8GF/wle7MPUoZtWKu1uq3B0HSV8FPvUHSd+EglhgxZD35pKWgGr/Z8Gc0HZqH1+OiJ
         +B0NfoXQ8kLqARWJABSCY7x2iJEJikkRnyHG1FFkoWatxAlawVYhEITswlMaWPvBO9tS
         4tecs7bmyEA/q4j9A1pTzzpZQiJTKuhCnyHWQTNXOXpbB5+NzN5gM32FnB+sVnPnPOfu
         4Zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735383093; x=1735987893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cslFju+KUWqOvyz1Tf67pxAH0XjE9f44GrOT+Lx7mYw=;
        b=cMZsPdrNxi7eYcaxRf+0gfnVnC1YP+SIC3KpgbSExF4klXmRUWISxnTvzQyzFW7/rV
         VLIlaKvnBzpfBgz+mUf4MbCjI+dBacG80Wv4kBuh3Pe2MZM4HtLNF57RvtWgKxWBXYTY
         CXReX43o3WkjlIeUPBZ/GxrKALSG4jV7khseA6PzO4Yonjr4z5dFWPGxjJyd6lxGKV54
         15zqy8meBNzy0yghPyYHOP27E8Aq9xZpGf8GYu22O3yEa8MRmpXd6fT1YSleuaUabM5F
         /TV7f5sYhpTxmDSwE+jfnEo18WT7m2S1LXrTbYHEzCHH1PP+mrUNiFI2VGB0YY83Srt0
         xMZA==
X-Forwarded-Encrypted: i=1; AJvYcCUW4OtPUAEE3TLKJ2IPBKERR+nzzXynzchEHYbGEFby4yoFBaFj1YKZDnyM1bjvprduyKx7Gp5gW0k=@vger.kernel.org, AJvYcCVFPiv2fGQT04YoneV6eL+VXRL6HbJ5pHOU7deWLVLNR6JDbmGLaHlBADLzPYGLu0Ab4U4Lces+qcV+9EAD@vger.kernel.org, AJvYcCVKdjqC1zck5uR9kSXRhXAfm+PGeJHirHzuDEy6rpkVxdJqlCga23zU7gOuReKrvaW8BlxewXphzKxPzorY8nOyiUdPWQ==@vger.kernel.org, AJvYcCVX0QQ07ed9ayyP+0ZDF8hhB7ZJXpnIkbWu7z/KPUnjEqtSf4TT+Wf4B1rtDtQRejWkDZXLOGevQqNl@vger.kernel.org, AJvYcCWPkZmAnL3hIu1yFluQv/WSkTySK5jw2zqcCVNbCpb4/eFIk15THnpVp64/7QX4yEGcn0vU1eSaRI9a87tRJg==@vger.kernel.org, AJvYcCWpsEvbaAd/j0p+/xOFUYSQ54J9INymUxxpRWFIh6wHzBWAGb6tlJVAF6q1KchZaeoFSrjS6b34WRgh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3D787zTe2emJwPXNE3T9I8PU9/wyBd5Bdka9+a8z/LJ/Vmxvg
	5mwuPjJqrw3x5lj2njONxiPFdQrST1QHJpg20J4sZ5rvdUgUP8iR
X-Gm-Gg: ASbGncuVyOwkkSbayzGYRoUDXdR82S8zHm+Q+8LXCLozoMzie4vg76MRY8ZMwoYM8bC
	7sth70xtpRUfrLimEjVgvik0e0w6wr/AN9HiekOEG9HUUVgHpR8OcABeK+uFCdgeoGoed2LqZ3E
	KIsKLuQTIo1eZ4rKbRnIzs38OLBOUOppYkDmccr6g+39SEu4cofMQ39APkQF7Kh6WozccPk/qiY
	y5clGAWqJXTRlAMWwhVJ1fmzH8nuttcN6HbuzCkQS0=
X-Google-Smtp-Source: AGHT+IGej2J44pyqeVn+FJaceG7AqmMf4toCvcVzo58eo7R43D8XnZ7I4oa4pstQneUUOFmDgceVPQ==
X-Received: by 2002:a17:90b:538b:b0:2ee:5bc9:75b5 with SMTP id 98e67ed59e1d1-2f452dfccf6mr43336703a91.4.1735383093374;
        Sat, 28 Dec 2024 02:51:33 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f447798982sm17266526a91.1.2024.12.28.02.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 02:51:32 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: krzk@kernel.org
Cc: andersson@kernel.org,
	bryan.odonoghue@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	gregkh@linuxfoundation.org,
	hdegoede@redhat.com,
	heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mitltlatltl@gmail.com,
	nikita@trvn.ru,
	platform-driver-x86@vger.kernel.org,
	robh@kernel.org,
	sre@kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: platform: Add Huawei Matebook E Go EC
Date: Sat, 28 Dec 2024 18:50:16 +0800
Message-ID: <20241228105017.585067-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <705f52a9-562b-4b17-8b28-ee837b41ea7d@kernel.org>
References: <705f52a9-562b-4b17-8b28-ee837b41ea7d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Dec 28, 2024 at 5:54 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 27/12/2024 18:13, Pengyu Luo wrote:
> > +
> > +description:
> > +  Different from other Qualcomm Snapdragon sc8180x sc8280xp based machines,
> > +  the Huawei Matebook E Go tablets use embedded controllers while others
> > +  use something called pmic glink which handles battery, UCSI, USB Type-C DP
> > +  alt mode. Huawei one handles even more, like charging thresholds, FN lock,
> > +  lid status, HPD events for the USB Type-C DP alt mode, etc.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - huawei,sc8180x-gaokun-ec
> > +          - huawei,sc8280xp-gaokun-ec
>
> sc8180x and sc8280xp are not products of Huawei, so you cannot combine
> them. Use compatibles matching exactly your device, because I doubt any
> of us has actual schematics or datasheet of that device.
>
> > +      - const: huawei,gaokun-ec
>
> How did you get the name?
>

From website of Huawei([1]), please search for 'gaokun' here, we can know
this series is called gaokun. Many files from windows indicate more,
someone fetch drivers from microsoft server([2]), in one of driver archive
'OemXAudioExt_HWVE.cab', there are two files, "algorithm_GaoKunGen2.xml"
"algorithm_GaoKunGen3.xml". And `Gaokun Gen3` print can be found on
motherboard(someone have the motherboard, I can ask for it later).

So can I use?
- enum:
	- huawei,gaokun-gen2
	- huawei,gaokun-gen3

Some backgroud:
There are 3 variants, Huawei released first 2 at the same time.
Huawei Matebook E Go LTE(sc8180x), codename should be gaokun2.
Huawei Matebook E Go(sc8280xp@3.0GHz), codename is gaokun3.
Huawei Matebook E Go 2023(sc8280xp@2.69GHz).

> > +
> > +  reg:
> > +    const: 0x38
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  connector:
> > +    $ref: /schemas/connector/usb-connector.yaml#
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c15 {
>
> i2c
>

Agree

> > +        clock-frequency = <400000>;
> > +
> > +        pinctrl-names = "default";
> > +        pinctrl-0 = <&i2c15_default>;
>
> Drop all three above and test your bindings. This cannot work and test
> will tell you what is missing.
>

Agree

> > +
> > +        embedded-controller@38 {
> > +            compatible = "huawei,sc8280xp-gaokun-ec", ""huawei,gaokun-ec";
> > +            reg = <0x38>;
> > +
> > +            interrupts-extended = <&tlmm 107 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            connector@0 {
>
> Test your bindings - you do not have node connector@0.
>

I have rewritten it locally. So I will add the following and do some fixes
in v2.

patternProperties:
  '^connector@[01]$':
    $ref: /schemas/connector/usb-connector.yaml#

    properties:
      reg:
        maxItems: 1

>
>
> Best regards,
> Krzysztof

Thanks,
Pengyu

[1] https://consumer.huawei.com/en/support/content/en-us15945089
[2] https://github.com/matebook-e-go/uup-drivers-sc8280xp/releases


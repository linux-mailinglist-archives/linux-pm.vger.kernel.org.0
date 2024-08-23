Return-Path: <linux-pm+bounces-12800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AA495C6FD
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 09:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB54283BBB
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 07:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55F813D2A4;
	Fri, 23 Aug 2024 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="g9r4KbF8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C550628DC3
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724399654; cv=none; b=RVcqz11yJ9XHjgm+Gb/wE1PHKZrJTxOqTCA7dypNDqVUSkH1Uhu69zOcQ2144Ea7aDnLbNQz4VDxembvI0RFw+AzuTl7RLHArHV7sSdb+DCux1Vg9q6oYqQCfsqT9agzKkK25LIiOg0afOx9cMSXNdKL9Quc53/1KuxhqWf5vmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724399654; c=relaxed/simple;
	bh=o/OpwKFjjA1yEkgqJPpN5d/tMG8m+GDhUM0qxhUcYY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PzuS7BZ34yT27yvXGGeoEMxuubn3/eexpej/ObR8jH5UcdWl/lUDWHZaFCDJR79fbc/4Z6NQulxt5b4N/w5sTveGORFxsI3ZItEKkLUgNcV7pp7E/TiFqjP5Ic9KlUmVTb59za9Zvo0ZCBaTMh3VC/NWHLmFqk8Gi6hkN23n86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=g9r4KbF8; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bf068aebe5so2441614a12.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 00:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724399650; x=1725004450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K9F6H3c2NVmBHPEentW34dAviw4YhqEZNXwnJa/lgq4=;
        b=g9r4KbF8boXqlaHvOateW8bGYMOhm34jwDwKIzmDuP1vp+uaDAMhXYzuv8uRWqW6NU
         MjQpU5jSy34jCJgQsLy3OfHRHE2J8AD5feeCkPjYbiZym6eyDruMe4iG7rnPOYfD/o+H
         BLtzTTlheSsMNwT4cNUiRze65dOg2tFpv3MV+MnBt0LfwwoF6nSucA0oQRk0EY9dVBMi
         qG4Ut+4xYurOL3y2yUSb1yaubM0eSpK7enfDo5saLzwG1C+R5wyWSq4YghqlUp9IuouO
         LPm25Wnfdv6AGWlXbWDSmlMPCUVTWHdZlxblshHuKgCvMap2fmCwSzJtCo5MW1XzPcCE
         BriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724399650; x=1725004450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9F6H3c2NVmBHPEentW34dAviw4YhqEZNXwnJa/lgq4=;
        b=WNqfC/XRoho51LRXPqjv7P267R0yFtR/eOVY49ZDxgKYIPhyqxZ2578QaH/KzrZ7vG
         8dq/dj0hAWwTKCVjcwb9KTIYgEf0LeDhIcTE7X6KVz9Y9yMzWZ+Gi/BIe+/ObSt2wbmh
         mZNn9mvFwce2ArSebn1YqL2bDOPaH4YswtLbgQ7Zi0tbVSpE4P8kHT5U7NGQB358m0uA
         Z7Eke3mB5gm4RnS9Qcv6ds9RE7/feZ0DobX63CbQ55ldckQ0IMz/uRMOJmyoUZ31xFoD
         I7qKUmGu4uNwuH5fzuSfFsjd40nqoFCsGD5XzEO/+WeNuU9e4UU3Xc/BWwtqUj3YD/QE
         zb2A==
X-Forwarded-Encrypted: i=1; AJvYcCUrj65kb2vfXrh4XlsPXGLpQfUzIFsH7Ks6yoXRTLYwc6CXGNPhuHNrQdsal/DodoX9IqqtO35wmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuzNXNMCVXLsj9YmXok7xB+TRiQc9KCBwf/SgvUPRi8OHfYmPS
	GG+L47mCA3/dm8ySO5sLunZdY1rFwOx31RHKcvPoiFO78A9wwbFxM9bcuCip4gE=
X-Google-Smtp-Source: AGHT+IEoQJnrG7rJ9f2StMomCkVPrYJqe5+JdS66nZak9PuSepkUhwJhO+/TtFtd6qLUxl+/AblgVw==
X-Received: by 2002:a05:6402:4303:b0:5be:e999:18ab with SMTP id 4fb4d7f45d1cf-5c0891a1ccemr803908a12.23.1724399649843;
        Fri, 23 Aug 2024 00:54:09 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3eabe1sm1754112a12.52.2024.08.23.00.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 00:54:09 -0700 (PDT)
Message-ID: <0d8b1322-cf15-4ed9-b958-06516bbb64c7@tuxon.dev>
Date: Fri, 23 Aug 2024 10:54:06 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] dt-bindings: soc: renesas: renesas,rzg2l-sysc: Add
 #reset-cells for RZ/G3S
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be,
 magnus.damm@gmail.com, gregkh@linuxfoundation.org, mturquette@baylibre.com,
 sboyd@kernel.org, yoshihiro.shimoda.uh@renesas.com,
 biju.das.jz@bp.renesas.com, ulf.hansson@linaro.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-3-claudiu.beznea.uj@bp.renesas.com>
 <20240822-vanilla-enigmatic-f0b05ecca4b6@spud>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240822-vanilla-enigmatic-f0b05ecca4b6@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Conor,

On 22.08.2024 19:42, Conor Dooley wrote:
> On Thu, Aug 22, 2024 at 06:27:47PM +0300, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The RZ/G3S System controller has registers to control signals that need
>> to be de-asserted/asserted before/after different SoC areas are power
>> on/off. This signals are implemented as reset signals. For this document
>> the #reset-cells property.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  .../bindings/soc/renesas/renesas,rzg2l-sysc.yaml | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
>> index 4386b2c3fa4d..6b0bb34485d9 100644
>> --- a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
>> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
>> @@ -42,12 +42,28 @@ properties:
>>        - const: cm33stbyr_int
>>        - const: ca55_deny
>>  
>> +  "#reset-cells":
>> +    const: 1
>> +
>>  required:
>>    - compatible
>>    - reg
>>  
>>  additionalProperties: false
>>  
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: renesas,r9a08g045-sysc
>> +    then:
>> +      required:
>> +        - "#reset-cells"
> 
> Given this is new required property on an existing platform, I'd expect
> some mention of why it used to be okay to not have this but is now
> required. Did firmware or a bootloader stage take things out of reset?

On previous SoCs the SYS controller has no support for controlling the
signals going to different peripherals (USB, PCIE in case of RZ/G3S).
I'll add a note about this on next version.

Thank you,
Claudiu Beznea


> 
>> +    else:
>> +      properties:
>> +        "#reset-cells": false
>> +
>>  examples:
>>    - |
>>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>> -- 
>> 2.39.2
>>


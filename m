Return-Path: <linux-pm+bounces-27763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E26CAC73A6
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 00:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DD01BC5EDA
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 22:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC659229B23;
	Wed, 28 May 2025 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LQNuGP0m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD3322A4C5
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469674; cv=none; b=YleMtx2SXYZPJ9+adQ6I4jNDdZEZfLglTcGu7KmziHO0U4kdacig2HLT2jbgLkadmuc1UIVLIp0tbsCcL8BHeanGJMdGHznNMnQuQyr9AuCqTkcOCa4YX15A/F7Wi4UyXDmzXqRn3s8VANmDoNt09lbHisl9vnJVE02g76Ysci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469674; c=relaxed/simple;
	bh=9xgovVByeRLDD7X8aQLb74zBQo1GfWHki0nfN4FrGTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qwIM7GEAbdOveUokIftK/lg+Ect+KtOvOJb5jYdAmaBpefFO0BhS5CntbTnlQ/1zUOkZ5sOeDGdcuFmgWuWNVTNciI8hCmL/dpTHQ9q93B7/6WJcdIjbShZ/ia2u7Q38zk2gjBmHhpllhi5rMxxzrqaYGiNWxUGNErS8Ni3MLLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LQNuGP0m; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74264d1832eso206688b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748469672; x=1749074472; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gjdYBhiSCBBsPz/KYuGmvOv9MuA+IwckOxlrzQUqXbo=;
        b=LQNuGP0m9nIk02uBtC5M3DySgJKs6DZr2xcc5mn+2Q3g2QLuQHvsyAw8e5uweHBXaY
         lT/jwP4VOIldGcYT/KbwiksQGObXs594eplv4G8Mg4WEZP1Hk0GIkV1Kfy0quOO5KMUi
         8vjZiNLE/vmhWGshzUjhgOZBn8ahAO0cjHpl2bruaVCd41EyMfIiasl3buiVo9ylIkQL
         Xm5skiSrf+UmYHQjejQYNqt/kUP45+v+gs80GSROK4Jz9oGxyGu+cuJibFH9yQC3sBaz
         3GWI17QL+DCE9gKB5pZotMLVsnuEaErttj5xkFansF6rRaKUW6tVydaLaHbODhjRIvN5
         3Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748469672; x=1749074472;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjdYBhiSCBBsPz/KYuGmvOv9MuA+IwckOxlrzQUqXbo=;
        b=lc9i4bsYwoIe+uRD9rCvgcVIaIo1dIxF4mcCsf8x5FWLcQ7nVwU2E3imHSOnKIC6LC
         +7istnVtZWKcggqp4jZ2oKRWxZ2aEWKUmQ+UxGgzECexNCMKDl1Q2Ocf0OGcqmGaLcV4
         l97oKWcWzhOiy6536mz9/2sBsf5q+m68HO5q7nsvlPosWsFMbR4MB9vCZLAla2u8M5gn
         pOe8WpmEeEeiy9B504vdSapmwg06KeGgFUYQkdGrMCx8CWcKQGtJpMWq8N21n9PAMb1U
         xZh9kWHj+WfTqPSLBCCrVR0enKJFfD91Ha2Mk2fx/RUvAaJ/8sbsBlvgXmBT7QMIkfR8
         4sGw==
X-Forwarded-Encrypted: i=1; AJvYcCU4usVVBHPH9lrCV2bjGxCxyPJfuUTAvJSqEfEs1B+NbeESyM3HESmINGJju9ufLzr4TDRDCgVQtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRlUPOvNE0ZPdQGuPQg1ow0OytnC4FOAwpLHYRAu3FhoJzahdE
	pzBWRks5IBYu6n+tmOxwu2w+t84bwaHGU12Gb1B77Su0jMrQf1yWk07oVcW9BPENyjk=
X-Gm-Gg: ASbGncsMc4vBZR7ZXryid65wg+ecNCTA/LSlqwKMGd8Pco2WaWIlIfmh+2WPbM7vpiN
	z4sFKqqNsb2DVxACGqV7DJ4qNK/7rC6ma066CcEHR7xa8KKDSldyv5NxnEae1xVzb+EzA1W2/V4
	3pnQue9EIPx3o2mU/OTSWlZoUG6G8yWVysViFTIl/PXiJKiPwz65/n3N4Es0kEimiio6B0MX/wG
	mCSrzzpmQgJClF6Fq7Z6ICdsiRAGTYIikBdBXyfwd82hFm8M8tU8uCFB073i/jjZrEUPSBANmgD
	tQJGzijXJNkaZoKRBS3AGmhT03aaM5tRiC0dTJSjz41nNE77QA==
X-Google-Smtp-Source: AGHT+IH3nYX+eQxZgpfdAR9VsWy9q7cvVikszCvdqn9prU3U/FXQrdVyfMwztBrRoAEFZ+77rvYLjw==
X-Received: by 2002:a05:6a00:2e84:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-745fde797f3mr27897905b3a.3.1748469671777;
        Wed, 28 May 2025 15:01:11 -0700 (PDT)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeaad78sm75427b3a.46.2025.05.28.15.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 15:01:11 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 arm-scmi@vger.kernel.org
Subject: Re: [PATCH RFC] pmdomain: core: add hierarchy support for onecell
 providers
In-Reply-To: <20250528203532.GA704342-robh@kernel.org>
References: <20250528-pmdomain-hierarchy-onecell-v1-1-851780700c68@baylibre.com>
 <20250528203532.GA704342-robh@kernel.org>
Date: Wed, 28 May 2025 15:01:11 -0700
Message-ID: <7h8qmgpf88.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Rob,

Rob Herring <robh@kernel.org> writes:

> On Wed, May 28, 2025 at 01:03:43PM -0700, Kevin Hilman wrote:
>> Currently, PM domains can only support hierarchy for simple
>> providers (e.g. ones with #power-domain-cells = 0).
>> 
>> Add support for oncell providers as well by adding a new property
>> `power-domains-child-ids` to describe the parent/child relationship.
>> 
>> For example, an SCMI PM domain provider might be a subdomain of
>> multiple parent domains. In this example, the parent domains are
>> MAIN_PD and WKUP_PD:
>> 
>>     scmi_pds: protocol@11 {
>>         reg = <0x11>;
>>         #power-domain-cells = <1>;
>>         power-domains = <&MAIN_PD>, <&WKUP_PD>;
>>         power-domains-child-ids = <15>, <19>;
>>     };
>> 
>> With the new property, child domain 15 (scmi_pds 15) becomes a
>> subdomain of MAIN_PD, and child domain 19 (scmi_pds 19) becomes a
>> subdomain of WKUP_PD.
>> 
>> Note: this idea was previously discussed on the arm-scmi mailing
>> list[1] where this approach was proposed by Ulf.  This is my initial
>> attempt at implementing it for discussion.  I'm definitely a noob at
>> adding support new DT properties, so I got some help from an AI friend
>> named Claude in writing this code, so feedback on the apprach is
>> welcomed.
>> 
>> [1] https://lore.kernel.org/arm-scmi/CAPDyKFo_P129sVirHHYjOQT+QUmpymcRJme9obzKJeRgO7B-1A@mail.gmail.com/
>> 
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/power/power-domain.yaml |  39 ++++++++++++++++++++++++++++++++
>>  drivers/pmdomain/core.c                                   | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 150 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
>> index 8fdb529d560b..1db82013e407 100644
>> --- a/Documentation/devicetree/bindings/power/power-domain.yaml
>> +++ b/Documentation/devicetree/bindings/power/power-domain.yaml
>> @@ -68,6 +68,21 @@ properties:
>>        by the given provider should be subdomains of the domain specified
>>        by this binding.
>>  
>> +  power-domains-child-ids:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description:
>> +      An array of child domain IDs that correspond to the power-domains
>> +      property. This property is only applicable to power domain providers
>> +      with #power-domain-cells > 0 (i.e., providers that supply multiple
>> +      power domains). It specifies which of the provider's child domains
>> +      should be associated with each parent domain listed in the power-domains
>> +      property. The number of elements in this array must match the number of
>> +      phandles in the power-domains property. Each element specifies the child
>> +      domain ID (index) that should be made a subdomain of the corresponding
>> +      parent domain. This enables hierarchical power domain structures where
>> +      different child domains from the same provider can have different
>> +      parent domains.
>> +
>>  required:
>>    - "#power-domain-cells"
>>  
>> @@ -133,3 +148,27 @@ examples:
>>              min-residency-us = <7000>;
>>          };
>>      };
>> +
>> +  - |
>> +    // Example of power-domains-child-ids usage
>> +    MAIN_PD: main-power-controller {
>> +        compatible = "foo,main-power-controller";
>> +        #power-domain-cells = <0>;
>> +    };
>> +
>> +    WKUP_PD: wkup-power-controller {
>> +        compatible = "foo,wkup-power-controller";
>> +        #power-domain-cells = <0>;
>> +    };
>> +
>> +    scmi_pds: protocol@11 {
>> +        reg = <0x11>;
>> +        #power-domain-cells = <1>;
>> +        power-domains = <&MAIN_PD>, <&WKUP_PD>;
>> +        power-domains-child-ids = <15>, <19>;
>> +    };
>
> This all looks like a nexus map which is defined in the DT spec. To 
> date, the only ones are interrupt-map and gpio-map. Here that would look 
> like this:
>
> power-domain-map = <15 &MAIN_PD>,
>                    <19 &WKUP_PD>;
>
> Quite simple in this case, but the general form of each entry is:
> <<child address> <provider specifier cells> <parent provider> <parent provider specifier cells>>
>
> <child address> is specific to interrupts dating back to the days when 
> interrupt and bus hierarchies were the same (e.g. ISA).
>
> For the existing cases, there's no s/w involvement by the child 
> provider. For example, with an interrupt, the device ends up with the 
> parent provider interrupt and there's no involvement by the child 
> provider to enable/disable/ack interrupts. That doesn't have to be the 
> case here if that's not desired.

Hmm, very interesting.  I wasn't aware of these nexus node map things.

I have respun a v2 using the nexus map:
https://lore.kernel.org/linux-pm/20250528-pmdomain-hierarchy-onecell-v2-0-7885ae45e59c@baylibre.com/T/#t

Thanks for the review & suggestion,

Kevin


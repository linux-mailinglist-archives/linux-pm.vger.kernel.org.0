Return-Path: <linux-pm+bounces-29525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF71AE881B
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 17:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA846818A4
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 15:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22C126B76B;
	Wed, 25 Jun 2025 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhsV+4MU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1491E3772;
	Wed, 25 Jun 2025 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865374; cv=none; b=XpRaGWdNOnt1W7EV6DVmEpme1VOqv84I0qrn9kcH5/4RCgZ3mKAU71Y5pzMuow7H/yC48DJbazTyKYVhaylVH1tH1JtSj5MxZTRFjSCNgBOtN7TGJfnLbT/b9y973rrNDKsCopZAAAa0Kn3YabYZWqfM9sxHcZuwjbEFH6jsOtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865374; c=relaxed/simple;
	bh=7Nva2+gS8Wqv4UQiN4BmS+skEo3e1+v7eDoMcNNWbak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2V2hAXRuHrRlTEaexva4gSXdeoo+X05BwFt9gj5xi154XAH8wfxk83xMg4KexvPihbZuhrdAkAgP9f7rADYFKRaMUcEgISSELF404EgNrYfMADxjMpQRlEZ8NFocKRBtdNselbJS19EMmiA7I+w82CIUTrXyEYo6PYz58fTtww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhsV+4MU; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2d09d495c6cso10814fac.3;
        Wed, 25 Jun 2025 08:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750865372; x=1751470172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2iLRZWU9mr0yxqJABvEamfRCguJhr8FEzZR2ailCaPI=;
        b=WhsV+4MU7qaSwVxrWwFlZTHccS0cmlsTDx9abuaKxNbX6spOA8kNohLqkhBsWZwd7b
         +0DrJTm9E8HDdySGaIqzLK/4f5pdgfZiywJvUQMEhEpHwbjMWnX7jqHBvh4PznevTCx9
         Kds42q6UOR98qL8FSYl/9ckL1yAn6Wv0zBrAUDYOEgLw2kANkonCvuAHRnYOH0tiR3qR
         5SXGaclNPaS2wQz9qXL5HX+B2yFUv3jRdiCppx7GslJ9Ov/m4eGakLYmcA/5dmQNDVBN
         HtaaZA/TSFn+Jb8tr2ox+IAYc6z0EK0q7uzGbMCFsmPgVYwF+62HFgku3f4dvpKdl7z1
         TG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750865372; x=1751470172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iLRZWU9mr0yxqJABvEamfRCguJhr8FEzZR2ailCaPI=;
        b=GlB7WTcrm7Am59ocnM8Hix3kaUf3pVd0ydEDBH+IcY9w09w/1z6sUlXGOYRYyB7UJR
         sD1Rml0xmR9pbPillsNPwLFcjP2SsCJt9nb1Oh0UANxHaMV5XH90bmNfec/T+4eMAiJg
         Ae+WSpwlq2tuNC/OONU3d9dMVCjWeqx82U5hegmcp9EevZa4N4sxnsK1AIhnilCFJDuE
         azzBxLMa2XG4bzUBkLdr/YuqdbYHtXIFJg8d5+c+T3+mkcvYTMxQ3ny4YKeqEpyUZYyU
         uwdMZy6HfFhZ+VYAKpGDP6TDKVAQIpYFe7YdOXDQYs6vrX8yir2hm5VKo/N83NdxwdJX
         LcCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi6CJI0BX9RSv6qGFSyxK2QFQ4GbZ8iTojpbPp/Dfk/Bx+PVRELdJHVHMk+ix9dztVW+Or6KswOXnv@vger.kernel.org
X-Gm-Message-State: AOJu0YzGjhgKPYZdfBwug7SBtXENCu8jrt15IwrZUnt/qZZJNHPQCn6p
	llLlB4mLnDjGH/hZeX1jappZF+NlaKaBuG/9a9gcronEwsKvO1O5PjN6
X-Gm-Gg: ASbGncuhbbm5Qy+RTbkk9gdVXnQAa9Vycs0iYynZT46IWxJrAzPFFkjnlR5SINfkdEt
	luSHvox/seosMEDPND2XwbuXoO8H9tGjyVnk+og5KijoCoRQAfD3+8LIVPZEHRSsMqIEemPeOzj
	dTgo9Rb854Y3M/5DDYuMhMFGLLWYBo9MNgTWsv7/B3vlFrPKl0ZyxKdUBa251SxtnG6iSqEopkD
	NQ3eaiOj99PyswSViHIIULMm3qcw3bn5t+LuuF8EV9cNerxIXGSml6UaNLP3Z/AC6mKrXpWqWaB
	MME7uXQf9SwTmvs7AO4dLjFnTZoUKgr51xg5DRUMeUUUQvPsDeDtAQo9s03MmwARguL8EGXvB3a
	agY3yEYl3lqb8ppwMv4s=
X-Google-Smtp-Source: AGHT+IGi8VRBTkcie2M82z62av9T1Lo0xgSLRRW+ViiR/xkeT8MTD0vEHx52CiLPrSexevn2OM8fgA==
X-Received: by 2002:a05:6870:9488:b0:2d5:230f:b34a with SMTP id 586e51a60fabf-2efb26d1599mr2456383fac.9.1750865371705;
        Wed, 25 Jun 2025 08:29:31 -0700 (PDT)
Received: from neuromancer.localdomain ([2600:1700:fb0:1bc0:d84e:5284:c7b2:e237])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ee8a8ea8a4sm2624297fac.24.2025.06.25.08.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:29:31 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:29:29 -0500
From: Chris Morgan <macroalpha82@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com,
	sre@kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, lee@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V3 1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A
 Charger
Message-ID: <aFwV2Xxyjhi6KQkw@neuromancer.localdomain>
References: <20250623162223.184304-1-macroalpha82@gmail.com>
 <20250623162223.184304-2-macroalpha82@gmail.com>
 <5qeo2xqjprozcjd553qmozzrmbciuf66gic65tzw7jspoub5n4@5wzkqasisgcz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5qeo2xqjprozcjd553qmozzrmbciuf66gic65tzw7jspoub5n4@5wzkqasisgcz>

On Wed, Jun 25, 2025 at 09:48:30AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Jun 23, 2025 at 11:22:19AM -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Document the Texas instruments BQ25703A series of charger managers/
> > buck/boost regulators.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  .../devicetree/bindings/mfd/ti,bq25703a.yaml  | 121 ++++++++++++++++++
> >  1 file changed, 121 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> > new file mode 100644
> > index 000000000000..0727f24b8e54
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> > @@ -0,0 +1,121 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/ti,bq25703a.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: BQ25703A Charger Manager/Buck/Boost Converter
> > +
> > +maintainers:
> > +  - Chris Morgan <macromorgan@hotmail.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/power/supply/power-supply.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: ti,bq25703a
> > +
> > +  reg:
> > +    const: 0x6b
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  power-supplies: true
> 
> Drop, redundant.

Acknowledged.

> 
> > +
> > +  monitored-battery:
> > +    description:
> > +      The phandle for a simple-battery connected to this gauge.
> 
> This part is redundant. It cannot be anything else, according to
> power-supply.yaml
> 

Acknowleged.

> > +      A minimum of constant-charge-current-max-microamp,
> > +      constant-charge-voltage-max-microvolt, and
> > +      voltage-min-design-microvolt are required.
> 
> This is fine.
> 
> > +
> > +  input-current-limit-microamp:
> > +    description:
> > +      Maximum total input current allowed used for both charging and
> > +      powering the device.
> > +    minimum: 50000
> > +    maximum: 6400000
> > +    default: 3250000
> > +
> > +  regulators:
> > +    type: object
> > +    additionalProperties: false
> > +    description:
> > +      Boost converter regulator output of bq257xx.
> > +
> > +    properties:
> > +      "usb-otg-vbus":
> 
> Drop quotes. Is this the name of regulator called in datasheet? To which
> pin this corresponds to? I cannot find anything on usb-otg or usb_otg.
> 

This corresponds to the VBUS pin. VBUS is an input usually but becomes
an output when OTG output voltage and OTG output current are set; OTG
enable is set, and a GPIO connected to EN_OTG is set high (per section
8.3.3 of the bq25703a technical docs).

> 
> > +        type: object
> > +        $ref: /schemas/regulator/regulator.yaml
> > +
> > +        properties:
> > +          regulator-name: true
> > +          regulator-min-microamp:
> > +            minimum: 0
> > +            maximum: 6350000
> > +          regulator-max-microamp:
> > +            minimum: 0
> > +            maximum: 6350000
> > +          regulator-min-microvolt:
> > +            minimum: 4480000
> > +            maximum: 20800000
> > +          regulator-max-microvolt:
> > +            minimum: 4480000
> > +            maximum: 20800000
> > +          enable-gpios:
> > +            description:
> > +              The BQ25703 may require both a register write and a GPIO
> > +              toggle to enable the boost regulator.
> > +
> > +        additionalProperties: false
> 
> Please place it after $ref.
> 
> > +
> > +        required:
> > +          - regulator-name
> > +          - regulator-min-microamp
> > +          - regulator-max-microamp
> > +          - regulator-min-microvolt
> > +          - regulator-max-microvolt
> > +
> > +unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - input-current-limit-microamp
> > +  - monitored-battery
> > +  - power-supplies
> 
> Keep the same order as in properties.
> 
> Best regards,
> Krzysztof
> 

Let me know if you have more questions about the VBUS, otherwise I'll
make the requested changes and resubmit.

Thank you.

-Chris


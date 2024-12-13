Return-Path: <linux-pm+bounces-19191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBB39F0EFC
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 15:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB36F161B91
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A5D1E0DE3;
	Fri, 13 Dec 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByIfWWQk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2552D1DF261;
	Fri, 13 Dec 2024 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734099572; cv=none; b=HkaMJBmAaa8wVlCFXqW/dJfJTeY+FkfRAfva6vJOs6PO3lXnj6Xprw9kXuaeho3VNFiQEuhDT+umepzq5A5oPiPw/6TvPgd8BOHTGR+dYhPtUr28lr9J3FjXt5OWMNVPeprm91wu9cBPNES3MCH/UxtCJMFuJNGJPj/6EpIrIzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734099572; c=relaxed/simple;
	bh=9KRAUOaUTs2X99/muAOiFNi0GSNZRVXkPIF4NwCwrYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADM/CToX+vNR5SKMBD+qCxlD7gvEgGe4KGen2DguiYP7gZMYPuSKO/EDY6wF0dZhmTeJarPHC1VMSUf1UDnA4hmJ4rapX4pOEugYiyA0QxKeJ7tQ8mfi14/UFsJhqjoT4yDhU1dbdkht2RLMsUVCKWKh3o7bmublvxIJWpZ8tFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByIfWWQk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-386329da1d9so888779f8f.1;
        Fri, 13 Dec 2024 06:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734099569; x=1734704369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OM+UA2EEJij8vAk4gBi+HR9PMM+3lXgIbxqXHxRaWyw=;
        b=ByIfWWQkIGVwvavupgcvc7dKOrQVTsw3HNaB9afZSal9wX+lANPRInGcpTS84HNwzN
         WOIyfd6LH7EmfRfRsoNnAbUkwuhVDtAOdIXoufpml5pY6d8jjjhEClxewJhKYn1rpw5/
         pwBG3V22FoocCnyntllIYQVKWCj6LANwKn/zMq7cy0pjuk2usJlD9c664nW1vt5qoS8p
         EAwYxpBB6GsaEU+e2J3rYwjuOCYOW0Qx8SJIy0JhCDhI8JFvy6C/gKzDRF9M4TxU6O8n
         wVj7ysiCEfJP9T/o8NwuHSxyoEYbn70v0d+os3KoTb78NLlo8I4C5K3S0QsEETNEq8BV
         bLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734099569; x=1734704369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OM+UA2EEJij8vAk4gBi+HR9PMM+3lXgIbxqXHxRaWyw=;
        b=ZJHYgpd3AZfNNboYLGBKMFVjQHyyfxZ/YokzUSvWm3Q8BM0FCw9LDbOL/23ZLJLLpd
         +ZK/CI0SXk4fFtt7dtGuY+i9yPK2wWXeO9hOdMZXBplTajZ2s8+a4UnjKi167MOqXqFN
         XKfux5mp+w738k7PlsVAtCSudD6pHq2xxE+1MA4GfnC5id28w49QQwL3WFFJxk4Guiow
         6pIItvNQsDsyPP8a4waxLp9usBZhj3yaM89aBb8Jtz0ZSmeSxRX7bS+CHGPZfxAVYQin
         21AxolyqBnbGRcy/wisxVmVUNPUNfOdJhfuAUn8TUXFta3YZYqE14jhnkVIV0BOBTtx3
         8ULA==
X-Forwarded-Encrypted: i=1; AJvYcCViP7MxQI5f6uYjgnYpIn8ipoknQpIRQCmia7BTlw8ufCdxZs9FixbpJT6dbUBDVXSdfNDaD2703qw=@vger.kernel.org, AJvYcCWdxIW9i9NnH6a2H025PVpFv16ie8j+OdiAlsE806pE09VDDmeP3ubWo0qIK3+td7lvBYcH6xQu/57H@vger.kernel.org, AJvYcCX5Udp7j/q9cyFNS+LUCGuwnPV6CtTAwZRmaQ7LJiU3+ln8sEpSuQw/HQivVmwOCscPHJpNWv7AzgNdlBB4@vger.kernel.org
X-Gm-Message-State: AOJu0YysUUR7HeDZqS3MWFmpQWqGRIF375Ft0KvUmTTQGTIqZC+xD+Oy
	dX8tJ48mTpsjrpdXlTzgLcUkRMycCILdmkRzwN2lRctJdjigqmi9
X-Gm-Gg: ASbGncs+ydGo5Ri3v4twGCYdG+m2J8MusLViCxqBYs2k9I4SL+kybUMj0s1EDqim/QG
	V8jR8eznybrmzP4s1J9iyhQB6ocVhmoIJPqOv9BkLqf3QRSakUofA2+j5myL8n9MTelZlg1+809
	EogkaqWu1eoy/MTRmDrkMcl02xG45MNAaFfmsE/GiDBoCfI9VKY5/1u9M/D4YJwWlClokX5/GBu
	IOr+sX30oKJPxC3mU91npR1N6TJ3980iBaBMmre07D2hNJmLl2d5g==
X-Google-Smtp-Source: AGHT+IH2XHWhpVgn7QFZkhM0tYTCyuj0UYjLaUat7NS5gwaYL/sRyLik/b7e2C5Q56yl4uHJODlFgw==
X-Received: by 2002:a05:6000:402c:b0:386:4a0c:fe17 with SMTP id ffacd0b85a97d-38880ae1306mr2270422f8f.27.1734099569137;
        Fri, 13 Dec 2024 06:19:29 -0800 (PST)
Received: from debian ([2a00:79c0:66f:7700:6a18:698b:dde4:1f55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362557c457sm50944575e9.15.2024.12.13.06.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:19:28 -0800 (PST)
Date: Fri, 13 Dec 2024 15:19:26 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: gpio-charger: add
 support for default charge current limit
Message-ID: <20241213141926.GA3920@debian>
References: <20241211-default-charge-current-limit-v1-0-7819ba06ee2a@liebherr.com>
 <20241211-default-charge-current-limit-v1-1-7819ba06ee2a@liebherr.com>
 <4lef2r5lblj5waulkc56xbfa4xnlxbrk7rawdjgmkatgfnlj3z@vmtcvza6wcna>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4lef2r5lblj5waulkc56xbfa4xnlxbrk7rawdjgmkatgfnlj3z@vmtcvza6wcna>

Am Fri, Dec 13, 2024 at 12:00:46PM +0100 schrieb Krzysztof Kozlowski:
> On Wed, Dec 11, 2024 at 08:29:09AM +0100, Dimitri Fedrau wrote:
> > Add binding for default charge current limit.
> 
> Why?
> 
See below.

> > 
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > ---
> >  Documentation/devicetree/bindings/power/supply/gpio-charger.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> > index 89f8e2bcb2d7836c6a4308aff51721bd83fa3ba1..545fdd7133daf67b5bc238c5af26d0cbd8b44eae 100644
> > --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> > +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> > @@ -58,6 +58,10 @@ properties:
> >              charge-current-limit-gpios property. Bit 1 second to last
> >              GPIO and so on.
> >  
> > +  charge-current-limit-default:
> 
> Use standard property suffixes - see other bindings how they define
> charge current.
> git grep charge -- Documentation/devicetree/bindings/power/supply/
>
Will fix it, thanks for the hint.

> But what I don't get is why GPIO chager needs it, since this is
> non-configurable for GPIO charger.
> 
With properties charge-current-limit-gpios and charge-current-limit-mapping
one can define charge current limits in uA using up to 32 GPIOs. At the
moment the driver defaults to smallest current limitation for safety
reasons. When disabling charging should be possible as in the example,
the charger defaults to non-charging. By having a default the charge
current limit can be setup on probe and charging is enabled.

> You have entire commit msg or property description to explain such
> things.
> 
Will explain it in more detail.

Best regards,
Dimitri Fedrau


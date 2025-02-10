Return-Path: <linux-pm+bounces-21691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4933AA2EC72
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 13:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5783A486F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 12:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9370F221DBF;
	Mon, 10 Feb 2025 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEjovmCi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020F20CCE6;
	Mon, 10 Feb 2025 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739190580; cv=none; b=n2vSJgivaRB85hf5VX4rn/JlI8YIn+yO9NP6CE7QuWVtQtqa/HtU8d1SMZl23wzxEspmoMB589AvzkKzgLGfKYeI2iM6JLr4jfLrV/7kAe5j4zGn8yo0zXBwPZNbnmUUh5TP4gvBNaElAhN1BSQsXQ2snar+x60WNgRiiP7vXUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739190580; c=relaxed/simple;
	bh=IuFvjydOw4L18BbCARPfPkycdVqb1Ih2e3bRySBUmBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V93BKWG/l2ym7NuAA5qQBAhyB31XqUFcTAvHR7onhwcEWQF9Nkfgf8P6qD6Uc7RRO0fZmfNc5H9Bto8K8qe1hYYjW25ZfMou1D5bqUY5rOabPk3JrQKRxHdAmLBaPBRRu8sMYcAGnle5k08zL+QXHNSr4Paza3E1laAklndd28s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEjovmCi; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c0566511aaso211372085a.3;
        Mon, 10 Feb 2025 04:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739190578; x=1739795378; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zY41R75BtToe8Yp09lMS5d4lVXKY/PmgZc/Js0T22zQ=;
        b=WEjovmCiwD6Zvcbb9k/o/qouVVH4u0TTIvb+qFLzNPfiKGj9UjSsZZuv5XzC13p/ng
         C2yt81kz0Y5H8myCSIIDRe14u/whOTUypbHn9JRFy08OSn9i24wf5n6rGKUrPi7WDLJf
         k/9aHybT5hIdkVcWlQQYuhah3FqMgQCu3WOu6n1XAlwdc5TR+mjvuwY2Hk7mVouCiXpM
         S28dwljEq7QBijo9OjQ4h4SAFUPGgAd81nSbDvwUQKXTegj8UKezSBp0y1voeKtk4ceA
         svcrgAb04K0Y4bj0+50wuTHcIFgo/14VUgN1NOUGb0L+2QJ9Zd/a10UJJ0aYgaluxMUL
         oKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739190578; x=1739795378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zY41R75BtToe8Yp09lMS5d4lVXKY/PmgZc/Js0T22zQ=;
        b=pGwSeenB59vShWR0kcABkB78ZOeLvfnS9/fwH+TKIKni63DmEen9utKZlUhkVqhLAA
         yVnsTbSL3RWv8c/dt45eWu1XwrebNPawyVDHP1SPcCuRjs59P8HnqVzEW6h3kpqf5yZD
         w7xsjO+JMqEKoGBt2GV3o8rPIfy9KtL5+uYGDRlACmzXfkRauru1TL+XlzeY8J8MK2D0
         iaRNE+UhRw828/s0Cn7r2DSrFBOXvW4hxOdZQYmkM2n16bmHBow0hntqEHeqNA4olkvf
         00eqUdbQXlZAngkdYt3Z/NINlyM+fObuPaXczFQRFvU8co73tYEqWv7W2vmWTiVTEH8J
         l+WA==
X-Forwarded-Encrypted: i=1; AJvYcCVN6Ip0jSQefMhDqbzjG8i53uNQla99XKtN2/lv/g8VN+0k6omq621inockvFs6pPqPeTGQMaLENDce@vger.kernel.org, AJvYcCWo2GgD2byf+OFiInxVB0Os38kgVewuchViCqsKNAxM9mhVnHqE1E5q5lBZOYi/BOhCQAISgaM4CpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtruxO1FqjBREDYJTepvVEujAyKldgoQKOIznn8UjxJ6KVy/Ph
	rQssv58oysv0LAIeF/R8HKqCIhbkJ5i8MUcH4NEdmFxTdjMM1c6TyEgH9g==
X-Gm-Gg: ASbGncvIgLVSVs5ul9heR4FvuekDegsvcFOMW/9GEgkoS2uUyPqaCq4hNXgj0O6+9T6
	A3JGgQI/WS4aYd/Kih4xSfUcxYCKSv0nc4P3Q1zYIYZ8Cp6a1q4IFIV/8noLCv/+FSrFHWjjt6e
	SsCf6TUHT5kMwvgbg4eUvmghpzbfW9kAg4xcW5mt+ONSuJhzXQHkvSKTq4iDh3SsdH8JKLi0KDF
	LcGWrQVCMPhql3fPRVfAcTZPWK8IKJ3MZoXBaPyXLjdIIX/4NSdgitSd2+ilAq+Nn4=
X-Google-Smtp-Source: AGHT+IHxp1/RlBBU1ek47PdaAYXfy4dhK7yLqQmOezqp2bSrFyZup9k7QBohFKb20v0D2hY4RciUgA==
X-Received: by 2002:a05:620a:319d:b0:7a9:c129:5da7 with SMTP id af79cd13be357-7c047c355c8mr1853489885a.29.1739190577686;
        Mon, 10 Feb 2025 04:29:37 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c05dffd3bbsm137289185a.45.2025.02.10.04.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 04:29:37 -0800 (PST)
Date: Mon, 10 Feb 2025 20:29:31 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Inochi Amaoto <inochiama@gmail.com>, soc@lists.linux.dev
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, Haylen Chu <heylenay@outlook.com>, 
	linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH 08/10] riscv/arm64: dts: cv18xx: Add sysctl and reset
 nodes
Message-ID: <mcixunylnco2obzrvqn4emaq3vey2zvkdggybymrm276bcgrsi@ck3nta7w576s>
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
 <20250209220646.1090868-9-alexander.sverdlin@gmail.com>
 <h73zitljaig7nrccd3f23i655imswv54tf667dhq3dord7rxsr@unqncqlorvc6>
 <e17ef70f7536bd1bf0b4d0f7258f91cffac76a20.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e17ef70f7536bd1bf0b4d0f7258f91cffac76a20.camel@gmail.com>

On Mon, Feb 10, 2025 at 12:47:59PM +0100, Alexander Sverdlin wrote:
> Thanks for quick feedback Inochi!
> 
> On Mon, 2025-02-10 at 13:13 +0800, Inochi Amaoto wrote:
> > On Sun, Feb 09, 2025 at 11:06:33PM +0100, Alexander Sverdlin wrote:
> > > Add reset controller node and required sysctl nodes.
> > > 
> > > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > > ---
> > >   arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi | 16 ++++++++++++++++
> > >   1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi
> > > index 53834b0658b2..d793b6db4ed1 100644
> > > --- a/arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi
> > > +++ b/arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi
> > > @@ -309,5 +309,21 @@ dmac: dma-controller@4330000 {
> > >   			snps,data-width = <4>;
> > >   			status = "disabled";
> > >   		};
> > > +
> > 
> > > +		rtcsys_ctrl: syscon@5025000 {
> > > +			compatible = "sophgo,cv1800-rtcsys-ctrl", "syscon";
> > > +			reg = <0x05025000 0x1000>;
> > > +		};
> > > +
> > > +		rtcsys_core: syscon@5026000 {
> > > +			compatible = "sophgo,cv1800-rtcsys-core", "syscon";
> > > +			reg = <0x05026000 0x1000>;
> > > +		};
> > > +
> > > +		soc-reset {
> > > +			compatible = "sophgo,cv1800-reset";
> > > +			sophgo,rtcsys-ctrl = <&rtcsys_ctrl>;
> > > +			sophgo,rtcsys-core = <&rtcsys_core>;
> > > +		};
> > 
> > I think these node is not suitable for riscv. It should use SBI SRST
> > extension to restart.
> 
> Independent from the particular form, or its correctness, this is still HW
> description, right? It would be a "policy" for the kernel configuration, if
> the particular build would rely on the FW or a kernel driver to reboot.
> 
> In other words, the HW block remains in place, no matter if it's controlled
> by a kernel module or a FW. What the point in hiding it from the RiscV part
> of DT, keeping on ARM64 side only?
> 

Yeah, I have make a mistake, the device is needed. SBI need these
device definition to handle some power event.

Regards,
Inochi


Return-Path: <linux-pm+bounces-15654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A1299EB7F
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 15:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD031F25D59
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 13:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9531AF0B1;
	Tue, 15 Oct 2024 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="i/Xfs3Ef";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="E7ya//8L"
X-Original-To: linux-pm@vger.kernel.org
Received: from bayard.4d2.org (bayard.4d2.org [5.78.89.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79961C07FF;
	Tue, 15 Oct 2024 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.78.89.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997666; cv=none; b=RMgU2OA6Ef8ObQwSv9arT/jmTRk6y2qHRwwAWPumxsu1itL3R2+qfS+i9lUT6/5l5qr3kjH9osRTUhlQ2tM8pSymzVU5pe/SDOPv/9pr/QfZn9MRjKZC+dNme/t0fdxF2+cWAh6YbIl9oHRIT3c0s+4U/pRdkPLlTpWPtaT1azU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997666; c=relaxed/simple;
	bh=z8CMqF1Qkrr11chR38o4qGiOfMIibQckV72yf00J/J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+gL9Bvy1V4X2gmIiHqqjBTW29sTCb3vIlA99FgvvFEq5xkAvfJESARS2hmCbA4P1t4yZbmDncyv7SdltLBffIuDoMbEsfr6mLUaPPiV66kqSpZjdyMW9AIv9vmQNbFHWn6hZ/XjBRH4smAMvMn6qUdmXgD2MDKaJgUCXAtPP+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=i/Xfs3Ef; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=E7ya//8L; arc=none smtp.client-ip=5.78.89.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 68EC7122FE21;
	Tue, 15 Oct 2024 06:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1728997656; bh=z8CMqF1Qkrr11chR38o4qGiOfMIibQckV72yf00J/J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i/Xfs3EfOWgr0NZuSh+H4k6e3qGH2F/B9PnPqW3VW+740K0nPmK9nkFAsT667IK/A
	 Xmt2BLwhU2JZsCkN+DGTH8bNVCIZZyivM6+cQxxLdr0TrrdXs8Gj6OE0qZLsNKXJs9
	 lfsp53kARAC1XHOb9bkKmzeYPh4UKZFdZTudtpaQ9rBxszrF2EiE8l2VoUC0gxv31k
	 mTDERgn4QqE9TDGyiStvylX5DwNyAUig/AwXzovZoE3EMUtBQi77zEdu0K19X8mR7H
	 mCzwRy+xbrdybg7HI1UqhkT2vQBHTDmuwkb4WACoXGxrZXynuqZ9J4VlEH73C/x1qS
	 PMKgMYZ9suxfA==
X-Virus-Scanned: amavisd-new at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OkmRudQO2a8g; Tue, 15 Oct 2024 06:07:33 -0700 (PDT)
Received: from ketchup (unknown [110.52.220.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 99CB0122FE1E;
	Tue, 15 Oct 2024 06:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1728997653; bh=z8CMqF1Qkrr11chR38o4qGiOfMIibQckV72yf00J/J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E7ya//8LT+6l88z0sqOEUvAZ3tXkFMTajQE+HilwRcmp3JqyvcM+MDr75SHUiiUEX
	 kdqUQojZVzKbbrVTh3WKRguUqy5uWAO9FMg/TAjgltU+QIlBzz0g1wpdkRB7lhNBLO
	 zR3BOol17M6FEribXcTnomnXCm/jxaZxfrGrmxNlBVcI6mmTiHtHmtsa34IrsI05yj
	 NNP3I+Vtjwgq6M5D2+OLvukn9uG2X4lNgteg8lEXh+8/Twv+Tq3wpEPSAtSKp4tWvq
	 Jftbn2xZoBeEtkPKz5y3SWiRs6YcgGlwj8tiTOY9ZIpYk7Ceu0Tzmz+AFfVg99511x
	 ihEp6vcWORHiA==
Date: Tue, 15 Oct 2024 13:07:19 +0000
From: Haylen Chu <heylenay@4d2.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/3] dt-bindings: thermal: sophgo,cv1800-thermal: Add
 Sophgo CV1800 thermal
Message-ID: <Zw5pB_tPuOgIbaxV@ketchup>
References: <20241014073813.23984-1-heylenay@4d2.org>
 <20241014073813.23984-2-heylenay@4d2.org>
 <cycdlsi3tb6nqgbzzmypmblpcxxqmn3slqcbf5mq2okw3lqrdr@ghvswymvnslp>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cycdlsi3tb6nqgbzzmypmblpcxxqmn3slqcbf5mq2okw3lqrdr@ghvswymvnslp>

On Tue, Oct 15, 2024 at 07:52:33AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Oct 14, 2024 at 07:38:11AM +0000, Haylen Chu wrote:
> > Add devicetree binding documentation for thermal sensors integrated in
> > Sophgo CV1800 SoCs.
> > 
> > Signed-off-by: Haylen Chu <heylenay@4d2.org>
> > ---
> >  .../thermal/sophgo,cv1800-thermal.yaml        | 57 +++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
> > new file mode 100644
> > index 000000000000..14abeb7a272a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/thermal/sophgo,cv1800-thermal.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo CV1800 on-SoC Thermal Sensor
> > +
> > +maintainers:
> > +  - Haylen Chu <heylenay@4d2.org>
> > +
> > +description: Sophgo CV1800 on-SoC thermal sensor
> > +
> > +$ref: thermal-sensor.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sophgo,cv1800-thermal
> 
> Not much improved, judging by other patches there is no "CV1800" SoC,
> but that's a family name.  Otherwise please point us to bindings or DTS
> using this SoC.

"cv1800" is referenced in the clock binding[1] and usb binding[2]. I
don't think there are other CV1800 SoC variants. Usage of "CV1800"
should be specific and unambiguous.

Best regards,
Haylen Chu

[1]: https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
[2]: https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/devicetree/bindings/usb/dwc2.yaml#L62


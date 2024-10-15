Return-Path: <linux-pm+bounces-15656-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B9099ED2F
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 15:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BCA1C22B3C
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 13:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799F11FAEE9;
	Tue, 15 Oct 2024 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="qjUCldBF";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="vnMZI+8p"
X-Original-To: linux-pm@vger.kernel.org
Received: from bayard.4d2.org (bayard.4d2.org [5.78.89.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96BC1FC7FB;
	Tue, 15 Oct 2024 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.78.89.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998474; cv=none; b=W7YPl4ZZSV+rEWFLQt6owBN51R7a9axjzNqS7wPnLFLR0L1FTXjsG5fKSpGPidO9w8rSFkKCvLoDN3dnsU+JyN33w6dbPMYBq0BD+oUxHyU+voZxJaIQb1ORyKlt0jLchJ5r+ATwqVrIO+N0HfsLcnQ4h+YSR5Ir8BcOSMLMwyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998474; c=relaxed/simple;
	bh=BifDifB6wdUvkl5Iu/cIT7h0gvstAeks818zu+TYv74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiQBtsV35NwZewh3b7BBefJmPLBsqDwUeFW9MkPVqmrudrrccdjHeqdWjKMAc5shccOo+xkds7g3eazal4TW/NZ5a/T1bOW71Ray+3q2MPuyw3oL9DSDQEEsnEev8v/1C7eLglyCjACB45JWbBSVCsPSIANCMP865gRmNH3QuTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=qjUCldBF; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=vnMZI+8p; arc=none smtp.client-ip=5.78.89.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 1A234122FE21;
	Tue, 15 Oct 2024 06:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1728998472; bh=BifDifB6wdUvkl5Iu/cIT7h0gvstAeks818zu+TYv74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjUCldBFec5UnpTkUwhnE14W7FBEE7CGTFEWgvSSW8YP4q5cXW85B80/5znrdIhvE
	 YSgz3uRlW8xACFzs1pyfp0lMZoYWDMUtRsMhZAiqyXdqjNhGg9nQR8weK3velaT1Rw
	 YOQI9JHF6+ywyFKZuA3per0KMo/g65m3LhG6sQ/dhwuALlB2bBLhMjuBB+POoYix/h
	 1bwrw3U/UZowAlizH+fbYZqmNwLcU1yEETVW3OVaLSR23eCVGXgWpjTUwl89DeNkjs
	 KEORSaahgeaZ/HPFnXqeJggxQAVXt7vhA9NQk9JgtiOcSWKqaCkV6+8D+E/meRm4p5
	 HB0izStlZSdew==
X-Virus-Scanned: amavisd-new at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 59EUaKZiQaZK; Tue, 15 Oct 2024 06:21:08 -0700 (PDT)
Received: from ketchup (unknown [110.52.220.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id F1E91122FE1E;
	Tue, 15 Oct 2024 06:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1728998468; bh=BifDifB6wdUvkl5Iu/cIT7h0gvstAeks818zu+TYv74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vnMZI+8p5fXNQrO5i/2EDsem9c/EUus7ofhbdg/7N+T70XusEsqnVOpUrIfzU1sA5
	 dghyXpOG1v48hoT77sv7mlqriSd74qa5Fdw4iirLnW/DqBdxQpM5e0Nji+dk2xds5Q
	 /zoy6xucE6lhrJeT4/nsOAQOFbaUeHC/ZV5lsXy1R5y2kRqVKrwJtglhY7KGFBzuNY
	 gsT6VD135fSlZgNzJo7Q1j2ozWvNkJlHQUErAPTKHhlB00UzvDAg6Wt8BVAhSfBNG8
	 r7cJRju+03XLm+owuPVX05aY5jLxJEgDkFVt29eZJoQ6qccKePiURH0u9x5kD6Bi2R
	 3c6zUv9dQSMNA==
Date: Tue, 15 Oct 2024 13:20:54 +0000
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
Message-ID: <Zw5sNqiradqQzmDD@ketchup>
References: <20241014073813.23984-1-heylenay@4d2.org>
 <20241014073813.23984-2-heylenay@4d2.org>
 <4ey46hxumhldwrbzalyw6xzn2l52cejggxvg6e3imus3qqzsjn@r55xpxvkpodu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ey46hxumhldwrbzalyw6xzn2l52cejggxvg6e3imus3qqzsjn@r55xpxvkpodu>

On Tue, Oct 15, 2024 at 07:55:10AM +0200, Krzysztof Kozlowski wrote:
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
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  sample-rate-hz:
> > +    minimum: 1
> > +    maximum: 1908
> > +    default: 1
> 
> 1. Why this is a property of a board?
> 2. I do not see this property defined in any common schema and I am not
> sure if it even should. Sample rate appears from time to time, but not
> in context of thermal sensors, so this should have vendor prefix.

Thanks, I decide to remove this property.

Best regards,
Haylen Chu


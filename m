Return-Path: <linux-pm+bounces-15769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3099A08C4
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 13:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7E91C21D62
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 11:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD6B206953;
	Wed, 16 Oct 2024 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="XqwlxG7J";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="GioSXe3Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from bayard.4d2.org (bayard.4d2.org [5.78.89.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37F618C33F;
	Wed, 16 Oct 2024 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.78.89.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079612; cv=none; b=N4HhOfWfUPXO62atfY2LHzKatMRB9jVxeSGkpzjSM++05BTdlbhLf2W6rBuIF+0l9kpKsUDEThl64xZwbMrnOUwFKRD/k+gLEBp74I/SxoGol0H7l/v5KPSLUsI5DDevgm4M17rYkgpPo9lGtJ3gepTE+egUwQV6TbsPk1YCs50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079612; c=relaxed/simple;
	bh=CTpiaDVehmXWFhKu5lgDz2DkL+bIx6aeyS54Njzjx58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/xbWPYQNRxn1GKc3qiYw/mBiI6UsQSUboTkFns4VeTqRbTQbV/CsVMRHXVCzhGQMH/tDNDf2sRdPe6PF0M0qh5wlGcCErItNlhkrrW9Q4DNlo85303YKDnI56ZULyx2n+ItC/fdOe++MMPmZa2PQHvsNk9uTrKwyRimZNZmvqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=XqwlxG7J; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=GioSXe3Q; arc=none smtp.client-ip=5.78.89.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 770AF122FE1E;
	Wed, 16 Oct 2024 04:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1729079607; bh=CTpiaDVehmXWFhKu5lgDz2DkL+bIx6aeyS54Njzjx58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XqwlxG7Jg7EWThrj0kMZB7pZIoFKdmLcsMm15ZPbDnnqEwhMrz+tP49GI77kcjM5H
	 /uBwpDgn/vQwQmhSn06e5Yy99T0YDzaLfZQJSGL2IuNvVnlMB/38Img7YRZ+AyfMBF
	 q1K2oMcyyiqAxhwe4LwK4noYwIxWjsOQj3rRFi7UBMXhw3KQCigOoEPqogDoTIDEK/
	 24qy3Jy9pm3WInomUvc5P3R8unqws006XJ8zsHb/cjpzAAO76JlVlkA8CdOseLn4kM
	 8UaaotpJfU2aaeBiLA6iksDeFbvJz4fYYcgGmLtsIbqbX9Cs70Lwc/mjav26KMFag5
	 newCSmHJS0DBQ==
X-Virus-Scanned: amavisd-new at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jf_V3Wg6a8EV; Wed, 16 Oct 2024 04:53:23 -0700 (PDT)
Received: from ketchup (unknown [110.52.220.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id C2FA3122FE1A;
	Wed, 16 Oct 2024 04:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1729079603; bh=CTpiaDVehmXWFhKu5lgDz2DkL+bIx6aeyS54Njzjx58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GioSXe3QFkH+QnXkKfW+YY/sPo3GPqHoEqjhjnUEUzkXDGi+6AlgS158RWy6hTJW1
	 j7vsb0rq0azKBqFomIzGUlZQplNzjzYfcOr+Rkcv5mJSB7qSDE0y3mkS2nvkCr0soh
	 fBpJsFyyoXyoB/19/uZcvV4ygf4D2/D0Yotol/NjjaHKmkNLHqyfh+T3TSskWkWDBl
	 vJO1BXZe+E57Z+qaQl8WTkICG3saUxubSBulfyrtDGyU/enCDdGYVwPBIgkXupHRcm
	 brTT7mPcnbAK3lIWRnvaJujdn2M0l5L4k3uNYeUIn+ivAxxONdlA5Fp2CV+li4lPP5
	 yFIVoXdDm/Cdw==
Date: Wed, 16 Oct 2024 11:53:09 +0000
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
Message-ID: <Zw-pJZ0jhxR8Oggk@ketchup>
References: <20241014073813.23984-1-heylenay@4d2.org>
 <20241014073813.23984-2-heylenay@4d2.org>
 <cycdlsi3tb6nqgbzzmypmblpcxxqmn3slqcbf5mq2okw3lqrdr@ghvswymvnslp>
 <Zw5pB_tPuOgIbaxV@ketchup>
 <e6012be3-01c8-4ff8-bb52-9334c7490c78@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6012be3-01c8-4ff8-bb52-9334c7490c78@kernel.org>

On Tue, Oct 15, 2024 at 03:34:39PM +0200, Krzysztof Kozlowski wrote:
> On 15/10/2024 15:07, Haylen Chu wrote:
> > On Tue, Oct 15, 2024 at 07:52:33AM +0200, Krzysztof Kozlowski wrote:
> >> On Mon, Oct 14, 2024 at 07:38:11AM +0000, Haylen Chu wrote:
> >>> Add devicetree binding documentation for thermal sensors integrated in
> >>> Sophgo CV1800 SoCs.
> >>>
> >>> Signed-off-by: Haylen Chu <heylenay@4d2.org>
> >>> ---
> >>>  .../thermal/sophgo,cv1800-thermal.yaml        | 57 +++++++++++++++++++
> >>>  1 file changed, 57 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
> >>> new file mode 100644
> >>> index 000000000000..14abeb7a272a
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
> >>> @@ -0,0 +1,57 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/thermal/sophgo,cv1800-thermal.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Sophgo CV1800 on-SoC Thermal Sensor
> >>> +
> >>> +maintainers:
> >>> +  - Haylen Chu <heylenay@4d2.org>
> >>> +
> >>> +description: Sophgo CV1800 on-SoC thermal sensor
> >>> +
> >>> +$ref: thermal-sensor.yaml#
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - sophgo,cv1800-thermal
> >>
> >> Not much improved, judging by other patches there is no "CV1800" SoC,
> >> but that's a family name.  Otherwise please point us to bindings or DTS
> >> using this SoC.
> > 
> > "cv1800" is referenced in the clock binding[1] and usb binding[2]. I
> > don't think there are other CV1800 SoC variants. Usage of "CV1800"
> 
> There are. git grep cv1800
> 
> > should be specific and unambiguous.
> 
> And other places have different name.

Okay, will use cv1800b in the next revision instead. Thanks.

Best regards,
Haylen Chu


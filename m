Return-Path: <linux-pm+bounces-23494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5960CA5043A
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 17:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40DC2175074
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 16:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922FA250BF2;
	Wed,  5 Mar 2025 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZivWpuY3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6461A24A07A;
	Wed,  5 Mar 2025 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191034; cv=none; b=aKngFtcsjFAAs5d5vhHEUpzzF5VFY44G8DomPg2QtnXhGp4oPh34rWRhXXzVNHCZ/iAf+4fVaFaM3Wi/jlKaoj2dMKmyQGRZJSOZgabsU36iGzJUnVX0Qn510fBmC/kqVA4M4qB+/zsoj7nWlK8+vE+V4NH2+63iEi4xzgojf50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191034; c=relaxed/simple;
	bh=NuzZ1W9S6mA+Pg9tyI3RTRMxgpOiMuBenFty3J3Rgy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGRIMQMsqfzCV/1Ose137SC5chhcwm3DUyAzQAkPnziFsNMaRU6SkilHs7/Fxgnf6aUJdOyxQh+GOHc73ptnQZSnBjnRnEZ8znO2LYeEISNvga0Vh4z08XFlZqLDAENhdaP3Xj73b7liQJn2+qMsKTKBxKNIWoaMGA902oonx4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZivWpuY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3ADC4CED1;
	Wed,  5 Mar 2025 16:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741191033;
	bh=NuzZ1W9S6mA+Pg9tyI3RTRMxgpOiMuBenFty3J3Rgy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZivWpuY3laRUWhZhuByMXRUc0TlOvrWH6dbQtLBoUUzxX3y1vXxgcu5EcPnk28XS3
	 T/VeBVjXXeSERqjnC9t9XjOFinEqgQDbwSO1m+6x3ft+ZomOY87LxUHneFm/LcPpst
	 luumKC2HBXDUKd5MMbWjMj0lBAspP3PMl7N7/YVOT1wDTWihzajfExwmKwJAX+LVNR
	 OdX24Tvo+BKFl0/u7jAcqrmEtArZMiuZd3l1jc1ewagg9kMwYv2AQz7N1ta6b1t9y4
	 Nuqv8y4iGKh0bbt+QzcFRG+3NJLVhgmjAP7UxP7MKovwFph+jzVdQNGCqKkEsz0gOd
	 0nwZVkRU0p5pw==
Date: Wed, 5 Mar 2025 10:10:32 -0600
From: Rob Herring <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: thermal: generic-adc: Add optional
 io-channel-cells property
Message-ID: <20250305161032.GA2068051-robh@kernel.org>
References: <20250303122151.91557-1-clamor95@gmail.com>
 <20250303122151.91557-2-clamor95@gmail.com>
 <08f305fa-0dbe-4ed9-bec5-cf8b5bbecfdb@arm.com>
 <CAPVz0n0G+0_f3MONV0Y-tYAb1KOwkUNiY2Pms8CZ6ZGtxRmFFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n0G+0_f3MONV0Y-tYAb1KOwkUNiY2Pms8CZ6ZGtxRmFFA@mail.gmail.com>

On Wed, Mar 05, 2025 at 12:03:20PM +0200, Svyatoslav Ryhel wrote:
> ср, 5 бер. 2025 р. о 12:00 Lukasz Luba <lukasz.luba@arm.com> пише:
> >
> >
> >
> > On 3/3/25 12:21, Svyatoslav Ryhel wrote:
> > > This implements a mechanism to derive temperature values from an existing ADC IIO
> > > channel, effectively creating a temperature IIO channel. This approach avoids adding
> > > a new sensor and its associated conversion table, while providing IIO-based temperature
> > > data for devices that may not utilize hwmon.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >   .../devicetree/bindings/thermal/generic-adc-thermal.yaml      | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
> > > index 12e6418dc24d..4bc2cff0593c 100644
> > > --- a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
> > > +++ b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
> > > @@ -30,6 +30,9 @@ properties:
> > >     io-channel-names:
> > >       const: sensor-channel
> > >
> > > +  '#io-channel-cells':
> > > +    const: 1
> > > +
> > >     temperature-lookup-table:
> > >       description: |
> > >         Lookup table to map the relation between ADC value and temperature.
> > > @@ -60,6 +63,7 @@ examples:
> > >           #thermal-sensor-cells = <0>;
> > >           io-channels = <&ads1015 1>;
> > >           io-channel-names = "sensor-channel";
> > > +        #io-channel-cells = <1>;
> > >           temperature-lookup-table = <
> > >                 (-40000) 2578
> > >                 (-39000) 2577
> >
> > Do we really need this change in the DT?
> > Won't the code in the thermal driver that registers a new iio device
> > would just be enough?
> >
> > I agree with Rob that it looks odd.
> 
> Building tree will complain on missing cells property if you try to
> bind it. It is not in required category anyway.

Sorry, I don't follow nor see why you need the property if there are no 
DT consumers.

Rob


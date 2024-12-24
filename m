Return-Path: <linux-pm+bounces-19732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 099849FBAC5
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2024 09:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA3E16215E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2024 08:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009CB192B71;
	Tue, 24 Dec 2024 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7KL2Pd1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A7118E764;
	Tue, 24 Dec 2024 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735030423; cv=none; b=OshjFRhbG5rDHxntUxUtDh4rB7lv9na4MKWb8keuD2395cDMG8buNH3MI4hRLFFTRmzDc7f8VaJQ+yoqwtZo4gioEPSyyfWa8nChOE78+qmwmZaV3MjQLEiEjoY+PHsGssJU6TpJq5t1JtAz9G5seqI5QDAhEPVAbZTsdY7i5K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735030423; c=relaxed/simple;
	bh=oyUzWxScHY5JktUj76SAcLkQhUMTi1JD+++R1xKImUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDGvW+gJXJWaR1jtWrPxbv+xitc+dyEOvc+mDzxrccuhLNPiYFMZrymrsFTIEQuM7dMuHcSUxdkTczgJj4aqibQ919SNN2KlOyjK/1sJbNSBd3cMWtvHoNyo1lOyh7jbFqt/L2oLjnDR8oVIY1q3UQ2HdZxPLcl5CfQIZQtypUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7KL2Pd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E809EC4CED6;
	Tue, 24 Dec 2024 08:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735030423;
	bh=oyUzWxScHY5JktUj76SAcLkQhUMTi1JD+++R1xKImUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l7KL2Pd1eMbG7+IT5VzXzp8TwyhFDFBcm23dLtuEz+116n5GY9T5D7jFK0D+erV4/
	 veBzuVbQU42IOdqMG0K3gJhluGz+D3/zi7a5PWcNqaB05v5N9+V/xzK8xbsWC+yVv/
	 rjeRu+DpmOi95fF1JUHmGhuefWos3vvEjkkqJKssLscFggqVdixexfdYHiSC1BEN1t
	 hNa1F7AACRErlNXOJ+X9cWYgZ9RumXmVJ68gq58V5MOZzOdu2vrfCBPYeJi2/vzzyQ
	 k+qqyyyk4N612rDQJEKvdPm7Ppzi+jO6ABhJOuFpyMInHhPtIGo5cs1KvT8tcqVz09
	 HQ1RMLWnIt/+w==
Date: Tue, 24 Dec 2024 09:53:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, airlied@gmail.com, 
	aou@eecs.berkeley.edu, conor+dt@kernel.org, drew@pdp7.com, frank.binns@imgtec.com, 
	guoren@kernel.org, jassisinghbrar@gmail.com, jszhang@kernel.org, krzk+dt@kernel.org, 
	m.szyprowski@samsung.com, maarten.lankhorst@linux.intel.com, matt.coster@imgtec.com, 
	mripard@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org, simona@ffwll.ch, 
	tzimmermann@suse.de, ulf.hansson@linaro.org, wefu@redhat.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v2 01/19] dt-bindings: clock: Add VO subsystem clocks
 and update address requirements
Message-ID: <wjet4yvtcobjaf7c4u7to6rm3ppkvmgyitp6evoqjpndtno6qg@h5xxyukph6y6>
References: <20241223125553.3527812-1-m.wilczynski@samsung.com>
 <CGME20241223125601eucas1p1d274193122638075dc65310a22616bae@eucas1p1.samsung.com>
 <20241223125553.3527812-2-m.wilczynski@samsung.com>
 <2cd0c34fbd14a0d69e689d04c2241938.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2cd0c34fbd14a0d69e689d04c2241938.sboyd@kernel.org>

On Mon, Dec 23, 2024 at 12:50:59PM -0800, Stephen Boyd wrote:
> Quoting Michal Wilczynski (2024-12-23 04:55:35)
> > The T-Head TH1520 SoC=E2=80=99s AP clock controller now needs two addre=
ss ranges
> > to manage both the Application Processor (AP) and Video Output (VO)
> > subsystem clocks. Update the device tree bindings to require two `reg`
> > entries, one for the AP clocks and one for the VO clocks.
> >=20
> > Additionally, introduce new VO subsystem clock constants in the header
> > file. These constants will be used by the driver to control VO-related
> > components such as display and graphics units.
> >=20
> > Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> > ---
> [...]
> > diff --git a/Documentation/devicetree/bindings/clock/thead,th1520-clk-a=
p.yaml b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
> > index 0129bd0ba4b3..f0df97a450ef 100644
> > --- a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
> > +++ b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
> > @@ -47,7 +54,9 @@ examples:
> >      #include <dt-bindings/clock/thead,th1520-clk-ap.h>
> >      clock-controller@ef010000 {
> >          compatible =3D "thead,th1520-clk-ap";
> > -        reg =3D <0xef010000 0x1000>;
> > +        reg =3D <0xef010000 0x1000>,
> > +              <0xff010000 0x1000>;
>=20
> I don't get it. Why not have two nodes and two devices? They have
> different register regions so likely they're different devices on the
> internal SoC bus. They may have the same input clks, but otherwise I
> don't see how they're the same node.

That's a good point. Aren't here simply two different clock controllers?

Best regards,
Krzysztof



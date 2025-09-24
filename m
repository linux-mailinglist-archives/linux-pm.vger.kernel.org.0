Return-Path: <linux-pm+bounces-35285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9837B9AA1F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 17:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A435816922F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 15:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558DB31158D;
	Wed, 24 Sep 2025 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTKD+yL+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8CD30F94E;
	Wed, 24 Sep 2025 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727472; cv=none; b=cChClYc4YsznVYxApEZ/8eJgyJryFWQZ0iHQWPliZCcLuEDyvzeSwkWVJRvdTbJGPc4/186J7blCMALr0evRI1zpe3Phi5Esw9tYa2BM7HSuP6a3Fv0c4Yrm3v5FkfddOaEw7kT4ISQhkJfjbey2ye6GhnwVgKYocF6JXgxsoqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727472; c=relaxed/simple;
	bh=z51gCKwdpZxvFwIfuZnWgQntDhqg+DSi+OiQMo4cKjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvC7baTeNgRnCGRrSBYaG5JtTGEVuaogQXTKvZoCVTxoAIKbvdKFtdohFeoy8lkJoanjpithD5trTqxs1Mk1Jhy+8acZDt83NWUKZRaHFmY3i8D+bZpSUP3bdGoXvOscCSg9m9f9lkjm2dipB53lmI3bBlLI9DCWX+Kc37UxR+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTKD+yL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56621C116C6;
	Wed, 24 Sep 2025 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758727471;
	bh=z51gCKwdpZxvFwIfuZnWgQntDhqg+DSi+OiQMo4cKjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hTKD+yL+GM8Kz5Or9C/Wek6gEMENBW4MdyX9Ax1rFpv/bBkEsP7hfvoUKChVFadcC
	 6mXioAhDdbIudVwAi5iG/xnJZc9uY2LJOALLbBKzTu41T7dD7OZ9a8LxeDBtQ4Jruf
	 7xZ3g/n/wjVAVfOp2xsAsJjEBw3NuYnF+I8S+cYnjEsJOstA76m1FGE5TKOXEjD2xO
	 GouWKyViuajmRXaN1PkKYPVsGX9NvfgBfRHHJJpCFKs4BX2JVu9Q/f25pikW4NzY0a
	 epWZT7lSa4Zr2wk9X+yxim4nKfvFKo8D65Hl7O4/Nxm0ldcji//TyKCvixzRM9UHvP
	 vwEXLBdyG121Q==
Date: Wed, 24 Sep 2025 10:24:30 -0500
From: Rob Herring <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Dmitry Osipenko <digetx@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 03/11] dt-bindings: memory: Document Tegra114 Memory
 Controller
Message-ID: <20250924152430.GA1735105-robh@kernel.org>
References: <20250915080157.28195-1-clamor95@gmail.com>
 <20250915080157.28195-4-clamor95@gmail.com>
 <20250922160040.GA92842-robh@kernel.org>
 <CAPVz0n3cmFC1PdFnLJ0Vf60i3c6pDO9Lvi8dmAHzBgwgsrPXnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n3cmFC1PdFnLJ0Vf60i3c6pDO9Lvi8dmAHzBgwgsrPXnA@mail.gmail.com>

On Mon, Sep 22, 2025 at 07:18:00PM +0300, Svyatoslav Ryhel wrote:
> пн, 22 вер. 2025 р. о 19:00 Rob Herring <robh@kernel.org> пише:
> >
> > On Mon, Sep 15, 2025 at 11:01:49AM +0300, Svyatoslav Ryhel wrote:
> > > Add Tegra114 support into existing Tegra124 MC schema with the most
> > > notable difference in the amount of EMEM timings.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../nvidia,tegra124-mc.yaml                   | 97 ++++++++++++++-----
> > >  1 file changed, 74 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
> > > index 7b18b4d11e0a..9cc9360d3bd0 100644
> > > --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
> > > +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
> > > @@ -19,7 +19,9 @@ description: |
> > >
> > >  properties:
> > >    compatible:
> > > -    const: nvidia,tegra124-mc
> > > +    enum:
> > > +      - nvidia,tegra114-mc
> > > +      - nvidia,tegra124-mc
> > >
> > >    reg:
> > >      maxItems: 1
> > > @@ -64,29 +66,10 @@ patternProperties:
> > >
> > >            nvidia,emem-configuration:
> > >              $ref: /schemas/types.yaml#/definitions/uint32-array
> > > -            description: |
> > > +            description:
> > >                Values to be written to the EMEM register block. See section
> > > -              "15.6.1 MC Registers" in the TRM.
> > > -            items:
> > > -              - description: MC_EMEM_ARB_CFG
> > > -              - description: MC_EMEM_ARB_OUTSTANDING_REQ
> > > -              - description: MC_EMEM_ARB_TIMING_RCD
> > > -              - description: MC_EMEM_ARB_TIMING_RP
> > > -              - description: MC_EMEM_ARB_TIMING_RC
> > > -              - description: MC_EMEM_ARB_TIMING_RAS
> > > -              - description: MC_EMEM_ARB_TIMING_FAW
> > > -              - description: MC_EMEM_ARB_TIMING_RRD
> > > -              - description: MC_EMEM_ARB_TIMING_RAP2PRE
> > > -              - description: MC_EMEM_ARB_TIMING_WAP2PRE
> > > -              - description: MC_EMEM_ARB_TIMING_R2R
> > > -              - description: MC_EMEM_ARB_TIMING_W2W
> > > -              - description: MC_EMEM_ARB_TIMING_R2W
> > > -              - description: MC_EMEM_ARB_TIMING_W2R
> > > -              - description: MC_EMEM_ARB_DA_TURNS
> > > -              - description: MC_EMEM_ARB_DA_COVERS
> > > -              - description: MC_EMEM_ARB_MISC0
> > > -              - description: MC_EMEM_ARB_MISC1
> > > -              - description: MC_EMEM_ARB_RING1_THROTTLE
> > > +              "20.11.1 MC Registers" in the Tegea114 TRM or
> > > +              "15.6.1 MC Registers" in the Tegra124 TRM.
> > >
> > >          required:
> > >            - clock-frequency
> > > @@ -109,6 +92,74 @@ required:
> > >    - "#iommu-cells"
> > >    - "#interconnect-cells"
> > >
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - nvidia,tegra114-mc
> > > +    then:
> > > +      patternProperties:
> > > +        "^emc-timings-[0-9]+$":
> > > +          patternProperties:
> > > +            "^timing-[0-9]+$":
> > > +              properties:
> > > +                nvidia,emem-configuration:
> > > +                  items:
> > > +                    - description: MC_EMEM_ARB_CFG
> > > +                    - description: MC_EMEM_ARB_OUTSTANDING_REQ
> > > +                    - description: MC_EMEM_ARB_TIMING_RCD
> > > +                    - description: MC_EMEM_ARB_TIMING_RP
> > > +                    - description: MC_EMEM_ARB_TIMING_RC
> > > +                    - description: MC_EMEM_ARB_TIMING_RAS
> > > +                    - description: MC_EMEM_ARB_TIMING_FAW
> > > +                    - description: MC_EMEM_ARB_TIMING_RRD
> > > +                    - description: MC_EMEM_ARB_TIMING_RAP2PRE
> > > +                    - description: MC_EMEM_ARB_TIMING_WAP2PRE
> > > +                    - description: MC_EMEM_ARB_TIMING_R2R
> > > +                    - description: MC_EMEM_ARB_TIMING_W2W
> > > +                    - description: MC_EMEM_ARB_TIMING_R2W
> > > +                    - description: MC_EMEM_ARB_TIMING_W2R
> > > +                    - description: MC_EMEM_ARB_DA_TURNS
> > > +                    - description: MC_EMEM_ARB_DA_COVERS
> > > +                    - description: MC_EMEM_ARB_MISC0
> > > +                    - description: MC_EMEM_ARB_RING1_THROTTLE
> >
> > Like I said before, I don't think it is worth enumerating the list of
> > registers for every variant. If you want to define the length
> > (minItems/maxItems), then that is fine.
> >
> 
> It worth because position of value matters when reading and list above
> provides a reference to the order in which register values should be
> grouped.

The schema does nothing to validate that. The only thing that gets 
validated is the length. It is just an opaque blob of data. I'm sure you 
have to define the order in the driver as well. One place is enough.

Rob


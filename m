Return-Path: <linux-pm+bounces-18382-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AA49E0E1A
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 22:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64857B340DD
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 20:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4781DEFF9;
	Mon,  2 Dec 2024 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLdvUXL0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4B619BBA;
	Mon,  2 Dec 2024 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733173062; cv=none; b=qw1JxMoqGQzIm/Mpn4ImrcStWwmHokyif47P4Age/AehTHupR+IbC0bXJty8srio6+RrXr0vV1CbDV40Z1llTbAGR32tyKa0vEtqMpoUiMSPjdv+SP6Y1ijRO8MuxmhaiQn3UeRM+ON6LooKXzrztcXphA0CBkz/3472dO+zpVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733173062; c=relaxed/simple;
	bh=y8VzxnsyxdZ299ksar2rMfEnBfUOR8Om3RcJKlRKg8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUKdtso5qrhFLwXgP4xsh1iA3F2gp9LxUfmZ3K1KGO3Nagyqwt2Pa3N2hLrxi4rveXZXLH91+I1ocVNE7u2oLA9cvwMn6OdVjlpIlq1Ett+VrBFvS+R7xje5r05MAspLURXf0bYDM+Hqf0x300OWu86dcxUXbPCNZixOQHudsBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLdvUXL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555E6C4CED1;
	Mon,  2 Dec 2024 20:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733173061;
	bh=y8VzxnsyxdZ299ksar2rMfEnBfUOR8Om3RcJKlRKg8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLdvUXL0NmalifhfD7a9PThBw2rUv5zYnuaYUEM8G9ffDYemWzgSOpLhQtw1rx0Q9
	 xFcv6FIpo0VLKdU2ROAGpRhQg3kqMuo9HqhxQQ3LglT/9sYWKt+MQgrCjRQ+MajkpZ
	 QvungpfEPoysMEZpJUauAih5kMLy7VGkv5XU6X70215SN6BGJ8OgAnFpWHo47exZtj
	 956t2OmsZJ4ZWj1u6aZEF8Q0XK9sFrMv4UH05P9nbFgL6q7J9AvEvvyykdtzrCW3q0
	 lFmDZCw5dPS9PpyXaX9j9XNUToEZ/vSjrrJi5ivFjxNwGeQxXCFeM8+j7wjk/HgpN1
	 bx6z6sEmYdXkg==
Date: Mon, 2 Dec 2024 14:57:38 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Document support for Airoha
 EN7581 CPUFreq
Message-ID: <20241202205738.GA3149730-robh@kernel.org>
References: <20241202151228.32609-1-ansuelsmth@gmail.com>
 <CAPDyKFqrY7uLD8ATqH0LghmkHgApQSsGtvGkOTd8UVazGu0_uA@mail.gmail.com>
 <674dd60f.7b0a0220.2ba255.7b7a@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674dd60f.7b0a0220.2ba255.7b7a@mx.google.com>

On Mon, Dec 02, 2024 at 04:45:17PM +0100, Christian Marangi wrote:
> On Mon, Dec 02, 2024 at 04:42:33PM +0100, Ulf Hansson wrote:
> > On Mon, 2 Dec 2024 at 16:20, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > >
> > > Document required property for Airoha EN7581 CPUFreq .
> > >
> > > On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> > > to ATF and no clocks are exposed to the OS.
> > >
> > > The SoC have performance state described by ID for each OPP, for this a
> > > Power Domain is used that sets the performance state ID according to the
> > > required OPPs defined in the CPU OPP tables.
> > >
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > > Changes v4:
> > > - Add this patch
> > >
> > >  .../cpufreq/airoha,en7581-cpufreq.yaml        | 259 ++++++++++++++++++
> > >  1 file changed, 259 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > > new file mode 100644
> > > index 000000000000..a5bdea7f34b5
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > 
> > [...]
> > 
> > > +examples:
> > > +  - |
> > > +    / {
> > > +        #address-cells = <2>;
> > > +       #size-cells = <2>;
> > > +
> > > +        cpus {
> > > +            #address-cells = <1>;
> > > +            #size-cells = <0>;
> > > +
> > > +            cpu0: cpu@0 {
> > > +                device_type = "cpu";
> > > +                compatible = "arm,cortex-a53";
> > > +                reg = <0x0>;
> > > +                operating-points-v2 = <&cpu_opp_table>;
> > > +                enable-method = "psci";
> > > +                clocks = <&cpufreq>;
> > > +                clock-names = "cpu";
> > > +                power-domains = <&cpufreq>;
> > > +                power-domain-names = "cpu_pd";
> > 
> > Nitpick: Perhaps clarify the name to be "perf" or "cpu_perf", to
> > indicate it's a power-domain with performance scaling support.
> > 
> 
> Will change to cpu_perf. Thanks a lot for the review!

Is that defined in arm/cpus.yaml? No.

The current choices are perf or psci though those aren't enforced (yet). 
Or nothing which is my preference if there is only 1 power domain.
 
Rob


Return-Path: <linux-pm+bounces-18566-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230EA9E4398
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 19:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F208D163B38
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 18:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCB41A8F81;
	Wed,  4 Dec 2024 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xxz+F7aL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA726AFC;
	Wed,  4 Dec 2024 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733337776; cv=none; b=urbTChR6mVsHjuBzu41RPZykxfw5ytLv+RtS6883/zXIvkJPyWXrZbgrQWYT7FfjHFaSsB6VIuYRe9Qgl59kMGJHvomoigQ9r51J8zAWqwZnfTxBkmMgcIN9KbsWQ88BdjPi2ksSbGo8wIIYB1InZyH1Y+hw4stZUPz/yXbmbeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733337776; c=relaxed/simple;
	bh=O/Zhj6xXRdGGJvpcvnu3X4YlT27afIf8vci2UWRYD8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKNq59ON518F7X4LtnR/U0/YH/9uFgHsUHHrLZwkWqEmu5BFTQLgjbaBoNCGtK///Y+oNQhuJRuJkSD3pQ9jPDrVqzTCghKP2WsuN+6Oaiwy/HgATutk5HutTkYPjQQ9Kzis39mMXvARWst8UuW1YRXiv6ixIuzj60kORgVeCIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xxz+F7aL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FD6C4CECD;
	Wed,  4 Dec 2024 18:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733337775;
	bh=O/Zhj6xXRdGGJvpcvnu3X4YlT27afIf8vci2UWRYD8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xxz+F7aLLfjGHjIzFprjn4YKE88Bz8lM2bNlz3cjUDmY6I3apxHsBtbz3C5SXVK/F
	 htBcirayED50YJAv+AV8gz769qUo+jlWDhX0cEFO3cDucmEwmOFLhBqVQBJXYhQWjY
	 5DpsWBuMSyHSVcZt3j72B8DXFAmsbveyb3wVTP8YXuSGM5KOU0h3ntyCA5N9X23VNP
	 mFYPY5ir59WCxtkRTiExB4XqFy7jyd21a/QRo5edtDX/IPaddrVidlI5tsT9Jb4HaR
	 phQExR0YzklauXWG6jQs3gkTs3Lo4FCQugCoICaRAQVytLoWhogmBJpo8w8RCDO/pc
	 CzwuXbBQYooNA==
Date: Wed, 4 Dec 2024 12:42:53 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: cpufreq: Document support for Airoha
 EN7581 CPUFreq
Message-ID: <20241204184253.GA276662-robh@kernel.org>
References: <20241203163158.580-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203163158.580-1-ansuelsmth@gmail.com>

On Tue, Dec 03, 2024 at 05:31:49PM +0100, Christian Marangi wrote:
> Document required property for Airoha EN7581 CPUFreq .
> 
> On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> to ATF and no clocks are exposed to the OS.
> 
> The SoC have performance state described by ID for each OPP, for this a
> Power Domain is used that sets the performance state ID according to the
> required OPPs defined in the CPU OPP tables.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> Changes v5:
> - Add Reviewed-by tag
> - Fix OPP node name error
> - Rename cpufreq node name to power-domain
> - Rename CPU node power domain name to perf
> - Add model and compatible to example
> Changes v4:
> - Add this patch
> 
>  .../cpufreq/airoha,en7581-cpufreq.yaml        | 262 ++++++++++++++++++
>  1 file changed, 262 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> new file mode 100644
> index 000000000000..7e36fa037e4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> @@ -0,0 +1,262 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cpufreq/airoha,en7581-cpufreq.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha EN7581 CPUFreq
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: |
> +  On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> +  to ATF and no clocks are exposed to the OS.
> +
> +  The SoC have performance state described by ID for each OPP, for this a
> +  Power Domain is used that sets the performance state ID according to the
> +  required OPPs defined in the CPU OPP tables.
> +
> +properties:
> +  compatible:
> +    const: airoha,en7581-cpufreq
> +
> +  '#clock-cells':
> +    const: 0

You just said no clocks are exposed to the OS.

> +
> +  '#power-domain-cells':
> +    const: 0
> +
> +  operating-points-v2: true
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +  - '#power-domain-cells'
> +  - operating-points-v2
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    / {
> +        model = "Airoha EN7581 Evaluation Board";
> +        compatible = "airoha,en7581-evb", "airoha,en7581";
> +
> +        #address-cells = <2>;
> +      	#size-cells = <2>;

mixed tab and spaces.

Can't I just go read the actual .dts files if I want to see 
*everything*? Examples should generally be just what the schema covers.

> +
> +        cpus {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            cpu0: cpu@0 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a53";
> +                reg = <0x0>;
> +                operating-points-v2 = <&cpu_opp_table>;
> +                enable-method = "psci";
> +                clocks = <&cpu_pd>;
> +                clock-names = "cpu";
> +                power-domains = <&cpu_pd>;
> +                power-domain-names = "perf";
> +                next-level-cache = <&l2>;
> +                #cooling-cells = <2>;

I don't understand why you have clocks, power-domains and OPP? 
Certainly that's conceivable, but not with how you're abusing 
power-domains for performance points and you said clocks are not exposed 
to the OS.

Rob


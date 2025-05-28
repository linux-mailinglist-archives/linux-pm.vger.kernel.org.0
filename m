Return-Path: <linux-pm+bounces-27759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89951AC72A6
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 23:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F62D1BC78B7
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 21:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0684C220F2E;
	Wed, 28 May 2025 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUH10kTm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45962DCC0C;
	Wed, 28 May 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748467001; cv=none; b=l4aiQdR0dlMB7/3As40yPF+uSz/TusHIg+CeWIdJ88Vhu+OFBzMLPCxzkzM4+1Rfmub2eLpywOTs4vB+Oo/Wrb86LR4qS2o02A526qgcfyFn8VMwHt5mqtG0NvAYDXMv9aieuhDa0VL2w7tcnp02PNmC1Nd7wLiMxjVWk/lV+s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748467001; c=relaxed/simple;
	bh=qcTRhH4BbhMI2P8Aa/dseT4V4Fa9E6TkxaLfsgzl+uo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=DV10g9NezHUypT1+lPmOa1Z/0oo+rtOvPjQXPV03D68LN0dwaAHmPcPUM1fvD0MFw295Sck2Y1RuIPAjhVdsHHmvYhidFib+UQE2IFpiKRt3IK3BU4G0lqcoFlUX4eL1jtWFpoHKg0PPfxr+dVq/WFVKF5wtPysjNrXKX+KC1cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUH10kTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D65C4CEE3;
	Wed, 28 May 2025 21:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748467001;
	bh=qcTRhH4BbhMI2P8Aa/dseT4V4Fa9E6TkxaLfsgzl+uo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=OUH10kTm+ldXnm+WHitKvK0dDeB/r6k5gxe92K/P6ZYhUYqpuYaT8W30/PmEnFKb6
	 UT12Tk0rZ3OakSMwfMnnkZQAMewgXxBLJ5DYr5cfngGsSXVyUqC7d8nByQ3/64l1q6
	 vjMaFiGnHvXhWfTAfWFAIDdoQFgBfQCzhDtfpMvJ1Qf9eY3GFEY0buJtdgcNLm3BQi
	 h50NWyeuCaXeUZWWQcInawayY7Zr/WPfO25ijywJhhJ7vLnKWP2dOoOdrPNXmpafEr
	 fMCa0mgqU7sUJxAntt8dsaVn47UpwW0p2uG37cauqS+jVADlhy4lrWDHxrv3FRui8I
	 QpsvadOtO5JjA==
Date: Wed, 28 May 2025 16:16:39 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, arm-scmi@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <20250528-pmdomain-hierarchy-onecell-v1-1-851780700c68@baylibre.com>
References: <20250528-pmdomain-hierarchy-onecell-v1-1-851780700c68@baylibre.com>
Message-Id: <174846699955.819861.15203166653070145497.robh@kernel.org>
Subject: Re: [PATCH RFC] pmdomain: core: add hierarchy support for onecell
 providers


On Wed, 28 May 2025 13:03:43 -0700, Kevin Hilman wrote:
> Currently, PM domains can only support hierarchy for simple
> providers (e.g. ones with #power-domain-cells = 0).
> 
> Add support for oncell providers as well by adding a new property
> `power-domains-child-ids` to describe the parent/child relationship.
> 
> For example, an SCMI PM domain provider might be a subdomain of
> multiple parent domains. In this example, the parent domains are
> MAIN_PD and WKUP_PD:
> 
>     scmi_pds: protocol@11 {
>         reg = <0x11>;
>         #power-domain-cells = <1>;
>         power-domains = <&MAIN_PD>, <&WKUP_PD>;
>         power-domains-child-ids = <15>, <19>;
>     };
> 
> With the new property, child domain 15 (scmi_pds 15) becomes a
> subdomain of MAIN_PD, and child domain 19 (scmi_pds 19) becomes a
> subdomain of WKUP_PD.
> 
> Note: this idea was previously discussed on the arm-scmi mailing
> list[1] where this approach was proposed by Ulf.  This is my initial
> attempt at implementing it for discussion.  I'm definitely a noob at
> adding support new DT properties, so I got some help from an AI friend
> named Claude in writing this code, so feedback on the apprach is
> welcomed.
> 
> [1] https://lore.kernel.org/arm-scmi/CAPDyKFo_P129sVirHHYjOQT+QUmpymcRJme9obzKJeRgO7B-1A@mail.gmail.com/
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  Documentation/devicetree/bindings/power/power-domain.yaml |  39 ++++++++++++++++++++++++++++++++
>  drivers/pmdomain/core.c                                   | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 150 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/power/power-domain.yaml:76:13: [error] missing starting space in comment (comments)
./Documentation/devicetree/bindings/power/power-domain.yaml:77:7: [error] syntax error: expected <block end>, but found '<scalar>' (syntax)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/power-domain.yaml: ignoring, error parsing file
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/keystone/ti,sci.example.dtb: system-controller@44083000 (ti,k2g-sci): power-controller: {'compatible': ['ti,sci-pm-domain'], '#power-domain-cells': 2} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/arm/keystone/ti,sci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/keystone/ti,sci.example.dtb: power-controller (ti,sci-pm-domain): {'compatible': ['ti,sci-pm-domain'], '#power-domain-cells': 2, '$nodename': ['power-controller']} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/soc/ti/sci-pm-domain.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/psci.example.dtb: psci (arm,psci-1.0): power-domain-cpu0: {'#power-domain-cells': 0, 'domain-idle-states': [3], 'power-domains': [[4]], 'phandle': 1} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/arm/psci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/psci.example.dtb: psci (arm,psci-1.0): power-domain-cpu0: Unevaluated properties are not allowed ('#power-domain-cells', 'domain-idle-states', 'power-domains' were unexpected)
	from schema $id: http://devicetree.org/schemas/arm/psci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/psci.example.dtb: psci (arm,psci-1.0): power-domain-cpu1: {'#power-domain-cells': 0, 'domain-idle-states': [3], 'power-domains': [[4]], 'phandle': 2} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/arm/psci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/psci.example.dtb: psci (arm,psci-1.0): power-domain-cpu1: Unevaluated properties are not allowed ('#power-domain-cells', 'domain-idle-states', 'power-domains' were unexpected)
	from schema $id: http://devicetree.org/schemas/arm/psci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/psci.example.dtb: psci (arm,psci-1.0): power-domain-cluster: {'#power-domain-cells': 0, 'domain-idle-states': [5, 6], 'phandle': 4} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/arm/psci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/psci.example.dtb: psci (arm,psci-1.0): power-domain-cluster: Unevaluated properties are not allowed ('#power-domain-cells', 'domain-idle-states' were unexpected)
	from schema $id: http://devicetree.org/schemas/arm/psci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dtb: power-management@23b700000 (apple,t8103-pmgr): power-controller@1c0: {'compatible': ['apple,t8103-pmgr-pwrstate', 'apple,pmgr-pwrstate'], 'reg': [[448, 8]], '#power-domain-cells': 0, '#reset-cells': 0, 'label': ['sio'], 'apple,always-on': True, 'phandle': 1} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/arm/apple/apple,pmgr.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dtb: power-management@23b700000 (apple,t8103-pmgr): power-controller@220: {'compatible': ['apple,t8103-pmgr-pwrstate', 'apple,pmgr-pwrstate'], 'reg': [[544, 8]], '#power-domain-cells': 0, '#reset-cells': 0, 'label': ['uart_p'], 'power-domains': [[1]], 'phandle': 2} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/arm/apple/apple,pmgr.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dtb: power-management@23b700000 (apple,t8103-pmgr): power-controller@270: {'compatible': ['apple,t8103-pmgr-pwrstate', 'apple,pmgr-pwrstate'], 'reg': [[624, 8]], '#power-domain-cells': 0, '#reset-cells': 0, 'label': ['uart0'], 'power-domains': [[2]]} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/arm/apple/apple,pmgr.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dtb: power-controller@1c0 (apple,t8103-pmgr-pwrstate): {'compatible': ['apple,t8103-pmgr-pwrstate', 'apple,pmgr-pwrstate'], 'reg': [[448, 8]], '#power-domain-cells': 0, '#reset-cells': 0, 'label': ['sio'], 'apple,always-on': True, 'phandle': 1, '$nodename': ['power-controller@1c0']} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/power/apple,pmgr-pwrstate.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dtb: power-controller@220 (apple,t8103-pmgr-pwrstate): {'compatible': ['apple,t8103-pmgr-pwrstate', 'apple,pmgr-pwrstate'], 'reg': [[544, 8]], '#power-domain-cells': 0, '#reset-cells': 0, 'label': ['uart_p'], 'power-domains': [[1]], 'phandle': 2, '$nodename': ['power-controller@220']} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/power/apple,pmgr-pwrstate.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dtb: power-controller@270 (apple,t8103-pmgr-pwrstate): {'compatible': ['apple,t8103-pmgr-pwrstate', 'apple,pmgr-pwrstate'], 'reg': [[624, 8]], '#power-domain-cells': 0, '#reset-cells': 0, 'label': ['uart0'], 'power-domains': [[2]], '$nodename': ['power-controller@270']} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/power/apple,pmgr-pwrstate.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dtb: power-management@23d280000 (apple,t8103-pmgr): power-controller@4000: {'compatible': ['apple,t8103-pmgr-pwrstate', 'apple,pmgr-pwrstate'], 'reg': [[16384, 8]], '#power-domain-cells': 0, '#reset-cells': 0, 'label': ['aop_filter'], 'phandle': 3} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/arm/apple/apple,pmgr.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dtb: power-management@23d280000 (apple,t8103-pmgr): power-controller@4010: {'compatible': ['apple,t8103-pmgr-pwrstate', 'apple,pmgr-pwrstate'], 'reg': [[16400, 8]], '#power-domain-cells': 0, '#reset-cells': 0, 'label': ['aop_base'], 'power-domains': [[3]], 'phandle': 4} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/arm/apple/apple,pmgr.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dtb: power-management@23d280000 (apple,t8103-pmgr): power-controller@4038: {'compatible': ['apple,t8103-pmgr-pwrstate', 'apple,pmgr-pwrstate'], 'reg': [[16440, 8]], '#power-domain-cells': 0, '#reset-cells': 0, 'label': ['aop_shim'], 'power-domains': [[4]], 'phandle': 5} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/arm/apple/apple,pmgr.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dtb: power-management@23d280000 (apple,t8103-pmgr): power-controller@4048: {'compatible': ['apple,t8103-pmgr-pwrstate', 'apple,pmgr-pwrstate'], 'reg': [[16456, 8]], '#power-domain-cells': 0, '#reset-cells': 0, 'label': ['aop_uart0'], 'power-domains': [[5]]} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/arm/apple/apple,pmgr.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dtb: power-controller@4000 (apple,t8103-pmgr-pwrstate): {'compatible': ['apple,t8103-pmgr-pwrstate', 'apple,pmgr-pwrstate'], 'reg': [[16384, 8]], '#power-domain-cells': 0, '#reset-cells': 0, 'label': ['aop_filter'], 'phandle': 3, '$nodename': ['power-controller@4000']} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/power/apple,pmgr-pwrstate.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dtb: power-controller@4010 (apple,t8103-pmgr-pwrstate): {'compatible': ['apple,t8103-pmgr-pwrstate', 'apple,pmgr-pwrstate'], 'reg': [[16400, 8]], '#power-domain-cells': 0, '#reset-cells': 0, 'label': ['aop_base'], 'power-domains': [[3]], 'phandle': 4, '$nodename': ['power-controller@4010']} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/power/apple,pmgr-pwrstate.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dtb: power-controller@4038 (apple,t8103-pmgr-pwrstate): {'compatible': ['apple,t8103-pmgr-pwrstate', 'apple,pmgr-pwrstate'], 'reg': [[16440, 8]], '#power-domain-cells': 0, '#reset-cells': 0, 'label': ['aop_shim'], 'power-domains': [[4]], 'phandle': 5, '$nodename': ['power-controller@4038']} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/power/apple,pmgr-pwrstate.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dtb: power-controller@4048 (apple,t8103-pmgr-pwrstate): {'compatible': ['apple,t8103-pmgr-pwrstate', 'apple,pmgr-pwrstate'], 'reg': [[16456, 8]], '#power-domain-cells': 0, '#reset-cells': 0, 'label': ['aop_uart0'], 'power-domains': [[5]], '$nodename': ['power-controller@4048']} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/power/apple,pmgr-pwrstate.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.example.dtb: power-controller (ti,sci-pm-domain): {'compatible': ['ti,sci-pm-domain'], '#power-domain-cells': 1, '$nodename': ['power-controller']} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/soc/ti/sci-pm-domain.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.example.dtb: power-controller (ti,sci-pm-domain): {'compatible': ['ti,sci-pm-domain'], '#power-domain-cells': 2, '$nodename': ['power-controller']} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/soc/ti/sci-pm-domain.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/fsl,scu-pd.example.dtb: power-controller (fsl,imx8qxp-scu-pd): {'compatible': ['fsl,imx8qxp-scu-pd', 'fsl,scu-pd'], '#power-domain-cells': 1, '$nodename': ['power-controller']} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/power/fsl,scu-pd.yaml#
make[2]: *** Deleting file 'Documentation/devicetree/bindings/power/power-domain.example.dts'
Documentation/devicetree/bindings/power/power-domain.yaml:77:7: expected <block end>, but found '<scalar>'
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/power/power-domain.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/pd-samsung.example.dtb: power-domain@10023c80 (samsung,exynos4210-pd): {'compatible': ['samsung,exynos4210-pd'], 'reg': [[268582016, 32]], '#power-domain-cells': 0, 'label': ['LCD0'], '$nodename': ['power-domain@10023c80']} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/power/pd-samsung.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/pd-samsung.example.dtb: power-domain@10044060 (samsung,exynos4210-pd): {'compatible': ['samsung,exynos4210-pd'], 'reg': [[268714080, 32]], '#power-domain-cells': 0, 'label': ['MFC'], '$nodename': ['power-domain@10044060']} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/power/power-domain.yaml#"}
	from schema $id: http://devicetree.org/schemas/power/pd-samsung.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml:
	while parsing a block mapping
  in "<unicode string>", line 72, column 5:
        $ref: /schemas/types.yaml#/defin ... 
        ^ (line: 72)
expected <block end>, but found '<scalar>'
  in "<unicode string>", line 77, column 7:
          power domains). It specifies whi ... 
          ^ (line: 77)
./Documentation/devicetree/bindings/power/power-domain.yaml:77:7: expected <block end>, but found '<scalar>'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/pd-samsung.yaml:
	while parsing a block mapping
  in "<unicode string>", line 72, column 5:
        $ref: /schemas/types.yaml#/defin ... 
        ^ (line: 72)
expected <block end>, but found '<scalar>'
  in "<unicode string>", line 77, column 7:
          power domains). It specifies whi ... 
          ^ (line: 77)
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/psci.yaml:
	while parsing a block mapping
  in "<unicode string>", line 72, column 5:
        $ref: /schemas/types.yaml#/defin ... 
        ^ (line: 72)
expected <block end>, but found '<scalar>'
  in "<unicode string>", line 77, column 7:
          power domains). It specifies whi ... 
          ^ (line: 77)
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml:
	while parsing a block mapping
  in "<unicode string>", line 72, column 5:
        $ref: /schemas/types.yaml#/defin ... 
        ^ (line: 72)
expected <block end>, but found '<scalar>'
  in "<unicode string>", line 77, column 7:
          power domains). It specifies whi ... 
          ^ (line: 77)
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml:
	while parsing a block mapping
  in "<unicode string>", line 72, column 5:
        $ref: /schemas/types.yaml#/defin ... 
        ^ (line: 72)
expected <block end>, but found '<scalar>'
  in "<unicode string>", line 77, column 7:
          power domains). It specifies whi ... 
          ^ (line: 77)
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1519: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250528-pmdomain-hierarchy-onecell-v1-1-851780700c68@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.



Return-Path: <linux-pm+bounces-42143-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF0BEIKFhGl43QMAu9opvQ
	(envelope-from <linux-pm+bounces-42143-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 12:56:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FC7F21D6
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 12:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EACD303DA9C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 11:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8199B3B8D62;
	Thu,  5 Feb 2026 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1KdPuJQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAA93B8BCD;
	Thu,  5 Feb 2026 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292540; cv=none; b=tzVWvMs4VUPKsDNQR7/elmrKiFYX61KN+UZtXuhYjDHsNN5SfwcU1m0TWP6GVvdc3vpuSqNj5jPvT7H0Dh4K6695kfdNe3gM6kzfvrPOOOGzH4JrnwnFQ8BrIUivk8d8cHEYBjnxE1sgoCkck0HFNx8aiqld3ox/n6V2PbioS6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292540; c=relaxed/simple;
	bh=3cWJYNDc2jDsYU++XvqlzFgu8j7Acr+5SYAqC16d3Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTWOfTSn1h3sWRwfJrTQdggxTaAoMKjbPSPtarg1JkRT9Y4u/OpbsvJUO6jiLxWh44E680C94biog1HBy4zsotElicZy7bUjNea1H0N256lCYtrpQ3C5isR0Y+0aFuFqkCP74Ce3BYhbGmeUMYYtaoza+gI8g4XeZKs1L6sr7jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1KdPuJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73265C16AAE;
	Thu,  5 Feb 2026 11:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770292540;
	bh=3cWJYNDc2jDsYU++XvqlzFgu8j7Acr+5SYAqC16d3Fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1KdPuJQ6Ff2LkI69WKOyqAccYkQ0UpFJgnDnyTH543YPbIkCBmWmZU6gPxN8Bkif
	 0PJpv70N7r2VOIGApk0NVMSIypiKooYjT91zdC6sHMsIVP83dpoM0drue1+uM30sZt
	 833PvlaaNpunBcRLC4BMjBvEy5Q7z5pwjoDLRxVFZ5I/H6MyAEYnIkz+jcD8DW2oXX
	 pHGRU3DbMT+PNteECyRsMrW3L5ctbpRcB0+7WqBYBdyMQx8AWNR2I9k/c06bmG1cvf
	 ECchvmuA+MnchvnX2S9oPMUZcz0S2iGPqgiKZt+C1YJw+LBkKyFDGliY46u8ILrhde
	 yYC0eGjVyfLNQ==
Date: Thu, 5 Feb 2026 12:55:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mike Tipton <mike.tipton@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Mahua SoC
Message-ID: <20260205-cream-ocelot-of-courtesy-c9ebdf@quoll>
References: <20260127-mahua_icc-v2-0-f0d8ddf7afca@oss.qualcomm.com>
 <20260127-mahua_icc-v2-1-f0d8ddf7afca@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127-mahua_icc-v2-1-f0d8ddf7afca@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42143-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3FC7F21D6
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 03:22:06AM +0000, Raviteja Laggyshetty wrote:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - qcom,mahua-clk-virt
> +          - const: qcom,glymur-clk-virt
> +      - items:
> +          - enum:
> +              - qcom,mahua-cnoc-main
> +          - const: qcom,glymur-cnoc-main
> +      - items:
> +          - enum:
> +              - qcom,mahua-system-noc
> +          - const: qcom,glymur-system-noc
> +      - items:
> +          - enum:
> +              - qcom,mahua-pcie-east-anoc
> +          - const: qcom,glymur-pcie-east-anoc
> +      - items:
> +          - enum:
> +              - qcom,mahua-aggre1-noc
> +          - const: qcom,glymur-aggre1-noc

All these "items" blocks should be sorted by the fallback, so
qcom,glymur-aggre1-noc is before qcom,glymur-clk-virt.


> +      - items:
> +          - enum:
> +              - qcom,mahua-aggre2-noc
> +          - const: qcom,glymur-aggre2-noc
> +      - items:
> +          - enum:
> +              - qcom,mahua-aggre3-noc
> +          - const: qcom,glymur-aggre3-noc
> +      - items:
> +          - enum:
> +              - qcom,mahua-aggre4-noc
> +          - const: qcom,glymur-aggre4-noc
> +      - items:
> +          - enum:
> +              - qcom,mahua-mmss-noc
> +          - const: qcom,glymur-mmss-noc
> +      - items:
> +          - enum:
> +              - qcom,mahua-pcie-east-slv-noc
> +          - const: qcom,glymur-pcie-east-slv-noc
> +      - items:
> +          - enum:
> +              - qcom,mahua-lpass-lpiaon-noc
> +          - const: qcom,glymur-lpass-lpiaon-noc
> +      - items:
> +          - enum:
> +              - qcom,mahua-lpass-lpicx-noc
> +          - const: qcom,glymur-lpass-lpicx-noc
> +      - items:
> +          - enum:
> +              - qcom,mahua-lpass-ag-noc
> +          - const: qcom,glymur-lpass-ag-noc
> +      - items:
> +          - enum:
> +              - qcom,mahua-nsinoc
> +          - const: qcom,glymur-nsinoc
> +      - items:
> +          - enum:
> +              - qcom,mahua-oobm-ss-noc
> +          - const: qcom,glymur-oobm-ss-noc
> +      - items:
> +          - enum:
> +              - qcom,mahua-nsp-noc
> +          - const: qcom,glymur-nsp-noc
> +      - enum:
> +          - qcom,glymur-aggre1-noc
> +          - qcom,glymur-aggre2-noc
> +          - qcom,glymur-aggre3-noc
> +          - qcom,glymur-aggre4-noc
> +          - qcom,glymur-clk-virt
> +          - qcom,glymur-cnoc-cfg
> +          - qcom,glymur-cnoc-main
> +          - qcom,glymur-hscnoc
> +          - qcom,glymur-lpass-ag-noc
> +          - qcom,glymur-lpass-lpiaon-noc
> +          - qcom,glymur-lpass-lpicx-noc
> +          - qcom,glymur-mc-virt
> +          - qcom,glymur-mmss-noc
> +          - qcom,glymur-nsinoc
> +          - qcom,glymur-nsp-noc
> +          - qcom,glymur-oobm-ss-noc
> +          - qcom,glymur-pcie-east-anoc
> +          - qcom,glymur-pcie-east-slv-noc
> +          - qcom,glymur-pcie-west-anoc
> +          - qcom,glymur-pcie-west-slv-noc
> +          - qcom,glymur-system-noc
> +          - qcom,mahua-mc-virt
> +          - qcom,mahua-cnoc-cfg
> +          - qcom,mahua-pcie-west-anoc
> +          - qcom,mahua-pcie-west-slv-noc
> +          - qcom,mahua-hscnoc
>  
>    reg:
>      maxItems: 1
> @@ -63,6 +133,7 @@ allOf:
>              enum:
>                - qcom,glymur-clk-virt
>                - qcom,glymur-mc-virt
> +              - qcom,mahua-mc-virt
>      then:
>        properties:
>          reg: false
> @@ -85,6 +156,20 @@ allOf:
>              - description: aggre PCIE_4 WEST AXI clock
>              - description: aggre PCIE_6 WEST AXI clock
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,mahua-pcie-west-anoc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: aggre PCIE_3B WEST AXI clock
> +            - description: aggre PCIE_4 WEST AXI clock
> +            - description: aggre PCIE_6 WEST AXI clock
> +
>    - if:
>        properties:
>          compatible:
> @@ -132,6 +217,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,glymur-pcie-west-anoc
> +              - qcom,mahua-pcie-west-anoc

Messed sorting. I don't get why such trivialities are still happening...

>                - qcom,glymur-pcie-east-anoc
>                - qcom,glymur-aggre2-noc
>                - qcom,glymur-aggre4-noc
> 
> -- 
> 2.43.0
> 


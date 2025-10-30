Return-Path: <linux-pm+bounces-37135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49B3C21D6A
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 19:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125561A6530F
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 18:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF50B36CE1E;
	Thu, 30 Oct 2025 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMvJZHce"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5761F4289;
	Thu, 30 Oct 2025 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761850464; cv=none; b=qBpMi2Scnh7LBj6MzUiokOHIC7WV+liay97s4AZ4la0A6rBD6WkCOK1CXKTO0eVp0hUrwZ1xCQyVtJPTjuSC24GdxwK0gsMJ9nLv8dtbRFaQWpu5uJOt/kaNTl3BuCRjQmC0+ArZKOdPgKTsJYFxby80o7J7/Yvyq/iP0ElI74w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761850464; c=relaxed/simple;
	bh=LcXInhdYM4JhzkE2rlpVp4so9C1DZXUfbRAwtPpGjyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYaD6daztu8LdiHwc1qCbUojpACPkxv9R1i46NgNWOLxDQ9r4oi6S8gm7gbWYoBoVmSOEQs5ezemfUGvVCRdTaQG1S0yIp5CpzNWQ7COZg2H55Mtjb2aPlVNNHnSTMNsPDuGHpgj0zJX5nMt/f8UL+q1Kd3dq0N8IHI4h/LLBYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMvJZHce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C554C4CEF8;
	Thu, 30 Oct 2025 18:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761850464;
	bh=LcXInhdYM4JhzkE2rlpVp4so9C1DZXUfbRAwtPpGjyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RMvJZHced0xe0SYXEBdqUWtrj5+Ios4HX4RT21t3HJdbVrs/SSLPGy6v3bd5R2S1O
	 lLtM9oyfvDaN2Y4SYcIqlcf93wW+8/lwvWenvC6Oo6BZgzziIqhW37ygVMI0XI7E6k
	 xwwWsxGhq2owrbwZ35/N9nSqStSSzxHJbYobCl47SWFV4sD5SWoK1/EAmXphB6EqUp
	 uLB9wEnsS+Fjwi+HIXhgD76KbPyQy80G+U7XUIkXhF2vlOZTUEWDocY0CX9BC+Qx9Y
	 eCFgNVKXpZPG3dFOPBzLPm+TPR4UfP9f87qGcNYP0+FzRgCM1+M0i/5T0v1GuDaHRr
	 N/nOau3BEixkQ==
Date: Thu, 30 Oct 2025 13:57:33 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mike Tipton <mike.tipton@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Kaanapali SoC
Message-ID: <g6fxmbakdpfuzg3yhxx6dciii7fwcnphrwdeyiubmaasjwrh4u@hvyx2eru7ail>
References: <20251030-knp-interconnect-v3-0-a084a4282715@oss.qualcomm.com>
 <20251030-knp-interconnect-v3-1-a084a4282715@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030-knp-interconnect-v3-1-a084a4282715@oss.qualcomm.com>

On Thu, Oct 30, 2025 at 05:09:02PM +0000, Raviteja Laggyshetty wrote:
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.yaml
[..]
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmh.h>

What is this used for?

> +    clk_virt: interconnect-0 {
> +      compatible = "qcom,kaanapali-clk-virt";
> +      #interconnect-cells = <2>;
> +      qcom,bcm-voters = <&apps_bcm_voter>;
> +    };
> +
> +    aggre_noc: interconnect@16e0000 {
> +      compatible = "qcom,kaanapali-aggre-noc";
> +      reg = <0x016e0000 0x42400>;
> +      #interconnect-cells = <2>;
> +      clocks = <&gcc_aggre_ufs_phy_axi_clk>,
> +               <&gcc_aggre_usb3_prim_axi_clk>

make dt_binding_check

> +               <&rpmhcc_ipa_clk>;
> +      qcom,bcm-voters = <&apps_bcm_voter>;
> +    };

Regards,
Bjorn


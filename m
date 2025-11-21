Return-Path: <linux-pm+bounces-38337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C386FC7794A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 07:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id CFEC72CA57
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 06:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227DC2E0917;
	Fri, 21 Nov 2025 06:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1DHQMS/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E859B314B69
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 06:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706578; cv=none; b=D5zWENnPBUQCFAxlyFGqqQ7EkbINR7hGDXQvTdqn1333KoBg/OxxBdrSR4Fc+99L2HIxjO8QZpVZZCtnCQLCu9bpTiaTGhM8i6T+7piyAsqdBsC733vQlD3HFBL48fJ7FKVaPjy6MxAu+cQDHe55JGH4eq8eiDkjyVVN8Cn3UOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706578; c=relaxed/simple;
	bh=yqUKn3EmQwAKi7EurVCdnwawf+I8dkUMXVPSlvJzIXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgTqsxrZBtjN+LvkJdOHa7PUeH/YCr3/+kKVULrgAda2fWbZRTtSSWPUwPgzPJBOrNtZvofXcMK3n5bV0+956EBnEKkHj4uvsNaY4WodwRDB8hGg/8cuQQ8rlfVqgvx3X94wvjHIiupK5e5Qe3p0tgd5roxxbTRjvv4a4phrfgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1DHQMS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D730CC4CEFB;
	Fri, 21 Nov 2025 06:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763706577;
	bh=yqUKn3EmQwAKi7EurVCdnwawf+I8dkUMXVPSlvJzIXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1DHQMS/LR2F4vJ4hqZUxXSC8+6coQElEqpH+PockwLGptWANLdmgPSz6XelzogYL
	 Km4Z/F2ECsWnl2S7o6FH80oAQXcyrEp3nANzs7N2NxZxDoifT9OAUYaecGmYCfzOLo
	 EaLd+UqeTqKE17mat+9yKKHiEFXeaUGvbgV1TklSp19AuK4bHEuuFaGy8IpDhXa8/o
	 1aGLVFr0el6hueChZs1fBq396QVnQt3TBb9BMAYXEfS2927PQqj4ZHPO2yAsMNdNqh
	 2tunXZDLK+e7OYpBYWmc4TbGacmSVMs+tkmM1oC8d+VupUpdkLOCXcjWx7l97Frvpu
	 o3Tm6dFzLw8vg==
Date: Fri, 21 Nov 2025 11:59:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	ulf.hansson@linaro.org, vireshk@kernel.org, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: Queries on required-opps on calling dev_pm_opp_set_opp()
Message-ID: <wrv4kszh6yg3txazsze4rllyndrlj6jbowtym7scdfbhdjrzsz@ujdzbjlhrcud>
References: <8e542a9d-132d-45c3-b17f-1dcea4bdf337@oss.qualcomm.com>
 <7paqqdkxfxd3hz76o7o4q7pkmc27czqtn3smffpkwoha7bncdq@w7ik7v3c5uwk>
 <b3e9403e-6194-448d-a361-45c645a2ab2b@oss.qualcomm.com>
 <kaxxdh2xt4hghwn23qzle5wx2ltdzq7eyp7rtyvbsgffjvowv6@hgphk72idpbz>
 <621fbd17-99c6-4669-9d7f-4c1c42270dcd@oss.qualcomm.com>
 <o67y2z47husak2ic3adb2w4kxst5vfdr3vdk3wifhbpyao7hew@jj5qerm3qxor>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <o67y2z47husak2ic3adb2w4kxst5vfdr3vdk3wifhbpyao7hew@jj5qerm3qxor>

On Wed, Nov 19, 2025 at 11:19:10AM +0530, Viresh Kumar wrote:
> On 18-11-25, 21:22, Krishna Chaitanya Chundru wrote:
> > Are you suggesting to retrieve the required clock from the phy node and vote
> > from the controller
> > driver? If that is case it will not generic as some targets have different
> > name for refgen clock in
> > phy node. And this will be like a hack to do it from controller driver.
> > 
> > If this is not the one you suggested can you give me some more details on to
> > change the frequency.
> 
> This is your controller node, right ?
> 
>                 pcie0: pcie@1c00000 {
>                         compatible = "qcom,pcie-sm8450-pcie0";
> 
>                         clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
>                                  <&gcc GCC_PCIE_0_PIPE_CLK_SRC>,
>                                  <&pcie0_phy>,                          // Already has phy as a clk

This is the source of confusion. In Krishna's usecase, he wants to control the
RCHNG clock, which is sourced by GCC to PHY and is *not* exported to PCIe
controller:
	
		pcie3_phy: phy@1be0000 {
			...
	                assigned-clocks = <&gcc GCC_PCIE_3_PHY_RCHNG_CLK>;
                        assigned-clock-rates = <100000000>;
			...
		};

The clock you are pointing here is the PIPE clock and is not the one that needs
to be controlled when the controller driver changes the OPP.

The RCHNG clock has some dependency with the PCIe link speed such that it's rate
also need to be changed when the PCIe controller driver changes the link speed
using the OPP table. But this clock is only consumed and controlled by the PHY
driver (the PHY driver just sets a fixed rate as per 'assigned-clock-rates' as
of now). This is where we need your help in tieing it with controller OPP.

Hope this clarifies.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


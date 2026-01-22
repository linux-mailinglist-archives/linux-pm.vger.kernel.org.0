Return-Path: <linux-pm+bounces-41335-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGn1MqqycmnwogAAu9opvQ
	(envelope-from <linux-pm+bounces-41335-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 00:28:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5156E7D1
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 00:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DC713002527
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 23:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C963D5F55;
	Thu, 22 Jan 2026 23:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhQgitGK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D693A3D729E;
	Thu, 22 Jan 2026 23:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769124512; cv=none; b=WF+0O5w6FYYfjD0jQQOVoqync8KPm24IfOyRXl+Jwwftg9UVY9mhEP5jjFoMNLusHrYD1BLX+uZo1OYep7r9GowE2XbQtpsXPND8C3rcW5cj2ixmJXEBYuhY5jmq99hoIu3vzwc/TdmwJ3R+CYx+wHDhyI9yg8Zuj48mLFP9IKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769124512; c=relaxed/simple;
	bh=BUOzpStFRDOGeqBZpPfVQ9oRePuFvr0ez3ACS9i6JHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3deFyUdLqmny8c+K8cV2U9p2LP/0UQkAkT4VNC4lFTZXEC06sgkn5OE4mNsOSv+dE2O8ggWVaCrmuR+tCgGrQaiuIVr4pkkcJKBhp9d9rSWBKJwBwkRIV5oPe3N8fPrg7XuYtKxsdtOHaceoQPV4qpe2gPNoKAGuUC631nQL9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhQgitGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C92C116C6;
	Thu, 22 Jan 2026 23:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769124509;
	bh=BUOzpStFRDOGeqBZpPfVQ9oRePuFvr0ez3ACS9i6JHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FhQgitGKoJyty28sLybglYMAn/8V6ilZR7kMhiOu0Yq5McwN3DJ+vqZCZxrqWRRz0
	 kqFRqaNM4U5dBeWYyHI9uN+guHgeqqkLhCKVRuKfKNzqcvQad7xkmcSq4SGAGvPUqe
	 8OFlkbDKDtUJOrw+psbZgNBkIE3iOKHUVVVE3ALT1NK7ox9keZuh8yidu8z+32JASP
	 NaFC1pL3wCkZbbjvzTihiSP1gTrWmTlLpitId/IVyjjx6hXZSyDmczq28JSM/Q9xsR
	 r4aiBFL16YH/jM8dPToiBpUjhbIQNZzMpS47uf/WiA37k0k/fjMxAlXtpy5ugDc6Qe
	 YIo94AILZcvqQ==
Date: Thu, 22 Jan 2026 17:28:28 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	linux-pci@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v6 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key M connector
Message-ID: <176912450807.3729991.5158858975024322086.robh@kernel.org>
References: <20260122-pci-m2-v6-0-575da9f97239@oss.qualcomm.com>
 <20260122-pci-m2-v6-1-575da9f97239@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-pci-m2-v6-1-575da9f97239@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41335-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF5156E7D1
X-Rspamd-Action: no action


On Thu, 22 Jan 2026 22:46:51 +0530, Manivannan Sadhasivam wrote:
> Add the devicetree binding for PCIe M.2 Mechanical Key M connector defined
> in the PCI Express M.2 Specification, r4.0, sec 5.3. This connector
> provides interfaces like PCIe and SATA to attach the Solid State Drives
> (SSDs) to the host machine along with additional interfaces like USB, and
> SMBus for debugging and supplementary features.
> 
> The connector provides a primary power supply of 3.3v, along with an
> optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> 1.8v sideband signaling.
> 
> The connector also supplies optional signals in the form of GPIOs for fine
> grained power management.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  .../bindings/connector/pcie-m2-m-connector.yaml    | 145 +++++++++++++++++++++
>  1 file changed, 145 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



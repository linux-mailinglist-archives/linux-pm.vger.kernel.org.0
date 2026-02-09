Return-Path: <linux-pm+bounces-42362-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA8tDjDpiWmdDwAAu9opvQ
	(envelope-from <linux-pm+bounces-42362-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 15:03:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA8B110002
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 15:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 106CC3019155
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 14:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215BF37754A;
	Mon,  9 Feb 2026 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuTJLbZX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F291C1BC2A;
	Mon,  9 Feb 2026 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770645805; cv=none; b=OfQH73D+ptB0JFHTKBY2aE17xl6SQEYHk6b2G9bzvXKThT1K3coirr0cfGg+5hG02ow7mFUX3Ke/43afZvfMsV5BycJ74kzYtPHaPapg+mFvtuFaVROcz5dzwvZxWMcj2dwl4JqGtabsZ1mMM83JAoMG8kneu+PU3YydNO9fd18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770645805; c=relaxed/simple;
	bh=cRa04hZCg0b8G9i0a+uRcUNpAa7gqU7eUDpMxVYri5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KF1BsKflzQebvxHB0oO+twM6R11pWQZNfriZDUc0ObuOt2xpkF2o/7SkfpYjaw+6/0vJLD1kYWuhLr8IqweHwEbFkhNcLP/UCM5hmwz7E6ZCXehKWm1YsH838pLM7FBiqF1xkUwoTt0QLfmTWQX+GiZvqF5A5AaKvXNeA58UJvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuTJLbZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BF0C116C6;
	Mon,  9 Feb 2026 14:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770645804;
	bh=cRa04hZCg0b8G9i0a+uRcUNpAa7gqU7eUDpMxVYri5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RuTJLbZXjaTipKnJmJKWtpEOegZeAX8ziIP56Dci7ZHwmCZWKVnxH/FUgyWnxj6C5
	 1Hv0AyXDTZSRU2/Gmg4+AnfXMCL6mqtDF2DksRz/FkgN67Wh8GllyRUFRbYylIXADA
	 himGAWf+EvcP0aEQtSc7MEj3a3PDCnskUeVHI0DiNeplO8LJzo+vtRHHYWroE7o6vd
	 5FJp7oioYqLLrC8HEnXNRHAh/pG6ypu5JaKbYkx6tn+ybIofWW+lcD+rAOLbsKu8Bw
	 wy5xDysQdIsH+Woi/edKhipLRNJ3FqxNWxKgl1EFPAFsoWXv/q1ifwpEI/c4L36e6h
	 rqEHLYneIk49A==
Date: Mon, 9 Feb 2026 15:03:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Mahua SoC
Message-ID: <20260209-auspicious-righteous-fossa-403cf1@quoll>
References: <20260209-mahua_icc-v3-0-c65f3dfd72c8@oss.qualcomm.com>
 <20260209-mahua_icc-v3-1-c65f3dfd72c8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260209-mahua_icc-v3-1-c65f3dfd72c8@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42362-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DA8B110002
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 09:44:28AM +0000, Raviteja Laggyshetty wrote:
> Document the RPMh Network-on-Chip (NoC) interconnect for the Qualcomm
> Mahua platform.
> 
> Mahua is a derivative of the Glymur SoC. Many interconnect nodes are
> identical and continue to use Glymur fallback compatibles. Mahua
> introduces SoC-specific configurations and topologies for several
> NoC blocks, including CNOC, HSCNOC, PCIe West ANoC/Slave NoCs.
> This updates the existing Glymur yaml schema to include Mahua-specific
> compatible strings, using two-cell "fallback" compatibles wherever
> the hardware is identical with Glymur.
> 
> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,glymur-rpmh.yaml    | 136 +++++++++++++++++----
>  1 file changed, 111 insertions(+), 25 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof



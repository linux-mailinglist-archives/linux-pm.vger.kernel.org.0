Return-Path: <linux-pm+bounces-43721-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIiJMYQXqmlfLAEAu9opvQ
	(envelope-from <linux-pm+bounces-43721-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 00:53:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 285A621989C
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 00:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 064363039C9F
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 23:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A58369229;
	Thu,  5 Mar 2026 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElAwYZeK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F28235F5FC;
	Thu,  5 Mar 2026 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772754800; cv=none; b=CVZXZaj9G5AIdIs7qVAG+ulEBwmte4+QQuOV3dxv6xWZi7qZKpAlsSyHUPDrEg8MUSb4qs/KJSb0//NYCOOzDf4PmqqrTZOnb89Pap56PXNeWP62kfw0I6TMGMGf89gPjMO2HBcE5i0+Q8wnaunagirrxtaHx3KFYVIC87nIhbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772754800; c=relaxed/simple;
	bh=J4ouPwYryWJg/Sgf3XGOhDoXmHmleT+UQJPFAEsXDk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fggVd7mFtZZynRITnjqidS8w9NlKo2xn+njNMHYhXDvIiI2I+UuG7Pm88LZBOsPikI2A0ffU/kaDpSH61Ef30ynN+AjF80jniKlWH5JKmjed9Ydue0IGWDYJnyP22JMg689dDiIJl/K5M3tjkL3ji3MVJ1D93bwwhysH1US03+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElAwYZeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C305AC116C6;
	Thu,  5 Mar 2026 23:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772754799;
	bh=J4ouPwYryWJg/Sgf3XGOhDoXmHmleT+UQJPFAEsXDk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElAwYZeKRz+T7o/hH1HzrDDGYTw+VjMdQ+sgmVJql9gUB7MaeTxmL3q9X+2FEReWd
	 YCaD4ZkiiMPfZ41X8ZKKoO9sJ4+1L0ufcLKr+RZ5rEffesrFWuk8b5OYpJZfIzlszU
	 wqnAW1iIXhColg7C1qmIrNVh9oE8fQEIj62E8I8QrIaoZAYgOxsvhgM/woqyVTySUB
	 GRsYcTUZlfR1IDwBsF0ujMxMNl+YudjlPAXVoq8b8QB0c/aea3mmkLqjjXrA0sflyk
	 GbsO0rFArKq5CY7U1Wp1jJbQwPf3JWPU6vpgf8STR5dE6reOusT3XqK7SuT+gNQt03
	 5F70VjtiEqTDQ==
Date: Thu, 5 Mar 2026 17:53:18 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
Cc: linux-pm@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	devicetree@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH 3/6] regulator: dt-bindings: sc2731: Deprecate compatible
 property
Message-ID: <177275479830.806461.10691931436723823826.robh@kernel.org>
References: <20260222-sc27xx-mfd-cells-v1-0-69526fe74c77@abscue.de>
 <20260222-sc27xx-mfd-cells-v1-3-69526fe74c77@abscue.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260222-sc27xx-mfd-cells-v1-3-69526fe74c77@abscue.de>
X-Rspamd-Queue-Id: 285A621989C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,bootlin.com,linux.alibaba.com];
	TAGGED_FROM(0.00)[bounces-43721-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[abscue.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Sun, 22 Feb 2026 14:16:47 +0100, Otto Pflüger wrote:
> The node containing the regulators is always a child of the main PMIC
> node, which already has a compatible property identifying the type of
> PMIC. This makes the compatible in the child node redundant. Mark it
> as deprecated and remove it from the required property list and the
> examples.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---
>  Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml                | 2 --
>  .../devicetree/bindings/regulator/sprd,sc2731-regulator.yaml          | 4 +---
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



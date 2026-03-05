Return-Path: <linux-pm+bounces-43719-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lAFKFOwWqmlfLAEAu9opvQ
	(envelope-from <linux-pm+bounces-43719-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 00:51:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 138D221980D
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 00:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B6883021BAD
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 23:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84EF36826B;
	Thu,  5 Mar 2026 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDhl9Olt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84040352FAF;
	Thu,  5 Mar 2026 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772754663; cv=none; b=G+Glo4BtoEBhrvEhpQDqOzQZbxyLTg49dNUcLBqiy4Tqv4zylmTqRccl1SBs6OrKAhdvfqPl22H4wAM6oJyz57J632GndF+ny5nBPjRQTaxPeL18r/LhCtvd0vJzBho3U73PCbHNQCvTacDoJf1XNIhIdEy0EQ6WgOOMKEb42Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772754663; c=relaxed/simple;
	bh=yf6v3QqBjbWcUMp6hooov3XsUuV8Pew7nwjBwy3OXIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoqTge7W0Qvhysn0VkX+g5CisndMRU73RzJfK/tzWS+QmKxmbDWBl3xNRHlu6vmHiA29VOyEsRxtmZolZGJd/YFNN4hxd+FeSuG8V4fiod7HHw5y4NvHsYMIP+kxAAN4gw+I7mNsec5+g14RC3Thg340xoGKH9Quz748KN5HQDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDhl9Olt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83BEC116C6;
	Thu,  5 Mar 2026 23:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772754663;
	bh=yf6v3QqBjbWcUMp6hooov3XsUuV8Pew7nwjBwy3OXIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDhl9OltXhTr3k00NsaKtS9z4ATTQRh4GdkIi2ZSB+TBWRLXBGqsQZ2JNR5WbC0gw
	 xUlTnE43QbvLJQQqEjHdJy36uorMTx4lvnKrsHI7wZ7AuKGjo//4W74G8cAB1BekAG
	 NoJj6L4zYn5wZcZWJTCBCgZhrz94+sRuXL4y3LkgVE4ORSn5NeibHmD3QVcUswwDEA
	 1sIUvG/Yzm+viCFXTBay1/3oroP6grhTX1vzAegL8/ogQ95yfRVUfyAjY8vBybNAwg
	 txCcvateSILWRWzPGTxthViohg4KKDBtoERhTzlK6NHEu3dAIl5z1LG5snckBqNtlK
	 KySRlNgp2zWEw==
Date: Thu, 5 Mar 2026 17:51:02 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Orson Zhai <orsonzhai@gmail.com>, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-rtc@vger.kernel.org, linux-leds@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH 2/6] dt-bindings: leds: sc2731: Add compatible for SC2730
Message-ID: <177275466154.803692.10391970750803014459.robh@kernel.org>
References: <20260222-sc27xx-mfd-cells-v1-0-69526fe74c77@abscue.de>
 <20260222-sc27xx-mfd-cells-v1-2-69526fe74c77@abscue.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260222-sc27xx-mfd-cells-v1-2-69526fe74c77@abscue.de>
X-Rspamd-Queue-Id: 138D221980D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,bootlin.com,linux.alibaba.com];
	TAGGED_FROM(0.00)[bounces-43719-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Sun, 22 Feb 2026 14:16:46 +0100, Otto Pflüger wrote:
> The LED controller found in the SC2730 PMIC is compatible with the one
> found in the SC2731 PMIC.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---
>  Documentation/devicetree/bindings/leds/sprd,sc2731-bltc.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



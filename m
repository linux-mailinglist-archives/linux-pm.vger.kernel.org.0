Return-Path: <linux-pm+bounces-43720-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMy2HP4WqmlfLAEAu9opvQ
	(envelope-from <linux-pm+bounces-43720-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 00:51:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E284F21984B
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 00:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52C24301AB9B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 23:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A0636921F;
	Thu,  5 Mar 2026 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5dFUyRV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E82635E930;
	Thu,  5 Mar 2026 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772754679; cv=none; b=jlMTkLn9g3hsNj4yWUyxIsGYS70+N+55a3RTx7njSnFvst2MyT3skoUhg+S9G0n3v2/0QsaWTJWKh645oTOqjvvRliKZ3JDmfJO9yeF2Ljjfa5517FG5rfoU848Ae2WwlK/+tuIh10h5GMbH6JIwwJ4Ql8DyKnuE4LscpMu6Arc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772754679; c=relaxed/simple;
	bh=X8QfSm1VBg+Jlvkc3NdYVKlWCPYfLxkTMJ/pyRy6Oi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqxsL931yixyoEPKsEtm2h8LMMEw/aTpLo/h4aQKITjkQRsOQ9lVEggMzk96B6ht4YtuWIiAEiF74jox0IuAtv6ikZp6foMNsmjFGVg+GmsZSIrLlxB7LxoE1xpC/+kOw5pdmiDiWlUtXADUOSEay3gkbyI4dNoHpEkovz4l5Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5dFUyRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F61C116C6;
	Thu,  5 Mar 2026 23:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772754679;
	bh=X8QfSm1VBg+Jlvkc3NdYVKlWCPYfLxkTMJ/pyRy6Oi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5dFUyRVEopatX5TSIeQyPGnjzw5wqYmB9RnAr6+HGqzXCLS9fC1yhXuuMME0gFI4
	 nWx0uPPQcS514eIKN7o7P8QRAWXZ3xztaRbczWC+pW4AsdWCssoh0vhyNlGpOW9mgU
	 +sc/pxS1z1FHuh3CMaFuCpNqgmAAUoMMxyM/bM6gVOPgpATPoNlk/09Z4vi4wYE9C4
	 4mvXdOzyENdsTj8LY4bjNcZigPGCfR+fp3AkE2kD9JkLGDWXgJVy/MraRhhLkhOlj8
	 YqdeVNcOkYgSfwFuTcKy3NtMC5uHQP8da8sShv5D1fPw+aBqrBV2EeUvaw6MuVlDyS
	 8gbz1rXPQFaQQ==
Date: Thu, 5 Mar 2026 17:51:18 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, linux-leds@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-rtc@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: rtc: sc2731: Add compatible for SC2730
Message-ID: <177275467782.804137.1600349191144583031.robh@kernel.org>
References: <20260222-sc27xx-mfd-cells-v1-0-69526fe74c77@abscue.de>
 <20260222-sc27xx-mfd-cells-v1-1-69526fe74c77@abscue.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260222-sc27xx-mfd-cells-v1-1-69526fe74c77@abscue.de>
X-Rspamd-Queue-Id: E284F21984B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,bootlin.com,linux.alibaba.com];
	TAGGED_FROM(0.00)[bounces-43720-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Sun, 22 Feb 2026 14:16:45 +0100, Otto Pflüger wrote:
> The RTC block found in the SC2730 PMIC is compatible with the one found
> in the SC2731 PMIC.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---
>  Documentation/devicetree/bindings/rtc/sprd,sc2731-rtc.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



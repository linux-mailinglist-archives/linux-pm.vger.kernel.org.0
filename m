Return-Path: <linux-pm+bounces-42364-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKEjDvkfimnLHQAAu9opvQ
	(envelope-from <linux-pm+bounces-42364-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 18:57:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAD91134B0
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 18:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94C983016259
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 17:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9583859D7;
	Mon,  9 Feb 2026 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVfpnW++"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A4C3793D9;
	Mon,  9 Feb 2026 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659828; cv=none; b=vAcR/feBNh7xBpFZS2tTjhcWElKTqssrigUJj/Fign5cD+SmNwlrPCac3HrQkyz3+FP6xVqB4OeeVCeqJ5AtFsEWoHQLNRVZpZBLgm8X0053fDMzMLNfpn08591pxfl2mNy/hBJG6CmCzrgjtjcj+1DJO/Bn20ahc1qndNU2ooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659828; c=relaxed/simple;
	bh=856Kwd/pThJAAJaQCb3VCvhPWwgKfNaoq1rbMEQh96Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCej+ohdux6VZPfRb+GamM7XcQfgoc2yE/4rfBfRS2f9BmiW6/7JCdFiLTfJ8faWpj6OBYnuQCka+skvQkUbDo15h56YXYQvGiF8IL/xQr1eQfwJ1uXvthl8JHQjBLKeIxXSX9I5t4nvkQHt52jbedBp2eBqW1haJ3/ForCw/x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVfpnW++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B1AC116C6;
	Mon,  9 Feb 2026 17:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770659828;
	bh=856Kwd/pThJAAJaQCb3VCvhPWwgKfNaoq1rbMEQh96Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVfpnW++UfnqkCLXvrxoEODMMCE1rIQOm4Oso2M0V+9pyxzqj1tzwfnHQ3JwWSv5i
	 Mil182Oi5/i6zr+b/0hGMcBMB6MFKrS7rNvAPfshTpDXnv/bk6EcEdTOp8QbmmrZDa
	 AWCGOvipYJogChJUiQTZ7gnBZIKiV0uMZPWmRlwAPxQDxcOYr5m6fMUez0D2c+y/X0
	 ko3WAwp6WwPSUvhJTAV9D76TWRjzV61IF5NPiYJoPQLpeg+xVeQ4cUqxweLdTp4z22
	 A5Rlb+FcxYjuBcZoSmun1HJBt+JYOrJWY8qoVH6p5sG6hCl0xPUTbuX85J4oTdd7dL
	 3rlVqeG2APxIw==
Date: Mon, 9 Feb 2026 11:57:07 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: power: supply: cpcap-battery:
 document monitored-battery property
Message-ID: <177065982675.1491615.16948217039462649956.robh@kernel.org>
References: <20260130134021.353688-1-clamor95@gmail.com>
 <20260130134021.353688-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130134021.353688-2-clamor95@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42364-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAAD91134B0
X-Rspamd-Action: no action


On Fri, 30 Jan 2026 15:40:20 +0200, Svyatoslav Ryhel wrote:
> Document monitored-battery used to describe static battery cell properties.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../devicetree/bindings/power/supply/cpcap-battery.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



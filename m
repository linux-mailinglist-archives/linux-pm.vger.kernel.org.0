Return-Path: <linux-pm+bounces-43823-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JplJurdqmlqXwEAu9opvQ
	(envelope-from <linux-pm+bounces-43823-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:00:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 429E622235E
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77F3C3035E2D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 14:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABC530E84F;
	Fri,  6 Mar 2026 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igF5XwZk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C93A63F4;
	Fri,  6 Mar 2026 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805594; cv=none; b=HsFpNIN2X9xWIh5qrdsTSzhyZaqgy58g3gN2xxWxphR1I65V0hS1xcdh4BLt/kd1sfPEGADamMwcx2HVzbVwkPxzUKtEMYYdxXa0mbeeq8WmATqCElCN0YNA2gn+ThJ4FyFDnYJg8DpnpwVrydvtcfvMNSRoz37MwPcLM9JKEJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805594; c=relaxed/simple;
	bh=IBx8s4MEb82WlxxgDM5bJV6i1OaR8I0L+CFSnAv5e9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L9kpY/xFwLgLhneLk5PHOFR1RfLO7psD5GdjTRhMwPdgCdLRl8q/i5TN7TrDz5e5Ig/ja+z+DIIvXa+Odog8gOgYv5ii+ygzKaR4rGckpvtXvwELyzybmvna+4YZVq/dMvXuP4JcPdhiaUdgceKBFhbHq3cso4WCYkFifSZg/Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igF5XwZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B95C2BC87;
	Fri,  6 Mar 2026 13:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772805593;
	bh=IBx8s4MEb82WlxxgDM5bJV6i1OaR8I0L+CFSnAv5e9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=igF5XwZkDIVguvOozPEcoDIOUNb4XQBtPfO7s3jYmwgSbWpeqIZBYS5Gf/5uvLEzE
	 rSirtVCE+D17p03ffGx+3ruUkP4hE6XWxEywzZn4VtLKXQONo9suR6p/3aVC9BROdx
	 gSBNQuIGpqgXxwk21GOrfsqdQ4fWrupIsR+LbGcwCtKBkwVH6s/0EjqfNQsa3C2tca
	 GhBCMi7uezfrCWIjRhVKJAN7TOwHo52Z2pAPStb35e7DoyVgbUQISQviVuJHkjwA+a
	 Xl0eykpl9YXDOqtru0gBz6CDfejU6Frkuzp/pWsANxP21cme2JVECT//60L0kmR9oe
	 zR2fB8i9xCcpw==
From: Lee Jones <lee@kernel.org>
To: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>, Michael Reeves <michael.reeves077@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Hector Martin <marcan@marcan.st>
In-Reply-To: <20260217-b4-macsmc-power-v7-2-4a4d63664362@gmail.com>
References: <20260217-b4-macsmc-power-v7-2-4a4d63664362@gmail.com>
Subject: Re: (subset) [PATCH RESEND v7 2/2] mfd: macsmc: Wire up Apple SMC
 power driver
Message-Id: <177280559145.1054360.6985204095532084985.b4-ty@kernel.org>
Date: Fri, 06 Mar 2026 13:59:51 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38
X-Rspamd-Queue-Id: 429E622235E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,jannau.net,gompa.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-43823-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, 17 Feb 2026 21:47:26 +1100, Michael Reeves wrote:
> Add the cell for the macsmc-power driver so it is probed by the
> MFD core.
> 
> 

Applied, thanks!

[2/2] mfd: macsmc: Wire up Apple SMC power driver
      commit: fd708bd746a1c81e7467f61ee1b538b1f4f23383

--
Lee Jones [李琼斯]



Return-Path: <linux-pm+bounces-43611-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FWOIH+AqGmYvAAAu9opvQ
	(envelope-from <linux-pm+bounces-43611-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 19:57:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E74206B48
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 19:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 172C730AC486
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 18:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A849E3D301B;
	Wed,  4 Mar 2026 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvidYYT8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852823CE480;
	Wed,  4 Mar 2026 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650433; cv=none; b=GWWQktzwslIvlbOUR1MeOp+3sLP6jVWeE2fLpmJJ9dVtXRTdeV5d8Z6Cf8l08Wc3Mlwwb4NSJ4BrqUwp1wjHVS7g7DexSePmc/bdD1P8N2PNzxSJMjTM1g4Itlye4MWORhqOXbCrxT896uAyTr2GrUKG5kDN6KyIYgmD2va+lQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650433; c=relaxed/simple;
	bh=CliOUV72ekHmLpkXXmGJGc79ExY9Wz0CZYLwd8GDc68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bW6OsRaBOz+U1JJeApUenImzQIPhUiN9di12jkAl6TBZkgazlaytXxCWsHeBDGroUacgGXzjo4ZNILUEGqf2Y9dUsAn3mJ+yAz/pGiRKpB11E2rGcEpNZikjki41jFiSRsudTNC/dgasm1sAKsAEPR3atJVJi9pqsFvBwQ0IkOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvidYYT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E466C4CEF7;
	Wed,  4 Mar 2026 18:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772650433;
	bh=CliOUV72ekHmLpkXXmGJGc79ExY9Wz0CZYLwd8GDc68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvidYYT8yL6CWT3lD+7DPetAqKrnfZPzjX2EQv7G2N2aEUJS8MS5Z7CyUfGoBBHcB
	 ybV/cQ0tnoMnatekcKq9YLMmAoGv/DiQeC0QIWHiFI9waDIhcNdDj9CUF7mTcAoGdN
	 ZWm+tGy5cnDVqpj05GZGXCIciDHV3Zn9fYym7X7X9FdPZ2ByfYv6m4h/6G0IMfnlZy
	 A/tSx8U2xUlfqpGiWzYFHFJCrFdGKQGhLnpifMXoplKyFrKPkn5+cnHTJmLJJTuUEz
	 iNvlUyq8YcE+xVw1yIC8elPnvDyIuLpaO3BCNSkdVifPrdOg3gJeJ6rYg34gqZG50R
	 ok73WZyJiqTyQ==
Date: Wed, 4 Mar 2026 18:53:48 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>, linux-pm@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: arm: Add print after a successful probe for
 SCMI power domains
Message-ID: <20260304-arrogant-primitive-mustang-990de4@sudeepholla>
References: <20260304101457.7470-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304101457.7470-1-ulf.hansson@linaro.org>
X-Rspamd-Queue-Id: 24E74206B48
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
	TAGGED_FROM(0.00)[bounces-43611-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 11:14:57AM +0100, Ulf Hansson wrote:
> It can be discussed how useful a print is after a successful probe. In the
> SCMI power domain case it's seems valuable, as it let us inform about the
> number of initialized power domains too, which is fetched from firmware.
> 
> Therefore, let's add a print about this, which also aligns with the
> behaviour of the SCMI perf domain driver.
> 

I always assumed it was already there as dev_debug() but I am wrong.

Acked-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep


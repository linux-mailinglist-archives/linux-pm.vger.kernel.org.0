Return-Path: <linux-pm+bounces-42527-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHLAMmvujGmSvgAAu9opvQ
	(envelope-from <linux-pm+bounces-42527-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 22:02:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DD5127992
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 22:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20E533045015
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 21:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7269335970C;
	Wed, 11 Feb 2026 21:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQJz0tKo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEFF1CF7D5;
	Wed, 11 Feb 2026 21:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770843662; cv=none; b=elzJs8g5FecBbvtF8tpIzffLuCAQ8ZDRrf5AOdLFNSBPEm5zuswFbqjJU9wgpSDmlHGKpKvCI/w2KsZTB/XhFHtCt6SALay4ozH7XgHzFeLDz1/CrWkWevqzKNhZDaYpRlCRgNXKeHw236POp5i1ls15HXCtHewZ6gubEgn9pk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770843662; c=relaxed/simple;
	bh=81vYoliXZmQPM4sljejuzft3uMpQt89btl4VFLCbsSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOlmSjQylGZ2edsyalSfReiK2woOqQ2L8289Vyoy78kOChcsMYWPqtc+W1JDDqCKMSYBQvcdlkmNYR8xrZ+5/DyVmPFrf6jiO8mbuu2F4H35Ychi/kK/N/VFWDybh88eJM5D5b/xzNdTZZgAYlKeoDWGMiSNupSjoSZFVraASx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQJz0tKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E18C4CEF7;
	Wed, 11 Feb 2026 21:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770843661;
	bh=81vYoliXZmQPM4sljejuzft3uMpQt89btl4VFLCbsSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQJz0tKo8aUeXh6TkvYU1vU5JK6Eo5iW1nFylPT/CahIe4nbYOSMhke2fXXiCci/l
	 oSdm/vdR0/CI2NWgW5CyF0Lnozx0EPbaP12Gg/RWwVyWXvJXMoEfcw7eqij2yjZqG3
	 nPB8kCoNVQaIzSD4eXOiZTYBJO1FIbxFHNkKTSNlLALwEOPGHBOepWSHXTt14sE8+v
	 KLzx8ccqEXjfyVnqv1rCBLNbHwRGFA6/1Wty3T0OXWMzl71d+PlXb8p3yQ4vZtIZEj
	 q+sf/PXrqrDSSLoHdT+VYWVxMOxVF9C1M2O4l+TbDWzoNI0oMlT3UsQJ/dISCyiHsW
	 FqSIUqM8Hy9Jg==
Date: Wed, 11 Feb 2026 15:01:00 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-samsung-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
	Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Will McVicker <willmcvicker@google.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Juan Yescas <jyescas@google.com>
Subject: Re: [PATCH v5 02/10] dt-bindings: power: samsung: add google,gs101-pd
Message-ID: <177084366016.3875481.12715667820083029736.robh@kernel.org>
References: <20260205-gs101-pd-v5-0-ede49cdb57a6@linaro.org>
 <20260205-gs101-pd-v5-2-ede49cdb57a6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205-gs101-pd-v5-2-ede49cdb57a6@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-42527-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,samsung.com,lists.infradead.org,android.com,linaro.org,google.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 34DD5127992
X-Rspamd-Action: no action


On Thu, 05 Feb 2026 21:42:30 +0000, André Draszik wrote:
> Add support for the Google gs101 version of the Exynos power domains. A
> new compatible is needed because register fields have changed and
> because power domain operations involve interfacing with the TrustZone
> protection control on newer Exynos SoCs.
> 
> Power domains can also have a power supply linked to them, so add
> optional support for that, too. It is believed that all (existing)
> platforms could benefit from this, hence it's not being limited to
> gs101-pd.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> 
> ---
> v5:
> - add domain-supply and update commit message
> 
> v4:
> - add new vendor property samsung,dtzpc
> - drop previous tags due to that
> ---
>  .../devicetree/bindings/power/pd-samsung.yaml      | 33 ++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



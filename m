Return-Path: <linux-pm+bounces-43049-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBriBZ2DnGlwIwQAu9opvQ
	(envelope-from <linux-pm+bounces-43049-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 17:43:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3F417A06A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 17:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D96DA31A6F16
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 16:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C009A314D36;
	Mon, 23 Feb 2026 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZuxW3qu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302C0315D28;
	Mon, 23 Feb 2026 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864494; cv=none; b=TqNOjiGi6GTqv82ekl4xDX3GGXM7lw+FEdHEGwf/FJ6L6JNXy4oJCCzmC+Te+xrdFbtrVrxxUJP3pgJiR9sNWFICRCvKbFRsXGc4wthmm7XouehX23r1dE1wYQ95HleHMucGUXctpNaWMrA+3JabfJKjApDMyh8KBslHNbSiPsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864494; c=relaxed/simple;
	bh=suaUWlORKIGwzlRZHSCIjFWvt/bcAEKUefESFgeuJ2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Znx+yLGDf9fkYtBR9y2VQhMqSnTVSjDlRhLfxGDj05mFiPWSo2neViY6BCm+C7PTHiZVKALWjBLSvYO/uZ21sVFHcay6vA+uSzJTudNn4HxXd7X90efg9h4mSe641g1ZqDIvBs11iEEzrjhyTEauak66rCe0o4ANxhuzf5NT4L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZuxW3qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C1FC116C6;
	Mon, 23 Feb 2026 16:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771864493;
	bh=suaUWlORKIGwzlRZHSCIjFWvt/bcAEKUefESFgeuJ2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZuxW3quixNrGIEv6em7CTs6+Ip2bXxGaJQHl3z14BaVcTUd28aRwrOC4Gx3CSV+s
	 HzNuHwRNDXguEeSFY2ZDMgW+mdMy5SDus0lJEAwWOMwPfdekEZIzcjOjFeClVeSDKg
	 ufU2jdUv6OgFeDIIHIdhadNdBrE66G0uRps828dTnjERt8z206/ns8M5jc9CglNwBw
	 ZFixc5QqHAUYUjNhsb0rjuOIvGRUo4vWWusrFWuD6NhbnC83BEwTQKN4sIeouZaXfF
	 UWyect42tRjpBuzSDnOHrR3WPiiVVIeGwUfii3w6OdwqpjgAJ47kZb4+Z/0dbvgAXc
	 TjKGdDAT5+Cug==
Date: Mon, 23 Feb 2026 10:34:50 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, sre@kernel.org, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 5/5] power: supply: qcom_battmgr: Add support for
 Glymur and Kaanapali
Message-ID: <cvmoj4a3rfytyteprzhmszblssnoop2yvs4bpavaukmavxj2vh@znvdkclfjwvd>
References: <20260209204915.1983997-1-anjelique.melendez@oss.qualcomm.com>
 <20260209204915.1983997-6-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209204915.1983997-6-anjelique.melendez@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43049-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andersson@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A3F417A06A
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 12:49:15PM -0800, Anjelique Melendez wrote:
> Glymur is a compute platform which has the same power supply properties
> as X1E80100 and Kaanapali is a mobile platform which has the same power
> supply properties as SM8550. Add support for the Glymur and Kaanapali
> compatible strings.
> 

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  drivers/power/supply/qcom_battmgr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index c8028606bba0..576ff35b4b71 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -1610,6 +1610,8 @@ static void qcom_battmgr_pdr_notify(void *priv, int state)
>  }
>  
>  static const struct of_device_id qcom_battmgr_of_variants[] = {
> +	{ .compatible = "qcom,glymur-pmic-glink", .data = (void *)QCOM_BATTMGR_X1E80100 },
> +	{ .compatible = "qcom,kaanapali-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
>  	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
>  	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
>  	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
> -- 
> 2.34.1
> 


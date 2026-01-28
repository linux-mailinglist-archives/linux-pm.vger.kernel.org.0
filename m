Return-Path: <linux-pm+bounces-41611-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPdRHSn0eWnT1AEAu9opvQ
	(envelope-from <linux-pm+bounces-41611-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 12:34:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 414C7A07C6
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 12:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F5D33021170
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 11:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDE0353EFA;
	Wed, 28 Jan 2026 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anlabok3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3244434F46B;
	Wed, 28 Jan 2026 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599735; cv=none; b=onDXToUeiUK6NfqL/oA4dULOxKdTkRmX+2hLkihEMYCDUtg0EDOVEI3WzPiWJ/8oXW/OKVkNbMkt3otA5ZtNwLKJ6IyPLHMiE7lweIHjKMtG8dTx0dfINaRG9chXM74tf2MNqbHmZdvDsxvGNpwF0/rzJF5K2zYFXboWq/bPhQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599735; c=relaxed/simple;
	bh=g1X8kWF/5LVe8TM3fT6MhgF5Xzc+Yc5m5pGpUxvULJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOU5YKlOqFKl3WI60n9QrIDriJmNkfowhpEulnkCBvbdbYPetzISHv0qKOPcVUk/Cc2GfGUUBahohjBn3kcoFppIKIyr5K0jd7zCSIfJJ9Uxf+mRB+nJFoEfZ8yCSref3EVuWIivMWkaK/IuGtKiVOaFQ5CVnaLYFNqqK8rerJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anlabok3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C21C16AAE;
	Wed, 28 Jan 2026 11:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769599734;
	bh=g1X8kWF/5LVe8TM3fT6MhgF5Xzc+Yc5m5pGpUxvULJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=anlabok3h9ST5LOWzQ5P9Q3KWalowet+HjKAt9MUjFZiLpY5ZkkgHhOZjZ2SAz1ch
	 oCDe3QBCb3yi06vzjQwqh4m1LS2Y2GWi1EBLEIss2CGCL5DRcEoS36J7QdtVfKo6CC
	 UHIkmqYkiHItjfMPjBhThEJIuqIQGq1T6Fo56OVXBTggMKc4vfCAELahFutUZs74Pe
	 ZpX+WuScoZEQwnRPHXlohaLhfgUE/r6xyosElv0GQPn8ynDVUp6ZTkEeBftFeTF/nS
	 PfeLyh2LJTbcOIAuJsXylKjq8UGYLC+DE9tTAAbcmcDoRgNVFuV9JCY+TPVVMPpW3p
	 MR19C2JkvsyAQ==
Date: Wed, 28 Jan 2026 12:28:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	konradybcio@kernel.org, mani@kernel.org, casey.connolly@linaro.org, 
	amit.kucheria@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v2 2/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
Message-ID: <20260128-primitive-lynx-of-virtuosity-50a190@quoll>
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
 <20260127155722.2797783-3-gaurav.kohli@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127155722.2797783-3-gaurav.kohli@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41611-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 414C7A07C6
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 09:27:16PM +0530, Gaurav Kohli wrote:
> The cooling subnode of a remoteproc represents a client of the Thermal
> Mitigation Device QMI service running on it. Each subnode of the cooling
> node represents a single control exposed by the service.

Subject - almost bingo, you hit two out of three which you should not
use.

A nit, subject: drop second/last, redundant "bindings yaml" and whatever
else is duplicating. The "dt-bindings" prefix is already stating that
these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18


Best regards,
Krzysztof



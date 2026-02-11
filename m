Return-Path: <linux-pm+bounces-42529-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM9AB2vyjGmqvwAAu9opvQ
	(envelope-from <linux-pm+bounces-42529-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 22:19:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B565127B3C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 22:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06BED30F9A2B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 21:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAC435CBC6;
	Wed, 11 Feb 2026 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4gBczgv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85CD34EEF1;
	Wed, 11 Feb 2026 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770844350; cv=none; b=BUfN69jwPJP0mvSzeAcyKCvxGuaCI0Co5wT9xFRAByOBzTYcLODIQdPs730wB8gfCh03+par6bLCtIVJsC9QQWL8miQUiSeNbpYZzlPznk7Z2aU2jo3L2X+XkLRUFgPMvoSIa8TKgXeMWTQjCkZXfIhc2lGY7svsxFTOSEUhDCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770844350; c=relaxed/simple;
	bh=ZsXDR+ZmQZgcAFLTOvK08pR/QTvXK90/KVWwSRiQC3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPapCDSUJLLNaodytB7gM5MMqxBKdjDglNI1Rwv/h+wtZfZjjY8++AhSZxVz6Y9tvDEa2uPHOyOfJYhlhS/dRYKv9P3KNeOfHGEdtaW7I+1IcNnyRT15uPK0/PWd1/2J1OqoKP08f1L+wnubSr2wxn0o02bCHD2g2atlgdcmEpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4gBczgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321B6C4CEF7;
	Wed, 11 Feb 2026 21:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770844350;
	bh=ZsXDR+ZmQZgcAFLTOvK08pR/QTvXK90/KVWwSRiQC3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4gBczgv0CRF9wWjRyBcZ6sr4hzPtVjbbyR/fWi2KJF0JCap73Xh9p8TZkXVH/z6B
	 cIS5py2CePVPSyb+xh36Kw+IHHulK4SxFFhPy6vnv4bnGW5UcSvYcdpmGCRPsXwTF6
	 +9trG//gb98jf1b+MKRjoIoMWl8O3SDHUDSQcZIN2lGvas6QeTnDbCKziKkEq+TyDe
	 jDf9z8ZgWtrQplxsQReN2izQTI0yRTkD3kgAAmjrGsVyFil96U5u6denXcHrnPIqNr
	 bKyI8UwcokiGnYxz73fIkAwr3JWWYpzNkYCUIN+lL3OENK0YzAWJ9A6cXBesd2GJT1
	 uLvTBtDxxqoWQ==
Date: Wed, 11 Feb 2026 15:12:29 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Juan Yescas <jyescas@google.com>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v5 04/10] dt-bindings: soc: google: gs101-pmu: allow
 power domains as children
Message-ID: <20260211211229.GA3882182-robh@kernel.org>
References: <20260205-gs101-pd-v5-0-ede49cdb57a6@linaro.org>
 <20260205-gs101-pd-v5-4-ede49cdb57a6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205-gs101-pd-v5-4-ede49cdb57a6@linaro.org>
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
	TAGGED_FROM(0.00)[bounces-42529-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,linaro.org,gmail.com,google.com,android.com,lists.infradead.org,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: 7B565127B3C
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 09:42:32PM +0000, André Draszik wrote:
> The power domains are a property of / implemented in the PMU. As such,
> they should be modelled as child nodes of the PMU.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
> v4:
> - consistent quoting using " (Krzysztof)
> - add samsung,dtzpc to example
> 
> Note: Ideally, the newly added properties (ranges, etc.) should only be
> 'required' if "^power-domain@[0-9a-f]+$" exists as a patternProperty,
> as they're needed only in that case. As-is, this patch now causes
> warnings for existing DTs as they don't specify the new properties (and
> they shouldn't need to). 

We can't have warnings added if they aren't valid.

> Only if DTs are updated to include
> power-domains, such an update should also add the new properties.
> 
> I've not been able to come up with the correct schema syntax to achieve
> that. dependencies, dependentRequired, and dependentSchemas don't seem
> to support patterns. Similarly,
>   - if:
>       required:
>         - ...
>     then:
>       required:
>         - ...
> 
> doesn't allow patterns in the 'if' block (or I didn't get the syntax
> right).
> 
> Rob said in
> https://lore.kernel.org/all/20251010141357.GA219719-robh@kernel.org/
> that this is a known limitation in json-schema.

For a given compatible, you should either have child nodes or you don't. 
The h/w is not variable. So something like this should work:

if:
  properties:
    compatible:
      contains:
        const: foo,bar

then:
  required:
    - ranges
    - '#address-cells'
    - '#size-cells'

Rob


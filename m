Return-Path: <linux-pm+bounces-41548-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KJxLSXbeGmwtgEAu9opvQ
	(envelope-from <linux-pm+bounces-41548-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 16:35:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5829496D0E
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 16:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3062308460A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F74235EDBE;
	Tue, 27 Jan 2026 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHES0Nxa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B834EAE7;
	Tue, 27 Jan 2026 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527057; cv=none; b=AC1xSz5ipc3Vu9Lqw/SA0FVmlv7atLKd6TMCcLtvYSpWFKPQN7TEaacbx59PcTdiI359dFZg5QlxoblCfk/KMkd//c2bacxj8a19kXrNDFM3e+CZiPRAl+f0QXIoO5alCZ+HHilPK7r+rZ65gGGLMzZMJ9lfatTcf22kN3gslMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527057; c=relaxed/simple;
	bh=06YFaYPc4N1f9nnWVb6MYBol7sp8w7ue49DiDGANxVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUmRJboK7pbFjdDwFlJQY7Nk59fJxQrHLj1yXUJzcbBMC0mKOEXgWesc4f7ZYsjmYpARPF2dCgli16MbIkIup3guqHSYcquOOARMpdxbd8S1c4RoSqwibeYH3IgJlAnwU8K8XxLZ5JZmmmc3g1goOTKB5pZKdS+RstgQ4b2PdHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHES0Nxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81194C116C6;
	Tue, 27 Jan 2026 15:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769527056;
	bh=06YFaYPc4N1f9nnWVb6MYBol7sp8w7ue49DiDGANxVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sHES0NxaudMq/qmeoTiz0aeclmGvJfz6FxHT6K36GqTbqX7FuX2L4MAYRvyv2v4+X
	 BO8l5M8snhZ8zh6nJ9R9fVzCk1PGKpa0Si8inyfomPFntwM/9OBbQEYi5+xV2hK9Zt
	 qRMHdYlFhrhArQZJJNNQoMB/UGmUjNpyKB0ttAxROg3Q8JEWRMqN2ZeLs4Yh2y8GiJ
	 RTfouRyNIM2aGEtnaMuLeCyPstykfmMm75Sb8mUaDNqSZNW1KN9ronMaiveSfvW+A5
	 qi47mLikdVZfjQDeb5VjMW11aG3f+FEG8+eJlswA8Muqs7glrWyhKuZxH4fXd5YFwx
	 ZeZoJNND0LucQ==
Date: Tue, 27 Jan 2026 09:17:35 -0600
From: Rob Herring <robh@kernel.org>
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v5 1/2] pmdomain: core: support domain hierarchy via
 power-domain-map
Message-ID: <20260127151735.GA1699112-robh@kernel.org>
References: <20260122-pmdomain-hierarchy-onecell-v5-0-76855ec856bd@baylibre.com>
 <20260122-pmdomain-hierarchy-onecell-v5-1-76855ec856bd@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-pmdomain-hierarchy-onecell-v5-1-76855ec856bd@baylibre.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41548-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.11:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5829496D0E
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 05:14:00PM -0800, Kevin Hilman (TI) wrote:
> Add of_genpd_[add|remove]_subdomain_map() helper functions to support
> hierarchical PM domains defined by using power-domains-map

power-domain-map. No 's'.

> property (c.f. nexus node maps in DT spec, section 2.5.1).
> 
> This enables PM domain providers with #power-domain-cells > 0 to
> establish subdomain relationships via the power-domain-map property,
> which was not previously possible.
> 
> These new helper functions:
> - uses an OF helper to iterate to over entries in power-domain-map
> - For each mapped entry: extracts child specifier, resolves parent phandle,
>   extracts parent specifier args, and establishes subdomain relationship
> - Calls genpd_[add|remove]_subdomain() with proper gpd_list_lock mutex protection
> 
> Example from k3-am62l.dtsi:
> 
>   scmi_pds: protocol@11 {
>       #power-domain-cells = <1>;
>       power-domain-map = <15 &MAIN_PD>,  /* TIMER0 */
>                          <19 &WKUP_PD>;  /* WKUP_TIMER0 */
>   };
> 
>   MAIN_PD: power-controller-main {
>       #power-domain-cells = <0>;
>   };
> 
>   WKUP_PD: power-controller-main {
>       #power-domain-cells = <0>;
>   };
> 
> This allows SCMI power domain 15 to become a subdomain of MAIN_PD, and
> domain 19 to become a subdomain of WKUP_PD.

One concern I have here is generally *-map is transparent meaning when 
you lookup <&scmi_pds 15>, &MAIN_PD is returned as the provider. It's 
also possible to have a map point to another map until you get to the 
final provider. The only way we have to support both behaviors is the 
consumer has to specify (i.e. with of_parse_phandle_with_args_map() vs. 
of_parse_phandle_with_args()), but the consumer shouldn't really know 
this detail.

Maybe a transparent map of power-domains would never make sense. IDK. If 
so, then there's not really any issue since the pmdomain core handles 
everyone the same way.

Rob


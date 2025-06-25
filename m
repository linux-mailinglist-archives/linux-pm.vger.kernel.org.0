Return-Path: <linux-pm+bounces-29503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D944BAE82F0
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 14:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0E61C22A27
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 12:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1625925F990;
	Wed, 25 Jun 2025 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUb5tUm2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB58C25F985;
	Wed, 25 Jun 2025 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855307; cv=none; b=EkVIoC4nSCY9Wf7YMMgvtkNONdHW7AAcX9iC1NulApneXRHqGnJ9O1GjmckDnRZ1AwQRbz49ph6gMAZB64/cUJ3JbDmWwxWfv/lsp1fJ8Zc37PrEwPYyIuHq50nlI2oivmg/nkEvG3iTTCWP3xW5o5MxfDmc9ZSWDI9OeO6UItU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855307; c=relaxed/simple;
	bh=7MJm5jgbgPDqBJsyip5lTcodZwc88Jr5IFDoaQfjsnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffNsIi6QqSRzEWdnmCyNANGhbgXwW8lU0G6E2JW9U0quwEiQaHWcSWikaIajfTpCuv2qdSZH/aigXWQcDubXn+XAw/ytaT4W9nM704GtsUx+NPb5okP6uYziJa4Noyk80swevSCvA9n7JEUmQ3NyqQybFUoecM3DOSsS0jkwnjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUb5tUm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA86C4CEEA;
	Wed, 25 Jun 2025 12:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750855306;
	bh=7MJm5jgbgPDqBJsyip5lTcodZwc88Jr5IFDoaQfjsnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FUb5tUm2+FSXphyzv2xlRwaGx85DWwQfrArtX04EyY3QMDCOtcHBpl5618FVrriFx
	 5lNt7jAHDPd1gBuhohrp642uuqkfMFYAqD00Zndx0HS67ERS3cwPaeedjTfyucMwVR
	 rGlKezpMdKCvVr6Tcf37ZyE/C+LKahELo7fSz/Kq/toqKK8A8320u3D5nRUwZkLeI2
	 aVt7pGwvLvDH2cyEUndtY2zTbaSCpW8ApI++ybjONFNquxUMNLDwWZHPTJTZUfcDos
	 wgTdxNdUIGZWt/jKUT2PRMqdE1yQJr55AzAWgYNjFezMiif9Y+c/y+2Vw7Uye4rmWK
	 j97brtCTwN3Kg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uUPRh-000000006ur-0otm;
	Wed, 25 Jun 2025 14:41:45 +0200
Date: Wed, 25 Jun 2025 14:41:45 +0200
From: Johan Hovold <johan@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Georgi Djakov <djakov@kernel.org>,
	Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] interconnect: avoid memory allocation when
 'icc_bw_lock' is held
Message-ID: <aFvuiVX0kMIqXQtZ@hovoldconsulting.com>
References: <20250625-icc-bw-lockdep-v3-1-2b8f8b8987c4@gmail.com>
 <aFvr1zSkf4KmIcMT@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFvr1zSkf4KmIcMT@hovoldconsulting.com>

On Wed, Jun 25, 2025 at 02:30:15PM +0200, Johan Hovold wrote:
> On Wed, Jun 25, 2025 at 01:25:04PM +0200, Gabor Juhos wrote:

> > @@ -276,13 +276,17 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
> >  		qcom_icc_bcm_init(qp->bcms[i], dev);
> >  
> >  	for (i = 0; i < num_nodes; i++) {
> > +		bool is_dyn_node = false;
> > +
> >  		qn = qnodes[i];
> >  		if (!qn)
> >  			continue;
> >  
> >  		if (desc->alloc_dyn_id) {
> > -			if (!qn->node)
> > +			if (!qn->node) {
> 
> AFAICS, qn->node will currently never be set here and I'm not sure why
> commit 7f9560a3bebe ("interconnect: qcom: icc-rpmh: Add dynamic icc node
> id support") added this check, or even the node field to struct
> qcom_icc_desc for that matter.
> 
> But if there's some future use case for this, then you may or may not
> need to make sure that a name is allocated also in that case.

Ok, I see what's going on. The qn->node may have been (pre-) allocated
in icc_link_nodes() dynamically, which means you need to make sure to
generate a name also in that case.

> And that could be done by simply checking if node->id >=
> ICC_DYN_ID_START instead of using a boolean flag below. That may be
> preferred either way.

So you should probably use node->id to determine this.

Johan


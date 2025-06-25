Return-Path: <linux-pm+bounces-29512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22585AE8577
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 16:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04DC17AB8E
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C95A2609EA;
	Wed, 25 Jun 2025 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsxRvAra"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C59313D53B;
	Wed, 25 Jun 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860131; cv=none; b=Bm0WmDF1+kQQUz+vKhKWwZNNfNpfGXeCGm+oJcFujFlPznTxXX/4fofJVEIicOgAX+mXD3nW1Or8S21/qsIpZYLFYe6zmLgwsLV8KmZWffuoa/Hcf0OIGScA/x4IFPXLp3nU9t/VcbLjLBdld/o7YSTGdincSiVz+lKZxaV094Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860131; c=relaxed/simple;
	bh=0E1iOgTDOe4/hcWEs/6My5mcmsk96XV7Vrk9N+Jysxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0TUrYuY6etyF6iYN4mYFkX+MEPr5MH/M3XBmlFeCn3JjZRCaJTdpSl1mS/ojMWJt9MCqRag0OIOZUqUHk6dIsDqH5nZDwrLS62+TqDIrz0jh26/+63vJG8i6JCiEEISaP4JNBDw2LgbwczmZ+gdYv1V5w2CNtH0HhnOMWlvyN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsxRvAra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1662C4CEEA;
	Wed, 25 Jun 2025 14:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860129;
	bh=0E1iOgTDOe4/hcWEs/6My5mcmsk96XV7Vrk9N+Jysxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PsxRvAra1+UYAxXNOQfwyROihYt1SLubVcs64pvGPUQv4NrfV/ZDvKniPhQp7iaMc
	 2E8WSNQMZq4HAR/7TuU6I5/1/v4Sfw+RbxU5GBtdgyly9HNSNirynkWPV7o1UuyWzC
	 0P7IdB0BcktrXzRN0UoRhNamc0YTldId3dqdOL1ghooDaGDuBx05voZQfUjD0Fj5lg
	 2IV2XhdLpfxI6s5YKtUSJCiOFYdeqI2U3x8xiaAcwc4ylzGl5CyAeO3waXi/GZ9gD+
	 d/v3F7klREapn0BL5nVQWuZgZVk+Vd2YeeT/QZTJ7h+iFJBHBAkHFDvYd+wEcLBAi8
	 pQaYVLvnm7bvQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uUQhV-0000000080x-2DfT;
	Wed, 25 Jun 2025 16:02:09 +0200
Date: Wed, 25 Jun 2025 16:02:09 +0200
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
Message-ID: <aFwBYRF0wJwVDdeX@hovoldconsulting.com>
References: <20250625-icc-bw-lockdep-v3-1-2b8f8b8987c4@gmail.com>
 <aFvr1zSkf4KmIcMT@hovoldconsulting.com>
 <aFvuiVX0kMIqXQtZ@hovoldconsulting.com>
 <84b94649-a248-46b0-a401-772aeb8777a2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84b94649-a248-46b0-a401-772aeb8777a2@gmail.com>

On Wed, Jun 25, 2025 at 03:15:53PM +0200, Gabor Juhos wrote:
> 2025. 06. 25. 14:41 keltezéssel, Johan Hovold írta:
> > On Wed, Jun 25, 2025 at 02:30:15PM +0200, Johan Hovold wrote:
> >> On Wed, Jun 25, 2025 at 01:25:04PM +0200, Gabor Juhos wrote:
> > 
> >>> @@ -276,13 +276,17 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
> >>>  		qcom_icc_bcm_init(qp->bcms[i], dev);
> >>>  
> >>>  	for (i = 0; i < num_nodes; i++) {
> >>> +		bool is_dyn_node = false;
> >>> +
> >>>  		qn = qnodes[i];
> >>>  		if (!qn)
> >>>  			continue;
> >>>  
> >>>  		if (desc->alloc_dyn_id) {
> >>> -			if (!qn->node)
> >>> +			if (!qn->node) {
> >>
> >> AFAICS, qn->node will currently never be set here and I'm not sure why
> >> commit 7f9560a3bebe ("interconnect: qcom: icc-rpmh: Add dynamic icc node
> >> id support") added this check, or even the node field to struct
> >> qcom_icc_desc for that matter.
> >>
> >> But if there's some future use case for this, then you may or may not
> >> need to make sure that a name is allocated also in that case.
> > 
> > Ok, I see what's going on. The qn->node may have been (pre-) allocated
> > in icc_link_nodes() dynamically, which means you need to make sure to
> > generate a name also in that case.
> > 
> >> And that could be done by simply checking if node->id >=
> >> ICC_DYN_ID_START instead of using a boolean flag below. That may be
> >> preferred either way.
> > 
> > So you should probably use node->id to determine this.
> 
> You are right. The problem is that ICC_DYN_ID_START is only visible from the
> core code. Either we have to move that into the 'interconnect-provider.h' header
> or we have to add an icc_node_is_dynamic() helper or something similar.
> 
> Which is the preferred solution?

I think adding a helper like icc_node_is_dynamic() in a separate
preparatory patch is best here.

If it wasn't for nodes now being created also in icc_link_nodes() we
could otherwise perhaps just as well have moved the name generation into
icc_node_create_dyn(). Now it seems we'd need a new helper to set the
name (or add error handling for every icc_node_add()), but we've already
spent way too much time trying to clean up this mess...

Johan


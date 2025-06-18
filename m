Return-Path: <linux-pm+bounces-28959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B27ADED04
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 14:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6514116454B
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 12:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45E42E06FC;
	Wed, 18 Jun 2025 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJ8E1Hv5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8869A2BF013;
	Wed, 18 Jun 2025 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251052; cv=none; b=GRKh7aQ1givEabDAJDn5BCygtsdb/xs5rAYgPYrgyjxvPT7JlLD3aC0x1StI5mYQK2toTu3kE5fYyQ0uau78vCHuSh8F0GQmDTYKstSmCAhd/NcHBiYRLT2bFDtxFfs6KFq/IMwx17Bpd9VeUBfTQDgtuUFG/OwhyfsSu7SqdAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251052; c=relaxed/simple;
	bh=ZSj/R+8J8mVMWAp2q9IOUy7kGCsK8aMkmayHlgXuTVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rlz9lUg24L2jLE0tNxWjtSoM2QxvmVmFiKt29qOR7PI3UOvcbhNL+DGr18MUH67+nEAe4hPGxXUDh0hMyqccS25nYuUj+NpcD2/kpPN2BNNlZtCbkSizOaXgUBVO3ShHBTySPg4oBjk5uxPO1XUK2LjI0fqIUmWijHrpqsxK4c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJ8E1Hv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FF8C4CEE7;
	Wed, 18 Jun 2025 12:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750251052;
	bh=ZSj/R+8J8mVMWAp2q9IOUy7kGCsK8aMkmayHlgXuTVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJ8E1Hv5F2GJ3Fl04RIvng2/6uT131VeCqskRFOop+D/1W+M9QmguFt1Ae8jJnK5y
	 FZr+NZAIOBKrkut6LeGGrWa/EYvkXqQ6/evWVZSFT2n8rVzJyGs3BqUPZYPjM2ya8e
	 ZASqEcT7q/0quA90fnWNkAhyA+s0eN1fNBnNgOxOCcuuLZtSm0k07vt+5zSyr00/4/
	 le4genhxBKoNV3EVHXXXvPNXfwFamvf+JbPNuziusBasIwPlDNjKt7d4QXJTAeoDUb
	 G2Exb7o0A6HwtLXCqqNoDwFnaXd2zHPOViUnM74dapk3DV1xc4Wcy2ffGeiDDmFw2E
	 Q26dwp89nSlbw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uRsFe-000000002SW-2uxe;
	Wed, 18 Jun 2025 14:50:51 +0200
Date: Wed, 18 Jun 2025 14:50:50 +0200
From: Johan Hovold <johan@kernel.org>
To: Bryan O'Donoghue <bod.linux@nxsw.ie>,
	Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Gabor Juhos <j4g8y7@gmail.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: avoid memory allocation when 'icc_bw_lock'
 is held
Message-ID: <aFK2Kl2I46dTYBI1@hovoldconsulting.com>
References: <TIkPOGVjPeCjPzjVtlSb6V5CIcpaXf2-6WG6HjAyaOW59Hj01-9VK7Z8DKadakOKr6fJeQICi6h0Z8mft9DQyg==@protonmail.internalid>
 <20250529-icc-bw-lockdep-v1-1-3d714b6a9374@gmail.com>
 <ca9f7308-4b92-4d23-bfe7-f8d18d20de10@linaro.org>
 <75a46897-040f-4608-88f5-22c99c8bed97@gmail.com>
 <04ab699e-b344-4ba1-9ca1-04b6e50beefe@nxsw.ie>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04ab699e-b344-4ba1-9ca1-04b6e50beefe@nxsw.ie>

[ +CC: Rob ]

On Tue, Jun 03, 2025 at 10:01:31AM +0000, Bryan O'Donoghue wrote:
> On 03/06/2025 10:15, Gabor Juhos wrote:

> > 2025. 05. 30. 11:16 keltezéssel, Bryan O'Donoghue írta:
> >> On 29/05/2025 15:46, Gabor Juhos wrote:
> >>> The 'icc_bw_lock' mutex is introduced in commit af42269c3523
> >>> ("interconnect: Fix locking for runpm vs reclaim") in order
> >>> to decouple serialization of bw aggregation from codepaths
> >>> that require memory allocation.
> >>>
> >>> However commit d30f83d278a9 ("interconnect: core: Add dynamic
> >>> id allocation support") added a devm_kasprintf() call into a
> >>> path protected by the 'icc_bw_lock' which causes this lockdep
> >>> warning (at least on the IPQ9574 platform):

> >>> Move the memory allocation part of the code outside of the protected
> >>> path to eliminate the warning. Also add a note about why it is moved
> >>> to there,

> >>> @@ -1023,6 +1023,16 @@ void icc_node_add(struct icc_node *node, struct
> >>> icc_provider *provider)
> >>>            return;
> >>>
> >>>        mutex_lock(&icc_lock);
> >>> +
> >>> +    if (node->id >= ICC_DYN_ID_START) {
> >>> +        /*
> >>> +         * Memory allocation must be done outside of codepaths
> >>> +         * protected by icc_bw_lock.
> >>> +         */
> >>> +        node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
> >>> +                        node->name, dev_name(provider->dev));
> >>> +    }
> >>> +
> >>>        mutex_lock(&icc_bw_lock);
> >>>
> >>>        node->provider = provider;
> >>> @@ -1038,10 +1048,6 @@ void icc_node_add(struct icc_node *node, struct
> >>> icc_provider *provider)
> >>>        node->avg_bw = node->init_avg;
> >>>        node->peak_bw = node->init_peak;
> >>>
> >>> -    if (node->id >= ICC_DYN_ID_START)
> >>> -        node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
> >>> -                        node->name, dev_name(provider->dev));
> >>> -
> >>>        if (node->avg_bw || node->peak_bw) {
> >>>            if (provider->pre_aggregate)
> >>>                provider->pre_aggregate(node);

> >> The locking in this code is a mess.
> >>
> >> Which data-structures does icc_lock protect node* pointers I think and which
> >> data-structures does icc_bw_lock protect - "bw" data structures ?
> >>
> >> Hmm.
> >>
> >> Looking at this code I'm not sure at all what icc_lock was introduced to do.
> > 
> > Initially, only the 'icc_lock' mutex was here, and that protected 'everything'.
> > The 'icc_bw_lock' has been introduced later by commit af42269c3523
> > ("interconnect: Fix locking for runpm vs reclaim") as part of the
> > "drm/msm+PM+icc: Make job_run() reclaim-safe" series [1].
> > 
> > Here is the reason copied from the original commit message:
> > 
> >      "For cases where icc_bw_set() can be called in callbaths that could
> >      deadlock against shrinker/reclaim, such as runpm resume, we need to
> >      decouple the icc locking.  Introduce a new icc_bw_lock for cases where
> >      we need to serialize bw aggregation and update to decouple that from
> >      paths that require memory allocation such as node/link creation/
> >      destruction."
> 
> Right but reading this code.
> 
> icc_set_bw();
> icc_lock_bw - protects struct icc_node *
> 
> icc_put();
> icc_lock - locks
> icc_lock_bw -locks directly after protects struct icc_node *
> 
> icc_node_add current:
> icc_lock - locks
> icc_lock_bw - locks
>      node->name = devm_kasprintf();
> 
> After your change
> 
> icc_node_add current:
> icc_lock - locks
>      node->name = devm_kasprintf();
> icc_lock_bw - locks
>      owns node->provider - or whatever
> 
> And this is what is prompting my question. Which locks own which data here ?
> 
> I think we should sort that out, either by removing one of the locks or 
> by at the very least documenting beside the mutex declarations which 
> locks protect what.

Feel free to discuss that with Rob who added the icc_lock_bw, but it's
unrelated to the regression at hand (and should not block fixing it).

Allocations cannot be done while holding the icc_lock_bw, and this fix
is correct in moving the allocation (also note that the node has not
been added yet).

Johan


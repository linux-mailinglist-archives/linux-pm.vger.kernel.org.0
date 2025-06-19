Return-Path: <linux-pm+bounces-29064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C0DAE0261
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 12:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A441BC3363
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 10:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71F0221720;
	Thu, 19 Jun 2025 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlG12O1r"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B09035963;
	Thu, 19 Jun 2025 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750327674; cv=none; b=otRbLh1MVKi2+OsHt/MPwHvoaOpRf5UXxZ840DXwnrgV9Wi2OoyB3rilB8vpGkWWRGKJN8MYHHc7PIpyRjlf5CiAbUYV9cRBUqaeA7U2cF1UTwfYPcJKYINpdKScFDvm/NTIc53Cw1K9WfhVIl45xRxNRpebRJs7agk4prSzMcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750327674; c=relaxed/simple;
	bh=y84ihwLVqY+Z1Q9OZ9Yk0150Oszxpg9LZot/6iCeLl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktTcpHT0pkq8h7OobAsq5MU/Z3Q/epFWH9mj+0jEPT1Ei1cgOXiSD6ZjbACd5GnypdXxTSotaO3vQqe4BYPqVNLWNGkIO4MdZUQ9LHyMtcWOcV6BPoEqkmZvRAC1JniJ9ypIcTwPaTYmLXwDPj0NRo9epVUC5DwJ89O4oDhy1Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlG12O1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C59C4CEEA;
	Thu, 19 Jun 2025 10:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750327674;
	bh=y84ihwLVqY+Z1Q9OZ9Yk0150Oszxpg9LZot/6iCeLl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlG12O1rSjWxnM4KDRwivPvB12BZKYoxfgdd6yq8v1FaJKIi8pCdKAXqUlkYOyC4s
	 zViEbelUy15Gc1UA9/z9q6xa0ttTXnImDSgF8L3vu5t4mQiBpprqhWpD8bHlpWmIOH
	 3C/xp0a4MwUVqcF8QbOtRVuHmnUx0QcckOPbp1zdlPnFAJf+mm9/9KY5GP8WLjFh3D
	 nwUEIIVGP2MiiMZsdasqlV5cDOEhGNpDNbTxGPfzZB5fVjgqXN6AwDJHlyd0EimhPK
	 YrzieeIgKHYbmatRXVR81PdUZfXfj/pA27XBY8k8/KsImGg8h+l6kGUL93/nCobV71
	 38ZSIDzb1G2tg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uSCBR-000000002R1-3Y8c;
	Thu, 19 Jun 2025 12:07:50 +0200
Date: Thu, 19 Jun 2025 12:07:49 +0200
From: Johan Hovold <johan@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Georgi Djakov <djakov@kernel.org>,
	Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] interconnect: avoid memory allocation when
 'icc_bw_lock' is held
Message-ID: <aFPhdWoZDOrdrbQz@hovoldconsulting.com>
References: <20250618-icc-bw-lockdep-v2-1-3223da346765@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-icc-bw-lockdep-v2-1-3223da346765@gmail.com>

On Wed, Jun 18, 2025 at 09:58:31PM +0200, Gabor Juhos wrote:
> The 'icc_bw_lock' mutex is introduced in commit af42269c3523
> ("interconnect: Fix locking for runpm vs reclaim") in order
> to decouple serialization of bw aggregation from codepaths
> that require memory allocation.
> 
> However commit d30f83d278a9 ("interconnect: core: Add dynamic
> id allocation support") added a devm_kasprintf() call into a
> path protected by the 'icc_bw_lock' which causes this lockdep
> warning (at least on the IPQ9574 platform):
> 
>     ======================================================
>     WARNING: possible circular locking dependency detected
>     6.15.0-next-20250529 #0 Not tainted

> Move the memory allocation part of the code outside of the protected
> path to eliminate the warning, and add a note about why it is moved
> to there. Also add memory allocation failure handling, while we are
> at it.
> 
> Fixes: d30f83d278a9 ("interconnect: core: Add dynamic id allocation support")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
> Changes in v2:
>   - move memory allocation outside of icc_lock
>   - issue a warning and return without modifying the node name in case of
>     memory allocation failure, and adjust the commit description
>   - remove offered tags from Johan and Bryan
>     Note: since I was not sure that that the added WARN_ON() is a substantial
>     change or not, I have removed the offered tags intentionally to be on the
>     safe side

Bah, what a mess (thanks for dropping the tags).

This dynamic id feature looks like a very ad-hoc and badly designed
interface.

icc_node_add() should not be allocating memory in the first place as it
is not designed to ever fail (e.g. does not return errors).

Generating the name could have been done as part of of
icc_node_create_dyn() or yet another helper for the caller could have
been added for that. In any case, it should be done before calling
icc_node_add().

Perhaps the best minimal fix of the regression is to move the allocation
into the two users of this interface. They already handle both dynamic
and non-dynamic node allocation explicitly.

Then whoever cares about this code can come up with a common interface
for allocating the name (e.g. move it into icc_node_create_dyn() or add
a new icc_node_init() helper or similar).

> ---
>  drivers/interconnect/core.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 1a41e59c77f85a811f78986e98401625f4cadfa3..32d969c349093bc356dc66234c62484aa9b9e872 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -1022,6 +1022,21 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
>  	if (WARN_ON(node->provider))
>  		return;
>  
> +	if (node->id >= ICC_DYN_ID_START) {
> +		char *name;
> +
> +		/*
> +		 * Memory allocation must be done outside of codepaths
> +		 * protected by icc_bw_lock.
> +		 */
> +		name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
> +				      node->name, dev_name(provider->dev));
> +		if (WARN_ON(!name))
> +			return;

But this won't do. We'd need to return an error to the caller (even if
this small allocation will never fail in practice).

> +
> +		node->name = name;
> +	}

Johan


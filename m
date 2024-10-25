Return-Path: <linux-pm+bounces-16459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2079B0495
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 15:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B28BB23354
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 13:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C9A1E0DA0;
	Fri, 25 Oct 2024 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsBfQdx0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732A81B6D00;
	Fri, 25 Oct 2024 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864374; cv=none; b=bgqZDMC+R9XFANQR9NRHrIkLGKP8vxOPb2MMbr9YYOfgvA4OxUVgd3W7wx786GSd8raCwdGaquFz+dbR7UelPfyx+JnBU44WGWk2QiO7CgbhirOdgusfEniP9A7ihIVdfbIHTRjqfbZBtRtxhsZ4NnZGYfFpzirEtU/tI1ih9BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864374; c=relaxed/simple;
	bh=Wv3aCtUjrX3Tkk0PNmsoXwKN+ujtjrsASQlTPopqlFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7s7cz752cC9S6mIpNtIvPGX3DX0JGGGSUE0/9TFKdx42JROjkMx5WWzanoFw8TnJk54jqDkMHvO5aIQQT2hafc6rRvO3RixcC8u8HxwldHwymKzeru8iQlRFLDO79+/J/SdIkgmQuJ2H7OLoWwZZBvNyf8/vcCGINKpJS2UJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsBfQdx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB083C4CEC3;
	Fri, 25 Oct 2024 13:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729864374;
	bh=Wv3aCtUjrX3Tkk0PNmsoXwKN+ujtjrsASQlTPopqlFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rsBfQdx0CYpVQgYnKJ3fw+cPRsfW+IWq+2HTElyCPEZ0uy5y5Rt4DQ47La0XYGBcq
	 s8CK0gl0+Kmdpc8QSGbLAFxC5KRbaC27w+8KDKfwp/N1+KbGvaFFwSLknMvaG0gWNn
	 S2QG08s0uacuO0RbKXAEb1dKDvU2t59iGWnN42Heyv5yoPHq2/o50aVadRqexTOZTx
	 WZoEAB3u1yJnSU8fkylIyYJ7JSkH+hKvTnaHvqVrqMx1mTie/W6kb4VhkF48CQ2zNT
	 UX2Ls9un9yf8xoMKgCbz6ww7aTgekpEWuzz9WtHwlxe+LXHprg1yjP/plywoQL5/1P
	 uicHUBGyoTXvA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t4KkZ-000000005ph-1vTz;
	Fri, 25 Oct 2024 15:53:12 +0200
Date: Fri, 25 Oct 2024 15:53:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, ulf.hansson@linaro.org,
	jassisinghbrar@gmail.com, dmitry.baryshkov@linaro.org,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	konradybcio@kernel.org, linux-pm@vger.kernel.org,
	tstrudel@google.com, rafael@kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH V4 3/4] pmdomain: core: Fix debugfs node creation failure
Message-ID: <ZxuixxBzQZUdIW1c@hovoldconsulting.com>
References: <20241023102148.1698910-1-quic_sibis@quicinc.com>
 <20241023102148.1698910-4-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023102148.1698910-4-quic_sibis@quicinc.com>

On Wed, Oct 23, 2024 at 03:51:47PM +0530, Sibi Sankar wrote:
> The domain attributes returned by the perf protocol can end up
> reporting identical names across domains, resulting in debugfs
> node creation failure. Fix this failure by ensuring that pm domains
> get a unique name using ida in pm_genpd_init.
> 
> Logs: [X1E reports 'NCC' for all its scmi perf domains]
> debugfs: Directory 'NCC' with parent 'pm_genpd' already present!
> debugfs: Directory 'NCC' with parent 'pm_genpd' already present!
> 
> Reported-by: Johan Hovold <johan+linaro@kernel.org>
> Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> v3:
> * Update device names only when a name collision occurs [Dmitry/Ulf]
> * Drop Johan's T-b from "fix debugfs node creation failure"

Also seems to do the trick:

Tested-by: Johan Hovold <johan+linaro@kernel.org>

But perhaps you could consider starting enumerating the duplicate
domains from 2 (or 1) instead of 0?:

NCC_1                           on                              0
NCC_0                           on                              0
NCC                             on                              0

Johan


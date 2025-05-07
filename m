Return-Path: <linux-pm+bounces-26832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 447ABAAE75F
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 19:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788157AD39D
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 17:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E0428B7E2;
	Wed,  7 May 2025 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HND4XoKD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A6A4B1E4B;
	Wed,  7 May 2025 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746637465; cv=none; b=j0vVj/zEpg2m5vxfCT/94TnhpOw1pOgCwQRdSgVlUCu23XpzORIVW5FsgNtlaIfJbgB7/9um9kKgpGdWEqEW/B0LwLoteBejrc3z1PnXWtFS7kVO0XEzNzmaUVpkVfaMgwfIjEx/HNTMqKJOGjqZ/zCUsKksYqfkXCsvHwvHTfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746637465; c=relaxed/simple;
	bh=00b4+LI0wzVAXzrO7XklVWCjwJt9gev7m7IRM/RaTzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2q/JT8vthXxSL+hoaiG4yd//V1HLh5qCmfIGKEaUowlJRLqFe6op1sDC6plwkHBeVeqojLqaV/+57W5tNYLphqhAjEUwahN9/Fu/mgTprfQDqRPPp4b/EBQeOuSwIxGzMEVqObybOOD70GxnDF2l8XWkRoq9NxRdOW2Nuw9V90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HND4XoKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346E5C4CEE2;
	Wed,  7 May 2025 17:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746637465;
	bh=00b4+LI0wzVAXzrO7XklVWCjwJt9gev7m7IRM/RaTzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HND4XoKDt5+V79OQx+o2QbttsLJPB0+je30HXwDN4dF+qgDLPZfx82Ld2c0yJXsff
	 8nZOBJcWfYcnwGM4gdyXL2afNjmVBtq/oQgPvYKox0FLKfbfhAHxSrsrnP5hAIpUzH
	 Ze4g/EE1kzHkjxSpSH7BIQRnFzuhGiKkZaCy3qY05J4WH88TKNbIi1DfN2Okw2jW7R
	 dK3jPun6UIYO8V4mpEUWK3bkXPMGPm/IF5iwJ0TuWeVILuSiob66+7TdL3yyRytTPh
	 A4rRjU9yaU0OWjIs+V3VpqTd+QRzQ8Jno67lMd79gNYGQtv8cNpyY7JTbuX0KTGktn
	 u2Rf1oYRdcJhw==
Date: Wed, 7 May 2025 07:04:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, len.brown@intel.com,
	pavel@kernel.org, christian.loehle@arm.com, kernel-dev@igalia.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PM: EM: Add inotify support when the energy model is
 updated.
Message-ID: <aBuSmITszR9AdoyL@slm.duckdns.org>
References: <20250507014728.6094-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507014728.6094-1-changwoo@igalia.com>

Hello,

On Wed, May 07, 2025 at 10:47:28AM +0900, Changwoo Min wrote:
> The sched_ext schedulers [1] currently access the energy model through the
> debugfs to make energy-aware scheduling decisions [2]. The userspace part
> of a sched_ext scheduler feeds the necessary (post-processed) energy-model
> information to the BPF part of the scheduler.
> 
> However, there is a limitation in the current debugfs support of the energy
> model. When the energy model is updated (em_dev_update_perf_domain), there
> is no way for the userspace part to know such changes (besides polling the
> debugfs files).
> 
> Therefore, add inotify support (IN_MODIFY) when the energy model is updated.
> With this inotify support, the directory of an updated performance domain
> (e.g., /sys/kernel/debug/energy_model/cpu0) and its parent directory (e.g.,
> /sys/kernel/debug/energy_model) are inotified. Therefore, a sched_ext
> scheduler (or any userspace application) monitors the energy model change
> in userspace using the regular inotify interface.
> 
> Note that accessing the energy model information from userspace has many
> advantages over other alternatives, especially adding new BPF kfuncs. The
> userspace has much more freedom than the BPF code (e.g., using external
> libraries and floating point arithmetics), which may be infeasible (if not
> impossible) in the BPF/kernel code.
> 
> [1] https://lwn.net/Articles/922405/
> [2] https://github.com/sched-ext/scx/pull/1624
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>

FWIW, this looks simple enough and workable to me. Just a nit below:

> +static void em_debug_update(struct device *dev)
> +{
> +	struct dentry *d;
> +
> +	d = debugfs_lookup(dev_name(dev), rootdir);
> +	fsnotify_dentry(d, FS_MODIFY);
> +}

Would something like em_debug_notify_updated() or em_debug_updated() be
better? em_debug_update() sounds like it's actively updating something.

Thanks.

-- 
tejun


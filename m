Return-Path: <linux-pm+bounces-27235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3855EABA04B
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 17:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E8CC7A2CC2
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3D61B042E;
	Fri, 16 May 2025 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4mqgu5+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0F5661;
	Fri, 16 May 2025 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410620; cv=none; b=EsJyw5LC9BGxYkxRQvDvRLULhUF1DIZPiMRTL+klrcjzSakxSPUib7khEBtigChXfprsd4jMhXS9EgG0OQ4b7X/ydZgCQZixjZFutnXpif0yvYbaXa8N8BFVT3MS7yA6fpTDebTx0W059PM8nLIVuGKEJ7zv3F+RD3hFbKvd4X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410620; c=relaxed/simple;
	bh=3TstAGtn8T9fjzO3XST4HjYjgLaUOvQyJRQG0G6ZMlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NO7u0Av03hPSwgCotN8Z01938XaBoCmlOyHuUlzIqfz593bIg/34hIJ+a9lmMI4NwUJT0JODM5Wa4qVS7GKuwRXYN/H12iu6tLK2L7/vVJEmMf9kf24MG0HOHf7eXkV3ClMYsz5GKnMc74xbSINPUSlrK5yF9R0PwIbWraX/hXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4mqgu5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF327C4CEE4;
	Fri, 16 May 2025 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747410620;
	bh=3TstAGtn8T9fjzO3XST4HjYjgLaUOvQyJRQG0G6ZMlE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J4mqgu5+B4917B2dzsLTUFd6jVkMr1BgNQbnFg/OWVelR2hTOC54XSqpSmboQVqMB
	 wtNv07dMvDZ1PzFYYrLuPODIgmOw7B4g824IKGJ7H4k9Y1/R7oA8hPmSgMk9115Gm9
	 TwOOHNwN6hVtwhoDC19F/aIPlYXsTdDPtd0e/CFBtwG74gfmKJJ77cxB8gU502xW8b
	 2F/sBcWvHAhDCqwg8rHWy0UooioWobAJCXJAQ2H82+EUwpmaxAyNdpXWVyA0KiVuzD
	 DMmmyCnS5nToepEe4OFSS7sCOz30P0F+b4dIzQSHLmi26wqw3JzUoqExywnt51wKow
	 zEETcDWpvz2vQ==
Message-ID: <fe647905-d852-4b0d-81b7-c2abab8b39ca@kernel.org>
Date: Fri, 16 May 2025 18:50:15 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] interconnect: Use rt_mutex for icc_bw_lock
To: Mike Tipton <quic_mdtipton@quicinc.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_aiquny@quicinc.com, quic_okukatla@quicinc.com
References: <20250506145159.1951159-1-quic_mdtipton@quicinc.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20250506145159.1951159-1-quic_mdtipton@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mike,

On 6.05.25 17:51, Mike Tipton wrote:
> The icc_set_bw() function is often used in latency sensitive paths to
> scale BW on a per-frame basis by high priority clients such as GPU and
> display. However, there are many low priority clients of icc_set_bw() as
> well. This can lead to priority inversion and unacceptable delays for
> the high priority clients. Which in the case of GPU and display can
> result in frame drops and visual glitches.

Ok, so the issue we see is caused by lock contention, as we have many
clients and some of them try to do very aggressive scaling.

> To prevent this priority inversion, switch to using rt_mutex for
> icc_bw_lock. This isn't needed for icc_lock since that's not used in the
> critical, latency-sensitive voting paths.

If the issue does not occur anymore with this patch, then this is a good
sign, but we still need to get some numbers and put them in the commit
message. The RT mutexes add some overhead and complexity that could
increase latency for both uncontended and contended paths. I am curious
if there is any regression for the non-priority scenarios. Also if there
are many threads, the mutex cost itself could become a bottleneck.

> 
> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
> ---
> 
> Since the original patch was posted a couple years ago, we've continued
> to hit this for display and now for GPU as well. How frequently depends
> heavily on the specific chip, product, and use case. Different
> configurations hit it easier than others. But for both cases it results
> in obvious visual glitches.
> 
> The paths being voted for (primarily DDR) are fundamentally shared
> between clients of all types and priority levels. We can't control their
> priorities, so aside from having those priorities inherited we're always
> subject to these sorts of inversions.
> 
> The motivation isn't really for general performance improvement, but
> instead to fix the rare cases of visual glitches and artifacts.
> 
> A similar patch was posted last year [1] to address similar problems.
> 
> [1] https://lore.kernel.org/all/20240220074300.10805-1-wangrumeng@xiaomi.corp-partner.google.com/
> 
> Changes in v2:
> - Rebase onto linux-next.
> - Select RT_MUTEXES in Kconfig.
> - Only use rt_mutex for icc_bw_lock since now there are separate locks
>    and icc_lock isn't in the critical path.
> - Reword commit text.
> - Link to v1: https://lore.kernel.org/all/20220906191423.30109-1-quic_mdtipton@quicinc.com/
> 
>   drivers/interconnect/Kconfig |  1 +
>   drivers/interconnect/core.c  | 23 ++++++++++++-----------
>   2 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index f2e49bd97d31..f6fd5f2d7d40 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   menuconfig INTERCONNECT
>   	bool "On-Chip Interconnect management support"
> +	select RT_MUTEXES

This pulls in unconditionally all the RT-mutex stuff, which some people
might not want (although today it's also selected by the I2C subsystem
for example). I am wondering if we should make it configurable with the
normal mutex being the default or just follow the i2c example... but
maybe we can decide this when we have some numbers.

Thanks,
Georgi

>   	help
>   	  Support for management of the on-chip interconnects.
>   
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 1a41e59c77f8..2e86a3c95d1a 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -14,6 +14,7 @@
>   #include <linux/interconnect-provider.h>
>   #include <linux/list.h>
>   #include <linux/mutex.h>
> +#include <linux/rtmutex.h>
>   #include <linux/slab.h>
>   #include <linux/of.h>
>   #include <linux/overflow.h>
> @@ -30,7 +31,7 @@ static LIST_HEAD(icc_providers);
>   static int providers_count;
>   static bool synced_state;
>   static DEFINE_MUTEX(icc_lock);
> -static DEFINE_MUTEX(icc_bw_lock);
> +static DEFINE_RT_MUTEX(icc_bw_lock);
>   static struct dentry *icc_debugfs_dir;
>   
>   static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
> @@ -178,7 +179,7 @@ static struct icc_path *path_init(struct device *dev, struct icc_node *dst,
>   
>   	path->num_nodes = num_nodes;
>   
> -	mutex_lock(&icc_bw_lock);
> +	rt_mutex_lock(&icc_bw_lock);
>   
>   	for (i = num_nodes - 1; i >= 0; i--) {
>   		node->provider->users++;
> @@ -190,7 +191,7 @@ static struct icc_path *path_init(struct device *dev, struct icc_node *dst,
>   		node = node->reverse;
>   	}
>   
> -	mutex_unlock(&icc_bw_lock);
> +	rt_mutex_unlock(&icc_bw_lock);
>   
>   	return path;
>   }
> @@ -704,7 +705,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>   	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
>   		return -EINVAL;
>   
> -	mutex_lock(&icc_bw_lock);
> +	rt_mutex_lock(&icc_bw_lock);
>   
>   	old_avg = path->reqs[0].avg_bw;
>   	old_peak = path->reqs[0].peak_bw;
> @@ -736,7 +737,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>   		apply_constraints(path);
>   	}
>   
> -	mutex_unlock(&icc_bw_lock);
> +	rt_mutex_unlock(&icc_bw_lock);
>   
>   	trace_icc_set_bw_end(path, ret);
>   
> @@ -798,7 +799,7 @@ void icc_put(struct icc_path *path)
>   		pr_err("%s: error (%d)\n", __func__, ret);
>   
>   	mutex_lock(&icc_lock);
> -	mutex_lock(&icc_bw_lock);
> +	rt_mutex_lock(&icc_bw_lock);
>   
>   	for (i = 0; i < path->num_nodes; i++) {
>   		node = path->reqs[i].node;
> @@ -807,7 +808,7 @@ void icc_put(struct icc_path *path)
>   			node->provider->users--;
>   	}
>   
> -	mutex_unlock(&icc_bw_lock);
> +	rt_mutex_unlock(&icc_bw_lock);
>   	mutex_unlock(&icc_lock);
>   
>   	kfree(path->name);
> @@ -1023,7 +1024,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
>   		return;
>   
>   	mutex_lock(&icc_lock);
> -	mutex_lock(&icc_bw_lock);
> +	rt_mutex_lock(&icc_bw_lock);
>   
>   	node->provider = provider;
>   	list_add_tail(&node->node_list, &provider->nodes);
> @@ -1056,7 +1057,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
>   	node->avg_bw = 0;
>   	node->peak_bw = 0;
>   
> -	mutex_unlock(&icc_bw_lock);
> +	rt_mutex_unlock(&icc_bw_lock);
>   	mutex_unlock(&icc_lock);
>   }
>   EXPORT_SYMBOL_GPL(icc_node_add);
> @@ -1182,7 +1183,7 @@ void icc_sync_state(struct device *dev)
>   		return;
>   
>   	mutex_lock(&icc_lock);
> -	mutex_lock(&icc_bw_lock);
> +	rt_mutex_lock(&icc_bw_lock);
>   	synced_state = true;
>   	list_for_each_entry(p, &icc_providers, provider_list) {
>   		dev_dbg(p->dev, "interconnect provider is in synced state\n");
> @@ -1195,7 +1196,7 @@ void icc_sync_state(struct device *dev)
>   			}
>   		}
>   	}
> -	mutex_unlock(&icc_bw_lock);
> +	rt_mutex_unlock(&icc_bw_lock);
>   	mutex_unlock(&icc_lock);
>   }
>   EXPORT_SYMBOL_GPL(icc_sync_state);



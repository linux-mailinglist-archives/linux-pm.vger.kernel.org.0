Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C313D3CB7
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 11:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfJKJtb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 05:49:31 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56409 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfJKJtb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Oct 2019 05:49:31 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 1b220ecebb2d0121; Fri, 11 Oct 2019 11:49:29 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andrea Righi <andrea.righi@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PM / hibernate: memory_bm_find_bit -- tighten node optimisation
Date:   Fri, 11 Oct 2019 11:49:29 +0200
Message-ID: <2167643.HFCj9E3NaD@kreacher>
In-Reply-To: <20190925143912.22593-1-apw@canonical.com>
References: <20190925143912.22593-1-apw@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, September 25, 2019 4:39:12 PM CEST Andy Whitcroft wrote:
> When looking for a bit by number we make use of the cached result from the
> preceding lookup to speed up operation.  Firstly we check if the requested
> pfn is within the cached zone and if not lookup the new zone.  We then
> check if the offset for that pfn falls within the existing cached node.
> This happens regardless of whether the node is within the zone we are
> now scanning.  With certain memory layouts it is possible for this to
> false trigger creating a temporary alias for the pfn to a different bit.
> This leads the hibernation code to free memory which it was never allocated
> with the expected fallout.
> 
> Ensure the zone we are scanning matches the cached zone before considering
> the cached node.
> 
> Deep thanks go to Andrea for many, many, many hours of hacking and testing
> that went into cornering this bug.
> 
> Reported-by: Andrea Righi <andrea.righi@canonical.com>
> Tested-by: Andrea Righi <andrea.righi@canonical.com>
> Signed-off-by: Andy Whitcroft <apw@canonical.com>
> ---
>  kernel/power/snapshot.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 83105874f255..26b9168321e7 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -734,8 +734,15 @@ static int memory_bm_find_bit(struct memory_bitmap *bm, unsigned long pfn,
>  	 * We have found the zone. Now walk the radix tree to find the leaf node
>  	 * for our PFN.
>  	 */
> +
> +	/*
> +	 * If the zone we wish to scan is the the current zone and the
> +	 * pfn falls into the current node then we do not need to walk
> +	 * the tree.
> +	 */
>  	node = bm->cur.node;
> -	if (((pfn - zone->start_pfn) & ~BM_BLOCK_MASK) == bm->cur.node_pfn)
> +	if (zone == bm->cur.zone &&
> +	    ((pfn - zone->start_pfn) & ~BM_BLOCK_MASK) == bm->cur.node_pfn)
>  		goto node_found;
>  
>  	node      = zone->rtree;
> 

Applying as 5.5 material, thanks!





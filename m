Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA5461638D
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 14:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfEGMPD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 08:15:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38688 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEGMPD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 08:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2f8uLRl8GMvPK9du+Y2zBV1bq1EpSh3gX/EwGd6390U=; b=DNftd0hd7CIq6B/3/BjfTB7f0
        E6GTEB51f7SpbiXzih2qPiGrPXNDD4fr1Fpckv4UBhjLd8vSfucwuoQ0NdGsEwQNd1Dvijq4hi55e
        KdXmm6bnNS730A4Mb2liyRn07qsvuPYZoeq7YWCJ41dDl5kanjpfAonbchJT7nOYzpEZJF++byy8T
        MC4jlpctVv3kqytX865R1dFPf9VGu4hgU/FSpv1bgRMf7eyUdeq9TQNtVDXXxritIPiGJ8PB7MJq+
        Ec7JUpj0Jlljqi29JjtD0P/C6XR8/IWk/PFatC6O62SXFb5C+lpqecQBLS3LyzQuXGXlTcYhoGrYK
        lrN/xWTaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hNyzt-0006wY-64; Tue, 07 May 2019 12:15:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C03542023ADB5; Tue,  7 May 2019 14:14:59 +0200 (CEST)
Date:   Tue, 7 May 2019 14:14:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Len Brown <lenb@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 10/22] powercap/intel_rapl: Support multi-die/package
Message-ID: <20190507121459.GL2623@hirez.programming.kicks-ass.net>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
 <9f6958c231347e639e322de8d8c3de6859559345.1557177585.git.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f6958c231347e639e322de8d8c3de6859559345.1557177585.git.len.brown@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 06, 2019 at 05:26:05PM -0400, Len Brown wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> RAPL "package" domains are actually implemented in hardware per-die.
> Thus, the new multi-die/package systems have mulitple domains
> within each physical package.
> 
> Update the intel_rapl driver to be "die aware" -- exporting multiple
> domains within a single package, when present.
> No change on single die/package systems.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/powercap/intel_rapl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index 3c3c0c23180b..9202dbcef96d 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -266,7 +266,7 @@ static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
>  /* caller to ensure CPU hotplug lock is held */
>  static struct rapl_package *rapl_find_package_domain(int cpu)
>  {
> -	int id = topology_physical_package_id(cpu);
> +	int id = topology_logical_die_id(cpu);
>  	struct rapl_package *rp;
>  
>  	list_for_each_entry(rp, &rapl_packages, plist) {
> @@ -1459,7 +1459,7 @@ static void rapl_remove_package(struct rapl_package *rp)
>  /* called from CPU hotplug notifier, hotplug lock held */
>  static struct rapl_package *rapl_add_package(int cpu)
>  {
> -	int id = topology_physical_package_id(cpu);
> +	int id = topology_logical_die_id(cpu);
>  	struct rapl_package *rp;
>  	int ret;

Both functions are still misnomers. rapl_find_package_domain() does in
fact now do rapl_find_die_domain(), right? Same for rapl_add_package()

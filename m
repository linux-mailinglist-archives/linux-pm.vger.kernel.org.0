Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74773241F97
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 20:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgHKSTs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 14:19:48 -0400
Received: from smtprelay0051.hostedemail.com ([216.40.44.51]:38036 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725862AbgHKSTs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2020 14:19:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id F096A100E7B73;
        Tue, 11 Aug 2020 18:19:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:4321:5007:10004:10400:10848:11026:11232:11473:11658:11914:12048:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: line52_260c3ae26fe4
X-Filterd-Recvd-Size: 1813
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue, 11 Aug 2020 18:19:44 +0000 (UTC)
Message-ID: <445d4b9039daca40a4d937959a0bc48ffe347f7f.camel@perches.com>
Subject: Re: [PATCH v2 2/3] perf/x86/rapl: Support multiple rapl unit quirks
From:   Joe Perches <joe@perches.com>
To:     Zhang Rui <rui.zhang@intel.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org
Cc:     linux-pm@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, len.brown@intel.com, rafael@kernel.org
Date:   Tue, 11 Aug 2020 11:19:42 -0700
In-Reply-To: <20200811153149.12242-3-rui.zhang@intel.com>
References: <20200811153149.12242-1-rui.zhang@intel.com>
         <20200811153149.12242-3-rui.zhang@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-08-11 at 23:31 +0800, Zhang Rui wrote:
> There will be more platforms with different fixed energy units.
> Enhance the code to support different rapl unit quirks for different
> platforms.

This seems like one quirk per platform.

Should multiple quirks on individual platforms be supported?

> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
[]
> @@ -130,11 +130,16 @@ struct rapl_pmus {
>  	struct rapl_pmu		*pmus[];
>  };
>  
> +enum rapl_unit_quirk {
> +	RAPL_UNIT_QUIRK_NONE,
> +	RAPL_UNIT_QUIRK_INTEL_HSW,
> +};
> +
>  struct rapl_model {
>  	struct perf_msr *rapl_msrs;
>  	unsigned long	events;
>  	unsigned int	msr_power_unit;
> -	bool		apply_quirk;
> +	enum rapl_unit_quirk	unit_quirk;
>  };



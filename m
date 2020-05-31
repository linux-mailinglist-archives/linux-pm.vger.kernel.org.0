Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F349F1E9AAB
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 00:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgEaWLa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 31 May 2020 18:11:30 -0400
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:57272 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726008AbgEaWLa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 31 May 2020 18:11:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 90F1C1802926E;
        Sun, 31 May 2020 22:11:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:966:981:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3865:3866:3867:3871:3872:4250:4321:4385:5007:7903:10004:10400:10848:11026:11232:11658:11914:12048:12295:12297:12555:12740:12760:12895:13069:13311:13357:13439:14096:14097:14180:14659:14721:21080:21324:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: chess64_5207aa126d78
X-Filterd-Recvd-Size: 1901
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun, 31 May 2020 22:11:28 +0000 (UTC)
Message-ID: <effe3cde7b1f188427c42c476f5a96251d837416.camel@perches.com>
Subject: Re: [PATCH] kernel: power: swap: mark a function as __init to save
 some memory
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        Dan Carpenter <error27@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Sun, 31 May 2020 15:11:27 -0700
In-Reply-To: <20200531210059.647066-1-christophe.jaillet@wanadoo.fr>
References: <20200531210059.647066-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

(adding Dan Carpenter)

On Sun, 2020-05-31 at 23:00 +0200, Christophe JAILLET wrote:
> 'swsusp_header_init()' is only called via 'core_initcall'.
> It can be marked as __init to save a few bytes of memory.

Hey Dan

smatch has a full function calling tree right?

Can smatch find unmarked functions called only by __init
functions so those unmarked functions can be appropriately
marked with __init like the below?

> ---
>  kernel/power/swap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index ca0fcb5ced71..01e2858b5fe3 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -1590,7 +1590,7 @@ int swsusp_unmark(void)
>  }
>  #endif
>  
> -static int swsusp_header_init(void)
> +static int __init swsusp_header_init(void)
>  {
>  	swsusp_header = (struct swsusp_header*) __get_free_page(GFP_KERNEL);
>  	if (!swsusp_header)


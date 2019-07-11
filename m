Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 270DC64F85
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 02:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfGKAV7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 20:21:59 -0400
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:51440 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727325AbfGKAV7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 20:21:59 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jul 2019 20:21:58 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 69EAE1800B461
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2019 00:14:43 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BC0308774;
        Thu, 11 Jul 2019 00:14:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2899:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3872:4321:5007:10004:10400:10848:11026:11232:11658:11914:12043:12048:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:13972:14659:14721:21080:21212:21433:21451:21627:30029:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: pail12_bbc0872fcd3a
X-Filterd-Recvd-Size: 1927
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Jul 2019 00:14:40 +0000 (UTC)
Message-ID: <cd61708e47cd63f3efaaa3e079982f63bfc88933.camel@perches.com>
Subject: Re: [PATCH] thermal: Add some error messages
From:   Joe Perches <joe@perches.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org
Date:   Wed, 10 Jul 2019 17:14:38 -0700
In-Reply-To: <0d3d6111f8a8bd199f1a5a5cd8c4e83e4f0690be.1562757659.git.amit.kucheria@linaro.org>
References: <cover.1562757659.git.amit.kucheria@linaro.org>
         <0d3d6111f8a8bd199f1a5a5cd8c4e83e4f0690be.1562757659.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-07-10 at 17:16 +0530, Amit Kucheria wrote:
> When registering a thermal zone device, we currently return -EINVAL in
> four cases. This makes it a little hard to debug the real cause of the
> failure.
> 
> Print some error messages to make it easier for developer to figure out
> what happened.
[]
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
[]
> @@ -1238,17 +1238,26 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>  	int count;
>  	struct thermal_governor *governor;
>  
> -	if (!type || strlen(type) == 0)
> +	if (!type || strlen(type) == 0) {
> +		pr_err("Error: No thermal zone type defined");

Please use terminating newlines like:

		pr_err("Error: No thermal zone type defined\n");

[]
> +		pr_err("Error: Thermal zone name (%s) too long, should be under %d chars",

etc...



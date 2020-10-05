Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C19282F61
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 06:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgJEETT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 00:19:19 -0400
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:47212 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725844AbgJEETS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 00:19:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9D24518224D61;
        Mon,  5 Oct 2020 04:19:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2198:2199:2200:2393:2559:2562:2828:2895:2914:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3871:3874:4321:4605:5007:7901:7903:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: fold51_2101521271bb
X-Filterd-Recvd-Size: 2681
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon,  5 Oct 2020 04:19:16 +0000 (UTC)
Message-ID: <f8fd76b81dab7dcb0e262a62e4d92bdf63ef2cfe.camel@perches.com>
Subject: Re: [PATCH] test_power: add missing newlines when printing
 parameters by sysfs
From:   Joe Perches <joe@perches.com>
To:     "Harley A.W. Lorenzo" <hl1998@protonmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>
Date:   Sun, 04 Oct 2020 21:19:15 -0700
In-Reply-To: <1g3ecQ7VLlrgKOSHr6teWgw9xcmVVQx1bFp2KpJD7y35lZpaC8ONb-jrPKapmFttEwVg2uhDwmv6mug9z5-GVZbqPbkOjcqjrSHtaW-k6ts=@protonmail.com>
References: <1599199798-27804-1-git-send-email-wangxiongfeng2@huawei.com>
         <20201003212336.5et7erdf6fihqscu@earth.universe>
         <472008b94f4b20915425db4714fdb505cb0cbe5a.camel@perches.com>
         <20201003215029.jsugcgpgrmcmydr3@earth.universe>
         <9822843f764520e1076a92fd9120294aa393a085.camel@perches.com>
         <20201004221645.nyaf7jhur4jixo6n@earth.universe>
         <1g3ecQ7VLlrgKOSHr6teWgw9xcmVVQx1bFp2KpJD7y35lZpaC8ONb-jrPKapmFttEwVg2uhDwmv6mug9z5-GVZbqPbkOjcqjrSHtaW-k6ts=@protonmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-10-05 at 01:30 +0000, Harley A.W. Lorenzo wrote:
> Here is the updated patch using sprintf, diffing from the original patch by Xiongfeng Wang.
> 
> [PATCH] test_power: revise parameter printing to use sprintf
> 
> Signed-off-by: Harley A.W. Lorenzo <hl1998@protonmail.com>
> Suggested-by: Joe Perches <joe@perches.com>

I did not suggest this.

> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
[]
> @@ -352,8 +352,8 @@ static int param_set_ac_online(const char *key, const struct kernel_param *kp)
> 
>  static int param_get_ac_online(char *buffer, const struct kernel_param *kp)
>  {.
> -	strcpy(buffer, map_get_key(map_ac_online, ac_online, "unknown"));
> -	strcat(buffer, "\n");
> +	char const *out = map_get_key(map_ac_online, ac_online, "unknown");
> +	sprintf(buffer, "%s\n", out);
>  	return strlen(buffer);
>  }

No temporary is necessary nor is strlen as
that's the same as the return from sprintf.

All of these should be similar to:

static int param_get_ac_online(char *buffer, const struct kernel_param *kp)
{
	return sprintf(buffer, "%s\n",
		       map_get_key(map_ac_online, ac_online, "unknown"));
}



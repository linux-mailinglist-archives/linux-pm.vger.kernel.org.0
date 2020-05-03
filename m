Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8655B1C2F05
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 22:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgECUGa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 16:06:30 -0400
Received: from smtprelay0218.hostedemail.com ([216.40.44.218]:49860 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729052AbgECUGa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2020 16:06:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 4D39380196CE;
        Sun,  3 May 2020 20:06:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2901:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:4250:4321:5007:8957:10004:10400:10848:11232:11658:11914:12048:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:21740:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: twig67_386849556fe11
X-Filterd-Recvd-Size: 1750
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun,  3 May 2020 20:06:27 +0000 (UTC)
Message-ID: <67bb48d7e7927b6b50bafa69a21eef41fc2157b5.camel@perches.com>
Subject: Re: [PATCH] thermal: stm32: fix spelling mistake "acces" -> "access"
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, edubezval@gmail.com, info@metux.net,
        tglx@linutronix.de, gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Sun, 03 May 2020 13:06:25 -0700
In-Reply-To: <20200503191104.153711-1-christophe.jaillet@wanadoo.fr>
References: <20200503191104.153711-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 2020-05-03 at 21:11 +0200, Christophe JAILLET wrote:
> Fix a typo in Kconfig.
[]
> diff --git a/drivers/thermal/st/Kconfig b/drivers/thermal/st/Kconfig
[]
> @@ -23,5 +23,5 @@ config STM32_THERMAL
>  	help
>  	  Support for thermal framework on STMicroelectronics STM32 series of
>  	  SoCs. This thermal driver allows to access to general thermal framework
> -	  functionalities and to acces to SoC sensor functionalities. This
> +	  functionalities and to access to SoC sensor functionalities. This
>  	  configuration is fully dependent of MACH_STM32MP157.

Could fix the grammar too:

This thermal driver allows to access general thermal framework
functionalities and access to SoC sensor functionalities.


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C02B1113B71
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 06:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfLEFrq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 00:47:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfLEFrq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 00:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x96gOpqCUg5wPLxbwWs7dfewlG/0CiMSE5+nMnsPO9A=; b=GjkJAE3VENnG6oHJGRTemG4Ui
        01wxy6qCxqveivonwruo9aqvEKwfkYr8KN6BgwuIWWWDtbMbqO1i9vw0nxY/9+Pjz8Itu/MOIDXa8
        sm8UAqHa9D60pnCE64OnLmAAykqKdiGfYzYE69/w1RFopeoLyAr6m7Iv0AbT1I52JwWJ9TxI2FFeg
        3Adm50uENj7cesdKxQD2t2wWvvwINuBUuRbjdnnDDgtw8BC9jAkSaGG3zmThyh9FbLFRFfK7nIxUS
        YoqhAjygauF6C2q8sPOrEG7rsJx8Jz44Rfr/F+O8t9kFpiRHV5Y/7BIs+ZJFVhleAdf+PgTa36xJc
        Zdzp6sLHQ==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icjzL-0004qz-Cd; Thu, 05 Dec 2019 05:47:43 +0000
Subject: Re: linux-next: Tree for Nov 15 (thermal:
 THERMAL_GOV_POWER_ALLOCATOR)
To:     Zhang Rui <rui.zhang@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>, qperret@google.com
References: <20191115190525.77efdf6c@canb.auug.org.au>
 <247cd41e-a07b-adf0-4ec2-6467f0257837@infradead.org>
 <9436e207-8a65-f01b-c348-32a8a00f03d4@infradead.org>
 <6d43c93a748872293df489d397f894b77b221bc9.camel@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8895dbb7-dd48-1076-cef2-64d53a59c081@infradead.org>
Date:   Wed, 4 Dec 2019 21:47:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <6d43c93a748872293df489d397f894b77b221bc9.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/4/19 8:27 PM, Zhang Rui wrote:
> On Wed, 2019-12-04 at 08:25 -0800, Randy Dunlap wrote:
>> On 11/15/19 3:44 PM, Randy Dunlap wrote:
>>> On 11/15/19 12:05 AM, Stephen Rothwell wrote:
>>>> Hi all,
>>>>
>>>> Changes since 20191114:
>>>>
>>>
>>> on i386:
>>>
>>> WARNING: unmet direct dependencies detected for
>>> THERMAL_GOV_POWER_ALLOCATOR
>>>   Depends on [n]: THERMAL [=y] && ENERGY_MODEL [=n]
>>>   Selected by [y]:
>>>   - THERMAL_DEFAULT_GOV_POWER_ALLOCATOR [=y] && <choice>
>>>
>>>
>>> THERMAL_GOV_POWER_ALLOCATOR is selected by
>>> THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
>>> even though ENERGY_MODEL is not set/enabled.
>>>
>>>
>>
>> This Kconfig warning is still happening in linux-next of 20191204.
>>
> I overlooked the original report probably because I was not CCed.
> 
> This is introduced by commit a4e893e802e6("thermal: cpu_cooling:
> Migrate to using the EM framework") which adds the dependency of
> ENERGY_MODEL for THERMAL_GOV_POWER_ALLOCATOR.
> 
> To fix this, it's better to make THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
> depends on THERMAL_GOV_POWER_ALLOCATOR instead.
> 
> Please confirm the problem is fixed by below patch.
> 
> thanks,
> rui
> 
> From c9429f6e28ea2219686a4294d39f015ba373774b Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Thu, 5 Dec 2019 12:17:07 +0800
> Subject: [PATCH] thermal: fix a Kconfig warning
> 
> Currently, THERMAL_GOV_POWER_ALLOCATOR is selected by
> THERMAL_DEFAULT_GOV_POWER_ALLOCATOR even if it has some unmet
> dependencies.
> 
> This causes the Kconfig warning
>    WARNING: unmet direct dependencies detected for
>       THERMAL_GOV_POWER_ALLOCATOR
>       Depends on [n]: THERMAL [=y] && ENERGY_MODEL [=n]
>       Selected by [y]:
>       - THERMAL_DEFAULT_GOV_POWER_ALLOCATOR [=y] && <choice>
> 
> Fix the problem by making THERMAL_DEFAULT_GOV_POWER_ALLOCATOR depends on
> THERMAL_GOV_POWER_ALLOCATOR instead.
> 
> Fixes: a4e893e802e6("thermal: cpu_cooling: Migrate to using the EM framework")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/thermal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 59b79fc48266..79b27865c6f4 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -108,7 +108,7 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
>  
>  config THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
>  	bool "power_allocator"
> -	select THERMAL_GOV_POWER_ALLOCATOR
> +	depends on THERMAL_GOV_POWER_ALLOCATOR
>  	help
>  	  Select this if you want to control temperature based on
>  	  system and device power allocation. This governor can only
> 


-- 
~Randy


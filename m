Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DBB34FB5C
	for <lists+linux-pm@lfdr.de>; Wed, 31 Mar 2021 10:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbhCaISt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 04:18:49 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:63834 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbhCaISr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Mar 2021 04:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617178727; x=1648714727;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=2nV0mXiyWztHWYThPphmbciYbzLzkc35sM0Dekg54Lk=;
  b=qhlFR/3QUdobCaVbmN6+qy+2MNHnDq61f0no19cxtqk1A29Spx8ugIiR
   yP6ikWNfiKpIRgSa4McjtNCx26D4jE+5dpkCvRpakkh8pZDRg2nXKCcTr
   EdVjxa/NqZjGbsEmo9EoKdMH9edYnSBqKkBRRzL8d3dY5WtRj/Zsny5uZ
   Unm112ziGw9i/lKisZ2a7IqB5l+Tab9RkHLH7fkC0M0EvLOj98DFpZJwh
   bzcIRKppQZ7H4jLjWY616WNnl5dQXLuyBW6B25r3hABfu413S8nr9aL1a
   8ef3zAR8PqIo0ZJxHMGoV2Waah8ktDsx86VJXdyQl3ajQJetjLY1ad2cO
   g==;
IronPort-SDR: 4EpDx81z0VAggYIKFLHNgy52EPo4trXaZJI5T2YSpChuh1AGjlgnmdZSFxxwQIqsv2i6k+LGN9
 1G2yAhPZsH7m862FcuZgbqm9Pu/vC1QF5dUQYUoduiPDO/HC/EFvQiZN7OxSvKIKPn7zpeTO1w
 4aNdmKvGPpwJm+ExeEHkXk7RbQ49jyBgGfoiLMOFvGMvBeXekGSuioAKo214wbS1rYfQcYc+u1
 u+fnq5JAwwhdaIjWI2WIPtbHkF/fZidbQPrSg0FqLiCZiE3VAdB0VtfOb7n8UVcV1V40RZEPH3
 d+A=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="114810110"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 01:18:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 01:18:44 -0700
Received: from [10.171.246.91] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Wed, 31 Mar 2021 01:18:42 -0700
Subject: Re: [PATCH] power: reset: at91-reset: free resources on exit path
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, <sre@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
References: <20210209110109.906034-1-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <b18fc346-498d-4c6f-7f06-a6148a17d216@microchip.com>
Date:   Wed, 31 Mar 2021 10:18:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210209110109.906034-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/02/2021 at 12:01, Claudiu Beznea wrote:
> Free resources on exit path (failure path of probe and remove).

I'm not sure we can use this driver as a module anyway.

Otherwise, it looks fine, but isn't it possible to use devm_of_iomap(), 
even in loop, and avoid having to deal with exit path?

> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>   drivers/power/reset/at91-reset.c | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
> index 3ff9d93a5226..2ff7833153b6 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -206,7 +206,8 @@ static int __init at91_reset_probe(struct platform_device *pdev)
>   			if (!reset->ramc_base[idx]) {
>   				dev_err(&pdev->dev, "Could not map ram controller address\n");
>   				of_node_put(np);
> -				return -ENODEV;
> +				ret = -ENODEV;
> +				goto unmap;
>   			}
>   			idx++;
>   		}
> @@ -218,13 +219,15 @@ static int __init at91_reset_probe(struct platform_device *pdev)
>   	reset->args = (u32)match->data;
>   
>   	reset->sclk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(reset->sclk))
> -		return PTR_ERR(reset->sclk);
> +	if (IS_ERR(reset->sclk)) {
> +		ret = PTR_ERR(reset->sclk);
> +		goto unmap;
> +	}
>   
>   	ret = clk_prepare_enable(reset->sclk);
>   	if (ret) {
>   		dev_err(&pdev->dev, "Could not enable slow clock\n");
> -		return ret;
> +		goto unmap;
>   	}
>   
>   	platform_set_drvdata(pdev, reset);
> @@ -239,21 +242,33 @@ static int __init at91_reset_probe(struct platform_device *pdev)
>   	ret = register_restart_handler(&reset->nb);
>   	if (ret) {
>   		clk_disable_unprepare(reset->sclk);
> -		return ret;
> +		goto unmap;
>   	}
>   
>   	at91_reset_status(pdev, reset->rstc_base);
>   
>   	return 0;
> +
> +unmap:
> +	iounmap(reset->rstc_base);
> +	for (idx = 0; idx < ARRAY_SIZE(reset->ramc_base); idx++)
> +		iounmap(reset->ramc_base[idx]);

But if we keep this loop, I have the feeling that some kind of 
"of_node_put()" is needed as well.

> +
> +	return ret;
>   }
>   
>   static int __exit at91_reset_remove(struct platform_device *pdev)
>   {
>   	struct at91_reset *reset = platform_get_drvdata(pdev);
> +	int idx;
>   
>   	unregister_restart_handler(&reset->nb);
>   	clk_disable_unprepare(reset->sclk);
>   
> +	iounmap(reset->rstc_base);
> +	for (idx = 0; idx < ARRAY_SIZE(reset->ramc_base); idx++)
> +		iounmap(reset->ramc_base[idx]);

Ditto

> +
>   	return 0;
>   }
>   
> 


-- 
Nicolas Ferre

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9D7E6172
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2019 08:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfJ0HeP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Oct 2019 03:34:15 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:54012 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfJ0HeP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Oct 2019 03:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1572161655; x=1603697655;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Ri+RSELqnUN93/J6a80rSFEySKHexPxEGcRasXgLP9I=;
  b=lVxzMif0KClooMJ9GJOtwQEF20vMdnTJjocqzzd5ObxnY3gMVOktdMob
   lKMT17mDhTXc5jvp/ZHE5xbq+acxcS9+CWjOhx985YtHLmsPYbwBYzLZ1
   EWQD1+HqzwklDNbAouwOK8y4rbezlNPZh7XySEKXfQWGrDe7r4jSz/CmR
   w=;
IronPort-SDR: HVVBNljbkukYMXBrYIik98vs58RnFOzUP6QltO4oPusYhrEFQkpWqFPNEur62k/P9CwQTO6+VU
 Rn589btUKScA==
X-IronPort-AV: E=Sophos;i="5.68,235,1569283200"; 
   d="scan'208";a="917511"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 27 Oct 2019 07:34:10 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id 18200A1D2D;
        Sun, 27 Oct 2019 07:34:06 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 27 Oct 2019 07:34:06 +0000
Received: from [10.125.238.52] (10.43.161.223) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 27 Oct
 2019 07:34:02 +0000
Subject: Re: [PATCH] thermal: no need to set .owner when using
 module_platform_driver
To:     Tian Tao <tiantao6@huawei.com>, <rui.zhang@intel.com>,
        <edubezval@gmail.com>, <daniel.lezcano@linaro.org>,
        <amit.kucheria@verdurent.com>, <linux-pm@vger.kernel.org>
CC:     <linuxarm@huawei.com>, "Krupnik, Ronen" <ronenk@amazon.com>
References: <1572051875-35861-1-git-send-email-tiantao6@huawei.com>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <3f82f629-8fb6-19bc-cd57-dd54ba613b1d@amazon.com>
Date:   Sun, 27 Oct 2019 09:33:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1572051875-35861-1-git-send-email-tiantao6@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.161.223]
X-ClientProxiedBy: EX13P01UWB003.ant.amazon.com (10.43.161.209) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 10/26/2019 4:04 AM, Tian Tao wrote:
> the module_platform_driver will call platform_driver_register.
> and It will set the .owner to THIS_MODULE
>
> Signed-off-by: Tian Tao <tiantao6@huawei.com>
> ---
>   drivers/thermal/thermal_mmio.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
> index 40524fa..d0bdf1e 100644
> --- a/drivers/thermal/thermal_mmio.c
> +++ b/drivers/thermal/thermal_mmio.c
> @@ -110,7 +110,6 @@ static struct platform_driver thermal_mmio_driver = {
>   	.probe = thermal_mmio_probe,
>   	.driver = {
>   		.name = "thermal-mmio",
> -		.owner = THIS_MODULE,
>   		.of_match_table = of_match_ptr(thermal_mmio_id_table),
>   	},
>   };
Acked-by: Talel Shenhar <talel@amazon.com>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D5B358029
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 12:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhDHKBu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 06:01:50 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:18544 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhDHKBt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 06:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1617876099; x=1649412099;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=e+1SNlLqo0lJXVL44NKQjDbbLmNS7oOdS2wDnjT8PKM=;
  b=eKMGzsCmCXGq94JXjky2zOq0GDBRYCEPhOPJfkawexbJKRrs1f38z/lQ
   k+/NYoZw9QcXwHjGqe4qBC06zRZrvS55J8fR3mDbCbws3J82YPGhC84qZ
   7GjxUzYlp2PCni7cFm7bx1BSeVwu69XzHNgel9reAYPK85LpM44En9OrG
   c=;
X-IronPort-AV: E=Sophos;i="5.82,206,1613433600"; 
   d="scan'208";a="126067621"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 08 Apr 2021 10:01:31 +0000
Received: from EX13D01EUB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id 9F9A5A21AF;
        Thu,  8 Apr 2021 10:01:29 +0000 (UTC)
Received: from [192.168.30.119] (10.43.161.41) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Apr
 2021 10:01:24 +0000
Subject: Re: [PATCH -next] thermal: thermal_mmio: remove redundant dev_err
 call in thermal_mmio_probe()
To:     Ruiqi Gong <gongruiqi1@huawei.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Wang Weiyang <wangweiyang2@huawei.com>, <linux-pm@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ronen Krupnik <ronenk@amazon.com>, <talelshenhar@gmail.com>,
        <talel@amazon.com>
References: <20210408100144.7494-1-gongruiqi1@huawei.com>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <60b8e4d4-6baf-4106-b9e1-685652fb2163@amazon.com>
Date:   Thu, 8 Apr 2021 13:01:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210408100144.7494-1-gongruiqi1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.161.41]
X-ClientProxiedBy: EX13D02UWC004.ant.amazon.com (10.43.162.236) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 4/8/2021 1:01 PM, Ruiqi Gong wrote:
>
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ruiqi Gong <gongruiqi1@huawei.com>
> ---
>   drivers/thermal/thermal_mmio.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
> index d0bdf1ea3331..ded1dd0d4ef7 100644
> --- a/drivers/thermal/thermal_mmio.c
> +++ b/drivers/thermal/thermal_mmio.c
> @@ -54,11 +54,8 @@ static int thermal_mmio_probe(struct platform_device *pdev)
>
>          resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>          sensor->mmio_base = devm_ioremap_resource(&pdev->dev, resource);
> -       if (IS_ERR(sensor->mmio_base)) {
> -               dev_err(&pdev->dev, "failed to ioremap memory (%ld)\n",
> -                       PTR_ERR(sensor->mmio_base));
> +       if (IS_ERR(sensor->mmio_base))
>                  return PTR_ERR(sensor->mmio_base);
> -       }
>
>          sensor_init_func = device_get_match_data(&pdev->dev);
>          if (sensor_init_func) {
Acked-by: Talel Shenhar <talel@amazon.com>

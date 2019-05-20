Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE93A239F5
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 16:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390076AbfETO1X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 10:27:23 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:3688 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390085AbfETO1V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2019 10:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1558362440; x=1589898440;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=AIVJUn9G+zO7VZ4y+Rlra1uIGxBGYi9sLc/Jl5PrZXM=;
  b=Ff90AQu1ymSGI/dD5GL4QrAEnCW1K+kjAsO/UR/xlR2mMwyjidnjeB1y
   riz6bUT+5FtrZ3wKDy6gysPHajGti/CXTDwKwG+6TkQmjL1I7JuOkB5XV
   YycYJAmONsNSzAWy1f2WFjnnn7mXYKEAsZrPCXChZ+/BQFwP5dws1ifI2
   o=;
X-IronPort-AV: E=Sophos;i="5.60,491,1549929600"; 
   d="scan'208";a="766764212"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 May 2019 14:27:18 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x4KERGsQ127588
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 20 May 2019 14:27:17 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 20 May 2019 14:27:16 +0000
Received: from [10.125.238.52] (10.43.162.116) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 20 May
 2019 14:27:12 +0000
Subject: Re: [PATCH] thermal: mmio: remove some dead code
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20190515093420.GC3409@mwanda>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <87257cd4-a7c8-3531-1033-84a6f79e6588@amazon.com>
Date:   Mon, 20 May 2019 17:26:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515093420.GC3409@mwanda>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.162.116]
X-ClientProxiedBy: EX13D01UWB001.ant.amazon.com (10.43.161.75) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 5/15/2019 12:34 PM, Dan Carpenter wrote:
> The platform_get_resource() function doesn't return error pointers, it
> returns NULL.  The way this is normally done, is that we pass the NULL
> resource to devm_ioremap_resource() and then check for errors from that.
> See the comment in front of devm_ioremap_resource() for more details.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Talel Shenhar <talel@amazon.com>
> ---
>   drivers/thermal/thermal_mmio.c | 7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
> index de3cceea23bc..40524fa13533 100644
> --- a/drivers/thermal/thermal_mmio.c
> +++ b/drivers/thermal/thermal_mmio.c
> @@ -53,13 +53,6 @@ static int thermal_mmio_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (IS_ERR(resource)) {
> -		dev_err(&pdev->dev,
> -			"fail to get platform memory resource (%ld)\n",
> -			PTR_ERR(resource));
> -		return PTR_ERR(resource);
> -	}
> -
>   	sensor->mmio_base = devm_ioremap_resource(&pdev->dev, resource);
>   	if (IS_ERR(sensor->mmio_base)) {
>   		dev_err(&pdev->dev, "failed to ioremap memory (%ld)\n",

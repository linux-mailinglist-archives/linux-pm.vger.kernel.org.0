Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6679A843A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 15:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfIDNQS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 09:16:18 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:43951 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDNQS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Sep 2019 09:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567602978; x=1599138978;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dVPgUqN88hiyFCDUl2n0H4GWl7kQ/LvDY+M8i0q+25Y=;
  b=VZ3WoOwZpRNbBzyask86p+s4bzhM8s3rmsabMlkwyJH3M21cXVQCp8uw
   wTHlnw8VLhZerNNEdVY59ltyzNsefsAk0t6RL2XdWQBV4jcjYOxAWB1x5
   rLSrxKCRKFhsCPtzFe4rAzF2EfZr+EJ8mF79yr+8z7QKIPk+FoNiHNa48
   Y=;
X-IronPort-AV: E=Sophos;i="5.64,467,1559520000"; 
   d="scan'208";a="700658012"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 04 Sep 2019 13:16:13 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with ESMTPS id 3E81BA215A;
        Wed,  4 Sep 2019 13:16:11 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Sep 2019 13:16:10 +0000
Received: from [10.88.66.45] (10.43.160.149) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 4 Sep
 2019 13:15:54 +0000
Subject: Re: [PATCH -next 13/15] thermal: thermal_mmio: use
 devm_platform_ioremap_resource() to simplify code
To:     YueHaibing <yuehaibing@huawei.com>, <miquel.raynal@bootlin.com>,
        <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <amit.kucheria@verdurent.com>,
        <eric@anholt.net>, <wahrenst@gmx.net>, <f.fainelli@gmail.com>,
        <rjui@broadcom.com>, <sbranden@broadcom.com>,
        <mmayer@broadcom.com>, <computersforpeace@gmail.com>,
        <gregory.0xf0@gmail.com>, <matthias.bgg@gmail.com>,
        <agross@kernel.org>, <heiko@sntech.de>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <marc.w.gonzalez@free.fr>, <mans@mansr.com>, <jun.nie@linaro.org>,
        <shawnguo@kernel.org>, <phil@raspberrypi.org>,
        <gregkh@linuxfoundation.org>, <david.hernandezsanchez@st.com>,
        <horms+renesas@verge.net.au>, <wsa+renesas@sang-engineering.com>,
        <linux-pm@vger.kernel.org>
CC:     <bcm-kernel-feedback-list@broadcom.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <talel@amazon.com>,
        <ronenk@amazon.com>
References: <20190904122939.23780-1-yuehaibing@huawei.com>
 <20190904122939.23780-14-yuehaibing@huawei.com>
From:   Talel Shenhar <talel@amazon.com>
Message-ID: <228fdf20-9f3a-4809-6fed-448e2bb349d3@amazon.com>
Date:   Wed, 4 Sep 2019 16:15:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904122939.23780-14-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.160.149]
X-ClientProxiedBy: EX13D08UWC003.ant.amazon.com (10.43.162.21) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks.

Talel.

On 9/4/19 2:29 PM, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-By: Talel Shenhar <talel@amazon.com>
> ---
>   drivers/thermal/thermal_mmio.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

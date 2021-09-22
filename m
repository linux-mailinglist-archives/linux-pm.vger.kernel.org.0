Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4266414730
	for <lists+linux-pm@lfdr.de>; Wed, 22 Sep 2021 13:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbhIVLDO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Sep 2021 07:03:14 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:61678 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbhIVLDN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Sep 2021 07:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1632308504; x=1663844504;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZHWrmmWN4TZxD38ZjRTWdMilYnPPW7deeIc6pKKkvs4=;
  b=OpjZWWUbdii/4G3rTZMEYYdMhOhwhdpMRBl8umCOqzZ9/hiSkr+PHUzb
   hN7fVsecfnjcDp6bghDFAGreASmXLmrtYLda93OAFkvjY08CXoCVDntrO
   X6naoGvCwUK/H0NTAkYWjxP1HaynYhSeehplo5rQwSxIFpUUZRxr5UkUI
   o=;
X-IronPort-AV: E=Sophos;i="5.85,313,1624320000"; 
   d="scan'208";a="143707804"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-1c3c2014.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 22 Sep 2021 11:01:36 +0000
Received: from EX13D01EUB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-1c3c2014.us-east-1.amazon.com (Postfix) with ESMTPS id 851B1CE3C1;
        Wed, 22 Sep 2021 11:01:35 +0000 (UTC)
Received: from [192.168.18.219] (10.43.162.186) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Wed, 22 Sep 2021 11:01:31 +0000
Message-ID: <04e09b28-3b0d-ed64-8bec-f07bc0ddf88e@amazon.com>
Date:   Wed, 22 Sep 2021 14:01:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: thermal: thermal_mmio: Constify static struct thermal_mmio_ops
Content-Language: en-US
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Zhang Rui <rui.zhang@intel.com>, Amit Kucheria <amitk@kernel.org>,
        Ronen Krupnik <ronenk@amazon.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20210920203849.32136-1-rikard.falkeborn@gmail.com>
From:   "Shenhar, Talel" <talel@amazon.com>
In-Reply-To: <20210920203849.32136-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.186]
X-ClientProxiedBy: EX13D14UWB003.ant.amazon.com (10.43.161.162) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The only usage of thermal_mmio_ops is to pass its address to
> devm_thermal_zone_of_sensor_register(), which has a pointer to const
> struct thermal_zone_of_device_ops as argument. Make it const to allow
> the compiler to put it in read-only memory.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Acked-by: Talel Shenhar <talel@amazon.com>
> ---
>   drivers/thermal/thermal_mmio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
> index ded1dd0d4ef7..360b0dfdc3b0 100644
> --- a/drivers/thermal/thermal_mmio.c
> +++ b/drivers/thermal/thermal_mmio.c
> @@ -34,7 +34,7 @@ static int thermal_mmio_get_temperature(void *private, int *temp)
>          return 0;
>   }
>
> -static struct thermal_zone_of_device_ops thermal_mmio_ops = {
> +static const struct thermal_zone_of_device_ops thermal_mmio_ops = {
>          .get_temp = thermal_mmio_get_temperature,
>   };
>
> --
> 2.33.0
>

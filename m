Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A9F2A3CFB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 07:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgKCGuz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 01:50:55 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49822 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgKCGuy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 01:50:54 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A36ohJT096870;
        Tue, 3 Nov 2020 00:50:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604386243;
        bh=6qKYBoE7dhstLWAsyXGwM4uWF/vz2ef/Ws3welqldwY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uew4Q2tiMVtpirF86L9mN9XDVXl4lXH+3FjnMP1qwwOzc9Aps975IoXVwe29CFYFp
         xENsulvC94Wqpy4zvdxoLyy/E4CbmK6k2EUVcChKJjsZBc5+imjPsp+cSTV8ar5XTl
         Sgh4bPnNb6BVo7+r7+cgR2V2BHlxERdkg180aeEM=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A36ohqS095201
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Nov 2020 00:50:43 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 3 Nov
 2020 00:50:42 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 3 Nov 2020 00:50:42 -0600
Received: from [10.250.232.146] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A36oXAV113532;
        Tue, 3 Nov 2020 00:50:36 -0600
Subject: Re: [PATCH] thermal: ti-soc-thermal: Disable the CPU PM notifier for
 OMAP4430
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>
CC:     <edubezval@gmail.com>, <aford173@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <andreas@kemnade.info>,
        <daniel.lezcano@linaro.org>
References: <20201029100335.27665-1-peter.ujfalusi@ti.com>
 <20201029105125.GJ5639@atomide.com>
 <b05f4bae-c285-828b-d5f1-fbf8613b4ca4@ti.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <2d6ecaaa-e760-759d-a23b-9556dd390758@ti.com>
Date:   Tue, 3 Nov 2020 12:20:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <b05f4bae-c285-828b-d5f1-fbf8613b4ca4@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/3/2020 12:12 PM, Peter Ujfalusi wrote:
> Eduardo, Keerthy,
> 
> On 29/10/2020 12.51, Tony Lindgren wrote:
>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [201029 10:03]:
>>> Disabling the notifier fixes the random shutdowns on OMAP4430 (ES2.0 and ES2.1)
>>> but it does not cause any issues on OMAP4460 (PandaES) or OMAP3630 (BeagleXM).
>>> Tony's duovero with OMAP4430 ES2.3 did not ninja-shutdown, but he also have
>>> constant and steady stream of:
>>> thermal thermal_zone0: failed to read out thermal zone (-5)
>>
>> Works for me and I've verified duovero still keeps hitting core ret idle:
> 
> Can you pick this one up for 5.10 to make omap4430-sdp to be usable (to
> not shut down randomly).
> The regression was introduced in 5.10-rc1.

Peter,

Thanks for the fix.

Acked-by: Keerthy <j-keerthy@ti.com>

Best Regards,
Keerthy

> 
>> Tested-by: Tony Lindgren <tony@atomide.com>
>>
>> Regards,
>>
>> Tony
>>
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

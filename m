Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BB72A3CEE
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 07:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgKCGlr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 01:41:47 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48140 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgKCGlq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 01:41:46 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A36fW2o093856;
        Tue, 3 Nov 2020 00:41:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604385692;
        bh=fQcLh9XqTYbZj8GFCkL4Rr0ADLhc2H9p6l0p9YmSulk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JGa/SWbieESsAXPh+IEQVTK9FXPCk3Mr7jS1bibOCBxsJaKhEwsmQrTwoKHDrAZDx
         8xl2JlIvtGp9sfyMJmou1hqUd7IOWKXysnhDSe4RYdS/Nr5RdW7WNmHqkqwjIIDwqC
         I+CHE+rTUhuLKt5pwqs+CFWegYTqEdzH5dBrGQ9I=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A36fWnJ082418
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Nov 2020 00:41:32 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 3 Nov
 2020 00:41:31 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 3 Nov 2020 00:41:31 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A36fTuq097267;
        Tue, 3 Nov 2020 00:41:29 -0600
Subject: Re: [PATCH] thermal: ti-soc-thermal: Disable the CPU PM notifier for
 OMAP4430
To:     Tony Lindgren <tony@atomide.com>
CC:     <edubezval@gmail.com>, <j-keerthy@ti.com>, <aford173@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <andreas@kemnade.info>,
        <daniel.lezcano@linaro.org>
References: <20201029100335.27665-1-peter.ujfalusi@ti.com>
 <20201029105125.GJ5639@atomide.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <b05f4bae-c285-828b-d5f1-fbf8613b4ca4@ti.com>
Date:   Tue, 3 Nov 2020 08:42:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201029105125.GJ5639@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Eduardo, Keerthy,

On 29/10/2020 12.51, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [201029 10:03]:
>> Disabling the notifier fixes the random shutdowns on OMAP4430 (ES2.0 and ES2.1)
>> but it does not cause any issues on OMAP4460 (PandaES) or OMAP3630 (BeagleXM).
>> Tony's duovero with OMAP4430 ES2.3 did not ninja-shutdown, but he also have
>> constant and steady stream of:
>> thermal thermal_zone0: failed to read out thermal zone (-5)
> 
> Works for me and I've verified duovero still keeps hitting core ret idle:

Can you pick this one up for 5.10 to make omap4430-sdp to be usable (to
not shut down randomly).
The regression was introduced in 5.10-rc1.

> Tested-by: Tony Lindgren <tony@atomide.com>
> 
> Regards,
> 
> Tony
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

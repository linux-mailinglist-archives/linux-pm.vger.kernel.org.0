Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAEF7827F7
	for <lists+linux-pm@lfdr.de>; Mon, 21 Aug 2023 13:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjHULbB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Aug 2023 07:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjHULbA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2023 07:31:00 -0400
X-Greylist: delayed 2615 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Aug 2023 04:30:52 PDT
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6A7118;
        Mon, 21 Aug 2023 04:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ous1oN9CqolOB1bkwGJLUiDZKO4d3gQIesYeEOsNOUI=; b=h2G2rNzQe1nSmA9SHdIazGnxMG
        3NB73LdIpo+IQ/AN7YRPmTX1er8EXGSMxssQTmFN1vQQkZIuWJa3uWBIwliB5EtcUPbhNOvQvhL2t
        vV1LE4HPVhE3rMLm6D/W45KzdSjJEemCtHeSeeDW27bu8zinP2fd6zODPMsE2valCQ+L21r2Vvt8e
        NmfG9fBHVItJzRJ1O4M/CCcPaWxK9BMM97QLlY2H4ZMsA0PzA348EnIUMRNDfQDHm36O9NWiBE3TL
        9Vr/I9LwT2c8mabNXvZ24V91BdsjcWJNFHKbGT7T/z9AW5c4FcxhAlzHh0s9ITG7g7RKjc1FRObxZ
        iRjI4f6A==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <cyndis@kapsi.fi>)
        id 1qY1pq-007HdP-2Y;
        Mon, 21 Aug 2023 13:08:34 +0300
Message-ID: <7c342b0c-9657-ffd1-6fad-ef6433ddc793@kapsi.fi>
Date:   Mon, 21 Aug 2023 13:08:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] thermal: tegra-bpmp: Check if BPMP supports trip points
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20221129153914.2699041-1-cyndis@kapsi.fi>
 <Y9KTrO+WqJJwuEDf@orome> <a08355e1-c393-2b2e-4a44-360e08607bb9@linaro.org>
 <Y9KfcSwYt7utbcg5@orome> <e716eda4-edfc-5946-4e6f-42aab5f73b0f@linaro.org>
 <d7435a96-3480-280e-d996-73fea690c373@nvidia.com>
 <2c37a786-0ae5-273e-f82b-4f9c82663053@linaro.org>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <2c37a786-0ae5-273e-f82b-4f9c82663053@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/3/23 13:26, Daniel Lezcano wrote:
> On 03/04/2023 12:22, Jon Hunter wrote:
>> Hi Daniel,
>>
>> On 26/01/2023 16:07, Daniel Lezcano wrote:
>>> On 26/01/2023 16:42, Thierry Reding wrote:
>>>> On Thu, Jan 26, 2023 at 04:08:03PM +0100, Daniel Lezcano wrote:
>>>>>
>>>>> Hi Thierry,
>>>>>
>>>>> On 26/01/2023 15:52, Thierry Reding wrote:
>>>>>> On Tue, Nov 29, 2022 at 05:39:14PM +0200, Mikko Perttunen wrote:
>>>>>>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>>>>>>
>>>>>>> Check if BPMP supports thermal trip points, and if not,
>>>>>>> do not expose the .set_trips callback to the thermal core
>>>>>>> framework. This can happen in virtualized environments
>>>>>>> where asynchronous communication with VM BPMP drivers is not
>>>>>>> available.
>>>>>>>
>>>>>>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>>>>>>> ---
>>>>>>>    drivers/thermal/tegra/tegra-bpmp-thermal.c | 52 
>>>>>>> +++++++++++++++++++++-
>>>>>>>    1 file changed, 51 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> Applied, thanks.
>>>>>
>>>>> I prefer you provide an Acked-by and I take the thermal related 
>>>>> patches.
>>>>> Especially in this period where we are reworking the framework with 
>>>>> the
>>>>> thermal trip points ;)
>>>>
>>>> Sorry, my bad. I misread this as belonging to drivers/firmware/tegra
>>>> which goes in via ARM SoC.
>>>
>>> No worries ;)
>>>
>>>> I'll drop this from the Tegra tree. Feel free
>>>> to pick this up:
>>>
>>> Ok, thanks
>>>
>>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>
>>
>> I don't see this one in -next. Are you able to pick this one up now?
> 
> Before going in -next, it will go through bleeding-edge then -next, 
> logically tomorrow.
> 
> 

Hi, still not seeing this in -next.

Cheers,
Mikko

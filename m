Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AAD2172FA
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 17:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgGGPvD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 11:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgGGPvC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 11:51:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B001C061755;
        Tue,  7 Jul 2020 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=sKnrwpscRwRPBpUhlbtspTfx0oBw6mAir2Zy9BEVNbY=; b=axtmKjqfm+LW4fWv7U2f6Lrn13
        2zgE82uA8OYJSX7OjWObeNsFa8krOfsiU170JEztNCnVohby5uiusNK/s6KIRKYTyCHCF4Fsk77xT
        Wmo7YLmw5npBFWBMDvLAqFOP5b/M4M6bkQ8MEqe7UR2k1lSl5QLlwD2shEPa2P0R9+g55L4K3FOfz
        J6nXUv/oybK8ijjdQOvvQI2PCEN4MMhuqxX64UQEv/kxHjKGnmANA7ZI+IjW6zy/mIka4/LPci3S3
        o3EI1GRux/KJIMgfJq5gIXPHvyAd84hCxF9+rMjp/Opplr5hZFuLybZIgBsw1nMDTq6Vynfjd/nFR
        aG+n3B3g==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsps4-0006Dy-Jz; Tue, 07 Jul 2020 15:51:01 +0000
Subject: Re: [PATCH] thermal: netlink: Fix compilation error when CONFIG_NET=n
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200707090159.1018-1-daniel.lezcano@linaro.org>
 <66b4c589-48e0-8975-b3b1-79168e3ea5e4@infradead.org>
 <04a6904d-9220-9045-6816-12cf84781f4d@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6568ae82-32a3-7a9a-9bf0-15dd7805a1fd@infradead.org>
Date:   Tue, 7 Jul 2020 08:50:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <04a6904d-9220-9045-6816-12cf84781f4d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/7/20 8:49 AM, Daniel Lezcano wrote:
> On 07/07/2020 17:47, Randy Dunlap wrote:
>> On 7/7/20 2:01 AM, Daniel Lezcano wrote:
>>> When the network is not configured, the netlink are disabled on all
>>> the system. The thermal framework assumed the netlink are always
>>> opt-in.
>>>
>>> Fix this by adding a Kconfig option for the netlink notification,
>>> defaulting to yes and depending on CONFIG_NET.
>>>
>>> As the change implies multiple stubs and in order to not pollute the
>>> internal thermal header, the thermal_nelink.h has been added and
>>> included in the thermal_core.h, so this one regain some kind of
>>> clarity.
>>>
>>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>>  drivers/thermal/Kconfig           | 10 ++++
>>>  drivers/thermal/Makefile          |  5 +-
>>>  drivers/thermal/thermal_core.h    | 20 +------
>>>  drivers/thermal/thermal_netlink.h | 98 +++++++++++++++++++++++++++++++
>>>  4 files changed, 114 insertions(+), 19 deletions(-)
>>>  create mode 100644 drivers/thermal/thermal_netlink.h
>>>
>>
>>
>> Hm, now I get this:
>>
>> ../drivers/thermal/thermal_helpers.c: In function ‘thermal_cdev_set_cur_state’:
>> ../drivers/thermal/thermal_helpers.c:182:2: error: implicit declaration of function ‘thermal_notify_cdev_update’; did you mean ‘thermal_notify_cdev_delete’? [-Werror=implicit-function-declaration]
>>   thermal_notify_cdev_update(cdev->id, target);
>>
>>
>> or should that call be to thermal_notify_cdev_state_update()?
> 
> Ah right, the patch applies on top of the v4 which is not yet in
> linux-next, I'm waiting for the kernelci loop result.

OK, that explains why I had a little trouble applying the patch.

thanks.
-- 
~Randy


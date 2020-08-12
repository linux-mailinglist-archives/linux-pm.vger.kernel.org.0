Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898A4242C25
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 17:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgHLPYf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Aug 2020 11:24:35 -0400
Received: from vern.gendns.com ([98.142.107.122]:40690 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgHLPYe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Aug 2020 11:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TdjKGfpfVnwMoKkPgW934kp6AzuXiBbfQm38pNhYlXk=; b=ha1ylY07oxbxCr7PlZtnKKOs0R
        9aT2k2kwEG1f4V+Vqg0mGliA8lLCar9r7HTe/AZJiLLzTX+5e0aMPgxIihlBA468nVH0GXeE1CICZ
        FTf9/TZegZNQ1ePVdjg8VGAGYPr1h+RQkd5Pj2axle8e4MLS+Ybj/wUdqZQuYdLpDGzkuNhCkC+Tj
        suFhc8t1QjwDQnguuSzC3cb7J1DRECQdU91tVU8jhiwhDlZA3440vgfkM2r4Neqv+mYBnhhKpYn3X
        02F0F1XBxLhdMMHPfN7iOg+gqpdCpmPEEIa8JmicXN+FQQuwRsjllqFiiBfOGYlimCF/22OWWBUJj
        db/PPPNw==;
Received: from [2600:1700:4830:165f::19e] (port=55728)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1k5scC-0000o0-C0; Wed, 12 Aug 2020 11:24:32 -0400
Subject: Re: [PATCH] power: supply: Add dependency to lego-ev3-battery Kconfig
 options
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Go??aszewski <bgolaszewski@baylibre.com>
References: <20200809185444.54247-1-alex.dewar90@gmail.com>
 <d6c98ee6-f2f3-c55a-be16-3794ccf30a28@lechnology.com>
 <20200812133711.ddwhxypmvr27pxdu@lenovo-laptop>
From:   David Lechner <david@lechnology.com>
Message-ID: <ce0ae241-10e1-de5c-e694-2c00dc01a2c4@lechnology.com>
Date:   Wed, 12 Aug 2020 10:24:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812133711.ddwhxypmvr27pxdu@lenovo-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/12/20 8:37 AM, Alex Dewar wrote:
> On Tue, Aug 11, 2020 at 09:24:10AM -0500, David Lechner wrote:
>> On 8/9/20 1:54 PM, Alex Dewar wrote:
>>> This battery appears only to be used by a single board (DA850), so it
>>> makes sense to add this to the Kconfig file so that users don't build
>>> the module unnecessarily. It currently seems to be built for the x86
>>> Arch Linux kernel where it's probably not doing much good.
>>
>> It would probably also make sense to add "default n" since it only
>> applies to one board in the entire arch.
> 
> Ah ok. That makes sense. Would you like me to send a follow-on patch for
> this?

You can just send a v2 patch that includes the change below and the
additional change.

> 
> Alex
> 
>>
>> BATTERY_LEGO_EV3 is already explicitly set to "m" in the appropriate
>> defconfig file, so I don't think it would break anything.
>>
>>>
>>> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
>>> ---
>>>    drivers/power/supply/Kconfig | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>>> index faf2830aa1527..9f76e2f47ac6d 100644
>>> --- a/drivers/power/supply/Kconfig
>>> +++ b/drivers/power/supply/Kconfig
>>> @@ -164,7 +164,7 @@ config BATTERY_DS2782
>>>    config BATTERY_LEGO_EV3
>>>    	tristate "LEGO MINDSTORMS EV3 battery"
>>> -	depends on OF && IIO && GPIOLIB
>>> +	depends on OF && IIO && GPIOLIB && (ARCH_DAVINCI_DA850 || COMPILE_TEST)
>>>    	help
>>>    	  Say Y here to enable support for the LEGO MINDSTORMS EV3 battery.
>>>
>>


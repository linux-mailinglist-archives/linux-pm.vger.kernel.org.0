Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2BDB75DF4
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 06:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfGZEvq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 00:51:46 -0400
Received: from anchovy3.45ru.net.au ([203.30.46.155]:47002 "EHLO
        anchovy3.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfGZEvq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 00:51:46 -0400
Received: (qmail 2589 invoked by uid 5089); 26 Jul 2019 04:51:44 -0000
Received: by simscan 1.2.0 ppid: 2555, pid: 2556, t: 0.3125s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on anchovy3.45ru.net.au
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=6.0 tests=ALL_TRUSTED,AWL
        autolearn=disabled version=3.4.1
Received: from unknown (HELO ?192.168.0.34?) (rtresidd@electromag.com.au@203.59.235.95)
  by anchovy2.45ru.net.au with ESMTPA; 26 Jul 2019 04:51:43 -0000
Subject: Re: [PATCH 1/1] power/supply/powersupply_sysfs: Add of_node name to
 uevent message if available
From:   Richard Tresidder <rtresidd@electromag.com.au>
To:     David Lechner <david@lechnology.com>, linux-pm@vger.kernel.org
References: <1564040858-24202-1-git-send-email-rtresidd@electromag.com.au>
 <9a10b934-e7f3-c95f-6250-8a857bdfa912@lechnology.com>
 <3c372ca4-373d-9c03-8636-a9f065eed577@electromag.com.au>
Message-ID: <f6082ff8-b9fc-a52d-ad48-fc1b348246f4@electromag.com.au>
Date:   Fri, 26 Jul 2019 12:51:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3c372ca4-373d-9c03-8636-a9f065eed577@electromag.com.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi David
   That call requires a struct device *
But the of_node pointer is located in the struct power_supply
Seems the of_node value in the base device* is null, and often is.
I find it hard at times to figure out which one of these to reference as 
things seem to be duplicated in a lot of places..

Should that call potentially be refactored to take a device_node * 
instead of a device *

**
Regards
    Richard Tresidder

On 26/07/2019 10:40 am, Richard Tresidder wrote:
> Hi David
>   That it would be. I wasn't aware of that call.
> I'll give it a crack and send in a new version of the patch.
>
> Cheers
>   Richard Tresidder
>
> Richard Tresidder
> On 25/07/2019 10:08 pm, David Lechner wrote:
>> On 7/25/19 2:47 AM, Richard Tresidder wrote:
>>> If the of_node name of the supply is available from the devicetree 
>>> binding
>>> then include it under the var POWER_SUPPLY_OF_NODE_NAME.
>>> This helps where a consistent name is known via the device tree binding
>>> but it is hard to identify based on the usual enumeration process.
>>>
>>
>> Would it be possible to use of_device_uevent() instead of introducing 
>> a new
>> property?
>>
>>
>>
>
>
>


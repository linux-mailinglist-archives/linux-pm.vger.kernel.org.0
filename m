Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E94B24715F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Aug 2020 20:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390923AbgHQSZy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 14:25:54 -0400
Received: from vern.gendns.com ([98.142.107.122]:44834 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390893AbgHQSZu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Aug 2020 14:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ze/Fp2bEpwKS0D9hQT11IEgTLHA/U4BtBRsUXbpJDzw=; b=hUOEEO0pBh6USLjb3wUcU7dmJ5
        NTOn7l7umnSmy9ivG4IgvlD3g2YSwGVz4aItNZTyKLAIPOygQvs06lPjhAFblIRvmXfHmtrIE6szG
        Zkq409nojD8P1KSuIJX/LJeLfO8/X82EM91pvuzsyU5lugzgkPwZkecPrrvnzawI2U6DbvYI5TZvi
        0AWzSkE3GYALchMBbPwjk0WxuXkBuioJ+xe/VhnWNpnYZOct76FhUTwUcDEaESyrnqnGEysRiveKD
        XdFvkVl/dZFeXUulybWzbbIFi4AmRGts8gbjAFk7QdiaJo5pGREiSvx0kk/Fxcs3Y9G0MD5akqBJf
        3FVSWpLA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:39396 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1k7jpK-0006y6-Eb; Mon, 17 Aug 2020 14:25:46 -0400
Subject: Re: [PATCH] power: supply: Add dependency to lego-ev3-battery Kconfig
 options
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Go??aszewski <bgolaszewski@baylibre.com>
References: <20200809185444.54247-1-alex.dewar90@gmail.com>
 <d6c98ee6-f2f3-c55a-be16-3794ccf30a28@lechnology.com>
 <20200812133711.ddwhxypmvr27pxdu@lenovo-laptop>
 <ce0ae241-10e1-de5c-e694-2c00dc01a2c4@lechnology.com>
 <20200812190253.zewvdfvyu6cnggcl@lenovo-laptop>
 <0927eaf0-62d6-adaf-c4b0-89d7f4cc7b4a@lechnology.com>
 <20200817174344.lxuzlly4it5vpfmz@lenovo-laptop>
From:   David Lechner <david@lechnology.com>
Message-ID: <dc296c76-b997-c711-7f60-a7a993601443@lechnology.com>
Date:   Mon, 17 Aug 2020 13:25:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817174344.lxuzlly4it5vpfmz@lenovo-laptop>
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

On 8/17/20 12:43 PM, Alex Dewar wrote:
> On Wed, Aug 12, 2020 at 02:12:57PM -0500, David Lechner wrote:
>> On 8/12/20 2:02 PM, Alex Dewar wrote:
>>> On Wed, Aug 12, 2020 at 10:24:30AM -0500, David Lechner wrote:
>>>> On 8/12/20 8:37 AM, Alex Dewar wrote:
>>>>> On Tue, Aug 11, 2020 at 09:24:10AM -0500, David Lechner wrote:
>>>>>> On 8/9/20 1:54 PM, Alex Dewar wrote:
>>>>>>> This battery appears only to be used by a single board (DA850), so it
>>>>>>> makes sense to add this to the Kconfig file so that users don't build
>>>>>>> the module unnecessarily. It currently seems to be built for the x86
>>>>>>> Arch Linux kernel where it's probably not doing much good.
>>>>>>
>>>>>> It would probably also make sense to add "default n" since it only
>>>>>> applies to one board in the entire arch.
>>>>>
>>>>> Ah ok. That makes sense. Would you like me to send a follow-on patch for
>>>>> this?
>>>>
>>>> You can just send a v2 patch that includes the change below and the
>>>> additional change.
>>>
>>> I've just had a look at the documentation[1] and it seems that as there's
>>> no "default y" there it'll default to n anyway. Have I got that right?
>>>
>>> [1] https://www.kernel.org/doc/html/latest/kbuild/kconfig-language.html#menu-attributes
>>>
>>
>> Yes, that seems right. That makes me wonder why this would have been enabled in
>> the Arch Linux kernel for x86 then.
> 
> Not sure, maybe the Arch devs like Lego? ;-)
> 
> Are you happy to give an Acked-by for this anyhoo?

Yup.

Acked-by: David Lechner <david@lechnology.com>

> 
> @Sebastian, are you happy to pick up this patch?
> 
> Best,
> Alex
> 


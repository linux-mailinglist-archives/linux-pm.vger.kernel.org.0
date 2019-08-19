Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C05D91B7C
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 05:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfHSDdK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Aug 2019 23:33:10 -0400
Received: from anchovy2.45ru.net.au ([203.30.46.146]:36982 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfHSDdK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Aug 2019 23:33:10 -0400
Received: (qmail 12459 invoked by uid 5089); 19 Aug 2019 03:33:07 -0000
Received: by simscan 1.2.0 ppid: 12386, pid: 12387, t: 0.3151s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on anchovy2
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=6.0 tests=ALL_TRUSTED,AWL
        autolearn=disabled version=3.4.1
Received: from unknown (HELO ?192.168.0.34?) (rtresidd@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 19 Aug 2019 03:33:06 -0000
Subject: Re: [PATCH 1/1] dt-bindings: power/supply/sbs_sbs-battery: Addition
 of force_load binding Add device tree binding documentation for addition of
 force_load boolean value to allow loading a battery during boot even if not
 present at that time.
To:     Rob Herring <robh@kernel.org>
Cc:     sre@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1564037445-22936-1-git-send-email-rtresidd@electromag.com.au>
 <20190816211430.GA8175@bogus>
From:   Richard Tresidder <rtresidd@electromag.com.au>
Message-ID: <1baa2fe9-7649-f70a-9076-5b49464ae1cd@electromag.com.au>
Date:   Mon, 19 Aug 2019 11:33:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816211430.GA8175@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a force load option when loading the driver as a module.
This adds the equivalent methodology for the binding path.
Though I suppose you could in fact just force load if the gpio detect 
isn't present.
Thats a good idea, just wasn't the existing driver flow. I can't think 
of any reason why we couldn't do that though.

I'll update the patch and resubmit V3
Will add a note about it in the docs

Please note I'd submitted this incorrectly when using our patch script 
last time, it's now correctly part of the combined patch

Regards
   Richard Tresidder
Richard Tresidder


**
On 17/08/2019 5:14 am, Rob Herring wrote:
> On Thu, Jul 25, 2019 at 02:50:45PM +0800, Richard Tresidder wrote:
>> Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
>> ---
>>
>> Notes:
>>      Add device tree binding documentation for addition of force_load
>>      boolean value to allow loading a battery during boot even if not
>>      present at that time.
>>      Accompanying patch to drivers/power/supply/sbs-battery.c submitted to linux-pm@vger.kernel.org
>>
>>   Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
>> index 4e78e51..187d7bb 100644
>> --- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
>> +++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
>> @@ -15,7 +15,8 @@ Optional properties :
>>      after an external change notification.
>>    - sbs,battery-detect-gpios : The gpio which signals battery detection and
>>      a flag specifying its polarity.
>> -
>> + - sbs,force-load : Allow loading of a hot-pluggable battery when there is no
>> +   GPIO detect available and the module is statically built.
> What's a module? That's Linux specific and nothing to do with the
> binding.
>
> Can't you just force load if sbs,battery-detect-gpios is not present?
>
> Rob
>
>


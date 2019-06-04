Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA98C34BCA
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 17:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfFDPQ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 11:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbfFDPQ0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Jun 2019 11:16:26 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F24B420843;
        Tue,  4 Jun 2019 15:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559661386;
        bh=pAQ9u+JYEr8bEaUMMm0FhnKAn06YVOdptDWZn/r/23Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eDTYX8hnxRGrI26LUGGi/CZbcE4D/3BLVgnyuc7XItSVxgmG67/4ym8jSg6uxnjxF
         mQf8m/ZQ3lUk+6207cPZRcPzShswLK5ZAiVpMAChOE5SxKIUovugiLt5U7ozs/sgI/
         7Y0kG3ubOR4kvn6TnkqUVFitW2KunUFINoYdilaQ=
Subject: Re: [PATCH] cpupower : frequency-set -r option misses the last cpu in
 related cpu list
To:     Thomas Renninger <trenn@suse.de>, ego@linux.vnet.ibm.com
Cc:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <20190529093033.30068-1-huntbag@linux.vnet.ibm.com>
 <CAHZ_5Ww2fMBGUR4gzNRZs-uV16j-hAevxT-vbNULRPsmKA7dow@mail.gmail.com>
 <1825219.HmmgU4QcfA@house>
From:   shuah <shuah@kernel.org>
Message-ID: <fe31ff62-da28-3f32-5f9e-171e624213bf@kernel.org>
Date:   Tue, 4 Jun 2019 09:16:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1825219.HmmgU4QcfA@house>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/29/19 8:21 AM, Thomas Renninger wrote:
> Hi,
> 
> On Wednesday, May 29, 2019 2:12:34 PM CEST Gautham R Shenoy wrote:
>> Hi Abhishek,
>>
>> On Wed, May 29, 2019 at 3:02 PM Abhishek Goel
> 
> ...
>   
>>>                                  bitmask_setbit(cpus_chosen, cpus->cpu);
>>>                                  cpus = cpus->next;
>>>                          
>>>                          }
>>>
>>> +                       /* Set the last cpu in related cpus list */
>>> +                       bitmask_setbit(cpus_chosen, cpus->cpu);
>>
>> Perhaps you could convert the while() loop to a do ..  while(). That
>> should will ensure
>> that we terminate the loop after setting the last valid CPU.
> 
> It would do exactly the same, right?
> IMHO it's not worth the extra hassle of resubmitting. Setting the last value
> outside a while loop is rather common.
> 
> I do not have a CPU with related cores at hand.
> If you tested this it would be nice to see this pushed:
> 
> Reviewed-by: Thomas Renninger <trenn@suse.de>
> 

Applied to 
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/ 
cpupower branch.

thanks,
-- Shuah


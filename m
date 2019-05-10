Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F02819D6D
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 14:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfEJMtm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 08:49:42 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:9765 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfEJMtm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2019 08:49:42 -0400
X-IronPort-AV: E=Sophos;i="5.60,453,1549922400"; 
   d="scan'208";a="218814811"
Subject: Re: [PATCH v3 2/2] dt-bindings: power: reset: add document for NVMEM
 based reboot-mode
To:     Rob Herring <robh@kernel.org>
Cc:     "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <fc60b885f1b447ce55950184c7921cfc1c96ade6>
 <20190421190913.1478-3-nandor.han@vaisala.com> <20190430224731.GA31760@bogus>
From:   Nandor Han <nandor.han@vaisala.com>
Message-ID: <0134c853-f5eb-8d6f-6523-61688607b367@vaisala.com>
Date:   Fri, 10 May 2019 15:49:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190430224731.GA31760@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 May 2019 12:49:36.0745 (UTC) FILETIME=[D3041D90:01D5072E]
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/1/19 1:47 AM, Rob Herring wrote:

Hi Rob,
   Thanks for review.

>> @@ -0,0 +1,32 @@
>> +NVMEM reboot mode driver
>> +
>> +This driver gets reboot mode magic value from reboot-mode driver
>> +and stores it in a NVMEM cell named "reboot-mode". Then the bootloader
>> +can read it and take different action according to the magic
>> +value stored.
> 
> This is also assuming the nvmem is writeable which is more often not the
> case.
> 
> Is your usecase a platform that supports pstore? Adding on to that
> binding might be a better fit.
> 

I'm using an RTC persistent memory for storing this data. The available
memory is low and don't think pstore will fit in this case.

>> +The rest of the properties should follow the generic reboot-mode description
>> +found in reboot-mode.txt
>> +
>> +Example:
>> +	reboot-mode-nvmem@0 {
> 
> What's this node for?
> 
>> +		compatible = "simple-mfd";
> 
> I only see 1 function.
> 

No need to this. Will remove

Nandor

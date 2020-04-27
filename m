Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D7A1BA6AE
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 16:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgD0Olm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 10:41:42 -0400
Received: from cmta18.telus.net ([209.171.16.91]:49902 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbgD0Oll (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Apr 2020 10:41:41 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id T4wzj73HAVEJfT4x0jPTVe; Mon, 27 Apr 2020 08:41:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1587998500; bh=FiJz5xRPR2jwwYNYrp1GATPMRcZKYvCN7htIP5MWM8Y=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=N4PZzdKb7/hn/N/LWoKzh2mRypfoIaaFWpFfuFP/EC8wZsc46mzB0N7kj8Ojx5V1W
         h8FekCpWpM/DLtHJKY3F68yeli8xMMJGu3gjn1TwvnXXzG4e5vRqbD1oVFCKvFiJxi
         WmkAZhZPoKbu6yARVXvVDSbp7CK+J15uDXWq0L9TcJ3DsqvGEN9kaK7QzSDSN3M9P9
         XFTbFVtb9h82wH2L5NIeaSAxgFFWsVQIR/9SGMCVrO3WyYUcYhYynMU15VXDLfg+Mk
         OqlXuPL3tzos/yH1zJ0/njsWBH3TCIlKWEKxrXlHAyTkArog9wULYMfUaL+AhzfQf0
         V7wN+uH6EVo/w==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=KIck82No c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=i0EeH86SAAAA:8
 a=Z4Wf9oU1dosRAX0lpn8A:9 a=QEXdDO2ut3YA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Hanjun Guo'" <guohanjun@huawei.com>
Cc:     <linux-pm@vger.kernel.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
References: <1587982637-33618-1-git-send-email-guohanjun@huawei.com> <06ff344e-7abf-9eb6-9664-0e9f9d8d6bc7@linaro.org>
In-Reply-To: <06ff344e-7abf-9eb6-9664-0e9f9d8d6bc7@linaro.org>
Subject: RE: [RFC PATCH] cpuidle: Make cpuidle governor switchable to be the default behaviour
Date:   Mon, 27 Apr 2020 07:41:36 -0700
Message-ID: <000401d61ca1$f684f7b0$e38ee710$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdYcmPLp6bju3k5oQcqR39LDQnZ46AABgHQg
X-CMAE-Envelope: MS4wfJDCRIWLulyl9yvNRsWRWpP1LUZI7VkQXl1XOnOSE/N5PhF88+dwPsBsz87xEYnZ9ofovcC8miTrcIAvkBvqgl/JsUNc85jnUXQxLEtloiGGL/n66VVq
 hcTe9CsFnUC23KNfTR9xBCY9baxnRcJcpxjeqpxFRZkdcmoojA/RwU68STwaXRQ5ayI+x1MzZiVSGM3DRMsqKDXrVN1H9p59JozHOhwPx9AWRi/VFdkTaUdQ
 3kIxxnYfkkkpuErzgfCRgdf6JPWzKRQzjm0czZLt3g0=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I very much support this RFC.
I have been running only with "cpuidle_sysfs_switch" for about 2 years.

Some changes would be required for the documentation files also.

On 2020.04.27 06:37 Daniel Lezcano wrote:
> On 27/04/2020 12:17, Hanjun Guo wrote:
>> For now cpuidle governor can be switched via sysfs only when the
>> boot option "cpuidle_sysfs_switch" is passed, but it's important
>> to switch the governor to adapt to different workloads, especially
>> after TEO and haltpoll governor were introduced.
>> 
>> Introduce a CONFIG option to make cpuidle governor switchable to be
>> the default behaviour, which will not break the boot option behaviour.
>> 
>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>> ---
>>  drivers/cpuidle/Kconfig | 9 +++++++++
>>  drivers/cpuidle/sysfs.c | 2 +-
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
>> index c0aeedd..c40cb40 100644
>> --- a/drivers/cpuidle/Kconfig
>> +++ b/drivers/cpuidle/Kconfig
>> @@ -47,6 +47,15 @@ config CPU_IDLE_GOV_HALTPOLL
>>  config DT_IDLE_STATES
>>  	bool
>>  
>> +config CPU_IDLE_SWITCH_GOV_IN_DEFAULT
>> +	bool "Switch the CPU idle governor via sysfs at runtime in default behaviour"
>> +	help
>> +	  Make the CPU idle governor switchable at runtime, and make it as the
>> +	  default behaviour even the boot option "cpuidle_sysfs_switch" is not
>> +	  passed in cmdline.
>> +
>> +	  Say N if you unsure about this.
>
> Well I wouldn't make this optional but just remove the sysfs_switch.

Agree.

> However, there is the '_ro' suffix when the option is not set. In order
> to not break the existing tools, may be let both files co-exist and add
> in the ABI/obselete the '_ro' file as candidate for removal ?

I do not like this _ro thing, and got hit by it with turbostat one time.
Agree it should be made a candidate for removal.



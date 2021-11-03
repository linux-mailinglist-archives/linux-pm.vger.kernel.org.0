Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E898443F63
	for <lists+linux-pm@lfdr.de>; Wed,  3 Nov 2021 10:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhKCJac convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 3 Nov 2021 05:30:32 -0400
Received: from aposti.net ([89.234.176.197]:50244 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231912AbhKCJab (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Nov 2021 05:30:31 -0400
Date:   Wed, 03 Nov 2021 09:27:44 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/9] Remove unused headers <linux/jz4740-adc.h> and
 <linux/power/jz4740-battery.h>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Message-Id: <8YOZ1R.5Y4XRHLJDAGS@crapouillou.net>
In-Reply-To: <YYI9t2Ng1Uppkiav@google.com>
References: <20211102220203.940290-1-corbet@lwn.net>
        <20211102220203.940290-2-corbet@lwn.net> <YYI9t2Ng1Uppkiav@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lee,

Le mer., nov. 3 2021 at 07:43:51 +0000, Lee Jones 
<lee.jones@linaro.org> a écrit :
> On Tue, 02 Nov 2021, Jonathan Corbet wrote:
> 
>>  Commit ff71266aa490 ("mfd: Drop obsolete JZ4740 driver") removed 
>> the last
>>  file to include <linux/jz4740-adc.h> but left the header file itself
>>  behind.  Nothing uses it, remove it now.
>> 
>>  Similarly, aea12071d6fc ("power/supply: Drop obsolete JZ4740 
>> driver")
>>  deleted the last use of <linux/power/jz4740-battery.h>, so remove 
>> that one
>>  too.
>> 
>>  Cc: Paul Cercueil <paul@crapouillou.net>
>>  Cc: Lee Jones <lee.jones@linaro.org>
>>  Cc: Paul Burton <paul.burton@mips.com>
>>  Cc: Sebastian Reichel <sre@kernel.org>
>>  Cc: linux-pm@vger.kernel.org
>>  Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>>  ---
>>   include/linux/jz4740-adc.h           | 33 
>> ----------------------------
>>   include/linux/power/jz4740-battery.h | 15 -------------
> 
> It appears as though there are still references to both of these
> *devices* in the kernel tree.  Should those be removed also?

These files were for older drivers that were since then replaced by 
newer drivers; JZ47xx SoCs are still officially supported and 
maintained.

Cheers,
-Paul

>>   2 files changed, 48 deletions(-)
>>   delete mode 100644 include/linux/jz4740-adc.h
>>   delete mode 100644 include/linux/power/jz4740-battery.h
> 
> Patch looks fine though.
> 
> Let me know if you want me to take it in via MFD.  Otherwise:
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> --
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog



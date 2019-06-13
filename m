Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE7144D20
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 22:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfFMUNQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 16:13:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfFMUNQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2019 16:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bKMWCvMopA9EQ8AelBJcmdTvyJTL93JTREGP6k5ibdU=; b=G/wqaOYFUB3TMjUpS3ONKm6h2
        NN3wE402X9P0slndGVuuqdBym+wP9BG81c6LZYuPXZOaFeLMzRGpaMd2xUUqtOmCCV8FaBOLVbtDP
        dBxeG0ztr6bYJdWoek1hsvgU9EwPKuEIFZk9ASjgChEgXovvBXHOW9pp5PwWge3ocoO0mzGSurPsz
        6uGLk5FSz/TieWTB9yB8nNJC5okV7oYWfpoRhKGky95UO9peXc6tzxtVGkfdcWHFc1j9lntOgW8oU
        bMV3PwYjHc5kl+M1wyiKrGhpQRZak9OlavimRnGHtYyXYRSh8XCvDQoJFa4yit2sca5SOtVmeWrWg
        hsK/KHoww==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbW5z-0002lr-Bx; Thu, 13 Jun 2019 20:13:15 +0000
Subject: Re: linux-next: Tree for Jun 13 (drivers/soc/qcom/Kconfig)
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bjorn.andersson@linaro.org
References: <20190613193054.37bde7fa@canb.auug.org.au>
 <00d6da06-1316-6560-5541-0caf8ea5084b@infradead.org>
 <2480052.F5ZUPELBQ8@kreacher>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9dd920db-f1c9-d5b7-dc01-aa0e0e70df0e@infradead.org>
Date:   Thu, 13 Jun 2019 13:13:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2480052.F5ZUPELBQ8@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/13/19 11:27 AM, Rafael J. Wysocki wrote:
> On Thursday, June 13, 2019 6:12:43 PM CEST Randy Dunlap wrote:
>>  This is a multi-part message in MIME format.
>> --------------D4992319A3EA7FFA5EF515C6
>> Content-Type: text/plain; charset=windows-1252
>> Content-Transfer-Encoding: 8bit
>>
>> On 6/13/19 2:30 AM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20190612:
>>>
>>
>>
>> on x86_64:
>>
>> ../drivers/base/power/domain.c: In function �genpd_queue_power_off_work�:
>> ../drivers/base/power/domain.c:485:13: error: �pm_wq� undeclared (first use in this function)
>>   queue_work(pm_wq, &genpd->power_off_work);
>>              ^
>> ../drivers/base/power/domain.c:485:13: note: each undeclared identifier is reported only once for each function it appears in
>> ../drivers/base/power/domain.c: In function �genpd_dev_pm_qos_notifier�:
>> ../drivers/base/power/domain.c:675:25: error: �struct dev_pm_info� has no member named �ignore_children�
>>    if (!dev || dev->power.ignore_children)
>>                          ^
>> ../drivers/base/power/domain.c: In function �rtpm_status_str�:
>> ../drivers/base/power/domain.c:2754:16: error: �struct dev_pm_info� has no member named �runtime_error�
>>   if (dev->power.runtime_error)
>>                 ^
>> ../drivers/base/power/domain.c:2756:21: error: �struct dev_pm_info� has no member named �disable_depth�
>>   else if (dev->power.disable_depth)
>>                      ^
>> ../drivers/base/power/domain.c:2758:21: error: �struct dev_pm_info� has no member named �runtime_status�
>>   else if (dev->power.runtime_status < ARRAY_SIZE(status_lookup))
>>                      ^
>> ../drivers/base/power/domain.c:2759:31: error: �struct dev_pm_info� has no member named �runtime_status�
>>    p = status_lookup[dev->power.runtime_status];
>>                                ^
>>
>>
>> Full randconfig file is attached.
> 
> PM_GENERIC_DOMAINS, which is set, depend on PM, which is not set.

Thanks for that.  (I changed the subject to indicate the errant entity.)

> Looks like an impossible configuration to me.

It's what happens when a driver selects PM_GENERIC_DOMAINS when PM is not set/enabled.

From drivers/soc/qcom/Kconfig:

config QCOM_AOSS_QMP
	tristate "Qualcomm AOSS Driver"
	depends on ARCH_QCOM || COMPILE_TEST
	depends on MAILBOX
	depends on COMMON_CLK
	select PM_GENERIC_DOMAINS

In my test case, COMPILE_TEST=y.  ARCH_QCOM is not set.

And kconfig does warn:

WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS
  Depends on [n]: PM [=n]
  Selected by [m]:
  - QCOM_AOSS_QMP [=m] && (ARCH_QCOM || COMPILE_TEST [=y]) && MAILBOX [=y] && COMMON_CLK [=y]


Who is responsible for that Kconfig segment?
Ah, Bjorn.  Cc-ed.

-- 
~Randy

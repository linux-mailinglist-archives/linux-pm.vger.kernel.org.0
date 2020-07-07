Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332AF21766E
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 20:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgGGSSj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 14:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgGGSSi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 14:18:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49DAC061755;
        Tue,  7 Jul 2020 11:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=nbd66pLuGjkYKOc6hwK0BBSTm2RkMZp20FPfhd1njx0=; b=gCM1d9uQPgnpbWhR89j1G6N89L
        nyQwBb/fwtc6SqBRN44jREedbdYNDvXXlyiUyrzuJ9nSaAftI8qCMjYux+z0flLj4NTyFaynD49EB
        bmiDeaL7ZHxZfhPCMA5Gr7O15ojxPsmRL7ZWOuMW+49yvCzvJe3Vq9vVZYjYacVVoevwSunz9FfwL
        IRJw/JSUFIyOZQCtw3z8jNyiInwy/hpiPgpC0BpVTKPZ47kHrTyPOhcQtVp8CUbtF/t0a9ySRR9y9
        CskOXgmkAv6Y5xKJ3cewZDFmWE3Lp1gZbkPEe8q2tKJzmqlMntxXmxGnqDS8DiAdHGkZg1ceJpD57
        S8xbHesg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jssAs-0005GW-Qm; Tue, 07 Jul 2020 18:18:35 +0000
Subject: Re: [PATCH -next] cpufreq: add stub for get_cpu_idle_time() to fix
 scsi/lpfc driver build
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
References: <3a20bf20-247d-1242-dcd0-aef1bbc6e308@infradead.org>
 <20200707030943.xkocccy6qy2c3hrx@vireshk-i7>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b35ed758-a964-2f76-d2d3-99c260458878@infradead.org>
Date:   Tue, 7 Jul 2020 11:18:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707030943.xkocccy6qy2c3hrx@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/6/20 8:09 PM, Viresh Kumar wrote:
> On 06-07-20, 09:44, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> To fix a build error in drivers/scsi/lpfc/lpfc_sli.c when
>> CONFIG_CPU_FREQ is not set/enabled, add a stub function for
>> get_cpu_idle_time() in <linux/cpufreq.h>.
>>
>> ../drivers/scsi/lpfc/lpfc_sli.c: In function ‘lpfc_init_idle_stat_hb’:
>> ../drivers/scsi/lpfc/lpfc_sli.c:7330:26: error: implicit declaration of function ‘get_cpu_idle_time’; did you mean ‘set_cpu_active’? [-Werror=implicit-function-declaration]
> 
> And why is lpfc_sli.c using a cpufreq (supposedly internal, i.e. for
> cpufreq related parts) routine ? I think if you really need this, then
> it should be moved to a better common place and let everyone use it.

Viresh:

James Smart replied in another email thread with lpfc explanation for using
get_cpu_idle_time().  Please see
https://lore.kernel.org/linux-scsi/7ae1c7e3-ce8d-836b-1ae7-d4d00bd8f95c@broadcom.com/T/#md083717b1ff3a428c3b419dcc6d11cd03fee44c7

for this text:
""The driver is using cpu utilization in order to choose between softirq or work queues in handling an interrupt. Less-utilized, softirq is used. higher utilized, work queue is used.  The utilization is checked periodically via a heartbeat. ""


> I also see that drivers/macintosh/rack-meter.c has its own
> implementation for this.
> 
>>    idle_stat->prev_idle = get_cpu_idle_time(i, &wall, 1);
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: linux-pm@vger.kernel.org
>> Cc: James Smart <james.smart@broadcom.com>
>> Cc: Dick Kennedy <dick.kennedy@broadcom.com>
>> Cc: linux-scsi@vger.kernel.org
>> ---
>>  include/linux/cpufreq.h |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> --- linux-next-20200706.orig/include/linux/cpufreq.h
>> +++ linux-next-20200706/include/linux/cpufreq.h
>> @@ -237,6 +237,10 @@ static inline unsigned int cpufreq_get_h
>>  {
>>  	return 0;
>>  }
>> +static inline u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy)
>> +{
>> +	return 0;
>> +}
>>  static inline void disable_cpufreq(void) { }
>>  #endif
>>  
> 


-- 
~Randy


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C8336889
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 02:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfFFAAc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 20:00:32 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:44281 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfFFAAb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 20:00:31 -0400
Received: from [192.168.1.110] ([77.2.1.21]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MKsaz-1hGBSH24Q1-00LEBz; Thu, 06 Jun 2019 01:59:20 +0200
Subject: Re: [PATCH 3/3] drivers: hwmon: i5k_amb: remove unnecessary #ifdef
 MODULE
To:     Guenter Roeck <linux@roeck-us.net>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, jdelvare@suse.com, khalid@gonehiking.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        aacraid@microsemi.com, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1559397700-15585-1-git-send-email-info@metux.net>
 <1559397700-15585-4-git-send-email-info@metux.net>
 <20190601224946.GA6483@roeck-us.net>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <e91fabd4-a7a4-3afa-9f3a-95a6d90e8c7b@metux.net>
Date:   Wed, 5 Jun 2019 23:59:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190601224946.GA6483@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:x2JZ14/Ltf9P+H+gFTGOzpgzjvpnZO2Dx45nnYtkU8/Jf77rGF5
 O3+Evml9+YC7+rE8EkhBKebhEATL6ngqsMnh1Sp0TOjWfM/22qOo3Wpzp0pji7YNXrtiG8d
 F050pOBi1wpgxtpCw1OAOz7kwg/vQAaB0Ze5Io53TRh2CiA26PIRufOmn/FXxPFgukkQfwB
 wkIzmo+GjH1u0aacbTSKA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pTo8rphLc3E=:o5o9pSJ22RJDRX25qdJR9X
 QqIFaMylNMFdKHq1uOuPqDCleLZU+ekezImac9fowU/ipSKyqoKteG1DOQfSPM04IT+ieT+tm
 Oyx3a9zNHSeZmiwLxKVT7P3CfQjYJwiS+ADHAqREXQR90mBEHb4lawnx4XKrk5fhQoNL7fd0D
 D+iTCEKoHr7G2sftpCweEZGrBkw2aEZpopAg0b55VWuwTju8Y5bRzUxk2rLoYbnG+rVNabimQ
 TOgMqCsBuv0t/CwozsNIEhzvpcIPiOZZklBERj1ChMueBjlmisKn9LCDSqMxUN9LXUGgNoTrB
 Sw900UxWU6fswrLGAzWErlyiZCsJ/HFnx37a3CDCDxrN0IHUk2ko61VYvPTRX3hwwH+FHMVox
 uIpIKn/rUoQkC3eW2BMZpjQZJ7jRtHOX/gc65Dh6cokyeJusPESVhuz7vZCo33gsJ1m1Qlrg6
 /OfxoN34bwxYq4Wl4yLR679V6mR/RQAw/MD2q74kkAWOb2mzQuijKoFN1b0qe9Yvci+R1ts6T
 EuVfyjkHPRYwTKalbjYe5nMjUXY9usesuF6cGCpLbnnUdhZx/T1K6JzDjb+dDJrHegydxueR1
 bbf+FbGSH6RqGIWSwBfD2i9ZjfH4iW74/BOPhOqQBux+zf9B6YzsIwMnH+hvz6pyMS0QADVnk
 d6s1uYwVIYchlhKkiIB4RJOcxw+gpEY9f1Xwvij/CCnK/TKjppCJCvRysmz5D1DyJtWyyIh7k
 6g1iMq6jd3n2+pIm3BdwY/zlgFOLwdauF0XHVwuvZIEWsqhzmNC6Q13lYpo=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01.06.19 22:49, Guenter Roeck wrote:
> On Sat, Jun 01, 2019 at 04:01:40PM +0200, Enrico Weigelt, metux IT consult wrote:
>> The MODULE_DEVICE_TABLE() macro already checks for MODULE defined,
>> so the extra check here is not necessary.
>>
>> Signed-off-by: Enrico Weigelt <info@metux.net>
>> ---
>>   drivers/hwmon/i5k_amb.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
>> index b09c39a..b674c2f 100644
>> --- a/drivers/hwmon/i5k_amb.c
>> +++ b/drivers/hwmon/i5k_amb.c
>> @@ -482,14 +482,12 @@ static int i5k_channel_probe(u16 *amb_present, unsigned long dev_id)
>>   	{ 0, 0 }
>>   };
>>   
>> -#ifdef MODULE
>>   static const struct pci_device_id i5k_amb_ids[] = {
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5000_ERR) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5400_ERR) },
>>   	{ 0, }
>>   };
>>   MODULE_DEVICE_TABLE(pci, i5k_amb_ids);
>> -#endif
>>   
> 
> I'd rather know what this table is used for in the first place.

Seems it's really just used for the module loader, while actual probing
is using a different table. IMHO, the worst thing my patch could do is
introducing a warning on unused variable (IMHO shouldn't happen when
it's static const).

I've just rewritten it to move everything into i5k_amb_ids ... just need
to run build tests on it (unfortunately can't run-test, as I don't have
that device).


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287

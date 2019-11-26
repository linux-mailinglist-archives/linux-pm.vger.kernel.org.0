Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1CD7109A1B
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 09:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKZIZ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 03:25:57 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:37507 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfKZIZ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 03:25:57 -0500
Received: by mail-pl1-f176.google.com with SMTP id bb5so7803277plb.4
        for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2019 00:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ewAeDZldYhSzz/uYyBGNViuyDfo1YvS6M0eL9yiYnY=;
        b=zbnswKBvuvc2ZX1gwwGABfoKimwB4hW65Ehl5XS+9fPnexk8qtKGS3eexucNaWi7wR
         GX11hom0BTh/qnMhSvDRw8H/T6x22HqRA7Pqwrtfc1lk++m5gVQwkRHM0BPKYVFM7A2m
         CJ4EJbfd/mr+YayIOlXR4zoqFQodaoXIwBTABuEW5PxlWF+3anMTYr+no9JYFW/mAs5e
         C4Oo/zLdF4pOW5qvIqBAVf+CzfLkWfp0eGF38jspnB8l06iEqneezK4Z9KpcU5bz590X
         MpsvZkECEB3xK33/grYfElvNWcYPoSs1PRUX9d0eWBQIdFtTolq/olwhAjbvW+csJkjw
         7bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ewAeDZldYhSzz/uYyBGNViuyDfo1YvS6M0eL9yiYnY=;
        b=hufTO0wxegwI0FbwVsj0gUDccHeBFbaUkiN22+wMXSUyu8YUP35Z15VEUYmeaX+3Q4
         9krWIXvCV4m5d/HDTVN3FQCx/QcPP7JMz4EPZrXGfppjHsVLuD4KD57jVRSP9CAuEaO0
         AmcBwDfn+afGVSe1iI66NtXCBDZVxwNmTD8zgoYrrVWlVBp6v5tnimTcF29IybkA4Oe6
         zc7+G+L82ibOzUjGMf+d0pXfgXdVK32b8A2PVafJDKpflaPePloKgvSFa6wTh2HoRHY9
         34LFM5k7YimNMcdOJJTkz90/27hkcn4tFM9pOKMxoifGWsmY6okl3AjSDFvi+b+XnbXR
         NogA==
X-Gm-Message-State: APjAAAVFvzjwaezOmW5vnwlDqVvwzimVXYFwiLWLGvibXqEsQegKufqc
        R8XbgWE9k29s/AYw+Ja8/mxrnA==
X-Google-Smtp-Source: APXvYqxgs17uSCn8x0QzZM7/YiCIfov7wv/Kngi0wzLwspfOmZJvyNwUEQd9DLmhhaqWNfyGdWD1dw==
X-Received: by 2002:a17:902:bd88:: with SMTP id q8mr34053143pls.261.1574756756403;
        Tue, 26 Nov 2019 00:25:56 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id t15sm11733798pgb.0.2019.11.26.00.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 00:25:55 -0800 (PST)
Date:   Tue, 26 Nov 2019 13:55:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
Message-ID: <20191126082553.kwfjpvstpjht2hl7@vireshk-i7>
References: <20191121093557.bycvdo4xyinbc5cb@vireshk-i7>
 <DB3PR0402MB39165544EDD0317095A1B72DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0geykeebX-67+h4twj+t7oTVBf7X7_UsXw0LAc+0Ap75Q@mail.gmail.com>
 <CAJZ5v0j4z9tEDCGKRc7dHqTiJ1Fq3So=ELfvR6H25UkRmKeBvg@mail.gmail.com>
 <DB3PR0402MB3916BDC24BDA1053B7ADBDCFF5490@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0g5EGWVAm4A8ynoWAPc1wJRpR6wgZqwhvbmeT4eT49EUA@mail.gmail.com>
 <DB3PR0402MB39165E40800E42C2E5635C7CF54A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB391638C66C7EB93B5156A2D2F54A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20191126061810.okkw3wkjmi2uvqjj@vireshk-i7>
 <DB3PR0402MB391646169704A952F7CEC4EFF5450@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB391646169704A952F7CEC4EFF5450@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-11-19, 08:22, Anson Huang wrote:
> Hi, Viresh
> 
> > On 25-11-19, 09:43, Anson Huang wrote:
> > > Hi, Rafael
> > > 	I tried to print the necessary info into DRAM instead of calling pr_info
> > > 	directly, then issue can be reproduced easily again, when issue
> > > 	happened, the LOG shows the last irq_work_sync() is NOT correctly
> > > 	finished. Below are the log and patch I added, the test case is simply
> > > 	to repeat removing CPU1/CPU2/CPU3 then adding back
> > CPU1/CPU2/CPU3.
> > > 	When issue happens, below log shows last round of removing CPUs,
> > > 	CPU1/CPU2/CPU3 irq_work_sync() all worked as expected, the work-
> > >cpu is
> > > 	-1, then when CPU1 was added back, the irq_work flag is
> > pending/busy on
> > > 	CPU1, and issue happened:
> > 
> > FWIW, I tried to reproduce it on my hikey board and I couldn't even after
> > hours of testing :(
> 
> Did you use ondemand governor? By default the governor is performance and
> it has no issue.

Yes, governor was set to ondemand and then I ran this script, which permanently
removes CPU 4-7 and then keeps offlining/onlining CPU 1-3:

root@linaro-developer:~/work# cat irqwork.sh 
#!/bin/bash

cd /sys/devices/system/cpu/

for i in `seq 4 7`
do
        echo 0 > cpu$i/online
done

while true
do
        for i in `seq 1 3`
        do
                echo 0 > cpu$i/online
        done

        for i in `seq 1 3`
        do
                echo 1 > cpu$i/online
        done
done


-- 
viresh

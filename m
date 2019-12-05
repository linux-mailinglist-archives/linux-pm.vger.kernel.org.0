Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA042113FFD
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 12:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfLELRU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 06:17:20 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39597 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfLELRT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 06:17:19 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so1468075pfx.6
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2019 03:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z03ohNLpppYcuO0yM+qjrRR5Yk/Uuo3EBjz7qrVNa5Y=;
        b=Afrl5HqsvYS1OORApp4kfLXG7NwmYUczo/EShpe717ZcT1SwhEFKQFAKmNrCdbrg9P
         up+t818iwO3ODhbxJiWypPwZMew0C/qlM/ylkiVQBmF+VCPAhlBsJt1g7q4Rr9quwx7X
         yBVg9jzGAGooMbJ/DhbIsz2hlSLKkya3kpITHcsmDgvrQxYaWS3uRLZtulj0kwCCYDGj
         kqwrujgjCU5ge42OcgIlshNcYsww5ZsETcXhmqoO+wzlkmDGUTaNuYq5wm55G0kNH7Vv
         9twi5Hzra0SD6B428iJofHqlFNEJoR3/ixKGPaVB0yURTgiw7APSftYCnf0ILh/dhZBf
         MRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z03ohNLpppYcuO0yM+qjrRR5Yk/Uuo3EBjz7qrVNa5Y=;
        b=SGBPkrYga1z6J8C/rX51sd1p+0KGPieVhg0G/AjFequ68cDtIRIaLLuc5hq4YwMCit
         pJYH6/9UaYnuE5PuLdEVOuOojO8CbJ0udfNbYbuY6E7C4JhsFTMNm4+UykQ9JdZmRs5g
         lD4XtsgDXbsRY3RisHwJtGEm6X2egKqcmQx7pVXYJHE0/07i+dUu2vK3Si05Mtx06STD
         +Tx4LNqe+EEtasg2PcXi3DnHcen+pNEpaIRwkWh2cmc44+Mz7A+vkQRMXq/sJt6/gV08
         Ei60+kta4s2RgS+qkZdePqyt0UdvZPWd8ngslN2v5LXefzqtvy7hI4+aAb7EtBXK/E+X
         qpcw==
X-Gm-Message-State: APjAAAVfDf7Nt74g7JZ6TGCgHd4Y2+seJBfL7/BnPZ4QN2760Cbk2Vrh
        lgV6vVPOal1y0Fysd6kCK47hGw==
X-Google-Smtp-Source: APXvYqws8iZ8M0HTa65099q4bAK72ZwNTLCnn/rr5st4JamUYufProjEpPWDwpeF9XurR6Xhln61Ew==
X-Received: by 2002:aa7:86c5:: with SMTP id h5mr8244033pfo.259.1575544639051;
        Thu, 05 Dec 2019 03:17:19 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id e27sm12607679pfj.129.2019.12.05.03.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2019 03:17:18 -0800 (PST)
Date:   Thu, 5 Dec 2019 16:47:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, peterz@infradead.org
Cc:     Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
Message-ID: <20191205111716.eu73f22x4rz652x2@vireshk-i7>
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20191205110034.gbnlnqggmk2hb44z@vireshk-i7>
 <4619762.rfsBlt1pEd@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4619762.rfsBlt1pEd@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+Peter

On 05-12-19, 12:10, Rafael J. Wysocki wrote:
> On Thursday, December 5, 2019 12:00:34 PM CET Viresh Kumar wrote:
> > On 05-12-19, 08:53, Anson Huang wrote:
> > > Hi, Rafael
> > > 	This issue is very weird, the irq_work used in cpufreq_governor.c is very simple, ONLY one entry to claim the irq_work, and cpufreq_governor's irq_work is a private irq_work structure, no other drivers use it. I added some trace event in cpufreq_governor.c and irq_work.c, every time, the issue happened at the point of CPU1/2/3 all off, and CPU1 start ON line, but when CPU1 tried to sync the irq_work in cpufreq_dbs_governor_stop(), the irq_work shows that previous work is pending on CPU3 which is offline, I also had the trace event in irq_work_claim(),  but no any log shows the cpufreq_governor irq_work is claimed on CPU3 after CPU3 offline, below is the debug patch I added and the log on 2 consoles:
> > > 	If I understand it correctly, the irq work used in cpufreq_governor ONLY has one entry of calling irq_work_queue() which will be ONLY claimed on the CPU calling the irq_work_queue(), but from trace result, I have NOT see where CPU3 could call irq_work_queue() after it finishes the irq work sync before offline. Could it something wrong related to cache maintain during CPU hotplug?
> > 
> > I think you earlier said that the issue wasn't there in 4.19 kernel,
> > right ? What about doing git bisect to see if we can find the
> > offending commit ?
> 
> That won't hurt, but I guess that it will be just the one that started to
> use irq_work ..

cpufreq_governor.c has hardly seen any patches since 4.19 and irq_work
is being used since a long time before 4.19 I think.

> Also note that schedutil has the same issue.

I agree, but at the same time both cpufreq_governor.c and schedutil
have almost exactly the same code around irq_work. It may be an update
to irq_work implementation, or something else that is causing the
corruption here.

And git blame may just point us to the offending patch if we are lucky
enough :)

-- 
viresh

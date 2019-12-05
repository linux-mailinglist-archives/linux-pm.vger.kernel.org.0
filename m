Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9BBC113FD4
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 12:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfLELAi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 06:00:38 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:37831 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbfLELAh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 06:00:37 -0500
Received: by mail-pf1-f177.google.com with SMTP id s18so1454222pfm.4
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2019 03:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZUGsVDU+ezq7myFy16KsH7Hg/PU1W1LYB5g4ks2ehVc=;
        b=O5H8Njm452u9OKbM8vjO4aaKIC1eEMsZ/1jHUU2NhRgNVZWcIR7noDrSLQw46QVO+W
         HFt1ak/3W73lZPCgkCs0UcFyP+A6A8FeKtUWB5gX2skS45yrOEEZj4SyjPyGqkOckPyc
         t05kP41FAPGj+FRsGxj+b5WEczTA+Ftp4/tTw0A2M/3SELPXp3DHoP7e8DeMl4fvHvN8
         p9VIb/f5dF1iBnagjO0i3cLD0QGH5DTBVp1AN3SyEM5Z+utkHOsZPaMEskc9EWXzzPIA
         RIZ9wQvidk6TYW2zuoig7hAEeX2OcCxyb0H66nQk4x0nBIpsXj5KSS2EHuwC7/VLL8a1
         qB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZUGsVDU+ezq7myFy16KsH7Hg/PU1W1LYB5g4ks2ehVc=;
        b=qHpucn9zbJLubgBaUcQYpasKPElAIyMMofCZhFz4jENj4DzQa/7kaIqBmNuymWr1pz
         ZAW7j9MULrZqWg9kbrV14KY4SCXeoLOgq+QtjIv0nhhO+YO1pkomToI7JFtzRFrQzKdS
         VeDlZdw3HbRGpNtyQwJMhU7AcSqDEt49aJPW07g9jqNG5hSUSDyzUNufGnuj73bgZN6C
         m0l7be5kcPcNJi5ww6++R1DG/0XqXv3uZYbrMMH5aWumTbf8/afiL51T2eMe4j91l36L
         tio+DYEHbOPjYu1TQtxsf2ts+x55+VarBemUB+4u72Rl2MrtZ0+fxMk277CRnKa6DwDW
         EBwA==
X-Gm-Message-State: APjAAAU5o710AHtKB+PjR2MFFCyw9IokLDWBr5UJfxdUlzcfh1NXUBPw
        KNDLMxXpxFiIWHBoUi3gedAS1g==
X-Google-Smtp-Source: APXvYqxatt6HrAhL36xb4JGDXE+letcEmBUCLi2FEhJFSTk2NZryP1pAyF95hJUirNfRa0GAMyl+sw==
X-Received: by 2002:a63:e009:: with SMTP id e9mr8814145pgh.222.1575543636912;
        Thu, 05 Dec 2019 03:00:36 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id c68sm12333354pfc.156.2019.12.05.03.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2019 03:00:36 -0800 (PST)
Date:   Thu, 5 Dec 2019 16:30:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
Message-ID: <20191205110034.gbnlnqggmk2hb44z@vireshk-i7>
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39165E40800E42C2E5635C7CF54A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0iiJusFSrB9LRQq39K9TeGu0kndogdd060qqiJ=QOAQRw@mail.gmail.com>
 <7507929.7xP3Io3WO9@kreacher>
 <DB3PR0402MB3916C8F16045625489E776F4F5460@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-12-19, 08:53, Anson Huang wrote:
> Hi, Rafael
> 	This issue is very weird, the irq_work used in cpufreq_governor.c is very simple, ONLY one entry to claim the irq_work, and cpufreq_governor's irq_work is a private irq_work structure, no other drivers use it. I added some trace event in cpufreq_governor.c and irq_work.c, every time, the issue happened at the point of CPU1/2/3 all off, and CPU1 start ON line, but when CPU1 tried to sync the irq_work in cpufreq_dbs_governor_stop(), the irq_work shows that previous work is pending on CPU3 which is offline, I also had the trace event in irq_work_claim(),  but no any log shows the cpufreq_governor irq_work is claimed on CPU3 after CPU3 offline, below is the debug patch I added and the log on 2 consoles:
> 	If I understand it correctly, the irq work used in cpufreq_governor ONLY has one entry of calling irq_work_queue() which will be ONLY claimed on the CPU calling the irq_work_queue(), but from trace result, I have NOT see where CPU3 could call irq_work_queue() after it finishes the irq work sync before offline. Could it something wrong related to cache maintain during CPU hotplug?

I think you earlier said that the issue wasn't there in 4.19 kernel,
right ? What about doing git bisect to see if we can find the
offending commit ?

-- 
viresh

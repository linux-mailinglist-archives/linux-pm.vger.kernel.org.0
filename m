Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 616A5113FEC
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 12:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfLELKM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 06:10:12 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50182 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfLELKM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 06:10:12 -0500
Received: from 79.184.254.100.ipv4.supernova.orange.pl (79.184.254.100) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 90efbe2452a8c53e; Thu, 5 Dec 2019 12:10:10 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
Date:   Thu, 05 Dec 2019 12:10:09 +0100
Message-ID: <4619762.rfsBlt1pEd@kreacher>
In-Reply-To: <20191205110034.gbnlnqggmk2hb44z@vireshk-i7>
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com> <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com> <20191205110034.gbnlnqggmk2hb44z@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, December 5, 2019 12:00:34 PM CET Viresh Kumar wrote:
> On 05-12-19, 08:53, Anson Huang wrote:
> > Hi, Rafael
> > 	This issue is very weird, the irq_work used in cpufreq_governor.c is very simple, ONLY one entry to claim the irq_work, and cpufreq_governor's irq_work is a private irq_work structure, no other drivers use it. I added some trace event in cpufreq_governor.c and irq_work.c, every time, the issue happened at the point of CPU1/2/3 all off, and CPU1 start ON line, but when CPU1 tried to sync the irq_work in cpufreq_dbs_governor_stop(), the irq_work shows that previous work is pending on CPU3 which is offline, I also had the trace event in irq_work_claim(),  but no any log shows the cpufreq_governor irq_work is claimed on CPU3 after CPU3 offline, below is the debug patch I added and the log on 2 consoles:
> > 	If I understand it correctly, the irq work used in cpufreq_governor ONLY has one entry of calling irq_work_queue() which will be ONLY claimed on the CPU calling the irq_work_queue(), but from trace result, I have NOT see where CPU3 could call irq_work_queue() after it finishes the irq work sync before offline. Could it something wrong related to cache maintain during CPU hotplug?
> 
> I think you earlier said that the issue wasn't there in 4.19 kernel,
> right ? What about doing git bisect to see if we can find the
> offending commit ?

That won't hurt, but I guess that it will be just the one that started to
use irq_work ..

Also note that schedutil has the same issue.




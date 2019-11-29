Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D202310D501
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 12:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfK2Ljc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 06:39:32 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58515 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfK2Ljc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 06:39:32 -0500
Received: from 79.184.255.242.ipv4.supernova.orange.pl (79.184.255.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 724467887e3930d8; Fri, 29 Nov 2019 12:39:30 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
Date:   Fri, 29 Nov 2019 12:39:30 +0100
Message-ID: <7507929.7xP3Io3WO9@kreacher>
In-Reply-To: <CAJZ5v0iiJusFSrB9LRQq39K9TeGu0kndogdd060qqiJ=QOAQRw@mail.gmail.com>
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com> <DB3PR0402MB39165E40800E42C2E5635C7CF54A0@DB3PR0402MB3916.eurprd04.prod.outlook.com> <CAJZ5v0iiJusFSrB9LRQq39K9TeGu0kndogdd060qqiJ=QOAQRw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, November 25, 2019 1:44:20 PM CET Rafael J. Wysocki wrote:
> On Mon, Nov 25, 2019 at 7:05 AM Anson Huang <anson.huang@nxp.com> wrote:
> >
> > Hi, Rafael
> >         Looks like adding pr_info() in irq_work_sync() makes issue can NOT be reproduced, any possibility of race happen there and the pr_info eliminate the race condition? I will continue run the test with the pr_info to see if any luck to reproduce it.
> 
> Yes, it looks like there is a race condition in there.
> 
> I need to analyze the code a bit to confirm it which may take a bit of time.

I'm not seeing any races in there expect for the possible over-optimization
of irq_work_sync() that I was talking about before.

Cheers!




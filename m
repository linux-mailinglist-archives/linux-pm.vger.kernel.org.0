Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08DCB44A9A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 20:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfFMS1S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 13 Jun 2019 14:27:18 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44339 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfFMS1R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2019 14:27:17 -0400
Received: from 79.184.253.190.ipv4.supernova.orange.pl (79.184.253.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id ff7a96cd0fcda06d; Thu, 13 Jun 2019 20:27:15 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: linux-next: Tree for Jun 13 (drivers/base/power/domain.c)
Date:   Thu, 13 Jun 2019 20:27:15 +0200
Message-ID: <2480052.F5ZUPELBQ8@kreacher>
In-Reply-To: <00d6da06-1316-6560-5541-0caf8ea5084b@infradead.org>
References: <20190613193054.37bde7fa@canb.auug.org.au> <00d6da06-1316-6560-5541-0caf8ea5084b@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, June 13, 2019 6:12:43 PM CEST Randy Dunlap wrote:
>  This is a multi-part message in MIME format.
> --------------D4992319A3EA7FFA5EF515C6
> Content-Type: text/plain; charset=windows-1252
> Content-Transfer-Encoding: 8bit
> 
> On 6/13/19 2:30 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20190612:
> > 
> 
> 
> on x86_64:
> 
> ../drivers/base/power/domain.c: In function �genpd_queue_power_off_work�:
> ../drivers/base/power/domain.c:485:13: error: �pm_wq� undeclared (first use in this function)
>   queue_work(pm_wq, &genpd->power_off_work);
>              ^
> ../drivers/base/power/domain.c:485:13: note: each undeclared identifier is reported only once for each function it appears in
> ../drivers/base/power/domain.c: In function �genpd_dev_pm_qos_notifier�:
> ../drivers/base/power/domain.c:675:25: error: �struct dev_pm_info� has no member named �ignore_children�
>    if (!dev || dev->power.ignore_children)
>                          ^
> ../drivers/base/power/domain.c: In function �rtpm_status_str�:
> ../drivers/base/power/domain.c:2754:16: error: �struct dev_pm_info� has no member named �runtime_error�
>   if (dev->power.runtime_error)
>                 ^
> ../drivers/base/power/domain.c:2756:21: error: �struct dev_pm_info� has no member named �disable_depth�
>   else if (dev->power.disable_depth)
>                      ^
> ../drivers/base/power/domain.c:2758:21: error: �struct dev_pm_info� has no member named �runtime_status�
>   else if (dev->power.runtime_status < ARRAY_SIZE(status_lookup))
>                      ^
> ../drivers/base/power/domain.c:2759:31: error: �struct dev_pm_info� has no member named �runtime_status�
>    p = status_lookup[dev->power.runtime_status];
>                                ^
> 
> 
> Full randconfig file is attached.

PM_GENERIC_DOMAINS, which is set, depend on PM, which is not set.

Looks like an impossible configuration to me.




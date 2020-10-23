Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6089E2971E9
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 17:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465529AbgJWPGy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 23 Oct 2020 11:06:54 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50356 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465544AbgJWPGy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 11:06:54 -0400
Received: from 89-64-88-190.dynamic.chello.pl (89.64.88.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id e7860b8843c45b1e; Fri, 23 Oct 2020 17:06:52 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH 0/3] PM: runtime: Fixes related to device links management
Date:   Fri, 23 Oct 2020 17:06:51 +0200
Message-ID: <3725593.WVS78bcaU2@kreacher>
In-Reply-To: <7ebacb82-dc0c-3938-660d-52810607ac00@hisilicon.com>
References: <6543936.FbWAdBN1tG@kreacher> <7ebacb82-dc0c-3938-660d-52810607ac00@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, October 23, 2020 5:50:04 AM CEST chenxiang (M) wrote:
> Hi Rafael,
> 
> 在 2020/10/22 3:10, Rafael J. Wysocki 写道:
> > Hi Greg & all,
> >
> > Commit d12544fb2aa9 ("PM: runtime: Remove link state checks in
> > rpm_get/put_supplier()") merged recently introduced a weakness
> > in the handling of device links in the runtime PM framework that
> > may be confusing and even harmful.
> >
> > Namely, the checks removed by that commit prevented PM-runtime from
> > getting or dropping references to the supplier device whose driver
> > was going away via its links to consumers, which specifically allowed
> > the pm_runtime_clean_up_links() called from __device_release_driver()
> > to run without interfering with runtime suspend/resume of consumer
> > devices (which still might happen even though the drivers had been
> > unbound from them by that time).
> >
> > After the above commit, calling pm_runtime_clean_up_links() from
> > __device_release_driver() makes a little sense and it may be interfering
> > destructively with regular PM-runtime suspend/resume control flows, so
> > it needs to be either fixed or dropped altogether.  I prefer the latter,
> > because among other things this removes an arbitrary difference in the
> > handling of managed device links with respect to the stateless ones,
> > so patch [2/3] is doing just that.
> >
> > However, in some rare cases pm_runtime_clean_up_links() may help to clean
> > up leftover PM-runtime references, so if that function goes away, they
> > need to be cleaned up elsewhere.  That's why patch [1/3] modifies
> > __device_link_del() to drop them upon device link removal (which also
> > needs to be done for stateless device links and that's why I'm regarding
> > this patch as a fix).
> >
> > Finally, to avoid pointless overhead related to suspending and resuming
> > the target device for multiple times in a row in __device_release_driver(),
> > it is better to resume it upfront before checking its links to consumers,
> > which is done by patch [3/3].
> 
> 
> I have tested the patchset, and it solves my reported issue, so please 
> feel free to add :
> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>

Thank you!




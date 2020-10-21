Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976282952CE
	for <lists+linux-pm@lfdr.de>; Wed, 21 Oct 2020 21:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392108AbgJUTOj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Oct 2020 15:14:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59714 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504800AbgJUTOg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2020 15:14:36 -0400
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id 93d625418f3655fd; Wed, 21 Oct 2020 21:14:33 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Saravana Kannan <saravanak@google.com>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH 0/3] PM: runtime: Fixes related to device links management
Date:   Wed, 21 Oct 2020 21:10:08 +0200
Message-ID: <6543936.FbWAdBN1tG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg & all,

Commit d12544fb2aa9 ("PM: runtime: Remove link state checks in
rpm_get/put_supplier()") merged recently introduced a weakness
in the handling of device links in the runtime PM framework that
may be confusing and even harmful.

Namely, the checks removed by that commit prevented PM-runtime from
getting or dropping references to the supplier device whose driver
was going away via its links to consumers, which specifically allowed
the pm_runtime_clean_up_links() called from __device_release_driver()
to run without interfering with runtime suspend/resume of consumer
devices (which still might happen even though the drivers had been
unbound from them by that time).

After the above commit, calling pm_runtime_clean_up_links() from
__device_release_driver() makes a little sense and it may be interfering
destructively with regular PM-runtime suspend/resume control flows, so
it needs to be either fixed or dropped altogether.  I prefer the latter,
because among other things this removes an arbitrary difference in the
handling of managed device links with respect to the stateless ones,
so patch [2/3] is doing just that.

However, in some rare cases pm_runtime_clean_up_links() may help to clean
up leftover PM-runtime references, so if that function goes away, they
need to be cleaned up elsewhere.  That's why patch [1/3] modifies
__device_link_del() to drop them upon device link removal (which also
needs to be done for stateless device links and that's why I'm regarding
this patch as a fix).

Finally, to avoid pointless overhead related to suspending and resuming
the target device for multiple times in a row in __device_release_driver(),
it is better to resume it upfront before checking its links to consumers,
which is done by patch [3/3].

While this series touches the driver core, it really is mostly related to
runtime PM, so I can apply it if that's OK.

Thanks!




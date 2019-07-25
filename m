Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 049F574A60
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 11:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfGYJvo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 05:51:44 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65413 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYJvn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 05:51:43 -0400
Received: from 79.184.253.188.ipv4.supernova.orange.pl (79.184.253.188) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 4cf206ac235193a0; Thu, 25 Jul 2019 11:51:41 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [Regression] Commit "nvme/pci: Use host managed power state for suspend" has problems
Date:   Thu, 25 Jul 2019 11:51:41 +0200
Message-ID: <2332799.izEFUvJP67@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Keith,

Unfortunately,

commit d916b1be94b6dc8d293abed2451f3062f6af7551
Author: Keith Busch <keith.busch@intel.com>
Date:   Thu May 23 09:27:35 2019 -0600

    nvme-pci: use host managed power state for suspend

doesn't universally improve things.  In fact, in some cases it makes things worse.

For example, on the Dell XPS13 9380 I have here it prevents the processor package
from reaching idle states deeper than PC2 in suspend-to-idle (which, of course, also
prevents the SoC from reaching any kind of S0ix).

That can be readily explained too.  Namely, with the commit above the NVMe device
stays in D0 over suspend/resume, so the root port it is connected to also has to stay in
D0 and that "blocks" package C-states deeper than PC2.

In order for the root port to be able to go to D3, the device connected to it also needs
to go into D3, so it looks like (at least on this particular machine, but maybe in
general), both D3 and the NVMe-specific PM are needed.

I'm not sure what to do here, because evidently there are systems where that commit
helps.  I was thinking about adding a module option allowing the user to override the
default behavior which in turn should be compatible with 5.2 and earlier kernels.

Cheers,
Rafael




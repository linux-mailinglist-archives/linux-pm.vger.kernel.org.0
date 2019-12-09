Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD5B1166BD
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 07:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfLIGST (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 01:18:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:22937 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfLIGSS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Dec 2019 01:18:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Dec 2019 22:18:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; 
   d="scan'208";a="215000460"
Received: from rzhang1-mobile.sh.intel.com ([10.239.195.243])
  by orsmga006.jf.intel.com with ESMTP; 08 Dec 2019 22:18:16 -0800
Message-ID: <38cbdb4739a56d25f13ef5afa7c6686d2baf74c4.camel@intel.com>
Subject: [GIT PULL] Thermal management updates for v5.5-rc2
From:   Zhang Rui <rui.zhang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Mon, 09 Dec 2019 14:18:21 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from tag
  git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-5.5-rc2

to receive the Thermal Management updates for v5.5-rc2
with top-most commit 6e456dca47c5e3b8d8c6bbc4edd1377985d793b5:

  MAINTAINERS: thermal: Change the git tree location (2019-12-07
21:49:39 +0800)

on top of commit fb3da48a8640f634242a0c61b78c3a5c724c5004:

  Merge branch 'thermal/next' of
git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux (2019-12-05 
11:21:24 -0800)

Starting from this release cycle, we have Daniel Lezcano work as the
new thermal co-maintainer because Eduardo's email is bouncing for
sometime and we can not reach him. We also have a new shared git tree
so that both Daniel and I can actively working on it.

Specifics:

- Update MAINTAINER file for new thermal co-maintainer and new thermal
git tree address. (Daniel Lezcano, Florian Fainelli, Zhang Rui)

- Fix a Kconfig warning. (YueHaibing)

thanks,
rui


----------------------------------------------------------------
Daniel Lezcano (1):
      MAINTAINERS: thermal: Change the git tree location

Florian Fainelli (1):
      MAINTAINERS: thermal: Eduardo's email is bouncing

YueHaibing (1):
      thermal: power_allocator: Fix Kconfig warning

Zhang Rui (1):
      MAINTAINERS: thermal: Add Daniel Lezcano as the thermal
maintainer

 MAINTAINERS             | 6 ++----
 drivers/thermal/Kconfig | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)


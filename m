Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B0B358EFD
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 23:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhDHVKc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 17:10:32 -0400
Received: from condef-10.nifty.com ([202.248.20.75]:61249 "EHLO
        condef-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDHVKb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 17:10:31 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Apr 2021 17:10:30 EDT
Received: from conuserg-09.nifty.com ([10.126.8.72])by condef-10.nifty.com with ESMTP id 138Kxvkl031146;
        Fri, 9 Apr 2021 05:59:57 +0900
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 138Kx46x002644;
        Fri, 9 Apr 2021 05:59:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 138Kx46x002644
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617915545;
        bh=CMNsK6z9omY3K2WcWrv+g7O+FAyKXeHXo7JaGbnAshQ=;
        h=From:To:Cc:Subject:Date:From;
        b=mCAELu1K9iNcHwzxPpkt2QeYzsGvXO3xtV9FO7Le8ftDrt50ftucQPKlGRH7qugRy
         Ya3grKSZw2YFqHeSRjzjleVybuCxC+F+LDqxW2ODDfZDizTzeFFEkS6xgklZ8DNySf
         sgjxmlZOGgylBtk14MT/msL3h5+0RgNqd1KhWiFHvZojROpII/2xzBmIKYk5FrMILE
         JH+ze/FBtu+Utc1Sh1V3UapkGiwD83/r25JpRXNpVeB6q8+2OIyrktRiLXSQ5RNZ6Y
         WT1cfD2EQCAGNfK7s+unVooFzVx+HATnyUBAB+3r8X2pMEEL5HCT32AGFF6izs7hFa
         M6AzFOhU0pc5Q==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 0/2] linux/kconfig.h: move IF_ENABLED() out of <linux/kconfig.h>
Date:   Fri,  9 Apr 2021 05:58:56 +0900
Message-Id: <20210408205858.51751-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


I insist on <linux/kconfig.h> having only minimal set of macros
that are needed to evaluate CONFIG options.

Everytime somebody added an alien to <linux/kconfig.h>, I needed to
kick it out.

I did not notice 1b399bb04837183cecdc1b32ef1cfc7fcfa75d32 because
I was not addressed by [1].

[1]: https://lore.kernel.org/lkml/?q=kconfig.h%3A+Add+IF_ENABLED%28%29+macro

I like Paul's idea, but if I had noticed the patch in time, I would
have tried my best to persuade to implement it outside of <linux/kconfig.h>
(Paul's initial patch was adding it to a new header instead of <linux/kconfig.h>)

Before it is widely used, I want to fix it.

In 2/2, I converted pm.h to allow driver cleanups.



Masahiro Yamada (2):
  linux/kconfig.h: replace IF_ENABLED() with PTR_IF() in
    <linux/kernel.h>
  pm: allow drivers to drop #ifdef and __maybe_unused from pm callbacks

 drivers/pinctrl/pinctrl-ingenic.c | 20 ++++-----
 include/linux/kconfig.h           |  6 ---
 include/linux/kernel.h            |  2 +
 include/linux/pm.h                | 67 +++++++++++--------------------
 4 files changed, 36 insertions(+), 59 deletions(-)

-- 
2.27.0


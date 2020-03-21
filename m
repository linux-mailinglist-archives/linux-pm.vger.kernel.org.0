Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C266D18E2EF
	for <lists+linux-pm@lfdr.de>; Sat, 21 Mar 2020 17:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgCUQmM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Mar 2020 12:42:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36050 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgCUQmM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Mar 2020 12:42:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id b18so10971489edu.3;
        Sat, 21 Mar 2020 09:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hOUxwkqpnMytCzxnbV5rDgipMTnqE3Eo9yayPel3k80=;
        b=TFHhtUs+kVx9MPvukJpOWN056xY+dp1KtCn2XYi/km5VGfrIgWULvvYuWuW+uV3su9
         XVKwYDMfm9jzuPkEevFyN735sFX91pEaBfBjz66ycfCPRDiDYhbl/vUlZPUWY7o6HktS
         85f9UfMhg5lK3RakVEhXsRq76mAt7rdsiItSJcpYI2YPkhhzjpzrFYCh1V/SZ+mZbnB8
         /UhSjKLqV2/8fGTRDGTumw/nts1j2Gp/fYCEa4/EalyZKwnuu33PrnvJdBBuRF87TvHc
         ntm6p6wSSwnEktnZIdhdTzq7/rq1tm4JgU1hzSS1X29LXky2H8TEoTXKC2VDFUXBxafQ
         R98w==
X-Gm-Message-State: ANhLgQ05XSLA4chUJepwTw/rarXeh2l92A//rmZ0+0KT6N9F6vkheYRw
        xxjPNyxeln2I9+PQjuCCJXQSltXO6pto3CBawCu2A/nC
X-Google-Smtp-Source: ADFU+vvzx1+Hm/OFP8lyIzm6w7PjOjndZFKPU8cqU1Voo6lS071IddxB21fSO/xx7NPZFtogCYVfku59Hh+gT0uzUdI=
X-Received: by 2002:aa7:dbc1:: with SMTP id v1mr13531314edt.177.1584808931122;
 Sat, 21 Mar 2020 09:42:11 -0700 (PDT)
MIME-Version: 1.0
From:   Len Brown <lenb@kernel.org>
Date:   Sat, 21 Mar 2020 12:41:59 -0400
Message-ID: <CAJvTdKmNJkx+aeHDcrqRG=0JDfaut5tj4w0oOojGWTjx9tY3qQ@mail.gmail.com>
Subject: [GIT PULL] turbostat version 20.03.20
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull these patches to update Linux to turbostat v20.03.20.
These patches unlock the full turbostat features for some
new machines, plus a couple other minor tweaks.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit fb33c6510d5595144d585aa194d377cf74d31911:

  Linux 5.6-rc6 (2020-03-15 15:01:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

for you to fetch changes up to b95fffb9b4afa8b9aa4a389ec7a0c578811eaf42:

  tools/power turbostat: update version (2020-03-21 00:48:02 -0400)

----------------------------------------------------------------
Chen Yu (5):
      tools/power turbostat: Support Cometlake
      tools/power turbostat: Support Tiger Lake
      tools/power turbostat: Support Ice Lake server
      tools/power turbostat: Support Jasper Lake
      tools/power turbostat: Support Elkhart Lake

Len Brown (5):
      tools/power turbostat: Fix gcc build warnings
      tools/power turbostat: Fix missing SYS_LPI counter on some Chromebooks
      tools/power turbostat: Fix 32-bit capabilities warning
      tools/power turbostat: Print cpuidle information
      tools/power turbostat: update version

 tools/power/x86/turbostat/Makefile    |   2 +-
 tools/power/x86/turbostat/turbostat.c | 142 +++++++++++++++++++++++++++-------
 2 files changed, 114 insertions(+), 30 deletions(-)

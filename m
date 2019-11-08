Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3047AF4552
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 12:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbfKHLFN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 06:05:13 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34714 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731784AbfKHLFN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 06:05:13 -0500
Received: by mail-oi1-f194.google.com with SMTP id l202so4903439oig.1;
        Fri, 08 Nov 2019 03:05:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3aTH1Z977b25oWGjuZ0H/5AYWBINoF8nmYXtAY/gL1M=;
        b=qDrYv4CAE9TZIvOUHD/jNU9Ywd3T+mCJ0kTgsCMmDlPsoQFtUbP6RebY/lgrYfE9Je
         2gsp5GAV4+ibcwoX+5oZ9V03IG6GiTa1LQ2YUL3U/ZQjL49XXhKDqLKBca0TRqLhZlCj
         ZvUHQ5fuWgnniXN+3WRWxxceuh1MgPVXfGAqPfpNS4/smo9UEZirrj5cbtsTemMzmTWl
         mI7rZL+62y6UQO7BeMpV2gzPATZYEG/lzoYwsQgubkEek1FYSXdH0HrxvSRl6v4ng5wL
         tT3pRU5LKnVKUG4w9PAgkBYCk33eAbyfpYx9d6qQjM0CaIxhHNDrkLiwhThp7FFyPYuz
         OI1w==
X-Gm-Message-State: APjAAAX4VvsMcLcqMQ8rMPuvvmzxnVvf0c8Aq+PX/STPL0VTSTJQnIYR
        THtUPlO0GH7QdHVIbe8BcKP6Nm89e0OqI7gFnSA=
X-Google-Smtp-Source: APXvYqwm4cJl+Tjng1uo+7i3zAU990Nw38Gcd0+2psUThBjuGsUnGyYtPPbeEoP/Y5CrXW17PqUyMwGx9DiAk79SNRo=
X-Received: by 2002:aca:530c:: with SMTP id h12mr4567158oib.110.1573211112276;
 Fri, 08 Nov 2019 03:05:12 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Nov 2019 12:05:01 +0100
Message-ID: <CAJZ5v0hTxyzNAyEeeZfqu1XNcFY9mYeft9EnAP+zD6s7x0Csqg@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.4-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.4-rc7

with top-most commit c31432fa7f825de0e19838f1ac7746381c509ec4

 cpufreq: intel_pstate: Fix invalid EPB setting

on top of commit a99d8080aaf358d5d23581244e5da23b35e340b9

 Linux 5.4-rc6

to receive a power management fix for 5.4-rc7.

This fixes an "unchecked MSR access" warning in the intel_pstate
cpufreq driver (Srinivas Pandruvada).

Thanks!


---------------

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Fix invalid EPB setting

---------------

 drivers/cpufreq/intel_pstate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

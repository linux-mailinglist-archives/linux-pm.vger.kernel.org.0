Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26496872BA
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 09:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405637AbfHIHKJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 03:10:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33292 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405601AbfHIHKJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 03:10:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so4586320pgn.0;
        Fri, 09 Aug 2019 00:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HPwG7pkcc5DZ98Mz2Gg0sM/TpTfIkaOBCUuZftqf1/w=;
        b=VD+Ar1DIRNtDCEqE2Yx4SwfjH51ak++dbdeaIqAr4Dwa/udxcfurZPOEeYFRIVL0qL
         ol6/odHAXtRsHeVmgEfNubI3Tckewc6r6ZaiGry0fgOC72HS0pNdgQRabl+xjYJAXS/7
         AXmRHh72D4ZVst+BzEQfkfihNv+Z1J/QKZvpPylay0xtN3VGzhqeRCuTs+bZjoC5VGNl
         ShkKFVAYMe5BOIBXtriMkuNzF3iU5pQo/SFNiJoKZLxmlD2TT4EpWevxvtQTUJ8szD69
         mBBjrAfRenCRvuk/iZHlaS9y/lGDRIgxrJH14vbALQD0jZiTvA7YjUtRy9vdAqZvfV6H
         qjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HPwG7pkcc5DZ98Mz2Gg0sM/TpTfIkaOBCUuZftqf1/w=;
        b=SovMV8+a5Tgqpz0Qld1iJKYRw9B4s5m92Wg52ZUyT/NE6OiqumV2Z8Bkl9LKAjxLkw
         /anzKkMCXCKlmIp0c0OObAa0FPbY+6+vZ/Iqc88ka2UgS2MLdd71fgdWIzw/GHKfbhCY
         dAgg6OyCO1WfyqLoJlrdzIVUZDtkcjDBBfrVlRukbWDkDjgrOYh9R2wXDgimt02KGKN9
         h5ljGktAH1Jp24OGu7rsWfYbzMA8Fwjd4Vwysu7JxSSsFcygavt/R7ff0/h4uYUS0naN
         NjxlyJvB2locebFuS+zx0H9qmUcR0Q5GlQ2aodLPhL1G/7qLUTz/aBYpHT1LwANDwjLG
         Db+Q==
X-Gm-Message-State: APjAAAXQJtahMYSRHzW539caA95zS5pHPjiiYNvSBkaRbqndhxrcjngp
        GUklpu0esD9fvBuWHP9OtM4=
X-Google-Smtp-Source: APXvYqx8b9QDL7gRE+a7XxAMhAJCg1WcAncDZoI70N/8WLtTRd1kO2iLQoNjxiNy3Te275dWnJSgTA==
X-Received: by 2002:a17:90a:1c17:: with SMTP id s23mr8029916pjs.108.1565334608346;
        Fri, 09 Aug 2019 00:10:08 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id e7sm215529pfn.72.2019.08.09.00.10.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 00:10:07 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jessica Yu <jeyu@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-pm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v4 0/8] Replace strncmp with str_has_prefix
Date:   Fri,  9 Aug 2019 15:10:00 +0800
Message-Id: <20190809071000.17059-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The commit 72921427d46b
("string.h: Add str_has_prefix() helper function")
introduced str_has_prefix() to substitute error-prone
strncmp(str, const, len).

strncmp(str, const, len) is easy to have error in len
because of counting error or sizeof(const) without - 1.

These patches replace such pattern with str_has_prefix()
to avoid hard coded constant length and sizeof.

Besides, str_has_prefix() returns the length of prefix
when the comparison returns true.
We can use this return value to substitute some hard-coding.

Changelog:

v1 -> v2:
  - Revise the description.
  - Use the return value of str_has_prefix() to eliminate
    hard coding.
  - Remove possible false positives and add newly detected
    one in upstream.

v2 -> v3:
  - Revise the description.
  - Remove else uses in printk.c.

v3 -> v4:
  - Eliminate assignments in if conditions.

Chuhong Yuan (8):
  dma: debug: Replace strncmp with str_has_prefix
  module: Replace strncmp with str_has_prefix
  PM/sleep: Replace strncmp with str_has_prefix
  printk: Replace strncmp with str_has_prefix
  reboot: Replace strncmp with str_has_prefix
  sched: Replace strncmp with str_has_prefix
  userns: Replace strncmp with str_has_prefix
  watchdog: Replace strncmp with str_has_prefix

 kernel/dma/debug.c       |  2 +-
 kernel/module.c          |  2 +-
 kernel/power/main.c      |  2 +-
 kernel/printk/braille.c  | 15 +++++++++++----
 kernel/printk/printk.c   | 22 ++++++++++++++++------
 kernel/reboot.c          |  7 +++++--
 kernel/sched/debug.c     |  6 ++++--
 kernel/sched/isolation.c | 11 +++++++----
 kernel/user_namespace.c  | 20 ++++++++++++--------
 kernel/watchdog.c        |  8 ++++----
 10 files changed, 62 insertions(+), 33 deletions(-)

-- 
2.20.1


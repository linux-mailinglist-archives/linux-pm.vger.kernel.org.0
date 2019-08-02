Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43E0A7E79A
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2019 03:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbfHBBqm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 21:46:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44849 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731827AbfHBBqm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 21:46:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so35075850pfe.11;
        Thu, 01 Aug 2019 18:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wLrJwcUbAlAZBvbLYx5iZ6fkS9RVbU5U/+b/jH7b5PI=;
        b=dEBoBePzfzEAhlohTUW9iv6gMd3sE9fXz9Wn6KwHsE/wNdj6o4DM9/n8xD0pqwaxmx
         PJCtAfjmOuT90vUfaVevnw8d9x7lGTb+5EtyWtxhUrLdxMxuU8UjO63cjpfLE31IXkUQ
         b+KcYlMnDTTU3qYOZW7engjNYstR37BH6FxddN9NGyo0MMumNcvaWGSFMfQTDBD7veAS
         sN3IaDtkz5/7FatGlRuJtOjtrXXUOJ3t9MMUQEV83ZS7QWeMEDL2excVRKfDm9bFwz/q
         2IHO5ncJfLyVGkhJBAeDJOwIjai9euQmFI2c6g2k835SKCIAte4uf9meWK81ogfW8yT1
         UoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wLrJwcUbAlAZBvbLYx5iZ6fkS9RVbU5U/+b/jH7b5PI=;
        b=Q/VSFnsGFc+OlxqZrH3XOvhLGka4GEhVS1e+moXyj2p8W4EtL/t+WMakkDl6/4fsaB
         Wx+C6V1ny75DdxdlMV8BaMj+xBo1psTaVm9NNARBvpuWw0PPqDx7Kw53GHGX6B5K4spB
         xedhSNexWdZDQWCnORoXl9CLDIqPVzEORQ+5MY+eS1BqSGvcstsLh5LiPVcNoDdbwZ32
         CrK6GDAEUdR3xZGQz7diOnGEwNz5Z69pqk0oR3PQ9BOG+7Br2SmJQ7bYs6qtnRes/usB
         eY12/KR6NwkDc5VI5jzhIw08AX74mzn7S5yH0/S7hu/kcBnyv9+k2fkgEXqzDDG2/6tI
         /EfA==
X-Gm-Message-State: APjAAAW8nFZ4YNeEmZ5BrPJ7c6So++xwipc09SMxa7HeyoYdjrq1SddV
        ecfwMddkK5FHNssvPWknA3w=
X-Google-Smtp-Source: APXvYqyz72H3jw23ZXyhl3tD28HFBu/J0BdHnsqDx2ZON6i6f+7lLXHmHArzMJBLvP1GkXbUCBbFxg==
X-Received: by 2002:a63:5550:: with SMTP id f16mr10691565pgm.426.1564710401658;
        Thu, 01 Aug 2019 18:46:41 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id r15sm79474631pfh.121.2019.08.01.18.46.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 18:46:40 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Jessica Yu <jeyu@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-pm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2 00/10] Replace strncmp with str_has_prefix
Date:   Fri,  2 Aug 2019 09:46:18 +0800
Message-Id: <20190802014617.8623-1-hslester96@gmail.com>
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

Chuhong Yuan (10):
  dma: debug: Replace strncmp with str_has_prefix
  gcov: Replace strncmp with str_has_prefix
  locking/locktorture: Replace strncmp with str_has_prefix
  module: Replace strncmp with str_has_prefix
  PM / sleep: Replace strncmp with str_has_prefix
  printk: Replace strncmp with str_has_prefix
  reboot: Replace strncmp with str_has_prefix
  sched: Replace strncmp with str_has_prefix
  userns: Replace strncmp with str_has_prefix
  watchdog: Replace strncmp with str_has_prefix

 kernel/dma/debug.c           |  2 +-
 kernel/gcov/fs.c             |  2 +-
 kernel/locking/locktorture.c |  8 ++++----
 kernel/module.c              |  2 +-
 kernel/power/main.c          |  2 +-
 kernel/printk/braille.c      | 10 ++++++----
 kernel/printk/printk.c       | 14 ++++++++------
 kernel/reboot.c              |  6 ++++--
 kernel/sched/debug.c         |  5 +++--
 kernel/sched/isolation.c     |  9 +++++----
 kernel/user_namespace.c      | 10 +++++-----
 kernel/watchdog.c            |  8 ++++----
 12 files changed, 43 insertions(+), 35 deletions(-)

-- 
2.20.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A1181910
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 14:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfHEMWT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 08:22:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41924 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHEMWS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 08:22:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so36281705pls.8;
        Mon, 05 Aug 2019 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEWoK/ncnnL5HeoDBfuY5M1+24Qlh2DA31rCewI/52E=;
        b=p6Z3kfl4eEvXmrZiU9Y687TE0tfxSww44x8bZWTyiuM1Kk4+Ls0NTJ67ignEqCsb8V
         qFoXvj+B7+OYXH5/sjVkWdJMQWfVVVxqkBrItVYnnYbjuQruh8Pd55RQm7Gf3vIwN4pj
         qvFF+yNwQbDj6TRhMxwvFnYifcpkdEi0xX3oWKOj8LdlE6VWvZniE5rgSbC33RSHiq4p
         7ji9b3MO2QrjgFvyBkTOmN49Uh9HswzgDWNIntCDXWJkN7bXuY50icgNCxMwWIO5O1uq
         QDRhnwKy2BjH/9Q8ZEHjRSSsJ4pjm1yh0yC14L22KF3amQ9pxCsB+WlNpVLLiEgmX7It
         MkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEWoK/ncnnL5HeoDBfuY5M1+24Qlh2DA31rCewI/52E=;
        b=N9W5HPJJ297AYWdM5eOJqTaUXyFm9kJdiLc9mcYtbErl/hoMMicZojooQ6m/6fGFSA
         uZ1go1CjdHMhw/87cQvJdwDqXjbKBdaivkX1AGAEt6wKz72dF4RZZfMEwnrXFatPAa4J
         brKm4mI+Fd191YDJyF5jpMvj/OQu5IW08LpNK9mz2ZSclugJ7Aa0k8h6BowWlES0vDPe
         GRvFoJrA9FVvMbrsRQk0DsdojYOBbb0/nBi+McO7s1cVhKdJMU3WnJA7uET8qm5nvJoD
         vLdUzThvhZylc1frWuNQ7YOtCYfgygSkz5mveppbDXTncyuPCNTIfdjiDJDhnnZrTTaF
         mmMQ==
X-Gm-Message-State: APjAAAUW+rYMai3yN96EcMV3a3RgYVnYEeWT8ygBws+DyZrO+FmlKYI2
        rU0DNa8sFURT3Av52OWsHyA=
X-Google-Smtp-Source: APXvYqyKEfTE85E4XHkXoQNUJWBl4w/9gg2ux5fA/09qhCairbUTm2pP4GaeK6Zg8ntOYFTPUxt7kQ==
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr139369488plb.139.1565007738273;
        Mon, 05 Aug 2019 05:22:18 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id a16sm92646276pfd.68.2019.08.05.05.22.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 05:22:17 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jessica Yu <jeyu@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Perches <joe@perches.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        iommu@lists.linux-foundation.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v3 0/8] Replace strncmp with str_has_prefix
Date:   Mon,  5 Aug 2019 20:22:04 +0800
Message-Id: <20190805122204.12823-1-hslester96@gmail.com>
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
 kernel/printk/braille.c  | 10 ++++++----
 kernel/printk/printk.c   | 19 +++++++++++++------
 kernel/reboot.c          |  6 ++++--
 kernel/sched/debug.c     |  5 +++--
 kernel/sched/isolation.c |  9 +++++----
 kernel/user_namespace.c  | 10 +++++-----
 kernel/watchdog.c        |  8 ++++----
 10 files changed, 43 insertions(+), 30 deletions(-)

-- 
2.20.1


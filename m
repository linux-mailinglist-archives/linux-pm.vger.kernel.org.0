Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BED3E2F0B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 19:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242112AbhHFR5H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 13:57:07 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:39902 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbhHFR5H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Aug 2021 13:57:07 -0400
Received: by mail-ot1-f44.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso9829745otq.6;
        Fri, 06 Aug 2021 10:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=577vfbAoSijgmcE4GmYPM0NJ6hQ7vUCyHwxoobFddU8=;
        b=JOuNds/GXuXDU2xzbknAmcelxDrabc27PP70GTsTvdbiYpZ6Vdwnb5zuQBDzADkPsI
         P1u17+JTe2QKL+aqqXHKrUHS4bEeLptWMvuzX2FakaPBDAbVmFqHIl30+rr0722gPl63
         a0VMPfs/9tvQylBW5Bwd2BoTHF/CXBVm2aBySE6yrtY7PgsXZvVQi41/BvrmnoRzuwTP
         dhM/SmwaqhGQHxb4Ja/3ZWqCaEQodIuUd78bzK9teSm+24VLJ8iA3wlzw/9IT57ZACjn
         E8xplgNMpBg9fqsR5WWfIQqxH5NTNNMM15FCPRo4cdfhArp1NetYwqS9qiBfQnN/6wf/
         XMqg==
X-Gm-Message-State: AOAM530fPSL+YYr5fqK+XdSQE5x///oAlFkLIS3C+7whOtcKsb3cnif3
        Z0gvp0fuGAw3WFWjv+jyy7+XfO1v9UxEXyJ3R4H7gS41kaQ=
X-Google-Smtp-Source: ABdhPJyDauh3wSg/0kcH0FGbxcO9mB4Aemh5mUJPsOnopPDb6zlDY8dJcu0JTx4nxvghdGYfS/WdcDiE1eGJdgDQLuU=
X-Received: by 2002:a05:6830:1f59:: with SMTP id u25mr8579754oth.321.1628272610281;
 Fri, 06 Aug 2021 10:56:50 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 Aug 2021 19:56:39 +0200
Message-ID: <CAJZ5v0jUHUByXOpDKgKeEJzwDq7eE36sP9sVdRJn7jMBSneTMw@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.14-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.14-rc5

with top-most commit 4adae7dd10db10f20f51833dc11b3cf7a342ad38

 cpuidle: teo: Rename two local variables in teo_select()

on top of commit c500bee1c5b2f1d59b1081ac879d73268ab0ff17

 Linux 5.14-rc4

to receive power management fixes for 5.14-rc5.

These fix a recent regression in the timer events oriented (TEO)
cpuidle governor causing it to misbehave when idle state 0 is
disabled and rename two local variables for improved clarity
on top of that.

Thanks!


---------------

Rafael J. Wysocki (2):
      cpuidle: teo: Fix alternative idle state lookup
      cpuidle: teo: Rename two local variables in teo_select()

---------------

 drivers/cpuidle/governors/teo.c | 48 ++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 17 deletions(-)

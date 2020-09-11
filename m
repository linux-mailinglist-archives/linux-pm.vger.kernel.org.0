Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC26266457
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 18:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgIKQg3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 12:36:29 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33179 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgIKPOz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2020 11:14:55 -0400
Received: by mail-ot1-f68.google.com with SMTP id m12so8656458otr.0;
        Fri, 11 Sep 2020 08:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aMmfzDJqgpNrWgPb0hQzPYfkLxYcxMPt+xFm1HcIqzI=;
        b=dah/j5ypaVWUUKW8BBup8/IUwP/WtapQLGl3m4w/x0nNeaHXTVi95RIobHmnMHTDq9
         3Nblq7mFJvR7irD1gCdtdy8Rjelu71PsKGSegHGn3v4+1D4NE4hG0Rc1e3MO8UIBPwtW
         mVhW3KgdbIQ1VJ8a4vqRcGttKU6Kn6CiR8vQ0Uz1WPPYudVmMRfPKo+iVdo+dUX31TQ8
         cTWXf5T8RXjY8glKHTDkarL/vxyxOJe5stEhCVlLw/UE5t7kWXDb4Wf4rq9lKpruKKAR
         7RubIF7v3HeIcjVAMN8KMqaS1ZyfM4+5+KIg6e3I03s9/JgotTN3pGJyvzcuX45tdHxH
         9WDw==
X-Gm-Message-State: AOAM532gjCD6mj3xa8hX8xEmEn/g37Gd/FC3DWmqoyItIomxii59mHfE
        CRFSpaz3ZF5LrUxliWdXohRtk0AJUGvLPbEMRVFsJ51jYOg=
X-Google-Smtp-Source: ABdhPJxx3QVjtIlHHmaRr+FIyCSanSv+NHluSyI7EbqSdQdh1eTL6q1Ds6lIG1SyGm3w/AYvLlR/UPmAAwOAlzy3MVc=
X-Received: by 2002:a9d:6010:: with SMTP id h16mr1499403otj.262.1599837244523;
 Fri, 11 Sep 2020 08:14:04 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Sep 2020 17:13:53 +0200
Message-ID: <CAJZ5v0jYBQ792GmDYMYOzxbmJC7HYzZFfQ4JR8LxDR=0goQ1_Q@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.9-rc5
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
 pm-5.9-rc5

with top-most commit d64e6906d188f0ba6a4f82b3f42e0bd0598183fa

 Merge branch 'powercap'

on top of commit f4d51dffc6c01a9e94650d95ce0104964f8ae822

 Linux 5.9-rc4

to receive power management updates for 5.9-rc5.

These fix three pieces of documentation and add new CPU IDs to the
Intel RAPL power capping driver.

Specifics:

 - Add CPU IDs of the TigerLake Desktop, RocketLake and AlderLake
   chips to the Intel RAPL power capping driver (Zhang Rui).

 - Add the missing energy model performance domain item to the
   struct device kerneldoc comment (Randy Dunlap).

 - Fix the struct powercap_control_type kerneldoc comment to match
   the actual definition of that structure and add missing item to
   the struct powercap_zone_ops kerneldoc comment (Amit Kucheria).

Thanks!


---------------

Amit Kucheria (1):
      powercap: make documentation reflect code

Randy Dunlap (1):
      PM: <linux/device.h>: fix @em_pd kernel-doc warning

Zhang Rui (3):
      powercap/intel_rapl: add support for TigerLake Desktop
      powercap/intel_rapl: add support for RocketLake
      powercap/intel_rapl: add support for AlderLake

---------------

 drivers/powercap/intel_rapl_common.c |  3 +++
 include/linux/device.h               |  1 +
 include/linux/powercap.h             | 11 +++++------
 3 files changed, 9 insertions(+), 6 deletions(-)

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64011EA781
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 18:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgFAQGs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 12:06:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55314 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgFAQGr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2020 12:06:47 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jfmxY-0006s5-WA
        for linux-pm@vger.kernel.org; Mon, 01 Jun 2020 16:06:45 +0000
Received: by mail-wr1-f70.google.com with SMTP id l18so191595wrm.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2020 09:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bpQ13/Tb/1v9ESSJdhnUaEx5I/MEIqhF5at0rFUACNM=;
        b=T6SoTxb/tVzLhJGCN7clVPmqm9scyJo+rOgVDE6pbyiC+nPxLrrNgDjNPLpf9Wy8UY
         YU7Nv47cVWVYPocQ6QgIBQI2/CKKckLO5lEYs/E0V18fQ5JfANPKcRtDbBF5V9i2V4Yc
         JKANbsGv5qK5LbgUxuhI8gQ3kTUd/KTMmHKwmBC2fSg4YkNQoB3x7grkj5k0JSQu8rM9
         K9rN8P4ZPZeq3BbFn/1SDo2nVjgieWp7UKs+RM8CG4f57nWK4vnGRynabdemQZ4a6ki+
         Pnv1/0Zd7jaz2gyLLjkOxwviljv58t8vSbIM9+3pwhx+s9V1gyVtLGnz9i1FWqk63ytk
         aCSA==
X-Gm-Message-State: AOAM531cqurWJ1RNoJTZ0Bw2JC3e+yGtpjn7HvGb0zsvreNz8QD/udMw
        2A2X4146gp777VpxidH3jJiQxCIggrRUC4We39XfQ1MsvpuI/N/4+dCWQJTyK0GWbUOyLLyb50G
        +Z1Ukkg/UPwGPYpPpie6n+ZY7nFKO1fgVFeb7
X-Received: by 2002:adf:dc42:: with SMTP id m2mr11722685wrj.342.1591027604647;
        Mon, 01 Jun 2020 09:06:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtIARnKWstXAKhlHKQE+KOrbq5RT+XW8IL/zXgEDl3x/r+gjZRu4PbPN3pWQtFh7apH9Bo4w==
X-Received: by 2002:adf:dc42:: with SMTP id m2mr11722665wrj.342.1591027604369;
        Mon, 01 Jun 2020 09:06:44 -0700 (PDT)
Received: from xps-13.homenet.telecomitalia.it (host105-135-dynamic.43-79-r.retail.telecomitalia.it. [79.43.135.105])
        by smtp.gmail.com with ESMTPSA id k16sm19719262wrp.66.2020.06.01.09.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 09:06:43 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] PM: hibernate: opportunistic memory reclaim
Date:   Mon,  1 Jun 2020 18:06:34 +0200
Message-Id: <20200601160636.148346-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Here is the first attempt to provide an interface that allows user-space
tasks to trigger an opportunistic memory reclaim before hibernating a
system.

Reclaiming memory in advance (e.g., when the system is idle) allows to
reduce the size of the hibernation image and significantly speed up the
time to hibernate and resume.

The typical use case of this feature is to allow high-priority cloud
instances to preempt low-priority instances (e.g., "spot" instances [1])
by hibernating them.

Opportunistic memory reclaim is very effective to quickly hibernate
instances that allocate a large chunk of memory and remain mostly idle
for the majority of the time, only using a minimum working set.

This topic has been mentioned during the OSPM 2020 conference [2].

See [RFC PATCH 2/2] for details about the proposed solution.

Feedbacks are welcome.

Thanks,
-Andrea

[1] https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-spot-instances.html
[2] https://lwn.net/Articles/821158/

----------------------------------------------------------------
Andrea Righi (2):
      mm: swap: allow partial swapoff with try_to_unuse()
      PM: hibernate: introduce opportunistic memory reclaim

 Documentation/ABI/testing/sysfs-power | 38 ++++++++++++++
 include/linux/swapfile.h              |  8 +++
 kernel/power/hibernate.c              | 94 ++++++++++++++++++++++++++++++++++-
 mm/swapfile.c                         | 45 ++++++++++++++---
 4 files changed, 176 insertions(+), 9 deletions(-)


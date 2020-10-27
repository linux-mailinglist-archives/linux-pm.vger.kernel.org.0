Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6176C29A56F
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 08:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgJ0HYJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 03:24:09 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:34921 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507521AbgJ0HYJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 03:24:09 -0400
Received: by mail-yb1-f202.google.com with SMTP id b25so491931ybj.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2020 00:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=kqo5gmOuIUzH6rrL+KlWEsG4rVOW760GLWoKfNL/7PI=;
        b=voBA9S+FDTWKGqPNJw5H8sWZAcAT2Zwu2OMyafzgRdhSWWgLHOhe9PlF/NPgIpBj/u
         3cUWs8+C+LpKoaaxhSp9RPwm9oSSRkrcsaAAN/np2YaV8Z8SpY7OgDz1e7P76F76Q2iV
         zeFtZnml2WkjrTz8+DqcY/HLrfJtMQigZKoAswNvkBFJlwagyy7q4uO2vkbBZ/JbASsn
         4uTrMeNvcXwm22j3pfZxir7VqR4vGACxaHpaWeclNNhFvnl9itMoSwnhif8K/JwGIYg3
         I2Bf78Ea/gF9nZaXvDd688zMH4Q0O/NBdAZbxLT3OceIoG+7qxqjF/1HAg6K2xQ8Y3Za
         UxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=kqo5gmOuIUzH6rrL+KlWEsG4rVOW760GLWoKfNL/7PI=;
        b=p8tesOEaIUKPrBdIlH4XoGAeto3pLIziQ9K0Pm31peSe+C9a+3cfBjNQ9gs4qVr6D2
         JO0hakKMJAXvkkx202woEbqLetuk4ivLMBpscJjpuFk+/yzwQ2415YHc4lklm0Ap8Cr1
         0RcnGhCDnxdYKAbrrirFCuU6/ke8u5tml6GQf9BtYcgKpbRYEVwYKDYODqcIe3ih6hbU
         TJr8GgCQqIqql040t02fAmfDnkK9AXmqK6+ao6Y5DODC068wDznTp0iIz4qmhcbX7Hvp
         DnqXUzyxG4uT8N1o5dEOzER0lNWTUSttd4u4EK8vvQDoh2275TA6OqFFXaYCisxLw17w
         eHiQ==
X-Gm-Message-State: AOAM533dZ+Zfv2M1NM5iul1jASU2hHXEzr0bp1atUsnXtWk0j8SHMGCK
        2Urnv8DY1m3etwfIA7FECTjnANixOxMleViz
X-Google-Smtp-Source: ABdhPJzQlpampx1oIH8MR7GSaIiCwZ05+fkPNH8ID+XWI5/zjOSpROql0teRhz3Fe/NzcWSiv7wOVNDD6dl6jc4P
Sender: "victording via sendgmr" <victording@victording.syd.corp.google.com>
X-Received: from victording.syd.corp.google.com ([2401:fa00:9:14:f693:9fff:fef4:fa73])
 (user=victording job=sendgmr) by 2002:a25:b126:: with SMTP id
 g38mr1497239ybj.36.1603783446520; Tue, 27 Oct 2020 00:24:06 -0700 (PDT)
Date:   Tue, 27 Oct 2020 07:23:53 +0000
Message-Id: <20201027072358.13725-1-victording@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH v3 0/4] powercap: Enable RAPL for AMD Fam17h and Fam19h
From:   Victor Ding <victording@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Victor Ding <victording@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch series adds support for AMD Fam17h RAPL counters. As per
AMD PPR, Fam17h and Fam19h support RAPL counters to monitor power
usage. The RAPL counter operates as with Intel RAPL. Therefore, it is
beneficial to re-use existing framework for Intel, especially to
allow existing tools to seamlessly run on AMD.

From the user's point view, this series enables the following two sysfs
entry on AMD Fam17h or Fam19h:
  /sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj
  /sys/class/powercap/intel-rapl/intel-rapl:0/intel-rapl:0:0/energy_uj

Changes in v3:
By Victor Ding <victording@google.com>
 - Rebased to the latest code.
 - Created a new rapl_defaults for AMD CPUs.
 - Removed redundant setting to zeros.
 - Stopped using the fake power limit domain 1.

Changes in v2:
By Kim Phillips <kim.phillips@amd.com>
- Added the Fam19h patch to the end of the series
- Added my Acked-by
- Added Daniel Lezcano to Cc
- (linux-pm was already on Cc)
- (No code changes)

Kim Phillips (1):
  powercap: Add AMD Fam19h RAPL support

Victor Ding (3):
  x86/msr-index: sort AMD RAPL MSRs by address
  powercap/intel_rapl_msr: Convert rapl_msr_priv into pointer
  powercap: Add AMD Fam17h RAPL support

 arch/x86/include/asm/msr-index.h     |  3 +-
 drivers/powercap/intel_rapl_common.c |  7 ++++
 drivers/powercap/intel_rapl_msr.c    | 51 ++++++++++++++++++++--------
 3 files changed, 45 insertions(+), 16 deletions(-)

-- 
2.29.0.rc2.309.g374f81d7ae-goog


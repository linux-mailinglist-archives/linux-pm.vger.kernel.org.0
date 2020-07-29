Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A3B231CF0
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 12:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgG2KwR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 06:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgG2KwQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 06:52:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F62C061794
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 03:52:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w11so3399333ybi.23
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 03:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vSliGyBZQKvlS0+61F1LBEoXAn3W7oNlUuyzH64gKZ4=;
        b=s6Br/iSuLIwOpryZlHRvpGvDbfddkW4PyoYgVr62dENEn+ac9CFU44qiia+IbgSEVW
         Nnl2wQRXJsTqxLwAfcFWiLOu/yWLP+ryfzxB/x6ztWI2jsOZ2w70YbEfNh/6A6d4PhZ/
         iMa2jkRQI8v9AfXr4C4y+07e1kKSuqHiyyRipNRzRNbeFAHK125rhYPIgBjRIyHWksfL
         /3T7oqq34vijYmj83jeDTWOhwBWPvdFdrUsUvLosJNgnfy84Sh0fLDpjnMAZowz70BGS
         fNni7Bnbk4PhkrdtAGdDO3uEUcN5KkA1icjYpeJh4rtHh86E6BobzTJydAOJUiwR86wo
         WMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vSliGyBZQKvlS0+61F1LBEoXAn3W7oNlUuyzH64gKZ4=;
        b=fWrTU1o9pj9V7uIRSGtVYFsXIK7T2jgOMEF2g2NGl+Rcu42nku6wlb399AiGbI+Pia
         G0y05K0MFpuaWFUBM1hmdxgf7bMGgsKqR5WYfXSdeHD8J2HcQfP1OnEbfPENbqCeLd3w
         NaOdf45cowRj2GW6xy/a1Kr+f6oI2sbzxqnSAoJELdX9ZeKJi38tr31R7gsiYUn40jKL
         afm6hSdorXsfQBrAbys8kIyXwmkyIgjIMfKOXAxM5LWbLwTDeKtA5wBypuDYI4ybnKjW
         fv6fmzgX+YKvGNPSlbAWxbVZr/wneojMkIvuA3I59bUP0Hvr8VNBUfwcBkW3K8fFpvU0
         uz2g==
X-Gm-Message-State: AOAM531AYbmhWa5u2XASDQsXp34E3k6uO6EixZM9w6/qpDLD6cNVFhh5
        m+kEgWfyqEVyVA0dBs1shChppjsz/EySS68a
X-Google-Smtp-Source: ABdhPJzk4f0duQ0J4jmHCNnomr0GLgR7krVV4GTA4+LU/ZyuMeFIRYgUpNVsZX0U8Ck588k2y4lL6X82dJhicAgI
X-Received: by 2002:a25:4945:: with SMTP id w66mr50685406yba.285.1596019935958;
 Wed, 29 Jul 2020 03:52:15 -0700 (PDT)
Date:   Wed, 29 Jul 2020 20:52:03 +1000
Message-Id: <20200729105206.2991064-1-victording@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH 0/3] powercap: Enable RAPL for AMD Fam17h
From:   Victor Ding <victording@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Victor Ding <victording@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Beulich <jbeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        linux-pm@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch series adds support for AMD Fam17h RAPL counters. As per
AMD PPR, Fam17h support RAPL counters to monitor power usage. The RAPL
counter operates as with Intel RAPL. Therefore, it is beneficial to
re-use existing framework for Intel, especially to allow existing tools
to seamlessly run on AMD.

From the user's point view, this series enables the following two sysfs
entry on AMD Fam17h:
  /sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj
  /sys/class/powercap/intel-rapl/intel-rapl:0/intel-rapl:0:0/energy_uj


Victor Ding (3):
  x86/msr-index: sort AMD RAPL MSRs by address
  powercap/intel_rapl_msr: Convert rapl_msr_priv into pointer
  powercap: Add AMD Fam17h RAPL support

 arch/x86/include/asm/msr-index.h     |  3 +-
 drivers/powercap/intel_rapl_common.c |  2 +
 drivers/powercap/intel_rapl_msr.c    | 58 +++++++++++++++++++++-------
 3 files changed, 47 insertions(+), 16 deletions(-)

-- 
2.28.0.rc0.142.g3c755180ce-goog


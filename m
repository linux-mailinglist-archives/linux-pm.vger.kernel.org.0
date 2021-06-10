Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E40C3A26ED
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 10:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhFJI1V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 04:27:21 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:40647 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhFJI1S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 04:27:18 -0400
Received: by mail-pg1-f181.google.com with SMTP id j12so21987523pgh.7
        for <linux-pm@vger.kernel.org>; Thu, 10 Jun 2021 01:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dx3LD+QONQZ90XyumvQYMedCFWUAyiq58QYIKI9G5zg=;
        b=P2q0IrTnZYJcNJxgCNUHZgCPckId6L8Xpz9JvHK94UQxbHTBsvAoHdRevTah0jtZ3C
         DCZ6YmT9q2kBAB7ezTldLlg1d+TpPCX4gGqUxhneVHoJ49Uc/el/KNIL60EsASs+ZlNC
         JEDN6py3rNeV5OcXFDOtSDN0tP/JK+MbjrpCq1S4hdgRmboCcjRNphTQdxRzsuiHmmb5
         yfyQl++2mNNsb7k2L/BGPE9wUTxeN1Nskrt0HKrJjII+LfLXiGwuZz6Vu3TTHIMFcgAB
         Wmy5LLcTK/ZMpMXPY4uhxUvBaF/ddyPrNPoR0AcOk9q9cdPYIl8Yze1Zad+LaPa2WcsZ
         4aiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dx3LD+QONQZ90XyumvQYMedCFWUAyiq58QYIKI9G5zg=;
        b=oJShm/I/CXw9KBQHlmUlc57o9cEJHNEIThl3esVZHmds6gePBfpBGGdfzPT08mSjCi
         Lywn9MI4sP6EUujrxmIjFum3BFAgE4eArqut/LcVye08+uBf6Ks6s/n4mDhpbyJyaXBL
         qI9/U5Rf+0NGZNeFMqhQEgF6s7ywNzhXGpffLdm9YiPrRzwLu+AlfFL+d8Zhgt9Ls5nK
         TdmPTjZVMOEpcArHtA6F92dK0nvvSJCVLGNQH4pipp10LkZneqFGNZfE+d9uMv0baiyi
         hWuSYoKrenFDqBiYIYo5d3S0kB6TOrUkCFXLE9bBzA8+b5YcfvMWzkZ2Br9SCqQukaaj
         dNCw==
X-Gm-Message-State: AOAM532JxE5VtAMLJTNi10yKotCfoBXqX6fPtIlXuGpsqtYRU9Ah/A/+
        10DvocPe61PR0oPg3JzzW5E7Mg==
X-Google-Smtp-Source: ABdhPJyi+O4KwGPfvZR518NR4+exaoYeuUIiRL46B3bKaN8ChQ5bmYUKDSfTaz+qd2RgLjB3qxti9A==
X-Received: by 2002:aa7:8888:0:b029:2ec:763f:4bcc with SMTP id z8-20020aa788880000b02902ec763f4bccmr1846743pfe.35.1623313448946;
        Thu, 10 Jun 2021 01:24:08 -0700 (PDT)
Received: from localhost ([136.185.169.128])
        by smtp.gmail.com with ESMTPSA id h7sm1739207pfe.62.2021.06.10.01.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 01:24:08 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dirk Brandewie <dirk.j.brandewie@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/5] cpufreq: cppc: Fix suspend/resume specific races with FIE code
Date:   Thu, 10 Jun 2021 13:53:56 +0530
Message-Id: <cover.1623313323.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Qian,

It would be helpful if you can test this patchset and confirm if the races you
mentioned went away or not and that the FIE code works as we wanted it to.

I don't have a real setup and so it won't be easy for me to test this out.

I have already sent a temporary fix for 5.13 and this patchset is targeted for
5.14 and is based over that.

-------------------------8<-------------------------

The CPPC driver currently stops the frequency invariance related
kthread_work and irq_work from cppc_freq_invariance_exit() which is only
called during driver's removal.

This is not sufficient as the CPUs can get hot-plugged out while the
driver is in use, the same also happens during system suspend/resume.

In such a cases we can reach a state where the CPU is removed by the
kernel but its kthread_work or irq_work aren't stopped.

Fix this by implementing the start_cpu() and stop_cpu() callbacks in the
cpufreq core, which will be called for each CPU's addition/removal.

A similar call was already available in the cpufreq core, which isn't required
anymore and so its users are migrated to use exit() callback instead.

This is targeted for v5.14-rc1.

--
Viresh

Viresh Kumar (5):
  cpufreq: cppc: Migrate to ->exit() callback instead of ->stop_cpu()
  cpufreq: intel_pstate: Migrate to ->exit() callback instead of
    ->stop_cpu()
  cpufreq: powerenv: Migrate to ->exit() callback instead of
    ->stop_cpu()
  cpufreq: Add start_cpu() and stop_cpu() callbacks
  cpufreq: cppc: Fix suspend/resume specific races with the FIE code

 Documentation/cpu-freq/cpu-drivers.rst |   7 +-
 drivers/cpufreq/Kconfig.arm            |   1 -
 drivers/cpufreq/cppc_cpufreq.c         | 163 ++++++++++++++-----------
 drivers/cpufreq/cpufreq.c              |  11 +-
 drivers/cpufreq/intel_pstate.c         |   9 +-
 drivers/cpufreq/powernv-cpufreq.c      |  23 ++--
 include/linux/cpufreq.h                |   5 +-
 7 files changed, 119 insertions(+), 100 deletions(-)

-- 
2.31.1.272.g89b43f80a514


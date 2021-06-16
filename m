Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A6C3A92E6
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 08:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhFPGnS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 02:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhFPGnH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 02:43:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91210C0613A4
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 23:40:33 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k22-20020a17090aef16b0290163512accedso3132042pjz.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 23:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ZiC6GECxJ5O7fmXBJLA01PVcumFVYCjotTKUnEvqAE=;
        b=j5nEWtGQ8e7L2j8MAdL8VNhwZHW7YbvwGKNbYTpaT4fT5y/uCH8RZAswlRUWfPHxv0
         PIhxhtmJkqTRIi1h6Y6H0yudszNUn9E1DN5YYqMBKkvVvvplj1qaEAhfpmXjEjatQ0vO
         rxcP980VoLdUqrzXUTTq879c0wb8Gq4fREWaBy9oA4H0KQWfYJUGdZqoDGmSk8WQqm4y
         gTOtbVlf5Elmy4z9Jah+NVKCUlCoZdJYhdtYnfhVAN2wrrerSR3Z7ywz56ta7BYlXi+5
         Q3BaY1HbaaTR3kt7lax0f+TxATdLDTONssXYcKshT+gNyvwFt8T+tOoIfSzcU1/GpDz5
         lreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ZiC6GECxJ5O7fmXBJLA01PVcumFVYCjotTKUnEvqAE=;
        b=f3hJ4ucJk7Xl45S66eLvHU9whqsQWNjPJ7+xQ+tn4UaLvTfhlGRB/V6H93/1SlevBE
         uF3MP6lQzmIsJ7QRP0mg2BZuQ8mrIhsRbprUBHgJ9bYP16C64T6Kbx38pWJbZq2A0iv6
         0nwQ3QCn+ZTY8usMUmYBFSKbQ+KrhdAkN0NaamyILVwTcJFBMBjWYSDhsfjbcNhVuqDc
         /nMvdsCLJBgzOuIfQQNFS/ebN1Y+iwOw7WgPwMBdx2txBrjV6sKDquha3ASURCsRV0DG
         5fsBrbbI/MrAuKiEO3zQQe/7SCwFgbNjLhN8rFclMgAYsTF09HtCRn3b93fFeRxf5CyY
         6Kkg==
X-Gm-Message-State: AOAM530tV6dvunHLSqwvllr2Erf2TVrY1wPw/NuGgNVDCQPBWGM6kZ31
        PWjfHUbb6Qd7/OOs42h7e5tA7A==
X-Google-Smtp-Source: ABdhPJxSyXLm1xOpMzrHEu55XT9R4v/JDtdpRRrJ7Z/jTDgNjDYRhgh55veskbKqtBCBtzm4Hx/9kw==
X-Received: by 2002:a17:90b:247:: with SMTP id fz7mr9072074pjb.137.1623825633079;
        Tue, 15 Jun 2021 23:40:33 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id x36sm1069608pfu.39.2021.06.15.23.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 23:40:32 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Len Brown <lenb@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dirk Brandewie <dirk.brandewie@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V2 0/3] cpufreq: Migrate away from ->stop_cpu() callback
Date:   Wed, 16 Jun 2021 12:10:25 +0530
Message-Id: <cover.1623825358.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Sending these separately from CPPC stuff to avoid unnecessary confusion and
independent merging of these patches. These should get in nevertheless.

commit 367dc4aa932b ("cpufreq: Add stop CPU callback to cpufreq_driver
interface") added the stop_cpu() callback to allow the drivers to do
clean up before the CPU is completely down and its state can't be
modified.

At that time the CPU hotplug framework used to call the cpufreq core's
registered notifier for different events like CPU_DOWN_PREPARE and
CPU_POST_DEAD. The stop_cpu() callback was called during the
CPU_DOWN_PREPARE event.

This is no longer the case, cpuhp_cpufreq_offline() is called only once
by the CPU hotplug core now and we don't really need two separate
callbacks for cpufreq drivers, i.e. stop_cpu() and exit(), as everything
can be done from the exit() callback itself.

Migrate to using the exit() callback instead of stop_cpu().

The stop_cpu() callback isn't removed from core as it will be reused in
a different way in a separate patchset.

--
Viresh

Viresh Kumar (3):
  cpufreq: cppc: Migrate to ->exit() callback instead of ->stop_cpu()
  cpufreq: intel_pstate: Migrate to ->exit() callback instead of
    ->stop_cpu()
  cpufreq: powerenv: Migrate to ->exit() callback instead of
    ->stop_cpu()

 drivers/cpufreq/cppc_cpufreq.c    | 46 ++++++++++++++++---------------
 drivers/cpufreq/intel_pstate.c    |  9 +-----
 drivers/cpufreq/powernv-cpufreq.c | 23 ++++++----------
 3 files changed, 34 insertions(+), 44 deletions(-)

-- 
2.31.1.272.g89b43f80a514


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76BE3FC266
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 08:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbhHaGAn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 02:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238470AbhHaGAn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 02:00:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA165C061575
        for <linux-pm@vger.kernel.org>; Mon, 30 Aug 2021 22:59:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id e16so13660397pfc.6
        for <linux-pm@vger.kernel.org>; Mon, 30 Aug 2021 22:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=b9OGeMyB8RoeFTfP33aJZL2Bo/kdCU6sSM8rp+lcdJg=;
        b=PZWS70RH6VCAV1XWb6ILurWrsIWobamRQY7xXcd8/To8ZCqzuGl66oib4Th1CKvXkz
         E860AZJw+8CEmPBsccIyTnfhBZbdmFrtJPQHy1aQrONaTYbVMEZ7VUtKmntFNNsEO6LW
         A/k9sgEbt5UGBiLUIZ9iWiDiyVHUsqbSWrP8nSmotblScQVTBELIjLlY4LpkatMnPnF9
         tbWk3XigO4t86oIC+bBH8VSLwDASoC9UG69MBwd9ARA1HQr7jz0lQof/I2P9Wu0KnZ/8
         Y7NAShNvfr70C1FB9DAAUHtG7xtUyKsXjAdoLhA6iIKzOyWZDW6JxNCE9FW+k6brWvhl
         1VXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=b9OGeMyB8RoeFTfP33aJZL2Bo/kdCU6sSM8rp+lcdJg=;
        b=QyGut3BuIv7Sl266dqTFmBbv4oUCWO+nBUHLxwxfdc02OWVNcleUBMTgo3kuqrmdlZ
         r65w8KoFCd3MAvMvVWvq0hF9IqSbM14SP9lowYgUMPTTkLPJXv6TMtAbkSwBF21lrRzK
         B3bMnw0UOSu5Qp2CmumVwogyhJgXiHkf3kdKNJIFr1Pq7aJH1fTdGVIibdCQy+Uo/nlW
         vl6FB26kyARPtd2ySk4pn30edU1z+sqialPYNVZoqUiiWd8WSAWCtSAMa+UjyADsKM7p
         NG9H7r6Bl2i65mf89ZEhUKmCCDXAqN77TCkimOjC/TD6uRKlfULiMBKHpyMKoRYisIZD
         aVTA==
X-Gm-Message-State: AOAM530lWaU0VBQ7KVwhBDIPmtwUcZcMdI/rB37gUBCY+T5Eje7oH4ZB
        tRr0649oBFuXr57Ex3rW3/B5Pw==
X-Google-Smtp-Source: ABdhPJx6MW29oPmzgbiPjCDkuEQv7KOXDZb+eT+EFYQATDpuFpFcayVQ7Y8sphVo++de+f1fLvwTNg==
X-Received: by 2002:a05:6a00:238e:b029:35c:c5e:b82d with SMTP id f14-20020a056a00238eb029035c0c5eb82dmr26823448pfc.33.1630389588390;
        Mon, 30 Aug 2021 22:59:48 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id b18sm16132779pfi.199.2021.08.30.22.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 22:59:47 -0700 (PDT)
Date:   Tue, 31 Aug 2021 11:29:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 5.15-rc1
Message-ID: <20210831055945.cnyi2qheipfv2q3q@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains:

- Updates cpufreq-dt blocklist with more platforms (Bjorn Andersson).

- Allow freq changes from any CPU for qcom-hw driver (Taniya Das).

- Add DSVS interrupt's support for qcom-hw driver (Thara Gopinath).

- A new callback (->register_em()) to register EM at a more convenient
  point of time.

Thanks.

--
Viresh

-------------------------8<-------------------------
The following changes since commit 484f2b7c61b9ae58cc00c5127bcbcd9177af8dfe:

  cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz variant (2021-08-09 09:31:22 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to f0712ace7fe0723b40733c3b98591d34c1b0bfb9:

  cpufreq: qcom-hw: Set dvfs_possible_from_any_cpu cpufreq driver flag (2021-08-30 10:43:35 +0530)

----------------------------------------------------------------
Bjorn Andersson (1):
      cpufreq: blocklist more Qualcomm platforms in cpufreq-dt-platdev

Taniya Das (1):
      cpufreq: qcom-hw: Set dvfs_possible_from_any_cpu cpufreq driver flag

Thara Gopinath (1):
      cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support

Viresh Kumar (10):
      cpufreq: vexpress: Set CPUFREQ_IS_COOLING_DEV flag
      cpufreq: Add callback to register with energy model
      cpufreq: dt: Use .register_em() to register with energy model
      cpufreq: imx6q: Use .register_em() to register with energy model
      cpufreq: mediatek: Use .register_em() to register with energy model
      cpufreq: omap: Use .register_em() to register with energy model
      cpufreq: qcom-cpufreq-hw: Use .register_em() to register with energy model
      cpufreq: scpi: Use .register_em() to register with energy model
      cpufreq: vexpress: Use .register_em() to register with energy model
      cpufreq: scmi: Use .register_em() to register with energy model

 drivers/base/arch_topology.c           |   2 +
 drivers/cpufreq/cpufreq-dt-platdev.c   |   4 +
 drivers/cpufreq/cpufreq-dt.c           |   3 +-
 drivers/cpufreq/cpufreq.c              |  13 +++
 drivers/cpufreq/imx6q-cpufreq.c        |   2 +-
 drivers/cpufreq/mediatek-cpufreq.c     |   3 +-
 drivers/cpufreq/omap-cpufreq.c         |   2 +-
 drivers/cpufreq/qcom-cpufreq-hw.c      | 151 ++++++++++++++++++++++++++++++++-
 drivers/cpufreq/scmi-cpufreq.c         |  65 +++++++++-----
 drivers/cpufreq/scpi-cpufreq.c         |   3 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c |  25 +-----
 include/linux/cpufreq.h                |  14 +++
 12 files changed, 233 insertions(+), 54 deletions(-)


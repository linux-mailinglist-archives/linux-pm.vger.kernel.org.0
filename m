Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF76D464E90
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 14:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244690AbhLANPA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 08:15:00 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:17429 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349508AbhLANO7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 08:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638364110;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=1FlbcCNhNwqCUtpY2nQHiXO5hf5Y2HFDjbhAdRUzc18=;
    b=rkY/fWU1azWv8bvgBV3kL2u8uoPrBCKYp4Ghj7PsPLGxojyxHTgjhuEZv4NfTWPcNd
    Tu29EYXjRS8haOi0e7pWU1qMJcpycHUIc6Mg6twrQNjvXnqDYlk5+XXL0TTjVN7i4oQw
    i4kTLnYaSGcVn5BzGWf/bebvq2jPMOTkt90PiKoUS7ilCUzRy1FfhAOmA9Q3JQERQfTq
    RHQZXlr/mNTtY+KvXnDKPtL8OzWuOG6T65x1dLdNDI+I/Wd9bQR4VBxM9epDUOytvkU2
    0QrnUAS3TBXQzW/qwAxesIA3p4tGsctgARvO/F7dT9l4dyFgUI4D9Rtpj2WhwWdLbiMS
    mjxw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQ7UOGqRde+a0fyL2moo2"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.34.10 AUTH)
    with ESMTPSA id j03bcbxB1D8Tghj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 1 Dec 2021 14:08:29 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 0/4] qcom_scm: Add support for MC boot address API
Date:   Wed,  1 Dec 2021 14:05:01 +0100
Message-Id: <20211201130505.257379-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The "firmware: qcom: scm: Add support for MC boot address API" commit
was reverted again in 5.16 [1]. This is a new attempt to add it back
with much less potential build problems.

For that I first simplify the existing qcom_scm_set_cold/warm_boot_addr()
implementations. The idea is that cpu_logical_map(), MPIDR_AFFINITY_LEVEL()
etc are not needed if we just set the entry address for all CPUs.
Nothing in the mainline tree actually requires setting a different entry
address for one particular CPU and I cannot really think of a use case for this.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7db2bc925e4642df6255612e5521af0423ada18a

Stephan Gerhold (4):
  cpuidle: qcom-spm: Check if any CPU is managed by SPM
  firmware: qcom: scm: Simplify set_cold/warm_boot_addr()
  firmware: qcom: scm: Drop cpumask parameter from set_boot_addr()
  firmware: qcom: scm: Add support for MC boot address API

 arch/arm/mach-qcom/platsmp.c       |   3 +-
 drivers/cpuidle/cpuidle-qcom-spm.c |  28 +++++-
 drivers/firmware/qcom_scm.c        | 132 ++++++++++++-----------------
 drivers/firmware/qcom_scm.h        |   5 ++
 include/linux/qcom_scm.h           |   4 +-
 5 files changed, 84 insertions(+), 88 deletions(-)

-- 
2.34.1


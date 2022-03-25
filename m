Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46644E7C23
	for <lists+linux-pm@lfdr.de>; Sat, 26 Mar 2022 01:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiCYT64 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Mar 2022 15:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiCYT6S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Mar 2022 15:58:18 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261A12A4FA0
        for <linux-pm@vger.kernel.org>; Fri, 25 Mar 2022 12:47:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bu29so15163871lfb.0
        for <linux-pm@vger.kernel.org>; Fri, 25 Mar 2022 12:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lgpBZVT3N397yNEIE8syFhUaj9YB16F6AhosJ5tOLW8=;
        b=N6mHXveQOoSZhABGQi8E7MEKTtsoXwSmYElE3MIh3BF5uZa3BYVcgqX7p08SdfaJj1
         vvQ+fxNfu25M+hlQG08ku6H5eTq8nShwNPKMdparpEIK+UVB4/BeB/+UCtGdrJ1NUS1p
         Xl1bMLPf92nO+oqq3G4iXBwfYORC23Fs3KUTaBe16bY6icyTegq6gqGDazL6VFfOex7k
         SyoGN9Xr+nQayHMSNpi11Zn1enUtJTwKMiFi0kf/O4CCtXGKFVFqBNMb/zHYMVR+27EQ
         6+PhmcHTrUUkuzD9oIEtQYuJFiGNDXyNlFJP48t3YW7307s7WgVSde2+ADZnEEEte29B
         nBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lgpBZVT3N397yNEIE8syFhUaj9YB16F6AhosJ5tOLW8=;
        b=KWi2BwTasPYsoojgI0D0BRIlm2637V5QSufNdBVFKiE6koNsVh3P6jV80PxVVvSYi0
         /QMJC96aMnjW3KF7RaQqRJ880w83gxV7f+5YC6D9d/pI1LHeGy4LCb1KsB1KljWD6NY2
         5FOZR7vwp+kzq5Gg4pwHH2sB0QDGsAFCEe5NYR5XVs/9A+uJrj9pcMCKBpvNQ2IZaKIQ
         qyE9ZcR6oUdA/ryEwMUBUrHJFDEhtw8qiat/Wi9D7ckAvXZa8AXd/hjkGy0UzDPP2sOw
         jDg1eIg72CV/94iJyIc4OGUc/29JlydX/8FdSrZPHPcQRKS3G0bi0kTTZLFQQ7sXUXFf
         iO9Q==
X-Gm-Message-State: AOAM531tZxJ4bp8xKuCBBLeJ4NAGgKeYRhMNsfOMbqwFGjAXaC/9eePo
        Bp3Ov1TjmEnm4Ta8nRTjASEyyg==
X-Google-Smtp-Source: ABdhPJyyhGwSHZvtiF6X9rzM53uUfZpOgpSMKroyqWiYthwPRq1lZ5oii1oKgclzonhQgtuLYK/ZSQ==
X-Received: by 2002:a05:6512:4014:b0:44a:2b77:bed6 with SMTP id br20-20020a056512401400b0044a2b77bed6mr8691672lfb.381.1648237643246;
        Fri, 25 Mar 2022 12:47:23 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u16-20020ac25190000000b004433b80c1d3sm802014lfi.182.2022.03.25.12.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 12:47:22 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v3 0/4] cpufreq: qcom-hw: Fixes for cpu hotplug support
Date:   Fri, 25 Mar 2022 22:47:17 +0300
Message-Id: <20220325194721.2263571-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchseries aims at fixing and improving CPU hotplug support on
Qualcomm platforms. First three patches are the fixes for the LMH
support in the cpufreq driver. The last patch adds support for
lightweight offline() and online() callbacks which are used instead of
exit() and init() each time the CPU is put offline or back online.

Patches 1-3 being pure simple fixes can be applied during the -rc
stage, while patch 4 is targeting next development cycle

Changes since v2:
- Point Fixes tag from the first patch to the correct commit
- Replace huge patch 2 with one-liner thanks to being able to use
  policy->related_cpus instead of policy->cpus

Changes since v1:
- Update commit message for the first patch to describe why dropping
  affinity hint is required (before calling free_irq()),
- Fixed commit message for the second patch to include messages
  generated using the mainline kernel w/o additional patches,
- Changed third patch to use dev_warn_ratelimited(),
- Reworked last patch to move request_irq/free_irq to online()/offline()
  to make sure that the IRQ isn't left enabled after the CPU has been
  put offline.

Dmitry Baryshkov (4):
  cpufreq: qcom-hw: drop affinity hint before freeing the IRQ
  cpufreq: qcom-hw: fix the race between LMH worker and cpuhp
  cpufreq: qcom-hw: fix the opp entries refcounting
  cpufreq: qcom-hw: provide online/offline operations

 drivers/cpufreq/qcom-cpufreq-hw.c | 43 ++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 7 deletions(-)

-- 
2.35.1


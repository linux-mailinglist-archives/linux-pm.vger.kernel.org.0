Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8FE1EA258
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 12:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgFAK7c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 06:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgFAK7b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2020 06:59:31 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D69DC061A0E
        for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2020 03:59:30 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x207so1429741pfc.5
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2020 03:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=O7dtDsTn8AU/RZ5LNEfHyIycb+r+zNEVy/2VPUEZ5s8=;
        b=jO7GQRuhXm4cImdACv9PjBouRLw9HvnFE22VCVFQ7BcD005PALTOJh75Immk7dbBrq
         Y6Bo2xX0P2878kmD+yFwGfgn46JSUacByGQhGDfvxpbCSu4I73Iz8UBT1G7C51xGTFGx
         vNUsUSqOIKffASzQwPhxTEkkVJCvQtdWOP9dAowzErUd6eXEHF1FpWdn5qoIcMqcjdOu
         9ZQy+RMOSXnKo69cgjS5M7ircER5MXxuWLe0Jyv88iJhwepz2I214UdFosOLynZGG73y
         G4T2dvvSn4sxuwvwPhWR6TtE1Ulc+S/Yb+OB7+lgvYXOMNBtuSlFLALGdcTaMmY6m6rl
         5zdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=O7dtDsTn8AU/RZ5LNEfHyIycb+r+zNEVy/2VPUEZ5s8=;
        b=EgGeLPJrSPeOQMeqPlWPF/nQKUqSbUxQg+x0oq5XM2Fi55f4UrSwch38W9QyxbwjCO
         8eDyBEOrgECRcT0Kx1LWyXW+f89B45vxZuuJ3sk1DY4gjAE2AmW5zpZC2mhJ+DKPYD51
         SG5G3g+T3DjwS8puDqfeVDmhw35qGBElw9u3tKNp+TOqvdAb1ZC+XrLZqeiropZgjYuF
         Ls+zfbzJge9doPS+XafJxf080SzCJdeTSOc/d2tVTxv7dPPfURHARY+6pI2LGNu37g5u
         b+vxxiicVG6kqkrnCVV24ZJGY7yab6t8AxtFNXYdfeyE21gnslaupuXiNqdfLvOpZJ4P
         uOTg==
X-Gm-Message-State: AOAM530jpH0f67QGkWn7GjcZF2cWIpyLJNEqRVumx2HaGC4d77PkL3dt
        OEKBYD/hAk84m3PziAdOSr+ZUIRHpjI=
X-Google-Smtp-Source: ABdhPJzsLmBeHZ0V1E5EwI908mvRU9IJuO0/fRm7A3rLgSfjZI/ia3SJKKZfOlkWc7OdUY2BVokYHw==
X-Received: by 2002:a63:348a:: with SMTP id b132mr17916961pga.283.1591009169727;
        Mon, 01 Jun 2020 03:59:29 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id 2sm14218648pfz.39.2020.06.01.03.59.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2020 03:59:29 -0700 (PDT)
Date:   Mon, 1 Jun 2020 16:29:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm changes for 5.8 (2)
Message-ID: <20200601105926.hug72sdvpywpbjr7@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains a single patch to enable
CPUFREQ_NEED_INITIAL_FREQ_CHECK flag for tegra driver.

--
viresh

-------------------------8<-------------------------

The following changes since commit 1f1755af4f062cb1cbd55ca4a250fe272b82fe2f:

  cpufreq: qoriq: Add platform dependencies (2020-05-08 10:53:10 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to 6cc3d0e9a097981c8a0317c65b8a2278593bd2b0:

  cpufreq: tegra186: add CPUFREQ_NEED_INITIAL_FREQ_CHECK flag (2020-05-18 10:58:40 +0530)

----------------------------------------------------------------
Mian Yousaf Kaukab (1):
      cpufreq: tegra186: add CPUFREQ_NEED_INITIAL_FREQ_CHECK flag

 drivers/cpufreq/tegra186-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


-- 
viresh

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCFF2834DD
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 13:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgJELZZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 07:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJELZZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 07:25:25 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660F6C0613CE
        for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2020 04:25:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id g10so3417354pfc.8
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2020 04:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pA8an3J7iekp9kUaUGnAb+r20ubAxJJ46ObMpIGcgjY=;
        b=jwIBN5qx9mO4kxcE3Zg182ZjShaI9TACFN+BpX+YLsHdcHYciOCDTxtNlp9zR7L9Rw
         y/73Xcs9LVxKRTqnG9m98ZzwtJBJqL3eXmOJuYmfM6Hxwlp0g5Gr0xSClZPDPp+C3En1
         uR/RepD/AC6mg7bLkEgk9DsaCyMlKHNHB2DttKXYve+1vo/xfe4HIPFOtd5feVenza6K
         sQRWgaV7675Nie2DgJblicn/eAjp8UVHpvppcAQ9sbmHBbs1sJWQV/T7Vin/lVzVD+kR
         U8sGpy+Lkhaz/qk6DtZUczsyX4s+M4W+lvqiv2vbcGHU7Vd9faX5BnB3fL/NNEHFUaO4
         RAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pA8an3J7iekp9kUaUGnAb+r20ubAxJJ46ObMpIGcgjY=;
        b=VSyFCYc6J9Re0UIpWIoWtUuhMIMVDJePd+3oQ0V+pHXjUk0RJU2GqpcElllDgHA0NX
         6JpfvE8Y1TjFSfuxpxX4+ApGbnHnemuhhituy1Da7gYrGQhN3Qo4z41v0jKbapVFi4hK
         4cATNuxwZ2/JqpAe7RJzX2JMkx3l8kD6WbLoP182rtUSrf0+7rh8NaX7QPCtjOy4fan6
         P8BYRgxPcuP8zHrE4dulCi5mSuNoys9IIpnQLndzrr6gpUGX/sBmmUJZjw9716lpo7wq
         2BwLBr5naF/0z4OBZBZ17fBBVHaja/IKnmPT2BxE8HZiQE7S+ir1/aQDtGaABBg6Z1FT
         EpBg==
X-Gm-Message-State: AOAM532FeMQ9K/gn99l4Rf7h+wvHmckvtCX6kxoDqqyhaAMFFjS8Gu3n
        evQJ6bcOVYv000Ynsau0i6Ax4Zxv0KAiZw==
X-Google-Smtp-Source: ABdhPJw8F9jAXeVWRp4ND7vtfT3UzU//ckyGPxS4AvsV0xUeZTUsk7tC+v97HASyrWtLPI8e1H7rWQ==
X-Received: by 2002:aa7:8e54:0:b029:142:2501:34d2 with SMTP id d20-20020aa78e540000b0290142250134d2mr16391449pfr.43.1601897124886;
        Mon, 05 Oct 2020 04:25:24 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id j12sm10509722pjd.36.2020.10.05.04.25.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 04:25:24 -0700 (PDT)
Date:   Mon, 5 Oct 2020 16:55:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP fixes for 5.10-rc1
Message-ID: <20201005112522.uzs2iax3umhxvtcl@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains following changes:

- Return -EPROBE_DEFER properly from dev_pm_opp_get_opp_table()
  (Stephan Gerhold).

- Minor cleanups around required-opps (Stephan Gerhold).

- Extends opp-supported-hw property to contain multiple versions
  (Viresh Kumar).

- Multiple cleanups around dev_pm_opp_attach_genpd() (Viresh Kumar).

- Multiple fixes, cleanups in the OPP core for overall better design
  (Viresh Kumar).

-------------------------8<-------------------------

The following changes since commit a4501bac0e553bed117b7e1b166d49731caf7260:

  opp: Enable resources again if they were disabled earlier (2020-08-20 11:30:22 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to a5663c9b1e31c00e0bdfaf4d92eb51358fc3950f:

  opp: Allow opp-level to be set to 0 (2020-09-16 14:02:34 +0530)

----------------------------------------------------------------
Stephan Gerhold (3):
      opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER
      opp: Reduce code duplication in _set_required_opps()
      opp: Set required OPPs in reverse order when scaling down

Viresh Kumar (12):
      opp: Rename regulator_enabled and use it as status of all resources
      opp: Reuse the enabled flag in !target_freq path
      opp: Split out _opp_set_rate_zero()
      opp: Remove _dev_pm_opp_find_and_remove_table() wrapper
      opp: Handle multiple calls for same OPP table in _of_add_opp_table_v1()
      Merge branch 'opp/defer-probe' into HEAD
      opp: Drop unnecessary check from dev_pm_opp_attach_genpd()
      dt-bindings: opp: Allow opp-supported-hw to contain multiple versions
      opp: Allow opp-supported-hw to contain multiple versions
      ARM: tegra: Pass multiple versions in opp-supported-hw property
      opp: Prevent memory leak in dev_pm_opp_attach_genpd()
      opp: Allow opp-level to be set to 0

 Documentation/devicetree/bindings/opp/opp.txt    |  53 +-
 arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi |  36 -
 arch/arm/boot/dts/tegra20-cpu-opp.dtsi           |  67 +-
 arch/arm/boot/dts/tegra30-cpu-opp-microvolt.dtsi | 512 ------------
 arch/arm/boot/dts/tegra30-cpu-opp.dtsi           | 984 ++++-------------------
 drivers/base/power/domain.c                      |  14 +-
 drivers/opp/core.c                               | 231 +++---
 drivers/opp/cpu.c                                |   2 +-
 drivers/opp/of.c                                 | 112 ++-
 drivers/opp/opp.h                                |   5 +-
 drivers/soc/samsung/exynos-asv.c                 |   2 +-
 11 files changed, 381 insertions(+), 1637 deletions(-)

-- 
viresh

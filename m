Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F9F4E38B7
	for <lists+linux-pm@lfdr.de>; Tue, 22 Mar 2022 07:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbiCVGKc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Mar 2022 02:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiCVGKa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2022 02:10:30 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE422BC1
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2022 23:09:03 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id c2so11902478pga.10
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2022 23:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GSbZcuOD5pRC90w/2obz0vWK+vjjty0o/jT3+9bN2xI=;
        b=M137y45Bp7Y3gNdXiAcgnqZPFghfw9ddFZK7XxIOfTN/hJAC+3sQ/urt3Ov1FJxEiu
         xKL5KMBZtHE3cVxvQ9f4O3CkO2wySB2aTd/1ip6+6oEG10TVEqykDUGPH227t9dckUjN
         5rCW3dw8XoNPeN3cqJzJKUwYkue5dsRhcaYA9UOVq3qUR23vKeUDbTZ78mur2/gceWDz
         5beEXAJYqzExP5y2nsNfRuB2fgBZQvFOh2yGM4keP884xMfib5T8Iba5tH/CrXQk6kwW
         3E4xutG5SBfSi7TXZCsuE2kk7g2aLtkKUnnSvqNeezEnotHKPbMs/U6+5RIGzYqHv/fr
         Opng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GSbZcuOD5pRC90w/2obz0vWK+vjjty0o/jT3+9bN2xI=;
        b=JLmJO5VRtVhfTc1UwqkXYtZhxWlFi15NEGH+rj24h2Mmz6MDIahBC1vx1y8pPJ9/BV
         +NL0jkeT3NHGCnalpwkcVYLdYg6IYKV8SXNfrIe2GzSkfesCVoZ3K3pl6+qXtjbWPjx8
         JlaKboUjgZEQVVLwZ7+xArwh2K9qe31JIQUPss2fiDx9UEKvzLQkzPkAcXVbe3y1cE9A
         KJwsCJHsreyflBeZFYDM0mnPYu2wQZ3EkHTVebpFLgSj/Kwv2LbEibYfnvJ9COjW+/nw
         UrjGQTfoj1FivJbDia2HHC+pc3IYO8wrageoul4glU2C4fYaHn3mXkyfXkFnLukgme5V
         n2Xw==
X-Gm-Message-State: AOAM530d+I5IzHywgEJiNNgCvxqyNkPy7Gs/CxvmQpVHAOA++QuVh3/m
        f8hc5fi/HNrsmOf2qt0/jWc0p7cOgjO3fQ==
X-Google-Smtp-Source: ABdhPJzUXoywQO30thfm2vTm9aroefT39JOtwXP4Cg2QQiIQyyzYUhh8WDMDk2B1nMhmiOA3HFNWHA==
X-Received: by 2002:a63:1918:0:b0:382:1cfa:eefa with SMTP id z24-20020a631918000000b003821cfaeefamr17874450pgl.510.1647929343302;
        Mon, 21 Mar 2022 23:09:03 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a1a0300b001c5d05622fbsm1294792pjk.33.2022.03.21.23.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 23:09:02 -0700 (PDT)
Date:   Tue, 22 Mar 2022 11:39:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 5.18
Message-ID: <20220322060900.jbghsxop4xe7x6wi@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Please pull OPP changes for 5.18. The request:

- introduces opp-microwatt property to the OPP core, bindings, etc (Lukasz Luba).

- Converts DT bindings to schema format and various related fixes (Yassine
  Oudjana).

- Expose OPP's OF node in debugfs (Viresh Kumar).

Thanks.

-------------------------8<-------------------------

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to f48a0c475c2aec8f2274703e1dc7be503f40f7cc:

  Documentation: EM: Describe new registration method using DT (2022-03-03 09:35:04 +0530)

----------------------------------------------------------------
Lukasz Luba (5):
      dt-bindings: opp: Add "opp-microwatt" entry in the OPP
      OPP: Add "opp-microwatt" supporting code
      PM: EM: add macro to set .active_power() callback conditionally
      OPP: Add support of "opp-microwatt" for EM registration
      Documentation: EM: Describe new registration method using DT

Viresh Kumar (1):
      opp: Expose of-node's name in debugfs

Yassine Oudjana (7):
      dt-bindings: arm: qcom: Add msm8996 and apq8096 compatibles
      arm64: dts: qcom: msm8996-mtp: Add msm8996 compatible
      dt-bindings: opp: qcom-opp: Convert to DT schema
      dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema
      arm64: dts: qcom: msm8996: Rename cluster OPP tables
      arm64: dts: qcom: qcs404: Rename CPU and CPR OPP tables
      dt-bindings: power: avs: qcom,cpr: Convert to DT schema

 Documentation/devicetree/bindings/arm/qcom.yaml    |  16 +-
 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml       | 166 +++++
 .../devicetree/bindings/opp/opp-v2-base.yaml       |  23 +
 .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml   | 257 +++++++
 .../devicetree/bindings/opp/opp-v2-qcom-level.yaml |  60 ++
 .../devicetree/bindings/opp/qcom-nvmem-cpufreq.txt | 796 ---------------------
 Documentation/devicetree/bindings/opp/qcom-opp.txt |  19 -
 .../devicetree/bindings/power/avs/qcom,cpr.txt     | 130 ----
 .../devicetree/bindings/power/avs/qcom,cpr.yaml    | 160 +++++
 Documentation/power/energy-model.rst               |  10 +
 MAINTAINERS                                        |   5 +-
 arch/arm64/boot/dts/qcom/msm8996-mtp.dts           |   2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   4 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi               |   4 +-
 drivers/opp/core.c                                 |  25 +
 drivers/opp/debugfs.c                              |   8 +
 drivers/opp/of.c                                   | 108 ++-
 drivers/opp/opp.h                                  |   1 +
 include/linux/energy_model.h                       |   2 +
 include/linux/pm_opp.h                             |  12 +-
 20 files changed, 851 insertions(+), 957 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
 create mode 100644 Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
 create mode 100644 Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
 delete mode 100644 Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
 delete mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
 delete mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
 create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml

-- 
viresh

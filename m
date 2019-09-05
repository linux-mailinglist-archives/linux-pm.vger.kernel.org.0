Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E07A98C8
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2019 05:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbfIEDL0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 23:11:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33995 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbfIEDL0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Sep 2019 23:11:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id r12so770128pfh.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2019 20:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=K3Ug0IlG6s3M7tp+TgJ4j/4s8HuQxcAVxpCZuD+ob1Y=;
        b=gRNt1LuLpuq7zSahMJq0fkAI2A5yxQ3opC7C9XBbaV1WU1aZEsq8j9ws0OBlqn7fv3
         yKNSThoNJtFCv8Qd7M+WI3wE2isp+Yrptgdqtos4cx1kRfGy/eLatOD7HFcnIb+ffkXX
         KzYCOjq7mHZ9fALNLXotOljaKiwl0T6jPje4Z+WCWTUjEhOMwfCxaeRYkBkPSO5pvywD
         2gV+V6g9gYglSi1dUApEJ7wFj1ftdnpl/VMD9TQFUoSigyK3ZymzrNOcvPciYCpPcmaQ
         IstqvwEiErhBdfqW6hvXMv1/x7Zy/trtj6zkwjtuEhKlp6l+i9acMWY7KdSuI5z8sF2M
         R5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=K3Ug0IlG6s3M7tp+TgJ4j/4s8HuQxcAVxpCZuD+ob1Y=;
        b=WD2FGD3Uk9+ek4wGyGj7B1fVjZ9J4DzGM1cOa4Gqpevf7y7j1VgY7OP20cSomi8K6g
         r/NrJXFIl/W4DLhJfNp1EQvrlQgVVDO2vYO/ncHMGBJB1i+jLY86mQCcdg7s2KD4HESL
         EIauPDCtR7+dtBKnl2QqipIDzGT2MXD7Fx7NDV+J0ez46KazyNLnnqqHCMMvwCodQYIY
         rZ4BaltR6v2XM53xeAU/jJhdgxxczHe06CL3qE2L1KHgFcQpqCywVdFY6YbBAH1yxU8H
         X1RIfE0kmEJB2qHjXV5HmeruPMUcCKfMshSNrhsoQfP7EACsfir4MGC1fcp2sMSrh/HT
         8gJg==
X-Gm-Message-State: APjAAAWyhp1ugQnplUZRzcIlaDlBdFhNZ9NV2KdO/zze0RgjVs5Bn7ED
        l9XCyGp9to91cDEPqBeI/sBvpYgU3MA=
X-Google-Smtp-Source: APXvYqxuUIMS+RXrXA2oGGFx58lN3n4f2Fwcl15Zb4ldOUlej7waKnEktDDPwMcmIRO8Ng5T0/vYFQ==
X-Received: by 2002:a17:90a:3748:: with SMTP id u66mr1472843pjb.4.1567653084882;
        Wed, 04 Sep 2019 20:11:24 -0700 (PDT)
Received: from localhost ([122.167.132.221])
        by smtp.gmail.com with ESMTPSA id j18sm522578pfh.70.2019.09.04.20.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 20:11:23 -0700 (PDT)
Date:   Thu, 5 Sep 2019 08:41:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm changes for 5.4
Message-ID: <20190905031120.ds7aic7txzuapleh@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains:

- Minor fixes for mediatek driver (Andrew-sh.Cheng and Fabien Parent).
- Minor updates for imx driver (Anson Huang).
- Minor fix for ti-cpufreq driver (Gustavo A. R. Silva).
- Minor fix for ap806 driver (Hariprasad Kelam).
- Significant updates to qcom cpufreq drivers, mostly to support CPR
  stuff (Jorge Ramirez-Ortiz, Niklas Cassel, Sibi Sankar, Douglas
  RAILLARD and Sricharan R).
- New sun50i cpufreq driver (Yangtao Li).

- This pull request also contains few OPP changes as well, which were
  required because of dependencies for the qcom cpufreq changes. They
  will be detailed in the OPP pull request.

--
viresh

-------------------------8<-------------------------

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to f75d2accca7785657311653c125bb22f342dc5d9:

  Merge branch 'cpufreq/qcom-updates' into cpufreq/arm/linux-next (2019-09-03 07:55:22 +0530)

----------------------------------------------------------------
Andrew-sh.Cheng (2):
      cpufreq: mediatek: change to regulator_get_optional
      cpufreq: mediatek: Add support for mt8183

Anson Huang (2):
      cpufreq: Use imx-cpufreq-dt for i.MX8MN's speed grading
      cpufreq: imx-cpufreq-dt: Add i.MX8MN support

Douglas RAILLARD (1):
      cpufreq: qcom-hw: invoke frequency-invariance setter function

Fabien Parent (1):
      cpufreq: mediatek-cpufreq: Add compatible for MT8516

Gustavo A. R. Silva (1):
      cpufreq: ti-cpufreq: Mark expected switch fall-through

Hariprasad Kelam (1):
      cpufreq: ap806: Add NULL check after kcalloc

Jorge Ramirez-Ortiz (1):
      cpufreq: Add qcs404 to cpufreq-dt-platdev blacklist

Niklas Cassel (6):
      opp: Add dev_pm_opp_find_level_exact()
      dt-bindings: opp: qcom-nvmem: Make speedbin related properties optional
      dt-bindings: opp: qcom-nvmem: Support pstates provided by a power domain
      dt-bindings: opp: Add qcom-opp bindings with properties needed for CPR
      cpufreq: qcom: Refactor the driver to make it easier to extend
      cpufreq: qcom: Add support for qcs404 on nvmem driver

Sibi Sankar (1):
      cpufreq: qcom-hw: Update logic to detect turbo frequency

Sricharan R (2):
      dt-bindings: opp: Re-organise kryo cpufreq to use it for other nvmem based qcom socs
      cpufreq: qcom: Re-organise kryo cpufreq to use it for other nvmem based qcom socs

Viresh Kumar (3):
      opp: Not all power-domains are scalable
      opp: Return genpd virtual devices from dev_pm_opp_attach_genpd()
      Merge branch 'cpufreq/qcom-updates' into cpufreq/arm/linux-next

Yangtao Li (2):
      cpufreq: Add sun50i nvmem based CPU scaling driver
      dt-bindings: cpufreq: Document allwinner,sun50i-h6-operating-points

 .../{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt}   | 127 +++++++-
 Documentation/devicetree/bindings/opp/qcom-opp.txt |  19 ++
 .../bindings/opp/sun50i-nvmem-cpufreq.txt          | 167 ++++++++++
 MAINTAINERS                                        |  11 +-
 drivers/cpufreq/Kconfig.arm                        |  16 +-
 drivers/cpufreq/Makefile                           |   3 +-
 drivers/cpufreq/armada-8k-cpufreq.c                |   2 +
 drivers/cpufreq/cpufreq-dt-platdev.c               |   5 +
 drivers/cpufreq/imx-cpufreq-dt.c                   |   8 +-
 drivers/cpufreq/mediatek-cpufreq.c                 |   4 +-
 drivers/cpufreq/qcom-cpufreq-hw.c                  |  23 +-
 drivers/cpufreq/qcom-cpufreq-kryo.c                | 249 ---------------
 drivers/cpufreq/qcom-cpufreq-nvmem.c               | 352 +++++++++++++++++++++
 drivers/cpufreq/sun50i-cpufreq-nvmem.c             | 226 +++++++++++++
 drivers/cpufreq/ti-cpufreq.c                       |   1 +
 drivers/opp/core.c                                 |  68 +++-
 include/linux/pm_opp.h                             |  12 +-
 17 files changed, 1011 insertions(+), 282 deletions(-)
 rename Documentation/devicetree/bindings/opp/{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} (87%)
 create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
 create mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
 delete mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c
 create mode 100644 drivers/cpufreq/qcom-cpufreq-nvmem.c
 create mode 100644 drivers/cpufreq/sun50i-cpufreq-nvmem.c


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9BE6A98D4
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2019 05:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbfIEDQt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 23:16:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41948 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730677AbfIEDQt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Sep 2019 23:16:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so573060pls.8
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2019 20:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Rgs75OuBKSXEbqQZsOUPu8aIFF3It1D2O+9b0mi46XM=;
        b=nlc0V2gfxEFTCr2TRMKEOf/vBqF6SPG7o/Vxq7V/ZinZwDQ9ePusnDk3JoE/EOQEdp
         dS3u5YR/p3aFzmvOuXouPLHgt+CXDYVU90YHfAz+/uOk2eWn9+q5N+hg+Gq5ZLzehk6n
         k6MY2Fcj6feF7QEdKCVn0Qm3vyN4T7X8yVW62pmY+mjeVaa+xnDetmdTbL/Cx6LXe9+f
         RVAsvrgj1PRBqszrqtiif3pONvOdj93at1yill6IbnlER7nVEEo1hPT/KEzJ97YSHkj3
         H7dz1fQMji/+/C2Pynkyg70QMOuIzjudKBVjDWt3dxS+RmmavV3AdUVe/kU2azGcHpjw
         w5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Rgs75OuBKSXEbqQZsOUPu8aIFF3It1D2O+9b0mi46XM=;
        b=jCInYykaAOx8ovV/F+JJh6v9F6Xt85Uz5MYOTua9gbSjZaZ7PuNbGQjjjfnB2QG44b
         b6ATgM9ZO13ZNFcjtzfXurwCyJ1Zf/0J5+PlBXQg9XaziEtFDPSUcx+1QngDywqawn2I
         OzYAkLEHSg4Nx9UZ6NqtP8Iqc6id7xq91OzE91/oshMEOjemOpXguIqD/EPk4pAR792N
         qMcrDHruR0f1DdBIAMnFcTXTaROUusB8zw13JLkOIPg3L73zQubXmZmFMdqP3Et+mjUl
         ne2yR1kBmJazl3xYovUgiyLQBuc9J4ZW6+8vZ3YOHUhlOcPYqd7YZCwGW3+ADApTfW+A
         7vCQ==
X-Gm-Message-State: APjAAAUT/qd/SJ14eIP9PXFW/aFnDT5krbd/kMJhNitmdnlLQkuNsh1o
        EOKm/UqYgvn5a46xNLf6gVOs2AS63pQ=
X-Google-Smtp-Source: APXvYqxD5rRMy3jpvvrX88V6fhlNaoYkfvRbCt+MBXbOVsqlZsAuL3DM2ahZO4hbWwszJkYIzSelHw==
X-Received: by 2002:a17:902:7047:: with SMTP id h7mr970818plt.275.1567653408293;
        Wed, 04 Sep 2019 20:16:48 -0700 (PDT)
Received: from localhost ([122.167.132.221])
        by smtp.gmail.com with ESMTPSA id m129sm480480pga.39.2019.09.04.20.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 20:16:47 -0700 (PDT)
Date:   Thu, 5 Sep 2019 08:46:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP changes for 5.4
Message-ID: <20190905031645.hvtfuafqt3sjinvb@vireshk-i7>
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

- OPP core fixes to better support genpd devices (Viresh Kumar).
- OPP core changes to support multiple suspend-opps in DT (Anson Huang).
- New OPP API (dev_pm_opp_find_level_exact()) and Qcom OPP binding
  changes for CPR (Niklas Cassel).
- Qcom minor update (Sricharan R).
- OPP Documentation fix (Yue Hu).
- OPP core support to enable/disable regulators (k.konieczny).

--
viresh

-------------------------8<-------------------------
The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to 071afa50609d46f2f760851b90696f9a09714d24:

  Merge branch 'opp/qcom-updates' into opp/linux-next (2019-09-03 07:54:17 +0530)

----------------------------------------------------------------
Anson Huang (2):
      dt-bindings: opp: Support multiple opp-suspend properties
      opp: of: Support multiple suspend OPPs defined in DT

Niklas Cassel (4):
      opp: Add dev_pm_opp_find_level_exact()
      dt-bindings: opp: qcom-nvmem: Make speedbin related properties optional
      dt-bindings: opp: qcom-nvmem: Support pstates provided by a power domain
      dt-bindings: opp: Add qcom-opp bindings with properties needed for CPR

Sricharan R (1):
      dt-bindings: opp: Re-organise kryo cpufreq to use it for other nvmem based qcom socs

Viresh Kumar (4):
      opp: Not all power-domains are scalable
      opp: Return genpd virtual devices from dev_pm_opp_attach_genpd()
      opp: Don't decrement uninitialized list_kref
      Merge branch 'opp/qcom-updates' into opp/linux-next

Yue Hu (1):
      PM / OPP: Correct Documentation about library location

k.konieczny@partner.samsung.com (1):
      opp: core: add regulators enable and disable

 Documentation/devicetree/bindings/opp/opp.txt      |   4 +-
 .../{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt}   | 127 ++++++++++++++++++++-
 Documentation/devicetree/bindings/opp/qcom-opp.txt |  19 +++
 Documentation/power/opp.rst                        |   2 +-
 drivers/opp/core.c                                 |  85 +++++++++++---
 drivers/opp/of.c                                   |  30 ++---
 include/linux/pm_opp.h                             |  12 +-
 7 files changed, 235 insertions(+), 44 deletions(-)
 rename Documentation/devicetree/bindings/opp/{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} (87%)
 create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt


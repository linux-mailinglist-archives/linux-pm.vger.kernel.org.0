Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4DAF18EFC8
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 07:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgCWG1u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 02:27:50 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37943 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgCWG1t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2020 02:27:49 -0400
Received: by mail-pj1-f66.google.com with SMTP id m15so5624135pje.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2020 23:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=n/HCueWdrh+q88CLQpAx+GQrh5dwQAskGxxiMWlQgLg=;
        b=V3AP4GKIO+Asf2XKJGCw75TgSbLVE826hx+tYstv2yeh2VsI9o834Erj9MNyO5g3yy
         IuNF35UZYqmQhmetX8ILT8HPS1PY9NekyxsUt+wmgMoKD+Qn4tDhFTQ6j+8Qg0nccnZC
         UApXgGpKfUNtyiZcwlEoUM4x4UGn0HF3vVKumLvb6zUscJel3H+RIxBqaMV50JGIws4F
         kZQDJqB6JMyLIHm4sNqvmQE7jggGqXKezKSI34uaPhnUONmqx7ynHHOaRcpMJWYreliw
         a7ImSgsaYpLDBRSuYI0lYDbYmcRanRCCOXCwarJo93n6XeCBYi6vQkAfo3SgAuNlR6AP
         Fb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=n/HCueWdrh+q88CLQpAx+GQrh5dwQAskGxxiMWlQgLg=;
        b=J5fj8isiNB5M1iyBS/BdWWZ0jEuPItiNruh97Ln2H8lucm15OTIfJuD0X3XOxnm1h2
         0hs/21Pa4ZYSINEL6f4ZH/WcLtVj/w3Oyce5dvMqJMQGfPblYqxknXPFBfbK7i4nZRTy
         h4HOY4YXNAddFVGkNUt/mqA/EGwjNsXPSzQ4PdyF+DLi5pVvyRieWsWjZSAWR1RI90pf
         A6lErDywoaD1PbdrTUZkGX3va8wBVD2JowRRV2/3P+4o0lqLRQTxyJkkND63DGpUjoGS
         /LJNce1+qFF7UqzyzXLfXGM5moIL6EZpKVTkUad5M2CEZGRTaZeVF6egkBZfQ3fPaT1V
         hT5g==
X-Gm-Message-State: ANhLgQ1I73wVTQQ2VRqYu2EAzlKyCEeltw7ReRwXPgVqV5iQ7ozLtyRp
        4x/fw4fzR1c3U5seyaqESAEdIw==
X-Google-Smtp-Source: ADFU+vsDImZQjTuV+7okSIUo5WA2OcoeBFMPuWCXE7H86TnumXt90nNhKUzmK2oa10G/SapbR/EUMQ==
X-Received: by 2002:a17:902:8303:: with SMTP id bd3mr20881326plb.171.1584944868495;
        Sun, 22 Mar 2020 23:27:48 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id f129sm1141919pfb.190.2020.03.22.23.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 23:27:47 -0700 (PDT)
Date:   Mon, 23 Mar 2020 11:57:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm changes for 5.7
Message-ID: <20200323062745.wt6i5lpvgjnor7sn@vireshk-i7>
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

- update to imx cpufreq drivers to improve their support (Anson Huang,
  Christoph Niedermaier, and Peng Fan).

- Update to qcom cpufreq to support other krait based SoCs (Ansuel
  Smith).

- Update ti cpufreq driver to support OPP_PLUS (Lokesh Vutla).

- Update cpufreq-dt driver to allow platfoem specific intermediate
  callbacks (Peng Fan).

--
viresh

-------------------------8<-------------------------

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to a8811ec764f95a04ba82f6f457e28c5e9e36e36b:

  cpufreq: qcom: Add support for krait based socs (2020-03-20 09:59:57 +0530)

----------------------------------------------------------------
Anson Huang (3):
      cpufreq: imx-cpufreq-dt: Add "cpu-supply" property check
      cpufreq: imx-cpufreq-dt: Correct i.MX8MP's market segment fuse location
      cpufreq: imx6q-cpufreq: Improve the logic of -EPROBE_DEFER handling

Ansuel Smith (1):
      cpufreq: qcom: Add support for krait based socs

Christoph Niedermaier (1):
      cpufreq: imx6q: Fixes unwanted cpu overclocking on i.MX6ULL

Lokesh Vutla (1):
      cpufreq: ti-cpufreq: Add support for OPP_PLUS

Peng Fan (3):
      cpufreq: imx6q: fix error handling
      cpufreq: imx6q: read OCOTP through nvmem for imx6q
      cpufreq: dt: Allow platform specific intermediate callbacks

 .../devicetree/bindings/opp/qcom-nvmem-cpufreq.txt |   3 +-
 drivers/cpufreq/Kconfig.arm                        |   2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |   5 +
 drivers/cpufreq/cpufreq-dt.c                       |   4 +
 drivers/cpufreq/cpufreq-dt.h                       |   4 +
 drivers/cpufreq/imx-cpufreq-dt.c                   |  13 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |  71 ++++----
 drivers/cpufreq/qcom-cpufreq-nvmem.c               | 191 +++++++++++++++++++--
 drivers/cpufreq/ti-cpufreq.c                       |   7 +
 9 files changed, 251 insertions(+), 49 deletions(-)


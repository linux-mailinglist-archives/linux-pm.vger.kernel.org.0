Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F05B1E9CBE
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 06:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgFAEeq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 00:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFAEeo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2020 00:34:44 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C55C061A0E
        for <linux-pm@vger.kernel.org>; Sun, 31 May 2020 21:34:44 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 131so2831143pfv.13
        for <linux-pm@vger.kernel.org>; Sun, 31 May 2020 21:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FDLsT8SXqD8oqNptpiupoZ7qxxpJJUa+umzBfIkScIc=;
        b=ZogN07ARzcrQmrpuFIC0CtilGKhAS5AUUjVLvAIBBLWd9Elr14oX3ru5EhauMsrXmS
         obW32fdOA8YF4mPA4wllV9qjWJe94TG6GNvb53WR+smsiRFIYCtfwo3xRqIGj+d4ZEGi
         KqS2bnDHal8bo+99TL8IjYS9MgC+O0d/QtYZ9m5ykVr4mWg30I3yYtq67gFXozjLGqVK
         HW2CLyHLOUHOmsj5h0ka74oSAXcQlXMvpx/AqmS0jWsSDW/P6E7MkQsJD4Pl99d+y0No
         OJaSBrG/gaip0p9rN0IVtlPGwW539OkSjKQcbLFxebP2WYLimc7TDd1YM1uEg/VUwLtZ
         TZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FDLsT8SXqD8oqNptpiupoZ7qxxpJJUa+umzBfIkScIc=;
        b=c1ddPcM7rhWbmmNFVt2XiyU2EksWLGTFJV1pqmBYqw6Q9c3vq+ikoch6pPQDgWdlo3
         OAll/aWkavaGmf1MVKL4Dbx3MGEacwc6V2fDMcGSzFm8bVD76KxHnFdNZH1D96YaIgV5
         P7nhB3hwBZ7wWs4fr+GQjc9QFankWNaha37bb5T5UwLqJOZv9eCKFPrVQ5sFVJUkCMJR
         /e7AZ8WlWBY5gSp5CyHnoVODPIPwanjYmyeUY/9Y9fz3JkAsgH1dUMHrxCcE57YNAUtt
         7sGUkl96WJYdXTZ+420AuQgyu4VOXgWwdFEusrO12Qrdt+KuZYT67VypOAWTRE+6xars
         e2kg==
X-Gm-Message-State: AOAM5334dyVUgdHcKRChdWNqpBs9b+RKHZAa9nsOZjTvyBn2qXKYjsUF
        c5qopVDwucyDfT0OLlxVJ3bXXw==
X-Google-Smtp-Source: ABdhPJz/mbrIgzTLWlYvvx8icQf/IRYc/pyC44Ba33VxysHu/6kFSRBUWkQSDGfj010LQQbfqkyWsA==
X-Received: by 2002:a62:3006:: with SMTP id w6mr18973662pfw.29.1590986083352;
        Sun, 31 May 2020 21:34:43 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id w4sm10440724pfq.57.2020.05.31.21.34.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2020 21:34:42 -0700 (PDT)
Date:   Mon, 1 Jun 2020 10:04:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>, rnayak@codeaurora.org
Subject: [GIT PULL] OPP changes for 5.8
Message-ID: <20200601043440.c5oiuucf7wuqeasd@vireshk-i7>
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

- support for interconnect bandwidth in the OPP core (Georgi Djakov,
  Saravana Kannan, Sibi Sankar, Viresh Kumar).

- support for regulator enable/disable (Kamil Konieczny).

This is based on three patches from the interconnect tree which shall
get merged via Greg's tree.

-------------------------8<-------------------------

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to 264c280442847ac7ed0bb89ac3a1e2e8859f25d8:

  opp: Don't parse icc paths unnecessarily (2020-06-01 09:37:45 +0530)

----------------------------------------------------------------
Georgi Djakov (5):
      interconnect: Add of_icc_get_by_index() helper function
      opp: Add support for parsing interconnect bandwidth
      opp: Add sanity checks in _read_opp_key()
      opp: Update the bandwidth on OPP frequency changes
      cpufreq: dt: Add support for interconnect bandwidth scaling

Jordan Crouse (1):
      interconnect: Remove unused module exit code from core

Kamil Konieczny (1):
      opp: core: add regulators enable and disable

Saravana Kannan (2):
      dt-bindings: opp: Introduce opp-peak-kBps and opp-avg-kBps bindings
      OPP: Add helpers for reading the binding properties

Sibi Sankar (1):
      opp: Don't parse icc paths unnecessarily

Viresh Kumar (5):
      interconnect: Disallow interconnect core to be built as a module
      Merge remote-tracking branch 'georgi/icc-get-by-index' into opp/linux-next
      opp: Expose bandwidth information via debugfs
      opp: Reorder the code for !target_freq case
      opp: Remove bandwidth votes when target_freq is zero

 Documentation/devicetree/bindings/opp/opp.txt      |  17 +-
 .../devicetree/bindings/property-units.txt         |   4 +
 drivers/cpufreq/cpufreq-dt.c                       |   4 +
 drivers/interconnect/Kconfig                       |   2 +-
 drivers/interconnect/core.c                        |  97 +++++++---
 drivers/opp/core.c                                 | 119 ++++++++++--
 drivers/opp/debugfs.c                              |  42 +++++
 drivers/opp/of.c                                   | 205 +++++++++++++++++++--
 drivers/opp/opp.h                                  |  10 +
 include/linux/interconnect.h                       |  12 ++
 include/linux/pm_opp.h                             |  18 ++
 11 files changed, 473 insertions(+), 57 deletions(-)

-- 
viresh

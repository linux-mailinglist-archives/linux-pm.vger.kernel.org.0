Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3533E5617
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 10:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhHJI7D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 04:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237306AbhHJI7D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 04:59:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8274C0613D3
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 01:58:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e19so6537097pla.10
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 01:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=tGDqpKKXonaqPg0I3+jQOa3tQeUyBDJ1nSpQ/SRm3gw=;
        b=J5ban8UIulJl+A2a0/t8Z/EKE9XSyU1s4q8UvYt5NZNjWDsS/iqzpu7M0sOj9ifFJp
         R4VovNiOo0jSvwTBR6etr0ErRf15KU0VSNk9/WCs3eN201bZR644VFWjNoxuRo7PmTOk
         Vlmd618p5vDShOwdXxRn9qtue2bJ0KaEGyMZxQAOXIxcVepkfJBWWoNXBQljOuTC5ArJ
         owsX4aTwWM/Ep4k3bulHjCk97c4xXaXNvsu2c8I7hz82AZ5Rn/GXDSGMWD+UWsWV9DGM
         9JiIEL9w1V5+0GXFE7Zqib8CGgSKs7pJOx6XRwTM6ECowwRqOiVBW2zWE+10k4lbDLfo
         9/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=tGDqpKKXonaqPg0I3+jQOa3tQeUyBDJ1nSpQ/SRm3gw=;
        b=N5s/jt1jaW1psrmxf7l6eMZoHj2c/Jz1b9ITmKfu2updIsXLGPbYQ3fSW3dzpIutPL
         n7nVKUZ4u7U+5cYwdjA//REQAWRSrmJS/pwtbZ4PvAOqh2TAaLlCpFKN2neSyx2JSOkE
         ECEOXi+zbt9DJFX0tG77P1PA6eedJvgEipFZWAAj2GFce15gzr5wyJos0zD2zmZsid2c
         nROzn9OtAsJSch3u6YLZxQ44DiXI3tzxYMgqQLPjsNf2pYp24CwZVvB1DTY4HeNmjc9U
         i5I9gVpvUED4SL2Nm7uqLe6COelBJmKEL8+hRNHSAGmppHbosXllb//79E6cq7zY83P/
         14SA==
X-Gm-Message-State: AOAM530JgjdwCHOE2Z04UZnM7XpxBz3nf/AEZyh7z02A/+StHnrYl8Tb
        MC7RCvdbv5+TwSgBRrea9xyLmA==
X-Google-Smtp-Source: ABdhPJyH6Xa+4feAnFwPXT0mzJbEB1OSxpPpmZXhjNfHupZDysMD3rh4obwtfecxTfTPkY0fIMiX+A==
X-Received: by 2002:a17:90b:102:: with SMTP id p2mr3925721pjz.126.1628585921202;
        Tue, 10 Aug 2021 01:58:41 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id t26sm22757180pfq.75.2021.08.10.01.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 01:58:40 -0700 (PDT)
Date:   Tue, 10 Aug 2021 14:28:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm fixes for 5.14
Message-ID: <20210810085838.d3hv3rxli5vxozlz@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains:

- Addition of SoCs to blocklist for cpufreq-dt driver (Bjorn Andersson
  and Thara Gopinath).

- Fix error path for scmi driver (Lukasz Luba).

- Temporarily disable highest frequency for armada, its unsafe and
  breaks stuff.

Thanks.

--
Viresh

-------------------------8<-------------------------

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to 484f2b7c61b9ae58cc00c5127bcbcd9177af8dfe:

  cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz variant (2021-08-09 09:31:22 +0530)

----------------------------------------------------------------
Bjorn Andersson (1):
      cpufreq: blacklist Qualcomm sc8180x in cpufreq-dt-platdev

Lukasz Luba (1):
      cpufreq: arm_scmi: Fix error path when allocation failed

Marek Behún (1):
      cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz variant

Thara Gopinath (1):
      cpufreq: blocklist Qualcomm sm8150 in cpufreq-dt-platdev

 drivers/cpufreq/armada-37xx-cpufreq.c | 6 +++++-
 drivers/cpufreq/cpufreq-dt-platdev.c  | 2 ++
 drivers/cpufreq/scmi-cpufreq.c        | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)


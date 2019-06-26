Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF6156319
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 09:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfFZHUe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jun 2019 03:20:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40792 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfFZHUa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2019 03:20:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so850369pfp.7
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2019 00:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DjzoKDoMTKdBIpJF7I7fI16yL6fDsQ5JYgulxAwKshE=;
        b=DyVpkamk29iddc5ldITyTYC0mgWriRh5qhS7IBEB6p4qPx4yGO52uOieXs1fjCcMDE
         PD0AN7bTIDTboJk8BaX4yYZMIbYzi99rcpmeZtfuyZR81S0MZVnzZMU9a/1UiZPgLW6s
         Xotlp22WG+Hyi8UvxkbUhO2ZSgwVdm8zHkgVra3zUdq5AtDVJb01ouyUynVlPtO699su
         gORqcq95hENTHYdXRXMrEU4z3CA9TfV2Tp0A3Kl2SwqUPh1O2BHOIXvyxBc9m/TVC85O
         SWT4OCRUTxK31ALhnn6IXiPt4fJVj6vX1Ey8wTp64FUr2WUTWhKDvzi3E2iu0G0NB9Qt
         rdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DjzoKDoMTKdBIpJF7I7fI16yL6fDsQ5JYgulxAwKshE=;
        b=UNrEI+HKQdLSqev5dno67s4q3iEKMVnrhnUYy60FavTwu4rxBCnxtm+vhvpUI7tcMa
         slU9Kg3ev0Xm4tJznkOlp+2NHwBpQWZtujAJE8ur8yMgOqHFCZt1e50Gaid1o20BulU9
         yJwSsH/sLFyVg97ozHu4XoRoa2xK0d+oXcCBDpjWNhWCKrLfToTkWL5k0L/pzGKszWkc
         fWzvBAog7ED2o84A0B9hXLJiMXZT903OE+Tmd3FpOFp2KzjCGjhJC7QJjk0cc2i3izlX
         /ypdk9q7oQLZj7yzgVw9YogePupG3kC3+p5+wer9jN1G5iDnl1WgzUgKqmckNsbcSaQi
         n9pA==
X-Gm-Message-State: APjAAAX6YyhVXrjVQ5MaP9TeqK8ANFtMwL30S+y6eoKO/HFGnZxKJKEY
        XsQTZO/3xqdNJNrlYjzgfjiIjw==
X-Google-Smtp-Source: APXvYqyOVhaneJtuJkeAoaokPsxYth/vMf/0Z49/QyzNow06eUvsXdpPDRSVfSKXNVbvIzBEDzeRrQ==
X-Received: by 2002:a17:90a:950d:: with SMTP id t13mr2889678pjo.81.1561533629501;
        Wed, 26 Jun 2019 00:20:29 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id c33sm10718477pgl.70.2019.06.26.00.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 00:20:28 -0700 (PDT)
Date:   Wed, 26 Jun 2019 12:50:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP changes for 5.3
Message-ID: <20190626072027.kjqfwwbvacn2s47o@vireshk-i7>
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

- OPP core changes to support a wider range of devices, like IO
  devices (Rajendra Nayak and Stehpen Boyd).
- Fixes around genpd_virt_devs (Viresh Kumar).
- Fix for platform with set_opp() callback (Dmitry Osipenko).

--
viresh

-------------------------8<-------------------------

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to 560d1bcad715c215e7ffe5d7cffe045974b623d0:

  opp: Don't use IS_ERR on invalid supplies (2019-06-24 12:48:29 +0530)

----------------------------------------------------------------
Dmitry Osipenko (1):
      opp: Don't use IS_ERR on invalid supplies

Rajendra Nayak (1):
      opp: Make dev_pm_opp_set_rate() handle freq = 0 to drop performance votes

Stephen Boyd (1):
      opp: Don't overwrite rounded clk rate

Viresh Kumar (2):
      opp: Attach genpds to devices from within OPP core
      opp: Allocate genpd_virt_devs from dev_pm_opp_attach_genpd()

 drivers/opp/core.c     | 176 ++++++++++++++++++++++++++++++++-----------------
 drivers/opp/of.c       |  30 +--------
 include/linux/pm_opp.h |   8 +--
 3 files changed, 122 insertions(+), 92 deletions(-)


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6A2EE03B
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 12:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfD2KGR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 06:06:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39873 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfD2KGR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 06:06:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id e92so4839092plb.6
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 03:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=L9vsHR4UBkZjIkLHhWbQG/G5pySH9Fi+q7NDpTNHaBE=;
        b=uxKMnOEcV1XL6nuDh8EcABzfXAttm4mDVRDlQy/FEUES52C6aSzR1OH3tv+5FhzHgE
         QCOzmqxrATO5IKr/C1Cbkrhk3jqECs0J6Vixbcwqr8c1q2fSYJd/4FgqE/kVB/e/C5nT
         B38WBzNfptwPtizb0MyGyMrIPk3OegQtQgOGqcNfHjB+ml3reh8y8JNRmYU4mRQXIgdk
         O1W9IacgDouxJu6gHlm95y61Qvm/63ZHuA4jHF+CQSWQDQWUjTFz3p90IB7D3QZmC6RR
         itmVKlODAsvPvoGvvIqT/Btdj2S4A5WZTGj/nBy3Dz1O9kCLJBLqsy7k0KJ+X+HXlW07
         /i8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=L9vsHR4UBkZjIkLHhWbQG/G5pySH9Fi+q7NDpTNHaBE=;
        b=qk+T+LO4K41TqnBj7du5XSdHAAyoLwHo1rWGX5MwcLg30GBHZlZtfMesI7k2eAcJII
         +7e0DBqUIVa5KOp2z+0PSfd/vls3nPNPjhwK+LlmypazSObx8liIjz6rY6UEL7lnr+ie
         WINn1LAO3hBarccYdRYh6DwwupyJ5t5GqNIrqenRE8derCky80qbgeoOCvvjeINN/Yg2
         crDxqR+dxGWLZGqivGJqjHul2vCgfOwJFO0jRs6XpVdGfdR75ipWFNWM2Kko4kkKN5Zf
         jRpLnm5+3W/BnnJ9BY5+37k3VWgsDrK7t4HIzLylZZFC7eTys23X6+qGC+QdDrudDrQt
         hZ/Q==
X-Gm-Message-State: APjAAAVek2PsqfDxhtQIpgXANt8fz+RlXZEwRcYfZCfGuISfhAs289kK
        Hq6+PBpcQuwWEYDhuP8OLxTjWA==
X-Google-Smtp-Source: APXvYqydBHPy2EfrVq0MajkI2l/Z3hRD8X5DKq4cRh8HrXA6oViHnG6KBNzcQm3idEmPi0xLQ+yZnw==
X-Received: by 2002:a17:902:e285:: with SMTP id cf5mr24315457plb.77.1556532376778;
        Mon, 29 Apr 2019 03:06:16 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id j9sm71802238pfc.43.2019.04.29.03.06.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 03:06:15 -0700 (PDT)
Date:   Mon, 29 Apr 2019 15:36:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm changes for 5.2
Message-ID: <20190429100613.xuqm3mdxzrc2np6o@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains:

- Fix for possible object reference leak for few drivers (Wen Yang).
- Fix for armada frequency calculation (Gregory).
- Code cleanup in maple driver (Viresh).

This contains some non-ARM bits as well this time as the patches were
picked up from a series.

--
viresh

-------------------------8<-------------------------

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to 8db82563451f976597ab7b282ec655e4390a4088:

  cpufreq: armada-37xx: fix frequency calculation for opp (2019-04-29 15:22:50 +0530)

----------------------------------------------------------------
Gregory CLEMENT (1):
      cpufreq: armada-37xx: fix frequency calculation for opp

Viresh Kumar (1):
      cpufreq: maple: Remove redundant code from maple_cpufreq_init()

Wen Yang (7):
      cpufreq: ap806: fix possible object reference leak
      cpufreq: imx6q: fix possible object reference leak
      cpufreq: kirkwood: fix possible object reference leak
      cpufreq: maple: fix possible object reference leak
      cpufreq/pasemi: fix possible object reference leak
      cpufreq: pmac32: fix possible object reference leak
      cpufreq: ppc_cbe: fix possible object reference leak

 drivers/cpufreq/armada-37xx-cpufreq.c | 22 +++++++++++++++++++---
 drivers/cpufreq/armada-8k-cpufreq.c   |  1 +
 drivers/cpufreq/imx6q-cpufreq.c       |  4 ++--
 drivers/cpufreq/kirkwood-cpufreq.c    | 19 +++++++++++--------
 drivers/cpufreq/maple-cpufreq.c       |  6 +-----
 drivers/cpufreq/pasemi-cpufreq.c      |  1 +
 drivers/cpufreq/pmac32-cpufreq.c      |  2 ++
 drivers/cpufreq/ppc_cbe_cpufreq.c     |  1 +
 8 files changed, 38 insertions(+), 18 deletions(-)

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5303A1A916F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 05:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgDODKZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 23:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728573AbgDODKX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 23:10:23 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DABEC061A0C;
        Tue, 14 Apr 2020 20:10:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t16so728775plo.7;
        Tue, 14 Apr 2020 20:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eS3WEp5yYi5D8p5YaEr/MbO0auRiUqCHMPg8uW5Jnl8=;
        b=DQbhY7QzEjoauXO2wUX9zkTAx1qIP2KpzuxRNMzeTJBNALJAc328gDdWWGbbJ95+tC
         /LwPS+mjZj810HgiL6vrzAoHAIOHF0Vy1R9SSuPeo2RTrKzhjf2+Oh+U5BTGQsnDF+Ta
         o5SLGJse8o9HDscr475EeXEbYUWSPumasCgypdbxyTgrq4LPLnn92XM03ZYDqL0Okb57
         rjueRDDk6ZZGXG6X/zfLR5b24sOO9ZbtDGnwEjmsB2WlyynzwtFxYYDloSWZBZID40kQ
         41HMyk4DO+m50qBYCK0W5ZfNvr2lRFoILswwPciSKboIA9jL+PqOmo+wut8FhaazFanL
         xuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eS3WEp5yYi5D8p5YaEr/MbO0auRiUqCHMPg8uW5Jnl8=;
        b=SI2uODK7t2PpuYGO4UYFmAbUCOwxqGFo01BANR9bK0zN+9U7aSbLRqPrhF2RnH6Y0w
         QMbwvBGjVT7KdlEtsqsWvNEeHVuETCaV7XZWBpReP6m5OuSoz3XDh5mWOXavvqM7Bn4w
         0BR6rKiuXWnH10d3PnzhYll7IjoLaC6yB0PBG2u9SHhhRyorhoYnDqiff4Ut2EMDLXW3
         q+tIeSiTl1QIZkGOuBCWbd0zVBr603AIzANx1tz5lZkW+ShidLKsSZs52CRC/fAyIkFy
         Ai9g/EKBODLxiQXBhUsDa5pLO9cOK2VYGSAu9Q8DBDy/rSRJdT/KzFo9ZHT/bDBKeeGu
         NTPg==
X-Gm-Message-State: AGi0PubyiCs6oVFNUGX8oH41HvUVlpxJYqLzi+YfU3fEBXBP24WY1yRa
        l+ZZUodyh50ilgs0lr3a6p9bHnqb
X-Google-Smtp-Source: APiQypKlzGC5BFKOlwtvT/D1O2o4ijrW5XruZNdmtof9HOKpeV5KBWVTpLfFOW0FaAh+BsZnPtAz6g==
X-Received: by 2002:a17:902:b097:: with SMTP id p23mr2911392plr.263.1586920221548;
        Tue, 14 Apr 2020 20:10:21 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id z7sm3131364pff.47.2020.04.14.20.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 20:10:20 -0700 (PDT)
From:   zhang.lyra@gmail.com
To:     linux-pm@vger.kernel.org
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [RFC PATCH v1 0/2] Add platform specific callbacks for cpu cooling
Date:   Wed, 15 Apr 2020 11:09:57 +0800
Message-Id: <20200415030959.1463-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jeson Gao <jeson.gao@unisoc.com>

Reducing frequency to too low will affect the system performance, and
sometimes the temperature could not cool down to an ideal value as well
even if the frequency was reduced to the lowest.

This patch provides users a callback to set its own frequency limit to
prevent cpu frequence from being reduced too low. And also give an interface
to allow users to register specific cooling operations, such as unplug cores
or cpu isolation.

Any comments are very appreciated.

jeson.gao (2):
  thermal/drivers/cpufreq_cooling: Add platform callback functions
  thermal/drivers/sprd_cpu_cooling: Add platform mitigation thermal
    driver

 drivers/thermal/Kconfig            |   8 +
 drivers/thermal/Makefile           |   1 +
 drivers/thermal/cpufreq_cooling.c  |  53 +++++
 drivers/thermal/sprd_cpu_cooling.c | 340 +++++++++++++++++++++++++++++
 include/linux/cpu_cooling.h        |  30 +++
 5 files changed, 432 insertions(+)
 create mode 100644 drivers/thermal/sprd_cpu_cooling.c

-- 
2.20.1


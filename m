Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504FB1A91C6
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 06:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388698AbgDOEXE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Apr 2020 00:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgDOEXD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2020 00:23:03 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D994C061A0C
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 21:23:03 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m21so951234pff.13
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 21:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=6aVqWV36Lonun8S9lUBqm13V4gt2NDnlvekfzm57JS4=;
        b=gUeDdDk1hq252L3vtzBHDyJhTCOlLQkOPs8VhKUXGQie/9id09O3h3NYP1/59I20rR
         WrkhmWyuRGPQyVTrIqDY3N7+KxuXSnfMMVrnB1aivOsva8R6Chl5Nzo8kKeIURJ8JV/w
         vreLx0QWT68vjhbNhOaULfqAvbstvYH7/K1q6hXRO6kTRDPz6xOvHH6Tx1uMMMeKvM0h
         K1kXvAy9tiMTrlTlOS6E/TB2DkIZccGnA5tdpHoMQHmLBuIJ5rSs/hGGPKF3hwr9P8JJ
         pnboerxCYDpuuMqDCXGZZ1mO2XAHmsvLeLdnJgA8DMyTBI5XDcg8DQAOkfs0QXaFlifV
         kL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=6aVqWV36Lonun8S9lUBqm13V4gt2NDnlvekfzm57JS4=;
        b=YoVYUQWEfmSOMI4TD3EXVCosOMIJXOQTdxGxDVtLvGCqp1s6WuWf3uBnRdm2wnDvuG
         myOW4KwfY/QcNfs1NAFuvqLxGFoDZIzy/2mSQajbqmg7XTDMgfEiqcfnRhi9Gg98uy3F
         h11E9J9znTZkv0hK1JWK/AWZ/2LRwy3JmJIniW9Aph9Dkv3nD9BspeJCQDGLVug6olzV
         TgqkhsUAnmpcmkWbH90AeoRuYQFoyevcx/qgE2FnXx/uEHl80dcvXDUMWkpvxs0/oWSt
         mmdVlWoZDhEPtbczi0AseZTB/p5H60Sd8t37FwE0s22zL/5pEhy2rdwh0aK/clZwoFB9
         FMuQ==
X-Gm-Message-State: AGi0Publ/XfaZ6WCzZBjG/Tab5dlZpBhhUyletm482M3tHSXD2LhJRUm
        YaNUtnlkNjPh50Y33WncOhW9kw==
X-Google-Smtp-Source: APiQypI5ESHeIaLp9+LnvVxWlzZhZfcU4VrL9Y2F5uuhMglsafYM2ePHV9FZDP+rKrxoHUDVXQP0VQ==
X-Received: by 2002:aa7:8486:: with SMTP id u6mr23807209pfn.106.1586924582173;
        Tue, 14 Apr 2020 21:23:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c15sm12375405pfo.139.2020.04.14.21.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 21:23:01 -0700 (PDT)
Message-ID: <5e968c25.1c69fb81.da101.9b69@mx.google.com>
Date:   Tue, 14 Apr 2020 21:23:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.7-rc1-2-g38aeec472905
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing boot: 63 boots: 1 failed,
 62 passed (v5.7-rc1-2-g38aeec472905)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 63 boots: 1 failed, 62 passed (v5.7-rc1-2-g38aeec472905)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.7-rc1-2-g38aeec472905/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
7-rc1-2-g38aeec472905/

Tree: pm
Branch: testing
Git Describe: v5.7-rc1-2-g38aeec472905
Git Commit: 38aeec47290576cd1f4112fab3937c855a0331d9
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 56 unique boards, 14 SoC families, 3 builds out of 6

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>

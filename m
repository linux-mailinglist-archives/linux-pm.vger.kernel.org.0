Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220331D1DC4
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 20:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390153AbgEMSpc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 14:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390087AbgEMSpb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 14:45:31 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757BDC061A0C
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 11:45:30 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p21so121914pgm.13
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 11:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=FKnYvbCR5EcRonZUMp5cJDyT0mT36LAaCaQzIcdwams=;
        b=I6nLt//4O/g+gYyfeq4mge5rPsnuNGLNPv8xU1jJYTEK8rLMwLL1PMWYiRXAz7G139
         x+7M0M4fBLSHb1ykyfuzFIfMgDWjvDnE/YficdiKlPdZsvfo14Y1UnhnmgJOVp8MBsSq
         nG5oilSxsUy6JZ29WQSXC+NFp9t3ZHJsKzMTdC3Ah0xGM68mMNGm4ham4WXOYhCyusQB
         E2XpEycbqFPPEqRKyu8nnosTso5CnX533ZEy/A71JZLrPWK+QUUnhKYFxmvTyEa/2Re9
         xLotDJfx/LzxVyor+I+2k/itGxIGGvDLmiitYkCj/MlwQHbfzfK7GIeRqtDrGr7qE52H
         sNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=FKnYvbCR5EcRonZUMp5cJDyT0mT36LAaCaQzIcdwams=;
        b=LedZ5ovUEiS+8+1Hr8HGpIGMoJhZ9/B28S5ebnZ/Ogd3noLe9R9p+zN/i6b41bE0dw
         C66bh6Ryj0rpi3J4+NJcSja1QYHKheX47miRsVoA1uTugb21Bk0AIBa3VGOkMS8H2MfK
         b3iGBOllUxLzVn19aTIDRu9EuEtpMOipMaMVS/Q1UC2kvTj7I8HYaGNiNMsAZ3MQG31k
         QXE/Vr4/z6Z9iBpy2PSQgvRdmd/HYKNWftTy3e4Zkx1rTcW2XAL8y5KMxlv3HRaLZooj
         z72OPL5ePnti72iZ22ci0ndvUjc4qPj6XIFjimVYdly9k6McLEyJnmkehJdjBkT+4id5
         hwGg==
X-Gm-Message-State: AOAM533yzCHeX3eIxYrjJ616ullnsZH4f1F+eEVuug1ir7Sya5hdRh5z
        ltcfqeen9hjb/M1cjf7C7jjlMQ==
X-Google-Smtp-Source: ABdhPJwi78h5Aho2ybH2i5FmbUBinXO8rJicOjcT7HwBrvuc0Ln2IMnEzQjZQ6WjCHozYpxQaALdvg==
X-Received: by 2002:a65:51ca:: with SMTP id i10mr644098pgq.115.1589395530036;
        Wed, 13 May 2020 11:45:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id fy21sm15856541pjb.25.2020.05.13.11.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 11:45:29 -0700 (PDT)
Message-ID: <5ebc4049.1c69fb81.5fa01.9c5f@mx.google.com>
Date:   Wed, 13 May 2020 11:45:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc5-53-gfbe093dd16f4
X-Kernelci-Report-Type: boot
Subject: pm/testing boot: 63 boots: 1 failed,
 61 passed with 1 untried/unknown (v5.7-rc5-53-gfbe093dd16f4)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 63 boots: 1 failed, 61 passed with 1 untried/unknown (v5.7=
-rc5-53-gfbe093dd16f4)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.7-rc5-53-gfbe093dd16f4/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
7-rc5-53-gfbe093dd16f4/

Tree: pm
Branch: testing
Git Describe: v5.7-rc5-53-gfbe093dd16f4
Git Commit: fbe093dd16f4eb35746ca73c063d6290a494a93a
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 55 unique boards, 15 SoC families, 3 builds out of 6

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>

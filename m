Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63DD1B83B7
	for <lists+linux-pm@lfdr.de>; Sat, 25 Apr 2020 06:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgDYEZy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Apr 2020 00:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725909AbgDYEZx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Apr 2020 00:25:53 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54845C09B049
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 21:25:52 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f7so5808935pfa.9
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 21:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=KpjyZbw8O0cPgmrboVg9IylFayG3Uk0kIg0ZTRsRTiY=;
        b=PtjJ+JHQwSCgZPTa4DM6JCX9oEI6j342n74ycBYl8P9NtDMAocIVFekiCwl1s44S+y
         IWkwAFDVJ1JMnimQgVlawYbDbGnyBrHfIY4kE8LSg7e3aAK9J14iO69OOrOQgowSLcmY
         Pcf77Gbx7LAP7c8B8qcGERaqw2KAYQdTkWmFEh0Kp1d8veYCR44kV8sKY8SuHIaQaqrY
         xEyc2l3G18Sq0bRpFAWJKS7MoWtQAsctVl13HNLxExLTyxwYYvoE5aeVtOUNvl5IlQfG
         rPrMHmS+Qk62b6udpdWbnRVxTfSKx7HyAUSbJaypdrvsnX3dfkqar8+QOruebL4yDTa9
         s6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=KpjyZbw8O0cPgmrboVg9IylFayG3Uk0kIg0ZTRsRTiY=;
        b=oEi7wNdWzdxStrr+6juZFVJsZ7trRINUIWwqY5wGzyUO3PiPWfLkc9nzKqaKaDyLe2
         JenByoprnvaT26zOCvpbaPSQjd7Gqfr+JhXIxhNaF7VgYmM9emI2IX1Gz84bIo9uQQH4
         N5lUvGrq8NeJiDhuLTBaSyVpUPJPo9OUMKoO/Vw4WQtmS+I3iFB8UdOboY0EGrD0MGaK
         CXUrccXYfUsX5gQa8sip4/Zt4qistaB3qLDaqa55J9fCaqgONymVQ1aSEJA/y+43zS42
         hSwNqnOWw1rnVC/CGoC8casJL1EDTuqhvQGKs5+yaDNIIj/WREQUDvyT6gvjlFJGKysG
         zHkQ==
X-Gm-Message-State: AGi0PuZOtEgyitB29tjDFlCzwNZXxhv8iZKuO6fIMpRLn8IyVKnt4i2H
        AxwA+aLzeAPhZUdqRhwc7L1vIg==
X-Google-Smtp-Source: APiQypKy8GN7U2rvYyuBKpBicNoPtA37I8FkC96CIUEpurb4flk3sfqdvnC6kblofCIRc1Sln/JwMg==
X-Received: by 2002:a63:e62:: with SMTP id 34mr11082923pgo.300.1587788751277;
        Fri, 24 Apr 2020 21:25:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b1sm7008040pfa.202.2020.04.24.21.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 21:25:50 -0700 (PDT)
Message-ID: <5ea3bbce.1c69fb81.8ccd.923b@mx.google.com>
Date:   Fri, 24 Apr 2020 21:25:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pnp-5.7-rc3-19-gcd227cc5ff82
X-Kernelci-Report-Type: boot
Subject: pm/testing boot: 67 boots: 2 failed,
 63 passed with 2 untried/unknown (pnp-5.7-rc3-19-gcd227cc5ff82)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 67 boots: 2 failed, 63 passed with 2 untried/unknown (pnp-=
5.7-rc3-19-gcd227cc5ff82)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/pnp-5.7-rc3-19-gcd227cc5ff82/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pnp=
-5.7-rc3-19-gcd227cc5ff82/

Tree: pm
Branch: testing
Git Describe: pnp-5.7-rc3-19-gcd227cc5ff82
Git Commit: cd227cc5ff829b628f48df3e6b18fc59349c4f9c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 58 unique boards, 14 SoC families, 3 builds out of 6

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-8:
          meson-gxbb-p200:
              lab-baylibre: new failure (last pass: v5.7-rc1-2-g38aeec47290=
5)
          meson-gxl-s805x-p241:
              lab-baylibre: new failure (last pass: v5.7-rc1-2-g38aeec47290=
5)
          meson-gxl-s905d-p230:
              lab-baylibre: new failure (last pass: v5.7-rc1-2-g38aeec47290=
5)

Boot Failures Detected:

arm64:
    defconfig:
        gcc-8:
            meson-gxl-s905d-p230: 1 failed lab

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>

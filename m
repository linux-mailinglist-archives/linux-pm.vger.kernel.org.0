Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE69185910
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 03:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgCOCat (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Mar 2020 22:30:49 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:41960 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbgCOCas (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Mar 2020 22:30:48 -0400
Received: by mail-qv1-f67.google.com with SMTP id a10so6921648qvq.8
        for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2020 19:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2iIEd4r/I8ATmjXSlsfQJdethCaZ/WTlnJB3PkGaOsk=;
        b=00IUks5EfUUT2qSao67jCvQ1QTCWQ5ltRm8Po4hxqWt6x1E9xyVrDGrubtNWIuBsZk
         +v9FdFf6+dYx/LHOLV+HA5PikxfIixg4/KJzs0Iu6OIxOnDGhIc0g/AtRA5ZPQ8VKEY6
         bHa25XZPFyWZQiTUacLwEi7v8O2PzBDsAeQEFA6vOnGyse+pUwOeb0duNf7Fxu/np4j7
         bNOn5Jvj3TI6wnRLqPV36vV9KMlmz1YkL6C+LBmdbCJqNhOp86hmFCMIBxWBSgM9xSvX
         /prG2N7B7SIhpLkOu4euPYNN6gPgJtJ5cvs5qAwUpENi7VJM4jXsvD2yrULW/VrfSC3r
         bceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2iIEd4r/I8ATmjXSlsfQJdethCaZ/WTlnJB3PkGaOsk=;
        b=d2H4Hw67QdzcLB0WN11O4IRbBBsBlaIr/J01t3W9Wlc/sD2ekJMmjwbZbMQal+SmFA
         CMGtY4p2kap0/zA9rKY9LB4HTiI7G5hEVNdxIvcws9cs6418g8c6vxyx51LVuYckk6BG
         OWqpISrX5+UZOpdwJbNgN1PSZ7fGeYdQ/ceE0dOiST4QSZF5MgZ0uZC7SXrTforKtBcw
         0FWgKJ3kOOk0XoC6bmsj0AOKFiLlR7vXckEOSW0b8ZuydkZ/k0alifgcdVK9ds7ydWaC
         f99KLxiC58VX08HPvq5Per+5d5uYDbJyG/2hR35vzPBZCTq/IgyOSIfcT6PyZx7niUts
         sFxA==
X-Gm-Message-State: ANhLgQ3t96rZM6eXJdWACeK3RTQYLZduN7zysbNP1tyhuIxeJp9c1ys5
        eSEH24vYZ/QfeugKii4kOtQF4vpnf/4=
X-Google-Smtp-Source: ADFU+vueGxCL20R0WTehVL4CPxR/aWy5bSQl6OkweHesFRWr1j8eWRSD4iPE4/UVGhYKXjLm4vOjlg==
X-Received: by 2002:a62:ce8b:: with SMTP id y133mr20335586pfg.172.1584215438384;
        Sat, 14 Mar 2020 12:50:38 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w27sm11414365pfq.211.2020.03.14.12.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 12:50:37 -0700 (PDT)
Message-ID: <5e6d358d.1c69fb81.10f54.5891@mx.google.com>
Date:   Sat, 14 Mar 2020 12:50:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pm-5.6-rc6-81-g0b0cbef30e18
X-Kernelci-Report-Type: boot
Subject: pm/testing boot: 65 boots: 2 failed,
 63 passed (pm-5.6-rc6-81-g0b0cbef30e18)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 65 boots: 2 failed, 63 passed (pm-5.6-rc6-81-g0b0cbef30e18)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/pm-5.6-rc6-81-g0b0cbef30e18/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
5.6-rc6-81-g0b0cbef30e18/

Tree: pm
Branch: testing
Git Describe: pm-5.6-rc6-81-g0b0cbef30e18
Git Commit: 0b0cbef30e1812bc567874888a4e71eb777fc51b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 57 unique boards, 15 SoC families, 3 builds out of 6

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-8:
          meson-g12b-a311d-khadas-vim3:
              lab-baylibre: new failure (last pass: v5.6-rc5-83-gabcd59902c=
64)

Boot Failures Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

arm64:
    defconfig:
        gcc-8:
            meson-g12b-a311d-khadas-vim3: 1 failed lab

---
For more info write to <info@kernelci.org>

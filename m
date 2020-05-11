Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F531CE2C3
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 20:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgEKS32 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 14:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729678AbgEKS31 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 14:29:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8016C061A0C
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 11:29:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j21so4935958pgb.7
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 11:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=yIoY1UR2+PUh4a5CSYa5kY9uyGN/tg7Zhna/Qmn3vOg=;
        b=SWNCYhaQPqXTGz57dIG2CUIOLLSlPQKd0qRNcWyyYh4voxAQ8HuMuftpronJOH4MHC
         FwMRnf/4+P62b0epbwRwi7BZBeIS1GEwQ7zRVZRBt/smL6SldR+Wt6i6qC7FG+/y0oKa
         1S79RVndZo+X8ZMWvgok5PVqSY4ebHSic7uHE+dcCuZY1UvWZ+UsNXVsim8GtLUSRF0D
         ud/HeZOTz8W4xEh+8cdp4cisUavJv/BWS+RhJGX6TBbB5AKqrc05FiKdyJoQLITnTxiw
         0MezJhJCUt+iZqHW35n+HLr6em1yMaP0GbeSH2TSFlWmEAB8rp4rVWTk8KCzP6/SI0wP
         GDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=yIoY1UR2+PUh4a5CSYa5kY9uyGN/tg7Zhna/Qmn3vOg=;
        b=Xz6+kZrwonNHRQornsi46lfQUGz5hpeQ4I9xI3n2tcYqpD4OWjFR1Jk5jMNZ95kDZF
         zX/blKXCPec5D+kcQ0isdi/0rmoAhXwUlzNznP+pVSXKMLzAe7BlPeEipKCDXsVlEf5g
         grZ6c6Vj+gKB76EKGPCDUm3o0YlQal2PJNv5kVfGBPmIuVtv8Kwh0D+UEm3iLoMAO4UT
         kjfefPOmazxtuYO8Ksnt2r1ZuPx+i8hHbJcgMZW4g/wkQXNC2fd4FCDhQdq7VKFmzjM4
         oVSD/tWyz8+GYCkKrCZda8Ub+a4it8XW33Uywz6sljju9ikiYr6Rv/Zx5kNk6fymDpKf
         C7gQ==
X-Gm-Message-State: AOAM530D8/O3QPq5zCtbXVZaC0UxpE+98sIyyumFsJRfRz4F61ohlSA4
        lJMLOxG34QkHI8fC+NbtlJTYvpd1Gxo=
X-Google-Smtp-Source: ABdhPJywrTjH2XZ3LMCGtlvG2QXwtniT8aveQ9IRoQE4ySUWrnlkYmdvDzwGz553ayuOSwR0Bk2f4Q==
X-Received: by 2002:a63:7a5e:: with SMTP id j30mr7053291pgn.5.1589221767261;
        Mon, 11 May 2020 11:29:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h13sm8445698pgm.69.2020.05.11.11.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:29:26 -0700 (PDT)
Message-ID: <5eb99986.1c69fb81.7916e.de34@mx.google.com>
Date:   Mon, 11 May 2020 11:29:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc5-43-gb68266410b45
X-Kernelci-Report-Type: boot
Subject: pm/testing boot: 51 boots: 2 failed,
 48 passed with 1 untried/unknown (v5.7-rc5-43-gb68266410b45)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 51 boots: 2 failed, 48 passed with 1 untried/unknown (v5.7=
-rc5-43-gb68266410b45)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.7-rc5-43-gb68266410b45/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
7-rc5-43-gb68266410b45/

Tree: pm
Branch: testing
Git Describe: v5.7-rc5-43-gb68266410b45
Git Commit: b68266410b45608f9ac68f17acd76bf64c209d21
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 51 unique boards, 12 SoC families, 3 builds out of 6

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-8:
          meson-g12a-sei510:
              lab-baylibre: new failure (last pass: v5.7-rc4-41-g277a1722e6=
6d)
          meson-gxbb-p200:
              lab-baylibre: new failure (last pass: v5.7-rc4-41-g277a1722e6=
6d)
          sun50i-a64-pine64-plus:
              lab-baylibre: new failure (last pass: v5.7-rc4-41-g277a1722e6=
6d)

x86_64:

    x86_64_defconfig:
        gcc-8:
          qemu_x86_64:
              lab-baylibre: new failure (last pass: v5.7-rc4-41-g277a1722e6=
6d)

Boot Failures Detected:

arm64:
    defconfig:
        gcc-8:
            sun50i-a64-pine64-plus: 1 failed lab

x86_64:
    x86_64_defconfig:
        gcc-8:
            qemu_x86_64: 1 failed lab

---
For more info write to <info@kernelci.org>

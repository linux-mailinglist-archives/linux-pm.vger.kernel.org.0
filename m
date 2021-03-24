Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5227346F4E
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 03:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhCXCPM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 22:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhCXCPA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 22:15:00 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8304C061763
        for <linux-pm@vger.kernel.org>; Tue, 23 Mar 2021 19:15:00 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id n11so13607726pgm.12
        for <linux-pm@vger.kernel.org>; Tue, 23 Mar 2021 19:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=4N+oxGKcj/IUSvZtZgAxmNfjHJ3lgTMY/aAUQo08pw0=;
        b=NZDMucgFnQGS/BbvL3JwydWyuwQEAHG/O3bhwdyicxmbGSCOnig3yB/6fpffZq53Le
         e1oZauxuTv5ECmq70KE7zga9P4P/EbVSNbDbrP7w9V3YOw5Hk4lMIqQIC7MImhih8Z2A
         LkhHG8aa84kQSFBqknd7sp7bESkfZI+Nxk6c+Lghss9B49s/VqFgJ9JNXsZmnMxs+Utl
         qnkJ1F8qhEs5xn5hMXnparFtZYMe6HNQQWSNEPT4qrEGQevVPZytVfg1Re/WwJR4DKRI
         5au8YEBK3vUS33Q26Y+Uoj2xgrz1Lw5C5bXQe2Hs5kMN0MQN/bx3otxldppr7Vjmhdx0
         LFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=4N+oxGKcj/IUSvZtZgAxmNfjHJ3lgTMY/aAUQo08pw0=;
        b=T5XIvTbrQKAFBJe8Go7nN2S5LvsUC93ezASpmIi8kyCBKjTXA+iLUmaVvj+Br/zXjp
         b65kBQqw/bSCiFW4F3JBhIDhK5Dqo8LfhLVajNwEymOsEBXuprWv7jCKmlIE0FnO7qeF
         XRIULjm2b5bKKXy+rsy6vmSN9CXl8P3b6fnQT8ov3i3Ejf9jBu8yo+Tgfc63y3jjVxUA
         h2K28uSwHSD+MzbLYw3SHSTumsSgOhzf8x46z4LanPD5XtuxsDSWO+IMORFbZZJ2hoBO
         Wd8S/4ZXvRFLUoUaNIRfCUXEQ5cUEzDXBui1mpg7eJHggFC59vX1wjxrUR7+S0KzK1bv
         xIVw==
X-Gm-Message-State: AOAM533LabGQHnXXf34UJzWWe8rY7a35zqVxru5usI9V+HLuVyByt5Lw
        QUVMYTRKnQUzuN/qTXoBAbGEYw==
X-Google-Smtp-Source: ABdhPJyPMyBL7vqsxeJcBJMqWQOesgMaLApmKr310vCFD+eTmPW8PXlwpJ9C55rtuW1FWuB+IytESA==
X-Received: by 2002:a05:6a00:2292:b029:1ff:bcb8:91f9 with SMTP id f18-20020a056a002292b02901ffbcb891f9mr780093pfe.63.1616552100319;
        Tue, 23 Mar 2021 19:15:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v13sm447360pfu.54.2021.03.23.19.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:15:00 -0700 (PDT)
Message-ID: <605aa0a4.1c69fb81.892a7.215b@mx.google.com>
Date:   Tue, 23 Mar 2021 19:15:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.12-rc4-41-g144389e954ef
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 106 runs,
 3 regressions (v5.12-rc4-41-g144389e954ef)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 106 runs, 3 regressions (v5.12-rc4-41-g144389e954ef)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =

r8a774c0-ek874           | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
4-41-g144389e954ef/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc4-41-g144389e954ef
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      144389e954ef1b556d4f192276f009158faecff7 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/605a96bc2250bcc4d8032d11

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc4-41-g14438=
9e954ef/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc4-41-g14438=
9e954ef/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/605a96bc2250bcc4d8032=
d12
        failing since 3 days (last pass: v5.11-168-gd10b8fa0d6dfd, first fa=
il: v5.12-rc3-29-g4bcad1ff6cfa) =

 =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/605a96e4669f41a122032cf9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc4-41-g14438=
9e954ef/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc4-41-g14438=
9e954ef/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/605a96e4669f41a122032=
cfa
        failing since 3 days (last pass: v5.11-168-gd10b8fa0d6dfd, first fa=
il: v5.12-rc3-29-g4bcad1ff6cfa) =

 =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774c0-ek874           | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/605a96d021bd7c3488032d0d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc4-41-g14438=
9e954ef/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc4-41-g14438=
9e954ef/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/605a96d021bd7c3488032=
d0e
        failing since 3 days (last pass: v5.11-168-gd10b8fa0d6dfd, first fa=
il: v5.12-rc3-29-g4bcad1ff6cfa) =

 =20

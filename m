Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4AB21E1A9
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 22:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgGMUwn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 16:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgGMUwm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 16:52:42 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36D7C061755
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 13:52:42 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 72so6058601ple.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 13:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=pXoRhBz4jWVYkhvgMUxI1XAwPzvoBiJLg3Q8j+n1sS0=;
        b=F4XDZ18lQMLwRffSsx2faYwrFKcobZjCRJTPNuv/+PtY+mCUIEF5lorcG82GqWYPmM
         DoMnTysDsGQpxYxNqy7hyRWH1DDDAnNGuXxQ1OLBps4rkxrKo7OCn9vdRrE2El15D2SI
         R9CksogeGgDGaC8cwCjPv3no2l4lgL5U4oY3fEb1BulQPxvWFNDZLOPqXKHXkdHysqCA
         Rv+lmVnzZ06QcKFxHxCK1VIU3NZCZW456O5IbJ6gYGsbZT+tT1IXnoFiCOJ3S2qftq0B
         8r4dIyqNmM7hVcVA5lBJVjksy7ldcZB7cG5E8tgb6jsiw4Z09G+WWdvTJP8DDSrh6Yjg
         MYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=pXoRhBz4jWVYkhvgMUxI1XAwPzvoBiJLg3Q8j+n1sS0=;
        b=R4U/KDC7uYRw1f8eXQoo5cCIW8jrSFe4hv6ZeahgCOcPEu/PuvSKjCon79QWDYOjFO
         HQOivyZOis02Nr3S6uxutZuorxt3Kd9eVb2X0lSBMbl5ws8NVSe4UXpqHCAXmn6E62YQ
         Y+Jthwj0Qu4Wr7dceRH15NmPrL/2ZXWTng0N0vqomhRKd0qna0QBz601086VcssWDnDc
         fZPFTFYU0hyIKpVJ4b2GwyYnV72VRUFbng3CILOC94iHsU6awkDVNEwmZqf3m5+f+wZx
         gZiefuJsmpnGl+o2uD1KKIQySV2uILIVZaJIsNd5d/RjfRcqn1bbtBr/H21tklqz0bCl
         jAFg==
X-Gm-Message-State: AOAM530Y7A95xmW62Nz+n8abj5hIAFrVcp7PrvH1NwtM0hTaDyGPrRSr
        lw/D9KCQHnBsZGlLrOZkNMyNIw==
X-Google-Smtp-Source: ABdhPJzg7wqzAC943Qs48FEga1WncV85XkQLlccAfjMzMrNeVyhcJ27aEzcm2q1x1c5Wq/tyR1i0QQ==
X-Received: by 2002:a17:90a:43c3:: with SMTP id r61mr1307447pjg.216.1594673561968;
        Mon, 13 Jul 2020 13:52:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p127sm15534899pfb.17.2020.07.13.13.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 13:52:41 -0700 (PDT)
Message-ID: <5f0cc999.1c69fb81.743ee.54d6@mx.google.com>
Date:   Mon, 13 Jul 2020 13:52:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc5-39-gf2eae871177c
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 91 runs,
 2 regressions (v5.8-rc5-39-gf2eae871177c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 91 runs, 2 regressions (v5.8-rc5-39-gf2eae871177c)

Regressions Summary
-------------------

platform        | arch   | lab          | compiler | defconfig        | res=
ults
----------------+--------+--------------+----------+------------------+----=
----
bcm2837-rpi-3-b | arm64  | lab-baylibre | gcc-8    | defconfig        | 4/5=
    =

qemu_x86_64     | x86_64 | lab-baylibre | gcc-8    | x86_64_defconfig | 0/1=
    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.8-rc5=
-39-gf2eae871177c/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.8-rc5-39-gf2eae871177c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      f2eae871177c5c62003e6a961382f098afeabfe6 =



Test Regressions
---------------- =



platform        | arch   | lab          | compiler | defconfig        | res=
ults
----------------+--------+--------------+----------+------------------+----=
----
bcm2837-rpi-3-b | arm64  | lab-baylibre | gcc-8    | defconfig        | 4/5=
    =


  Details:     https://kernelci.org/test/plan/id/5f0cbf65997c02f93285bb1f

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc5-39-gf2eae8=
71177c/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc5-39-gf2eae8=
71177c/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5f0cbf65997c02f9=
3285bb22
      new failure (last pass: v5.8-rc3-35-g941eabdd7fe5)
      1 lines =



platform        | arch   | lab          | compiler | defconfig        | res=
ults
----------------+--------+--------------+----------+------------------+----=
----
qemu_x86_64     | x86_64 | lab-baylibre | gcc-8    | x86_64_defconfig | 0/1=
    =


  Details:     https://kernelci.org/test/plan/id/5f0cbb285874844ed785bb18

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-8 (gcc (Debian 8.3.0-6) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc5-39-gf2eae8=
71177c/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc5-39-gf2eae8=
71177c/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/x86/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f0cbb285874844ed785b=
b19
      new failure (last pass: v5.8-rc3-35-g941eabdd7fe5) =20

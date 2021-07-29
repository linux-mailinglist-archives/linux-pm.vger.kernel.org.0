Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DC73D9C2A
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 05:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbhG2D15 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jul 2021 23:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbhG2D15 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jul 2021 23:27:57 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8F4C061757
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 20:27:53 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id i10so5274724pla.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 20:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=arxIiQbVePYcnmSqIQX8bMyIoir3B3L3XCflb6nAWaU=;
        b=rijxy1FRh/8Ud4QqlDirOlX0POGcHAiGhncTbrggmvwDZX7v/2RfufBBmQvbkigH9a
         mK2VmyMg8OPgns0dfTxCqgdQo2RY/uyunLtgaIIa6cpfb8vhHDLVR5V3ko4XWVO9zDvx
         zCIsIIbrrA8Qe5oJpDZbhDpvPcLjmL44QYFhn3tl+egDY6bi1VAMRTFW1SPGXOW947Uh
         VgbKmimQmLYMQYtNnRFRkyM00NgMLEziZWI6RlxC2e+WXgbKHYbUJe18ylO6oG1rrOX+
         7XUq+dlL1mOxu6BCmSlCfYoBCeFWZefpM3O+dzuLshjys95t1j+nzFFtGXrARWNszEjH
         lCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=arxIiQbVePYcnmSqIQX8bMyIoir3B3L3XCflb6nAWaU=;
        b=fGZ6j0FTms5qgiKtywAf4YD96Nfu4VFZLfNSV2yYnq8KhhFfCJB/kZxT65e4yjPGtk
         tP0eOeTYlW2X/Dk6NCqTsp5U+yEVdKbBlleivV9bmMihegdwZIYvFe/0pCJNMlQq1jHm
         CIQWhBL3O/VfX90vp41E7MpALXoGjtKXVQWgtURx/qjqzP03X2VybsYioIW6cTRA0yjQ
         gMMXk/xvztqJr/wjpWMuMdaJou+oWLM7sWgXmOtVtj+mQbWG0jWkwHuUkwA9lb/ZSIka
         IzLTc+xQwI7Cxbhcjt8ov+afJVsOx8b5nEt27c0R13/bATuXf6aRi755nh6Of4NRDz6Z
         1ATw==
X-Gm-Message-State: AOAM532kYNmJ+jmvyfh3Bflg495ZwT5BflioMKGEgAsWMsg/0RUw/1WU
        3nLOyFnK1vXovRUJQRXv5VNsug==
X-Google-Smtp-Source: ABdhPJys7yzt3E1beJyJBjZBOPjvOv1asJs2MYvfkEaiMv6zWbOQ9Twjvn3EBOxzec4JQ/9PNThwMg==
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr7578544pjq.181.1627529273381;
        Wed, 28 Jul 2021 20:27:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g14sm1212352pjj.16.2021.07.28.20.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 20:27:53 -0700 (PDT)
Message-ID: <61022039.1c69fb81.a3845.535c@mx.google.com>
Date:   Wed, 28 Jul 2021 20:27:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.14-rc3-20-g604483c9d252
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.14-rc3-20-g604483c9d252)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.14-rc3-20-g604483c9d252)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.14-rc=
3-20-g604483c9d252/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.14-rc3-20-g604483c9d252
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      604483c9d25283debe498a972c2b4565581e3aaa =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/61020e52779e3374425018c1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc3-20-g60448=
3c9d252/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc3-20-g60448=
3c9d252/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0722.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/61020e52779e3374425018c2
        failing since 343 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20

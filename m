Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F8435A93A
	for <lists+linux-pm@lfdr.de>; Sat, 10 Apr 2021 01:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbhDIX04 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 19:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbhDIX04 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 19:26:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4907C061762
        for <linux-pm@vger.kernel.org>; Fri,  9 Apr 2021 16:26:42 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id z22-20020a17090a0156b029014d4056663fso3976165pje.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Apr 2021 16:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=YuI5Do1eqbHS862MSw9AeA3eztIrVLDm5PhhuUccwb0=;
        b=DfcOkI+mWLRfYjKtWUHJGls32OTxAmnxWbbKiUmtNQx0xZoNHP9RTTKHUhQv/6d+BH
         z/HpkO2qd6iqph0R5xqM6syAt6Ni8nOysQfmQZRaADV748HSjGceT7i+OFvU47Os7IUk
         gjzS8l6nBUYQjdkA/dpnnQRQCf3QWG98Yjz/063RCJaSXsZChfCxQ3horoMm+nDA4GUJ
         E8O3BG6pIUm/sTRcfE11LCUEAN4XHzljWCfnmb/ESxtm5Yu5fJNUEFzgxediqk1JQPdM
         8yI+hGrPuTdP0c3ENZuW9pCQoyDRiEexmJQWr6atTexOw0WPTzDhk7IhceNd7VzFY/KZ
         nrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=YuI5Do1eqbHS862MSw9AeA3eztIrVLDm5PhhuUccwb0=;
        b=L83X1KG6puX2KxeVV2gNb/ICyECysOXQRQSY1YZv39iSg/opnwiImdPmY2dhnEOMVY
         FzVPswsjTtJ48C9mZpkY2pbmiayglLoE945vu99mIe9yXT1vAwGiRETzLb+EOgu1DSw5
         s6kqcsjMtbSYPW/TTyGYXpsHkzNWBjzG4wfDPS7DxWkt1RAXdyBk7sS2tUEFqPGtI7Hg
         lUPdeNxh+dRMlh4ntyyru+46HY+yaAKfBLBQ01ROhasF85dzkNZ0Acnn+tUSo9LyuLac
         VebuzwEk1jhiv/mhR2+Nb/ilnskgvw8Tw4p3ns+O75NvzN/y+kS496CjPz1li6Jb3rbR
         O5PA==
X-Gm-Message-State: AOAM533m0ybJ8bxHHEkQCxb7Qdfri+aIqcsVM4xkTz62JfREnoqtLdUS
        cbOT6s3OAC5I99OxWMUFVPytXw==
X-Google-Smtp-Source: ABdhPJypM7FESyzbB+xdE3Fo2TXEgIVBs16fnGFos9/1y5vKuXOmJ6W5YkhAnDOwyNa3XXRSnnNgHw==
X-Received: by 2002:a17:90a:540c:: with SMTP id z12mr15501123pjh.163.1618010802179;
        Fri, 09 Apr 2021 16:26:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j26sm3134234pfn.47.2021.04.09.16.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 16:26:41 -0700 (PDT)
Message-ID: <6070e2b1.1c69fb81.adbb.8b7c@mx.google.com>
Date:   Fri, 09 Apr 2021 16:26:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: acpi-5.12-rc7-125-g45f505d811b4
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 5 runs,
 1 regressions (acpi-5.12-rc7-125-g45f505d811b4)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (acpi-5.12-rc7-125-g45f505d811b4)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/acpi-5.1=
2-rc7-125-g45f505d811b4/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: acpi-5.12-rc7-125-g45f505d811b4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      45f505d811b4a64b2909019c0e0cba141114a007 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6070d602b9a7542059dac6b1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.12-rc7-125-g=
45f505d811b4/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.12-rc7-125-g=
45f505d811b4/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0324.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6070d603b9a7542059dac6b2
        failing since 233 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E86284B94
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 14:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgJFMZN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 08:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgJFMZM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 08:25:12 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EF3C061755
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 05:25:12 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x5so1137214plo.6
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 05:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=SEK4kjcUaZP7wQWsFLka/FFeKDTr+B9zhI17f3fWqCM=;
        b=gxTLomAvBT+rTLMZEzNS4jzghaS8F6igaBEsQO7pTBX9pkP3XSCPpYuB2mqAadAUmc
         SJ2huBh3UFExpSfpv1gnFbHMtV3nhUvPfYlzIHiLwjWJFfmroc/Rr29xZQ7Kn6nrcNmf
         IoLlXbnqAUvDo+u4B3nkpM2nRKUpIqcJomYBBUDXRZjVFCj6Xf8ns5Ch2esuXZ3QsMQA
         FESnY/L399Nx6Oa2H518fWcRRVPq/F3PWSjVJFN0Ux8hDCDxABDAcE1EzfSLsWgsG5fE
         z5Ga0nJAr3gfGB7+I1g91EXk6BOrM7XITc2LZ/wbJlsIEdTkJBJCGRLF+hnfY29Y8OJq
         fEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=SEK4kjcUaZP7wQWsFLka/FFeKDTr+B9zhI17f3fWqCM=;
        b=anNQcvg2oODRPv6l1gf4z+vrzLvDFwfg7e3R0JTZbyZAbv6kVafjmqSSFwMAmUupYC
         gXlGEYIYaMW33BQkOkbJWdNCiBB62pS8caafKxjn+1OaB0J3Nx6hePRE+7+tpUdos3TG
         CXjMkqbYVLiI5OOxNhz/mT/Xe1pXTtTKBMp+RSEsoSux3yW42pSmpB9TW9vrsjZXPHps
         V5wC/lMOklVLHaSGmhfTcVRbyDKcegNvQBX4V05FeJHSURqbtaii6OWq/nqPTM0OIEI/
         tECsPIGfj3XJMihtw4URbuldrbO55PIEGQsbXgEJ7ZFR/LvVtSMExtPWRVjwCugWADoY
         cM0A==
X-Gm-Message-State: AOAM531uGoL12QJ4178UWJkUE3sEt/F+cLeSLEvMwmsp+ZpMpR5+J2OG
        l2U1ps3w07jS4aazx5mn24KnMA==
X-Google-Smtp-Source: ABdhPJzE+JQcuSyX+aXni699iV5T4saRR4flP8bgGa6kC63jaiHwB7TTm+crvtelSCAvmwx5FGCsJg==
X-Received: by 2002:a17:90a:474c:: with SMTP id y12mr3806202pjg.150.1601987112323;
        Tue, 06 Oct 2020 05:25:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z73sm3734229pfc.75.2020.10.06.05.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 05:25:11 -0700 (PDT)
Message-ID: <5f7c6227.1c69fb81.60dad.7dc4@mx.google.com>
Date:   Tue, 06 Oct 2020 05:25:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc8-119-g9acb56ca0dec
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 3 runs, 1 regressions (v5.9-rc8-119-g9acb56ca0dec)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (v5.9-rc8-119-g9acb56ca0dec)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc8=
-119-g9acb56ca0dec/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc8-119-g9acb56ca0dec
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      9acb56ca0dec044037bf2d0a76f49ba773134ec0 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f7c5138369c1f500a4ff418

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc8-119-g9acb5=
6ca0dec/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc8-119-g9acb5=
6ca0dec/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1002.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f7c5138369c1f500a4ff419
      failing since 47 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)  =20

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18332AC590
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 20:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbgKITz0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 14:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730722AbgKITz0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 14:55:26 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA74C0613CF
        for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2020 11:55:25 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id z24so8067951pgk.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2020 11:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=HOaEc4/VoR2hbXHKCuUVAZWb3ev0adCqtgw5eIz8544=;
        b=0h1la21Dyt32TfjrvRvY0meAlA9cVHzLlyFns+CbbeJiV6zuEdxk40BZBkJNk/W9aJ
         trzTN66FxvZAdLynMzpnAMVxXAfY/zFhx+eLSjL5xqd8fGjYfUyUKrDJWz1CkOtXq6rc
         OKPbIBKIDnPy5YUq0T57AS1tSQl/VhxVWP+GiM05hASqnaqv2dEwzJn18WxQtAUK1b3D
         Np4Ozzlca/sv6uVgtUpxwz7JNF8HecSylD+L7Ii+VVDYKDsH7cf7f7VSUjniwpLJIxRv
         K03W3VIGxoSeS6D9z/29GNxEp91Z9JRoGD8wOhWTtQOVvt6GXL2yP+3/sqSWA/Q7zP8E
         FH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=HOaEc4/VoR2hbXHKCuUVAZWb3ev0adCqtgw5eIz8544=;
        b=nH5aCy6aijrkDzEvacko9h7GnFE9+UYStiAcXuctYtkGEcohw5Eax87ZVd82XXhgLb
         62LZB6mrC2/lDzz9gt0BZH9tlVvAJic/cdnhjHPVLPxpI1N073POWUYAqayz8JuhUKk+
         bzOYR8Hip6SSL2mJWHaJLfTu2oyzcxSmpBQIX3/5XoEW+NMHUAcz6dd0GnvBBiz0kjYb
         xNejWMtfbXct6eiujt+tr3GD2bT1NwSRBL/ZM0A05jWLDyyvVCNUVDTHDQ01Jn3Gap6r
         Gl81fZZHEERRKVocLMAyN1mn8loFuR/vZsdoq1wj4wQw1jZnPYnbLfAQ11DNAhqRishH
         M/GQ==
X-Gm-Message-State: AOAM533BW03j5mtHb7d8PrqA1hqMTdXhoOY9fFdnxdRmh9sq0PO/v03x
        /3ZvZr//wgBL9yVJgb25sKESDn7rlxa2YQ==
X-Google-Smtp-Source: ABdhPJxoUKvOgLtT/96VL2Z+gitp+whGV6t5Tr8Exit3nnY5+1G07+cElkEkXeC66v8/wewqludquQ==
X-Received: by 2002:aa7:86d8:0:b029:18b:585b:3b16 with SMTP id h24-20020aa786d80000b029018b585b3b16mr14515511pfo.72.1604951724728;
        Mon, 09 Nov 2020 11:55:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a28sm12143733pfk.50.2020.11.09.11.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 11:55:23 -0800 (PST)
Message-ID: <5fa99eab.1c69fb81.4e29.9fde@mx.google.com>
Date:   Mon, 09 Nov 2020 11:55:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.10-rc3-7-g7c5e6f73cac0
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.10-rc3-7-g7c5e6f73cac0)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.10-rc3-7-g7c5e6f73cac0)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
3-7-g7c5e6f73cac0/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc3-7-g7c5e6f73cac0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      7c5e6f73cac0c06e727d07879d6c3c00b1010377 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fa9921886943bd9e5db88bb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc3-7-g7c5e6f=
73cac0/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc3-7-g7c5e6f=
73cac0/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1105.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5fa9921886943bd9e5db88bc
        failing since 82 days (last pass: v5.8-107-gb72b3ea38c81, first fai=
l: v5.9-rc1-4-g1f08d51cd57f) =

 =20

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD30351CF8
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbhDASXJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 14:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239883AbhDASRF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 14:17:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5A7C0045D6
        for <linux-pm@vger.kernel.org>; Thu,  1 Apr 2021 07:24:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w8so1233223pjf.4
        for <linux-pm@vger.kernel.org>; Thu, 01 Apr 2021 07:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=WfIBTVO/GVb+L0JRI57dnbShae2nCBHRW3TkOl+Bw9c=;
        b=LtWwlDu+mCsInf8t28JB8gCCw0dpMp+7vyIvgbRoQHfFsrPk+AYwSbG91wcXWWE1T0
         6wcz88oDAxpYxPZG7TxUZBELkqLS2DP+L5m7Evu6ZBXKoxG+zhF3AXAGvbZogOVaztwm
         t5adc4jBMoPY5cIvWoVF3D49NPnBM7YF3K6kKhy5BZJp9G8U2WBSNC3RenxgIW7fD4ZN
         hQHeJBGCFqr34Nd9gaadGihRi66NB2jA3GgphsYfEb3/QU1p7W3fgtlM42EBxZdPmqH8
         /K+892bQZkQ59JIYu1PY5mb7wZg5m54hBb44UNg/sTxt/M5K5xSDFDSLSzI/GCNN7Kvr
         PCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=WfIBTVO/GVb+L0JRI57dnbShae2nCBHRW3TkOl+Bw9c=;
        b=iTeJLWt/kfp0cx0rt6n2d//T5TX70iUgsnhkObkDGZLttyXIs0jiMWs/GBYmYDTqIX
         gMj1eIc01g2FjbANBv2Gz3H1vpRj1zBH1bHrAUVH7MWfHs3R60rtNJ6fogTDImYf/jxA
         iB6DKeyXCtr+YtnjuByP48kaRpEm2QkAtw+zyFVLrdgS1Kr0VYgD+O2wbP/PT3o1dGnK
         MFFsuwUU9lvwBgYrkNgNY9lRu8+Qs7QZ1E1z6Yu0NcZg6pkB5BL35osyE0bRxv63mrxc
         zdLu+d396SKdFpBRwTqNEkFT6dgqZA1uOWZzLo/zYrtYn23X8vq/U2Caw9zmPnaWueD+
         AsVQ==
X-Gm-Message-State: AOAM532kZyKwk/2BPhSUSebkcX6XAZCKHhGukRBtEV0qfnd9eZ5LuLDG
        5/QueD4Kao1lCAfcKy+ymUYJ3g==
X-Google-Smtp-Source: ABdhPJwbvZChYAEtTVMky5o5FU/BekvQk278c+LWWRfjZBLf/XguRfxoyjdm/n9ohtlBhFu7YHbsoA==
X-Received: by 2002:a17:902:c1c4:b029:e6:7bc9:71fd with SMTP id c4-20020a170902c1c4b02900e67bc971fdmr8010711plc.5.1617287068290;
        Thu, 01 Apr 2021 07:24:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a15sm5904827pju.34.2021.04.01.07.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 07:24:27 -0700 (PDT)
Message-ID: <6065d79b.1c69fb81.81e12.e7f2@mx.google.com>
Date:   Thu, 01 Apr 2021 07:24:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.12-rc5-47-g85f34ae663986
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 81 runs,
 1 regressions (v5.12-rc5-47-g85f34ae663986)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 81 runs, 1 regressions (v5.12-rc5-47-g85f34ae663986)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
5-47-g85f34ae663986/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc5-47-g85f34ae663986
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      85f34ae663986081df77a1df26e08fd1978573a3 =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6065d0275ba6b0c9fddac6d1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc5-47-g85f34=
ae663986/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc5-47-g85f34=
ae663986/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6065d0275ba6b0c9fddac=
6d2
        new failure (last pass: v5.12-rc5-47-g506a524e05e2) =

 =20

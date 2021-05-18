Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93F1387036
	for <lists+linux-pm@lfdr.de>; Tue, 18 May 2021 05:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbhERDVr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 23:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243889AbhERDVd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 23:21:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0108EC061573
        for <linux-pm@vger.kernel.org>; Mon, 17 May 2021 20:20:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n3so4298862plf.7
        for <linux-pm@vger.kernel.org>; Mon, 17 May 2021 20:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=xsrCsR5Rw9s8EopV0l4CHjL7ryzGorfaRglRlFV6kU0=;
        b=rz8siifzlFnucyTVOjeHf5AnHbtPyBL7K12l8mMKYgVr3cFsvRf1dKE+dzGVordUnF
         SHQcYDeIsRIbzIswpasPiwFR/sEdPPeLFoEqQa/IqTGagem6xuF9gZpWAQ/fwBv42pB6
         F5EnsdcwSRIVOEYF2o9Tgq30t1juqbyJaWBx/dPckmRQFnsUasG97F0X4IuLfWoqcNG8
         ZH3QmJGrFezMtyezFRIMJudon6tZ+pCxDJZK61LkCnnhWi5MClqHv71oxwBV6CQt8DB1
         7ChAOuFTxooIV9GvPx2flRQZ9CvdvlPAf8t9HfVjTweV5AGmGC7LUQvj942/PZzoUyLr
         mMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=xsrCsR5Rw9s8EopV0l4CHjL7ryzGorfaRglRlFV6kU0=;
        b=Jh5YXrba3IRSmlXKmdDRf07n/XbPnXqlwLCo0f7IR4sJqpqU29JVZ7Li8EPEf0tnpX
         NfP9v8vFVWP9R3FyX27qT1SZ2JItF6Qhorc7O8turUzo0J8La0gcZUZSqsTp8ukPsjGj
         67Xy3yCMv5i2qq/kBawZGbIMloVesEJCkP4b+ol/Y2ur4lXqCd36gxapL69xyKPxm01E
         lsMX1OPYgwiYQlErq6olhHE+blx6J3UrhjvOBFRSrSn8dy5Ie3Hu9TmsLyBg1t8ubwQ0
         mzeh07wIpSj4pZX8PLhoKriu/7XfdKEaWom9qpEiB2aD2XxizaD4m5s2PUpRZH+pPrto
         vwdQ==
X-Gm-Message-State: AOAM533QmmSd6El4C0pwxT8VgT2OYbGQ1KnORZNebKmFqPYJJdnSRSTN
        Q/LkJZQCMLztmDfR+8qdUYxUPw==
X-Google-Smtp-Source: ABdhPJyuBRZntTDNYicpmRpZ3aMl5qStTWqcq9bhD6HOeN8JSr3uM+fCcXLdntYehSSN+GaJRa0ysw==
X-Received: by 2002:a17:90a:a505:: with SMTP id a5mr3007899pjq.58.1621308014516;
        Mon, 17 May 2021 20:20:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 125sm4038419pfg.52.2021.05.17.20.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 20:20:14 -0700 (PDT)
Message-ID: <60a3326e.1c69fb81.4e4d6.d566@mx.google.com>
Date:   Mon, 17 May 2021 20:20:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc2-4-g3da05329d571
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 81 runs,
 1 regressions (v5.13-rc2-4-g3da05329d571)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 81 runs, 1 regressions (v5.13-rc2-4-g3da05329d571)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
2-4-g3da05329d571/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc2-4-g3da05329d571
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      3da05329d57186b0e0d4e510ac5f38bd12c4f70c =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60a32a46a320d4391fb3afbd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc2-4-g3da053=
29d571/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc2-4-g3da053=
29d571/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60a32a46a320d4391fb3a=
fbe
        failing since 6 days (last pass: v5.13-rc1-4-gdc9d574fa82fc, first =
fail: v5.13-rc1-9-gcb7accda3e01f) =

 =20

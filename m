Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178412CE0F9
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 22:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgLCVmO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 16:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgLCVmN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 16:42:13 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BD3C061A4F
        for <linux-pm@vger.kernel.org>; Thu,  3 Dec 2020 13:41:33 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id x15so1917630pll.2
        for <linux-pm@vger.kernel.org>; Thu, 03 Dec 2020 13:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Bt5767yI7rttJqo6s+5snNT0w2p+H1Ug+S2ESfpx388=;
        b=AB/pGSheV2tEXbxzVhN193Rhd5EX+bkpYepsY1xUFiRXLKcTBGTALJR3kCA0RF0KGb
         TRHtcTtvIEQvvSP4WR7K3M4KEIi6pFY2cfT7sFXCoKTX5Ii1WVZ1V9ECo4Y5gYGAcbO7
         VDllVJfqPZxxncBqMPaaqzt2GIfVDRbD3s+G6vKXP3D2VFXD5J4mvY55KFIdfLLxVJ1S
         56lfFlIHeZq6ulV89i4XvF+DGNE4xGsBWEWOcGQzHWx/8iIdGxzldODNaUMcMau/bnAh
         rQteD8IPjsxyqOPdEAtF74Ni6UXDtdcV8y+z0KRtPRhyWDUsWlBGgz7rQyWj7k2ho340
         VZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Bt5767yI7rttJqo6s+5snNT0w2p+H1Ug+S2ESfpx388=;
        b=BfsO+AYSIvHs7MWFjmzSHNzNLAlbvPwAtYG3GTEjOHWBT+jw7a02gADr5MuofShezI
         b7L1Wg+TqJ6x49N4DVr3KoczFJ/FewpTBorCIRYvvfvsEdGHh72gA0RXAET/niuyjPwb
         lVlWV16uoQ0yzrfUQlt380Z5ayKrQQOWO7K0c49+iGq554FSiIyfxbvhIYhuGZH7225v
         hWzFXtDzb/dw2x9NtrpKeuk49LVvE1HoBqSPuIocITEh/8fTz6Tq/io8xvI9/QB+LIwM
         6tqraqvBckPfHi2pN3a8yGkJYJ6Qno5GF0+HbQS80wZm4zajp47WyHrxFYgFRJEKLpsv
         xrEQ==
X-Gm-Message-State: AOAM531eGs6TiK3wiFAX6FJrDy7E+Ex/y0KATzoISLLlytfQrk/VOjh8
        DzsTC3p39MxjLITV6rbn9hs/AGzMvzzK+Q==
X-Google-Smtp-Source: ABdhPJzg1J4vQMLYSY8q/tWWLr9ta2or60m7slqT6ayicw4a2X9F3w2VxDW88Db/gR7qwKerA/+zhg==
X-Received: by 2002:a17:90a:7d0c:: with SMTP id g12mr994596pjl.77.1607031692998;
        Thu, 03 Dec 2020 13:41:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r23sm2287167pfg.22.2020.12.03.13.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:41:32 -0800 (PST)
Message-ID: <5fc95b8c.1c69fb81.97cdc.52ba@mx.google.com>
Date:   Thu, 03 Dec 2020 13:41:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc6-90-gc35cc6e0cf05
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 130 runs,
 1 regressions (v5.10-rc6-90-gc35cc6e0cf05)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 130 runs, 1 regressions (v5.10-rc6-90-gc35cc6e0cf05)

Regressions Summary
-------------------

platform         | arch | lab          | compiler | defconfig          | re=
gressions
-----------------+------+--------------+----------+--------------------+---=
---------
beaglebone-black | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
6-90-gc35cc6e0cf05/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc6-90-gc35cc6e0cf05
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c35cc6e0cf0522be409eb83e6c2d7ab606627e17 =



Test Regressions
---------------- =



platform         | arch | lab          | compiler | defconfig          | re=
gressions
-----------------+------+--------------+----------+--------------------+---=
---------
beaglebone-black | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/5fc9523e4637e0f6f0c94cb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc6-90-gc35cc=
6e0cf05/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc6-90-gc35cc=
6e0cf05/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fc9523e4637e0f6f0c94=
cba
        new failure (last pass: v5.10-rc6-87-g53bf34061bc2) =

 =20

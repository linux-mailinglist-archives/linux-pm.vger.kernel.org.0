Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4C460D13E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Oct 2022 18:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJYQEd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Oct 2022 12:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiJYQEc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2022 12:04:32 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B7A13F7F
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 09:04:31 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f193so11939057pgc.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 09:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tsHS1tv+Y+KuwCnrcIenZkBtqfjYF6vYA8nmG5ukv30=;
        b=qI+zprybOAo1es2foSwI35REUa9JwYonFHFS5Mby9H3eeUQZzJqljOCffa3vzXQRqJ
         RTnceVlG5mRd4Lg1EtG0UugHh0egZl9KS5Z/UVTN6E2I4M6AdW0TZ3RuPQsyp2twY658
         mwiclb+QMrLozUxFkS8ZRDVjYV2KHug9Uv3pVM8Srox4xczAdciWzxZ6V0iQ8FZkcH5c
         3mkzR8TrcmqxEDgwiDVz3aSyMX+vP/DenW5+ZQIpFOA7pfazhfTBgmg9Ia/x9it5kOU4
         0+VwL2GOg8JkG43ptrmpa/Z3ZWAt2WfQ0uw8GSLAlxvrHIqALBdJevQQnYa9bliKtUWm
         +Bdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsHS1tv+Y+KuwCnrcIenZkBtqfjYF6vYA8nmG5ukv30=;
        b=ulcaEtTmzh2LvfU9LxBL/+uS88p0JMUhXUsBwdgIXunX/yboxcLogoEXgQdxbF1id6
         oZg2x6BsR/ENZVrlXPVCFQUlVBoY+h+Ag56qxRZyHyNoSv2IUmsAxwPUFPFYpoNpyg0d
         4pnRcBOeS+6CvLGs9qjxRtBbL30j07lJxRR6InB+njiZ1wsul2cgamOi7yl+m1H1Zqkm
         a/pADC0VqGhdIoFpbKVMYt/mABxtFa7E2TJ6ctMqgqX9o1TIxC+vk3Uq+Xg/vyCeJIx0
         DpOju7wgvEU8rBxhjcDRvVaK08+jzC5j3X/cvPSlKC+/FiSv9PGnxyEtvmqmOaJLDyAZ
         AO2g==
X-Gm-Message-State: ACrzQf16s0tISk3domwF1FwFyue9gHjPlxniAcdxw3WYvaES91epQnsY
        /quUHvb3NBIJaXnZscURLQp0kA==
X-Google-Smtp-Source: AMsMyM4IFmBwU6AP0zFZBJjaqBY4XWmPxe3iWkjoERHq3NhyGLF82fzRO4WfEn2/B3x/oIHkanWJ5A==
X-Received: by 2002:a63:f153:0:b0:46e:b0e3:547e with SMTP id o19-20020a63f153000000b0046eb0e3547emr22824084pgk.51.1666713870894;
        Tue, 25 Oct 2022 09:04:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id lj9-20020a17090b344900b0020c899b11f1sm5638240pjb.23.2022.10.25.09.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 09:04:30 -0700 (PDT)
Message-ID: <6358090e.170a0220.7e944.a3b1@mx.google.com>
Date:   Tue, 25 Oct 2022 09:04:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc2-3-g49c6629f06a33
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 59 runs,
 1 regressions (v6.1-rc2-3-g49c6629f06a33)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 59 runs, 1 regressions (v6.1-rc2-3-g49c6629f06a33)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.1-rc2=
-3-g49c6629f06a33/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.1-rc2-3-g49c6629f06a33
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      49c6629f06a33addd2d77936d3069e58dc31c5d2 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6357ff1f12ed636a145e5b3b

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.1-rc2-3-g49c6629=
f06a33/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.1-rc2-3-g49c6629=
f06a33/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221007.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/63=
57ff1f12ed636a145e5b48
        failing since 140 days (last pass: v5.18-rc7-183-g45785e0ed597, fir=
st fail: v5.19-rc1-2-g6a8964e282382)

    2022-10-25T15:21:49.079023  /lava-190858/1/../bin/lava-test-case
    2022-10-25T15:21:49.079428  <8>[   17.783723] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-10-25T15:21:49.079672  /lava-190858/1/../bin/lava-test-case   =

 =20

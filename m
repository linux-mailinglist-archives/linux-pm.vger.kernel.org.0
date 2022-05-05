Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA7151CAC7
	for <lists+linux-pm@lfdr.de>; Thu,  5 May 2022 22:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbiEEUqm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 May 2022 16:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385942AbiEEUql (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2022 16:46:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A6F60055
        for <linux-pm@vger.kernel.org>; Thu,  5 May 2022 13:43:01 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q4so2591182plr.11
        for <linux-pm@vger.kernel.org>; Thu, 05 May 2022 13:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=4SISAC4t1nEoDPaqCXPUNWQFPpEjWGOyMghZ3FvHi2Q=;
        b=Ke2WyJZqh0BeNgMeofzYNdBJ4QsjmiM8pDLfnCleX+6719xAoVeR7vrHFxdovKmNPU
         YLFx66OGC70ngjN2lI87LLLDBucyOTrbHD9+4+t/Ht0VW6zBrqk4eq7MX5IWgcpthRpc
         23sscWaIQWqoIZzkkNcTtmrlRUWnV0IiRvBrbHc1AEflIB0MYjA3dC9YhNqvc4gysdc1
         nWn49+xmXOZPx5DKeLrnWdyzKiaOlixhK1+Xn3Vu2QsJ5lflfg8XSuGjQI1+BS2IFo25
         KLl9KG0CjmqfSo23fVlnhEkSklxWBN5Eblzmf1PVKbjBje7NzbMPEwcfahQSkSV1Xakt
         xirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=4SISAC4t1nEoDPaqCXPUNWQFPpEjWGOyMghZ3FvHi2Q=;
        b=XYg/IP1H13RfjvffyD+M7o3XRhb/pduACF8i45glWmmZhnzVg/4cd2XZlCuesnAM8i
         7ktp49Kai3I7crrxH8FwZYRLxNAij8LR9udS0bus56sTOS9TshD0B8ozaME4/yQw+cVc
         48jRIIwi/CRjv/1EMGE1auLX5ztoBmCmPkSIJB6TbNZbSSQ7vG3ZoLH3uVsyw736WdXH
         3MhQEYjpxrG0NpDBDWv/qYXidsxiB95PLYCpRYAMu5/6JREAlxqD3LpTztgR/TWbw+HM
         ILJ8pk2u/HTKKJfcX1ru27q+Qe3gXV6tSjdLcirdFxT1WxybSyRvdGTU3+VxTXKc4d10
         QU2w==
X-Gm-Message-State: AOAM530dqCvCWC59T2MCI2mBtUs630zCzN50G+p2EzJW7zRny+dVvQGc
        XrQB3J6p5NiHg++PMkY4DrQkBdDqg/KzP3lEGJU=
X-Google-Smtp-Source: ABdhPJzCw8C14wHo7y4x9IefnOy3YdlK2b8QjhwwTJcdNp40BrFuWfP+ZJhwPT0si96YACuVR7siAQ==
X-Received: by 2002:a17:90b:3142:b0:1dc:c4c9:cdf8 with SMTP id ip2-20020a17090b314200b001dcc4c9cdf8mr4069532pjb.125.1651783380490;
        Thu, 05 May 2022 13:43:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b14-20020a170903228e00b0015e8d4eb293sm42289plh.221.2022.05.05.13.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 13:43:00 -0700 (PDT)
Message-ID: <627436d4.1c69fb81.a23be.01e0@mx.google.com>
Date:   Thu, 05 May 2022 13:43:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.18-rc5-102-g1fb89757668a
Subject: pm/testing baseline: 74 runs,
 2 regressions (v5.18-rc5-102-g1fb89757668a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 74 runs, 2 regressions (v5.18-rc5-102-g1fb89757668a)

Regressions Summary
-------------------

platform        | arch  | lab     | compiler | defconfig | regressions
----------------+-------+---------+----------+-----------+------------
fsl-ls1043a-rdb | arm64 | lab-nxp | gcc-10   | defconfig | 1          =

imx8mn-ddr4-evk | arm64 | lab-nxp | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.18-rc=
5-102-g1fb89757668a/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.18-rc5-102-g1fb89757668a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1fb89757668ad3301992968960e204ee09c07a09 =



Test Regressions
---------------- =



platform        | arch  | lab     | compiler | defconfig | regressions
----------------+-------+---------+----------+-----------+------------
fsl-ls1043a-rdb | arm64 | lab-nxp | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62742e25bc127951188f573a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.18-rc5-102-g1fb8=
9757668a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1043a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.18-rc5-102-g1fb8=
9757668a/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1043a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220428.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62742e25bc127951188f5=
73b
        failing since 2 days (last pass: v5.18-rc3-93-gc15e061fb0ab, first =
fail: v5.18-rc4-115-gd3fa656ae5f38) =

 =



platform        | arch  | lab     | compiler | defconfig | regressions
----------------+-------+---------+----------+-----------+------------
imx8mn-ddr4-evk | arm64 | lab-nxp | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62742e28860770a2908f572a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.18-rc5-102-g1fb8=
9757668a/arm64/defconfig/gcc-10/lab-nxp/baseline-imx8mn-ddr4-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.18-rc5-102-g1fb8=
9757668a/arm64/defconfig/gcc-10/lab-nxp/baseline-imx8mn-ddr4-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220428.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62742e28860770a2908f5=
72b
        new failure (last pass: v5.18-rc4-115-gd3fa656ae5f38) =

 =20

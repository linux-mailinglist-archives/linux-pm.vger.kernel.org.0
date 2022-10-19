Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9AA6052F7
	for <lists+linux-pm@lfdr.de>; Thu, 20 Oct 2022 00:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiJSWXx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Oct 2022 18:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJSWXw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2022 18:23:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4355181CA6
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 15:23:50 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c24so18603043plo.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 15:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NT7ZFogFkmlI57Imvtb/uGPP7vrPZDS0Ypoa2cGMjo4=;
        b=1jsTMmQFv1BpxuevWU4fpMzSzZCSbbF82yqD20iHwy1D9DMqEBMRloyPlSUcGsDdox
         +8B1VLBIj6EL6a1rwsFlpZQ/XfEDXHHzEPdBLAbP/WkzrzZysxWT3oRJZmopFQLCxSwd
         +m/KKyPTQz6mxcbQRaZvgIX0lLDESN2kjw9T50tAGK7IkYuUkXUREIobIPlLOQLchO2I
         XEh5x2pS/VaRJXh8f7ADxVrhcHXPlL7xAMXA43wgLIWBB0Cm4dLV08lunOK8AkwFZRy7
         Q6VHr/liHjXQH4lpnCUmqPgz/lB0Z44rVKT29ez5T7qbspHMFFTA4JKSkJS8PES+7Te5
         klTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NT7ZFogFkmlI57Imvtb/uGPP7vrPZDS0Ypoa2cGMjo4=;
        b=Dxmam2JQTC9T2E+cG39J2SEaXVh2yGOJkbFnCl8nCa37cflIuz2dPp2vsYQRQEkXm4
         /ts2hIoRP+r4ujhLsAOr19gzTMZylOGM+K0rHRT/qqMrTNi3jqcqaf8chMmHADOJDKn8
         NldXxFOXXSg7WYn0kIhfJdmxxUKBte3s7Z+iKRr8OcoAs1nST3/IqVEo8fVFTqjcEGWL
         KQvChtHEPpOnWDA1tCJpAdguydes3ffcOkL721ZAp0SxhoLJ5H8//YbzIBOeAqNuhmmR
         0wFNY0eCMfNEj/P7FFm5a96ZqtE9rbR1MITPAVsbZs1b9hqyxhck9xejQnCICavL0tHV
         O8Fw==
X-Gm-Message-State: ACrzQf2rvcLbJ31PQAfR+CIMlX72zxCuWJ8B9vNp0j3mFxQelKW7w95A
        3uzKWOMatImN8xiuFozmWjUJPniXJUxqo4Aj
X-Google-Smtp-Source: AMsMyM4dURUwZ3DJL2rhXZqP6SxSCFsyPZpOxPvjJ/b9Uk1OlGINgITN/1Q3wiIP0bPkubZuIsqebw==
X-Received: by 2002:a17:90b:388e:b0:20d:4a1f:d5a2 with SMTP id mu14-20020a17090b388e00b0020d4a1fd5a2mr11892283pjb.135.1666218230047;
        Wed, 19 Oct 2022 15:23:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t20-20020a63f354000000b00451f4071151sm10229471pgj.65.2022.10.19.15.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:23:49 -0700 (PDT)
Message-ID: <635078f5.630a0220.d7a4a.3313@mx.google.com>
Date:   Wed, 19 Oct 2022 15:23:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-22-g89871b5c10a0
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 73 runs,
 1 regressions (v6.1-rc1-22-g89871b5c10a0)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 73 runs, 1 regressions (v6.1-rc1-22-g89871b5c10a0)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.1-rc1=
-22-g89871b5c10a0/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.1-rc1-22-g89871b5c10a0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      89871b5c10a0504b364a83363f47a069578ae1f9 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/63506a11d409289b035e5b80

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.1-rc1-22-g89871b=
5c10a0/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.1-rc1-22-g89871b=
5c10a0/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221007.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/63=
506a11d409289b035e5b8d
        failing since 134 days (last pass: v5.18-rc7-183-g45785e0ed597, fir=
st fail: v5.19-rc1-2-g6a8964e282382)

    2022-10-19T21:20:03.435443  /lava-187146/1/../bin/lava-test-case
    2022-10-19T21:20:03.435750  <8>[   18.505010] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-10-19T21:20:03.435903  /lava-187146/1/../bin/lava-test-case
    2022-10-19T21:20:03.436045  <8>[   18.521261] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2022-10-19T21:20:03.436544  /lava-187146/1/../bin/lava-test-case
    2022-10-19T21:20:03.436696  <8>[   18.539088] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2022-10-19T21:20:03.436837  /lava-187146/1/../bin/lava-test-case   =

 =20

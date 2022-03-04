Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37FE4CDF58
	for <lists+linux-pm@lfdr.de>; Fri,  4 Mar 2022 22:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiCDUp5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Mar 2022 15:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiCDUp4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2022 15:45:56 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B28EDD2
        for <linux-pm@vger.kernel.org>; Fri,  4 Mar 2022 12:45:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so8981234pjl.4
        for <linux-pm@vger.kernel.org>; Fri, 04 Mar 2022 12:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=W8L0CnPeo+zJeQ8xRjyLBCHZbEKtnFc6NQtkmoNRfPg=;
        b=VKPW7J9RB16shxQk3Cn0pZjuoesquKm2CpBQaXV8g7MmfnJJnS54uZnJv3TYqYszDQ
         W4o2yIAZNfEBkPVAaiSjco84/YI2DmIOYFJ9JnpWx4FTWU46SbHR9YXyzEil4biFS3Hg
         RUZCpVXE7Vs43ZKD3OsQzC7ZPEvNIrg5jhrt0Om0oZ9Apf+uYwR3NfnPv1bz2AHR4N6t
         cq/F4p1nrjBRDXwOgOTVQw1dasTNTDde7dSevunOrLuIFX3874mSShJplWo5b3GHFrHo
         XYfU6ZMajrJ5ELQuKohwmBBIHgxcB3uSgzDWPAddLl0EQs6/gNksBY0vVq59Zj3LpI/e
         ELfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=W8L0CnPeo+zJeQ8xRjyLBCHZbEKtnFc6NQtkmoNRfPg=;
        b=fhVTR9Eqlhel5pZkGoTgzjKmUqvddlzVdsj1WrDHrdoI44CmWgHQTEt0O9jep3tEPZ
         8ey2L4TwstdMh8d3EXoJsVRU6YawKhwZdk/+X3N1e+wgZhBQJWeMNQZWRSoxouyb/gB1
         84v8EqWdgE2dygT4jd5wbPxPL0N79lQ8XwarCYFpWqxdubygcoKiuxOS+Z4CTXAu6Bj/
         bKOSYwmHc5tGfuKe4DBVV8FsLouyF3Xd8iiw1Me5RbgcJATcnnH57lsq0J1v9hatgSzw
         gZssS0oCg/vtW1HFhNSt682t1apG3aU/5ZZXShWbkr3f5DwH/b44y+hnLsHa8ljGkM4E
         DUtQ==
X-Gm-Message-State: AOAM532ZMwy5QBozk5PT3R1PSHKn/3dEvoq+JSJ+W3wFwHTRmBMK0uyu
        5pWqtTkKGcECGZ3vy8LpUvAK2g==
X-Google-Smtp-Source: ABdhPJx49vPMLykGle/vSjfNJPW3U6gZAM9Kq9P8hurjiE7iyhXMviZCSw+KSSOks4e3kzOD6psbNQ==
X-Received: by 2002:a17:902:7610:b0:151:6152:549c with SMTP id k16-20020a170902761000b001516152549cmr362574pll.91.1646426707865;
        Fri, 04 Mar 2022 12:45:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h17-20020a056a001a5100b004f0edf683dfsm6625776pfv.168.2022.03.04.12.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:45:07 -0800 (PST)
Message-ID: <62227a53.1c69fb81.82027.200b@mx.google.com>
Date:   Fri, 04 Mar 2022 12:45:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: thermal-5.17-rc7-127-g87852f90dc5a
Subject: pm/testing baseline: 50 runs,
 1 regressions (thermal-5.17-rc7-127-g87852f90dc5a)
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

pm/testing baseline: 50 runs, 1 regressions (thermal-5.17-rc7-127-g87852f90=
dc5a)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
meson-g12b-odroid-n2 | arm64 | lab-baylibre | gcc-10   | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/thermal-=
5.17-rc7-127-g87852f90dc5a/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: thermal-5.17-rc7-127-g87852f90dc5a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      87852f90dc5a429bfc19d3d0f909f00fda55a0f0 =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
meson-g12b-odroid-n2 | arm64 | lab-baylibre | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6222710909bec62719c62975

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/thermal-5.17-rc7-12=
7-g87852f90dc5a/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12b-odr=
oid-n2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/thermal-5.17-rc7-12=
7-g87852f90dc5a/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12b-odr=
oid-n2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220218.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6222710909bec62719c62=
976
        new failure (last pass: v5.17-rc6-115-g7c2ca3c76b25) =

 =20

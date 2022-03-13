Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B344D723E
	for <lists+linux-pm@lfdr.de>; Sun, 13 Mar 2022 03:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiCMCuG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Mar 2022 21:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiCMCuF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Mar 2022 21:50:05 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193405D18E
        for <linux-pm@vger.kernel.org>; Sat, 12 Mar 2022 18:48:58 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id s42so11339997pfg.0
        for <linux-pm@vger.kernel.org>; Sat, 12 Mar 2022 18:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=fhgSeBRjxr7eJMYvRhatFMqSt04PBD/AqJddO8Zg3Cg=;
        b=fVpQ22pFqFYfdf4fcA4R+ZNV+StDWe0ZurLugDsWrCCdPwdYXwgM1jRs7VuYhpaLeS
         0q6OpOJSaesw3zjolTDAd6wapN0nOAWlHtuAcdvGRU3OINyYonUdpGN/TfJLO3rkDL+N
         7GTTLSxu6WEuliFwGY2QxD9TtymOY0GXKIUzOqZcH2TiBXnOdTP1YYdqtrMOONrraaBX
         Ing7IldQxi0sd2HFIb6ntm7u6/ykFKPZk/Z2lr2DEiursJgKKOVYPLnJ9wgYDQPygwkB
         tZkX1OHgeX5LeXOh7sT3lJ1s33sq6CwyzvyhGGlCUx9015d+IiZVgs2dJDFWw0565Gz0
         +GRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=fhgSeBRjxr7eJMYvRhatFMqSt04PBD/AqJddO8Zg3Cg=;
        b=r5Eo4jBFc2xzOUDjcJ0+ld+7KPZwAOn8GNV3ZBlJDkcfGYPnh6ZMn5GH0FeoMFZ5do
         qQgTonZDwDw3HOSii++OJ9KhQz/9IhYbn2iNZ068AVEhNRnqM3K49oVIX0Ieg3velLda
         WFJTX332MGe5rHmYsjx5Wn2bdlLzmHMifBrJl1LzqH977lb7ffHf8mdy1uXmuNzvVUy0
         EXrUXrIjJLTJr58im/5m105zMF5Igzqk1L1alH3RzUzleclIyiRi2jAAncDnSKlzMiGq
         /rM1np76ft6QF19V52AUWIjmLvgYUvAI+jTeuo0G4cG66JMI+Vo6cPuJ4MC+ufHdoaMV
         l1jQ==
X-Gm-Message-State: AOAM533dcsBFJV4D6//89/YEt4aOMyj0B021tQzQVLBAPya3DWeKi0CV
        s7CNYhnlW1GgdxbaXNqYE6/4s4sn5X5BCScPrl0=
X-Google-Smtp-Source: ABdhPJwrTtFDh8YDVXML+CTpQ11Cq1FJGhzZMktXcviad3zWxUPnhTQhJybtKXj+943O7wpTmo5P0w==
X-Received: by 2002:a62:1481:0:b0:4f6:38c0:ed08 with SMTP id 123-20020a621481000000b004f638c0ed08mr17791650pfu.86.1647139737604;
        Sat, 12 Mar 2022 18:48:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f21-20020a056a0022d500b004f7a420c330sm4109751pfj.12.2022.03.12.18.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 18:48:57 -0800 (PST)
Message-ID: <622d5b99.1c69fb81.ae7fc.af1e@mx.google.com>
Date:   Sat, 12 Mar 2022 18:48:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc7-161-gbda0a27564ac
Subject: pm/testing baseline: 52 runs,
 3 regressions (v5.17-rc7-161-gbda0a27564ac)
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

pm/testing baseline: 52 runs, 3 regressions (v5.17-rc7-161-gbda0a27564ac)

Regressions Summary
-------------------

platform            | arch  | lab          | compiler | defconfig          =
| regressions
--------------------+-------+--------------+----------+--------------------=
+------------
cubietruck          | arm   | lab-baylibre | gcc-10   | multi_v7_defconfig =
| 2          =

r8a77950-salvator-x | arm64 | lab-baylibre | gcc-10   | defconfig          =
| 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.17-rc=
7-161-gbda0a27564ac/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.17-rc7-161-gbda0a27564ac
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      bda0a27564ac6b8ddd5972a7d630a62fde44ce51 =



Test Regressions
---------------- =



platform            | arch  | lab          | compiler | defconfig          =
| regressions
--------------------+-------+--------------+----------+--------------------=
+------------
cubietruck          | arm   | lab-baylibre | gcc-10   | multi_v7_defconfig =
| 2          =


  Details:     https://kernelci.org/test/plan/id/622d54e90a272bc341c62968

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc7-161-gbda0=
a27564ac/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc7-161-gbda0=
a27564ac/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/armel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/622d54e90a272bc=
341c6296c
        failing since 26 days (last pass: v5.17-rc3-39-g9b044ca4ac33, first=
 fail: v5.17-rc4-37-gd4e043a4af96)
        16 lines

    2022-03-13T02:19:28.614281  kern  :alert : 8<--- cut here ---
    2022-03-13T02:19:28.622371  kern  :alert : Unable to handle kernel NULL=
 pointer dereference at virtual address 000001a0
    2022-03-13T02:19:28.634007  kern  :alert : [000001a0] *pgd=3Dbc<8>[   3=
6.980731] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3D=
lines MEASUREMENT=3D16>   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/622d54e90a272bc=
341c6296d
        failing since 26 days (last pass: v5.17-rc3-39-g9b044ca4ac33, first=
 fail: v5.17-rc4-37-gd4e043a4af96)
        58 lines

    2022-03-13T02:19:28.634876  f16835
    2022-03-13T02:19:28.643049  kern  :alert : Register r0 information: NUL=
L pointer
    2022-03-13T02:19:28.644959  kern  :alert : Register r1 information: non=
-slab/vmalloc memory
    2022-03-13T02:19:28.650801  kern  :alert : Register r2 information: non=
-slab/vmalloc memory
    2022-03-13T02:19:28.655616  kern  :alert : Register r3 information: non=
-paged memory
    2022-03-13T02:19:28.664225  kern  :alert : Register r4 information: sla=
b kmalloc-1k start c4ec2000 pointer offset 64 size 1024
    2022-03-13T02:19:28.671981  kern  :alert : Register r5 information: sla=
b task_struct start c257c400 pointer offset 0
    2022-03-13T02:19:28.681221  kern  :alert : Register r6 information: sla=
b kmalloc-1k start c21d2000 pointer offset 16 size 1024
    2022-03-13T02:19:28.689573  kern  :alert : Register r7 information: sla=
b kmalloc-1k start c4ec2000 pointer offset 128 size 1024
    2022-03-13T02:19:28.695212  kern  :alert : Register r8 information: non=
-slab/vmalloc memory =

    ... (44 line(s) more)  =

 =



platform            | arch  | lab          | compiler | defconfig          =
| regressions
--------------------+-------+--------------+----------+--------------------=
+------------
r8a77950-salvator-x | arm64 | lab-baylibre | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/622d52122269e0b8a1c6297f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc7-161-gbda0=
a27564ac/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a77950-salvator-x.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc7-161-gbda0=
a27564ac/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a77950-salvator-x.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/622d52122269e0b8a1c62=
980
        new failure (last pass: v5.17-rc7-144-gcdd758e337cb) =

 =20

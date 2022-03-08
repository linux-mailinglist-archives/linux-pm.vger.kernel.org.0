Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED39F4D0D92
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 02:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiCHBiG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 20:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344322AbiCHBiF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 20:38:05 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879EA2E68F
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 17:37:09 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b8so15719746pjb.4
        for <linux-pm@vger.kernel.org>; Mon, 07 Mar 2022 17:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ODRsFJYS/2vQbriyTPqUHZvLfukf/0lKVIf0QsAkzls=;
        b=FiyVoJb7auYBhM34yGeLTwDsoK/jck9n6HNdaaZkysfEPuvj84AyI/8u51f25YmOQw
         rVXRdrWYETZ8e0tqFBVQKTDF34iSdG7R7wqq7qC9gYKjPysgSza446WTQz3b9tNUbuWH
         JoOBFLHgR28JyYuDkcJ2aO2ScMcLI077rAjm6ghzsqj7t05L7nC08C6J/qnGux1mAGA3
         jVXtQn8ctu9UR8h77I9Y6dSYNey/iHwMZ2MXjFMPjuLEqvI1AB+QtWTg2I7KF9haEd+u
         wzz/qbagowj4ZiKXTQ+5lYXPRw7GK0OnTdcn4mH9V/2zCEt7khIJHdIKnm3M9XcRkgCG
         272A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ODRsFJYS/2vQbriyTPqUHZvLfukf/0lKVIf0QsAkzls=;
        b=PZ5nhJ2JBVymtdRG+P3QowhG0RkYSX0qyCgP7ax3o1LJsFYaaVfM5AcnXOnCBI12PT
         09RjOq95F5JH0MLsktflEjBbPbB0d0RrWhwRhhoVX/StoY8pH/KFlX6yXWBIF0wcKuo3
         3lyX4WmaI1ePvgKE3N5+Rj4x3qzv5ODocysDRBUYUv5DoIOsjt0nhdWg4A6EkhdNM9ml
         bu0q2/tg12eRm84kQYkLx2aW7vpdQST2ufUrevjHQfoRnKPjkXSDESB0wwdZ7pKhvjOU
         aePclG/0wiK4NLlAbU+WYdnnU/tgh4Re4uxyVs8gBRQXnl+HnZ8WKKuH+hivdEAJiAkT
         JuHA==
X-Gm-Message-State: AOAM532sVRY3Ur6IZl9FPZ3ETMylfL8yZHHVdsd6zifSJId3nQWmm4/+
        lC7HVDr8T5nzQ6V1P0Np9wIsKhl/tYA/Ny2nKns=
X-Google-Smtp-Source: ABdhPJw7zj3PnfXG3dd7xnLv2ukyhJci5DrqpJS6b0iPBZKgR+d38J41q4sF7Bswdax8I8yaDuGNsA==
X-Received: by 2002:a17:903:1d0:b0:151:c879:3428 with SMTP id e16-20020a17090301d000b00151c8793428mr15050791plh.52.1646703428932;
        Mon, 07 Mar 2022 17:37:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090a414c00b001bf6d88870csm595768pjg.55.2022.03.07.17.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 17:37:08 -0800 (PST)
Message-ID: <6226b344.1c69fb81.8969d.24e0@mx.google.com>
Date:   Mon, 07 Mar 2022 17:37:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc7-126-g0b4cb964dac5
Subject: pm/testing baseline: 17 runs,
 2 regressions (v5.17-rc7-126-g0b4cb964dac5)
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

pm/testing baseline: 17 runs, 2 regressions (v5.17-rc7-126-g0b4cb964dac5)

Regressions Summary
-------------------

platform              | arch | lab          | compiler | defconfig         =
 | regressions
----------------------+------+--------------+----------+-------------------=
-+------------
sun7i-a20-cubieboard2 | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig=
 | 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.17-rc=
7-126-g0b4cb964dac5/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.17-rc7-126-g0b4cb964dac5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      0b4cb964dac51d55a3a3ed4db6536e8b4b31031a =



Test Regressions
---------------- =



platform              | arch | lab          | compiler | defconfig         =
 | regressions
----------------------+------+--------------+----------+-------------------=
-+------------
sun7i-a20-cubieboard2 | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig=
 | 2          =


  Details:     https://kernelci.org/test/plan/id/6226a3692c180b277dc6296b

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc7-126-g0b4c=
b964dac5/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun7i-a20-cubi=
eboard2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc7-126-g0b4c=
b964dac5/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun7i-a20-cubi=
eboard2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/armel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/6226a3692c180b2=
77dc6296f
        failing since 20 days (last pass: v5.17-rc3-39-g9b044ca4ac33, first=
 fail: v5.17-rc4-37-gd4e043a4af96)
        16 lines

    2022-03-08T00:29:11.865001  kern  :alert : 8<--- cut here ---
    2022-03-08T00:29:11.865260  kern  :alert : Unable to handle kernel NULL=
 pointer dereference at virtual address 000001a0
    2022-03-08T00:29:11.865434  kern  :alert : [000001a0] *pgd=3D7c<8>[   3=
7.204978] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3D=
lines MEASUREMENT=3D16>
    2022-03-08T00:29:11.865594  8b9835
    2022-03-08T00:29:11.865748  kern  :alert : Register r0 information: NUL=
L pointer
    2022-03-08T00:29:11.865896  kern  :alert : Register r1 information: non=
-slab/vmalloc memory
    2022-03-08T00:29:11.866045  kern  :alert : Register r2 information: non=
-slab/vmalloc memory
    2022-03-08T00:29:11.866190  kern  :alert : Register r3 information: non=
-paged memory   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6226a3692c180b2=
77dc62970
        failing since 20 days (last pass: v5.17-rc3-39-g9b044ca4ac33, first=
 fail: v5.17-rc4-37-gd4e043a4af96)
        58 lines

    2022-03-08T00:29:11.908084  kern  :alert : Register r4 information: sla=
b kmalloc-1k start c4e24000 pointer offset 64 size 1024
    2022-03-08T00:29:11.908311  kern  :alert : Register r5 information: sla=
b task_struct start c2546e80 pointer offset 0
    2022-03-08T00:29:11.908497  kern  :alert : Register r6 information: sla=
b kmalloc-1k start c21cdc00 pointer offset 16 size 1024
    2022-03-08T00:29:11.908652  kern  :alert : Register r7 information: sla=
b kmalloc-1k start c4e24000 pointer offset 128 size 1024
    2022-03-08T00:29:11.908794  kern  :alert : Register r8 information: non=
-slab/vmalloc memory
    2022-03-08T00:29:11.950913  kern  :alert : Register r9 information: sla=
b kmalloc-1k start c21cdc00 pointer offset 0 size 1024
    2022-03-08T00:29:11.951139  kern  :alert : Register r10 information: sl=
ab kmalloc-1k start c26e3800 pointer offset 0 size 1024
    2022-03-08T00:29:11.951315  kern  :alert : Register r11 information: NU=
LL pointer
    2022-03-08T00:29:11.951464  kern  :alert : Register r12 information: sl=
ab task_struct start c2546e80 pointer offset 0
    2022-03-08T00:29:11.951607  kern  :emerg : Internal error: Oops: 17 [#1=
] SMP ARM =

    ... (46 line(s) more)  =

 =20

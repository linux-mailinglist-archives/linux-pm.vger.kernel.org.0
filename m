Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44DC479ABF
	for <lists+linux-pm@lfdr.de>; Sat, 18 Dec 2021 13:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhLRMdO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 18 Dec 2021 07:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbhLRMdO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Dec 2021 07:33:14 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482FBC061574
        for <linux-pm@vger.kernel.org>; Sat, 18 Dec 2021 04:33:14 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so5736294pjj.2
        for <linux-pm@vger.kernel.org>; Sat, 18 Dec 2021 04:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=XqPLqDk5v5DvjKOte6DAAdt/wj+OXOli7oTDSj8/ezw=;
        b=ffpw3b91PeTxrVHqC/NPUSMWtj0DOLn5eNyMIPLBUXYgZc0kUcs9NEs+AfnuBz3sff
         q/Sr+PSM5qjesuYgHg4QnwiL+ykxnsiMQYatql27rALDjfTvt84L1TxDjbM5ACiOzdZU
         AggIQUOVKgF600sCMZJPt0+wQvETFyD9LTb3cdWxeJlY5veRbgJXXfHCQLMT97Y2PLO/
         yQ4KUbpng35Z/LHv1DONA4UpNKdx1Tb+vcl/SFFjomYLHkOIrC3Mhc77WYP/YIpmtDot
         LDWNpi5opr8edY+ufKgT9p4NYp9rjct8IrWQqwSGrEpDJNOJGauMk1fi7x+P0TcEJ01C
         fO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=XqPLqDk5v5DvjKOte6DAAdt/wj+OXOli7oTDSj8/ezw=;
        b=LVvsvV9Sw0vxU6N6+b1ip1SmUuJHxph7aVGG7+gGKlSWRBnaQfCLSqbF0EtNWpJVEL
         ZPlTVGsscoaYB9ENB1bCueJzQeQm1KiuUy0sAamlREDAxax9hKAIMp8lOTyIRhfyUaW7
         S/GtbJpowWlXACEcUBzPSH69TfCM8tKp37SunNd376ARE0dEiGoKM3Y74Lzeo1eRw+Y2
         sdpPeaZJURZZ0A2D53afdlk7Mk7vDTsxZ4jV8Y/R/JAZS/h+jonE4JIiqyCbvsrU2CnX
         GLxXhBH0z1n+pB60W3O5qB25LLG/foLEfK3AGd4AoTFI6Xwqh8pgiA7tWwninZfefOXM
         u5dA==
X-Gm-Message-State: AOAM53214ZdEPWVjwzoPHdCNd1kO/QzLB5uVvWdDf1S9v0/mRDEAElst
        swlA24s8NB3QI0WxttC31+xHoioqM33srqwO
X-Google-Smtp-Source: ABdhPJyEiqojVOaXN3VeoK+3Jw/GtMryQGkvjmWZQ8HWnv7r3p93yp88nyopVW4mXhZkEi+SxB4OiA==
X-Received: by 2002:a17:902:8f94:b0:143:8e81:3ec1 with SMTP id z20-20020a1709028f9400b001438e813ec1mr8003901plo.52.1639830793792;
        Sat, 18 Dec 2021 04:33:13 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n34sm770465pfv.129.2021.12.18.04.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 04:33:13 -0800 (PST)
Message-ID: <61bdd509.1c69fb81.19187.16ef@mx.google.com>
Date:   Sat, 18 Dec 2021 04:33:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.16-rc5-47-gd56e7f8e2a45
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 75 runs,
 1 regressions (v5.16-rc5-47-gd56e7f8e2a45)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 75 runs, 1 regressions (v5.16-rc5-47-gd56e7f8e2a45)

Regressions Summary
-------------------

platform            | arch  | lab          | compiler | defconfig | regress=
ions
--------------------+-------+--------------+----------+-----------+--------=
----
r8a77950-salvator-x | arm64 | lab-baylibre | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.16-rc=
5-47-gd56e7f8e2a45/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.16-rc5-47-gd56e7f8e2a45
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d56e7f8e2a454abe4a106bcf04153d8c48dad7b1 =



Test Regressions
---------------- =



platform            | arch  | lab          | compiler | defconfig | regress=
ions
--------------------+-------+--------------+----------+-----------+--------=
----
r8a77950-salvator-x | arm64 | lab-baylibre | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/61bdce199d120d3a58397157

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.16-rc5-47-gd56e7=
f8e2a45/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a77950-salvator-x.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.16-rc5-47-gd56e7=
f8e2a45/arm64/defconfig/gcc-10/lab-baylibre/baseline-r8a77950-salvator-x.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20211210.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/61bdce199d120d3a58397=
158
        new failure (last pass: v5.16-rc5-43-g8dff5ac97bf3) =

 =20

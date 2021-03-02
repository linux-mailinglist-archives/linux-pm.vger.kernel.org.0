Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F2E32A29A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Mar 2021 15:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376837AbhCBIMx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 03:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbhCBCEt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Mar 2021 21:04:49 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56264C061756
        for <linux-pm@vger.kernel.org>; Mon,  1 Mar 2021 18:04:02 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id t25so12846246pga.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Mar 2021 18:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=4m2uyJ9M1RTFiPlOjyQOTxYLlAXUwH5JMi1j4TlOYAQ=;
        b=Z/3hqwt2t4ueVjb0y4R44pn6FzX+By42qptupCg4+AzKHnETxq051cou6IkzOVeCOZ
         a3MJcy3l88/mwDEKqdwyRuZ50rAJGrr47JhYeKZ8fvfAH1SeLrKFOmkuL5LNuhi5qodp
         3QM9OW1pb4hr83guGpXSuwtcrKM9n7PDwTjAtbPuEapEEietD4sZi8ljCswlT35Xneh5
         dn5fllxKp138d8E3mMaucWm3SjLKQ+ckPlqYbZwMMSX/rrGWD0Limj2yP+pf1lMthKbr
         jx9BTngW755BF8mYlc4mXfX3/pQG4ZjfbP54xPkOEhYFvW66vo7Vk+1AxsMjwOo70P7n
         yp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=4m2uyJ9M1RTFiPlOjyQOTxYLlAXUwH5JMi1j4TlOYAQ=;
        b=UMNR5MT3BZSMCRqrOdA2WEfXx5kP7q9NHXvo8Lglsl+nL5u63Al8bGb98wZk/agDfS
         I3A3ndFodqLW0A4cKs9NqpR/ewjUDVurvxjNhj/nR8RoU1r0k/JSytIk6EsuATlhNax/
         uFxNA4Fdr5D+2Z0yoxwp7bmYkEYzxFN8KvU6Ht+5D6TdhPCpDdvgYCmIfUCDn5GlnUiA
         ojmVDPG5ZtK4bnWlD9Vsfy8ft58lSgzTAkuH52U07KUuZblA2CKyLY4e/zXPxPKgFC84
         KHDspvb6SRl0f43ToPvQFc8KGMZeVagC1U32T0trmgzSgczSZG3ClA735g+Cp6PMzAyW
         /cZw==
X-Gm-Message-State: AOAM530QYJu/Heud5G3nDteipAwQ5CAtt797+zeiIiFxV8L23S+f2nuA
        t6U9Z6rc4z9iYhGbhnkT772lOQ==
X-Google-Smtp-Source: ABdhPJzz79tCcLLhzCBOt/eDj3hhAGGWPf99gXM9ADR5rFGletASv7LWkkAE2LWZzs5ovG7za434Xg==
X-Received: by 2002:a63:1c08:: with SMTP id c8mr16124838pgc.228.1614650641801;
        Mon, 01 Mar 2021 18:04:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u22sm18088511pgh.20.2021.03.01.18.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 18:04:01 -0800 (PST)
Message-ID: <603d9d11.1c69fb81.4522c.a9e2@mx.google.com>
Date:   Mon, 01 Mar 2021 18:04:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc1
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 3 runs, 1 regressions (v5.12-rc1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (v5.12-rc1)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
1/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/603d8eadb5739fda41addcc5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc1/arm64/def=
config/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc1/arm64/def=
config/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0301.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/603d8eadb5739fda41addcc6
        failing since 194 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20

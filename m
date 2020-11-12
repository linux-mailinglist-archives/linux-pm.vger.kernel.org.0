Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D392B0E03
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 20:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgKLT1A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 14:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgKLT07 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 14:26:59 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CD7C0613D1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 11:26:59 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id z24so5056161pgk.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 11:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=3TPmqQ8BSEZmoQ5OChe+v5bIZYbT//Ax6JAedT1m3c4=;
        b=OyuJIs71aji82g21xn/cSPJpvsGYs+m1/RaIVMl4HwumW/Ff7VzIrwM+vHDD26bxSH
         nhL4e81SoLiZTFtLv7MeBnHRupo0H4U3mAZ3VTKdmwEBYqJ8Ols31Y7gfhZDqIdLowkE
         OlusaCsQNT076IG538vAwUMQwK43tAU9W0PYU07xO7S8mAPv7ttbGMk2UQiL8blcsQHQ
         Z+cDN3NxBMOER9W39fX/g/X/Q25yo77xMnrFw9XC+kZ/X8Mzd4JWyKE0kIzIGIKHHeEE
         tOTGrBZRYqiWFNlRVuAVsJ9WlxaEMMvJ03lkZZ8BLQ+MG0ZFk+Jr4AgIvuDmy/8THdIy
         /fvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=3TPmqQ8BSEZmoQ5OChe+v5bIZYbT//Ax6JAedT1m3c4=;
        b=P+BLtoplLMNcI65BNqBLRP+TjI4z9ncA6/AgaMFalP4YN941zOKq4bO4ZtLdNdUxic
         wc1u3XufK+9Vh3FYJntVjdUyDAjQEaZGTvO+lGzwQhWTeGM1kRhVl/FsImvhIO8EMoRg
         NBtqTBSoPgtnzTbTDkxIJhHm8uk0/sfbAfDX3dptdIqGuA/6W+cjfeHDf9mZ1F+dO8oM
         Cd+ma3aBatXFOWn5SOY4A4tYeYMCUApJvmSCA4UNR3PMaAjBSN/fHj3bGYTBE8yCvbKb
         4flBUpMzmUx12k6CzmWQos8t5dY+CWxRvn7G8SgV8HgvRn6QKVUap+q8j0SgHrMoaIxs
         lnaA==
X-Gm-Message-State: AOAM531h0P9S7i/Q7p0hD7hYQgLX3nEDki1X5VuFIFYuso3bIJvOcd9s
        O2krrAdGIBKgmiy2dcwHubPCiw==
X-Google-Smtp-Source: ABdhPJziZkm+hh2rXZsVkiAgS7WoG3H3Sr5fYmhocsOMiLIl09N7/qwhwD1gtLfxvjkutgSwJW9ADw==
X-Received: by 2002:a17:90a:67cb:: with SMTP id g11mr771804pjm.226.1605209219302;
        Thu, 12 Nov 2020 11:26:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m20sm6979693pfk.31.2020.11.12.11.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:26:58 -0800 (PST)
Message-ID: <5fad8c82.1c69fb81.b717c.e394@mx.google.com>
Date:   Thu, 12 Nov 2020 11:26:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: pm-5.10-rc4-33-g52d108cd060d
Subject: pm/testing sleep: 5 runs, 1 regressions (pm-5.10-rc4-33-g52d108cd060d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (pm-5.10-rc4-33-g52d108cd060d)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-5.10-=
rc4-33-g52d108cd060d/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: pm-5.10-rc4-33-g52d108cd060d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      52d108cd060dea3403c01d460c2ffbc7eaaf4a9c =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fad7acacb1118e178db8853

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.10-rc4-33-g52d=
108cd060d/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.10-rc4-33-g52d=
108cd060d/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1105.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5fad7acacb1118e178db8854
        failing since 84 days (last pass: v5.8-107-gb72b3ea38c81, first fai=
l: v5.9-rc1-4-g1f08d51cd57f) =

 =20

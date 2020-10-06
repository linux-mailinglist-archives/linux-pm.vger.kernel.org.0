Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219CC284BFB
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 14:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgJFMtu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 08:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJFMtt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 08:49:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4DDC061755
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 05:49:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p21so1514820pju.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=eJ1aq4jgjqD+XAdKnyKlrf72kNxBwvd/dyCBPHrWBCc=;
        b=tWV1i5KD4A7CLC4G5r0hmQpYRlwmk6lVI3vabttdA7R+77ijJ7HJ8hPEAiw83vjWFO
         lsu4OUwItUGuJzXRMLNhkuxtkLeR/FO0Y8HcZUEQugJrwdzy+xQOPGsOv6ooSG6cxBXO
         lpIRepNyqpOMhW/LRUbW5VRqLdh9WdQ+L2IxHdZ8I3kfb1VgQzbJD2pBMc+tQ5kTCQaK
         RbIr0/y2qbUXXyMwUJJuG0RLbKig6C84nM2qiEe5IZK/Q4XYlq6ah1QeH2AZADiOEZuq
         Srjo3DBa1wxo+OooOfN2QqtsUJfL4/R/pFTlck/OTh3wSf2lbkFuBY+ByzGxNdpSoNEZ
         FkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=eJ1aq4jgjqD+XAdKnyKlrf72kNxBwvd/dyCBPHrWBCc=;
        b=dhVnnsfXeIMQhqbRwyBLTN9v62owKIu5AHk9/m3SkGn1I04xgpbl/JgvxGgVP5rMWL
         zGdwlTtjEE5AuVBtQV15/7TcHkMXV9t9UdCXbGUnylgxC2iWP+VchC93Jc76/M37B1X3
         wT+NU9OriQ0id/j0jhbDgul+w8vqSrL9FPSbWlwVI88Faw5iirb/6O98HqxHsEahiF8q
         tXfkTp7x0BmR9DprO05C4IL4zsgIidElY+G1mElJ/JeluSMl9wMK+Mzl00kWlOX52P+y
         aXCys10A5wNKMAtUJ9JI4eU15GQbJhiQo8Gj1GvvFMPH8t5e+gILPb9q1jmfB2ptT4K5
         W+Rw==
X-Gm-Message-State: AOAM533uDAs0Uxce7ixOpoIQmsTdGSVccK30kpvLX3hkIHmvtzxioi9t
        QOGhZJxspBlsfc/1I4Daqa5FkoYEPwZF1Q==
X-Google-Smtp-Source: ABdhPJyU4xxUKSUbKTbjUDCd8JfmNtc62yBHKMCpPgWoaKMb+86mcKoyi8WQwhzqjGsL3e2fC5iCpg==
X-Received: by 2002:a17:902:7d8d:b029:d3:95b9:68ed with SMTP id a13-20020a1709027d8db02900d395b968edmr3132977plm.28.1601988589394;
        Tue, 06 Oct 2020 05:49:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q24sm2661017pfn.72.2020.10.06.05.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 05:49:48 -0700 (PDT)
Message-ID: <5f7c67ec.1c69fb81.a90f4.4ae3@mx.google.com>
Date:   Tue, 06 Oct 2020 05:49:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc8-137-gc3cdb7873495
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 3 runs, 1 regressions (v5.9-rc8-137-gc3cdb7873495)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (v5.9-rc8-137-gc3cdb7873495)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc8=
-137-gc3cdb7873495/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc8-137-gc3cdb7873495
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c3cdb7873495e5bbe7e3168efa9a2e7c988669a2 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f7c5ba934a7cb2c5d4ff3ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc8-137-gc3cdb=
7873495/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc8-137-gc3cdb=
7873495/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1002.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f7c5ba934a7cb2c5d4ff3ed
      failing since 47 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)  =20

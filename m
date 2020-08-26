Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A12F2539F6
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 23:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHZV4L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 17:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZV4L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 17:56:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A43C061574
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 14:56:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id kx11so1515782pjb.5
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 14:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=WURpRTOSaOVyGJd7bnpoqzz27D7sRqVnWbeCbMfajd0=;
        b=Kt0cRxZ5BBGJtv/HnNi5o5EngrvtBU8zgaTCnkGjk8Qg8bgIyGpXkxJn9i6hPgTqt7
         wKlx9/7mheVVCp8Qhy+lk5pZvAJyo1y6juVmGYW2otzAG7XllxARmDpOdknMHpqOQ4Kt
         zw3XzD42TMUbjsmUbfBLsp3A4Ou2KzYwr+AKLOGEdntPZ5K34X7UyJm4ZimvUm9iQV30
         v1GLMb84C6FcVscASxOkgK3i5ZB1s1xYYlbDNCGijcRneA5Y/qqwAZKYrSbJQsIt2Vm0
         /1JWXDsGOwLMddQ0EmS3NPloSizIp1rmQPYTLtMldygGh6oKy4Ph6deotqn/Y5b0ukMQ
         Io2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=WURpRTOSaOVyGJd7bnpoqzz27D7sRqVnWbeCbMfajd0=;
        b=lToLQOIBWWzDuml8GI9m7b0/W2rsfFgfJebfZQJXlfIdS55pbfE/Fy1mTuIB16wzdc
         YuUBzHO65i4qUb6nKSXhAjjV6CF5WMLoLrCn5wVKvYcd7jzxO2S43yCNM5hC67XsbkyL
         sw5wXrlAB7C0/6mfKdJ2b0uK5GSL6wImUJyJ0H2aA287jVXXWc7T0ZuLvhzZ2fqnd3qA
         n0HH23criM96fgV0oP4lgtdMuKDwCQaf/QeQo7l0vz4oxToTOhMxafWwjQpHVSLClRbb
         FOP3OYebndfMPkhFgIAPJsVKoIJKO5s1KwSHq+lAfXzAnW1zc2YSBAX4OwgROwUF6Wfg
         5QSA==
X-Gm-Message-State: AOAM532PUFgQx4XHjbLQvRN3SxRrnbuiafqdPdjGaZJi/g767GJEbeEP
        oaF/dhdKD8JpmGoI9gMBAKdvDQ==
X-Google-Smtp-Source: ABdhPJw213It8cd0/zIIxU3/vPpvLeRUon+iieAaVdCW9DqQkppmvYxidyGXvcobvDxLduDIc0obHg==
X-Received: by 2002:a17:90a:d253:: with SMTP id o19mr1062838pjw.196.1598478968244;
        Wed, 26 Aug 2020 14:56:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u14sm150908pfm.103.2020.08.26.14.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 14:56:07 -0700 (PDT)
Message-ID: <5f46da77.1c69fb81.e3f1c.0df9@mx.google.com>
Date:   Wed, 26 Aug 2020 14:56:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc2-14-gfe784821d630
Subject: pm/testing sleep: 1 runs, 1 regressions (v5.9-rc2-14-gfe784821d630)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 1 runs, 1 regressions (v5.9-rc2-14-gfe784821d630)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc2=
-14-gfe784821d630/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc2-14-gfe784821d630
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      fe784821d630f71eee1f431f10e08518db42dc02 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f46c86b0c0bb888419fb442

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-14-gfe7848=
21d630/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-14-gfe7848=
21d630/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0821.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f46c86b0c0bb888419fb443
      failing since 7 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)  =20

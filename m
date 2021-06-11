Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11743A49C1
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 22:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhFKUDc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Jun 2021 16:03:32 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:45922 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhFKUDa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jun 2021 16:03:30 -0400
Received: by mail-pg1-f180.google.com with SMTP id q15so3284423pgg.12
        for <linux-pm@vger.kernel.org>; Fri, 11 Jun 2021 13:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=f35T/APy5uvNlXS5kiawBYoOeEmqze0QHHJzbO5ElhI=;
        b=BoqapoaPIjRaR5KDbxmpb4Hy7ypKEinlreMRoIzcCs4XvcR+xoPFYTtPhg4cB5avyR
         r9JkjiRCvEqNFZL8k72I5MIsxg4HTi8BsjfHOpcIrXj84db4FgN6ycVSySIprkRmCDm8
         x/tZ2o1VcKJk6ve3zTwVwp9cxVGWYdtJu7naT5+rDRhNBI3mqIFQ+ANuEZORF48+EEjy
         CZ9S4yI1JA5DKvbEGSxedOU4vR7+KPT8b7C7j0Ofa0kFY17teMaJ3aVovdTUEgc5e+b/
         Uslwy58vdh7XYH0NbAip6pNRjUiIwm+p/cxs/f7RUaeL951ZbWMShxKYJqUxMY8iUNGq
         vgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=f35T/APy5uvNlXS5kiawBYoOeEmqze0QHHJzbO5ElhI=;
        b=g3v89W8zpF2j6p5iAleCoqSBHckGI99JJ9J+eXSw8YiSokUlKoTb1eHWagLpGmGj9Y
         +B5/iSqFaBaHHySjw/Tru9OI/eeTulaCA+/cu5Adr+6FGzoxGJcB9hY8eE9wh+96vfSQ
         VaKI8xK3gABYTVPz7V1Ccyw2S5BSTnLcjCdHouIaTAS4SzzLVZ1ZkSwlcGYpaMOGEQgr
         YAchKWJxuN0eTj1SHzDkGpMPuh1VavNnC2fN6lP+LAkctzu4Iwmti03UrliC21lFQTuB
         L01xeWimQO58uWqCCrFaHRMgs3oe+Rw0S+l2twdTJPuW6n6TquVPiYVSvwo0dtD2xQ4l
         T72Q==
X-Gm-Message-State: AOAM533c4BsopRyxjiiTbs1x9fkObjeQp04+IBMxJKJQlYTZZ/0KVOBh
        8w5bQRxfa34XlpFQpH+PmVnNgw==
X-Google-Smtp-Source: ABdhPJz3cSdjehJ5xL/efYJiEXIVATHOWN4Wzi1Ft8IQZvTQcb7oGTDi1FZC2YD9tD1MYfHABMJIog==
X-Received: by 2002:a05:6a00:10:b029:2f5:9339:1e8c with SMTP id h16-20020a056a000010b02902f593391e8cmr9076259pfk.42.1623441619728;
        Fri, 11 Jun 2021 13:00:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p37sm5688053pfw.166.2021.06.11.13.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 13:00:19 -0700 (PDT)
Message-ID: <60c3c0d3.1c69fb81.1f66d.1b14@mx.google.com>
Date:   Fri, 11 Jun 2021 13:00:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.13-rc5-112-gfce7d470d0dd
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.13-rc5-112-gfce7d470d0dd)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.13-rc5-112-gfce7d470d0dd)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
5-112-gfce7d470d0dd/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc5-112-gfce7d470d0dd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      fce7d470d0dd8960fb8fff2c6adcdea7646a85a9 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60c3b3a3d9c5ac50c90c0dfa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc5-112-gfce7=
d470d0dd/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc5-112-gfce7=
d470d0dd/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60c3b3a3d9c5ac50c90c0dfb
        failing since 296 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20

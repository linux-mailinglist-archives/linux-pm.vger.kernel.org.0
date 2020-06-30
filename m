Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FDA20F981
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 18:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388541AbgF3Qb5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jun 2020 12:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732008AbgF3Qb4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2020 12:31:56 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71D0C061755
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2020 09:31:56 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h4so2586566plt.9
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2020 09:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=lulc8sCBZxSsIDSGEDtjINzC+/cThYmKQydGNOLrXZk=;
        b=aKUgpSD/He1pCv7TvCNXwV9z+Q3uGOGLxilUpyitNbMesfDm95S24P973smJiUd0lo
         YQtvwzaWvCkwIjO6scgIJ74QMzJeyFxaqde9lRcRdhyY+/ISOpVE02jJ/dqKn5r6W6br
         4G8AJicwQ88EEvLk1uY1F0/7E6HlxzJ1T0t4Of/v4rS982I4mMvIeSSmcORRkLRGUszd
         nTgJY0zLaVwompnDKBYfCXolengsNSyItqi0+bZEfTHuAUqsQ3CXx1zHPogm3p68NQ+l
         pyp9GtA86QZ2YiaDXvty6LohelyfJTfku8txJc6ED7Bi9qrcF11YHaLb85bp+PFKS5j1
         kUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=lulc8sCBZxSsIDSGEDtjINzC+/cThYmKQydGNOLrXZk=;
        b=Ccpff5uvQgKAsivl2qGjUo+8OQTj6kV8sEqcb1e03JEh9YRMjx7Ckid2Wa0z3yCBTn
         AMNStttt1pOonWSRsFSxrk2/4S/9QGXUKjOwLlZn7Vm07i913jtxW1pd7LdHtXKkHYCi
         NTzgqMLBuUS+EuaoSLh7DIfiyoIzN1osIb4ZmXPGngdylwuQuc7KeIas9hNWCT51W0F5
         DuP0aA03i6EkSSjxS074x7rg4EaP0AiNmYG5gCRxBqWQtl2cG4xPGJDXnZWAJUQ9wzki
         pm9esPkIL3Dbm6SpBdcUXVzYclllrmF5kcr+i+YIvIKLQYMOOqZFVitCmEH3ilC6Nv+d
         beWQ==
X-Gm-Message-State: AOAM532llEQqFaerknLMOI0q1w/3AYMzozBkJz19d1g+Q+8LMArRuYTu
        cVJ6p3Xy6I1Tg6zjUnGkCiGohA==
X-Google-Smtp-Source: ABdhPJwTlyv2TA/q9N6YOe9W7ECy+4TC0eVFcKpSHM0OTvDRAYxowppQyUFCmnMW3HlFl7hzK7jaOg==
X-Received: by 2002:a17:90a:1d06:: with SMTP id c6mr7037791pjd.194.1593534716224;
        Tue, 30 Jun 2020 09:31:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m14sm3183697pgn.83.2020.06.30.09.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 09:31:55 -0700 (PDT)
Message-ID: <5efb68fb.1c69fb81.621a6.8761@mx.google.com>
Date:   Tue, 30 Jun 2020 09:31:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc3-22-g0169dcbef89a
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 77 runs,
 1 regressions (v5.8-rc3-22-g0169dcbef89a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 77 runs, 1 regressions (v5.8-rc3-22-g0169dcbef89a)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | results
----------------+-------+--------------+----------+-----------+--------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.8-rc3=
-22-g0169dcbef89a/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.8-rc3-22-g0169dcbef89a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      0169dcbef89af55d4b2bb8ac0762683622e532e9 =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | results
----------------+-------+--------------+----------+-----------+--------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5efb5d021e13014c6685bb30

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc3-22-g0169dc=
bef89a/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc3-22-g0169dc=
bef89a/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5efb5d021e13014c=
6685bb35
      failing since 0 day (last pass: v5.8-rc2-27-g3168a010c528, first fail=
: v5.8-rc3-20-g4ebdb176f4ab)
      2 lines =20

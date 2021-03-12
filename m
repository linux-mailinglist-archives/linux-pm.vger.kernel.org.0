Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DAE339906
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 22:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbhCLVWM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 16:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbhCLVVp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 16:21:45 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E841C061574
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 13:21:45 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id p21so16674484pgl.12
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 13:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/AwLIc6zJlLtPmMcfNZMysP1AMmo5TWzcDGkNIiGBbA=;
        b=zq0M1eW7AtC8FDSq5GQ1UBka4rF/23tOjcxTkaTmhmcqb+J96do7C1ykJS5Sc+kPk4
         oJHYXCAjlGnYnJ0JgHhUG4C/KPveY2BcrvtFgTeILQSH7a5w2RtnN1IznagSmuNw8LHj
         SemLPSKaUE6XRuOCubK0pmScCj6G0lU/LmB7AAMLSFqgz7HSeJAdyu/VIEEGLMWb67AB
         SLET7lgv2reZ0aWIPxgBy2gstEMhoVD49Lc95JpsHfdU4ZnX84tIA9EULVh4/DlGo9KR
         IRpl69bhB8mICmbQLub5J5i4sGtd72Bt8jd6fy+ohENO/MB3cHDgoXJggQXPfUoYDU5V
         +tZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/AwLIc6zJlLtPmMcfNZMysP1AMmo5TWzcDGkNIiGBbA=;
        b=P4pVPcgHhsivFrZXGZW72qFHdzozxvKc3fXL6RXnlf2g5V5rnbK7s73L4Xli87nA3N
         JjV0ME4tEPjoYmjnSFuLVRA4tLSFZ7rIgpKnwnL8NnQ8T20chfwXg2JVNmbmpQTaog8q
         6linFTNBDNb75fIS+3ou0QCP7WZimOB352JSo0mX9nMPsod14nUN+Y1hj7TtYJJ17Dgr
         W8uQbIyxU1AgaU+jxnvIpC85w1ImnpxQc8IBbluAcY/0jiy+eyegcB+C5mnf3ORZRxu8
         eGv0Vw1rS1fO5AAXcWZN12zJQTEdfzLOcrvuCKR+hD2DED1FOzrolFXJxxBA7kCMPnTy
         wvAQ==
X-Gm-Message-State: AOAM5331pwQFGzmTlf/Ccp2DSOYjq7meljNsKdug9CAnbqtdPXF1rxxj
        NFMPZxjE5WXcIkf9M22rfU2i7A==
X-Google-Smtp-Source: ABdhPJxjZW7tXk/iQIYNmJHlIyhKtoGWJOJigzCiWMt8zSxHjsQqi7II6Zhqtrc9a1IlFveg7y0vhw==
X-Received: by 2002:a63:5625:: with SMTP id k37mr13195690pgb.96.1615584104901;
        Fri, 12 Mar 2021 13:21:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h16sm2855559pfc.194.2021.03.12.13.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 13:21:44 -0800 (PST)
Message-ID: <604bdb68.1c69fb81.e3693.69ed@mx.google.com>
Date:   Fri, 12 Mar 2021 13:21:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: devprop-5.12-rc3-29-g42326a293954f
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 4 runs,
 1 regressions (devprop-5.12-rc3-29-g42326a293954f)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (devprop-5.12-rc3-29-g42326a293954f)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/devprop-=
5.12-rc3-29-g42326a293954f/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: devprop-5.12-rc3-29-g42326a293954f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      42326a293954f11eadf31161b8315bf6dc2279da =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/604bcee6d40d172220addcbb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/devprop-5.12-rc3-29=
-g42326a293954f/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/devprop-5.12-rc3-29=
-g42326a293954f/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0301.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/604bcee6d40d172220addcbc
        failing since 205 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20

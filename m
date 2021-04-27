Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C972C36BCD1
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 03:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbhD0BCb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Apr 2021 21:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhD0BCa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Apr 2021 21:02:30 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE25DC061574
        for <linux-pm@vger.kernel.org>; Mon, 26 Apr 2021 18:01:48 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id s15so1498320plg.6
        for <linux-pm@vger.kernel.org>; Mon, 26 Apr 2021 18:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=w9q7rm6xTidu6h7WsBfFbdVbCJrVEKS2QqFAk3VBu6Q=;
        b=GOSS/UnzFMCb8gvCoAS//XmDEmX/XwF9nYrw3NQBWdPbJwXdrFiYltcAXkShb9mrLY
         W2ZYj8qNb9t3G6h4b2CRRVs/x3OSBX9BOaq434nCQPdTfSIxWryFAZcyCWBhtOvPHAvV
         v9nDSi3xuiZMEx4OyY+EvqcRYnvjSNrDEa9xFoLiF0CXc3Xg6z3BwKiOtuMJDX98HhsW
         bTS0RYHaXxPKi0cAOSt15Tlv1Tjom4bq+SGLUmTEBGdwuiO+zzNdB7FmNAY9vX73Zw+x
         qN1U3T9u3ZU66n38WCT7stvlQQ1kfZ83uKntHqXsFVTRRo/C5e2kyAkME8Bx/htuqoPF
         bqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=w9q7rm6xTidu6h7WsBfFbdVbCJrVEKS2QqFAk3VBu6Q=;
        b=oEF1vjHVTr8Qz6HE+RnGa9pURjDAErBLAgybhuRer4knPrrHqTCbALgkczzWYRo2w1
         h29NyCf3H7nfWALziW6DYTej+PjvxYrVIw7jMdo/+cTB4yDCQ1fRws/9evSamfcvWAVB
         f1+IKm+FuSGFd9vTzMstWVz0V0X4EK8MkKYyk3gIyn5yPWQjbCa2V/mMbaIGZAsKNwyO
         LW3FQ6r04LkJV73Zb659+MCFffSBjojYX1ol0kMTgyDKY0cFZ8iq6DZB5XhmSdC73GWL
         Alp7PBSUpsaD+5YB224fVhDpI8m0IEkjlf4TCAYVG/wL3G9Qhx3pJ5IuHZ8gxXnlYhgd
         7mOA==
X-Gm-Message-State: AOAM532h9A/doM5r7HowbUNIFxVg1thYPP3j6Nu989/+YxGpKJrqKvm2
        qb0rix8IlrPLlN0f/ySjZZrjAqYyeEP58Kmv
X-Google-Smtp-Source: ABdhPJzsm1GMPyz3+8DUmOATvDdQkM7gj0LulmHrOh+xFBlniTJrTDhxIOGD/HILgh5y+YtPeFBzpg==
X-Received: by 2002:a17:90a:ea11:: with SMTP id w17mr2065523pjy.6.1619485308326;
        Mon, 26 Apr 2021 18:01:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b1sm13507164pgf.84.2021.04.26.18.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 18:01:48 -0700 (PDT)
Message-ID: <6087627c.1c69fb81.9e33e.7ca3@mx.google.com>
Date:   Mon, 26 Apr 2021 18:01:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc8-168-g3c44d15e5ffdb
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 7 runs, 1 regressions (v5.12-rc8-168-g3c44d15e5ffdb)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 1 regressions (v5.12-rc8-168-g3c44d15e5ffdb)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
8-168-g3c44d15e5ffdb/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc8-168-g3c44d15e5ffdb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      3c44d15e5ffdbc1b9d31d098b65c5cb50211d802 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/608755cea931a9e2f79b77bc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc8-168-g3c44=
d15e5ffdb/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc8-168-g3c44=
d15e5ffdb/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0426.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/608755cea931a9e2f79b77bd
        failing since 250 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07A42C5C67
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 20:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405182AbgKZTCT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 14:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgKZTCT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 14:02:19 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DD8C0613D4
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2020 11:02:18 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id m9so2375727pgb.4
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2020 11:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=da2pVb0Er/S+edmeutgX7lnXz4y31CMb6C+MCjrl/zk=;
        b=FchqniPESv05JHho1UaBuSNQQQSxNfSihOVHNXdGnJCTcbhJHpNnws872O5+LBgfGz
         3rBkpR0CZNCsHdyROqtqj0K0u7M4R3c/TnQImff0kETz5K3p/2oBXhdlZD38KYK5LPcp
         U2NjtZtBDuipVO9vYTeaihjPFvih2G03cF8EyttrQle2tTxOWJMUOFaWLsGvxVDBR/7C
         Ywdg7joPI2DrYW3REn0Du10fuPPw75hIif76yyJoIxmqUeMLHx3ZYlTmUaeiZWYbEwiF
         ll37H8MlmPLIiRGdIaxf/iP2H7zI2xxxOdGkW1k0FgC6NeVXPXacQFVG1Yr+rVbCcJQF
         U9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=da2pVb0Er/S+edmeutgX7lnXz4y31CMb6C+MCjrl/zk=;
        b=t8fE97o6KMWlultbbkbE+lEFoJnMInFaj+2rcLimL9y6FJAnOJYdWu91vejJQrB/a4
         83uuQCey4Y+vzhso5y+E9e/j3SzFQegtjGmb2zl9+XlhhePdmuI08IusOahg/7afot4U
         L5F8i5DMD6rWwuegELe+zJgDEDS2xKBccJ/WEskno2uXN7TpOt9q1vTq0/VeSYROJlhL
         jl8tjM/+QzVjJ8VTJ8g+Ai3hTZDPX+D2rRzLbs3dHfeATyTN4h/rD8SDcLWk7ahTEbuU
         Ewx+xeJdDGD3MfM6DRGTZAwujnJv5KW0tywbc238qO2ZUc6vxqJ7Q4NFbipIbIW2A9ns
         fVww==
X-Gm-Message-State: AOAM533lnxITKGZmdcEJCmU/nmNF8+piwPQyAu/3inyQmUgU5gk2vIh+
        GVeYhLnxGdUyuTf9Xx8gOOjHkg==
X-Google-Smtp-Source: ABdhPJyEX9KmTisBMb0cXBSnW75DVtObJu/qiKECwUpOtPHPC/FliSbhF7MlJu55Fezsh9Ub31Gyrw==
X-Received: by 2002:a62:2cc3:0:b029:197:dda8:476a with SMTP id s186-20020a622cc30000b0290197dda8476amr3632043pfs.37.1606417337822;
        Thu, 26 Nov 2020 11:02:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h1sm7106792pjz.22.2020.11.26.11.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 11:02:17 -0800 (PST)
Message-ID: <5fbffbb9.1c69fb81.408eb.1c40@mx.google.com>
Date:   Thu, 26 Nov 2020 11:02:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pm-5.10-rc6-75-g735f7fba25ec
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 6 runs, 1 regressions (pm-5.10-rc6-75-g735f7fba25ec)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 1 regressions (pm-5.10-rc6-75-g735f7fba25ec)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-5.10-=
rc6-75-g735f7fba25ec/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: pm-5.10-rc6-75-g735f7fba25ec
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      735f7fba25ec002ec984d45612afaa3a553fe05d =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fbfee406aa99f5846c94ce8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.10-rc6-75-g735=
f7fba25ec/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.10-rc6-75-g735=
f7fba25ec/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1123.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5fbfee406aa99f5846c94ce9
        failing since 98 days (last pass: v5.8-107-gb72b3ea38c81, first fai=
l: v5.9-rc1-4-g1f08d51cd57f) =

 =20

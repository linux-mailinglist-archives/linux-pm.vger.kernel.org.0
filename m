Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C1031E1DD
	for <lists+linux-pm@lfdr.de>; Wed, 17 Feb 2021 23:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhBQWOq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Feb 2021 17:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbhBQWOl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2021 17:14:41 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083ACC061574
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2021 14:14:01 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s16so85518plr.9
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2021 14:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=riZhsWhKU0dm/J5AOcoBM++eYapsJeL1OmU541ESLhA=;
        b=VhVKWzSy93h1BBhC1girL6Hxpq5EUorrk4L5k60hjmekxi1ybETqQ9leBOP2l0rQLZ
         evrRf4xhh3DepT1dQnAAeFvqY9Nr7KTnoTB31TU0neKuT4IJ2GWiMplUnNkL/dbcPdgR
         X6LAI+UuLFLqzvczxq5Vpg7yX3BKec3M0hAYFDnclCVzNglJ2Xrq09qAOYBX/f7H8RyX
         BTxe8B7MqO+lRjrhAQDmsOj+oze9l8aDP7C2ovPFmEa04XOor/bnM0LoJJ51A20LG8oc
         /JjX76xR1HWVUiVPkfImxsvbXPXyRXyp6NdGjRsuxxqGkY55M8rSkVT1ytfdeL+9J1Cz
         2Urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=riZhsWhKU0dm/J5AOcoBM++eYapsJeL1OmU541ESLhA=;
        b=d+GvQUGyqh/ufAO/Xm7PP03zukdHH66WwhII7deOmRCjKT/heqltii4GyxbY3jxpRv
         /KyRRqB9qL5X1837k74ilUVkuXNiTxRXLAI/82YnArMhUn3qB8WUr5zOjJXzjPeuLUku
         Ch5H9VarCaqwxrWDIRx6vlG4PavZNeUEp/BIY+U/zgs7i+fFxjWvO+bWTKmj5cxKfVSY
         uM0fKMX/cy1Lfh3mdAPHt8CJq3YhppBQm3BaUYKFu3iQ7LyiV6/iU1dFTGejpp73Y7As
         wOFa7KhyMFVReSAcdx/0zqAZFIp6UoFdDQODUw7H/0eUftiIH12eOBocAWeZy+yl/JBi
         Zptg==
X-Gm-Message-State: AOAM532FzbQsSR+909ybCKYxULgYopVWUhZRJ4Jlni55rbZ+palPLQlT
        2lBLe/VZYkSqbGBIiUMFYNxTWA==
X-Google-Smtp-Source: ABdhPJygYxoDowsWg3IeBZ6wlkM0XiLcs5E5Z7TYpKTJ1vP4kfH5GuUZbwLwWRsNU3n4F0seZE9o7A==
X-Received: by 2002:a17:90a:ff01:: with SMTP id ce1mr902746pjb.164.1613600040636;
        Wed, 17 Feb 2021 14:14:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k24sm3331016pfg.40.2021.02.17.14.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 14:14:00 -0800 (PST)
Message-ID: <602d9528.1c69fb81.7309e.78f4@mx.google.com>
Date:   Wed, 17 Feb 2021 14:14:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.11-156-gc9756fcd3979
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 6 runs, 1 regressions (v5.11-156-gc9756fcd3979)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 1 regressions (v5.11-156-gc9756fcd3979)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-15=
6-gc9756fcd3979/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.11-156-gc9756fcd3979
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c9756fcd3979ee48382b8e442bb0375bfa05291f =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/602d880c98ce68eef9addcbb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-156-gc9756fcd=
3979/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-156-gc9756fcd=
3979/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0215.2/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/602d880c98ce68eef9addcbc
        failing since 182 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20

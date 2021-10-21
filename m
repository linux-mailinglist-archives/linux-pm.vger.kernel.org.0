Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24A7436202
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 14:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhJUMq6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 08:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhJUMq6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 08:46:58 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E652C06161C
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 05:44:42 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q10-20020a17090a1b0a00b001a076a59640so5741116pjq.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=fPZhRlmvmcNir1y76+yyNj29wU9R71kryN4Jj//f9Gw=;
        b=VJFsAT4KFkQ2egc8wLWcl8dJNQL67dRFBHLCnp/YSs++OErr+lxRRFapEnSWqdDVcd
         /hemxx8ipSuJrms6gW2/kAjpToQcRcKpVuTXzyinFvwhUfHnBmm5KQwVUg6A/pgDITY+
         4TQSVwq1KoDhw5zbEYFxc6kG6hP2FEKqDY9z/bLK+wwbUhCpmJ/R2EFsE2SdEVUgk9rN
         Pnz2wiZiHWnHu6qpRlHUtAQvwPt+xW7AWg2WOo2nqnZNUpe2QRVN2vrCtqLf8mtzNufG
         wkH/6XqlBuilN2KBeujzcrEp0Uoyuef3ukA4F2p0OHBTpzbOfRqUOIYcoBQQTsVaDqlS
         9GnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=fPZhRlmvmcNir1y76+yyNj29wU9R71kryN4Jj//f9Gw=;
        b=oaV1rfMrdH82/alO+EMq2qM6E9OpPjW896/qQHXKwcX0nKtoYViVZT8NYK59anwGsm
         gbhS+9OuFah+xTp+J7YCp/lSsFj3Z/QvbeY5UIV+RFnR00wlZZ2EC9gSSQkHG6LKtCiP
         X4R80U9NJ0fGnIDWhrbUIFYFiYIdY2Ui9h9ja0eQSP/NFU2qdGrt3ZbjCo+qnx2urFhO
         KVXNK90mt/LeDwXcrDi84+7+CDQTqcNaXN8N3yP/bZUXJLdAQUhK6k0QY3AckdAqLZwc
         nfbyMC/dKYWt3Sua23Nodvy2FlTWikzvh+spwkyYDcp0sdqbBcPwlzeqeIIBKeW3/xlv
         HOHg==
X-Gm-Message-State: AOAM533wIaXWTur+G/xoDOVXAmfhjclHunRCM3aUxzqcBQQ9m/lYZEWM
        NSOGXHCLxJsEijLaaKTSm97EyQ==
X-Google-Smtp-Source: ABdhPJwa9Jnle0wSOnXnh7ictqox+bh0Y/sY37JRca1kOM1++rUtY0gtmlr/iowyY/ncOcGYYBSNGA==
X-Received: by 2002:a17:90b:1bce:: with SMTP id oa14mr6395999pjb.225.1634820281776;
        Thu, 21 Oct 2021 05:44:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h23sm6365691pfn.109.2021.10.21.05.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 05:44:41 -0700 (PDT)
Message-ID: <617160b9.1c69fb81.34573.0b97@mx.google.com>
Date:   Thu, 21 Oct 2021 05:44:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.15-rc6-69-g8b39e976f0f8
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 66 runs,
 1 regressions (v5.15-rc6-69-g8b39e976f0f8)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 66 runs, 1 regressions (v5.15-rc6-69-g8b39e976f0f8)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
 | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
6-69-g8b39e976f0f8/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc6-69-g8b39e976f0f8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8b39e976f0f81dd610ea1d7930dc8ba662b639b5 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/617157a035ac120dad3358fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc6-69-g8b39e=
976f0f8/arm64/defconfig/gcc-10/lab-collabora/baseline-meson-g12b-a311d-khad=
as-vim3.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc6-69-g8b39e=
976f0f8/arm64/defconfig/gcc-10/lab-collabora/baseline-meson-g12b-a311d-khad=
as-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/617157a035ac120dad335=
8fe
        new failure (last pass: v5.15-rc6-67-g7f01eda12647) =

 =20

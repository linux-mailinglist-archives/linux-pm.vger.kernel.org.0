Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168043B6BA2
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jun 2021 02:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhF2ARW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Jun 2021 20:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhF2ARW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jun 2021 20:17:22 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DBEC061574
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 17:14:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso1243707pjb.4
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 17:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gabiYu0e6osFZ9R6+hKQgzOs3WpDhYxwp9R9im1zJD0=;
        b=EuEjFtNF+TBKgCrd6Tu1JzX3CeZqbnF/wEm4sHyiqIk3ukCcxL5O2536TVAp/tdZCl
         hS0TRq22QxqWqGfrFNHw4yTscS70ZrCxZqUlJbVRRKZBWpwQogWyy+YB8CtvtuLbsxHO
         FmoCMVck9YUi6PmXUwcX131z+J85q+AOutfVlO6BVRYrrOCKbBxec0z9EhW/YEzmQrpL
         xX1p7mgjR+PdcA3z3Dq/cWEwCnkph783IoM967gPHjK/+vuBRbaSdzclthCxhZOl6rB+
         hflYDXS13XEve1g7PHwJiL40fLmp6m8/gOty6SivPED9Qqv17DufNrUkD4b5bpFshfOV
         TFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gabiYu0e6osFZ9R6+hKQgzOs3WpDhYxwp9R9im1zJD0=;
        b=aHIjuCS7Mcy6yrmg8K+fRhMJMAytO+XlnFVwMd+rfKpNvvxfjN07tpIMVbLt7VFTR9
         DHCIBgB4B+dxfXOiyJ2J195NS5zXJINaE1XjoVAXSBBMYSvv4ZqGgVGYdQqknlLKv5Jz
         3hVNJaihn+0YuNjqfcWzCD3NTxK0JXQtO2Ky2z3IkkUPts70AXPNZ7IcXLTfgc9vzYrk
         JFhT+1wvpkeo8IhBPo4C43IX8GNYIJTjXBZIoooPwkbkLfXz9xhih8CpoCDEVBI1rNvj
         TgnxoKIy0jnpgrX6yifnwqJf+qx0b0+8fqlrZ85dw03CA3r1LyLNIaf97icrsZ2HzDTZ
         fSmQ==
X-Gm-Message-State: AOAM531x2WUpVifpaPWpyyanBMnSXX5gWYlNzw241jkvPOvruvKVFAkc
        2pavVnKJQCsNoYas39mQIMZynA==
X-Google-Smtp-Source: ABdhPJyGVZ6c9+FCR1+79J4247AbFpUNISzjRPs9/y9Pf0S63mNDChzZLl04RT7kHWg1S7KwDjW81g==
X-Received: by 2002:a17:90a:d793:: with SMTP id z19mr1983309pju.143.1624925695512;
        Mon, 28 Jun 2021 17:14:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 1sm16214794pfo.92.2021.06.28.17.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 17:14:55 -0700 (PDT)
Message-ID: <60da65ff.1c69fb81.ebb6d.0baa@mx.google.com>
Date:   Mon, 28 Jun 2021 17:14:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: devprop-5.13-rc8-169-g33842e66a789
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 2 runs,
 1 regressions (devprop-5.13-rc8-169-g33842e66a789)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 2 runs, 1 regressions (devprop-5.13-rc8-169-g33842e66a789)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/devprop-=
5.13-rc8-169-g33842e66a789/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: devprop-5.13-rc8-169-g33842e66a789
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      33842e66a789d1e4aa9d0379c1f5f43fd4cc4ae7 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60da58f853f5aa1a3523bbfe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/devprop-5.13-rc8-16=
9-g33842e66a789/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/devprop-5.13-rc8-16=
9-g33842e66a789/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60da58f853f5aa1a3523bbff
        failing since 313 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A7624FE87
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 15:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgHXNGj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 09:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgHXNGe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 09:06:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653E2C061573
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 06:06:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y206so4780282pfb.10
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 06:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/d//1N4yOsBUvKsDHruVdVZzXKH+g+duflbqsBKImxo=;
        b=faT1PTJ2KqlPrWHrn5WycdY8zpwRpZoB/1BbgmbYpJEg1ZxCSsHOZTU7SBQo7aVSa/
         0CKQ4W/H0aN6M7ROlwmYhL6ibq6y89VC8bUa+B6yb0NWekj58XZ+ufhaSmLklzS+Taxs
         K/TIjDqwCeEEFiPEj264SCesWu4bqEPwd3cwsGK2QPf/5OfcNaMBHA0ahx8SYUgIL0nX
         1/uKWoMA662R5mu44vCbCUXAxfrwKbTt8gqWOS+hYVwkSXUe1luZpp4Bdmok3uFD4nJs
         eonpkr/tcGW0R1nWcTiMNomniHwIEiqE426mwO1d+baOBHW9CZBrdoUr7cZ6bPaYO/ug
         k7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/d//1N4yOsBUvKsDHruVdVZzXKH+g+duflbqsBKImxo=;
        b=FHSfqvkeZ6rRKAJ2xh8IyHvYCbwOmqZHTuPe/ib0euivSN3Mm3m2bNO3k/QatlQ6/z
         Ki8zWNP2PYCsYYb89x3UBKFlaxma8Mz1UrTN+WS7/nFDhKBplyHmz/nvpmNtALxjunVq
         vywSJQ7DHSWsaoe3PgPYLXpyae8hk967xV7LNjnoXmKFXd9I37rw8N9en7OJEUGEnhFn
         /DYLxRcepiNjSFxDofTNKS9ufAU2Yj28m9uq2df4UIA0loA7YxIEHMrZg/FVp28wqJeO
         nhccgXVvOUXyVzHWO9vz1YVP9tpNqbFVOiO0mYNTicLvr0lxQhGG24dkzBedT20faWz5
         3vjA==
X-Gm-Message-State: AOAM530mLQLbQtZO7UF5MP7/+vYCUfIswwj946QXNIc0yjfGcfCR67To
        uUyNfsHOxjesFJi4o5viGlrXWw==
X-Google-Smtp-Source: ABdhPJyysf4h5AFWR56Z7l/B9dBKgqjQzztgmB+T/+ibdk3sUC8fSx3gSUefND7hEQhq9SvdoJ3pqw==
X-Received: by 2002:a62:53c2:: with SMTP id h185mr3880121pfb.53.1598274393933;
        Mon, 24 Aug 2020 06:06:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g19sm33705pgj.86.2020.08.24.06.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 06:06:33 -0700 (PDT)
Message-ID: <5f43bb59.1c69fb81.c336.01e1@mx.google.com>
Date:   Mon, 24 Aug 2020 06:06:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc2-8-gf5eba0ea1052
Subject: pm/testing sleep: 2 runs, 1 regressions (v5.9-rc2-8-gf5eba0ea1052)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 2 runs, 1 regressions (v5.9-rc2-8-gf5eba0ea1052)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc2=
-8-gf5eba0ea1052/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc2-8-gf5eba0ea1052
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      f5eba0ea1052daba08e3fcf50be669b13fd7953d =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f43ac18340369b1c69fb449

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-8-gf5eba0e=
a1052/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-8-gf5eba0e=
a1052/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0821.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f43ac18340369b1c69fb44a
      failing since 4 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)  =20

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3C430CF6C
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 23:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhBBWxu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 17:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbhBBWxt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2021 17:53:49 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47DBC0613ED
        for <linux-pm@vger.kernel.org>; Tue,  2 Feb 2021 14:53:08 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id t29so15364246pfg.11
        for <linux-pm@vger.kernel.org>; Tue, 02 Feb 2021 14:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=eMxMCpeXWUYDBwy8sh1LDwQBEqIVPCZRI09DRgNUXPg=;
        b=bSu6c/DhS2gzEWEd1saU4NVljt+5ZHGZ8w5zlvveANyXnnYZPOaaiWfr6VAF6YJ+EI
         5fD6M0YY4gE2mydnx1Ol1ysAWIskq6CGd0EaBnrWc1in8oqf+CFo8m9aO+Xd0kwK01Jj
         s+L8HUYii6W/PFX4sSMK4XTErwUHbFKRMGOCBfHKbQolV47DSNlbwjoZh8ZaMN64mY5c
         l+JaCjq0AvxrN/gLFV9jSUI7P3o1FHV1ttPnPwwPjNv7/Bv5Fes5Fhxpy4mOVHMMhf6f
         UCr+uaKojFvdmq95GHNMWmQT7bGrRw31OZhEtl0ukRyXwxEXPOW+ZZUwmuYqOWCsPGId
         pAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=eMxMCpeXWUYDBwy8sh1LDwQBEqIVPCZRI09DRgNUXPg=;
        b=gIQV1xxdc3hN2k0SHWjQbQAq425e9oSYffqvczTx7K9uZsUMVKQjEpByObw+Vo7wrQ
         rgAKbgkqLYNyOTytMP1EqiIAvyMOK8gsmtpguxws0lZuuVIhoRGp48hkNDB5k+k6Bsi7
         lNzRzZk/Cs1DGcHmEEvlVgckz/4DpsSUU954mokOOWNKRN87VLg8lbm8ILS0NQKAAxRo
         EBTCPTnFk7atCUYQuWzlCC9I3yYSgEPtI1s34CrVqiNt50B5S7gPolkuZeDbCVP6t4CM
         qS3XIPtHttZCNaZpWynG5GooQHaROtlnob/eupvCMnnnS4iUqtsjkJvuk+sZHoicK4AZ
         dmVA==
X-Gm-Message-State: AOAM533VVt+x7t5cEyub0H1HwZPrZ81LVuZmxDSEQpQdSpYXT8iduUB6
        IdPWVnv3oQlc9VP/0Wf0SXRCLHNa5D9YCg==
X-Google-Smtp-Source: ABdhPJw5c81fGOVMsdAeR5rsumbgfD3SMFHDPJ9x7jAKtGeRjP5+kOEsZURIX4MBXVp2VRljj5bcPA==
X-Received: by 2002:a65:67ce:: with SMTP id b14mr321167pgs.387.1612306388377;
        Tue, 02 Feb 2021 14:53:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d2sm65231pjd.29.2021.02.02.14.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 14:53:07 -0800 (PST)
Message-ID: <6019d7d3.1c69fb81.7b1af.04b3@mx.google.com>
Date:   Tue, 02 Feb 2021 14:53:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.11-rc6-72-gc42187278fc1
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 5 runs, 1 regressions (v5.11-rc6-72-gc42187278fc1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (v5.11-rc6-72-gc42187278fc1)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-rc=
6-72-gc42187278fc1/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.11-rc6-72-gc42187278fc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c42187278fc107ad17fdaa2def70c451bcfdb6be =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6019cb2d91756a6b823abe6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc6-72-gc4218=
7278fc1/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc6-72-gc4218=
7278fc1/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0201.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6019cb2d91756a6b823abe6e
        failing since 167 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20

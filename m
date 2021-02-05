Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B363101B6
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 01:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhBEAhS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 19:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhBEAhS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 19:37:18 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C77C0613D6
        for <linux-pm@vger.kernel.org>; Thu,  4 Feb 2021 16:36:38 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id my11so5820628pjb.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2021 16:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=blNw7eI+WLWaDOzdQKI8HR3X6z8iTIENh3WLLv8dXlk=;
        b=gScMAr9UZ2DLtizbqJ6ZHYQc+8AI5cS7tScWbMB6F0qSvM0A9O2tuKBfxAsCE2HiB5
         SJFcR1vUxVsk7NUEhlRWp/+fhlzoj2c+p7a2ejfxAjJJUbgmdAHCwFUbWhA3mQwDbfmm
         VZo27/uyhOVuIIq+/Ioq27gtphPavcCyM6OwoTjH6vQLP0MzonBea3QEYIwWva0kp1IU
         rp+5A5SL627DlUP+iIJZHWEgfY7K5uuNadqiRf/Jxp68j5Dl+JIyHFjbTfK+EZhfhOdk
         wZChbxS8OgY1KI0GyjAoYRKx90haRwiKIEz2IBxQaYSsr8r23yJCSEhSU1tpbl1Q6pHp
         aMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=blNw7eI+WLWaDOzdQKI8HR3X6z8iTIENh3WLLv8dXlk=;
        b=K6HRmk3xME+kiJ2TXxpk9RUF/0kGptB23UVHmiZaxDRVFvfq/jrncS6DCRt4JNNYQ/
         S5y9t8kW9KQamTqMb+JYRxW+EBvSk3oX1wYqYbQVlegbL4N0GZys3CpnuJ+yAJgrT2ax
         3caCXMzEyKmDaIkltuNPeAI9I6Iurywt1HKhFzOFkLWTsVknWboY/pKXWprggujgZYXf
         XwdhnwRqrbgNmicTjUszp7nsr0IiDUip+6nh1egcEdQdbER+lCOt9VzUoRCrxDEX0fpo
         PLm+IErCLgcuesEYlS/gQzD7wDAW8jh7UKderu7MZ9M7IjNSfPOF4JTAMroTepBs0pgs
         +GtA==
X-Gm-Message-State: AOAM53221+rbKBbg4QGLuwiGcDwjIwYaD3WnAqWc4jKdAI0UdEkLrQbg
        vrGPGO5U6/9N6ptNNBvSb9GT0w==
X-Google-Smtp-Source: ABdhPJyrzj7H/Ekx30tZIe2EjNa4HOZgDQKj2UpxvNVe63jHjor6hGXZtSsL0OvcmlZRofnSYDusNQ==
X-Received: by 2002:a17:902:241:b029:de:17d3:423e with SMTP id 59-20020a1709020241b02900de17d3423emr1538597plc.44.1612485397846;
        Thu, 04 Feb 2021 16:36:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 85sm7133916pfc.39.2021.02.04.16.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 16:36:37 -0800 (PST)
Message-ID: <601c9315.1c69fb81.5b73c.fc76@mx.google.com>
Date:   Thu, 04 Feb 2021 16:36:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: acpi-5.11-rc7-89-g5f8da9ef1c5d8
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 5 runs,
 1 regressions (acpi-5.11-rc7-89-g5f8da9ef1c5d8)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (acpi-5.11-rc7-89-g5f8da9ef1c5d8)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/acpi-5.1=
1-rc7-89-g5f8da9ef1c5d8/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: acpi-5.11-rc7-89-g5f8da9ef1c5d8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5f8da9ef1c5d88b9a6de64ad33d98e2edd58ce89 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/601c868e90a055d4c13abee6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.11-rc7-89-g5=
f8da9ef1c5d8/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.11-rc7-89-g5=
f8da9ef1c5d8/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0201.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/601c868e90a055d4c13abee7
        failing since 169 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20

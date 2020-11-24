Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0693C2C1C80
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 05:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgKXEIe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 23:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgKXEIe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 23:08:34 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A21C0613CF
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 20:08:34 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id n137so7142848pfd.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 20:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=QL1XWCkTJIms/S6xwzxwJMrQ5cvD56yicOLbP2bPiVA=;
        b=P2IFoXiNkb92RGxU8+uVNpRLPTqrqFU0p/Yyfq8IJ2MoGAYeeGl3fP0dLJadu/51q5
         2raEBln8G5zW0qCswASylhyZ9oH6TQjBuNV4tZd8C6HmADIcmq/Ms5QyoMQ+ns8MghZL
         1GWobQtl8BfJMnII2/sPgWdhN5hfmpy0BQMNAkDew9zycxEw25D8TlEYX8fx5po6eX7w
         50Bng0lNwkk8xP4djWXeoxJQc76WpINF9o7LCCZAFkX+hqUUXn8RmmnwhsX2mo8rpzzV
         Mvl3n0plSXS0op7TN6YsMv6OvJajKB1QKJHJziAl7q3bZvC8V3Dtd5eTBqIPD4VuWI+/
         Vu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=QL1XWCkTJIms/S6xwzxwJMrQ5cvD56yicOLbP2bPiVA=;
        b=Dk95CpG8y5z+tOULp1DAayqi4E1FOSDAdO/9UQFRk6tKrAlyjx5s/8tahcF+B5qLy1
         REIBCWDqb8nPTUSTbDvhN8GbBUHDHgLzpnPN53dhAU/Lk8Kw0qHcdrJzx+hYAJQzXFat
         onUlRgHPGb0sGsIIcehram2QyqL0s4wB376gLSjE95mX8FYm7OcqrrY/Wgfe3/BllpUH
         LTdpEZ7S5pcwd2wlOEI209DQC2f5om6hkL8N8MeH3qGlAARozu0lH4YsNt9eWlony24G
         PJ7FiFOSlsutfuFPhszoSOJ3UC4vON5lIPOPKiaEIaYNvmLj3gnH/PxJ1PRj0GE8KeqG
         vvhQ==
X-Gm-Message-State: AOAM533q8P0iC8k0aD8godmCEPpU5EZaYL2UXkcDlX/DsCYHvLWAq5Wa
        pZ+hxE18ysbm67jyZ2hdp6Fe0g==
X-Google-Smtp-Source: ABdhPJxREW635UAQrOoZf/W2L45DQFkoi/YGuePJIRcTUxfwCsbGQhAs37pvF6qqjJkDdQTs4SiDcQ==
X-Received: by 2002:a63:2060:: with SMTP id r32mr2192285pgm.129.1606190913877;
        Mon, 23 Nov 2020 20:08:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c203sm6807623pfc.10.2020.11.23.20.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 20:08:33 -0800 (PST)
Message-ID: <5fbc8741.1c69fb81.26fc0.226c@mx.google.com>
Date:   Mon, 23 Nov 2020 20:08:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc5-53-ga8cb5559d8098
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 99 runs,
 1 regressions (v5.10-rc5-53-ga8cb5559d8098)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 99 runs, 1 regressions (v5.10-rc5-53-ga8cb5559d8098)

Regressions Summary
-------------------

platform       | arch | lab          | compiler | defconfig      | regressi=
ons
---------------+------+--------------+----------+----------------+---------=
---
qemu_i386-uefi | i386 | lab-baylibre | gcc-8    | i386_defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
5-53-ga8cb5559d8098/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc5-53-ga8cb5559d8098
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a8cb5559d809862f8d41c8bdf3a4608553997d0a =



Test Regressions
---------------- =



platform       | arch | lab          | compiler | defconfig      | regressi=
ons
---------------+------+--------------+----------+----------------+---------=
---
qemu_i386-uefi | i386 | lab-baylibre | gcc-8    | i386_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/5fbc79f5d579c275eac94cc3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-8 (gcc (Debian 8.3.0-6) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc5-53-ga8cb5=
559d8098/i386/i386_defconfig/gcc-8/lab-baylibre/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc5-53-ga8cb5=
559d8098/i386/i386_defconfig/gcc-8/lab-baylibre/baseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/x86/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fbc79f5d579c275eac94=
cc4
        new failure (last pass: v5.10-rc4-59-ge98c22d03688) =

 =20

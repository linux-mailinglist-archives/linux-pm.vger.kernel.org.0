Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64159301234
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jan 2021 03:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbhAWCOP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 21:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbhAWCON (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 21:14:13 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A82DC06174A
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2021 18:13:33 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id x20so5010690pjh.3
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2021 18:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=r7TouDibufHtbmdxr0EEYMvNY/v8CjQUkYNq5D8Hkdg=;
        b=PS5tTDHjWcCNlVfEL1txrDotIA6fVnIbCcBq6rMA8GxW2jaY2odFC15UMCMh8hr55t
         xscDCs7ndFx1kMOcemMdSaLtCk2Hb2+46F09daMOIPC3M5Umo/EnBuvHlOpsVNVOWtGk
         /nNo6GbUvmkja5zQqa2ycTLrLcYwR/E8Yws3nxqpXK6d0EgxrBmlZGRZr/Vfv2pgRhaY
         ppgyrvzBRhf3uKMMpQi19wUHbbMein7IC6CIC0hBnoaIcl7dnNV5DY/NaWVDKlnRjv7T
         bTvJjoL+vJW6MsmgwA8e0Hn7Vig3bmfNTkiMXlZDFyM+KXBUyltOJTyxoAwoX1RfR6+1
         E2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=r7TouDibufHtbmdxr0EEYMvNY/v8CjQUkYNq5D8Hkdg=;
        b=aKQ6fkTWwIfn+OutrdC+xuuC6jKaZhOXQaHLl/M/U+ZQjyBC9UflL33MTGOIQin2sG
         OIUbuEV1XbJzCOyWVdRiAnxm8+0LuigpQ0loeGKcbLXO25O1ATAf7E+IC+JZjbiMSdjO
         6DyeCid0iQS/NQtH5InlLnvEzqQrYYDYHLBENshdxHv3PWChjbi8VP2w6eRnNYbI9afr
         1NEyT1lfqnG8GVDohz/VCgfAMe7d6h2DlGuKWNWmwheP//+JksptkzfeISIqhop/U0yk
         EN6rNrZ9SPVcetCJ7dpTkA5A8pWXiwmnCw3HiyZqUm9lK3CfmBGpZVhwem+gtWYhAFvf
         b0pg==
X-Gm-Message-State: AOAM531IMt4KBzy4JCq/pUJcPTZ9klB5gKIwHi/HaaZMbbDMGgQ7JSJA
        AlWgVSxzH6J3pveBwZuRnPk9CA==
X-Google-Smtp-Source: ABdhPJw6RYwUcUf+UQ6dhBSfgO4AwR7ZWUExdjUJPAg76+8EFA0xu/nolum6TDKhW1w03S+r7hmmNA==
X-Received: by 2002:a17:90a:fd0b:: with SMTP id cv11mr8691764pjb.26.1611368012775;
        Fri, 22 Jan 2021 18:13:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k141sm8261492pfd.9.2021.01.22.18.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 18:13:32 -0800 (PST)
Message-ID: <600b864c.1c69fb81.35147.4718@mx.google.com>
Date:   Fri, 22 Jan 2021 18:13:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: acpi-5.11-rc5-27-gad758c58a703
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 106 runs,
 2 regressions (acpi-5.11-rc5-27-gad758c58a703)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 106 runs, 2 regressions (acpi-5.11-rc5-27-gad758c58a70=
3)

Regressions Summary
-------------------

platform                 | arch | lab          | compiler | defconfig      =
    | regressions
-------------------------+------+--------------+----------+----------------=
----+------------
imx6q-var-dt6customboard | arm  | lab-baylibre | gcc-8    | multi_v7_defcon=
fig | 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/acpi-5.1=
1-rc5-27-gad758c58a703/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: acpi-5.11-rc5-27-gad758c58a703
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      ad758c58a7036596aed10b408535d4e0dd16c7d6 =



Test Regressions
---------------- =



platform                 | arch | lab          | compiler | defconfig      =
    | regressions
-------------------------+------+--------------+----------+----------------=
----+------------
imx6q-var-dt6customboard | arm  | lab-baylibre | gcc-8    | multi_v7_defcon=
fig | 2          =


  Details:     https://kernelci.org/test/plan/id/600b7c53e5eb037555d3dfd8

  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.11-rc5-27-ga=
d758c58a703/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-imx6q-var-dt=
6customboard.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.11-rc5-27-ga=
d758c58a703/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-imx6q-var-dt=
6customboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/600b7c53e5eb037=
555d3dfde
        new failure (last pass: acpi-5.11-rc5-27-gd9ac95f54ba88)
        4 lines

    2021-01-23 01:30:47.103000+00:00  kern  :alert : Unhandled fault: align=
ment exception (0x001) at 0xcec60217
    2021-01-23 01:30:47.104000+00:00  kern  :alert : pgd =3D (ptrval)
    2021-01-23 01:30:47.104000+00:00  kern  :alert : [<8>[   43.007141] <LA=
VA_SIGNAL_TESTCASE TEST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines MEASURE=
MENT=3D4>
    2021-01-23 01:30:47.104000+00:00  cec60217] *pgd=3D1ec1141e(bad)   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/600b7c53e5eb037=
555d3dfdf
        new failure (last pass: acpi-5.11-rc5-27-gd9ac95f54ba88)
        26 lines

    2021-01-23 01:30:47.162000+00:00  kern  :emerg : Process kworker/0:1 (p=
id: 30, stack limit =3D 0x(ptrval))
    2021-01-23 01:30:47.163000+00:00  kern  :emerg : Stack: (0xc2259eb0 to<=
8>[   43.054613] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail U=
NITS=3Dlines MEASUREMENT=3D26>
    2021-01-23 01:30:47.163000+00:00   0xc225a000)
    2021-01-23 01:30:47.163000+00:00  kern  :emerg : 9ea0<8>[   43.065943] =
<LAVA_SIGNAL_ENDRUN 0_dmesg 624844_1.5.2.4.1>   =

 =20

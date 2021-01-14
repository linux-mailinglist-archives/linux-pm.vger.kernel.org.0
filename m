Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06ED2F626C
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 14:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbhANNxU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 08:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbhANNxT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 08:53:19 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5D7C061574
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2021 05:52:39 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id s15so2923246plr.9
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2021 05:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=DiRDbMGE6RwUlk3o6wLe9grwGd18nYv6pFVeW+MSqQA=;
        b=tX6B1YF39AzF/MVG20a6GNvAm9634o+1sYJ6ZIi57hM+eBWnrZsdIY1iVUljvHtzFr
         4W8hWOGs0g1B7nDlCrSRm/L4LTUmGQE1por1A4P11f/agIT1CUZFChGW9EDKySCMccea
         4lHR3W0InZ6mZ2vkLTamIARQ2CexQMbtd47YRhOo6yMC093nvfnNA+VYqGAzwDIc+UeN
         jA/Zm2KUIztNRc2yR8ZQfK0Yy3rgXhTqtT8Dj2ixKISNsZZ5AFAQl55BMHuXJDT5afZV
         c67IdHDkTGXbusiZFgXi7olG4A6WHnWVU2+ACQw7eZ9U0I/CufAinbmuOH6ACYrpijpn
         +erg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=DiRDbMGE6RwUlk3o6wLe9grwGd18nYv6pFVeW+MSqQA=;
        b=AtV6VCBCuJKRRZsl33rIR72I0Ho3jiuM17M8/umBa19iVCZUbcFKUJW4ICW7rSdT9Z
         0Ucj/+F9hoFr3NnvCy+qLJtBFyhpDlvqx7nXBZpiR2N+ggdIuLfcXjMoO7w6tdTzYDvF
         EsgIeUkUiB3bmxcnFGSmUyjpphqOTPHezjJpcolSm/iygVtgYhkwqeLkNaVHoOsaxykL
         pANDeVyYPMNJfg0RNzAN2SSola9bJ/6PDXZN9kMx3h88S4/zD9a4YGIjmHd+CNCIp9JQ
         +iio+z0wDlIxlRJchkbOO0w6BUrOBinViHfP3D8hxR76fbcxDSy5BAt7WGBId7MCpODw
         b6OA==
X-Gm-Message-State: AOAM533Qw5SpIdeTilT0oWJfIN1ubuwtL6ygEOpJIPYXjbTzgChOsofO
        +p5grGw/Yw2Drd+ovg9McIajjA==
X-Google-Smtp-Source: ABdhPJxTa7063IZfDXPBQdmClfzFMb0c9raap125+/Oqu9RZe1mkSwU4YnCWXsu84EZURAESbVJglA==
X-Received: by 2002:a17:90b:2317:: with SMTP id mt23mr5095262pjb.2.1610632359173;
        Thu, 14 Jan 2021 05:52:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v1sm5885903pga.63.2021.01.14.05.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 05:52:38 -0800 (PST)
Message-ID: <60004ca6.1c69fb81.79912.d86a@mx.google.com>
Date:   Thu, 14 Jan 2021 05:52:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.11-rc3-19-g9f0b1e583eac
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 5 runs, 1 regressions (v5.11-rc3-19-g9f0b1e583eac)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (v5.11-rc3-19-g9f0b1e583eac)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-rc=
3-19-g9f0b1e583eac/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.11-rc3-19-g9f0b1e583eac
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      9f0b1e583eac5573c52c2ead2e1f232adae7d044 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6000406e388847c78bc94cda

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc3-19-g9f0b1=
e583eac/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc3-19-g9f0b1=
e583eac/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1221.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6000406e388847c78bc94cdb
        failing since 147 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20

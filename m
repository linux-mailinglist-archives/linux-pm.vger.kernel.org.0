Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FD633488C
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 21:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhCJUCz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 15:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhCJUCj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 15:02:39 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7062C061760
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 12:02:38 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so8119726pjb.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 12:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=DfrXYhU6KH1+xFAOqz1cAem37F8YbT++Ka4S5/dpiX4=;
        b=zX/hxmHWRsTuvAAiQVv8K5aTgd5z4lJbkYK8u1ba96AwDhYj2NqvG3lT63nJfLIRUU
         GsN6moYXCFczqb18//Qx6QqEIAs1MC/t8vTh/Uy6asTY/3N5CTLdUtEL9y9L2wqUE9eI
         tNJii1e7jmtcbUBYLPqHPXDqw4LyOE2SosQ1tjMA1p7lo1U51cHkIES+IH/K/z+mDhpm
         Qo14sfWKsXUXJ3AH6rPUCJ8Wl8hJcpe035ajsyhEViD+lhlmlC/w9CLwHBgiR/1ghC6T
         WhNtBhJNKRiDOJRUEzojkE1tMBu9mFFvbjTYRrMxZY7sKyMQnTFMU5QTuyxjLFFfE+9q
         L1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=DfrXYhU6KH1+xFAOqz1cAem37F8YbT++Ka4S5/dpiX4=;
        b=p5yBECUEHrSdV/sS7Fd7pq8zG9yw9C3OAEupBMUWAfdpIjV70dLmFfiWzPprabBkAc
         JjrNHQ39noRl3k20kYU9FdqbboYSD6l8xJKzvqtpdggaMReGUzNjQimsdhIObmEg+zNK
         +8msktkP/rnb3UbhIYzEptDLgntrf+QZgQaOpf7ddG99+yRD4bNwzQOXQopZ7D/773wN
         e7T5XuDucXHogeX7QUJPmQnGbo3JC6H3cqsLZIuVJiJoAC6e2EI/gGmurnr3HP18GO5W
         kAhkT7ydPRWO7omTgNmr/zDjLJgoTtab/nf8UVIFxdbcsK4w+wMz61n/tw0PpYFFZqIS
         f5fQ==
X-Gm-Message-State: AOAM5306LGxK4lTy4cCUdHUYwO1aZ6n5qURjSS3BrTKQf8P0ZTqt1W/w
        oIrEHGWNTohL5BDqKQitzTQyWw==
X-Google-Smtp-Source: ABdhPJyw+kw4B8yQdaGsbuMSyrciCg///NpMFkZsoXDm8qs8y4xyaI+Hri7dgd0Wzq4pzmJuDHZ6YA==
X-Received: by 2002:a17:90b:4c08:: with SMTP id na8mr5493576pjb.70.1615406558491;
        Wed, 10 Mar 2021 12:02:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o62sm322811pga.43.2021.03.10.12.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 12:02:38 -0800 (PST)
Message-ID: <604925de.1c69fb81.8f214.12b8@mx.google.com>
Date:   Wed, 10 Mar 2021 12:02:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc2-28-g8608bdeb4cdb
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 3 runs, 1 regressions (v5.12-rc2-28-g8608bdeb4cdb)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (v5.12-rc2-28-g8608bdeb4cdb)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
2-28-g8608bdeb4cdb/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc2-28-g8608bdeb4cdb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8608bdeb4cdb5608b4073077e6e5d7bdedefd169 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6049196d1e9ecad2eeaddcd2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc2-28-g8608b=
deb4cdb/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc2-28-g8608b=
deb4cdb/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0301.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6049196d1e9ecad2eeaddcd3
        failing since 203 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20

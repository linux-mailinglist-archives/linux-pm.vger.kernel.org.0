Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B67E2F428E
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 04:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbhAMDdi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 22:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbhAMDdh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 22:33:37 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E178BC061575
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 19:32:51 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id cq1so280782pjb.4
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 19:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Suvl02A3qsmwPgtHnOM+1QYAXRUY2RZGObpZLJxT8JM=;
        b=onry9PnyIYc3Y5HMHBJhS2eipsDQvXZD04kkaWD+AF/xEUSaZCp6T6U2LjTpRZekTZ
         9ejlvD7V9/7V+BfgWY12ymePK10DSsXbrD118ZZWsz/D0UMEh62FBp+rcnZcErr7aYbP
         z8IJuyf/Pm2lo2ox+BtnsfH0o8XHlurBjadABQdMW0uIjPB0Iz9ZPI66mWMJfjNmK0Mx
         WLql92r3p3bntD5hpXrLaQNpfp186s/qZwJPHR8Ti2m7SHNMlgDhguJPLGAU4fc/J7HG
         P48wYqtDvVoEm3+GixKKo5uGwQHdKicpPg9l6IPOFz9wChALQLOoi5g7tUHccNQC/Wi3
         pVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Suvl02A3qsmwPgtHnOM+1QYAXRUY2RZGObpZLJxT8JM=;
        b=Vn/1cRzI00ZFys+mOe04RNiTzqdYCjllvmJ5ZnDmhgGOW2MtXQqPmgK6ebHG3G9fA8
         EjfVCe7RkQUTs5SyLUjWRWi+XpATEglOQ5PBHe2MrBUfM2nFc+4TOCWwAV8FphTRfdDo
         FOZg9jH97KsXYFLzUyukCqCwYOv7uEIWZPUswsc41jwnhtVovRco2ho+asTWy196cUrk
         YCjVXYmV8kVIUrrmbCJt26G05A5SzDZ0V+VcpxqeePm0Zj519Fw2UNbK0MpRlI6YJLex
         wR+1tolEst8LDqD8pjvF2hFhqJyBM8NVpM5QhCSPXHOVQjs8EeUAZTufwZzBJMHOEjDz
         c8hA==
X-Gm-Message-State: AOAM533onfUhYGDjllC8DSRyWGmxH9WBVOEEuVkyd6Tsa4mVuJyUTjAl
        BSWvD3Q9tgeKyiN5506PYPqXBw==
X-Google-Smtp-Source: ABdhPJwsdCIliRQ4tYagxl8ZpuCPxk7GsgoD3MFu5x9jhH6QCLoOrFv3BvlFtLgIgQB5MbKHuL/YBQ==
X-Received: by 2002:a17:902:a5cb:b029:dc:2706:4cc8 with SMTP id t11-20020a170902a5cbb02900dc27064cc8mr158852plq.62.1610508771516;
        Tue, 12 Jan 2021 19:32:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s7sm515710pju.37.2021.01.12.19.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 19:32:50 -0800 (PST)
Message-ID: <5ffe69e2.1c69fb81.ded5e.19a6@mx.google.com>
Date:   Tue, 12 Jan 2021 19:32:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.11-rc3-12-g8cbb6cfa9b8e
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 3 runs, 4 regressions (v5.11-rc3-12-g8cbb6cfa9b8e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 4 regressions (v5.11-rc3-12-g8cbb6cfa9b8e)

Regressions Summary
-------------------

platform            | arch  | lab           | compiler | defconfig         =
 | regressions
--------------------+-------+---------------+----------+-------------------=
-+------------
mt8173-elm-hana     | arm64 | lab-collabora | gcc-8    | defconfig         =
 | 1          =

rk3288-rock2-square | arm   | lab-collabora | gcc-8    | multi_v7_defconfig=
 | 3          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-rc=
3-12-g8cbb6cfa9b8e/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.11-rc3-12-g8cbb6cfa9b8e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8cbb6cfa9b8ef84f97642e04038e571673f6ffe4 =



Test Regressions
---------------- =



platform            | arch  | lab           | compiler | defconfig         =
 | regressions
--------------------+-------+---------------+----------+-------------------=
-+------------
mt8173-elm-hana     | arm64 | lab-collabora | gcc-8    | defconfig         =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/5ffe5d7268039c1e6ec94d49

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc3-12-g8cbb6=
cfa9b8e/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc3-12-g8cbb6=
cfa9b8e/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1221.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5ffe5d7368039c1e6ec94d4a
        failing since 146 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =



platform            | arch  | lab           | compiler | defconfig         =
 | regressions
--------------------+-------+---------------+----------+-------------------=
-+------------
rk3288-rock2-square | arm   | lab-collabora | gcc-8    | multi_v7_defconfig=
 | 3          =


  Details:     https://kernelci.org/test/plan/id/5ffe5d7d74cc11f053c94cb9

  Results:     2 PASS, 13 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc3-12-g8cbb6=
cfa9b8e/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squar=
e.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc3-12-g8cbb6=
cfa9b8e/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squar=
e.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1221.0/armhf/rootfs.cpio.gz =



  * sleep.rtcwake-mem-1: https://kernelci.org/test/case/id/5ffe5d7d74cc11f0=
53c94cbc
        new failure (last pass: v5.11-rc2-21-g75a052c6b1ba) =


  * sleep.rtcwake-mem-2: https://kernelci.org/test/case/id/5ffe5d7d74cc11f0=
53c94cbd
        new failure (last pass: v5.11-rc2-21-g75a052c6b1ba)

    2021-01-13 02:39:53.157000+00:00  rtcwake: read rtc time failed: I<4>[ =
  19.720243] rtc-hym8563 0-0051: no valid clock/calendar values available
    2021-01-13 02:39:53.157000+00:00  nvalid argument
    2021-01-13 02:39:53.158000+00:00  rtcwake: assuming RTC uses UTC ...
    2021-01-13 02:39:53.158000+00:00  rtcwake: rea<4>[   19.739992] rtc-hym=
8563 0-0051: no valid clock/calendar values available
    2021-01-13 02:39:53.158000+00:00  d rtc time failed: Invalid argument   =


  * sleep.rtcwake-mem-3: https://kernelci.org/test/case/id/5ffe5d7d74cc11f0=
53c94cbe
        new failure (last pass: v5.11-rc2-21-g75a052c6b1ba)

    2021-01-13 02:39:53.159000+00:00  TC ...
    2021-01-13 02:39:53.205000+00:00  rtcwake: read rtc time failed: Invali=
d argument
    2021-01-13 02:39:53.206000+00:00  rtcwake:<4>[   19.780419] rtc-hym8563=
 0-0051: no valid clock/calendar values available
    2021-01-13 02:39:53.206000+00:00   assuming RTC uses UTC ...
    2021-01-13 02:39:53.207000+00:00  rtcwake: read rtc time failed: Invali=
d argument   =

 =20

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B008D38CE9E
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 22:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhEUUJ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 May 2021 16:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhEUUJZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 May 2021 16:09:25 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A686C061574
        for <linux-pm@vger.kernel.org>; Fri, 21 May 2021 13:08:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z4so9369636plg.8
        for <linux-pm@vger.kernel.org>; Fri, 21 May 2021 13:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+9ARc72iJbC2m0HW/ffO1zaY3tPEV55oc9PK1iJbwGQ=;
        b=t9/CRhdS5mm3fyr+ngYx8ugy8OdT+hCwqZx1WQpwsC82q8UgT00UDROgZWjTN5BS2w
         3d5whbOXK8xqdYCeLeXy+YRPpfvVg2wgJzUKIkZnCRqjkwBvQm7+t3MCHJ63SxZ3J/Bz
         NDFHYsogCIkHS5IhIa7279BtTiwBhI2i7z1z/cSxlYv0fXs72Ukn6FfvEHLH9//YxUpD
         8vfs7Dxgf+xgvMq3VpdWMj60q+GWD7OIcdDtVIVt+hZrIGm/l/YlgFT1YGXkzI9JnD/U
         nTt+6ccRRIhracT03TTJ+3iNDedaLIBxNLHBRLtVW8AOkrR5s8Ek6XK6QnNSIYPWgrko
         in1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+9ARc72iJbC2m0HW/ffO1zaY3tPEV55oc9PK1iJbwGQ=;
        b=GEMC1U6pAzJT4TKzU+OXSVBiR9qm9gz9AI7jqE2wxv73YBpVngo9qm3TsAVGOx8mv/
         A4GfJtBPPrpyS+pUXpb1urkXB7f1Cvgc+/m/eXbANd+4Ex+pkEDhS5hJ1PNlhHOFhd6g
         e0IghauTI/zgHuX/N8dCcEySdJi/b1PT1CIaxDvzD6NOMUq/3LsEl9fe3f000TupU0pV
         kcWsvSCQDyYCuNFu3zBhHZZpZ48IDpfEGgHTyFbsPO+vvZVkAL8sx/NDAjwZ5CMJQIH0
         cMgQeVZGRvhdM//0MiuG7ht7ETdiaNGl7fw+q7Hy5157Ezk/srsD0P4FllF3Y7QVIaMj
         XgXQ==
X-Gm-Message-State: AOAM532bLC8fMfKgrPYxg2tTEfwSQQLd0ZZtfmaY3ITJHu9T6Rap2RxZ
        lqromIpsWijIKvDARhj9cbhTOQ==
X-Google-Smtp-Source: ABdhPJxuVujvZAO0AP6UAgpFKSV1uk27tJAKWbpE1VaWeXdCHRy32G+b2MMboWG8Wj75yGMJpoTjtw==
X-Received: by 2002:a17:90a:fa91:: with SMTP id cu17mr12661109pjb.214.1621627682082;
        Fri, 21 May 2021 13:08:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 69sm5002675pfx.115.2021.05.21.13.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:08:01 -0700 (PDT)
Message-ID: <60a81321.1c69fb81.ecb8f.162d@mx.google.com>
Date:   Fri, 21 May 2021 13:08:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc2-14-g49f1b0f7d4af
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 7 runs, 3 regressions (v5.13-rc2-14-g49f1b0f7d4af)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 3 regressions (v5.13-rc2-14-g49f1b0f7d4af)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
mt8173-elm-hana   | arm64 | lab-collabora | gcc-8    | defconfig          |=
 1          =

rk3288-veyron-jaq | arm   | lab-collabora | gcc-8    | multi_v7_defconfig |=
 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
2-14-g49f1b0f7d4af/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc2-14-g49f1b0f7d4af
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      49f1b0f7d4aff9ebcfdc2d63dd0e94f867d69d9b =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
mt8173-elm-hana   | arm64 | lab-collabora | gcc-8    | defconfig          |=
 1          =


  Details:     https://kernelci.org/test/plan/id/60a8066ae559ab5ba7b3afb8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc2-14-g49f1b=
0f7d4af/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc2-14-g49f1b=
0f7d4af/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0503.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60a8066ae559ab5ba7b3afb9
        failing since 275 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =



platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
rk3288-veyron-jaq | arm   | lab-collabora | gcc-8    | multi_v7_defconfig |=
 2          =


  Details:     https://kernelci.org/test/plan/id/60a80ab119ff7efa7ab3afa3

  Results:     21 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc2-14-g49f1b=
0f7d4af/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-jaq.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc2-14-g49f1b=
0f7d4af/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-jaq.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0503.0/armhf/rootfs.cpio.gz =



  * sleep.rtcwake-mem-2: https://kernelci.org/test/case/id/60a80ab119ff7efa=
7ab3afa8
        failing since 10 days (last pass: v5.12-rc8-168-g3c44d15e5ffdb, fir=
st fail: v5.13-rc1-4-gdc9d574fa82fc)

    2021-05-21 19:29:42.275000+00:00  tcwake: assuming RTC uses UTC ...
    2021-05-21 19:29:42.275000+00:00  rtcwake: wakeup from \"mem\" using rt=
c0 at Fri May 21 19:29:48 2021
    2021-05-21 19:29:42.290000+00:00  <6>[   82.225829] PM: suspend entry (=
deep)
    2021-05-21 19:29:42.313000+00:00  <6>[   82.247990] Filesystems sync: 0=
.000 seconds
    2021-05-21 19:29:42.342000+00:00  <6>[   82.271654] Freezing user space=
 processes ... (elapsed 0.001 seconds) done.
    2021-05-21 19:29:42.349000+00:00  <6>[   82.283625] OOM killer disabled.
    2021-05-21 19:29:42.554000+00:00  <6>[   82.289649] Freezing remaining =
freezable tasks ... =

    2021-05-21 19:29:42.591000+00:00  <6>[   82.486671] usb 2-1: new high-s=
peed USB device number 4 using dwc2
    2021-05-21 19:29:47.883000+00:00  <3>[   87.816629] usb 2-1: device des=
criptor read/64, error -110
    2021-05-21 19:30:02.365000+00:00  <4>[  102.302455]  =

    ... (21 line(s) more)  =


  * sleep.rtcwake-mem-3: https://kernelci.org/test/case/id/60a80ab119ff7efa=
7ab3afa9
        failing since 10 days (last pass: v5.12-rc8-168-g3c44d15e5ffdb, fir=
st fail: v5.13-rc1-4-gdc9d574fa82fc)

    2021-05-21 19:30:03.017000+00:00  rtcwake: wakeup from \"mem\" using rt=
c0 at Fri May 21 19:30:09 2021
    2021-05-21 19:30:03.028000+00:00  <6>[  102.965723] PM: suspend entry (=
deep)
    2021-05-21 19:30:03.040000+00:00  <6>[  102.975358] Filesystems sync: 0=
.000 seconds
    2021-05-21 19:30:03.055000+00:00  <6>[  102.986006] Freezing user space=
 processes ... (elapsed 0.001 seconds) done.
    2021-05-21 19:30:03.061000+00:00  <6>[  102.997985] OOM killer disabled.
    2021-05-21 19:30:03.403000+00:00  <6>[  103.004085] Freezing remaining =
freezable tasks ... =

    2021-05-21 19:30:03.426000+00:00  <3>[  103.336614] usb 2-1: device des=
criptor read/64, error -110
    2021-05-21 19:30:03.784000+00:00  <6>[  103.716691] usb 2-1: new high-s=
peed USB device number 5 using dwc2
    2021-05-21 19:30:09.084000+00:00  <3>[  109.016617] usb 2-1: device des=
criptor read/64, error -110
    2021-05-21 19:30:23.072000+00:00  <4>[  123.010816]  =

    ... (21 line(s) more)  =

 =20

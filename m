Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794E02FF6C2
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 22:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbhAUVHP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 16:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbhAUVHD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 16:07:03 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45494C0613ED
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 13:06:23 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id z21so2188130pgj.4
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 13:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=eYM6Q2NJR+iyWzanXeBQkA/PpVPjgEth9djbGTGtXk8=;
        b=TkOpHuoUU7/UENCIqStW6iLb3dOVNezxFJw+t+e9R0IUzhAhLeT+nN1PsXMsVygE8M
         Fe6A5otKjRZ1kPDrSVKJgiYIX7qUh5eQWbyoMxQSaI0omqPmfplgtZuPHt3TAZlVfkpl
         Hcv0OXzdMoEf4WTqE5w4Ki9juDaKyFnBgwU5Z+l8ie2CIr0IDltj6QuQZvuUsbfP5QL5
         NEy8PcrshGMbPINU5iqdZFK8kVRLiny+UvS/QR6FTBMdlr5hfb0OVe28TzD/OFmvM3WF
         m2zmOFcfgqpR8hKlT4NgY445QP0AX6fKAOwYndCrwix0cTlRxyJoH4XQZSdogTLJsdj4
         e8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=eYM6Q2NJR+iyWzanXeBQkA/PpVPjgEth9djbGTGtXk8=;
        b=RCr6qHUk4ocGK4lekx85XkjkH5yOufai+V23HoatdiGCAW5XgTT4uWf8ecib8e+9+Z
         gcTeePrWKTNWUkDNMbN4lQQ9CjRz6glpQdnTyQcHOXVBsdQrT5HeurYrXYw1rlOpKtWB
         teiXXGROlmqNVnFQJeNT4qRA1Wz+wZ9Be6fKq7ta5EZs6DqQVZ8otfP3sDKsspCx26CO
         m8Toba3fRe3MFpphh+Miy/SLjZ2E9YmGjrtfuYyHAyK6EWI87Y2BN5QJmQBkmJBobmiR
         KSCQbvp4D0pyxiwaRkHS/sl6WcowGiSUcxoEuJaZTG9dwn7n5/B0+P3N1qAem+gqNCz4
         Fi2A==
X-Gm-Message-State: AOAM531woH8NF4HdUfmtszGvFSuenYJ50eoK6pG2owWTyCZFqXEXfqZl
        BcRh/FIF/GL1gkWkVxMhupvrpA==
X-Google-Smtp-Source: ABdhPJxQw8meuQrQvSAe+ypDvb/uP91zyPFbQUlPPXm9RLgSx+2ylZcrP+pYbwfEhZdi8qugYUUY+w==
X-Received: by 2002:a63:5416:: with SMTP id i22mr1193386pgb.43.1611263182901;
        Thu, 21 Jan 2021 13:06:22 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c189sm6633723pfb.175.2021.01.21.13.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 13:06:22 -0800 (PST)
Message-ID: <6009ecce.1c69fb81.7b94b.01f6@mx.google.com>
Date:   Thu, 21 Jan 2021 13:06:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: acpi-5.11-rc5-27-gd9ac95f54ba88
Subject: pm/testing sleep: 2 runs,
 2 regressions (acpi-5.11-rc5-27-gd9ac95f54ba88)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 2 runs, 2 regressions (acpi-5.11-rc5-27-gd9ac95f54ba88)

Regressions Summary
-------------------

platform            | arch | lab           | compiler | defconfig          =
| regressions
--------------------+------+---------------+----------+--------------------=
+------------
rk3288-rock2-square | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
| 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/acpi-5.1=
1-rc5-27-gd9ac95f54ba88/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: acpi-5.11-rc5-27-gd9ac95f54ba88
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d9ac95f54ba88454a0ff889028149b802118a89b =



Test Regressions
---------------- =



platform            | arch | lab           | compiler | defconfig          =
| regressions
--------------------+------+---------------+----------+--------------------=
+------------
rk3288-rock2-square | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
| 2          =


  Details:     https://kernelci.org/test/plan/id/6009dd7b01694d58b7bb5d82

  Results:     2 PASS, 11 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.11-rc5-27-gd=
9ac95f54ba88/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-=
square.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.11-rc5-27-gd=
9ac95f54ba88/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-=
square.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0118.2/armhf/rootfs.cpio.gz =



  * sleep.rtcwake-mem-4: https://kernelci.org/test/case/id/6009dd7b01694d58=
b7bb5d85
        new failure (last pass: v5.11-rc4-28-ga31400ec480e)

    2021-01-21 20:00:54.704000+00:00  ake: assuming RTC uses UTC ...
    2021-01-21 20:00:54.750000+00:00  rtcwake: read rtc time failed: Invali=
d argument
    2021-01-21 20:00:54.750000+00:00  1 RESULT=3Dfail>
    2021-01-21 20:00:54.751000+00:00  rtcwake: assuming RTC uses UTC ...
    2021-01-21 20:00:54.751000+00:00  rtcwake: read rtc time failed: Invali=
d argument
    2021-01-21 20:00:54.751000+00:00  CASE_ID=3Drtcwake-mem-2 RESULT=3Dfail>
    2021-01-21 20:00:54.751000+00:00  rtcwake: assuming RTC uses UTC ...
    2021-01-21 20:00:54.751000+00:00  rtcwake: read rtc time failed: Invali=
d argument
    2021-01-21 20:00:54.798000+00:00  IGNAL_TESTCASE TEST_CASE_ID=3Drtcwake=
-mem-3 RESULT=3Dfail>
    2021-01-21 20:00:54.799000+00:00  rtcwake: assuming RTC uses UTC ... =

    ... (2 line(s) more)  =


  * sleep.rtcwake-mem-5: https://kernelci.org/test/case/id/6009dd7b01694d58=
b7bb5d86
        new failure (last pass: v5.11-rc4-28-ga31400ec480e) =

 =20

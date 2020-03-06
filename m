Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CED817B41D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 02:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgCFB7S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Mar 2020 20:59:18 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:43628 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCFB7S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Mar 2020 20:59:18 -0500
Received: by mail-pg1-f173.google.com with SMTP id u12so313492pgb.10
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2020 17:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=KfF8q0PTDaJOX7nHJdXbZxyylbzNNDhBeOhU9iFNG8o=;
        b=J/4tGLv4dXg42FO42AwKunZquyTsNS/sBug9w07NS01Yj2ttCO2WKwEL5fe+TyxlXh
         5/khFJqo1NDA8Pwel4ZHCkuc7e5NpUnfBek7GIm7ozh6tKusRaZs5CK7Iuwq6w/jQ5lP
         A/6ap52Hq7qrladROt++JdzMniPkxIdRc7/NFibjZHPwrTuAljGtxePmSBrjIBQ2ga0a
         ofys6oGDvVXq1i8acLVVw9XIFR7bjvF67V659h+dkZMaS7lm9mtTHVx4ovbrnK/7zjKw
         HfWiYsYj1dXomfkk6Z0Fu2GopmOe+W16fx3WRjoI0ucbei6zzR3Qb7vdmKBw1253/ri+
         EsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=KfF8q0PTDaJOX7nHJdXbZxyylbzNNDhBeOhU9iFNG8o=;
        b=KTmmgEl9oKjAqXPMLnraqD+U5komX8oPO0j8LmtM0Q8McFnVnJb6NcLNYUyLycVQJD
         xHApc4t1gi70Qf5LiZ/yU0uq3Nw0xSQvRtnNKLlyk1p0bAri4Gxo1meq5dOo9FZijMdE
         KUYjGQ6vtxcX2z7WbiuF3hk7zw8ONsSoZSidJTopeBiXKr+bLMmB1gNBAmYFC8JeWuOF
         bV2Xggz1dGXHQ74L88CRZVjl1+kOFnPad9VFSgxFsP5rV6bKgPggzzDMjh2U3Zw/JIEO
         gLmWkMLtVPsTwhbxL9f0kAXLZJREHBbBgi2LnnEk24JIR+EVw2qngBUBlAA2Kq9N6tKd
         EUIQ==
X-Gm-Message-State: ANhLgQ0MCMlUuMN6ZE7UwDXBuL8/FxCv8IsO8JwM6iEGYx6IVuA047mH
        Avo4tIA3CfHMNKXcdXJ64jSItwowL1o=
X-Google-Smtp-Source: ADFU+vuuVEzsjTTthVbKPH2VJEoC4I4qhd+L25DiCevTywcM+59eyXEcpeOWWYThpv0mUOoFFLWOhQ==
X-Received: by 2002:a05:6a00:2c7:: with SMTP id b7mr1375485pft.162.1583459957089;
        Thu, 05 Mar 2020 17:59:17 -0800 (PST)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u11sm7526941pjn.2.2020.03.05.17.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 17:59:16 -0800 (PST)
Message-ID: <5e61ae74.1c69fb81.2376.458b@mx.google.com>
Date:   Thu, 05 Mar 2020 17:59:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.6-rc4-78-ge63a6b3d7d38
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 1 runs, 0 regressions (v5.6-rc4-78-ge63a6b3d7d38)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 1 runs, 0 regressions (v5.6-rc4-78-ge63a6b3d7d38)

Test results summary
--------------------

run | platform         | arch  | lab           | compiler | defconfig | res=
ults
----+------------------+-------+---------------+----------+-----------+----=
----
1   | rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 11/=
15  =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.6-rc4-78-ge63a6b3d7d38
  URL:      git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it
  SHA:      e63a6b3d7d38c359b20aded5ec6964ffdf61ca96 =



Test Failures
-------------
  =


run | platform         | arch  | lab           | compiler | defconfig | res=
ults
----+------------------+-------+---------------+----------+-----------+----=
----
1   | rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 11/=
15  =


  Results:     11 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc4-78-ge63a6b=
3d7d38/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc4-78-ge63a6b=
3d7d38/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0228.1/arm64/rootfs.cpio.gz  =


  15 tests: 11 PASS, 4 FAIL, 0 SKIP
    * rtcwake-freeze-1:
        never passed
    * rtcwake-freeze-2:
        never passed
    * rtcwake-freeze-3:
        never passed
    * rtcwake-freeze-4:
        never passed   =

     =20

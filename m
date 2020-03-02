Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F358175B0C
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 13:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgCBM6d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 07:58:33 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:36315 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgCBM6d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2020 07:58:33 -0500
Received: by mail-pl1-f180.google.com with SMTP id g12so2153644plo.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2020 04:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=3oty/bS7tzv9P9li9h7QnAeHhWblqUINxBhCenWdx2Q=;
        b=q9BBLdEiier6m+lZj4RHTYOzGiUbDfzRa9w+HEHDYr/f2ozzPBfG2NYv/GA/zUHvoQ
         CKA6Ae5nUhvoYKMpq/swSJVd6/kfmTvnQCgzM1Tz9J5GOjy2aRoOU637HB7KzvP9pFQP
         SF128+cJ8PyXW2LF60WdhqTpx3hZQoxb4YddjYKmYe9iQoLsZZxozO2mTu4SAzx6X/pI
         zXchXvPITGZoYvYXkzTZfLLHHIusvUuI+cJKX88v/u1S9JMVVzuVJJPkdAquZ9VDC9qJ
         eWYIX/4S0mImIDNu4xIahI7z2ZrRIB3PHbO2BRqwplOaphZspdSubHI9crII8Dco6TCU
         ODIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=3oty/bS7tzv9P9li9h7QnAeHhWblqUINxBhCenWdx2Q=;
        b=uRloVshJjAh0YfepvJGNHQX016tKusunCJKJCgegaoM/3ZNXR8JPuH6h462d7/wv4w
         TNQgGnLrXnQ9Oe5pk9DWW3SLUaWUHGestkq9kH/dbU4ftKQ/mxcp1H9gkIhirjpqE38P
         6ZrCBTXgK9ngFFQcI8I2yPmKqwnCT8Ty1xYN+cJiWnrCWP+1I5E8m2tNV19zjjI+jSZm
         yzKYfWJct7rj8XDgPa3f+gBchW8AO5SPb5A4iK3EvHAPyNppqCQAcAUv/xAnolDSWzOz
         5TwzaLo1BevDL28nR9lWFaErEzbMB7T/aBY1xBstjXhxamr7lD0/Kw3ZhxLBvO7htQkT
         i1MA==
X-Gm-Message-State: APjAAAUGJfsyVB/xKOUbkWsVf55BYr3/DG5QGSnNaR3v4ASoCykOu9HG
        7684yjQgyZfwWS8KYSUKxVYm7wXNU/I=
X-Google-Smtp-Source: APXvYqxIiw5z/2MfKMOp8TGWGSiyH+GuLFcaoNa51H7z/zlPAzUxKaW3mPqof+JDp0iZAyT9ukO1FQ==
X-Received: by 2002:a17:90a:3266:: with SMTP id k93mr20778280pjb.23.1583153911866;
        Mon, 02 Mar 2020 04:58:31 -0800 (PST)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k24sm18278408pgm.61.2020.03.02.04.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 04:58:31 -0800 (PST)
Message-ID: <5e5d02f7.1c69fb81.5ebe0.f8fb@mx.google.com>
Date:   Mon, 02 Mar 2020 04:58:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.6-rc4-56-gf99f4dfcc7da
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 23 runs,
 0 regressions (v5.6-rc4-56-gf99f4dfcc7da)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 23 runs, 0 regressions (v5.6-rc4-56-gf99f4dfcc7da)

Test results summary
--------------------

run | platform                     | arch   | lab                   | compi=
ler | defconfig        | results
----+------------------------------+--------+-----------------------+------=
----+------------------+--------
1   | bcm2711-rpi-4-b              | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 1/1    =

2   | bcm2837-rpi-3-b              | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

3   | hifive-unleashed-a00         | riscv  | lab-baylibre          | gcc-8=
    | defconfig        | 1/1    =

4   | meson-g12a-sei510            | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

5   | meson-g12a-u200              | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

6   | meson-g12a-x96-max           | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

7   | meson-g12b-odroid-n2         | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

8   | meson-gxbb-p200              | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

9   | meson-gxl-s805x-libretech-ac | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

10  | meson-gxl-s805x-p241         | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

11  | meson-gxl-s905d-p230         | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

12  | meson-gxl-s905x-khadas-vim   | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

13  | meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

14  | meson-gxm-khadas-vim2        | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

15  | meson-sm1-khadas-vim3l       | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

16  | meson-sm1-sei610             | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

17  | qemu_arm64-virt-gicv2        | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

18  | qemu_arm64-virt-gicv3        | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

19  | qemu_x86_64                  | x86_64 | lab-baylibre          | gcc-8=
    | x86_64_defconfig | 5/5    =

20  | rk3399-puma-haikou           | arm64  | lab-theobroma-systems | gcc-8=
    | defconfig        | 5/5    =

21  | sun50i-a64-pine64-plus       | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

22  | sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

23  | sun50i-h6-pine-h64-model-b   | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =



  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.6-rc4-56-gf99f4dfcc7da
  URL:      git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it
  SHA:      f99f4dfcc7da2a275bf6c1c864a829afab018816=20

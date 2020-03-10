Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73FFF17F505
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 11:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgCJK1a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 06:27:30 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:45815 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgCJK13 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 06:27:29 -0400
Received: by mail-pf1-f169.google.com with SMTP id 2so6257543pfg.12
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2020 03:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=BloQpTlc4KGZ6OIBeKqCAFV50yJWBwYpjb4VkeOtEz0=;
        b=CuPpQjSRQhDi6KqHmehB5yP+xH/DwC25HiM7LCmcnUEy//LORidHvB59Q8zBXccvF2
         pYwf55fMBr2WfkL/bmJbHzK67uo7LH6bbj0dAM/5WcSHMad9xVh+6s/xLG7CZkB5FC1C
         sn9/j9MleXvrRlYMKHGHycSHgs5TU/0Dvk303g28FEgoGg7ZzSbyQ6tQu5gRS38HN6qJ
         +2iIM/wMPEf8tnahxAWyQ5ZZgm4eJvM5a/zaC0PkdS5FLlBpQfEfTrUDoBP3f73KjqSy
         darurHrExiUOhhZAiimCy8h4QxyxYuAoIyhJiOCVAq/ovGUcUbCHo3GGU6oOKaO3tYcP
         sk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=BloQpTlc4KGZ6OIBeKqCAFV50yJWBwYpjb4VkeOtEz0=;
        b=DRZ7Ow1jm+tZP7Z4NWMB1Gori08dl4VTl9VcZ/9ob0IajcqbrxkraDcBdzxvcGv4oK
         0EohZf6om53HjwUuVJKJTKjfBwe6pl+hGIPXXuRNIQWu7hPsnQI7gHLSLfISoYm39Tlo
         fqWOyzM+KRx9VmN5zKmpjbNASsJguoamAedq+ORvGSWMSf6VIY8TcKUgD7jANmvr4R7y
         FYW8psc8TkJ8/VUV8aK7QaymMVAXrzPRUfgMvbcrRRVbJSADpcsWOhZcYVikK9gZoHms
         k/kVYSNXi9qojVDtO9bUZ0bss0H6nCBwnHSpp5Ob5sp0cJ3gMx5oO13nYAI3mqQPp75G
         +cFw==
X-Gm-Message-State: ANhLgQ2h8GGxijipxD0J+2wKrosa6gfNf7OBmu2O2K5t1ylT7lcEAbwT
        kb98YrwSA7mfvqsjgcE8pZWqrQ==
X-Google-Smtp-Source: ADFU+vuSnq03Dj27UmpNyGF/iDv8/xjoDBQkO6msQrOG7nitIzYvu83dDxx7yejc6+dQSLKnftmgRg==
X-Received: by 2002:a63:ce0a:: with SMTP id y10mr19712823pgf.44.1583836049122;
        Tue, 10 Mar 2020 03:27:29 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i72sm19729778pgd.88.2020.03.10.03.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 03:27:28 -0700 (PDT)
Message-ID: <5e676b90.1c69fb81.9f49b.57b9@mx.google.com>
Date:   Tue, 10 Mar 2020 03:27:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc5-83-gabcd59902c64
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 24 runs,
 0 regressions (v5.6-rc5-83-gabcd59902c64)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 24 runs, 0 regressions (v5.6-rc5-83-gabcd59902c64)

Test results summary
--------------------

run | platform                     | arch   | lab                   | compi=
ler | defconfig        | results
----+------------------------------+--------+-----------------------+------=
----+------------------+--------
1   | bcm2711-rpi-4-b              | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

2   | bcm2837-rpi-3-b              | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

3   | hifive-unleashed-a00         | riscv  | lab-baylibre          | gcc-8=
    | defconfig        | 1/1    =

4   | imx8mn-ddr4-evk              | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

5   | meson-g12a-sei510            | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

6   | meson-g12a-u200              | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

7   | meson-g12a-x96-max           | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

8   | meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

9   | meson-g12b-odroid-n2         | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

10  | meson-gxl-s805x-libretech-ac | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

11  | meson-gxl-s905d-p230         | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

12  | meson-gxl-s905x-khadas-vim   | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

13  | meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

14  | meson-gxm-khadas-vim2        | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

15  | meson-gxm-q200               | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

16  | meson-sm1-khadas-vim3l       | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

17  | meson-sm1-sei610             | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

18  | qemu_arm64-virt-gicv2        | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

19  | qemu_arm64-virt-gicv3        | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

20  | qemu_x86_64                  | x86_64 | lab-baylibre          | gcc-8=
    | x86_64_defconfig | 5/5    =

21  | rk3399-puma-haikou           | arm64  | lab-theobroma-systems | gcc-8=
    | defconfig        | 5/5    =

22  | sun50i-a64-pine64-plus       | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

23  | sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

24  | sun50i-h6-pine-h64-model-b   | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =



  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.6-rc5-83-gabcd59902c64
  URL:      git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it
  SHA:      abcd59902c6467999041971af4ab14f30a2b3780=20

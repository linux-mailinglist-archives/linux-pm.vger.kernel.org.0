Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5777D2DA648
	for <lists+linux-pm@lfdr.de>; Tue, 15 Dec 2020 03:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgLOCeX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 21:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgLOCdr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 21:33:47 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C3FC0617A7
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 18:33:07 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id w1so247621pjc.0
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 18:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=cP+3d7w0+qlXBQzbUCcjuxUzM//HI7+P1AkBQaZwFlM=;
        b=s6sqZIyK6tbk7AzcH57ppmprZKnfU1niipNYAGtrVNNJpgyznWx42Ls8c2CPx1YQt/
         A2z8elcqUufsZ8cUwGpw8xTeqxnHcttWYQgA5ZKmXNvK8gdWxIpQvXBrtGydbsZPKG8M
         4qMjKVrCWgf7CUIDNofuGRhQCbqXGgO3q1GHrqZcZkhTshiJUd36G/VphP4X4tc5lhVx
         kAgMqY6y0oPXjmS0GTrhQ7F1b9xOSpPnczoC+NQGIH/v6vC6FUnqkuaPz5P795jyCWKO
         g68wY/ZaR1TGPsTvefV1v6DNM1/IJ2Yb1Gg1kq9QslO9hIddKyyW05WqYL3OWT35IQrb
         ejZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=cP+3d7w0+qlXBQzbUCcjuxUzM//HI7+P1AkBQaZwFlM=;
        b=QHbfAIR7elbWlusULM/BscK+dMdqeul0Gd1LmQaeDwvrBjYUASjrbsxUFndhEmQbSm
         6PyoEJ3z0cbbUPxYYU6uOxVAfhr6mqycAzA2ZRTJySR6Cz69dnjl2wLpK7ti3Hz3N+AT
         ggho1WIul/HtXvjMizLHHn7QCDL/V60SdH5yhEGpxQBXqDuLArlzn6i5haMUTtptt4yf
         LAq9JsS7ub7tvIZfQHJC9qa2lSF5eYaKnUd9DYU0QZJn8OOe7rlNkWVhuS3kyDFGrcm+
         vt+oyrEEA81QlVn0r3skpqWECOFsVrmKUibBsP2WUTF//BK7oE/0g3DpTNyirq1BZ3bq
         TwzA==
X-Gm-Message-State: AOAM532diraMwJ+IORsgIeMYs7rQGb6zObrNUCQR/G5+maUNG0VvsWLB
        xE0BBEIXy1RN65FpWpwpR0mmSg==
X-Google-Smtp-Source: ABdhPJy4mmx3XXbuzXlmRflcDNGo52WLcc7zs+wV5eydFI9/8UG99DryomEipiiUF1igtK5FQ/yIKg==
X-Received: by 2002:a17:902:a415:b029:d9:ef8:afa1 with SMTP id p21-20020a170902a415b02900d90ef8afa1mr25109926plq.66.1607999586914;
        Mon, 14 Dec 2020 18:33:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x23sm5031607pge.47.2020.12.14.18.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 18:33:06 -0800 (PST)
Message-ID: <5fd82062.1c69fb81.27794.ba85@mx.google.com>
Date:   Mon, 14 Dec 2020 18:33:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc7-148-g08e85a810cae
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 75 runs,
 2 regressions (v5.10-rc7-148-g08e85a810cae)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 75 runs, 2 regressions (v5.10-rc7-148-g08e85a810cae)

Regressions Summary
-------------------

platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-8    | defconfig | 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
7-148-g08e85a810cae/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc7-148-g08e85a810cae
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      08e85a810cae7e70eae555a109236dd8f8730593 =



Test Regressions
---------------- =



platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-8    | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/5fd816159492139094c94cb9

  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc7-148-g08e8=
5a810cae/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc7-148-g08e8=
5a810cae/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5fd816159492139=
094c94cbd
        new failure (last pass: v5.10-rc7-106-g97756044ce06)
        10 lines

    2020-12-15 01:49:04.058000+00:00  kern  :alert :   ESR =3D 0x96000004
    2020-12-15 01:49:04.058000+00:00  kern  :alert :   EC =3D 0x25: DABT (c=
urrent EL), IL =3D 32 bits
    2020-12-15 01:49:04.058000+00:00  kern  :alert :   SET =3D 0, FnV =3D 0
    2020-12-15 01:49:04.058000+00:00  kern  :alert :   EA =3D 0, S1PTW =3D 0
    2020-12-15 01:49:04.058000+00:00  kern  :alert : Data abort info:
    2020-12-15 01:49:04.058000+00:00  kern  :alert :   ISV =3D 0, ISS =3D 0=
x00000004
    2020-12-15 01:49:04.059000+00:00  kern  :alert :   CM =3D 0, WnR =3D 0
    2020-12-15 01:49:04.105000+00:00  kern  :alert : [0001207370006d7b] add=
ress between user and kernel address ranges   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/5fd816159492139=
094c94cbe
        new failure (last pass: v5.10-rc7-106-g97756044ce06)
        2 lines

    2020-12-15 01:49:04.105000+00:00  kern  :emerg : Code: ab000318 8b1502f=
7 fa401800 540011c0 (f9400720)    =

 =20

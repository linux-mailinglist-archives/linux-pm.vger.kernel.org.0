Return-Path: <linux-pm+bounces-12659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CC195A636
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 22:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C3528748B
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 20:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571CD1741CB;
	Wed, 21 Aug 2024 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="WLoE6q+z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CB1171089
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724273698; cv=none; b=cWllaAVnMLIavjN9+eeafx5LnUMrXYVx1oiTbyTAQ01Q7cTj3ISlDnahMP6ypU6QoURmGrrRuGbgS9z15k+m8fa+ip++3BdOqLCmCvF78knQ5qSQz3KOB2bXvesfujakTwiwGh6m62hghQRCbgpEkuytRmxF88kYG+WajC/1Dh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724273698; c=relaxed/simple;
	bh=S9SKo+pke1l2/Ufw+DboCFrR2att7AQBPsujnfwmAS4=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=ZDz0YleI2fLJfz6vrS0DFUB3fXR6DCqJnwuZ/wAZxFigEcbs7RbYPs4p8kQmDS//iT9+OgQzHBzf59fOAs0DZ/XwpfqnSiwfziJsRl2sHDR2CkIdUs+jIVsPXyNNw/w6nZSZySWB8VUIk4p7aGnbNC01lwikI3gcrrz+6h3r3nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=WLoE6q+z; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39d47a9ffb9so370765ab.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 13:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1724273695; x=1724878495; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MYR3FZrbm7ZbECMDVKfBOotCzlugr9vc0sg5bZEeoTg=;
        b=WLoE6q+zwSVW6K5dQvsFZs4FGphg20snYmJ/u62HB4IinQOruGI9BIsZv1sfHuwdHx
         esF7zkG/okAs0XW9uX6QYs9FeoxZamt1N1qiznGgYm4pXUp847HUNdptQDJn0YVT98GM
         BOIz1U05kKp+PS4KjxjJYb0GnOnWof0cNdiiCPYhXsd8gHbRSCupM+J9pggBcC0goIzy
         kEM6jTCeFc1hv2wT9mWR9zfWs0Z+PmAmR17/dftAUF5C6jgGkBzS0FcyFzpS6HQOMi3Q
         88PGyzWvj9dlwrPINOOHqglBRMWOofFRGiyEeBKR4IrNWqolyj4D9zL/7ZtNz2gFI+X2
         19gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724273695; x=1724878495;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYR3FZrbm7ZbECMDVKfBOotCzlugr9vc0sg5bZEeoTg=;
        b=u5p5FQa/wu6z4oOYZe/462hJGYDDdZM6pd6QSeAuLrFHOBAbCMLtDRbRp0mUNAlBwN
         /V1jdnBH1LAEQX20XTnJfQ+GL6S40XD1FpjVAbR1EG13oTIyUBIhSFAUaqvSm2EfPibz
         zYkKJezwL0JW5IdjyuM2GAjpcDTYCu09DvI36+o7iOYRKPg2CdIlvQ+kR7E+QNczPcDX
         1UMf91ZWXhUnKqhi0AHIof92vRPJXMK6kbc+Rw+nNAIwUrZ506QIi4jF4eN44eCXEwzk
         UC27jIbkIgnR9QD3+ooauI7QmqJYVPow4idOO4RYBDKtLada3to9GWuJAsGIrGclT98p
         oczQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZRfwYMkaXUVUwvX21thCqwxDfWv5HVazKV1AI4uUqTJmdehFPhhPWFq8J9rwAn2a+TsfV1dhEVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUjRmE4MLcTcFLqbZFa3cHLXZk+Z1f1ZTFEtGIusbFbM1tGPL9
	PYumzuh+SE86vy9R4L6oaK3TDioUdnx6qw0hV8HwRZ087CHuNJ6O0vTqIbm9me4=
X-Google-Smtp-Source: AGHT+IFUaAdzt/add6u9EwFHB5BHmpvuFlYHDmToeaXOqs/XB3RmMJ6w9x07tyhqJFSb+qOtOkCotQ==
X-Received: by 2002:a05:6e02:20c2:b0:39d:113d:71e6 with SMTP id e9e14a558f8ab-39d6c3586f8mr40590135ab.3.1724273695292;
        Wed, 21 Aug 2024 13:54:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acabbf3sm39098a12.29.2024.08.21.13.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 13:54:54 -0700 (PDT)
Message-ID: <66c6541e.650a0220.12a61d.045f@mx.google.com>
Date: Wed, 21 Aug 2024 13:54:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.11-rc4-64-gd59a2908cfee3
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 32 runs,
 7 regressions (v6.11-rc4-64-gd59a2908cfee3)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 32 runs, 7 regressions (v6.11-rc4-64-gd59a2908cfee3)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
imx8mp-evk                   | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =

imx8mp-verdin-nonwifi-dahlia | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =

meson-g12b-a3...libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =

meson-sm1-s90...libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =

rk3399-roc-pc                | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.11-rc=
4-64-gd59a2908cfee3/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.11-rc4-64-gd59a2908cfee3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d59a2908cfee32b60bd9891f81d2c0afce265795 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
imx8mp-evk                   | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/66c64e569124ff02d4c8687c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.11-rc4-64-gd59a2=
908cfee3/arm64/defconfig/gcc-12/lab-broonie/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.11-rc4-64-gd59a2=
908cfee3/arm64/defconfig/gcc-12/lab-broonie/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230703.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/66c64e569124ff02d4c86=
87d
        failing since 0 day (last pass: v6.11-rc4-45-g5807af07cb47b, first =
fail: v6.11-rc4-62-g96051083f54ab) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
imx8mp-verdin-nonwifi-dahlia | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/66c64b19bc23ea98b7c86855

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.11-rc4-64-gd59a2=
908cfee3/arm64/defconfig/gcc-12/lab-broonie/baseline-imx8mp-verdin-nonwifi-=
dahlia.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.11-rc4-64-gd59a2=
908cfee3/arm64/defconfig/gcc-12/lab-broonie/baseline-imx8mp-verdin-nonwifi-=
dahlia.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230703.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/66c64b19bc23ea98b7c86=
856
        failing since 0 day (last pass: v6.11-rc4-45-g5807af07cb47b, first =
fail: v6.11-rc4-62-g96051083f54ab) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-g12b-a3...libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/66c64b4abc23ea98b7c8685e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.11-rc4-64-gd59a2=
908cfee3/arm64/defconfig/gcc-12/lab-broonie/baseline-meson-g12b-a311d-libre=
tech-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.11-rc4-64-gd59a2=
908cfee3/arm64/defconfig/gcc-12/lab-broonie/baseline-meson-g12b-a311d-libre=
tech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230703.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/66c64b4abc23ea98b7c86=
85f
        failing since 0 day (last pass: v6.11-rc4-45-g5807af07cb47b, first =
fail: v6.11-rc4-62-g96051083f54ab) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/66c64b94e2a7e49c74c86855

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.11-rc4-64-gd59a2=
908cfee3/arm64/defconfig/gcc-12/lab-broonie/baseline-meson-gxl-s905x-libret=
ech-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.11-rc4-64-gd59a2=
908cfee3/arm64/defconfig/gcc-12/lab-broonie/baseline-meson-gxl-s905x-libret=
ech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230703.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/66c64b94e2a7e49c74c86=
856
        failing since 0 day (last pass: v6.11-rc4-45-g5807af07cb47b, first =
fail: v6.11-rc4-62-g96051083f54ab) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-sm1-s90...libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/66c64c62a5f91b8d48c86855

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.11-rc4-64-gd59a2=
908cfee3/arm64/defconfig/gcc-12/lab-broonie/baseline-meson-sm1-s905d3-libre=
tech-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.11-rc4-64-gd59a2=
908cfee3/arm64/defconfig/gcc-12/lab-broonie/baseline-meson-sm1-s905d3-libre=
tech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230703.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/66c64c62a5f91b8d48c86=
856
        failing since 0 day (last pass: v6.11-rc4-45-g5807af07cb47b, first =
fail: v6.11-rc4-62-g96051083f54ab) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
rk3399-roc-pc                | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/66c64b36bc23ea98b7c8685a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.11-rc4-64-gd59a2=
908cfee3/arm64/defconfig/gcc-12/lab-broonie/baseline-rk3399-roc-pc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.11-rc4-64-gd59a2=
908cfee3/arm64/defconfig/gcc-12/lab-broonie/baseline-rk3399-roc-pc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230703.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/66c64b36bc23ea98b7c86=
85b
        failing since 0 day (last pass: v6.11-rc1-12-g7a7f6947f545, first f=
ail: v6.11-rc4-62-g96051083f54ab) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/66c64c313bd1358245c86856

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.11-rc4-64-gd59a2=
908cfee3/arm64/defconfig/gcc-12/lab-broonie/baseline-sun50i-a64-pine64-plus=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.11-rc4-64-gd59a2=
908cfee3/arm64/defconfig/gcc-12/lab-broonie/baseline-sun50i-a64-pine64-plus=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230703.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/66c64c313bd1358245c86=
857
        failing since 0 day (last pass: v6.11-rc4-45-g5807af07cb47b, first =
fail: v6.11-rc4-62-g96051083f54ab) =

 =20


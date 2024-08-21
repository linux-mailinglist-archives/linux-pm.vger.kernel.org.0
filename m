Return-Path: <linux-pm+bounces-12650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC19595A419
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 19:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02CEEB21B6D
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 17:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC741B533A;
	Wed, 21 Aug 2024 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="OzCKBQlh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3B31B5309
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724262138; cv=none; b=dgcj5AnNX/sVmX2yijaM3nuk5siOy6HGs5ytaGywnhdRKRVVkwO+2C80TSewE2TG0ttdfFWpvoeQ8HSYXCGo4UieUn+XoDLHLeM0hNha7u63b94drEpTktFbGAOT1QWG11/jjuWHoU97SnMr1FW77rbmM6t82d4cqDAhT6Nmg9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724262138; c=relaxed/simple;
	bh=OYsVfhItULfR8hqHIHaTCs9pRuj9D5T43uO+p9aqgF0=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=ERCqHD+th4j0Qz0jyAUCgI/kxFi/qjw43Ybe04FFzzZf8qxixwXTwVQcPjN/QOmQGholYt5iaaGNwJPtECWOlumZwI2abltxZSQZZ3ZBcw2XLwJBIKRppZr2qf2SgArq+dS7LxOs1owhQtxXaeSyU/7g9W/qRDkEdc+HrdIHg80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=OzCKBQlh; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7141e20e31cso1398887b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 10:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1724262136; x=1724866936; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wqa+RIQmYX3AtVVFwPhFkiTIbBzavJUN3qlGQrGdqHk=;
        b=OzCKBQlh9nQRBWYN3vTAAskZAL0DUTj08/YsCif5TiC9GemGF2nGGtNa6xZG3IQUm+
         sEdoAQkOYZwOrWxjBruKWd1X8wokgxQwqVV6/neLF1e6oHI7HASEfnCsiCrvLq2QCXg4
         9+PwwmjImkCnZx2Fmsw7GqzFWfiqw3P+HFNtscOEIplSh/esq9/QB7towZTGNihcGWIJ
         i8AO1GPFnI81/kmlAgB5mSMiEteazvkXZ0SZVMC5ADsrpmpgnUk3f0z5tpOBDTmuhrOP
         NzZ44drxrk8GYs+FCPA7PK54eLAoUxoT24qaCViL0v/7P2x3Oslxs7X+uYGcN9D97TXx
         Oqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724262136; x=1724866936;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wqa+RIQmYX3AtVVFwPhFkiTIbBzavJUN3qlGQrGdqHk=;
        b=rJa4hL0aPdTM83m6y0VKPaXr/QT8rSR0OwhpFIIfQfM8T5Zs+6uTbd3y5YGLb2FiZp
         oC0Wyf6pa48nEYzxtUcBR2K21EoxjDUJXYXyt1OokJmqpZEDLkyTm55BOt7rQiFUBO9P
         quWm6N4Hn0xtEZr+I6/G2S1+qIAkccIm4g/wCK1i5EBpf9UzyLBA9H7ShBUj8ymdafGs
         Ri8EDbvWZ88+JuFFZAZYAIrHp5MU6XuVSgZpJjU6S4QhO2C2HrACnTdNXfxCHCc27TgI
         +rM092sBGHlQhcz5ZTALSieFWkiilYrgobm//UV2JZsWLIWXxH2iHbeb2a91MpC0GYcE
         9GYw==
X-Forwarded-Encrypted: i=1; AJvYcCWu1xsgzUy1h4lyinOTAP3hhsKVXrlT6CAAd0ekyQACbJPb7uOMLjeGP3GuocPGQnnXtPljKCs24A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDHVUH8mak2nS5TGQoS8Y7FGFy8clwaygpXqw/mj4V7HA/QPYV
	FMJQJMC/fO/d3OV7qS1eqgNAxz/aqPZUSsuf/8BBU6Uahd1Hy1bHSCjxO+0dxX8=
X-Google-Smtp-Source: AGHT+IEp46RvswP6iUdOWyZ9JELg3s6vcjO1CopufIqTDgiI+KzjJAc57cPKiqpj7HuchEyRVL4miA==
X-Received: by 2002:a05:6a21:e92:b0:1be:c6f8:c530 with SMTP id adf61e73a8af0-1cad7fb3757mr3565619637.26.1724262135628;
        Wed, 21 Aug 2024 10:42:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3fdfcsm10204353b3a.219.2024.08.21.10.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 10:42:14 -0700 (PDT)
Message-ID: <66c626f6.a70a0220.252856.6381@mx.google.com>
Date: Wed, 21 Aug 2024 10:42:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.11-rc4-62-g96051083f54ab
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 32 runs,
 6 regressions (v6.11-rc4-62-g96051083f54ab)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 32 runs, 6 regressions (v6.11-rc4-62-g96051083f54ab)

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

sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.11-rc=
4-62-g96051083f54ab/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.11-rc4-62-g96051083f54ab
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      96051083f54ab00630804ce8fed69667929f6299 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
imx8mp-evk                   | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/66c61df263ab5da8fbc8685c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.11-rc4-62-g96051=
083f54ab/arm64/defconfig/gcc-12/lab-broonie/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.11-rc4-62-g96051=
083f54ab/arm64/defconfig/gcc-12/lab-broonie/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230703.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/66c61df263ab5da8fbc86=
85d
        new failure (last pass: v6.11-rc4-45-g5807af07cb47b) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
imx8mp-verdin-nonwifi-dahlia | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/66c61ec70259605c85c8685e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.11-rc4-62-g96051=
083f54ab/arm64/defconfig/gcc-12/lab-broonie/baseline-imx8mp-verdin-nonwifi-=
dahlia.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.11-rc4-62-g96051=
083f54ab/arm64/defconfig/gcc-12/lab-broonie/baseline-imx8mp-verdin-nonwifi-=
dahlia.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230703.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/66c61ec70259605c85c86=
85f
        new failure (last pass: v6.11-rc4-45-g5807af07cb47b) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-g12b-a3...libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/66c61e57f390622954c86863

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.11-rc4-62-g96051=
083f54ab/arm64/defconfig/gcc-12/lab-broonie/baseline-meson-g12b-a311d-libre=
tech-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.11-rc4-62-g96051=
083f54ab/arm64/defconfig/gcc-12/lab-broonie/baseline-meson-g12b-a311d-libre=
tech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230703.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/66c61e57f390622954c86=
864
        new failure (last pass: v6.11-rc4-45-g5807af07cb47b) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/66c61e8b36680094dcc868a8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.11-rc4-62-g96051=
083f54ab/arm64/defconfig/gcc-12/lab-broonie/baseline-meson-gxl-s905x-libret=
ech-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.11-rc4-62-g96051=
083f54ab/arm64/defconfig/gcc-12/lab-broonie/baseline-meson-gxl-s905x-libret=
ech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230703.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/66c61e8b36680094dcc86=
8a9
        new failure (last pass: v6.11-rc4-45-g5807af07cb47b) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-sm1-s90...libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/66c61e6cd532c0a00bc868b8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.11-rc4-62-g96051=
083f54ab/arm64/defconfig/gcc-12/lab-broonie/baseline-meson-sm1-s905d3-libre=
tech-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.11-rc4-62-g96051=
083f54ab/arm64/defconfig/gcc-12/lab-broonie/baseline-meson-sm1-s905d3-libre=
tech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230703.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/66c61e6cd532c0a00bc86=
8b9
        new failure (last pass: v6.11-rc4-45-g5807af07cb47b) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-12   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/66c61dad22b89910d8c86857

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.11-rc4-62-g96051=
083f54ab/arm64/defconfig/gcc-12/lab-broonie/baseline-sun50i-a64-pine64-plus=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.11-rc4-62-g96051=
083f54ab/arm64/defconfig/gcc-12/lab-broonie/baseline-sun50i-a64-pine64-plus=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230703.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/66c61dad22b89910d8c86=
858
        new failure (last pass: v6.11-rc4-45-g5807af07cb47b) =

 =20


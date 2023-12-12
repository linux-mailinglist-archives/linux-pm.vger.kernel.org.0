Return-Path: <linux-pm+bounces-927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A84BD80E48C
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 07:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63270282D68
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 06:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2C415AFB;
	Tue, 12 Dec 2023 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="UB0ac9NG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BD9CF
	for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2023 22:53:54 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5c66b093b86so4758861a12.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2023 22:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702364034; x=1702968834; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1AcPgqRQiirxfEWRfu8wqWx4+9iwywzkzitbg9poWpA=;
        b=UB0ac9NGl+yjNbIAX2Sz3PcwJ1NiDN6eH6VRfzPoDVJ8d5/v73dNrQeUD9DwbqjppW
         Y0ENhOY9ZcRyfCdRqUj9FtuSkp3JWa9SkUoj0rWgy8qcpw0f8KRwDJ/fVwLDbwjL92U8
         FEnQxPTLJOiC+8mKW/Xg5qWNupMyMPQE2YRhYm7bHTRzxzqBg6CVObp1nh83nvdKPEqV
         j3gKeovHsGv1w9qqdjDEn+/e6Rnnjt7Z+A+70+YLNhhwx5n08QqI8VAwvv2BjjtAkFAV
         rdADRS3QpRPVpQ0UtqoV9AI7WpbDPsRdNV+7OqFVHEKeWoKuu887kQ7Mpi8R34BrQDLL
         B0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702364034; x=1702968834;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AcPgqRQiirxfEWRfu8wqWx4+9iwywzkzitbg9poWpA=;
        b=bXNj5MzCdKP5TTpcpzb2Rzk6s8MSZAcblmDCD4I9IaRbuVzsx4GjBjlLMnshAjKZEO
         oJ1ybre00N4SYodKHOse1ukzvdN0swlMQk2y3XUIUxO0o654Qpc54V7DPe8QfaY7cp+I
         9TpcbBlvIJQoEjJki9vASXRwr99in3BshKxmfPkVuVN/TpLpeFKS36EvMhf3EIAcrhkt
         aHQbKQZWUxUVO07AJOtqdhPEjG2kbfq9QAav6LBX1lJW+uZIuLztrDRjrFOnRDzH6oll
         Dytg+lxGYr0trNnLpo0Se+yh5RbZ0XSpuETb/wF2XjnGoDY1m36msxv/4cLKLWB+yNZm
         IHEQ==
X-Gm-Message-State: AOJu0YyUhBMRrNuG7dogLVXQX7pgghq6Ev0inCSfvrnDaQu9lRZC3Cw3
	6YeNai+GHwwQeYLFvz6dsUOBYQ==
X-Google-Smtp-Source: AGHT+IE9Y1Sq8zHBCs8Od+ZeTzfMZaTJBk6BUlGNX3HFS/ESaNADUcsMEhuMLE+Zrkb6Qhzmi9X0TQ==
X-Received: by 2002:a17:90b:1891:b0:285:490d:10cd with SMTP id mn17-20020a17090b189100b00285490d10cdmr7196471pjb.3.1702364034301;
        Mon, 11 Dec 2023 22:53:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id qa6-20020a17090b4fc600b0028613dcb810sm8293599pjb.23.2023.12.11.22.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 22:53:53 -0800 (PST)
Message-ID: <65780381.170a0220.afda8.7d12@mx.google.com>
Date: Mon, 11 Dec 2023 22:53:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.7-rc5-62-g5173d2be59b3d
Subject: pm/testing baseline: 56 runs,
 1 regressions (v6.7-rc5-62-g5173d2be59b3d)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 56 runs, 1 regressions (v6.7-rc5-62-g5173d2be59b3d)

Regressions Summary
-------------------

platform       | arch | lab         | compiler | defconfig      | regressio=
ns
---------------+------+-------------+----------+----------------+----------=
--
qemu_i386-uefi | i386 | lab-broonie | gcc-10   | i386_defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.7-rc5=
-62-g5173d2be59b3d/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.7-rc5-62-g5173d2be59b3d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5173d2be59b3d85bac70339074548dd738fd6034 =



Test Regressions
---------------- =



platform       | arch | lab         | compiler | defconfig      | regressio=
ns
---------------+------+-------------+----------+----------------+----------=
--
qemu_i386-uefi | i386 | lab-broonie | gcc-10   | i386_defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/6577f5900504bf4807e134a1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: i386_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.7-rc5-62-g5173d2=
be59b3d/i386/i386_defconfig/gcc-10/lab-broonie/baseline-qemu_i386-uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.7-rc5-62-g5173d2=
be59b3d/i386/i386_defconfig/gcc-10/lab-broonie/baseline-qemu_i386-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6577f5900504bf4807e13=
4a2
        new failure (last pass: v6.7-rc4-67-g169769cb3761a) =

 =20


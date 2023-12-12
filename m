Return-Path: <linux-pm+bounces-995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C92280F47F
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 18:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BEF2B20CEF
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 17:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9C37D88E;
	Tue, 12 Dec 2023 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="F32k1Ztf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25C3B7
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 09:25:44 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d3470496e2so3041115ad.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 09:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702401944; x=1703006744; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Mbed8XPacJMxvXKLI3wpzTkAPK7BMP/i93mS7E8IcQ=;
        b=F32k1ZtfNZhpKT+ljuLFumjPNHIV5FConVywWV/hWNdLQamtsTDB0KCr4Fx8VeIve0
         BKsYfXsBYZ0lMf6yBEFI43Au6LocB1FPLLclbRUA/hrYSFD3dXk92yhI+lwPCf+Dgg33
         RxZNSN/6fpVqD595wcNc4X9yi9MJslGZmZZSN1T6F49H7UJM1NKLDf1oYc84UtDeA4gY
         mmoD4tcFbD/Dq9UecDzBJcjELbuliFU9QHF5vFq09M7Ey1lFREVk5Je0buxGTHkOncSj
         5LSxMhaAWeIFRnh9VplN0ShHh1Rb9mTzyduIvL9VT02vGVbFoPOrFMtFZf/EjiBZk7d/
         7rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702401944; x=1703006744;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Mbed8XPacJMxvXKLI3wpzTkAPK7BMP/i93mS7E8IcQ=;
        b=CuD4277IDH+Pf3Y9jwZ6jrG81XQSbZIq5+KJOiDLC/3EVEDKKjvxrfWg5vaFcDy9EO
         bOR4RRyBmQlpMA3FrTR2pmBNjlpzrelC2FWAiSVf2BsslO7dwboIBR7e+CGVEgvht5Bl
         lZfvvf2KYi+iMJMRgYpq4Mq9exyiuhBcw2kvmxH2X0scSyJkt4NU1zwbchZHAl4onmQK
         9wq7pDBovIqrX/X8wATjPwueyKbG8x2GoxBVNFB3LQmLWMKIzmrQdDTi3V+yIWnym8AW
         UZX85UmukX6iJ8OVFEITiX52KKuLjA6zuMNV88AA2u/fkM5F1m0I4hWffeHW5SG94g0Z
         MV4g==
X-Gm-Message-State: AOJu0Yxuao2fF+/HtTM02qbl4ILIaKU/IrWVpgYud1MM7Io7Q9Bno8Mw
	zU4JxsIbbm1THGXC6gUhpNAfGw29Y3rAxf1x81Ixdg==
X-Google-Smtp-Source: AGHT+IF9mYUtpNIhvMjIINblCe5SuTrSfchoTzjBFyOt3Fog6NYxfgu3AHOWajNaDqrYZ31eUr1qog==
X-Received: by 2002:a17:902:c950:b0:1d0:6ffe:a09 with SMTP id i16-20020a170902c95000b001d06ffe0a09mr8029317pla.103.1702401944332;
        Tue, 12 Dec 2023 09:25:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jm2-20020a17090304c200b001d2ed17751asm8569943plb.261.2023.12.12.09.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:25:43 -0800 (PST)
Message-ID: <65789797.170a0220.c6a76.88a3@mx.google.com>
Date: Tue, 12 Dec 2023 09:25:43 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc5-71-g15c1f7c6e0578
Subject: pm/testing baseline: 58 runs,
 1 regressions (v6.7-rc5-71-g15c1f7c6e0578)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 58 runs, 1 regressions (v6.7-rc5-71-g15c1f7c6e0578)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.7-rc5=
-71-g15c1f7c6e0578/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.7-rc5-71-g15c1f7c6e0578
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      15c1f7c6e0578df001fc5972e1cb64a6b306c3a1 =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/65788d7c92b24a82a1e134b0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.7-rc5-71-g15c1f7=
c6e0578/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb1=
5-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.7-rc5-71-g15c1f7=
c6e0578/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb1=
5-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65788d7c92b24a82a1e13=
4b1
        new failure (last pass: v6.7-rc5-62-g5173d2be59b3d) =

 =20


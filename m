Return-Path: <linux-pm+bounces-6071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F84789CE94
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4E11F236EE
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 22:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BF8149E17;
	Mon,  8 Apr 2024 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="nO+2+FPa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E8A2AF14
	for <linux-pm@vger.kernel.org>; Mon,  8 Apr 2024 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712616676; cv=none; b=lVQpWS58COaeUy3iGukNWWxp4BWkWY8gwiOUnL1pQCDjB6pZMmg8RCgNQClL1QIU3xYylytT9KQMXGDVE5KPryDkJhNc1rTlq1nBIBxA1PGk+J7eCrH6TPI72ZeCBUoG5tiwLxY7mwZakYEjvsA4Ayvz1L2x+vbZZ5aQhlC0OtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712616676; c=relaxed/simple;
	bh=67nYmxximUQ27f2WtztN1bJkdtQIQjqSMdGZ2dtkZG0=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Acctwc/QEdUstuUyVQCDePJY9PGwnw7ruyT0PNDM2jzC3uOwgHCBndVy88O0IY9EiISQXrPAqPbgq7KX7TXdbV9zl7BhgXtnANrqPkkzvnQpajPYxS8bX8YHQ9WQAyLCRvYrhnL+nXuNRZHkSA+qhODyRr6PwMmBpzkWbVNWHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=nO+2+FPa; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so3216773b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 15:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1712616673; x=1713221473; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RSMm0pOWaEMOkEY18Zx1kzdWZdXO1CMLcYXCieYJTMo=;
        b=nO+2+FPanC7FwDgZLN75gRidbkBTEMaec/q8Ki0N+BbEdYao2kiZ20Yzz/z2A8wG9N
         lVpDbbTvkb91jwvDqLB8vOsN4PvtX3dHMhpmO1geWfvOtUKEnT4++ANCsXXGExKXMvnP
         NK41FdfmcPQHMpAtk4Ogx8CwGcN9Cy12uGQ59O/a2e+p6yv6fmrAqJSn3T+TWBp9SfUb
         /qXtmI+k+wHDq6YkwKwD15lWES4D2G75J/zNr5QLtZLyq+9DjuuCh19mze3pQsVb0ER2
         mprKTaCAifXWggBIVdRq1ZFRAMwhLPKbo1XpW9bhZ1OalY9dDmaT5AfxcX3c1SPo70W3
         eEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712616673; x=1713221473;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RSMm0pOWaEMOkEY18Zx1kzdWZdXO1CMLcYXCieYJTMo=;
        b=a56N3Vq/uKqdcH7FL4+1sze8HA/PWBqaXZfdVtDeGwvD1uYtsg6gFGOHbG4g3jUl7i
         85quhHDpD9Rl7UXx50AIVUnsUjEcdwtzIRLwo8rzlqVp2fHAsfARfTYhDbNtsXePVrh4
         B6htKZFYVWlHjj7gbHJ+NOi0UOGEeSGNNLrvvuHpY173t+DBS7gm/7P364n55HgyHg4B
         qdKHYpcVI7asdo9Wx92AZq0eIQkRsl9KhGM8Q2l+h8d93dXtf+FqdXkTNvYlY0d9OIwl
         r8NjMGO4DSetdbpgf6O7/R+s9pSBaiQ4U1XcOdQ9ZFlqABPCgfBScjlY8Uc7y2kaA7qR
         ldeg==
X-Forwarded-Encrypted: i=1; AJvYcCXCvWk0fC5bjC4ES6+9UEpquh5V9xNw5ENG4EPZ/SZ08Dj6Liq8gwQ9URsoaKrv2WJJ+LE6ueg04D8xfs/zsQd5fbKPjgD+lKI=
X-Gm-Message-State: AOJu0YzmnzdcJ7eCA3E4Kg7/yNtoHeuaMhPjWNMr1l48WMGqJQX78CXJ
	LV9kM157bpL5fpr9qgfED1qxDNmCIHQA6IsF7RIXEwiKiFhJFKPi14biGxzBqV9512ysC0b64AI
	Sun0=
X-Google-Smtp-Source: AGHT+IFGsyVeSeHMrHt1olb/tb0+wUjSyu8OmYLVM9zD81EcMM0obMnREs+4WPLZjVUQU5o2eXSb9Q==
X-Received: by 2002:a05:6a21:9201:b0:1a7:58ca:cdf3 with SMTP id tl1-20020a056a21920100b001a758cacdf3mr7347312pzb.8.1712616673426;
        Mon, 08 Apr 2024 15:51:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n17-20020aa78a51000000b006e6adfb8897sm7115166pfa.156.2024.04.08.15.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 15:51:12 -0700 (PDT)
Message-ID: <661474e0.a70a0220.1f53.33cc@mx.google.com>
Date: Mon, 08 Apr 2024 15:51:12 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc3-46-g790383b39266f
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 59 runs,
 1 regressions (v6.9-rc3-46-g790383b39266f)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 59 runs, 1 regressions (v6.9-rc3-46-g790383b39266f)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.9-rc3=
-46-g790383b39266f/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.9-rc3-46-g790383b39266f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      790383b39266fd8fdbaed36120a4f620eb28fa92 =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/66146ab03a1f262e894c42db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.9-rc3-46-g790383=
b39266f/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb1=
5-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.9-rc3-46-g790383=
b39266f/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb1=
5-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230703.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/66146ab03a1f262e894c4=
2dc
        failing since 26 days (last pass: v6.8-rc7-160-g268314880cd43, firs=
t fail: v6.8-rc7-179-g7a90d40a48f4) =

 =20


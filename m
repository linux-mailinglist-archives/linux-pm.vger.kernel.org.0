Return-Path: <linux-pm+bounces-8783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 111D7900536
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 15:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1741C2229A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 13:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFF61940B1;
	Fri,  7 Jun 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="W769un6C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354B419048A
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767683; cv=none; b=ZMEbMXzfTKmxmbr5OJDs/4H2zcxtIMiermghjugNVTwkwvF7ZYYwz5Dok/q/GTxjG4l1Ss9+32wBxzaDP7t/cpiPfxlC0a+GjWkoVfi0n0Hpmnrdpbup9V6NvJpzmPl/p9CljNH9HuuqBup/IrxZaD6o9noboXeWkoEUTWsJqGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767683; c=relaxed/simple;
	bh=6aqTZTHnsThL0Ki6wuxZQ+3XCVXkV5GeXuIEmASScqs=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=BsBu7ghxfLmqRvAuT8j/McGKBMSsJxoG0WWxRJx2YPZoNXJW1fpEA/1XOGRhkVpt7jWPzdLhHNsd89uLJho5Ryj8sCtvJAY9Cvb1iob9LxrJXQ6Zx+5Ir0ww4BF+89BDtqX+A5uYNVsAArfmXTzHOqG5XWaHxergo5wXJjXcPFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=W769un6C; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f4c7b022f8so19296175ad.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2024 06:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1717767681; x=1718372481; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kjz2FXGfmGKiaGm/XNhlc5MjeSZ7VhsWXNrc+Nu+u0M=;
        b=W769un6CaFtmkZJ4FxrbdpC9WgNQwEWdXRSBAK6SR5sBryW/IDo6CBn2p3GWkhwkzT
         Tq1vvnVDjU2/wbWxIlUYU6GiSnq/Q9l4MdymNV0zEvroxbFklWmLA6lbKyz+siq4KR8N
         Fuxx+QXBjdq3XiVg2UtVZWwZSCtydQpEa+h2bvQDZxI8pTPTUYJCaSniuezd6MwF4zCu
         I8eSQJjmTUr2fZJTmsltqpyiNgkJqFtso1Gy8qnrk9o+Nj4D2DLyPtKSmDZsGG74MNBy
         JXsFyQq+jyMlv8R7Z8mIkcOKP9qa0IGsF9b/nyrKyuSIHBBe0+Vd0jTg0To39R0uKW+R
         2cdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717767681; x=1718372481;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjz2FXGfmGKiaGm/XNhlc5MjeSZ7VhsWXNrc+Nu+u0M=;
        b=kE1R5Ot7ri/NTCwuP9Iy3hOvB1MIJIJNRVb9xwWKg6L1NCCUV+JNWrC55PkBRfzBUO
         /ZbxHHS6ilLgE6ywxfXoYb5BrC9+6DEeKn+K+XlUIe38+eAddAm/lJFJ/KIClNgJg9Ml
         8Zm5wqFCuQmDZAXTPghWvdmR/3/tVXUrpzqwv2pxGh84z8ocxBVJEXLoQ26kngPyteD7
         6OSAqtw+yG6NA1qaSbEW3qZbFGh6h3E9g7yey30ooJYzY+WsHw6DjY5Lelwy8jyX0eHC
         JXsq0jLZsKcwmEMAsJi3QPccZZUdAMha8YTEng4NaAJKhJ/kXf3ggveYNvFiOc0e9N2B
         hDew==
X-Forwarded-Encrypted: i=1; AJvYcCVLLdJBl+zwZu0Oa6Tw0rXgS5K65klQteaFA52h+4kLFAceOu5j0AtqFLj5/8ccGeurv9YMsHcHM/6oYUbY2g6GrD7kfJAR+xs=
X-Gm-Message-State: AOJu0Yw5Cxa2jVJr7U0yA0FTISRI5Ed0kR85J26+VXkjKuutwPqOZI2L
	4hpaGKJc+4doTEj8+OjYH7cq4ED/BCpi+KVTQ+9+ecZcMI+AqFtnsaNz17Y3M1lE4vTU5N6asAh
	e
X-Google-Smtp-Source: AGHT+IFaY5R3aF7qSNwzayfIRVp+HbUo/iE2KeH4/RD3ROaLO1gR35m0fPAyhq4zWZhQNvCL62QDDw==
X-Received: by 2002:a17:903:230a:b0:1f3:6ac:fbcd with SMTP id d9443c01a7336-1f6d0377214mr29049065ad.44.1717767681445;
        Fri, 07 Jun 2024 06:41:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7606easm34266895ad.45.2024.06.07.06.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:41:21 -0700 (PDT)
Message-ID: <66630e01.170a0220.365a8f.9210@mx.google.com>
Date: Fri, 07 Jun 2024 06:41:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc2-102-g8ed7b65b7edc3
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 61 runs,
 1 regressions (v6.10-rc2-102-g8ed7b65b7edc3)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 61 runs, 1 regressions (v6.10-rc2-102-g8ed7b65b7edc3)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.10-rc=
2-102-g8ed7b65b7edc3/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.10-rc2-102-g8ed7b65b7edc3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8ed7b65b7edc3518cbcd873aef5d23f2fcd37ee7 =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/666303e864196ba46a7e709e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.10-rc2-102-g8ed7=
b65b7edc3/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-w=
b15-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.10-rc2-102-g8ed7=
b65b7edc3/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-w=
b15-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230703.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/666303e864196ba46a7e7=
09f
        new failure (last pass: v6.10-rc2-102-gddb5639c3f502) =

 =20


Return-Path: <linux-pm+bounces-9036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC8F905B6B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 20:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D61628E1D7
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 18:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC2B5A4C0;
	Wed, 12 Jun 2024 18:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="JKyYCc+a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68464EB45
	for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217951; cv=none; b=rDIaO2Hv0/BmqaQEQcylEIPXmWJR/KCFFnskYf85v+xd7LSC5311rIRH94bXNvjfv+Ghhn0FWAzdJduchQstnrjRQfMMuI/g4rCk4K3p6j0XelQDr4piPPLtskaxO5bfYfZfOgnzplUASArsd3o1jkRO3h9yvnwSz9rTse+jMnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217951; c=relaxed/simple;
	bh=c89VrSlp2GYFT3dQFdilmhjShzdobyg/3XejtkaA7so=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=sm4Jo33H1i7apwUPpueQ8uuRt+8cS3bUfwPpa/yQDfiOyh+AQDd2w+YXNGEVm9FqtTFczBmcMa0KRTwrpTXyCRVqxeVB5q9XzBgrzs2ma/9iClKsF2qLr7Vu4vSt4sgJg7+6EKzjOkkNVXnjLmyqc5tsvZuDE615Iuqf+c4Jfr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=JKyYCc+a; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-656d8b346d2so121917a12.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 11:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718217949; x=1718822749; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sDMp65pxu/oKqIUcMWog0yGIjM/tm9cyzX3E51dVNZc=;
        b=JKyYCc+a+pT9A7JvXhSQzPGeFDqGSDX08+NCUqlBu4/lFXeVT6ie4EmGOCZ3EWZjts
         cKMmjcP++Rm94CClYmaNqF9T8k/Qfqpg7usUxLxRB6rDdZzWQGMNEFPKIkcAij8uBbGe
         eGubdCmb7WjvqldRT6Wny2i9MWNtOgwVwylIyzWrI19zSBEfHiUaznLEAzkkBzabpWOP
         1OVidOd2+VbO9VP9owSbBHLxikdajyrVPrOBUl390F3khz/6Ar5sJfqu0FBnjB46A0bT
         6bRbBxlNrwGpPwkWU0FmbrDoGR2Sp6RMsPbWg62MwP0d8GTqA3sXebmkxXkOhUr7TGg1
         JEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718217949; x=1718822749;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDMp65pxu/oKqIUcMWog0yGIjM/tm9cyzX3E51dVNZc=;
        b=KU4MicRXUXGkabQHTWrR9FFJocMWrCXGdcNrsGuccvZ8byzb6A69NJg2eaqRlyxTB4
         P3RotNuCXxcXD+izJROqhCJFk7AalK4ocaLK2v17vx68L1SIBMsIZ8/ZDeUH475Zsao4
         MDYL2NGnghwNhwb02Q8SU2mBRsuqijO3hvhMgHGKViybMK7vIsQDgWYjgARseLziN2jM
         Xt5TQ9BmuFvHbaqkN3UFFtKlkoUCCLT4z3pABgUqXbbquvvlR0PMoOcyPemevy9ccmZ8
         S/Xw8v/a9hL3ujm/Uq6kHtFx+wvvpl775utk7K46c3QutpZj/AZeO7V/bF68b04bYBgs
         DV3A==
X-Forwarded-Encrypted: i=1; AJvYcCX0GEDfeQDKZmSKg0N10OF0ubqWJqXM9nvr5SDi9C/L52peWW29TG2MNsJv4z7lJP3FsWo2oqV7ekwv1i8ANqmIEJNev7JyArk=
X-Gm-Message-State: AOJu0YxFiieFXTYnFmG7hZgcpoVPH6SlDUzLz0DPyEdCn5hpWQ6W/LQZ
	5/waIQMS74y+4KaOcCrTsIFVAo40uhw2/XJWfwMOenAXfiCGX6qkDDOY0XoHg/I=
X-Google-Smtp-Source: AGHT+IGm8yWNYzztbP4w0+p5k9e+oK1qG7mQrMtS8UbRBzorrzGWZgg1YHBZ3OO+TVvxxD+AmCOcuw==
X-Received: by 2002:a17:902:ab88:b0:1f4:7a5c:65d4 with SMTP id d9443c01a7336-1f83b5e7089mr26535945ad.18.1718217948693;
        Wed, 12 Jun 2024 11:45:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71f397601sm53298265ad.61.2024.06.12.11.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 11:45:48 -0700 (PDT)
Message-ID: <6669ecdc.170a0220.be7ef.159b@mx.google.com>
Date: Wed, 12 Jun 2024 11:45:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc3-41-g0a2c035b1e6d5
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 60 runs,
 1 regressions (v6.10-rc3-41-g0a2c035b1e6d5)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 60 runs, 1 regressions (v6.10-rc3-41-g0a2c035b1e6d5)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.10-rc=
3-41-g0a2c035b1e6d5/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.10-rc3-41-g0a2c035b1e6d5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      0a2c035b1e6d598961e94001daf4e19d23f85af5 =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6669e1aff254f2e0427e706d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.10-rc3-41-g0a2c0=
35b1e6d5/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb=
15-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.10-rc3-41-g0a2c0=
35b1e6d5/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb=
15-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230703.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6669e1aff254f2e0427e7=
06e
        new failure (last pass: v6.10-rc3-28-g4b1e729cb8c00) =

 =20


Return-Path: <linux-pm+bounces-1545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DFD81C3A7
	for <lists+linux-pm@lfdr.de>; Fri, 22 Dec 2023 04:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649B7287759
	for <lists+linux-pm@lfdr.de>; Fri, 22 Dec 2023 03:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705AA6D6F9;
	Fri, 22 Dec 2023 03:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="1S6f1pyX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D796453A4
	for <linux-pm@vger.kernel.org>; Fri, 22 Dec 2023 03:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3dee5f534so18525865ad.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2023 19:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703217044; x=1703821844; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b8bdUDgZRNgJxnTB+GUvNvkrJyeoBCrrddmMAydzekg=;
        b=1S6f1pyXcXED7HSvh3TLt30VvQ6MRfuRuRStTwFBda0ErafZtXkg2D09rpxK1eldej
         wZUBFHtL50e5xaoK4A0CZIz7eMuqKr+2GS3fluWXrTRxQ2AHx4hpbQUq+2FUjyCkQqHu
         mqC6GzcWfWGgTRitWY7424KvWbVJuWPD28VMKCP6/tZSWWr537pUsJqKVRkNcTyLW5G5
         +P7g/Iz2knv3NU+XcMfptbSM4/HGdFuIItJf9xJY9ERJfx7MvIEwUK5xBDSdcrNNac7b
         WF0s8P54qOzQnJKX2X1E9bhqI+Q8BYtZPtmrGZXvywHQlhA/O19ihWurtX9YqX2+pU3r
         vwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703217044; x=1703821844;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8bdUDgZRNgJxnTB+GUvNvkrJyeoBCrrddmMAydzekg=;
        b=BRXbiZ6GvLBBefhXfiq+G/i7GEDywbZ0CEl2u0J6ydPC9FhxNHTEoqGn/hd8vywgk6
         OPSjsaqE2jSJPBAfYKWOVZOi4g6REIPdMvA2VoE5PywJzRaizK4HDNVc4cjRY9+lt0d5
         Oy+iCtFrQ1y0djw9IEPYs5+A3Sz3DXc5+2cxc7VagWn9cgwbbUXsjzKBDQbVjg4864yE
         eyphOtv+9FBUwc6I69B7ySigyZXxSA40AXLkBoHxVW+kO0jmJ8r6eq/Br86kvbi2lwzX
         A1VF7sfnIbLikmPWZDtB3kOn61vZ6fSF5jTM5pFDG0h8DogyxzbcSR97J1LdAcJcuQxS
         yR5A==
X-Gm-Message-State: AOJu0Yxz2YUZ7CKtuQKnbnweOvySbYvhxU8Aaq5cpaj7Q8NrhmcDP3T6
	9LbUNYNpQ767GOwmwxq8Ar8lJn2tTuIVkiFvWzGk27A5tos=
X-Google-Smtp-Source: AGHT+IGebh9BzouKBtez0HGLOry8e6mUlWmPzNrbjJtzYWk5jhRds46jVYYV241tt1PyU8acn4XH/Q==
X-Received: by 2002:a17:903:68f:b0:1d3:d3f0:6ba9 with SMTP id ki15-20020a170903068f00b001d3d3f06ba9mr1842872plb.66.1703217044051;
        Thu, 21 Dec 2023 19:50:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902b58c00b001d4152a6165sm685858pls.182.2023.12.21.19.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 19:50:43 -0800 (PST)
Message-ID: <65850793.170a0220.f243f.3abe@mx.google.com>
Date: Thu, 21 Dec 2023 19:50:43 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc6-100-g6a473ae3ce709
Subject: pm/testing baseline: 56 runs,
 1 regressions (v6.7-rc6-100-g6a473ae3ce709)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 56 runs, 1 regressions (v6.7-rc6-100-g6a473ae3ce709)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.7-rc6=
-100-g6a473ae3ce709/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.7-rc6-100-g6a473ae3ce709
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      6a473ae3ce709c1b9fb544f105559f195814535a =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/6584fdc220ac050b47e13477

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.7-rc6-100-g6a473=
ae3ce709/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-blac=
k.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.7-rc6-100-g6a473=
ae3ce709/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-blac=
k.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6584fdc220ac050b47e13=
478
        failing since 0 day (last pass: v6.7-rc5-91-g3b6de08083e1f, first f=
ail: v6.7-rc6-95-g52227a1b24640) =

 =20


Return-Path: <linux-pm+bounces-1170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F35A08138C3
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 18:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318BA1C20C42
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 17:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5E965EDA;
	Thu, 14 Dec 2023 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="DD7CPubA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7F3191
	for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 09:38:03 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6ce6b62746dso5405164b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 09:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702575482; x=1703180282; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wMBM8wrLw//Ml+zFWwD4TGfk/CR72J6JzB7bXWe5Jhc=;
        b=DD7CPubAGsNMrV8gv/0u5DiZ1SiO2BcV3TdkU4G01KJnaz6qXb8C48/dq7RyKNyLI8
         ve96sR9VJmidNe+1eKzHHBymFFjzYPAGNUDO0IUzxG7jHRyhGbnADIhPRdM/WdgC96II
         ndzaSHw3X9CQK/ucbeKoLi2ZSzVorxMlC9BdBEPF/owU9BProsf9zdny2kIRBgZ+prHv
         rktwqk616X8RJSLbO4xmUm8jFKlyP2+KnUSCumcPZ/kMttjK1SBuUcBwVlaqtk5mrIYa
         YT3Mvk7HeHg3hfIVMbcbwIrXz5NxReaFFgvg7g3DBbLYRPt9jhSf1/DgZtnw9Z7EZo+U
         vduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702575482; x=1703180282;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMBM8wrLw//Ml+zFWwD4TGfk/CR72J6JzB7bXWe5Jhc=;
        b=HwRNmb/fnPgHzYcA43Abzo6h2ND+Oqsa/y8SQeyqxQchWLPt4/zFxyKvWW1Lrttrv7
         zXgLiPkdMADk6JI9H8qvBlkFj+/6qIU9BcKV5jmY7URpJrOa2oNesfCN+w27yW9PwOMO
         1tLnb4fUPmKk1oRG2r1qkjr8jvNvdI/Wkzn2TmQUcJMLoxCqABvOFf4DBDS5vO0YpYWF
         avr85tm0rdLI41VsI6lVHqZZrKmWI/TYMvyrJGtO1Mw4lvXBu/Plt0rWPSaw2eIDHMkn
         bONdYbFL1VuGKkk0Le1SDGRHSbzBLAL24iph5+wh1V1BcNUkmu4znJ5vKknVyLZ8DBGc
         xnOw==
X-Gm-Message-State: AOJu0YwI5qF8ZPtpgQrizRsXa4RPt46ImUBWhvjgf3IjPT5JoTvPaW5/
	pcHIfJR0aNgxFlWkKZSL2IBLOgID1ZaVPnKBZY0=
X-Google-Smtp-Source: AGHT+IGMC6RuqPuDqT/wMvoAlquYv4CUPxeNNlBQ99cxNrgOO/UYQ5YvrVr3HoobsBsWr7M9hGoRFw==
X-Received: by 2002:a05:6a00:b51:b0:6ce:3f02:108c with SMTP id p17-20020a056a000b5100b006ce3f02108cmr5608759pfo.22.1702575482622;
        Thu, 14 Dec 2023 09:38:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d12-20020a056a0010cc00b006ce61c9495fsm12020023pfu.206.2023.12.14.09.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:38:02 -0800 (PST)
Message-ID: <657b3d7a.050a0220.37939.7079@mx.google.com>
Date: Thu, 14 Dec 2023 09:38:02 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc5-91-gee96d5c15517f
Subject: pm/testing baseline: 58 runs,
 1 regressions (v6.7-rc5-91-gee96d5c15517f)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 58 runs, 1 regressions (v6.7-rc5-91-gee96d5c15517f)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.7-rc5=
-91-gee96d5c15517f/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.7-rc5-91-gee96d5c15517f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      ee96d5c15517fbdf136aeff1919646e843fbb6f3 =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/657b336cb56f3e5999e13492

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.7-rc5-91-gee96d5=
c15517f/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb1=
5-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.7-rc5-91-gee96d5=
c15517f/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb1=
5-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657b336cb56f3e5999e13=
493
        new failure (last pass: v6.7-rc5-82-ga5166a0124480) =

 =20


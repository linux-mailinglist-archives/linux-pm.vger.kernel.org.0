Return-Path: <linux-pm+bounces-1511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7032281B686
	for <lists+linux-pm@lfdr.de>; Thu, 21 Dec 2023 13:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109C91F26352
	for <lists+linux-pm@lfdr.de>; Thu, 21 Dec 2023 12:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881C27C643;
	Thu, 21 Dec 2023 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="2fwhnr5R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDAD7BEF7
	for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2023 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-35d3846fac9so3077925ab.2
        for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2023 04:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703162931; x=1703767731; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iffL0toZTsUNOp4O3Gui4zN7Q/1D8BsuDf2xkAfQTjE=;
        b=2fwhnr5RV5yAjz+h6zaWd2upIFOCQeo/vB3Wvr7PZqio3Q+xrFsGg5pgf3fDnpZ0qR
         o+qdHlORjITdcZwW3xzsae61MVxKfTxtH19fmxHDgRzQbOK9bNqOmm0XFKfJJvU4Qjof
         K9+7U2mpCRzmeDuPU6R/cfVXwpF7xI7wrs92i68SFKRRNXyrbI21rrA+T6/uTvF/nW9J
         0K2b9UvHlZ9OzW0GVBB6iBypCBPE07G+Fjxerq3PHlWRlPEkVn4RAMN9+yRYerc1JvWb
         D21ijSFT9uB3h24AI/Qm7HH1wh6tWn95aL+rhJAQp0+Y8yVX/QzSOUvNesVhNPgc0JrJ
         85Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703162931; x=1703767731;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iffL0toZTsUNOp4O3Gui4zN7Q/1D8BsuDf2xkAfQTjE=;
        b=Aqn4pZz1Z6rWE41AZWNDXq1QTmYYe8kTYT5xDWOwMZudfpjaBezoe/mZE2L8nrmKL9
         Z+ugplI1onccCs/9W34/dD6mpw92WsAFF8uKkuCvPmq1SO6bs77MR1QKYt2P5GttkCAg
         XznnItymxO1BWt8sXqSMsHSacYK0qliaSTd+Svw1I+RAu/HUHOvaxzD6330BcpToV/Jg
         caiTCMkvTEHbwXkbXEGvvEdgM3N8HBmzs45IWfqcu9f52IxQC7UIkAcd8PjRZ1XGQnwN
         2q5Rqu6Dsm1QzANAAJhXfroEIVJxZltHGG2YYrZwaQr8S6in+1ldur5nomsUP/9CK5ss
         VDuw==
X-Gm-Message-State: AOJu0YwZRvDFdD2kIYwEh4vMV4PIZFGuvibGE160Mz3kJEpRHMXMg4Yv
	nrbOm035wNvC8lS04prKgo5tjg==
X-Google-Smtp-Source: AGHT+IF3PCpgBP4ad/Fp7+vBtgxFP6IH6mqxExZ1aDhh8SfxUa1J6cbkRrNJh9v91A/VtfkYvEBkeg==
X-Received: by 2002:a92:d941:0:b0:35e:6b02:7037 with SMTP id l1-20020a92d941000000b0035e6b027037mr22038640ilq.58.1703162930825;
        Thu, 21 Dec 2023 04:48:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p23-20020a635b17000000b005c66b54476bsm1441341pgb.63.2023.12.21.04.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 04:48:48 -0800 (PST)
Message-ID: <65843430.630a0220.9b24a.3c9c@mx.google.com>
Date: Thu, 21 Dec 2023 04:48:48 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc6-95-g52227a1b24640
Subject: pm/testing baseline: 56 runs,
 1 regressions (v6.7-rc6-95-g52227a1b24640)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 56 runs, 1 regressions (v6.7-rc6-95-g52227a1b24640)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.7-rc6=
-95-g52227a1b24640/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.7-rc6-95-g52227a1b24640
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      52227a1b24640361bf68926fe12e60ab76004c7d =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/65842a77727c4520a3e1367e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.7-rc6-95-g52227a=
1b24640/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.7-rc6-95-g52227a=
1b24640/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65842a77727c4520a3e13=
67f
        new failure (last pass: v6.7-rc5-91-g3b6de08083e1f) =

 =20


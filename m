Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43CB476838
	for <lists+linux-pm@lfdr.de>; Thu, 16 Dec 2021 03:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhLPCmR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Dec 2021 21:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhLPCmR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Dec 2021 21:42:17 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A009C061574
        for <linux-pm@vger.kernel.org>; Wed, 15 Dec 2021 18:42:17 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z6so18239966plk.6
        for <linux-pm@vger.kernel.org>; Wed, 15 Dec 2021 18:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ruSFKYuJWvSSI13PQVNBt4J3FMBiI68WZj57AY3dhYU=;
        b=iYQNFJ6tnAT0JM3WYPjV8buyvlKkwOIDRXAVb3ef3Jkt52WesObSW2lheXBmnT6CB5
         jhw0sQ4VKI9LO55dC+CgKVwp3S6LHuEcl7HJV6LMjOeiEsRVTDq3yNYdtQHDZ0xozuKi
         5PyMjqa1OBELHw+MVrlyyRJ412yUH6r66tIRlKxf9Wdxj6MLShW/+ptQmcx0CHyvtaC2
         1dsToSrv9NYkp/4DoJAd6sIYamQ3JqLks+kEQlpUtgUI+gGFhj0xSi6V6SzioOOF0uQW
         f39rVi3wkR6D2zvyOOEizwBiQGRqX/6q/0zlsejo867UuIpfFhOPIRfQ01xxp0YSEfLE
         1QaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ruSFKYuJWvSSI13PQVNBt4J3FMBiI68WZj57AY3dhYU=;
        b=G7gZVGcG2hQCQtImfSmGcagzQUBYuQoBmsjs5QF1/L3RIGfuC5d+aTTvr60vJKjvgb
         RVp6TgOxXQk/g7WOyg/j43HuGzx7eLbyeoWMBD69K63FagXiP3iM+QduBgzXNlzgBdAu
         6R+KCxEolalXPQfyj0sRCM4yV2tY8+FezaCLEOeBRZHmgUllj46UGZtnOqN2jIBd/dxZ
         +nz/mBtvDYy8nKahSIj55Dr3jS/ydcpu/acZQvkKYq3h8LnEwo6BHc47LmEdBa9TK0hB
         M3+rXE2Va8E5xPGs4YTCHLyyMPSTG5isq6cauyIKx6kca0o2akrfQIVzijEPc/am2a1e
         /2hg==
X-Gm-Message-State: AOAM5319M8s9RJLwci5I262wZWaLLDqtvzf3u8uoAsjtwBdZNKkerdKz
        ZXNSRyQvwPt8grp7Z+rXD3ht+3CsYFQX1DOR
X-Google-Smtp-Source: ABdhPJxxHmhWnuLhLux5NvrbqlwDsH2ViI+Mr3VGSNfqcJAdqiCX2OBW6+nNGh14ac8RlnJGq8r9SQ==
X-Received: by 2002:a17:90b:3ec2:: with SMTP id rm2mr3438266pjb.1.1639622536782;
        Wed, 15 Dec 2021 18:42:16 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y191sm3660346pfb.124.2021.12.15.18.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 18:42:16 -0800 (PST)
Message-ID: <61baa788.1c69fb81.3a1e6.b1cb@mx.google.com>
Date:   Wed, 15 Dec 2021 18:42:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.16-rc5-43-g8dff5ac97bf3
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 88 runs,
 1 regressions (v5.16-rc5-43-g8dff5ac97bf3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 88 runs, 1 regressions (v5.16-rc5-43-g8dff5ac97bf3)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
     | regressions
-------------------------+--------+---------------+----------+-------------=
-----+------------
minnowboard-turbot-E3826 | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.16-rc=
5-43-g8dff5ac97bf3/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.16-rc5-43-g8dff5ac97bf3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8dff5ac97bf3147fe5caf4c0f21592607ca08416 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
     | regressions
-------------------------+--------+---------------+----------+-------------=
-----+------------
minnowboard-turbot-E3826 | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/61ba97de5da29f8e14397131

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.16-rc5-43-g8dff5=
ac97bf3/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-minnowboard-t=
urbot-E3826.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.16-rc5-43-g8dff5=
ac97bf3/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-minnowboard-t=
urbot-E3826.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20211210.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/61ba97de5da29f8e14397=
132
        new failure (last pass: thermal-5.16-rc5-48-gf1f42573b6f3) =

 =20

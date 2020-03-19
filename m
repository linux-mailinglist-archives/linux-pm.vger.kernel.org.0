Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D72018B289
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 12:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgCSLtl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 07:49:41 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:44699 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgCSLtl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 07:49:41 -0400
Received: by mail-pf1-f175.google.com with SMTP id b72so1287589pfb.11
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 04:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+UvrYFRx5n0TkolOV3QJ46QCrYcffvXBd9Dc44WyNM8=;
        b=mJFXzxfTEIa3DMMIGQEmgdy0vuGNpoKWVZ3xPQmWFuqaw6u9AUR7jezfSE3buksktW
         eR7Y/ZJi4CtSnqq01P/HBpwRi6n95CZaqZ/5dabZD0ot6bztYs8TbcpGQDP1vulOp7XE
         xRt8t2z3sfxlQB82DnEuVtN9zDipkqjQpNSGpRU6BEyOght+EXFDwPrTUhOD2KwgnoDY
         eyp2KTTpeVZDQPRDxMHMWDJQlpRqit/HBzKFReYfbTYNSqaZkr/v2465QRntiwI3jfin
         t9/b/ILQ362mx7qZe2grjgFC4OEz8hm/I0F09hyk92GLeqH4Q7v4gj0WVrJTjvwaVet2
         OfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+UvrYFRx5n0TkolOV3QJ46QCrYcffvXBd9Dc44WyNM8=;
        b=JZZIK3bIHvNk/JER49EqPvQVjnS5uK0rgF9SCAUwMTDvJQXsMKkx8Kaep1p6sEdJ7j
         SOQvf2aOFcWT+6Sr4omiXgB2jIxy0mGo+2DNEnbLkNcrRIBBEVlq5+hLmdptlA7EzLLw
         r0N2pBUTcjw7heSKwwbQr90QWyeHavtvB3o6Wcbzc0/MxUNuq5T4lsJythpUgGkcfgqb
         oLssGmAs8Y1AS4mM/h2iUmTlLPuWTP93kb6PfZM0Un+luadf4IRSDwboN+hq4Jc377dI
         winhxTFrT6wcCP9EOnfJmRvKOt8zoEjioXbahxPYt4V7Lw6S7lnY7vRoQm407VFl/kpl
         xy/A==
X-Gm-Message-State: ANhLgQ3Mk2WBsqYBqlEzjm5YbVwWmKLPH+dDDT2wL9NmUM54S6pyOMxv
        WnmeyyUs90JrFOUU3ahANxvXqHO1uWA=
X-Google-Smtp-Source: ADFU+vumZkF50ZwJoVT7ukqp2Y/jUQ8++KawDwuqC9hr/NOt2l/or77f2e4vDlOuZd3d4fqnxgcO+A==
X-Received: by 2002:a63:e511:: with SMTP id r17mr2964882pgh.352.1584618579723;
        Thu, 19 Mar 2020 04:49:39 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h95sm1962463pjb.46.2020.03.19.04.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 04:49:38 -0700 (PDT)
Message-ID: <5e735c52.1c69fb81.c81a2.7112@mx.google.com>
Date:   Thu, 19 Mar 2020 04:49:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc6-100-g37da629c357d
X-Kernelci-Report-Type: boot
Subject: pm/testing boot: 61 boots: 1 failed,
 59 passed with 1 untried/unknown (v5.6-rc6-100-g37da629c357d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 61 boots: 1 failed, 59 passed with 1 untried/unknown (v5.6=
-rc6-100-g37da629c357d)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.6-rc6-100-g37da629c357d/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc6-100-g37da629c357d/

Tree: pm
Branch: testing
Git Describe: v5.6-rc6-100-g37da629c357d
Git Commit: 37da629c357d0ce08072f1532fae2091e467ae42
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 55 unique boards, 13 SoC families, 3 builds out of 6

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        gcc-8:
          exynos5250-snow:
              lab-collabora: new failure (last pass: v5.6-rc6-102-gc03d064a=
440c)

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>

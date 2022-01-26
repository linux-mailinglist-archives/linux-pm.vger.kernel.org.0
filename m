Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60C549BFF9
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jan 2022 01:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiAZAKd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jan 2022 19:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbiAZAKd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jan 2022 19:10:33 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31171C06161C
        for <linux-pm@vger.kernel.org>; Tue, 25 Jan 2022 16:10:33 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b15so6354017plg.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Jan 2022 16:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=xLG4I7Y0HzNmnisjUTkIFSd1ZXSy/NMnnFHFCH00rfE=;
        b=4KOvxnI6RzPsN7YbvNT9hlJFb2AhmiE16n0R0Gywh/prMXXNVNogij+1wL37CwhXsi
         wNtgBVkYIaMGw1JZQzrUwKQxOB3B9T/7d3eBS4yx7Nvsh3T3x05Uxi4L1l7E30OpXY44
         WPvw3VHyJ7on59QUIUz8OIogcquYsfAYz1rcIy32qAg1cMJx1A7cV34iflxhHtXPN2B4
         r26uM7lNlBUUs38LUMYtGEVmFC4nuc6fClao7cuZSLXc9sBa4IqAJXiG87Laz1goCJsC
         2qDPPZIJfnnX6usIB4nGDZTsfAUECh8OklYoUFcgmNOWJupQCUh5csLdClKHV8R9fmT7
         2Ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=xLG4I7Y0HzNmnisjUTkIFSd1ZXSy/NMnnFHFCH00rfE=;
        b=q2EWoQjVdnlulfcCKsUBO+x11dC1dllKzk4NHcomA6YIDHf1/QvQZ1eiPuYgXWgMUa
         McRjzu+WCeANqL4n7dFqJHXQZ/yT0WRo7eSpoc1pjyrslKKYZVnEjXHdBY0bmZ12fw1A
         SeH87STvEBCPBLElyOOVA/IYUsi+1VbG4tjGO6c7/SL2wCKfnPKh/BWWsHU550ty9PFQ
         uNwvGcl4O38Jt8XnCkecLw7PGnp8wWuAiDAmsP0wwLTo1S2vFMrp8qhyO7jeal/EpHl1
         TLYlQCgZiq+EyAdzIgTP5qjooeVunhoXA1vZLloacu6lTtIaKDxFPU/9CMztU64ZB/nL
         Jd2Q==
X-Gm-Message-State: AOAM531yVyOlY8L8Fm0QaeHyb3wef+DzE6OboMVeidAwYC5V5aJN1GJq
        qMuCLijAZMhQ8LRe3uQP02CbXw==
X-Google-Smtp-Source: ABdhPJxRl2r7ok8cO2dmjyx8kENfmUMj6SfSBotVGBw8VOssv8bAbpVluik2kFwjv4Bwf1oYBparTA==
X-Received: by 2002:a17:902:8494:b0:149:8a72:98bb with SMTP id c20-20020a170902849400b001498a7298bbmr20133740plo.0.1643155832619;
        Tue, 25 Jan 2022 16:10:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k13sm150220pfc.176.2022.01.25.16.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 16:10:32 -0800 (PST)
Message-ID: <61f09178.1c69fb81.9d5d2.0a6a@mx.google.com>
Date:   Tue, 25 Jan 2022 16:10:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.17-rc1
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 4 builds: 0 failed, 4 passed (v5.17-rc1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 4 builds: 0 failed, 4 passed (v5.17-rc1)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc1/

Tree: pm
Branch: testing
Git Describe: v5.17-rc1
Git Commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 4 unique architectures

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5851E1B4C
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 08:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgEZGbX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 02:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbgEZGbX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 02:31:23 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BF4C061A0E
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2020 23:31:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y18so9664203pfl.9
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2020 23:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gKUKyvOgQlnfDf+bW5bLD0I0FnciI0xVVaCOIbtUIgg=;
        b=Y/1pqs56VgJVyASHAjvle1VJFDfinST0HNeckm7SKW59c5L6SbGV3R6mOOg3o3AM4E
         3SLbmogUYpx5KHcpx9T3hj9r6qljysDbKYWbXBMydrJ4dX5r8BDTX5gwjQGjaD4MkM8K
         vAr32bCE5C6RSmRCoXHSGWCK4fscU7GEqOC/Q0ug7FB09C59YI6hY4ehnDhyMa/VERVe
         klothWnLwpxxecY1WmHb8ig+G2GRqYeWpJhtHhnooPHhFNnI/wF3Da5R+JVauTX+tn6k
         szRsNCfLK5P4T7F4tXOgai+aud8Tr8L3md6FqQ4RLBiVzfJj5Ponksl9hSuzdsIkBgJV
         1xgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gKUKyvOgQlnfDf+bW5bLD0I0FnciI0xVVaCOIbtUIgg=;
        b=rp6Z3GmUWulpYJZGL3IvLIQmrqm/EbtcQcwfLJ2dL65aA8hIMLmHvnOWOaYizhczvu
         epqxfQRaaPEtsC1Ji9w0/Un5ynm4zwjZ4iVSdDHX1npHWu8ZpVyeNzisCPzBTIdMDHKf
         FLOJJnZAKCUPBzHCSWDrOP57LdhwhTcaAV1fhZpKmA0ef3zFIcvbdVJy1yaYS1OnPHRn
         4wed261Rysuxlz8GNCLpA7ADBJ8qgsWR9aBmfP5ZntGPJl3qJtZa8aQLKnRZAESnFJdo
         Ud/JGiFkeAf6FuapLfXfJQCTeij/tEyGHAynJrLGMjumbiIo27i4KwYPitZunv+75mBK
         2Eyw==
X-Gm-Message-State: AOAM5332b0XoUIFYdCQcTrYweDDqaLRXRHsgChXfKV8K3ox+Uk9U4Ns4
        Jt2774a9g033q93tJ+SsCkFvqPP+u9U=
X-Google-Smtp-Source: ABdhPJwMdjBIKy4mj45LUAafVqnXssU1tz0DQWBfBVe4KKDMjuAyhNlm5mjy/ecmF2OEGOn5/sYq1w==
X-Received: by 2002:aa7:8a48:: with SMTP id n8mr20726431pfa.257.1590474681412;
        Mon, 25 May 2020 23:31:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z8sm11725712pgc.80.2020.05.25.23.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 23:31:20 -0700 (PDT)
Message-ID: <5eccb7b8.1c69fb81.4e843.d2bb@mx.google.com>
Date:   Mon, 25 May 2020 23:31:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc7-74-g6b0724667355
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: testing
Subject: pm/testing boot: 56 boots: 1 failed,
 54 passed with 1 conflict (v5.7-rc7-74-g6b0724667355)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

******************************************
* WARNING: Boot tests are now deprecated *
******************************************

As kernelci.org is expanding its functional testing capabilities, the conce=
pt
of boot testing is now deprecated.  Boot results are scheduled to be droppe=
d on
*5th June 2020*.  The full schedule for boot tests deprecation is available=
 on
this GitHub issue: https://github.com/kernelci/kernelci-backend/issues/238

The new equivalent is the *baseline* test suite which also runs sanity chec=
ks
using dmesg and bootrr: https://github.com/kernelci/bootrr

See the *baseline results for this kernel revision* on this page:
https://kernelci.org/test/job/pm/branch/testing/kernel/v5.7-rc7-74-g6b07246=
67355/plan/baseline/

---------------------------------------------------------------------------=
----

pm/testing boot: 56 boots: 1 failed, 54 passed with 1 conflict (v5.7-rc7-74=
-g6b0724667355)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.7-rc7-74-g6b0724667355/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
7-rc7-74-g6b0724667355/

Tree: pm
Branch: testing
Git Describe: v5.7-rc7-74-g6b0724667355
Git Commit: 6b0724667355b76a0813de36e987f6b881131a69
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 48 unique boards, 15 SoC families, 3 builds out of 6

Boot Regressions Detected:

x86_64:

    x86_64_defconfig:
        gcc-8:
          qemu_x86_64:
              lab-baylibre: new failure (last pass: v5.7-rc6-64-gbb7ba30bf9=
60)

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

x86_64:
    x86_64_defconfig:
        qemu_x86_64:
            lab-baylibre: FAIL (gcc-8)
            lab-collabora: PASS (gcc-8)

---
For more info write to <info@kernelci.org>

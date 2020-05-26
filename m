Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D1A1E2367
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 15:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgEZNwT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 09:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgEZNwT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 09:52:19 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F7CC03E96D
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2020 06:52:19 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v63so10197453pfb.10
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2020 06:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=CKE5O2KYei1qGcIAaZy5r9oGg8jUlkng0vug4owpBhs=;
        b=1jyZjxgrMlFU4Z/ZgjixXfHtmyP3tYWWv0cfOwpcV3WDr3BHVNMoOhcy5PMk/dJdA0
         2w842fqC9F1xNFLnacefZR3ytQX89DcTcpPW6hOAPW+p37JBO8av9I5YUFfVb04lw/q4
         C5Uh/TfUQrORdEmok+uf4IYhtJdXO47BOFJ8w6YngqBtaYhJkfKKyx2d2U1F3wo4f1aa
         RjDKQwlrE0ITx6hH1UIz4eaWHkLXyfNK+CYhBXTnQZCLBmJsD8DmsWgBD8t8/y9bpFgo
         TV8thY3zxii5kg7cnD0XX4pJ5MlY2M7rOPSRK+aPo9wA24kpwkPsbcTI1TrAjp0+jLnK
         YGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=CKE5O2KYei1qGcIAaZy5r9oGg8jUlkng0vug4owpBhs=;
        b=Lik+CFtCrTRxJ0yh70aRNyxOUkkiqwpgLOHo/r/PJJwH1kFByvYMmQRIkMN/j358s4
         lpOQYrOQaTscxlAd4NwsCwbXsap48IhkXHxKWR/sHUOYXxkIhQfXkOFML/GfRfdxoG5u
         alRKDBzG4HYO4D5oWpd62bpnt4RQik3yhxb5o1CHSmB0XXMSlCAlaR4qayKXdZ33VTCO
         1s2fvxXmO46KQAdni3vyksTgh5eReRd4/N7Xx7CR0vt+xJIlAIeryWOEw1XjHzEcMYuJ
         Z3nXdWfSyGpp6UHGt6eo0JC4ys1tdtCyqrl/h41GoKKefee639d4bzfh2LPHBfv74HZN
         x15Q==
X-Gm-Message-State: AOAM532JhKnrA8+AcyubkpRiCQ49oFsRMCWUZYzxO5otDGr6B9K23BVC
        mjEoR2JiLB3hygO9atz4GGdC9g==
X-Google-Smtp-Source: ABdhPJxs+rnkj0LstxFVTm60lriKb7unJDoH8zlHW+RXMjIgMDD+P4q/afD9mlQiNKCuZNSNCT3bPw==
X-Received: by 2002:a63:5812:: with SMTP id m18mr1131343pgb.407.1590501139202;
        Tue, 26 May 2020 06:52:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q3sm15435307pfg.22.2020.05.26.06.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 06:52:17 -0700 (PDT)
Message-ID: <5ecd1f11.1c69fb81.e00d.d8bf@mx.google.com>
Date:   Tue, 26 May 2020 06:52:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc7-85-g813946019dfd
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: testing
Subject: pm/testing boot: 57 boots: 1 failed,
 56 passed (v5.7-rc7-85-g813946019dfd)
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
https://kernelci.org/test/job/pm/branch/testing/kernel/v5.7-rc7-85-g8139460=
19dfd/plan/baseline/

---------------------------------------------------------------------------=
----

pm/testing boot: 57 boots: 1 failed, 56 passed (v5.7-rc7-85-g813946019dfd)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.7-rc7-85-g813946019dfd/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
7-rc7-85-g813946019dfd/

Tree: pm
Branch: testing
Git Describe: v5.7-rc7-85-g813946019dfd
Git Commit: 813946019dfd8929048c3350d3d320f34ebcb01c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 49 unique boards, 15 SoC families, 3 builds out of 6

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>

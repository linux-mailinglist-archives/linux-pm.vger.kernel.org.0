Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC711C2ACD
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 11:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgECJBw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 05:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgECJBw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2020 05:01:52 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BEDC061A0C
        for <linux-pm@vger.kernel.org>; Sun,  3 May 2020 02:01:50 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 18so4000634pfv.8
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2020 02:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/2O4cKdjwSJBb8XUzitU+bYTnXU86sfNakC1TRnaR9o=;
        b=HAp49pnHqkiOiNhYnNOo/g9Vm2cVeXy2o/wVmOfLz3b4dawW8QVtThtzxrDFCT98Bv
         oijLMv29RIDU/bIqkczv2I9A5C42MdSet6NCEd9o/pJQJ2cdFtVkZpXagsnHrOWXfwpH
         pVEKcsYU0bVODsZBZawMQpFUGdrgtQ3bGl9ldQD5GvlXV7V6t43mjQRW3iq923aXVy2F
         FxiqK6YDN9LHhGeyrpRerm48BwKDfV9XEzchINli+rTD9NoB2oywP6SRAwmam/WiCfjp
         U2KylNtKUaJ6raz4ryqpcktOI3UyJUNFmYfnL1rsswUUPLTRDiXnZcLwj0V6eRgYYxTP
         GZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/2O4cKdjwSJBb8XUzitU+bYTnXU86sfNakC1TRnaR9o=;
        b=mZvBDFVYshvIV+yCPB3zYBODr41xHrA6Vc56RXmKGvsreQuquoiMHC4YqMueUDcjnV
         z0KT03HhdwU50DhRoSTXudO0pcdx6Nwm38kHMyS2GK6Ce/ALk/qt3MKjEjTK4BTH2wg8
         uWIMzLDyOA+alFgXW09hx6oz6tLtOO5tr0dMSXs7mRLi6xTiKASw98QAO1TBD0cIIdnr
         0UZwIeWY0wrW3Kdp49jWHd9LbDzRScZaczkarcB1YjbH6ra3onKhZwhV2gTJztWXmZrz
         Cfa0kk3hPsYlONN09GlR2B8vLWq8/+2A6s5TXhGjQWSNgB0lAt89Nt//Cb6ZIeefEjNQ
         T8sw==
X-Gm-Message-State: AGi0PuYdQe4bqgVnbXOpri97h5cXbdti73lubBsxkGe9ksRd1WfbYw52
        LB5kg9pcbUbgN6q8dyII+CZSkg==
X-Google-Smtp-Source: APiQypIjD5eiU6bAU6lCGN3PujY35iUUSLtge4+VhUlyWaZB4CC85gRi8i11qAq6SYBiXOMdGtwBug==
X-Received: by 2002:a63:614:: with SMTP id 20mr6463923pgg.198.1588496510367;
        Sun, 03 May 2020 02:01:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b16sm6115719pft.191.2020.05.03.02.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 02:01:49 -0700 (PDT)
Message-ID: <5eae887d.1c69fb81.f5745.8ce0@mx.google.com>
Date:   Sun, 03 May 2020 02:01:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc3-24-g1985b45de014
X-Kernelci-Report-Type: boot
Subject: pm/testing boot: 52 boots: 1 failed,
 50 passed with 1 conflict (v5.7-rc3-24-g1985b45de014)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 52 boots: 1 failed, 50 passed with 1 conflict (v5.7-rc3-24=
-g1985b45de014)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.7-rc3-24-g1985b45de014/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
7-rc3-24-g1985b45de014/

Tree: pm
Branch: testing
Git Describe: v5.7-rc3-24-g1985b45de014
Git Commit: 1985b45de01473658db9194e948eb151f9e076ae
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 46 unique boards, 13 SoC families, 3 builds out of 6

Boot Regressions Detected:

x86_64:

    x86_64_defconfig:
        gcc-8:
          qemu_x86_64:
              lab-collabora: new failure (last pass: v5.7-rc3-21-gd38f9bc92=
61a)

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
            lab-baylibre: PASS (gcc-8)
            lab-collabora: FAIL (gcc-8)

---
For more info write to <info@kernelci.org>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2E81BA1EB
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 13:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgD0LHF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 07:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726485AbgD0LHE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 07:07:04 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5261EC0610D5
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 04:07:04 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t16so6869699plo.7
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 04:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=nKQt7v7w4nS3rXoLM16YoPujt6MNkA5qMmK0B9veF/o=;
        b=NiDLsLSfYBF75S4sOIhxCiWkNcizgGDC2o7zZe7SGvA6du+5HkyPa/Ez8quz4VobdX
         Ssjhngjx9SQ+WQS7kqvaVf7oo/3q/Sc/VNoa+dTYwhriBWogwzvROeeOSd04f03RvER/
         MJKCjDra1SgzYqWpzVcMZsfuYqw5Gr5QPsqqbRVV+dynzq4UmDfFtofS19Xo6YEhtIlN
         r/zY+q5kBiaA8SGfRIQjP0dxJDy1SnzCsZLOalE/dBqLJFzRsvAsYShWxJYP/IhaMgLv
         HlhckoVTiXyEZ76WGS200kwyYYj0PF/03KHb40XzXAN5nWAwFzP0io4jSVBPIWPk781j
         AiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=nKQt7v7w4nS3rXoLM16YoPujt6MNkA5qMmK0B9veF/o=;
        b=oLPALFax1dtKf8D5WXDK+/KCUG+51vFprqjyaYidDQRpdKi7LesUHESjH2furWWfua
         wK2oTcO5M1mC29+8YFxZD97NtMj1D/knyHff/dt9kmFOCylxU7mt40tIFkrybOPwMY08
         q/NFgHcA4VnWYdw5jLLkzOH8WSoqRVOKJUcWfK0MARx9Z3Fw+o25f0wmwR6GGlEky+Js
         fhivEXEJHRYU4WeNZo17VLZ+j82fO44+DaM0l4jXdp4fsBTIucJGNH3H+o0KSzOmG4fV
         moeHvcKMtB3EGN7m6BPRNzySEJpGNahV2+3uczxDISVzU8+iaOAhxHw3JGSL7U6T56z5
         jZqQ==
X-Gm-Message-State: AGi0PuYvGB3mNZImtXQxzDuKu5bHz5xdTJ7/vDuEfCg/NerQki9ZlZar
        cNHdJFQjtNAN4g7lehzHg6yx9g==
X-Google-Smtp-Source: APiQypL2xX2OvzSref2mlr2Tpur7b7xPtPzD5XT2w8zJeD/8v5a39JnQ0fbpU/4UCU1fJ7v37pR9DA==
X-Received: by 2002:a17:90a:8c85:: with SMTP id b5mr5956274pjo.187.1587985623719;
        Mon, 27 Apr 2020 04:07:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 198sm12570715pfa.87.2020.04.27.04.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 04:07:02 -0700 (PDT)
Message-ID: <5ea6bcd6.1c69fb81.8bcc5.22ab@mx.google.com>
Date:   Mon, 27 Apr 2020 04:07:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc3-21-gd38f9bc9261a
X-Kernelci-Report-Type: boot
Subject: pm/testing boot: 68 boots: 2 failed,
 65 passed with 1 conflict (v5.7-rc3-21-gd38f9bc9261a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 68 boots: 2 failed, 65 passed with 1 conflict (v5.7-rc3-21=
-gd38f9bc9261a)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.7-rc3-21-gd38f9bc9261a/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
7-rc3-21-gd38f9bc9261a/

Tree: pm
Branch: testing
Git Describe: v5.7-rc3-21-gd38f9bc9261a
Git Commit: d38f9bc9261a2b20e8509370b5df9bdb3badaf81
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 59 unique boards, 15 SoC families, 3 builds out of 6

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        gcc-8:
          omap3-beagle-xm:
              lab-baylibre: new failure (last pass: acpi-5.7-rc3-250-g177af=
5b82ac5)

x86_64:

    x86_64_defconfig:
        gcc-8:
          qemu_x86_64:
              lab-collabora: new failure (last pass: acpi-5.7-rc3-250-g177a=
f5b82ac5)

Boot Failures Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab
            omap3-beagle-xm: 1 failed lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

x86_64:
    x86_64_defconfig:
        qemu_x86_64:
            lab-baylibre: PASS (gcc-8)
            lab-collabora: FAIL (gcc-8)

---
For more info write to <info@kernelci.org>

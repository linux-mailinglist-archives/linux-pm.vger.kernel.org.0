Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB771E6926
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 20:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405732AbgE1SOX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 14:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405736AbgE1SOW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 14:14:22 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750B4C08C5C6
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 11:14:22 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n15so13997519pfd.0
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=xOf7K2RhgDVuK3GvY4sLkahIaJtruJgT5I9q1rpee1Y=;
        b=fQfvq3LCbNCgQHYroGuzXpcw6J1WvCfaqYdTvV6+49IAl7ZAD/7ylgc4mNZfZLClMp
         zU2jc8gqpjndWuytD3neKaVkz2fFnKT8z/Gj5Zi0Xefi2EAi/jqj6Y4SX39cwU70qswb
         MvR8wVNx3Z0vLsXXZ9aOMbbmXA9x26eSjkSb0RKd1g7MxPQvvdYNOMNguUzgG2TWFUv4
         naKAR20eflPNyuUFRKhocVJNq1KA0vhLCKUhtXe0ZVfzCfXdDAJX87hX+xuv6VZ5uFaP
         fifj8hnt97i6O0H0WyXgA4eDdYrbCoLqsHg/fs9Uul+NYOiY7y5KtLIi6X2O3PPVEdvw
         jNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=xOf7K2RhgDVuK3GvY4sLkahIaJtruJgT5I9q1rpee1Y=;
        b=V3skcR6yxh3A6eMhJoqCf0Tng7ZZzXlGZ8GygxwJXUymkmNgN3O3u5HEM8RPL9AybL
         97iXwoe9oxz2HHV70XPIfA/8lWK1sI/qNs2Y5HrHnlg8K/fNgfI0onhYNaQrAXxdwj58
         FL8cjcadRAQ20jCRdYnZf9d9EULxjmONDVw9xyPTjN/wuPFpwxfTKbkBjv7ZZdw5qGmd
         drHoSOzDNp1nCX06ZW+ywwK6VZ51aPJrBqVQfjFl5OXzVDSvW8RQMiAU/i/a2WG8gjtA
         iPeSd3PneGNZrMqUQcCbguklznYGQBkII1H/6IRp1+cqhnjCRkOxaEe1wd5OYa4dWvtf
         RdGA==
X-Gm-Message-State: AOAM533EAHqUB2gdvcbxb88FNQUIWiYsgfvQex14pZ87HzKBWgBbJ4Xt
        tsqTgg9S+cIXUmIkmzpk1vlja1k5nxk=
X-Google-Smtp-Source: ABdhPJy0cRxepO2D7CDsUAehnVXb/bEG3u/rUDUwn9ysOIvyJ5qhZ9v+alxY5Po6yKqICj3AshguXQ==
X-Received: by 2002:a63:1415:: with SMTP id u21mr4088795pgl.366.1590689661888;
        Thu, 28 May 2020 11:14:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o16sm5038881pgg.57.2020.05.28.11.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 11:14:20 -0700 (PDT)
Message-ID: <5ecfff7c.1c69fb81.f9e95.feab@mx.google.com>
Date:   Thu, 28 May 2020 11:14:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v5.7-rc7-92-g065693d08662
Subject: pm/testing boot: 53 boots: 1 failed,
 52 passed (v5.7-rc7-92-g065693d08662)
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
https://kernelci.org/test/job/pm/branch/testing/kernel/v5.7-rc7-92-g065693d=
08662/plan/baseline/

---------------------------------------------------------------------------=
----

pm/testing boot: 53 boots: 1 failed, 52 passed (v5.7-rc7-92-g065693d08662)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.7-rc7-92-g065693d08662/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
7-rc7-92-g065693d08662/

Tree: pm
Branch: testing
Git Describe: v5.7-rc7-92-g065693d08662
Git Commit: 065693d08662db2ceebb2aa051ffae22d364cd25
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 46 unique boards, 15 SoC families, 3 builds out of 5

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>

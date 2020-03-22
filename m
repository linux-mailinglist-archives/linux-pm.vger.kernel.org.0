Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27FAE18E84B
	for <lists+linux-pm@lfdr.de>; Sun, 22 Mar 2020 12:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCVLN3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Mar 2020 07:13:29 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:46524 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgCVLN3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Mar 2020 07:13:29 -0400
Received: by mail-pl1-f178.google.com with SMTP id r3so4590709pls.13
        for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2020 04:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Q03DypSkbz3mOGP3pYQMF+v2WNkvYhIV1ceGinvvy2E=;
        b=sghPLM8i9/FvGbHSEJq3jGCNkB1oeWOj4BAU3yQ39lFWt2JvaS5VBmQvnj3rxt/orw
         wAXT7gx2+HzrS78tBHg5Ql/snsO112HpcEjsh1nbPwzd8B8aheHqoMwcJp+LiB+OEvuR
         21caabRhLhZwx6uqSKOAKOII7wipap3OXhyHQB7Q3ebuPQ8dlh9BtFAINL0BAPHqP38N
         A+E4D5Prw8Sft28kIn5m6n5pKSidJq2gGNvQOvd2EMD0QLMeKk0yEHTPqwpDWtAsuQ1q
         QHJaR5xGz1DASpJG8wjKQma7lQsXuW+WbMZxqTiX0hVGGdHsfvYDppelMCWCK1eKzlMt
         Y2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Q03DypSkbz3mOGP3pYQMF+v2WNkvYhIV1ceGinvvy2E=;
        b=lAs31X/tqDrKjMSEjs7pRmVYaxndEUAfTjeTPZ3BycPJVOhaiiYVNfEdD/J+6SCnH2
         NXGOaNqO7TvQGomB3lmN7I1ITinIIVgojutNd0AmCjpGw6lxMwcKYWcmSHzTgAADMslP
         o4C+TKHspn88v5PytURyyfQ39sMkRQ8N+83BREwdCjWKJCFEzNSLIK323uzDSGKobT2q
         V0VtiVPt0oM2LehzuRqON96AB5NGU3U295AjE5NqwAa8+73/W/yh/Q7yhdp4bHVH6dKy
         G3lLrYXwck0UGZp69bgH01T4TrZg5RMFdoOxJ6BxouzwC8mCkvPNimwNhNxr8CrKXUhL
         j4bQ==
X-Gm-Message-State: ANhLgQ0eXoMX84xhtknON84UJilEAtNp7KEsinMl3zIXSh3uvQoLwf3B
        a6Tc2EbJjpaRxUdg6qw7gRGJ5xVem3A=
X-Google-Smtp-Source: ADFU+vs0DGZP4c3OQYIeN3U0xoJP+5k554exxAX7rjGGkTVKA5jd8ycshThHKDIDm+/LuBKg8Osvqw==
X-Received: by 2002:a17:90b:368e:: with SMTP id mj14mr8030147pjb.107.1584875607860;
        Sun, 22 Mar 2020 04:13:27 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i197sm10738617pfe.137.2020.03.22.04.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 04:13:27 -0700 (PDT)
Message-ID: <5e774857.1c69fb81.ff4fb.6f25@mx.google.com>
Date:   Sun, 22 Mar 2020 04:13:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc6-104-g5e3ada361a7a
X-Kernelci-Report-Type: boot
Subject: pm/testing boot: 64 boots: 2 failed,
 61 passed with 1 conflict (v5.6-rc6-104-g5e3ada361a7a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 64 boots: 2 failed, 61 passed with 1 conflict (v5.6-rc6-10=
4-g5e3ada361a7a)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.6-rc6-104-g5e3ada361a7a/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc6-104-g5e3ada361a7a/

Tree: pm
Branch: testing
Git Describe: v5.6-rc6-104-g5e3ada361a7a
Git Commit: 5e3ada361a7aef36e173fc7004a8e9f0066f9010
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 56 unique boards, 15 SoC families, 3 builds out of 6

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-8:
          meson-gxl-s905x-khadas-vim:
              lab-baylibre: new failure (last pass: v5.6-rc6-100-g37da629c3=
57d)

x86_64:

    x86_64_defconfig:
        gcc-8:
          qemu_x86_64:
              lab-baylibre: new failure (last pass: v5.6-rc6-100-g37da629c3=
57d)

Boot Failures Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

arm64:
    defconfig:
        gcc-8:
            meson-gxl-s905x-khadas-vim: 1 failed lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

x86_64:
    x86_64_defconfig:
        qemu_x86_64:
            lab-collabora: PASS (gcc-8)
            lab-baylibre: FAIL (gcc-8)

---
For more info write to <info@kernelci.org>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9E5F1562C3
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2020 04:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgBHDIi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Feb 2020 22:08:38 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:45249 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgBHDIi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Feb 2020 22:08:38 -0500
Received: by mail-wr1-f47.google.com with SMTP id g3so43784wrs.12
        for <linux-pm@vger.kernel.org>; Fri, 07 Feb 2020 19:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ZB+3hoW7o15d/8a0sxkMuF2sGwZG0Y/B9EfYar7qmDk=;
        b=10muHL7f+2/uzuB0TzTzDKnuZcy8CXwaWdA/vjuZ6fajTfJR4qShycXX8+APOi+Ddc
         FuVdAnfFyF5HltuGEII215RwQ8bmyFeP0eqKDfVqlltjqDM2rJLlhnAQ2QxotrvoVq9j
         1M8Y6Y0saodqgm4STYDoM/lC2pFRKFb6VGMTtgHDQXc6QfovJ6cp7Q1UHsIM/Khtohkn
         0hMWP0yejSmjEEH6YKkCWfrdc06FDTm2WbznPqY8QEfvSTj64TpQpkxb3LMUp5vhJxkp
         aCJBH2rswSCjRDriCb6xRBrH/yeDzViczmWKP3wOHgZPa+f13+cHMzn8c593W9yJL5mf
         GZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ZB+3hoW7o15d/8a0sxkMuF2sGwZG0Y/B9EfYar7qmDk=;
        b=Q2W4tN+MP1q+HBtnDHcfxI5OTs7ok2Y1ylBzDIxx1vQcxRk9NwMwRgzP93eqNGrMEl
         vXqi98uWVA/hMXwJkI3orP+wCIUXVDXke4FXv2TPGY5XXbIofGGIrmNCulCgLGVjHSB4
         j7yFC/XalIh4RIBdfh0mBa14RL+Kp4ITfq9aK8Tf6+tWjC09rQO4vSJT5xYpXmNcCJbv
         e5CzTFDdkoOELU76pnpUNte2px7odPBVbizoJgkt1nf/bxH38s9GodKGkUi/nHbbaprw
         aZq8/SEDd1lRHN0ZnMgc9kqkNrrT+jSWf5YrOnGwRYaBW99tvHdh73kgVBem+yUZzTR2
         XjYg==
X-Gm-Message-State: APjAAAVfaVtOtsDkRWFtoFgJV9myqpUXZ1UH4OKX+N8vGyCcJ5pR9nFu
        jopOEo+d5cCz7U9osRUxayUd6ZquJV4=
X-Google-Smtp-Source: APXvYqzVJPj9xtvJ5iOQGSHQPGUXG6uCY3ZNZ8MAz/wl0XTuGcnJmoBuXwHI4a+TetUVh7j2iMW4CA==
X-Received: by 2002:adf:e9c5:: with SMTP id l5mr2475546wrn.322.1581131315349;
        Fri, 07 Feb 2020 19:08:35 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id z4sm5797212wrt.47.2020.02.07.19.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 19:08:34 -0800 (PST)
Message-ID: <5e3e2632.1c69fb81.96788.950c@mx.google.com>
Date:   Fri, 07 Feb 2020 19:08:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.5-rc7-146-g4529d29bc6a6
Subject: pm/testing boot: 33 boots: 0 failed,
 33 passed (v5.5-rc7-146-g4529d29bc6a6)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 33 boots: 0 failed, 33 passed (v5.5-rc7-146-g4529d29bc6a6)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.5-rc7-146-g4529d29bc6a6/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
5-rc7-146-g4529d29bc6a6/

Tree: pm
Branch: testing
Git Describe: v5.5-rc7-146-g4529d29bc6a6
Git Commit: 4529d29bc6a6f458ae731425ce4f7e3856365bbe
Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 29 unique boards, 10 SoC families, 2 builds out of 5

---
For more info write to <info@kernelci.org>

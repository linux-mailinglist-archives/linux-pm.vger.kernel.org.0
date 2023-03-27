Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708736CA5BE
	for <lists+linux-pm@lfdr.de>; Mon, 27 Mar 2023 15:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjC0NZs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Mar 2023 09:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjC0NZc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2023 09:25:32 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DF16E81
        for <linux-pm@vger.kernel.org>; Mon, 27 Mar 2023 06:24:16 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q206so5116919pgq.9
        for <linux-pm@vger.kernel.org>; Mon, 27 Mar 2023 06:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679923449;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AH/wqhds6qkZ8Sk78QShgf+0Ijf07Y1m3SH9luWJg9Y=;
        b=E2406gZOVwojaNxA08GiZShwctcvmFReJCJ1fgqdLWsSdSZ3NPw9wm5m5phl5YoA/d
         XTUxXG8odHn7en6qbeD1UT8WnA30JavZkJxac1P28MABikfpN+r9ozqBxyLgMZ+whsGc
         wmNZ+o3tl9+XBZ+NY7NIo4VwalQZB2fH2xiaumXwif4lxAg6EINT58Zz5vhF6bRJC+Ww
         L0MwV5sZ2MV0JSryKIWfWbipCqs+9ZtZf1v9uiSQX73H++yQ/xezw2x2eIISy8x/jmiQ
         jArPjLeOmicMFB/sGpTiDtcGFwn5uJXKxMADf+PSdCeDSUtYQgmgplgf4rxYtFkyfo07
         lDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679923449;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AH/wqhds6qkZ8Sk78QShgf+0Ijf07Y1m3SH9luWJg9Y=;
        b=rZhL+n0ebqi+VNucPX7+TUKsklfVh6XU9pj1g/egLHr3OHook7+otrCuWcdhCiuCDR
         YoyhJ/4Q5V+axnrw8KjKkj+UpnmUYWQCVmGamZkYBSohxTZNCfxCRTcneQxlXaaaCQ7v
         r8+vF3FZs0BRbkIbeLYckxhw2GmuGrtoOQo4nkuL3inFCvfHKMNlCFFTbPYolCbSrRz3
         OvWe8b6WnvvRzJySMwwvPE6xzfe5UmClNBqJmI7VZcUeZrNHZx6FeDQWFBoz3YvPSZxX
         BtuMpKlLryQG3Kw7RvsoqirivxHCGPtA99V7RXqq6fux6uMsXbHF/XK6+4GJT/t8R3+o
         oW9A==
X-Gm-Message-State: AAQBX9fDrq9D8/ecdsbN5/qG6Egk825bL2Xjjnk65TtoJYvqe8S9xadj
        9cZdOsZuafV0QS9iiAC+kVGIXw==
X-Google-Smtp-Source: AKy350ZU/EIp/jCCKl8FO3nMJ8t/ceaGnLvJafwRi3J7qy84PBe5XHbzzoC2WmMjHqdq+BnCVYJ33Q==
X-Received: by 2002:a62:8401:0:b0:628:1852:8431 with SMTP id k1-20020a628401000000b0062818528431mr13076741pfd.30.1679923449202;
        Mon, 27 Mar 2023 06:24:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n6-20020aa79046000000b005ae02dc5b94sm18853244pfo.219.2023.03.27.06.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:24:08 -0700 (PDT)
Message-ID: <642198f8.a70a0220.109f2.086f@mx.google.com>
Date:   Mon, 27 Mar 2023 06:24:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.3-rc4-43-gfb794799824a
Subject: pm/testing build: 6 builds: 0 failed, 6 passed,
 4 warnings (v6.3-rc4-43-gfb794799824a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed, 4 warnings (v6.3-rc4-43-gfb=
794799824a)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc4-43-gfb794799824a/

Tree: pm
Branch: testing
Git Describe: v6.3-rc4-43-gfb794799824a
Git Commit: fb794799824a5b8c31e1150e1c9c95df6eb6a11f
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

Warnings Detected:

arc:

arm:

i386:

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
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
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>

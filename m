Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C19E7B9838
	for <lists+linux-pm@lfdr.de>; Thu,  5 Oct 2023 00:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbjJDWiy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Oct 2023 18:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240426AbjJDWib (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2023 18:38:31 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171CE10FD
        for <linux-pm@vger.kernel.org>; Wed,  4 Oct 2023 15:38:01 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bdf4752c3cso2073925ad.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Oct 2023 15:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696459080; x=1697063880; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HouwFsyeVUsHPtYpT5U/Mke7fDuJ9LJLoYmMRl6LNm4=;
        b=n8bNZi0WCLUmIFIcR1MUUnnKRZlbRwXleXMeK92OZUb9YgWHYhKPfBKG/rBUYtBc5k
         VXMmH8aNCiLBg6nVi6SGDjw2UhPfFrF809pi5hKX+STNjDWNlxr/ohDjPBIHrN3Qizsn
         WwoYxXsH1R7pM6Fd5w0brpWm5+6DlAYiBHdIWbHWX7IagWxG6hRieczGTfdHZNDRoX9Y
         WpVKw2RSH9046Mf3iVjWPNsWvOCjeepTYf96f4Dtzt6gUu9hFF8/yKhOICGEeAvXMg2X
         9rYJxRrLAqBoEA9/EIaFYSXo8VSg5S43GS35VrNbeCTrAhi/xekzN93v9217i/aLwmqE
         DO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696459080; x=1697063880;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HouwFsyeVUsHPtYpT5U/Mke7fDuJ9LJLoYmMRl6LNm4=;
        b=kKiicMplv/b8QPSGdsrZl3OBp0RA/QF4/aTRW2aqAyjk7GjdU90vJAoHi4p0cj+7bO
         ksu4e3oVKer37EFeRREkUwyVcx5xQInV7oWjpXaoCnwPV4o9/YSKN/ppjl4ZC0y6HrxM
         ZxwR53PDm/x/snvwA8llb3ZwET38qsOu79IJk7BbGj3yju+UlQqlfEex8Sr+ou0ZjXp8
         0iuXSh9qWkLmqO/RPLeMYiJ8L/mXZG1aCcv0lpCwfjB6g1lcxIJwia0fpNQSRrT99NB3
         7kRJkzwmt0OQTc6o+VVoFYMm2hz5KZCgR0abz0xg+5oQfjUJvDMNCBcHMhgDh7J0/GJk
         2BLQ==
X-Gm-Message-State: AOJu0YxB+zJC5FCWONlhks3Cc/u9+RyDPtvVqp2WHAPjubFVD8UV0HcD
        L0Yhly4PTYUsxNZDqBxERKaJvg==
X-Google-Smtp-Source: AGHT+IGszKjWUIDQWPoj7FD2e5IMMkliiHg+YKop4QRZbx8ljaqGOXyP9q9cnao4qvn4nw131mGCvQ==
X-Received: by 2002:a17:902:700c:b0:1c0:e12e:8e39 with SMTP id y12-20020a170902700c00b001c0e12e8e39mr3454087plk.35.1696459080304;
        Wed, 04 Oct 2023 15:38:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902db1100b001c0a4146961sm81609plx.19.2023.10.04.15.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 15:37:59 -0700 (PDT)
Message-ID: <651de947.170a0220.36d1c.04ce@mx.google.com>
Date:   Wed, 04 Oct 2023 15:37:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.6-rc4-110-g087dbcb21272
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.6-rc4-110-g087dbcb21272)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.6-rc4-110-g0=
87dbcb21272)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
6-rc4-110-g087dbcb21272/

Tree: pm
Branch: testing
Git Describe: v6.6-rc4-110-g087dbcb21272
Git Commit: 087dbcb2127272bfc2419ec2dc1e19e6a030f3af
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:

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
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

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

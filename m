Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51BD725150
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jun 2023 03:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjFGBB5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jun 2023 21:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbjFGBB4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jun 2023 21:01:56 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327B5E5E
        for <linux-pm@vger.kernel.org>; Tue,  6 Jun 2023 18:01:53 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-65299178ac5so6506766b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Jun 2023 18:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686099712; x=1688691712;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8ulPueLYHRFynyfMJ7wdi79NARwrp3p5iXjTFBS3ikI=;
        b=HyDDwsAH8X8WANIF/3y4JA7B1c4QwFu5wR/Vs6UiXlrxYGSvju+jtg8dXJWdZg3Xl5
         tVt/nit2W9XNgbY8vKM0rxMVe1xX3aOLDF1c65kfcvXlQhW5Fpvi5VqbLd2RtlmRb5i8
         FiA9EGKCgjAHna8djO6bg01LXM031rynDGhy1aTmOViI+R3SN2STxJ8NSWlR1hEKCHNQ
         1duq9xPJXsWZjWoJluIL7SI5PFAd3VllnSwZhCx3Bc/rZ7+K5XUvA68QHV2zVmI8YGxz
         +TR5xc/2y5vbrPcobuDdpJFXTQ1B+yerpkfe1saopA1kMV7SCOx1diyKwqqfpoUJlX8+
         AGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686099712; x=1688691712;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ulPueLYHRFynyfMJ7wdi79NARwrp3p5iXjTFBS3ikI=;
        b=CwuA2/haLtTHRrMh+YMxgqGk1I4xwt53Mwwwkp2CT/vvnWFe43uULyGkXHy0DgIB65
         2j2fj2B2u5wmIgEnXu9tFT4FfD2uDjf2ARvEOqN3YeicMdd4YR3p2z0RTWTZKz8K14AT
         TeRVjLhWWOE+me3249UIw9KnxYTYOUzME7gnuJGDHlGkuIp8zpUbyb5s97KUi8u0gqDc
         kHZ+ahOhUC8GhQKKQTDwvbJm3xEOnf881W2HvDlg03FBdDE89zDQQCbDeGw9tuOAwcGF
         h5TVRnbCTIPIoCaAmo0xKzTiHXaKjtOgbOuYIq0EHBWPUckm9FUx+daT/2HqODvwYEUj
         PX6w==
X-Gm-Message-State: AC+VfDx0j0HgG92PMGE+HqhnzYmF8UmAhV3w1HncJYXup2SN6WpneJzH
        rlazDxNQFY5kGTJS3ixvl6ebrw==
X-Google-Smtp-Source: ACHHUZ6Lk0JJsTRtawt5I4ms39KDh6dvnlwSRhX2jwgv65kjxN/7+8FjqNcKXlQgTW6BIG/r4tW2Hw==
X-Received: by 2002:a05:6a21:6710:b0:104:a096:6ac7 with SMTP id wh16-20020a056a21671000b00104a0966ac7mr1301760pzb.34.1686099712600;
        Tue, 06 Jun 2023 18:01:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x19-20020a056a00271300b0064378c52398sm7331600pfv.25.2023.06.06.18.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 18:01:51 -0700 (PDT)
Message-ID: <647fd6ff.050a0220.13805.e07f@mx.google.com>
Date:   Tue, 06 Jun 2023 18:01:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.4-rc5-35-ge8195eaff86f
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 7 warnings (v6.4-rc5-35-ge8195eaff86f)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 7 warnings (v6.4-rc5-35-ge8=
195eaff86f)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
4-rc5-35-ge8195eaff86f/

Tree: pm
Branch: testing
Git Describe: v6.4-rc5-35-ge8195eaff86f
Git Commit: e8195eaff86fd2ddb5f00646b5f76e40cd1164a8
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
    x86_64_defconfig (gcc-10): 3 warnings


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
    1    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: .altinstr_replacement+0x17a8: redunda=
nt UACCESS disable

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches

Warnings:
    vmlinux.o: warning: objtool: .altinstr_replacement+0x17a8: redundant UA=
CCESS disable
    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled
    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled

---
For more info write to <info@kernelci.org>

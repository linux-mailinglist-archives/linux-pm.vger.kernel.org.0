Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FBB7838D6
	for <lists+linux-pm@lfdr.de>; Tue, 22 Aug 2023 06:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjHVEeF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Aug 2023 00:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjHVEeE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2023 00:34:04 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F75184
        for <linux-pm@vger.kernel.org>; Mon, 21 Aug 2023 21:34:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68a41031768so1098792b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Aug 2023 21:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692678842; x=1693283642;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GurahkdBXJump+yUwDFBhdwe87qzd0hQjyHpUS/+z2U=;
        b=ZCgVWd7gelBe2mZkfsLlystHt9QhpbdnzmlFcEGSST8QohlqFH3h9mtYQE6oqpjfyk
         1MnsPogze65XqAvnxuWieJsNMjhhy5RoxDxt00xsVK/ewP+PPD/3Y3Gih59X0OiBuI3O
         Ql3MMAvauKhLj5xUUiggncMa5T5MoRe8qMcxy4TMnyKolM/d+kMB2IkkTmgCW2w130EI
         2WaJb4Uq3ESPUWsPfnbjhx6GLW2bcPdnEz4TIjHUYyBU6kURMqFm0FBHfP9WLGuWt3H+
         CnOW/udC6CyUXqk1gYKqKxUx0Z0DaN4FzQ0iziOq5OU5oMXPfDS82ETsk94Ypmr/UWbT
         9NTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692678842; x=1693283642;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GurahkdBXJump+yUwDFBhdwe87qzd0hQjyHpUS/+z2U=;
        b=DGed6/+Zfj2vN59enpwtU/fYyi+3jPcCR2DoT3H+mIu+Tab+/qfuUiBh76+Li9QLE6
         YOXqbS5GUVzha1JUJrVYQ/x4aOwnJ8Tz6BRj87SrK6cUtV+oaKu6Q0THmMpCbrAQ1ehA
         L8/Aof1STsoJXmCDRBOfoMZBhnqt1muBfL7FkFECcVwmUin9i39LDAqqKI9H4gJ3lLDp
         9n19ZHMDB6eg9xzy3IfL2kUlqcQCL7AEPJ6ACmkfJqd/YWJb8YFGS44+epvXDdlufHkq
         Ow8r2ifziGcabsxCDUF4e12BvKPssSGJEFTvXYL4XbDRfY8Qt0YAh0oXKf5EJTYmVDfn
         Lt3Q==
X-Gm-Message-State: AOJu0YycfO0CdxhxZjlPCtVsYiCPoStTKEBiqbBYhSS84jX1cStBJHVa
        k3c9n3xH1aodlyw8bCkgqVsW4Q==
X-Google-Smtp-Source: AGHT+IFgmLu7VHwxyFc+zpJCIrcWQqg6Z+wkNlJHfhzO26Ybl0G6UdMBC/MrpMb/t1INQNpMKG/N8A==
X-Received: by 2002:a05:6a20:6a05:b0:130:7803:5843 with SMTP id p5-20020a056a206a0500b0013078035843mr8096843pzk.4.1692678841845;
        Mon, 21 Aug 2023 21:34:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ja15-20020a170902efcf00b001bb9bc8d232sm7904741plb.61.2023.08.21.21.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 21:34:01 -0700 (PDT)
Message-ID: <64e43ab9.170a0220.bfeef.f298@mx.google.com>
Date:   Mon, 21 Aug 2023 21:34:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.5-rc7-96-gabb51b0e3f333
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.5-rc7-96-gabb51b0e3f333)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.5-rc7-96-gab=
b51b0e3f333)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
5-rc7-96-gabb51b0e3f333/

Tree: pm
Branch: testing
Git Describe: v6.5-rc7-96-gabb51b0e3f333
Git Commit: abb51b0e3f3336875a4b59f74a118134ce8c45fa
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

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9BA7BF179
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 05:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442026AbjJJD3z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Oct 2023 23:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442070AbjJJD3v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Oct 2023 23:29:51 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB30AC
        for <linux-pm@vger.kernel.org>; Mon,  9 Oct 2023 20:29:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690bccb0d8aso3985177b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Oct 2023 20:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696908588; x=1697513388; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5bQvVKnGXTfaXu7n5oK1iqWc1ZlH5ExtVzEqI1qv0Kg=;
        b=kCWKybx0gni9yfek3LgttKeksSvNM/+9WE2hHVyXDhp+KZ+hgAn6ORbvia/uow6rG8
         YJkei8yQpszYcqAH37x3L0wZGwc2KbH7PT0jkLgSI024qz08aICd0x15NuXrcofvyIzN
         MddzLhIQonUz7XATojk7susP2zLyld0A3PXNQIL8+wS/+9GjgZCZSeXLQxZsYSIQPasD
         3F1IkQBVFSK5KCE8FogkuqK6PLwxFDQPhibXNcO3udWpSAW0rD8WWHDemJrL6c35ulIZ
         Fjt3fdtjYawiJx26YxnXnyzUuhU2N5sxcUnqpfuJJQbapcpSefI9m7c+Z5zucRj3Bkcp
         pKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696908588; x=1697513388;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bQvVKnGXTfaXu7n5oK1iqWc1ZlH5ExtVzEqI1qv0Kg=;
        b=U5lk+qw3sxk2rYVxexrARKYke83Pe5aulnrOE2L3HWu0LCNjaGkA4fi11F+QXLReTm
         upXGE/l0jg9V6eM3nMX+bzYWm+r4fWq9tdHP3W0Ht2y00BBB+6BQ7+GbgxSkumARUx/K
         NqYT+wFa1ZT2vctzxZ2JZPBfy0rARvW6hC2YEcm2TLhTJNZyw/MY5i5hjasXEOctT2Ck
         FmJsosrbWTsZRvnnHW3WZ2YWaXvX+abWeuA3B24XNQ0+J9n17GU9E9nl8C6RV4or730L
         8W3yhYrAJrnAhSj3hUC4OwCJ2gA8Ijni1/f0468NJ6PRYckGZc3ylMWAKEeMlqxH5+BI
         c2rQ==
X-Gm-Message-State: AOJu0YwyrcP9obxNLZH5ptPF6so3xq14FUlPeI7nyyh9ZAy5e4myRpmr
        5VJMZGuHeXu0GOZji2rUpYoiXDILkF7Q4+auY4jV/w==
X-Google-Smtp-Source: AGHT+IFnOwLkA7LCkr68I4+UGRtpt1jB8RiS6yGinah+tBYMMAZHTDXL/RJmoOI5Gh3rZo7vkJjK7w==
X-Received: by 2002:a05:6a00:398b:b0:690:c306:151a with SMTP id fi11-20020a056a00398b00b00690c306151amr15843057pfb.0.1696908588478;
        Mon, 09 Oct 2023 20:29:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r5-20020a638f45000000b0058901200bbbsm9177335pgn.40.2023.10.09.20.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 20:29:47 -0700 (PDT)
Message-ID: <6524c52b.630a0220.98db.9a81@mx.google.com>
Date:   Mon, 09 Oct 2023 20:29:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc5-135-g3fa39021ead0
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.6-rc5-135-g3fa39021ead0)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.6-rc5-135-g3=
fa39021ead0)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
6-rc5-135-g3fa39021ead0/

Tree: pm
Branch: testing
Git Describe: v6.6-rc5-135-g3fa39021ead0
Git Commit: 3fa39021ead0c8a84117648a727ca8b2f8af3b3d
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

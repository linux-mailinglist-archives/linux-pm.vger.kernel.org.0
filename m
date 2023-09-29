Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9AB7B31F8
	for <lists+linux-pm@lfdr.de>; Fri, 29 Sep 2023 14:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjI2MCy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Sep 2023 08:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2MCx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Sep 2023 08:02:53 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC51EF9
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2023 05:02:51 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-351232a46b3so39650945ab.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2023 05:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695988971; x=1696593771; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UJnZWusS+auwrzmf7ucKQZ1g7pCIeU4HyU06wEXGLYE=;
        b=FRkUNIlfqkOY3T/U0uyG7y27qk8E7t7qo91znwA+sJ2PQthuiaDHGyuRdZBwFL30GU
         cGI5P+tmIN9ji1cILpVLfKZDKfzyWygAEGivoQyg0av6cK3zr9VahgMN8SeZG2+4n/2A
         cgpTNXUPVZbBjejePOFE8Bthgm7kBUcLC6xeR9jfbpCFy6hBoqNAHc3Qq1sKAPlVBk2v
         oX/C7Zu0XDHvh6xnum7ScHX9cqJhcUCwOd+XYIhWc9IiJ27XXo0URMsFWz6UlA56WjxQ
         pHE/SKgZ2H/cY0aylAqVZdnW22z+GVXys1l2f/fMTcG6agPFFcOp6Ajy67UJxvUYWdew
         inFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695988971; x=1696593771;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJnZWusS+auwrzmf7ucKQZ1g7pCIeU4HyU06wEXGLYE=;
        b=mWhDszpr8DyBF7Rz7q900JAd3dEYVlEdSu3OJCWlMd03ix6tzfjl37rpg9yOoiYIBg
         eePD7Dj6ht7NfB1w2YaWc4E5PDbqujXaApiSzIGh6mvDCNvAxpdESiaXMaNrz1Mkw19l
         3dOpA7e2L7UStT9YDYRbF9IoBfbCp3+vAmttfJqHdYj+jcfYKtop5tFQTrvIz1e5YD+z
         Dzz8yAVLJnC6dleHtiOXwhkrX6CExc9kHrGkyOu2hwxQ87Hbk5nkcP0FLbdXisQqQGAG
         3u1Knvum0UCj68JxCDS3pzSCLpHjdnQU+e12zOCqt/hg2ymfBabfHyPpgklSc3PZOJ2c
         9j4Q==
X-Gm-Message-State: AOJu0YwkR+i+NU4mKtWxktsrPH3SKHuNcBB1iTaD46NbAQZka+HISxLz
        Z7ptgu2M41wugjyQ6jQWBeVSww==
X-Google-Smtp-Source: AGHT+IEzVmOlrw/Xt0Rd2POGcw+9vj+3md7it+RmJ4DcK4zUAnnngeIXygLpbtFpMLyxOQ3aGk+hfg==
X-Received: by 2002:a92:ca45:0:b0:34d:ec9c:7321 with SMTP id q5-20020a92ca45000000b0034dec9c7321mr4667575ilo.3.1695988971094;
        Fri, 29 Sep 2023 05:02:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y15-20020a63ad4f000000b00578bb0066b6sm3641567pgo.71.2023.09.29.05.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 05:02:50 -0700 (PDT)
Message-ID: <6516bcea.630a0220.11b20.b113@mx.google.com>
Date:   Fri, 29 Sep 2023 05:02:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.6-rc3-95-g705ffbf392dc
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.6-rc3-95-g705ffbf392dc)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.6-rc3-95-g70=
5ffbf392dc)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
6-rc3-95-g705ffbf392dc/

Tree: pm
Branch: testing
Git Describe: v6.6-rc3-95-g705ffbf392dc
Git Commit: 705ffbf392dc64e6f54772eb08e99d94f7845ed8
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

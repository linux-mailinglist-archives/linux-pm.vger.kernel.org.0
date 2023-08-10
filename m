Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3257782A4
	for <lists+linux-pm@lfdr.de>; Thu, 10 Aug 2023 23:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjHJVT5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Aug 2023 17:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjHJVT4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2023 17:19:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6762727
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 14:19:55 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686c06b806cso1024098b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 14:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691702395; x=1692307195;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/q54FWHRSL0pKS9xzg8t+BnFbPgrRKTox05WRAIA/sQ=;
        b=fp/tEiaFAPe1AcWYpDk4lMt2k5BT3JIiEuAgMH+Qji3AXGvjqm3P+t02iiRg0Lp9I+
         swgfHzEHDjpatXIHXJUQSKDiVpMEtgzxiJhaFzRe/dbid3YmMvExbtbBeKOUoO5kTs7/
         VrNW+KswJC/laSpH4KuZDzwvo4XMIAe20nWko8pmnY5qxu20ADXotD6AkKGoE1qcrkzr
         iY0sIZCJJD0wnpUINrqfouoNd5JfDNdMpw6wlKb7KkQhtIDRKnUQ33CIxugNtua0aQqD
         0JeS0vhpYnwzhlpO/cpuoCgPDfUQtP4tUOw0Oa1LjdmHZLHXJiDwAXE8jmllZ6wMzb19
         O6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702395; x=1692307195;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/q54FWHRSL0pKS9xzg8t+BnFbPgrRKTox05WRAIA/sQ=;
        b=F21Gw8ocn7JRgT0JpqkfNQVlVkbMUiwYdx9xZ/xNlgwKfW3YBuMvgnpYdic/C0oDo/
         PSZDEGNt33mjE/R63WVub7hpiQ9n2kYLkD86A8Roo7CbT42BLyDHV8g//Q4GjZZoiCoy
         xLv9grZ6DSCBub7Jx/Gn7tQawsnBt1d5/n3egAZ+GbZECW9gne62oC+XvYnjODfiYOb0
         s0xp972ipS0d1eZ0eGcpjkFoNxwaaE3TJ776+jGQMVyT4UZFqEK8ZlzJZruJ7AvP6qjE
         DJaWHQkpoOc1QlVsUnUBto7rCyYvBlHq5CeGwYMdTRWVpcgRaeXSSnR4pZVMkWSi55+7
         IVcw==
X-Gm-Message-State: AOJu0YwV+OGguEYllkU9YhphpP/49H4R+nVdNeWVMw1Jpv83az4S5Mow
        RvZ4fQ2NOmLB4cxybPKZWLZGGg==
X-Google-Smtp-Source: AGHT+IG/fi44WVYAjN5f1NNoH3TMv10s2aiYGiGASKQNjDFRvuLYTxSIryBkklMmElKkxqVz+EOmLQ==
X-Received: by 2002:a05:6a20:458:b0:134:a8a1:3bf with SMTP id b24-20020a056a20045800b00134a8a103bfmr192663pzb.30.1691702395222;
        Thu, 10 Aug 2023 14:19:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r4-20020a62e404000000b00682a99b01basm1964966pfh.0.2023.08.10.14.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:19:54 -0700 (PDT)
Message-ID: <64d5547a.620a0220.82ff2.3e0d@mx.google.com>
Date:   Thu, 10 Aug 2023 14:19:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.5-rc5-81-gfac64c1cae9e
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.5-rc5-81-gfac64c1cae9e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.5-rc5-81-gfa=
c64c1cae9e)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
5-rc5-81-gfac64c1cae9e/

Tree: pm
Branch: testing
Git Describe: v6.5-rc5-81-gfac64c1cae9e
Git Commit: fac64c1cae9e3d53eb271e93c51639565dca406c
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

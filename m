Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0930767A6D6
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 00:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjAXX0Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 18:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjAXX0X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 18:26:23 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D4445F6A
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 15:26:18 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b10so16755843pjo.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 15:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rH8PyARr68wROHUBQJtgD8sixKhNqYYSxz6dYv2RIL0=;
        b=JhmRQWcBOhkIHrdD7keGKIA1cO48OcJ/crvnEBinf6JkR1UKeROwVRYyh9eznXu/oS
         LRm94c32jcT81WFeEtvtd65pT08UjlqOX6hm7iTxeGydV9RAwMQcFSQVcFdxToRbuhU0
         SIBis9VxfvRQWkIXMkT5BcivBS5utv1RE0hX8SNap+oaO0S8FwNbbJ5zFsguqoEjzhFw
         XKjGCQvPyOHDJlUhGj4XFdw+neMkS7NdBHRHaGMdJUDAp2FswQZ7kX+wFflutoiGdRKl
         hPcw1RHZz6Q9+J/W+naHUL6ntSbFZrM2O4mvezwV9yW4kDgZc9Nyjx+WOsxy/+uUTHp8
         VJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rH8PyARr68wROHUBQJtgD8sixKhNqYYSxz6dYv2RIL0=;
        b=il0fae4vMoL8fjCQ6jE/EY6/v7lnzo2bAfdqlhG9wYhj0k53659BnZwc2J/DZuP2Sy
         PPiaD0tLQBNoF9DjdWnZ60frvW6VrjGpijqamEl26yOtghs1IXQae8LBnE3LaHw9qzOv
         lC4eHJ9M0wej8Q6XWTLTdzENyNEux6zLMW7OOcbKS8WosuNEijYUnlCa24DYnm/WI7V0
         6ojeBningtlPBjnjvRMwWj6jJnhspmqD1ChiVlmSPI0sWX2vzT+OEPkP4ZSRL45vo9Ga
         6JEOobSFK32y6UkVVvbM/LV7A0xnRZ7zQLy0qYhiDMWOzVGLuBgRHZ0+v3qpPFaYdawA
         aqWA==
X-Gm-Message-State: AFqh2kqAdBKdDFhYcH9d1V3y6oq5HYREG7w1tA8MO3VZ7FTqNhCJKoAu
        rJ8zzdZKg6WwyqLlZkSfvML6fA==
X-Google-Smtp-Source: AMrXdXt8tuiKgHR1VU65pjhMjNRYWTFr6MrAwQ1yozlr8hMc2dv6+ZdDzVAY9RXuviD+yP5jUTeCSQ==
X-Received: by 2002:a17:903:286:b0:192:751c:6e8d with SMTP id j6-20020a170903028600b00192751c6e8dmr30000147plr.58.1674602778428;
        Tue, 24 Jan 2023 15:26:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902968c00b0019338ecad52sm2193495plp.190.2023.01.24.15.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 15:26:18 -0800 (PST)
Message-ID: <63d0691a.170a0220.16a5b.4510@mx.google.com>
Date:   Tue, 24 Jan 2023 15:26:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc5-92-g2f9e90528ee7
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.2-rc5-92-g2f9e90528ee7)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.2-rc5-92-g2f=
9e90528ee7)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc5-92-g2f9e90528ee7/

Tree: pm
Branch: testing
Git Describe: v6.2-rc5-92-g2f9e90528ee7
Git Commit: 2f9e90528ee7bef1986e08a253c9ea8a8926df0c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

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
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>

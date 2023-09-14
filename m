Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A021E7A0F78
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 23:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjINVGP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 17:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjINVGO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 17:06:14 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E478269D
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 14:06:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bf55a81eeaso11364645ad.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 14:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694725570; x=1695330370; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PRNG/J+zb3l5t73lEcKsGxL1+VyiUnT9ZKc8LxjtEo0=;
        b=jCaFjDJ9Y8D2GVKy1+32AgS6q7807K5ceuIgNfYmovnjaHsWrPiUa7un2B5JTHlO63
         W0pgtoaWPkysM3eqz3PieTLr/wHE5drjENkRzSyIss/Kj2SwboQyL+HXDZAn7hB5FyGL
         CYt1Fq3B5OUh6nzrFWstgvDr5MSTtTZS4XXPJeS/gfaUIiJxXym0cQHbA5gTYvQm6W2G
         ICic29jC+yNarB6LFRQxfZzvx3kFdWLgKUokoythfccEo452EptWiT7uoYwECl/e1nqb
         77X9qQmAJLDParf5lrkrL+BI0IJIvVVXAEryIxeYIJOvP38nTqtKtVtBnPjc3gYCBGjS
         rN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725570; x=1695330370;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRNG/J+zb3l5t73lEcKsGxL1+VyiUnT9ZKc8LxjtEo0=;
        b=EVXuhULr83y9hUB5tzBwryN9Y20NbDxjqO+dlwbhE5aj+6s+RUMpuDDYti+d4cQxWg
         Wv7fdp2ShWOq40+8n2WFkGl3+lmRFEEaWYHO2zK8nR42eGsCnXcvORZqMekQ5a9QWHl/
         UL18uiT99TJ4JYdamT3XPm5zZT+iwmy5HPhCWVJDbWKU8vCsCirAivaMadQ5g/uSBc9g
         Gp6NtDoYbrGB5chNIgZpVNk5CLxV1Tn0Z+R6olVGcIOC7qLxHRYRcZtEvsoKatiN7/oR
         sRbqO0GXl6fvUjaol45c3+6cphXMg8SJ2ieyf8dun9q8xyGp5POCX5H+/2ZeLcmVMHMq
         xjAA==
X-Gm-Message-State: AOJu0YwlgjUTNNm/Rm6UnZgKEav/JQp/9C7wibv7C3kA4u3gXM0QHRC3
        eljawbxT3UKENg2/0zUp/+z+v0kgsxmmdmUpADQKtg==
X-Google-Smtp-Source: AGHT+IEGAOngPc1WwYA3XZVyjImcmVZz5ySCm5jVOVdyRG8pZZF5EaNWDbcuMcdj22cEJC3pSCMsVA==
X-Received: by 2002:a17:902:c952:b0:1c3:749f:6a5d with SMTP id i18-20020a170902c95200b001c3749f6a5dmr8159214pla.4.1694725569750;
        Thu, 14 Sep 2023 14:06:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090341ca00b001bbb7af4963sm2015849ple.68.2023.09.14.14.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 14:06:09 -0700 (PDT)
Message-ID: <650375c1.170a0220.21cea.7f15@mx.google.com>
Date:   Thu, 14 Sep 2023 14:06:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.6-rc1-18-g77717cab92056
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.6-rc1-18-g77717cab92056)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.6-rc1-18-g77=
717cab92056)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
6-rc1-18-g77717cab92056/

Tree: pm
Branch: testing
Git Describe: v6.6-rc1-18-g77717cab92056
Git Commit: 77717cab92056218f16b9fa41af5363b9411f4d6
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

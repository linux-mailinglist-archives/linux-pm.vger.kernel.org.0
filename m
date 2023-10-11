Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AA57C57A7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Oct 2023 17:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjJKPC0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Oct 2023 11:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjJKPCZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2023 11:02:25 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C3A92
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 08:02:24 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c88b467ef8so46327955ad.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697036544; x=1697641344; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kpaWC66yVP5i+fqxa3f45yxxorFTGgzdrh1YPqsGDwo=;
        b=hT9YKpbyiwWTMlSBCEN4GSjpwYk/d3HHeMTik9+aI6Kza4+fzx+Q2gkJ9soUovVbAE
         99u0PwsDuGQkdEUHS2pW4X3x3PdI+IG2a8WAYJax75xY5pvVcSxGjze9iZ3zDClLYohB
         qzNQK5FmhOGzPodPDIVHG9oJqCMQFTopsLx0hUoBoJjkKZPiXw715QOkjyXVF+9SRdZV
         35Z2HBJaiNuw9HvEwSSDUWFNp99NrjA5Kp0Q9/Vh24cKv91AI56OmQhfjBXQ/jQB7u2w
         g2BTkoF5q7acJNxfKNXEay405wzYn+XoF/Y/U5Pg5nuD3p3HnVMdLNjhaJh4J8q2Y6np
         AhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697036544; x=1697641344;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kpaWC66yVP5i+fqxa3f45yxxorFTGgzdrh1YPqsGDwo=;
        b=ktjfCcgWkUMluLynCeyQVq82rRHSrqerL6aaFAhQ1URANZWAqGZyeTgpMRci+6Bu+W
         OOF33+RluWhItkLjKyH5vhnftX6+xH3kYJo57loz+UwCouToA+HLYG+eS9qAFJ3UB464
         8MdnB1WnEv6GtMluEgvXZhAjRDNC08cEu7e9Rd+NNPRoG1WwjMDLM+H1A0U682VSfauk
         hr8m9Yy+8byFfT5pN3/A1/coR18Yn7owdrREbChzL5ORh3uZubvw8+mYbo6IP+grIzwH
         cQjKoQlNQXoEXS8khoBeNcyDevFyuUbR0IB2yVzEU0z5obHnsZgsv3BieEonqE7QVLvq
         VBaQ==
X-Gm-Message-State: AOJu0Yw+XYZrpPNBdoY+egdRbr9E34AIT/gKt6WGgYQNuaX1KXfvThMp
        M+FBtp5yYHFeyjwS39YVOlwzfcpP5nYIJF1rtP8mYA==
X-Google-Smtp-Source: AGHT+IHWREcuB7TUsO1xqeExi/UhNsewGuYOyQiwoT9pFhrtYcNgDgoWM6cWMjLfPFCy4p4eDppW9g==
X-Received: by 2002:a17:903:228a:b0:1c3:2423:8e24 with SMTP id b10-20020a170903228a00b001c324238e24mr23482601plh.8.1697036543753;
        Wed, 11 Oct 2023 08:02:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902eac400b001b9da8b4eb7sm3689035pld.35.2023.10.11.08.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:02:22 -0700 (PDT)
Message-ID: <6526b8fe.170a0220.b4271.adfc@mx.google.com>
Date:   Wed, 11 Oct 2023 08:02:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc5-139-gc7234228d1fac
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.6-rc5-139-gc7234228d1fac)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.6-rc5-139-gc=
7234228d1fac)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
6-rc5-139-gc7234228d1fac/

Tree: pm
Branch: testing
Git Describe: v6.6-rc5-139-gc7234228d1fac
Git Commit: c7234228d1fac8f498c5859aaa32f154619f3ce6
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

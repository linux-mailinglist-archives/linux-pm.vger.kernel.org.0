Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AC16DE699
	for <lists+linux-pm@lfdr.de>; Tue, 11 Apr 2023 23:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjDKVlX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Apr 2023 17:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDKVlW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2023 17:41:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03A7449E
        for <linux-pm@vger.kernel.org>; Tue, 11 Apr 2023 14:41:20 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w11so9885574pjh.5
        for <linux-pm@vger.kernel.org>; Tue, 11 Apr 2023 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1681249280; x=1683841280;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iprYUSpeM13lGpin+jZ8QcFRJb8RrUDDJuR9gf+UmZA=;
        b=4T/LTs4uyYi7avaumXc5KI+q8+5mnKADkrvMI7qnDsenWAdP/YnDpZ/zW/RWamre3u
         Ci2jiB4HQNqhPXc08fEtW0b5iBhcojjYdRymqK/mOWFcneJpbM5U5CDaw7JtWmD+J1O+
         5zu4Ww+nORSN5kwm0wS8KyUj/Rz925zUlXsPt0B4ipKizivTDd1xLesnQ8b1kQKIhY1m
         1BnFrhYzLJ754th7zPjdmCkicJ+hWIrFJyfj1XEbFmXvXyU/3amvb0zVdGAGYVdOQFsT
         mNpl8Y9muYHnk6tVwcKQWkOHGwMgVW7sMufrNok9G6ejA+VLDwVZ/TQ80Rh9tZqifM3X
         P+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681249280; x=1683841280;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iprYUSpeM13lGpin+jZ8QcFRJb8RrUDDJuR9gf+UmZA=;
        b=d3ZfdO/f+VO80PsUaYMVD8QPElk/yZ1amPmcHCAZV1LHKdZYbbll5ijLFC5brlHKY0
         joJ78fZ8FsszVL3bsjXV+caE5SQnXOMRhDgEZGoNYfHlJFDXPiiTv7r0k5LmG5tnwwC6
         AmtvkCN8a6DlZ/qJyNhLG04xP90oaP/c1y4V1wfQCIO8EK5oPOWSG7c788mhshA5/Me8
         FmITYE63um6YkvS1T3spYqSbPf74o3/PpXbLcZ7YCtxHF6x+aBfUutAVpn/hO6z3NlAx
         vLwlQRzzXbUD03LpIsSzjEg5rh0lflSrvHA+1iO9B/6w6hwns+0plV6/W3/C5OzwX0Kr
         cZ3Q==
X-Gm-Message-State: AAQBX9eWUxUclZh39xDlZle0iFUHIDOMhkQvmjTpPeiZ45AQvNztxmre
        4vip+Pfj9sO2xEckZyAf2Xtr3Q==
X-Google-Smtp-Source: AKy350a0XgFGWvrWDozSCX02QEuXeyoEbzCJoxJa3jvHrGjbG1kKdIdpqIHIkumuGrp6dwW4KDQB0w==
X-Received: by 2002:a17:90a:ab0d:b0:23b:2f4a:57bb with SMTP id m13-20020a17090aab0d00b0023b2f4a57bbmr20256892pjq.10.1681249280191;
        Tue, 11 Apr 2023 14:41:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id gi1-20020a17090b110100b00246ba2b48f3sm2485537pjb.3.2023.04.11.14.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 14:41:19 -0700 (PDT)
Message-ID: <6435d3ff.170a0220.b731a.2b17@mx.google.com>
Date:   Tue, 11 Apr 2023 14:41:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.3-rc6-130-gc4895dfd200d
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.3-rc6-130-gc4895dfd200d)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.3-rc6-130-gc=
4895dfd200d)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc6-130-gc4895dfd200d/

Tree: pm
Branch: testing
Git Describe: v6.3-rc6-130-gc4895dfd200d
Git Commit: c4895dfd200d5c78aa61b55e924b0e35a06b5fe1
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

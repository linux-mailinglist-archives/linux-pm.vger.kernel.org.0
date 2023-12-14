Return-Path: <linux-pm+bounces-1162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F07813700
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 17:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7773DB20FDB
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6635E61FB0;
	Thu, 14 Dec 2023 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="U9T85piQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBF38E
	for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 08:54:47 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d367e7092eso7771555ad.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 08:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702572886; x=1703177686; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R26HJiynloK84egh/KX6vL0lSgUHEP3P5GWA4eowV5I=;
        b=U9T85piQvYbtimQElgZ9crkH11Cbdni20uuAq1PBWhbpdhzCRlPkAfpJe5FHqUprNf
         3WTyywpe8OoPfPt568frkueqFTr5l6ECJBj5bIMglRCvDSrCwKmDAIXi7hvw+kQz3i5Y
         7Qn+zLSYT0XUmae8f3DZCBNeynF1PZeVWGdHw2DF/coarx6k1gl/9mM+GfFaQn4KM4YG
         f/rcgZSwVQirvOBZDeWbYfVwIDmx/ctbZulYF+jG5ShyOHKutTIsaWnc41QlKoeOdb8I
         0GwFBpVmmZuXSXWyC94GCwhTwEalx0vjADLMlLDpSQjgf5JFf1Ubaj/l9eYXxl9adX2h
         4Tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572886; x=1703177686;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R26HJiynloK84egh/KX6vL0lSgUHEP3P5GWA4eowV5I=;
        b=qyxxGdH6hcLZmRd19R5tRMJbt+UfxGoKehMwNEEBdFRCGgXYaLueoVnZqtbuJzywC7
         Mt2F3RaFHqBWfHiSeXOkDAAGcG0pyhdpWehuhiHrQwn3MNcUdJPOALArRaCkCen1dBdh
         FvjOVOb/ghqgRigznyBcLI4YLATVFS7tdGOUYbjWWMd4++gfGbbStLYzoZ7DaBH2SlkZ
         Xo9KYWLB0NgaWQTRAG7PDbT+GPuilCx9U8B28h45m6DnAu41D6VBzIH5cWChxIe+XbDQ
         8tVXsQu7gJTz8CIcu7qT+g3Ted5pjLcuDYug4SHNGLGkIXoU/cpYJqccYFIYslpIxDlO
         2e1w==
X-Gm-Message-State: AOJu0YzsTJkL/kaP+6jVCIoEq1rDNoXvxBh45q1K5EwthcsyV+7mS9aW
	v+fioXZ0r8fHJva5vwrpuiGQPKDH6js4dC8NpX0=
X-Google-Smtp-Source: AGHT+IGZ1PCMvxk43Dm3C+cq6tc28vyo8QrDFQGG8WbC6oFidKX5P8UJS18Pyhaj1EIRjqCoHvn+NQ==
X-Received: by 2002:a17:902:7ec8:b0:1d0:8cbf:39db with SMTP id p8-20020a1709027ec800b001d08cbf39dbmr8703015plb.88.1702572886586;
        Thu, 14 Dec 2023 08:54:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902b58700b001d0c41b1d03sm12700746pls.32.2023.12.14.08.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:54:46 -0800 (PST)
Message-ID: <657b3356.170a0220.1746b.77cd@mx.google.com>
Date: Thu, 14 Dec 2023 08:54:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.7-rc5-91-gee96d5c15517f
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc5-91-gee96d5c15517f)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc5-91-gee=
96d5c15517f)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc5-91-gee96d5c15517f/

Tree: pm
Branch: testing
Git Describe: v6.7-rc5-91-gee96d5c15517f
Git Commit: ee96d5c15517fbdf136aeff1919646e843fbb6f3
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


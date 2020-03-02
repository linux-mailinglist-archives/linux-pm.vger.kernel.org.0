Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22635175A24
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 13:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgCBMOe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 07:14:34 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:37852 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbgCBMOe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2020 07:14:34 -0500
Received: by mail-pl1-f179.google.com with SMTP id q4so4136543pls.4
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2020 04:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=nwpiNOZRSlfz7fkWJKds1iP803kng6edSS3IYewKkHg=;
        b=gJt7LclESLKECQqFEs554DNBjxDqQngLEGfRVprn/O0fGgNmA/OtRrk2fFTnTFz035
         SV1Bjz/dqD3FNukuuPWIxCxI0IukP2yMYZFqywjswrzOjCM3BdbMNSeSZIuPSOtfTE2h
         CtYOOSXP2m0/3LDJnwaLhyGFE48tSisbkm8YCM7tohsfndQ/WwCmLs0k1v8ME4TKgS1w
         WeF/IpLF/W9XI+HGdHrEOoYRLnVdnl3VrKPni5HgRa0NJvUzHja3EPvgxQcob+fCnVFO
         u/IbEevr2EVZWY0eWLpur554vcKF6wAzPcLAw2B0CaXgzRRVluFqLQke+K1uCSd7epTk
         N1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=nwpiNOZRSlfz7fkWJKds1iP803kng6edSS3IYewKkHg=;
        b=DKKbkoK2iuzTQFNsPN+6f6Fuyw+VERpt61okTsz9BOFjqv219c80zn7uZ6fjFkN0Q7
         jd+GrTlmQ57bqcWZHjE6ceishmpUAEyCOpT5NrY6kGnG7VhNUeaKdfSPNt/WqqOkb6V2
         6HJphucFdcqm5n8MuzF0usLMebX65LUcEGwTbMcyfCuxJmG2JYs1Q4vOGBFZNAtysY9v
         xCgfj4OYrxCocQCodbSyxczPHme1cCPWnYGgtuzSpW12sYXAw5ADRPVyrvGdCvPLkTgu
         axj5rilw9lGUUlv16rW6EcKJthd0MxG6qWpS0xGNM9duqoA7MrFYCBd2ge8yAirpY3lf
         /Nkg==
X-Gm-Message-State: ANhLgQ3CJN617LBx7CigPQijt83RpT40sGnKwZQY/zg5136ptP8YSxpX
        XtH7a6l/kjRzLiorXcAommMWKw==
X-Google-Smtp-Source: ADFU+vvhn92V6lGibIKSSkiwANlTupfqHQN9zCzVhkVzDVZ4IJb3FHSX3XaW5roo5VUhTFnbl1yakA==
X-Received: by 2002:a17:902:a415:: with SMTP id p21mr472772plq.57.1583151272847;
        Mon, 02 Mar 2020 04:14:32 -0800 (PST)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f8sm20760677pfn.2.2020.03.02.04.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 04:14:32 -0800 (PST)
Message-ID: <5e5cf8a8.1c69fb81.7f0b.6989@mx.google.com>
Date:   Mon, 02 Mar 2020 04:14:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.6-rc4-56-gf99f4dfcc7da
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (v5.6-rc4-56-gf99f4dfcc7da)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (v5.6-rc4-56-gf99f4dfcc7da)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc4-56-gf99f4dfcc7da/

Tree: pm
Branch: testing
Git Describe: v5.6-rc4-56-gf99f4dfcc7da
Git Commit: f99f4dfcc7da2a275bf6c1c864a829afab018816
Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>

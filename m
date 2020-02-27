Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 770061728F3
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 20:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgB0TvI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 14:51:08 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:36342 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbgB0TvI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 14:51:08 -0500
Received: by mail-pg1-f178.google.com with SMTP id d9so232365pgu.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 11:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=WUtduz+x2cePfsO4xfh146VoV6zUUwL0cPHUHG3iKOU=;
        b=0lEu428PzHEcnUAKyAstQDZe+NFPTzpgAvjhZe79dn8AjigZwUZYLjt35esJ+gDPdc
         No3hTyGHF4Nu4xL4osqcc8vkB1e6XPJMCxazxyMQYhzkfRwQF9Sb2PM/CMUWpIJz5gIN
         lHENrR33KX+lsu5UuzL5AFLoGZMg/IZANFszFKUVKz4ucAF2FjL5ugyS8zEpJvP3pRqf
         +mSXgP6cpYI2N42gfgSnMnrICknB16tK+2F8PClfGkfhyRTYvGmMtV1NfiC72aT2x7KO
         cwoLEJNcPPu0XuihUiSSlZwYLf649IFeOGu/LA1LlYef3Wi0mf2S8typw/AqAUvj4out
         0+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=WUtduz+x2cePfsO4xfh146VoV6zUUwL0cPHUHG3iKOU=;
        b=FEfWMHSDvOOr8gjipQQsECe9vq0GR1DIIXRgOO7OL7lFBBmiK6ectV7OdzPr4pbbXd
         EcKiNut/I9J6ObBkG0AbNNc8/JzgppCCRXCwA8BDBmEL/RrqOnTaorpyaCOYMiN7AHO8
         pz0l/fMlv2pHcpxdmmjsjNU/OZxUP3oEyBQJncaV2qe2oDAsaiG6wpXNFIoHfsSHn4cg
         yiod0Qu1OWSho4ChRxLaAzvTosyVvmQMhXzZDfo3OBpYBtlwF9iBK/1OF+1hdg4Hxs+7
         eYV5RQqH/qD+MImVXXosJJTQi76oyXbs6Y+rGshFNOA4lq5o0DljSNooK7cqA1thIZoh
         fCUg==
X-Gm-Message-State: APjAAAVVbUTIEWXWUAtJaEZSERDbxv+kot4XkTMBSV4gbtGQBtBR816G
        /cnf1jLIMsJ1uD7coachBEcLSN95Syk=
X-Google-Smtp-Source: APXvYqwV3+P1eHmrmnS3/LB8wqSzcNBE4VCpbq6qPLWhKYr82bbEYfivHcelJbN8N38IR1TSqg37XQ==
X-Received: by 2002:a62:790e:: with SMTP id u14mr633536pfc.174.1582833065620;
        Thu, 27 Feb 2020 11:51:05 -0800 (PST)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s23sm6921441pjq.17.2020.02.27.11.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 11:51:05 -0800 (PST)
Message-ID: <5e581da9.1c69fb81.d81fe.1ed0@mx.google.com>
Date:   Thu, 27 Feb 2020 11:51:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.6-rc3-67-g146605da90d7
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (v5.6-rc3-67-g146605da90d7)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (v5.6-rc3-67-g146605da90d7)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc3-67-g146605da90d7/

Tree: pm
Branch: testing
Git Describe: v5.6-rc3-67-g146605da90d7
Git Commit: 146605da90d753b81f95829c7f13bfa02f46ccb1
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

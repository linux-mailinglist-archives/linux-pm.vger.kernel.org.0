Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76703185865
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 03:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgCOCF5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Mar 2020 22:05:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45461 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgCOCF4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Mar 2020 22:05:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id 2so7684710pfg.12
        for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2020 19:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=W0HmdiFzUuXI6TsJaEEd7vUDsJQgXWS0jN3ODGIwXBg=;
        b=kJw3/eftt1jzD2AbkUnQFwq8ipOdhAx0Fi/17wKbv+yKRmBz86VOAd42A0tkR5aQIJ
         LMrmX6nlsU3NlPX85ii+gtBXyFAQ78KTXd9V7ai1T/Oz8gfLRxsk6TozgmpNsIPbs9Mv
         kp6wKuZeOUdhe0hPOFDNjrR+liHrxSF/gi20QImjstZ79kgvRclqk7hBatPuhYOw0J3F
         XqdI/XiXPZt2GV8h/WbV6/mfxNIhYOWWPYxRMKpG9TbiAnSKDPMzIiI1N+4z1pYokyXV
         jgPQu9bzDxpCbvYjuaQbJR4PG19dvmeNdzfXFFkjBAIpgpftOllPYq+E/ss0R8bs7VXf
         Km3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=W0HmdiFzUuXI6TsJaEEd7vUDsJQgXWS0jN3ODGIwXBg=;
        b=lromci1x1EdazbIb0QQGGKcAwuPJJ0WURVNgz96MoB9x1sQVjUViZbkyHkBnDc3GD0
         3CCzJJfv4w87znPtSB6LhsBnZbM05QoFoeH3IrNBukRD1tLf8u59P5JoGpqU7+AgI7ov
         qO6C2OqO5HchB14mREZvzVmSuVO3tf1lwL6xN0b2Ra2EtytovdbvNyqVUtg/sb8GL4MV
         2VbzTDjNAYramI9c45m7+lf/AXxFLQADB4aWamUqWIVJAsKkF3owIt5kohn3aIQc5lML
         29muB6a5i9Qupz6pUahPl3lhAnV9sGOmVTzasmDk7fzLiUXahjddCqOa8dWwF5UdEjuO
         zP2g==
X-Gm-Message-State: ANhLgQ1aIirYZXoHAQ6Cmw2J8tzLHjJr8S9Lpe/q2sTphC1zhK+jeBo4
        rAJu/CxJT5UAdbHHpnhGaH4r0wzWUm8=
X-Google-Smtp-Source: ADFU+vvKWpYgipx24Do2UayxbppEf0eHlu4JNz0e69jq61FiHHGJnBEOfjNKpm15VtyTj8AWALzecA==
X-Received: by 2002:a63:f113:: with SMTP id f19mr19975661pgi.168.1584212804301;
        Sat, 14 Mar 2020 12:06:44 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e204sm9707093pfh.199.2020.03.14.12.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 12:06:43 -0700 (PDT)
Message-ID: <5e6d2b43.1c69fb81.35c02.18d1@mx.google.com>
Date:   Sat, 14 Mar 2020 12:06:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pm-5.6-rc6-81-g0b0cbef30e18
X-Kernelci-Report-Type: build
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (pm-5.6-rc6-81-g0b0cbef30e18)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (pm-5.6-rc6-81-g0b0cbef30e18)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
5.6-rc6-81-g0b0cbef30e18/

Tree: pm
Branch: testing
Git Describe: pm-5.6-rc6-81-g0b0cbef30e18
Git Commit: 0b0cbef30e1812bc567874888a4e71eb777fc51b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
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

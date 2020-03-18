Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0D37189A17
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 11:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgCRK7e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 06:59:34 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:37918 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbgCRK7e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2020 06:59:34 -0400
Received: by mail-pl1-f181.google.com with SMTP id w3so11030131plz.5
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2020 03:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=g/qxeRWGo74s8GISexZzaE5jrD6wz9LKPtO3tsW9s7g=;
        b=uzzvkSQpV/a7bB3zRLU/vmqDNbYoG/BtMERuGJq/+uTaHM9TDwNuEcOwwBS5VnBxjR
         aUp3nk0VA2I2WAQfI5TtZFS8HaNMEggiSd6Jnlp1PsYJOvxOxnEFyd4gWWRLtvAbAleS
         2rjQ7Hjz4zeTlxhZu6KCTU6NxvcGwPkQ9+6YETVN516BvaDF4HtB9oXK5lcYzuSv+Py5
         B6NYmdhJtpuGmRMuaY0bdIQzsUw99kqS4euc7C05TX/bYRTfppVzFcVDm3qOj9vWzv4Z
         AY09KV4BXrsPQnJN3gGHAGOjpgX/sc/kd1buu5+bkvsB0+0EBrkda0AVn501mRtWI+en
         rBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=g/qxeRWGo74s8GISexZzaE5jrD6wz9LKPtO3tsW9s7g=;
        b=fNvUgElfkU9jtY5N+760WwDeivg/GnRwq7hZXn70Qzp+1Q8AuuyIsdIlCNemPMzS6T
         a/PJ4ExRx35mVwDTwTWrYkzb/nse5YQHysqjTKT9BRzpZyw5zLsX7Zd3kKzjwQ5cs32A
         ZPd9mBQW/Bwl8msoPMuS0p49sQ7ThaKuSor6N96NYOMom5va3UmJAn7N+m3PS65w6ucU
         j4KIieHxLmHAeYniq5Rhi4hMm447wA3a9DzgjFI41L54i+7bP1MpEv3OvC2oyb20iQOy
         s3wcT/KypVUvLHRfCabSVlF6yQLypqQeYsvhDfLabGKwUqK4gCoDqPF5I2zdxGjdVt7N
         nDtg==
X-Gm-Message-State: ANhLgQ1WBp0lfwcXPKLES7YY+080utGhV6msNWXn8mL33CjbnDsG88Yo
        rzLIZS8mbx6vjADTRCkBCnz7rQ==
X-Google-Smtp-Source: ADFU+vtA34yfeJczAxVzHJ+bUrsG/5bzrAYEv3SqLoQA3AsUQU/eTOJFpX0n9onB6AyXMX/VuFaG4w==
X-Received: by 2002:a17:902:7d8f:: with SMTP id a15mr3263464plm.175.1584529173334;
        Wed, 18 Mar 2020 03:59:33 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f127sm6176589pfa.112.2020.03.18.03.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 03:59:32 -0700 (PDT)
Message-ID: <5e71ff14.1c69fb81.ddc3c.72d3@mx.google.com>
Date:   Wed, 18 Mar 2020 03:59:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc6-102-gc03d064a440c
X-Kernelci-Report-Type: build
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (v5.6-rc6-102-gc03d064a440c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (v5.6-rc6-102-gc03d064a440c)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc6-102-gc03d064a440c/

Tree: pm
Branch: testing
Git Describe: v5.6-rc6-102-gc03d064a440c
Git Commit: c03d064a440c2a5cbe3da782db05d3e18dc5ec3e
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

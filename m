Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F06679FE7
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jan 2023 18:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjAXRPK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 12:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjAXRPE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 12:15:04 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6281649971
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 09:15:03 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so18419637pjq.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 09:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cV73hwhacMYHiOCwEJDYGxf8Xx3ZV3mgofZTbx7rj+o=;
        b=AMMvlIxFrROAEtFT7tJnXHQWedVYFworVprUj0QLicXf0DVqUWHjyQCFPe42D31Kov
         DAfhy2J9FJIxb9eVVVr8LESRUPEaJn6zC6MZ0Fh5cZKXsDplIY6hM52TdGkGRMNSX9az
         YY1aT7XdF+DJng7+9W8xelBqRDIdsJ6JFQ4Nc6VdSGyXI1wtv3+OrtOzmoAE/EB3rNKk
         FTXGWwBGHUw4OW82Oji4GduXinRqOE4sBQsYaovR+jsQrOEWhv/j3joGdY8BVgwJ+7A1
         T2xenfQdhi/GRm9sNPGtn+3wj1LKyHwK7STqw3eKm5lPfSkJ8V2JmWMSwAEVWcKuOZQn
         sUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cV73hwhacMYHiOCwEJDYGxf8Xx3ZV3mgofZTbx7rj+o=;
        b=kccAG//n4liihaaSFy465wNVGQhvIO7LeU0Qgx+hdV43bl/rURKSFOxfSea8mRGH6/
         rLrCasSZ9gI4iT9bcfYIHGmPIEJbdlCr9tDJvFMDEWr8JhYMKwQw9TxR1HoF7QiizzGH
         9w3iY1m7Q1QW1AZhLtQkH5BjLeGOXb06pU1l+Lq3tCEk3Nvt8Cm0/o+2THyapiHRSCQ4
         x9zSiIxYXtu2C9RZdKKHY2WRkLQiJzN4mV4wyzZ3HyvPFjKZUJTsKQZmjL8u7TS9Ff/q
         ++VBegY3SjBBhoG0DjwXWDNecSkKxbjlfob6uNOpcQ6mrUp4UZBAR1hvGt2fE7F0AN/p
         DJ3A==
X-Gm-Message-State: AFqh2kpxMrBYB2FyaG1rBkNYUycI+Tf2vKtfI71pcpb00jKW9l74TN/9
        XajyT1yE+kavdUsp/5OI8I6qZg==
X-Google-Smtp-Source: AMrXdXvUiIdvtIkR+oS3RInMhnjmThnaCwxP68zrQjXMSEUEH+AzV3XprfcBLTDrdLxJi5kQE2UQ4w==
X-Received: by 2002:a17:902:c409:b0:195:e202:18b3 with SMTP id k9-20020a170902c40900b00195e20218b3mr21520994plk.30.1674580502829;
        Tue, 24 Jan 2023 09:15:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id az3-20020a170902a58300b001899c2a0ae0sm1941060plb.40.2023.01.24.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 09:15:02 -0800 (PST)
Message-ID: <63d01216.170a0220.27978.3ee3@mx.google.com>
Date:   Tue, 24 Jan 2023 09:15:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc5-93-g06f503868b96
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v6.2-rc5-93-g06f503868b96)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v6.2-rc5-93-g06f=
503868b96)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc5-93-g06f503868b96/

Tree: pm
Branch: testing
Git Describe: v6.2-rc5-93-g06f503868b96
Git Commit: 06f503868b964d4833db2465c13e0ab1efff1a5d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:


Warnings summary:

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>

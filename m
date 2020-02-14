Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA0C515D24B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 07:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgBNGic (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 01:38:32 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:53408 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgBNGib (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 01:38:31 -0500
Received: by mail-wm1-f44.google.com with SMTP id s10so8763213wmh.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2020 22:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Lhan5TrByPFF2Cn7OyxRo1nP1tV/BfkZXuebE6pGDbk=;
        b=q/Vc3rJ8ZXRqmp/ayOINwLJ0iiObIBgUNW6BUThLTX9o2bB0v5ovw/WGzcURcwGWeB
         +vcshO/QuOhDGK39tncoT+b+nLoNSxrDH0JlLoPlXkBmUk+RQgI50YAtOEUvROl7KS0p
         jNk6nHTyfkqua6k4hAN2lcXjlfrvX9W6F0oGATgjc3LmrOwM/iCRXOkZ7AI6NbcvWtAn
         4AP26TmJU1/cHgAUh1CFl21841t5tKIQ6a8EyhMCDCqKdy+VV9UmNJ1RKgzHcDZI9Z77
         LNBGqSVsuBCfEQIdefyz8X3m3ZlxrD6JmqT7OH+0NGkplyoP6CT57Zx4rGOhD//pKJne
         7nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Lhan5TrByPFF2Cn7OyxRo1nP1tV/BfkZXuebE6pGDbk=;
        b=s6gIogSW/c7ywlmALYlsctVHGnAAMq+IOWeYf/d+bZV85vjWmcPsVe87IVFhloqDoy
         0MzrKlzzjZtwiCK3/R2FPZ14u/utOlD71r3SOczHX7O66ujexSvR1bwwhE3NfjrBcjyy
         bgEksjKV1gpHJjdOCVB4/J7YEI5uOjJKMNPU9AbCc1Ezu+9+85HCIb79cVD70W1uOlkX
         epzoAETjOTB+54tqKD/XzO7DMGbqOJhvOVS+VVMS8bZm9Px6tqvzctA/rY4Et1Jh+vi/
         JDHytlRYjitXCbPZTGHvLVf/JoX11WtYYXq0QIi06EmVDnwPnWxTBGnzjqGVni3m9a3P
         O1/Q==
X-Gm-Message-State: APjAAAWM98O9yiukiLpByonHOeNYPXOCPwDW+QUG/jXTpElZ49rOcfZw
        sl9RG+9L3IG+lS2CR0A/pQdYhMMHyouZvQ==
X-Google-Smtp-Source: APXvYqwXEMZAJuz0NX31GyEae7z4Iw+fY08/Dn5OkvorMLILXhH/3xmM4vBMmZoyrB1y+dKu6GaT5A==
X-Received: by 2002:a05:600c:218b:: with SMTP id e11mr2725833wme.56.1581662310052;
        Thu, 13 Feb 2020 22:38:30 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id f127sm5942774wma.4.2020.02.13.22.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 22:38:29 -0800 (PST)
Message-ID: <5e464065.1c69fb81.5941d.8cc2@mx.google.com>
Date:   Thu, 13 Feb 2020 22:38:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc1-10-g55fe2ef33c65
Subject: pm/testing build: 4 builds: 0 failed,
 4 passed (v5.6-rc1-10-g55fe2ef33c65)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 4 builds: 0 failed, 4 passed (v5.6-rc1-10-g55fe2ef33c65)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc1-10-g55fe2ef33c65/

Tree: pm
Branch: testing
Git Describe: v5.6-rc1-10-g55fe2ef33c65
Git Commit: 55fe2ef33c658a1c0922ca161b136bb7171ac084
Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 4 unique architectures

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
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>

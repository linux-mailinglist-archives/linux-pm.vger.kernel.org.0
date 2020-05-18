Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F16B1D7B3E
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 16:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgERO3u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 10:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgERO3u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 10:29:50 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ED1C061A0C
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 07:29:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f15so4296841plr.3
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=yo/6OXL7cDjsydwPUEhY4mjUa/EXFlPNhT8kdS80Tro=;
        b=BY/n/yO7BaaRufh0VnwvAAh+DjlgBhlUnUS7fUMkIcSM+w6MqyUUZWZYo2bOyW10V/
         YyBSdwM9A+F9Y0MhUZ59yS8a/7PSlxjtHQt3CbEgklL/AlW+Vht7MMaEy16BL0oGDz3/
         n7Ww/tmxE61ya9fljnnfGFopHiKOLRyLw6ZFpMUC9sTT5K05qlJ4RnG3dbPNJ6iOfXzQ
         qD1BZIPoPUTWO0RFxWZrcedv9tl+G2tesDAwiCdhKa/RPLkr9themZ63cYTa9M6D4Wgw
         PDrat7Lvdm9mgY20KsMtv4yYSAd2mldRCxH2R4GUVGs+qlfBSRH4kQSzlFMqp+j9sKzI
         nfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=yo/6OXL7cDjsydwPUEhY4mjUa/EXFlPNhT8kdS80Tro=;
        b=nAew8fPxrI7rqQvyJxxF5Slvd8ZRo96MUCsDZxQkvdlJPHIxFeYFK5JjFSj72R8M2P
         N78opv2v6+nT0D4f89x30GR267h0Y/iG7pvljSudtExKYtIMNo8Xrz46hN9c+kyrGn05
         OdVMe/NNLolbF57KcrHBfK+Bbb51vBSNKtb8xXHwbNQKxJPBvItfqEbvfauWJoJWvuVo
         TOMVAISXsfG2kt5QnGGemfYWcYf+Q5m5egk2/w9bqLzFjlpkzkdCCEd/5IE142/Eh2+5
         QMAv0HAm+t1q/24gKy3YPiiRnXOtYX3puGu9CxA/yUkFrxiRXPDEcWd70JU4jAhAvhkV
         nMjA==
X-Gm-Message-State: AOAM530GvzgguB0M2+1r1ZL2lWUhhwN7fHJujd0btOo4DtdJl1eGW+HE
        7MHtRsLBG6XZU5T8mp/dC01duA==
X-Google-Smtp-Source: ABdhPJz3LEu1M3oMeiAhUCWZW/fjsdM7kuFBeFy01Rox8EdP1UeZCF0Al8QLNwwSlNjy+skHak0KNg==
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr885289pll.223.1589812188418;
        Mon, 18 May 2020 07:29:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w7sm8666644pfw.82.2020.05.18.07.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 07:29:47 -0700 (PDT)
Message-ID: <5ec29bdb.1c69fb81.ffdcb.a05d@mx.google.com>
Date:   Mon, 18 May 2020 07:29:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc6-60-g478d8912f6a3
X-Kernelci-Report-Type: boot
Subject: pm/testing boot: 26 boots: 1 failed,
 25 passed (v5.7-rc6-60-g478d8912f6a3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 26 boots: 1 failed, 25 passed (v5.7-rc6-60-g478d8912f6a3)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.7-rc6-60-g478d8912f6a3/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
7-rc6-60-g478d8912f6a3/

Tree: pm
Branch: testing
Git Describe: v5.7-rc6-60-g478d8912f6a3
Git Commit: 478d8912f6a348713e0a6f7707e2a1874890a7ae
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 26 unique boards, 12 SoC families, 3 builds out of 6

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8537F198834
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 01:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgC3XZG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 19:25:06 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:43970 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3XZF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 19:25:05 -0400
Received: by mail-pf1-f177.google.com with SMTP id f206so9378170pfa.10
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2020 16:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=TnTvBrGQCUhjm/3P4N8qpjOJ085ipPIbOIcVpl89/IY=;
        b=tf2uS/9BrcM5GeFi8oCmOV+pL5/IHgKPXQUbLymSLLnmcwu59gPiajPiBhYvOweUwC
         Cd7bUc2PevYHizKC1F+GHOVmiJmk2CrwL78C2KcGp3bM1wTOf5Auk/lmIyI3B59xW7D3
         FmSooRBwZoYQ8WiQEvynqeaXyXJ06+gA2w0XZTN5xqg3N7dHDgTahHo6+6KRdZgclmpq
         l+hwwLMZAwWpCMZk6lry6vSBpq2Logn5vFq5qji8aRCAjG2FoDu+fQz752C9sdfvPMgl
         PL4s2FyeEx7JtObRtVUVWODQgXl+OMb4uzRssYpDnkefUeR9003ZliSlT/a0T1ylTPOq
         iVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=TnTvBrGQCUhjm/3P4N8qpjOJ085ipPIbOIcVpl89/IY=;
        b=HtDhQYnkDcoxFZOwTI0hWD06iagZlsC/zS4QIXDPclQxKJEC+caJ67jOcSXrz//DzT
         dSYoxUCTsZbf0bexPJyO2eLPy521SyN0ZW1nW71Y3V29S8rhoUc9TN/Kldt1zbNs1tGC
         Hje2o4WuK+jtKCrjeVGLxJh3gvkuRW/8ZxgUxJ/h6yhXRoBDnGL0HZRatCtT0hK35sVF
         RaRlWKQ92tQ6TJS126BbfkkSlAxTB6TdtpV2NxnL/y3GTD6BEWjUnoW3bJfr4pJpdy/H
         YWfIbxyzyk0FvNlLdRwxXAOGAchjfCZOv7KTxjj/YLEujDGqtdoCNOX4WgmCDRHtv+dZ
         fQ2g==
X-Gm-Message-State: AGi0PuZ81GTNUMpoADkL7TP+vs0twwtrJt/NYBlCxq7Wn95cdBOedRZ0
        r1OuWps4mrGzfN0QDcVbCfCBmg==
X-Google-Smtp-Source: APiQypIQTnC+dGLm0R5ZOqO0QCcrJFPk+NQGM+/XL0FVe1bbeZtMtII18RSiJ07ZBZYgp5W/xfPi0Q==
X-Received: by 2002:aa7:8283:: with SMTP id s3mr4277839pfm.230.1585610704471;
        Mon, 30 Mar 2020 16:25:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i6sm11009312pfe.62.2020.03.30.16.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:25:03 -0700 (PDT)
Message-ID: <5e827fcf.1c69fb81.b2b09.1706@mx.google.com>
Date:   Mon, 30 Mar 2020 16:25:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.6-141-g61fafa3ac67b
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing boot: 65 boots: 1 failed,
 64 passed (v5.6-141-g61fafa3ac67b)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 65 boots: 1 failed, 64 passed (v5.6-141-g61fafa3ac67b)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.6-141-g61fafa3ac67b/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-141-g61fafa3ac67b/

Tree: pm
Branch: testing
Git Describe: v5.6-141-g61fafa3ac67b
Git Commit: 61fafa3ac67beab5d2e0bf439da2523bd035cb0e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 57 unique boards, 15 SoC families, 3 builds out of 6

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>

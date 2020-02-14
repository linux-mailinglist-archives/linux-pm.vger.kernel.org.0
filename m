Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90BB215D2BC
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 08:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgBNHW1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 02:22:27 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:41649 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgBNHW1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 02:22:27 -0500
Received: by mail-wr1-f46.google.com with SMTP id c9so9684675wrw.8
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2020 23:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Rcu8+0wi0noOgKyHnZkEE8vWwQRe3AmgJ6bgwk+oz8w=;
        b=MIfdYLXBSwCdGltvyIMIyL6eAy4Iqfr6vOFHsconC0ynraeF8bbPnq2wz+D/V5+pax
         bw9eiEhssfe2BT/UyVR7k0NsNia8fxzrp+TgPeOxGuQ4HL/oqF8YsBjZWLmegPiuBwdu
         ZinJ/lwPPnlNf9a+q5GVj7DNqWM2u7uKrpi808CFoJFXKM5qSCvtSMJNEpDQaRcoO/ob
         4IpI6rQTrQ53bPK1YRLBeS5cXZYu7e27VrJ0UMG/gfe2Ck3xYGk6x2lKaSdHxmGgiThr
         drEMAttrQ+S8dUUTNvja4dqFLMmLCuh+BGdsyVEDFqxyOpKSFpPQ0+FHiQTBvvEuWR66
         Liew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Rcu8+0wi0noOgKyHnZkEE8vWwQRe3AmgJ6bgwk+oz8w=;
        b=gZeWUISp5ozlkeJWCLFTyasXq44OtAIoefUXUxk8P1uwSEk+8KY9JpamXKd4IuJR9E
         geHpeiyR9G4oeQ6IS5pD0k8J/68gbkguSdQ8gmiydWG2Ew5zY2va0FPDLaNzYyBbml3I
         VQV7yK/wX8Rgm46JBRWNsgNs4LWaPTCN4Un2hLAjRNLKVISk5UVoOmcv5mIQUjuC2FWJ
         VSYa0PTBBPNac+c8ozVWFHhw11BdTX12HhCkRXjOrXimawmirivjJoett4YFoGZLQxcF
         fOCNSMNqnAfsxXzFUqTzKYGRDI9rmo0cqTMpR9HvBhxRSc0OYEzyQjfL/9C/tL6cxLUq
         VlGw==
X-Gm-Message-State: APjAAAWWgPJnc6EyNScTiyMGcIW3EK7it3VL4N8DuiTnyExdin7Dnz/X
        REAgcCPurJrzc7cQFgBJHjGqUQ==
X-Google-Smtp-Source: APXvYqwM/DcpdjYAHvwDAqIHPNXf2rxpM5q97La8R1CSqxdYuZK+OaLxCq9UJrayAJOBq51OCHYY5Q==
X-Received: by 2002:a5d:61c2:: with SMTP id q2mr2200533wrv.425.1581664946114;
        Thu, 13 Feb 2020 23:22:26 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id q10sm6147597wme.16.2020.02.13.23.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 23:22:25 -0800 (PST)
Message-ID: <5e464ab1.1c69fb81.1ca64.9b05@mx.google.com>
Date:   Thu, 13 Feb 2020 23:22:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc1-10-g55fe2ef33c65
Subject: pm/testing boot: 28 boots: 1 failed,
 27 passed (v5.6-rc1-10-g55fe2ef33c65)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 28 boots: 1 failed, 27 passed (v5.6-rc1-10-g55fe2ef33c65)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.6-rc1-10-g55fe2ef33c65/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc1-10-g55fe2ef33c65/

Tree: pm
Branch: testing
Git Describe: v5.6-rc1-10-g55fe2ef33c65
Git Commit: 55fe2ef33c658a1c0922ca161b136bb7171ac084
Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 24 unique boards, 11 SoC families, 1 build out of 4

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>

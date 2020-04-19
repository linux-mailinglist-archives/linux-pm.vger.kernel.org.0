Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACE31AFD58
	for <lists+linux-pm@lfdr.de>; Sun, 19 Apr 2020 21:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDSTVV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 15:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgDSTVU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 15:21:20 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93E4C061A0C
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2020 12:21:20 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id p8so3949570pgi.5
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2020 12:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=5icAZzCqR705DPcn6Mv3fNGjB7LE5Wbv6HgkCAKoq0s=;
        b=GV+WsHK59hFaewGES+i9weyzM5gvqOgoE+2wj2/k+tp5q27Ri/G4lVLy+4/aSeFU0i
         iBvq4OOPK58Keg/yxjNm5T5kXdnLeYB91T9MGlCVEDHn7NkMSe9FUN8XSSdoK+COrIYX
         j+kUZEGHYz0ro7QMQwFPZjs50QwoOkX4Oz/2UAQq76LbP8SK1G+pigVa/cQALsJxCb6n
         hNRDR+fyQWjM1rSLRRb3uE1Vnz1UPWZHRlcBNoyj9QSqu5Vyy3KVRS3tQpDhnMILZWnH
         ejjEsUytfu1pgosUNcOY6v3UqyP+f7S/c145vXdwpnZkYSnZAURqjqB7W3FRSJSI+eIY
         zhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=5icAZzCqR705DPcn6Mv3fNGjB7LE5Wbv6HgkCAKoq0s=;
        b=We7+RLAwl+Jc4bVKGMOhlqUOqtqazYlmQ0QKIP7K72ujpdiYlXzXbolaK4KDpvIcSu
         rc/25RzdZnZLCjvm+gdjsuNcSViM8AdqL9zTseMgtNxIzQsD2NHwjM4ZDJYNcRj4Ugjt
         OIYUSX3kCvQdjk1pBjwkP2wtcXB29lDAEevXdjRLGJyyhICIRNAMPL4sTrI7PJhxZ7wI
         jKr8Ii5t5bKBwTzDWGxhZGcWHMlo3uqpUTLBcbyLSXqMOwyrBSS+uSD2Q3DeuWYYelCM
         HK2XjNhvmlT2eRZrdGsxcUxEYWTfACdE2R0DzlQc5hpkExTs21jm2t3zYTaaLnDho+8e
         WzHA==
X-Gm-Message-State: AGi0PuYUlkZbf7rv0sTnEXPLGeHxE1n672pcMquJwB7cSEOdsBWv6kol
        Q0FpAm0gwMNua+xDg2hJkKEIsP0D0R8=
X-Google-Smtp-Source: APiQypL5EtF06NewKui03v2jcYRUIg9uC+7mtEObRYrVa4/grNcF7bOcYB4fryNsfM8KUsTYJPYOEg==
X-Received: by 2002:a62:ea06:: with SMTP id t6mr13489768pfh.298.1587324079977;
        Sun, 19 Apr 2020 12:21:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c125sm25144209pfa.142.2020.04.19.12.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:21:19 -0700 (PDT)
Message-ID: <5e9ca4af.1c69fb81.fd610.aa6e@mx.google.com>
Date:   Sun, 19 Apr 2020 12:21:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pm-5.7-rc2-184-gc087b3aec013
Subject: pm/testing boot: 21 boots: 1 failed,
 20 passed (pm-5.7-rc2-184-gc087b3aec013)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 21 boots: 1 failed, 20 passed (pm-5.7-rc2-184-gc087b3aec01=
3)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/pm-5.7-rc2-184-gc087b3aec013/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
5.7-rc2-184-gc087b3aec013/

Tree: pm
Branch: testing
Git Describe: pm-5.7-rc2-184-gc087b3aec013
Git Commit: c087b3aec013062ef1d49510b70112a33daabb54
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 21 unique boards, 10 SoC families, 3 builds out of 6

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>

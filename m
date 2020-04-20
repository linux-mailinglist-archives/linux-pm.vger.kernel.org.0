Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B78A1B06CD
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 12:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgDTKoW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 06:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbgDTKoV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 06:44:21 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8BCC061A0C
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2020 03:44:21 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y25so4748442pfn.5
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2020 03:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=KBFH1OXrJpN9o+qmgYsi6ZWjVcpKB7Ul6in3uy673z8=;
        b=akWTHy2jLM880CsJBjDBsl/wu3vP55XUrnud7iPQMxDSAHH85K3YXjhJLbTxavJbGt
         ZBpE0uR0hbQYqsvqAwlqIN0STtMN7eomXV7LewCEqQmQ5GCqd88qF1N63nv5U7ceOdLc
         XtXKz69TqacrqcH0g68w8+QTUHSBC309EDlBJTxzZcmqvkvY8mTMAHXTA2CChMBmVf97
         vmL0vhlz/nHAxmFAdd3iFsFamvUuV9qPEjltJ1PaAnb7pkf9ZTzpoX+jStmmAyHn2lWV
         Vq/FRXUxSd+9f9VUUpSRE3z/rRQs5Qytrk43yCaUPcMAiTQ6Ipf87y2BQ/9lFzBrv0y4
         QvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=KBFH1OXrJpN9o+qmgYsi6ZWjVcpKB7Ul6in3uy673z8=;
        b=GU16TcSGkpouL4WJN7GeEHeS0W5NDNFr5XGtXznOYhiKzL7BBnhme/epE8zs5b/XZK
         29BYYjpcKOFQ6ZxPZ5AGdhlT8KxEjhgwYQRqq9itXP4jvQJWRXQPWHXeh/xZq/4jsyG/
         Ze3PqlFBhgR7gJDd1HUZyN4A9nGTQH2WfTcf+1G7x3B5dYtqjCzkltbXruIymRv93efn
         qIxBj8jQyd45/XQ4Jy/LhW0EvY9xHgoJ9hppSjyu9xzZy4dj8jPdGYZL6g0Yb8MakAsz
         ZgktoTUpDdBJLpEnkZpTUJanQ51KHPVNZavS16ub3KSJUU6pF3tPUqyRQO2TeipKrRy9
         ishg==
X-Gm-Message-State: AGi0Pubwz/AtygcdqOuGtgkiJJOqYKwjRPhN8aNcUImgEymqYGWWQ1vF
        R07C13IK++t+TgLz95bX4BiR5ojiY9c=
X-Google-Smtp-Source: APiQypI38GmMOBo2VA3Pa5l4cQg8UjEjwMMc+InX3RCR5hU4dFv8SWv+pRHM4kmasIIrxOX1kk2gCQ==
X-Received: by 2002:a63:5642:: with SMTP id g2mr16467853pgm.211.1587379461204;
        Mon, 20 Apr 2020 03:44:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l15sm830916pgk.59.2020.04.20.03.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 03:44:20 -0700 (PDT)
Message-ID: <5e9d7d04.1c69fb81.9bcbf.1eff@mx.google.com>
Date:   Mon, 20 Apr 2020 03:44:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc2-16-g247f4817f956
Subject: pm/testing boot: 19 boots: 1 failed,
 18 passed (v5.7-rc2-16-g247f4817f956)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 19 boots: 1 failed, 18 passed (v5.7-rc2-16-g247f4817f956)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.7-rc2-16-g247f4817f956/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
7-rc2-16-g247f4817f956/

Tree: pm
Branch: testing
Git Describe: v5.7-rc2-16-g247f4817f956
Git Commit: 247f4817f95659c2102343dedb580362ae60eb86
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 19 unique boards, 9 SoC families, 3 builds out of 6

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>

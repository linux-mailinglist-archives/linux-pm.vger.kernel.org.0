Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35BD1E8A71
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 23:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgE2Vut (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 17:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgE2Vuq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 17:50:46 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55879C03E969
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2020 14:50:46 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y11so1742613plt.12
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2020 14:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=BRvw/AXEymunTjPsHk5e4vOqn0h3iaA1JVFt/eFWVE4=;
        b=hc4TwddH5zk62BCyuhgigANB/8DjcJULi9XcPFySB60LTloEV8uu6WNnucFoa85EpE
         EJAB3SRjJHNPIcmtzSxOf7KI4z7ppHL++bISYiPuZ/DBJ0Ip0tQaaowH1I+RRYTa/PUS
         9/aNmbOPT8YD55S85ftlMVCnFjtS7M2+7Bx4WOlkNtMnZnqiJhGpkipOKY3VC5Lz7Pw0
         soB0tHYn4PO45UF1t8WgJhQNuCzjm0MoGHa1BFmx5UziMx2kjFrrtHKV5FYVlctemLrf
         HaWGTQJu2Y04+ntfuh2Bb3U9eOuZs9pDXUUYq4K9p9UUJzD/5miJUVcbilliQoABX9V5
         l0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=BRvw/AXEymunTjPsHk5e4vOqn0h3iaA1JVFt/eFWVE4=;
        b=PvldFUaqFZ03W0h5mrf3L7g2yfdjNb/Thj0y2MuKtRVUIKcPdXEBmLx8KbCqtp2jil
         Yqs1Hf9VI2X9l8ZG1iihJPgXSo9853u+8zgIHKz+RzZWyyVzpZowmY7ew6rYiiUBTyK8
         EwX/c5S3CxTgQjyXtOiabkvGYQvoO3Cm42MKycjEIJjPxMlsVlI+XESmseZx/nwrDaKe
         k7kazDNAh7QzkbUCYqTM5iTz9HLa8/ELVl+lXAyKVLk1ExGb+R7q7x4Jpgh2I+LyCZvB
         /zHqeWxr7Zf2DP1hB1J62R7S7zUBkA+WHh+wihcRwTDN1S/RyVRJI/dzFKLFyTGAKU95
         274g==
X-Gm-Message-State: AOAM531B+6f7s319t3iDg+bQ3Nyo9CDlthTMLDBE8zfE+Hl8FeSdki5O
        G9MVRynf1sL5lJlIk6q4TJrr3g==
X-Google-Smtp-Source: ABdhPJy9+pr6pUxw7odV+HR9pxX6nanY0b/pMD6IuAPGyoNt+BIJAROYOkolh2+34dQoALfJHizA8g==
X-Received: by 2002:a17:90a:10c1:: with SMTP id b1mr11189672pje.232.1590789045883;
        Fri, 29 May 2020 14:50:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e5sm7834373pfe.121.2020.05.29.14.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 14:50:45 -0700 (PDT)
Message-ID: <5ed183b5.1c69fb81.d92db.b4ed@mx.google.com>
Date:   Fri, 29 May 2020 14:50:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v5.7-rc7-109-g1a09809dda81
Subject: pm/testing boot: 27 boots: 0 failed,
 27 passed (v5.7-rc7-109-g1a09809dda81)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

******************************************
* WARNING: Boot tests are now deprecated *
******************************************

As kernelci.org is expanding its functional testing capabilities, the conce=
pt
of boot testing is now deprecated.  Boot results are scheduled to be droppe=
d on
*5th June 2020*.  The full schedule for boot tests deprecation is available=
 on
this GitHub issue: https://github.com/kernelci/kernelci-backend/issues/238

The new equivalent is the *baseline* test suite which also runs sanity chec=
ks
using dmesg and bootrr: https://github.com/kernelci/bootrr

See the *baseline results for this kernel revision* on this page:
https://kernelci.org/test/job/pm/branch/testing/kernel/v5.7-rc7-109-g1a0980=
9dda81/plan/baseline/

---------------------------------------------------------------------------=
----

pm/testing boot: 27 boots: 0 failed, 27 passed (v5.7-rc7-109-g1a09809dda81)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.7-rc7-109-g1a09809dda81/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
7-rc7-109-g1a09809dda81/

Tree: pm
Branch: testing
Git Describe: v5.7-rc7-109-g1a09809dda81
Git Commit: 1a09809dda810120fadcc35d96872d9fd5ceb00c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 23 unique boards, 6 SoC families, 2 builds out of 4

---
For more info write to <info@kernelci.org>

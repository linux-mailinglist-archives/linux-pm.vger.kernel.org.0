Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3110189AE5
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 12:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgCRLn0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 07:43:26 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:38359 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRLn0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2020 07:43:26 -0400
Received: by mail-pg1-f178.google.com with SMTP id x7so13544202pgh.5
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2020 04:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=U84e4UOrgcVean29lMfv4/bbLeH6pd5tEHvZ+cvGo34=;
        b=VTEfJOVDkzdOhs0FwoYMeaZuTTDsAFv17tLfsZ7WlVdrZ9TEnW2yZjOzQtSYnf2tWF
         jiPxvYQH3OXXKT9joH4sosRwGnEG7V1mXFS2YzVhnXMflWFWGKVHgVcAOIhfOMSuUyzz
         gFdI1bFvZ7PUMN7EEo67li4cnSzoBIWu6316BPXQ/WuzPC+1aXwQPc9vwHDN3QtbYvQf
         iv49hx84NxbsLxb0l/EEq35mFJ86VgVOqQ7yF49VqLm6erKw8cUhtpUjBiplsosiVhQp
         HXv+jv4fKjOk/0Kw68x+nNbXwhMYSwONAoJcXvgKf72nWpd5jrwRXGld2dZfTUWx+NoB
         Ci+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=U84e4UOrgcVean29lMfv4/bbLeH6pd5tEHvZ+cvGo34=;
        b=gkF/pHdrxQFBSydEIgQdRU3K2+sgV6o6iMuBPpcee1tRY7nO23Ppv1295SBSu8vIRQ
         FZ+TL5co+u9zp8LZpDp0JCPQx7PRDkVBLfy6IwenksNysuxLQPpx5AsQMl+dzO6OVA+5
         TTf2CsafGuBlw+NYjD1hY1CBhPnU1HE98ufil6x3W99eY3zFH3w1NQOr7YnzGVSxtlZC
         tK0GY6Ar8wOA9sPDpw3nPozf/mmXVSVoxhUthBRoWmBWo3XS+AEdDQ8zEgLT2urxq8m8
         XjV22HIItjRF4ffA1Ryv8j3Vi/ExHRZsoOMdkrZmG5c1wRE1mOMDvo1NFuInwM8ZlzOt
         A55Q==
X-Gm-Message-State: ANhLgQ08bGE8rokh05N/0BGcwwTmBEul60HCc/PoqoEynd70Q71owwoe
        XHZ4MW7IJLbXBJmoLcVzN1l+fA==
X-Google-Smtp-Source: ADFU+vs2aFk7gKK9Qz9rI1WoNvpNsKWQqeo35MWHsKTcJmZLkhG8fm2sS7IFli5dZ7e1QPUMKXmy2g==
X-Received: by 2002:a63:f447:: with SMTP id p7mr4199592pgk.326.1584531805411;
        Wed, 18 Mar 2020 04:43:25 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i2sm6345112pfr.151.2020.03.18.04.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 04:43:24 -0700 (PDT)
Message-ID: <5e72095c.1c69fb81.a5057.61d2@mx.google.com>
Date:   Wed, 18 Mar 2020 04:43:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc6-102-gc03d064a440c
X-Kernelci-Report-Type: boot
Subject: pm/testing boot: 59 boots: 1 failed,
 57 passed with 1 untried/unknown (v5.6-rc6-102-gc03d064a440c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 59 boots: 1 failed, 57 passed with 1 untried/unknown (v5.6=
-rc6-102-gc03d064a440c)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.6-rc6-102-gc03d064a440c/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc6-102-gc03d064a440c/

Tree: pm
Branch: testing
Git Describe: v5.6-rc6-102-gc03d064a440c
Git Commit: c03d064a440c2a5cbe3da782db05d3e18dc5ec3e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 56 unique boards, 14 SoC families, 3 builds out of 6

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-8:
          meson-g12b-a311d-khadas-vim3:
              lab-baylibre: new failure (last pass: v5.6-rc6-99-g4a13723c32=
5c)

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>

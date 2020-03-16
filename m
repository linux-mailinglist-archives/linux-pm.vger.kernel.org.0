Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B68D4186C10
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 14:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbgCPNaq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 09:30:46 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:41082 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731193AbgCPNaq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2020 09:30:46 -0400
Received: by mail-pf1-f177.google.com with SMTP id z65so9928650pfz.8
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2020 06:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gGa87oNn/iWn7AelT0+st4JUfc9eV/HK3yAekv3ikj0=;
        b=jAGVWhSfjn0cR3K7M7DpiPc6BQSClsQXF+5EkDj+7EDduBUxd9BRftapwTHlCiwIxy
         +4xpjhwQ5TVS11aq0NcRYxU287YHByhhcebV1MCQQlBHs7hpSMfRbn16OirxJOZKbOvI
         INhaqPoPwYtambr6Tv2ipTpO8/U69kIWgVMnW+KhDoUkpjbL3zPbwpx+uCbNHt+8Fncb
         F8Yt+RDVIpmX5ywIjwPnHo59ACz+U6+K/TNzuv9m8YS8gzokkmF2q5es+nbAQGdriUJP
         9egkYuNu5XgE/ZRMdlhDGbLZmo/YUd/ZNGh3RizN/xe1Yio9lXMxZepKpj9AVYAkvgp+
         5Ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gGa87oNn/iWn7AelT0+st4JUfc9eV/HK3yAekv3ikj0=;
        b=Qjy3WMnqP3BNj8j8ooqoMRZp3mdYtutHRFo9ywLELD3F74RRfwh15i6BlXOgJwKoI+
         E4FT+IKzTFSfHIFrSIXcJUbkoym3qycdnA85MvFpIOG1E2u/supIgCfq1Ipu/j78mWeq
         wRq1EoubLcYPCUhu3u4ndD+1QV7dfjbLOzPkQeSa5cLpO9pGbPhYL16t21e6NElCGfrz
         BHk9KaVVKRXGBdTS8a7U7+9T83FiJv1DeHUx06rsgQ7O0/sT1YY1dkgL55vLWNNguMor
         nYTrCn06R+fpGGwBFwqMr3O7vkxK5rhW3xXgmnmIQ0PLeCDm/Yrxo/NknbRi4T6hS0Ok
         1ifA==
X-Gm-Message-State: ANhLgQ0ix1asmtbHUBI2A+Mq3WRpK9ydYK6vY7KjAmTZc/DYOlbLTzfG
        1hZdI/nlE5Wd/sZpQt5G4ASY+g==
X-Google-Smtp-Source: ADFU+vsRAEgr3vIsSiUupA3snCKV9UgvQpRXzEMWfjRla4tU1lJXPhWZqJIq409R2bqUcv+6oFP8iQ==
X-Received: by 2002:a63:ee02:: with SMTP id e2mr26268787pgi.183.1584365444723;
        Mon, 16 Mar 2020 06:30:44 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i4sm14228pfq.82.2020.03.16.06.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 06:30:43 -0700 (PDT)
Message-ID: <5e6f7f83.1c69fb81.87fc.00cd@mx.google.com>
Date:   Mon, 16 Mar 2020 06:30:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc6-99-g90f425b95754
X-Kernelci-Report-Type: boot
Subject: pm/testing boot: 62 boots: 1 failed,
 60 passed with 1 untried/unknown (v5.6-rc6-99-g90f425b95754)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 62 boots: 1 failed, 60 passed with 1 untried/unknown (v5.6=
-rc6-99-g90f425b95754)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.6-rc6-99-g90f425b95754/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc6-99-g90f425b95754/

Tree: pm
Branch: testing
Git Describe: v5.6-rc6-99-g90f425b95754
Git Commit: 90f425b95754aa7c6e93f239ae73e7d250a58e98
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 54 unique boards, 13 SoC families, 3 builds out of 6

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-8:
          meson-gxbb-p200:
              lab-baylibre: new failure (last pass: v5.6-rc4-56-gf99f4dfcc7=
da)

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>

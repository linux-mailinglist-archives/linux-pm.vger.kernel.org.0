Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD4F188ED8
	for <lists+linux-pm@lfdr.de>; Tue, 17 Mar 2020 21:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgCQUTW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Mar 2020 16:19:22 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:34301 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQUTW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2020 16:19:22 -0400
Received: by mail-pj1-f54.google.com with SMTP id q16so274222pje.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2020 13:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=XrKAAJJIb6DM0ea3T/bXana50sRBWWKUVXZelL27caQ=;
        b=lNeUT8QbkF83xENXHrWavQ9XTE+LF1XD8LsgTS2NoH8rkgPs22A0sBFvDPxqmBlGfb
         9rfDxWCRey2XrNrwG5n8HfBEmavHY+v3tvgqrdvtJs0Y4iLhNmUF4HaZ6ZfWSlGjhg3G
         nX7IKu6FkvMJqlrKc6NKNidkvN8AKcgitOIw3m7z7jImx3/caCTWmCNiAG8n/YcRin15
         4YQ0tVqwZ3vOtOUx7uZgbOy1PU6sxQ/ryYrpQIIiyjqi593+Mdup20W+ZYqy5u/q/H/Z
         J66qOsywWPcSbSEOC+8Anletue1ftcBeNrwMA9T0I8ziViuRqDDZ9oJoqqL9PlllhzCp
         e8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=XrKAAJJIb6DM0ea3T/bXana50sRBWWKUVXZelL27caQ=;
        b=BdLcgS0wFgzRfvIySnVyqp32TT/BDTJ0CIRI4hFgzfyZDwRoLpmri6wLSbyXK986kJ
         79Iy3/ZhRzUYci3mKZE/OH3zWII/8s243fgbl4rVnVSv0bW/tgDg+/6paQvibe37ierI
         u+Ycn1fq1QIrsb8tHUYZe32Jls4e1bgD983ZIXtd/lTxeuGmL5EbyxLLWowuuygOGJ3s
         Cd+qGqceBJ/M/NUE5CPHPh1sB4G3N11IpPmHfY2t4UcW/pQrpJVWXx/lyOJEkAx5izVJ
         Ej5wLoONv/pRIcDB4GqEDMIOZNe3rmSgHhsQNjm675LnWFJW/75wApCUMChyB+QOq6Pa
         0w6g==
X-Gm-Message-State: ANhLgQ0IEeOKFQ1DMFYCDboScEUupk8zU/jguzQUbP5MQGRRtZXkbu6Z
        17UdkEJZCT/V405ejPuDed/DjW8H8KI=
X-Google-Smtp-Source: ADFU+vvfB0QL9B5auJbUMHRgvS4RD7kPCYNP7T61bN7RQdpnO8tQRu5cAkf++9CyqC7KTPDYvlBxUA==
X-Received: by 2002:a17:90b:307:: with SMTP id ay7mr984263pjb.123.1584476361404;
        Tue, 17 Mar 2020 13:19:21 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z12sm4357623pfj.144.2020.03.17.13.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 13:19:20 -0700 (PDT)
Message-ID: <5e7130c8.1c69fb81.1fb04.f47e@mx.google.com>
Date:   Tue, 17 Mar 2020 13:19:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc6-99-g4a13723c325c
X-Kernelci-Report-Type: boot
Subject: pm/testing boot: 63 boots: 1 failed,
 62 passed (v5.6-rc6-99-g4a13723c325c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 63 boots: 1 failed, 62 passed (v5.6-rc6-99-g4a13723c325c)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.6-rc6-99-g4a13723c325c/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc6-99-g4a13723c325c/

Tree: pm
Branch: testing
Git Describe: v5.6-rc6-99-g4a13723c325c
Git Commit: 4a13723c325ce2b444bec3aa5836854cc1f48390
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 55 unique boards, 14 SoC families, 3 builds out of 6

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>

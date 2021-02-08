Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18824312A77
	for <lists+linux-pm@lfdr.de>; Mon,  8 Feb 2021 07:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhBHGHT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Feb 2021 01:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBHGHN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2021 01:07:13 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4CEC061793
        for <linux-pm@vger.kernel.org>; Sun,  7 Feb 2021 22:06:18 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id k13so2556904pfh.13
        for <linux-pm@vger.kernel.org>; Sun, 07 Feb 2021 22:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Tlt0KYtqA+Hr03xQ/isU/faVPTM5pqVbpY2dvJsj1+Q=;
        b=k141nhWPND0piT7Rh94UFx3FeE1DhHq14fUlWvR6jISynDPdW0pUtB0UbMMIeM+Y2F
         ABuweKJgHzjGkW1sF5Zdxu1lcksa8LtC1AixqRH1Cmgxk9pnQ9vTJNaPFqbSGpPQfIQd
         s3saf5bni2UksiIkEOVw5q8LmIqvzJJAzZp+pfW1bgN8CoEJFI+Pv8/00VGL2Tkm92oB
         baWCJeVSSDArxOox9Dej/IuiL+g/Eis83oJwgUyiSAV5AANiVCHHSmEVGJcrsVsm+MGD
         7LCpbdmYKKZJlCVl+geaFbaCY4eBKRdgH8i1GehHuqgParTkuRWGoBqfr6fheF43oHMI
         joyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Tlt0KYtqA+Hr03xQ/isU/faVPTM5pqVbpY2dvJsj1+Q=;
        b=tw+b/C71jGX7OKdFBFEkWexLatkUm5FCcF6MdbOydlJjTh8tj2WVQJ/5ltdtGMB+6j
         wNA/q/3bSSppbvz3vG14Tk7bYyCZKHPF+eHnF2c/m1eW4TJ9IQRBMRWzElD4fFLsY3Da
         WRYe8tTz6LcI5w0WxXmFB5eM1nmx/BVnDEWicCXwKCLuv6kFTGLmDPs8kX2bjBjVZEpX
         f2N0XA9L5angssai0o07tB5CaEjyKuB1jAzrJ2Teg6HaE+h3TDikd5caBUXFMkINKBTs
         m02e84u3slnxzhW+f3BjsQSzPqMzrgVTkA7elmc2fbLy8CwKhBSJiSLcCqXeNqm1NNWk
         /mtA==
X-Gm-Message-State: AOAM530lJFScvYg6EwaKk0oOJTsVBr4QA343w1CyP6gMwnKWUAw5nF2T
        IzLcykulu0kw9DGnjNMkA9o9fw==
X-Google-Smtp-Source: ABdhPJySYy/6INpXgzhqp5iu9WWvzLC7FXFy2v+g0BbdC16OEkpzo/akdq6mshkVQerMXpHervKnOQ==
X-Received: by 2002:a63:7f09:: with SMTP id a9mr15385309pgd.63.1612764377712;
        Sun, 07 Feb 2021 22:06:17 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id p7sm16091648pfn.52.2021.02.07.22.06.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Feb 2021 22:06:16 -0800 (PST)
Date:   Mon, 8 Feb 2021 11:36:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 5.12
Message-ID: <20210208060614.krjwvatrp6wxxxkp@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5lk7veuvwpxdtxdk"
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5lk7veuvwpxdtxdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

This pull request contains following changes:

- Removal of Tango driver as the platform got removed (Arnd Bergmann).

- Use resource managed APIs for tegra20 (Dmitry Osipenko).

- Generic cleanups for brcmstb (Christophe JAILLET).

- Enable boost support for qcom-hw (Shawn Guo).
=20
-------------------------8<-------------------------

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/=
linux-next

for you to fetch changes up to 7114ebffd330bfc5a95b9832a70b6bd857d26fd8:

  cpufreq: remove tango driver (2021-01-21 09:34:46 +0530)

----------------------------------------------------------------
Arnd Bergmann (1):
      cpufreq: remove tango driver

Christophe JAILLET (2):
      cpufreq: brcmstb-avs-cpufreq: Free resources in error path
      cpufreq: brcmstb-avs-cpufreq: Fix resource leaks in ->remove()

Dmitry Osipenko (1):
      cpufreq: tegra20: Use resource-managed API

Shawn Guo (1):
      cpufreq: qcom-hw: enable boost support

 drivers/cpufreq/Kconfig.arm           |  5 ----
 drivers/cpufreq/Makefile              |  1 -
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 24 +++++++++++++------
 drivers/cpufreq/cpufreq-dt-platdev.c  |  2 --
 drivers/cpufreq/qcom-cpufreq-hw.c     |  6 +++++
 drivers/cpufreq/tango-cpufreq.c       | 38 -----------------------------
 drivers/cpufreq/tegra20-cpufreq.c     | 45 +++++++++++++++++--------------=
----
 7 files changed, 45 insertions(+), 76 deletions(-)
 delete mode 100644 drivers/cpufreq/tango-cpufreq.c

--=20
viresh

--5lk7veuvwpxdtxdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJgINTWAAoJENK5HDyugRIcAycP/RvH0NPOFedux40XKytVyPyf
0WbAItQIT6p4pMvI4sswtGa9eu2vvCDEJj6rX2d4aB+XNzRvXtsM+Lj2gxE+3xBS
bf8ZXTFlv9pQcFUgOI3cz3+vsOTF0q4SqvwNR9f69WDkT9nVCnnp6vKyv7vvwor3
pxIO2EDH4T8Z+aBbilXp7mbl5U0EKsxkG3QUAKuuWgwt5jk7Q9z5vgIKNpYlGKa3
mzeCgzWGm4MRaaIt0scadqLFXYmuMHcu3dqE7ZKNJOK05MBsOeefSSa4ix1aa6QV
JEdj2bcgZYtf0yBpKgLzqXmSxQn69Hv+QEgxYbmSPndRV2wtzqs5LdyQa7UwCKSh
e216edXaRs0rjq643zQX1w2+k8RsWdGloV5XHUxf5ofWxk7hKmZn6x3kB9/HVtlx
Ln74T3ljjL4aEZ0vpF+f+7Bl846a8q8YM5ub2qQTc4lt8FC3axbxLCbPSEdndBpm
pqnOSGsKDO3xKMZIYeMmjCeYunsvv8P2i5MlLH+3+8Hl4kpwCJhE6LirIqwCafpd
aNd8Jr3gNijp7jOsbv7B8hAaHqRTZk7AUIaYP6fiT4S++o40VRPJloDfR3Qe5L8Y
9jRGdUW+vZHRJiTseC1NmpEUgsBJz4mYu19gt5a7u2j6MQ7dOranq0EnUs8KHcpL
R6dRPn6gA5X0zrQUwdcC
=s8aw
-----END PGP SIGNATURE-----

--5lk7veuvwpxdtxdk--

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B130B312A59
	for <lists+linux-pm@lfdr.de>; Mon,  8 Feb 2021 07:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhBHGBR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Feb 2021 01:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhBHGBL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2021 01:01:11 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B6FC06174A
        for <linux-pm@vger.kernel.org>; Sun,  7 Feb 2021 22:00:31 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cv23so224833pjb.5
        for <linux-pm@vger.kernel.org>; Sun, 07 Feb 2021 22:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/c7Iv0cjmCSSrPnUhUKaznddxtbBnlBBgmij3981uEo=;
        b=qayu2BPFcmW8/cZ13BCbBwC1RghiQdspWFIubREBAC7Mw7eDleAt0l5/gA1iW1+IP0
         rNd+fueqnmmTts7eCPvz37Q/oT6u8HDs0czKFrZx9W4MGuU3NVYux4F3jfIGu+1E8TQb
         hxkiuin4N87gN0MNQpjwScSObIdmAokRvQ+/eAiPUulLqgZ0VoVWfLRZp87lquoPn6R8
         u2mMXvUs45PoxYI36++OxudCiJk8G5xM+1+DFHpvJ+qJ+humPpa3ncKUouXjLEXCko23
         OuTKErxVlf9dClZbkGed9Sv4Q9vm9GznqeJtwwt6mGaOOAFklWhvXUpb/M1GjactDYeu
         4rJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/c7Iv0cjmCSSrPnUhUKaznddxtbBnlBBgmij3981uEo=;
        b=QBZm8v1TK0g4NOdH1QsYHaf9C+IhaBt+ASZ0ntK+TOyMtrlVKaVGcJL1AGeAQzKWns
         FkekBSJRhGsMwvTq8qde/tz9gjvuyoe8B6OojBvE/nrkTfZ8jCNnv8uWZZuz+oOA61Ov
         V0SqACA5qEm2q6A8kmzhPmF0OreyVYiASCHM3zbvC3s3x+qx9kUfKtO4Lxi0gZx4x3oI
         X9pCf1GWrlQDAoK6vqBd2wbJeQoKTFjaKQv2Qy+I05f/Ldg8jBDocI8ccgAH7DoNHuW3
         5EC927qqrXK+nJ1vhwSR9FDh0/ghT0lSkGVEu+ONeooui9synk7TDlWRcR0ftqQKW/ys
         8hBA==
X-Gm-Message-State: AOAM532a/W6sQ+PYclTOkvVGmIfS0i+x+Eqzey6JAZ4ibHdvFV8zPiAU
        14tf2Wffb1K5vDtbz9Oeq9QgnA==
X-Google-Smtp-Source: ABdhPJylc7/sgoMomJ7u1DSFma7zuVU31xXAixY/udaZjMGv1fe86vr0yGwxGbuP+fEIDl327zK8Ig==
X-Received: by 2002:a17:90a:fe92:: with SMTP id co18mr13721846pjb.146.1612764030976;
        Sun, 07 Feb 2021 22:00:30 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id w9sm6890341pfc.51.2021.02.07.22.00.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Feb 2021 22:00:29 -0800 (PST)
Date:   Mon, 8 Feb 2021 11:30:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 5.12
Message-ID: <20210208060027.kzqxscpceb7l6656@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rm5mzonogh57oycu"
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rm5mzonogh57oycu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

This pull request contains following changes:

- Generic cleanups across the OPP core (Dmitry Osipenko, Viresh
  Kumar).

- New OPP helpers dev_pm_opp_find_level_ceil(),
  dev_pm_opp_get_required_pstate(), dev_pm_opp_sync_regulators(),
  devm_pm_opp_register_set_opp_helper(),
  dev_pm_opp_of_add_table_noclk() and devm_pm_opp_attach_genpd()
  (Dmitry Osipenko, Viresh Kumar).

- Allow required OPPs to be used for devfreq devices and related
  changes to devfreq governor (Saravana Kannan).

- Significant code changes to allow a new OPP helper,
  dev_pm_opp_set_opp() (Viresh Kumar).

- Remove dev_pm_opp_set_bw() and update related drivers (Viresh
  Kumar).

- Allow lazy linking of required-OPPs (Viresh Kumar).
=20
-------------------------8<-------------------------

The following changes since commit 1048ba83fb1c00cd24172e23e8263972f6b5d9ac:

  Linux 5.11-rc6 (2021-01-31 13:50:09 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-ne=
xt

for you to fetch changes up to 86ad9a24f21ea7aac7deed06fe9556392568d88a:

  PM / devfreq: Add required OPPs support to passive governor (2021-02-04 1=
6:48:16 +0530)

----------------------------------------------------------------
Dmitry Osipenko (11):
      opp: Fix adding OPP entries in a wrong order if rate is unavailable
      opp: Filter out OPPs based on availability of a required-OPP
      opp: Correct debug message in _opp_add_static_v2()
      opp: Add dev_pm_opp_find_level_ceil()
      opp: Add dev_pm_opp_get_required_pstate()
      opp: Add dev_pm_opp_sync_regulators()
      opp: Add devm_pm_opp_register_set_opp_helper
      opp: Add devm_pm_opp_attach_genpd
      opp: Handle missing OPP table in dev_pm_opp_xlate_performance_state()
      opp: Print OPP level in debug message of _opp_add_static_v2()
      opp: Make _set_opp_custom() work without regulators

Saravana Kannan (3):
      OPP: Add function to look up required OPP's for a given OPP
      PM / devfreq: Cache OPP table reference in devfreq
      PM / devfreq: Add required OPPs support to passive governor

Viresh Kumar (23):
      opp: Staticize _add_opp_table()
      opp: Create _of_add_table_indexed() to reduce code duplication
      opp: Defer acquiring the clk until OPPs are added
      opp: Add dev_pm_opp_of_add_table_noclk()
      opp: Prepare for ->set_opp() helper to work without regulators
      opp: Rename _opp_set_rate_zero()
      opp: No need to check clk for errors
      opp: Keep track of currently programmed OPP
      opp: Split _set_opp() out of dev_pm_opp_set_rate()
      opp: Allow _set_opp() to work for non-freq devices
      opp: Allow _generic_set_opp_regulator() to work for non-freq devices
      opp: Allow _generic_set_opp_clk_only() to work for non-freq devices
      opp: Update parameters of  _set_opp_custom()
      opp: Implement dev_pm_opp_set_opp()
      cpufreq: qcom: Migrate to dev_pm_opp_set_opp()
      drm: msm: Migrate to dev_pm_opp_set_opp()
      devfreq: tegra30: Migrate to dev_pm_opp_set_opp()
      opp: Remove dev_pm_opp_set_bw()
      opp: Allow lazy-linking of required-opps
      opp: Update bandwidth requirements based on scaling up/down
      opp: Don't ignore clk_get() errors other than -ENOENT
      opp: Fix "foo * bar" should be "foo *bar"
      opp: Replace ENOTSUPP with EOPNOTSUPP

 drivers/cpufreq/qcom-cpufreq-hw.c     |   2 +-
 drivers/devfreq/devfreq.c             |   7 +
 drivers/devfreq/governor_passive.c    |  44 +-
 drivers/devfreq/tegra30-devfreq.c     |   4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c |   8 +-
 drivers/opp/core.c                    | 798 ++++++++++++++++++++++++------=
----
 drivers/opp/of.c                      | 230 +++++++---
 drivers/opp/opp.h                     |  17 +-
 include/linux/devfreq.h               |   2 +
 include/linux/pm_opp.h                | 112 +++--
 10 files changed, 885 insertions(+), 339 deletions(-)

--=20
viresh

--rm5mzonogh57oycu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJgINN7AAoJENK5HDyugRIclkAP/RwMFl808awDb+6m9gjcCNj8
Sy7AoaC6e98HDJcLaqSFRCAwGx4lE2roSqXzYHMvHAhCehmXi/XbBqJSUzk036+5
nEpsAg3jlTcTNfJJ1uEAJziAFgXiBMCOiVTb1Ca7Lpae4AY9nt1Q6YdFMBVNmuYQ
NZ18Uf8UBHuzVhTnaSv9Y+6836LKTBrGT/FWYxkgBeIC8GFtW6JzeVfo6XPBTG+l
JJqqB7uMEj9nwg/NAXKwiSE3lriUbVwClOPi0Nyzo1KDn7FoS9KOIUIvWku207nM
p/elf2j2LWr+IV3uwgJ9TEkAhqEDmHZnmoyennCWsp/Dfx5BSwqu9CITM0VzL/Kv
xgcVzFKKRvN5Hx9Y/rRwFIUGX/N7a2BPiWgINOJFAvjNDTotfJME6rQif68Jl0Xh
j+gLyaLr7uI+eF0PaX/Z4hgBVAxDMx8W4XIZ8DcwRLdxDl4ORJ3yBRgUriQPcP6j
C5RM1A+POPVmHFmLQVw6Ll6YXBC470mGexSlc+g9OlInDBYs2jm/Y+qiUVNGJ1AB
uzhEE82rKAL8d+ZbJn82Dq6ojkQUXkGdi+iOISma23QO/0UfBSx2TDhcwUY6zgpY
3aD/atDlbEt9V6qNv99Vky5nBFNF/5D5irL7HMn0l7yTPU/6pG9NGIQ21z4uGdPx
6JAAUaXiFf9QkOGI9gab
=mPTo
-----END PGP SIGNATURE-----

--rm5mzonogh57oycu--

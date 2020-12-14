Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F942D9736
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 12:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgLNLPh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 06:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407551AbgLNLP3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 06:15:29 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAFFC0613CF
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 03:14:49 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id l23so6416497pjg.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 03:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tfWITl/QA5or2H5VgdiE16MiDiMCOrtC1ucmtZdgjzc=;
        b=v15Jf1UX9wwm+/V6Rex6/Iw/8dtRyJL8raaR0ilA5XRKJuYhRq25/cSEmLTRxEgjyt
         lZZS2AdRTgTfDd5L6ZfnnmwcVuyUco6djfrtKXqDHH5LrfCyqPX3RkYE74kzTCcP6X+9
         F67YVIUfmBojxJSLS6FoWYWxH93DEYBfzhCkjvC2qvprdwefJGSAQyAs41gKtM7QLF7G
         hrmt6cI5Z9BbzcOjppPdNpiKTt16mEg+iOCNgYwAw8/X+wqfoTuqjPNeDIcy25pnkd9k
         ZxXyVjpCuD617W16TDyVXDqyyxDN74usYvf+HGKb6JcRqEJGi4N62EvQ9mF23Ia1sERV
         f+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tfWITl/QA5or2H5VgdiE16MiDiMCOrtC1ucmtZdgjzc=;
        b=RdfNbJW19Ej/nAKz2gO5HE3INqyzCrw1NiK9+zDlbm4GNatHA7m5BNASDaqAZevBIp
         iiwsoyWZ8qM0v7gk4KY1jmRHPPjXs8ceml8EXMBUgVf9BNB+qS91Uk0cAf3ClpEF6OtN
         VZkGUXls2DXZO2WzvMQGyfqo7++g5DAWuV49t3NXI3ZermbXCQbKXupjY8AnRklD8T6x
         7MV6s6Rj+ALNwjEd04eOJtamlVhvVES+DrdmzOEbSq7v2wJIlV4uZQaouV26YGg6FEP4
         cvxCgQx+sSOPanqf4pPx+szfH/foZFnUAgEhe+MAolUn58nHoiv1ngyf3Xoyep/7l4ri
         rxzQ==
X-Gm-Message-State: AOAM533xqTTmYMRjcfoa+qFjxdZY135fiPJgqsI4Aox+tA5WPxGG3nqP
        uS3yADXojdnYlARxIAOEScG0YQ==
X-Google-Smtp-Source: ABdhPJwkX7QpaU5M4o4LS8HoC+xdGJpEavzvvSdMVUTC25vcw+73p8lcHm/mSPc9qwSXt9Ps0XTRJg==
X-Received: by 2002:a17:902:7e85:b029:da:726a:3a4f with SMTP id z5-20020a1709027e85b02900da726a3a4fmr22592096pla.65.1607944489000;
        Mon, 14 Dec 2020 03:14:49 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id mj5sm18326633pjb.20.2020.12.14.03.14.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 03:14:48 -0800 (PST)
Date:   Mon, 14 Dec 2020 16:44:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 5.11
Message-ID: <20201214111446.xz5hrfamjm3tyesq@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains following updates:

- Allow empty (node-less) OPP tables in DT for passing just the
  dependency related information (Nicola Mazzucato).

- Fix a potential lockdep in OPP core and other OPP core cleanups
  (Viresh Kumar).

- Don't abuse dev_pm_opp_get_opp_table() to create an OPP table, fix
  cpufreq-dt driver for the same (Viresh Kumar).

- dev_pm_opp_put_regulators() accepts a NULL argument now, updates to
  all the users as well (Viresh Kumar).

-------------------------8<-------------------------
The following changes since commit e0df59de670b48a923246fae1f972317b84b2764:

  opp: Reduce the size of critical section in _opp_table_kref_release() (2020-10-27 13:21:03 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to 2c07b0fd9bf6dfb0bdf05aac018e6b3242d60822:

  Merge branch 'opp/empty' into opp/linux-next (2020-12-09 11:24:12 +0530)

----------------------------------------------------------------
Nicola Mazzucato (2):
      dt-bindings: opp: Allow empty OPP tables
      opp: of: Allow empty opp-table with opp-shared

Viresh Kumar (14):
      opp: Always add entries in dev_list with opp_table->lock held
      opp: Allocate the OPP table outside of opp_table_lock
      opp: Don't return opp_dev from _find_opp_dev()
      opp: Reduce the size of critical section in _opp_kref_release()
      cpufreq: dt: Don't (ab)use dev_pm_opp_get_opp_table() to create OPP table
      opp: Don't create an OPP table from dev_pm_opp_get_opp_table()
      opp: Allow dev_pm_opp_put_*() APIs to accept NULL opp_table
      cpufreq: dt: dev_pm_opp_put_regulators() accepts NULL argument
      cpufreq: qcom-cpufreq-nvmem: dev_pm_opp_put_*() accepts NULL argument
      PM / devfreq: exynos: dev_pm_opp_put_*() accepts NULL argument
      drm/lima: dev_pm_opp_put_*() accepts NULL argument
      drm/panfrost: dev_pm_opp_put_*() accepts NULL argument
      media: venus: dev_pm_opp_put_*() accepts NULL argument
      Merge branch 'opp/empty' into opp/linux-next

 Documentation/devicetree/bindings/opp/opp.txt  |  54 +++++-
 drivers/base/power/domain.c                    |   2 +-
 drivers/cpufreq/cpufreq-dt.c                   | 155 +++++++----------
 drivers/cpufreq/qcom-cpufreq-nvmem.c           |  15 +-
 drivers/devfreq/exynos-bus.c                   |  12 +-
 drivers/gpu/drm/lima/lima_devfreq.c            |  13 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c    |   6 +-
 drivers/media/platform/qcom/venus/pm_helpers.c |   3 +-
 drivers/opp/core.c                             | 228 +++++++++++++++----------
 drivers/opp/of.c                               |  16 +-
 drivers/opp/opp.h                              |   1 +
 include/linux/pm_opp.h                         |   1 -
 12 files changed, 283 insertions(+), 223 deletions(-)

-- 
viresh

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650522FDCEA
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 00:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbhATVZe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 16:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbhATVYv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 16:24:51 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEC4C061575;
        Wed, 20 Jan 2021 13:13:51 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id h205so36039386lfd.5;
        Wed, 20 Jan 2021 13:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HM+kPSLxbcGuQtpmn+lHuIBs3kdjxoFtz28EJXxS7zg=;
        b=Rsgpal3kAkbYt71GPypPxgpyohAY5taJJXOGXEjvFATzhq46V+v4nnelJQdHN/dTgu
         J+wV/xKYGCbgmocmBF057xhuQXaXpzWijWXDEnG/szu6WH02JItR1kHpxmq3gmGsDdso
         k/b97i87l3qrTyB3WAa51fnxUj8nAdDNUlBvhbYxiSUjbiIVmUOazQw65xJhKtdtlMjV
         YyUcvEXbDTjacpSG+PI6iFL7HKdWVQu1AextIJZIGAEriMBpg4yUce3WtqHN2OZWSbqh
         uXpRkYl7i9o3BOBUiqO4z8OhDw3tvvQOgiXwVYItUx4I/bMYLSGzP//diRg6h2eGy19z
         mnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HM+kPSLxbcGuQtpmn+lHuIBs3kdjxoFtz28EJXxS7zg=;
        b=hu1G8/cyFlZEodtF29Ho0+mQDp14/ZCsmQ/2do4sSmfP2fxfuSDe1b+Ncgc0JJLMv2
         x3ZJocXmEnBEY8YcnCghqSq7TUhPqQio0L7ICwQd0uJiK7lw94dkDQhFVaXgA1hM3e1I
         a7ZnEzrLjDg+nfumQWVHRJBzu/U4N3wB1mqqKAMXODBPQv2N2VeQJE6RwUwn+zDq0c/E
         okYZU2cZYJrni6Ew8FHIDlNHZtjAHnB5KpWQrCjIcmN5HcP6oopRWP1xL7DhM5TLLWDt
         HJy19c20ILiTEHqntYq2Xzl9m/rgAl0mnYIgOgbRudpWqhbrouHw/UBO0wejQ0Nep9UO
         RjRQ==
X-Gm-Message-State: AOAM532QWaEeyZOhe2OoS4sW05vKQDBgsp8WyikWwNj7FDbBM9HKjhyt
        FcnOFnG7dj60IMTqXP9wbUvvBcLcxME=
X-Google-Smtp-Source: ABdhPJwppQdoc95LhQkyhFMdU8KkEKCLWzXUoEZZ7CBVaMSh53NI2hFNeLQ2hmtxHzN+Vojv+KrKYw==
X-Received: by 2002:ac2:58f2:: with SMTP id v18mr4915989lfo.623.1611177230404;
        Wed, 20 Jan 2021 13:13:50 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id 196sm298131lfj.219.2021.01.20.13.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:13:49 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 0/3] GENPD API improvements
Date:   Thu, 21 Jan 2021 00:12:29 +0300
Message-Id: <20210120211232.17299-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This series is a prerequisite for the power domain driver of NVIDIA Tegra
SoCs [1]. It extends the GENPD core with a better support of performance
states and eases linking of child/parent PDs for the PD drivers.

[1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=221130

Changelog:

v5: - Renamed genpd_xlate_performance_state() and its arguments like it
      was requested by Ulf Hansson and Viresh Kumar in a v4 review.

    - Added r-b from Ulf Hansson to "Make set_performance_state() callback
      optional" patch.

v4: - Updated the "Make set_performance_state() callback optional" patch.
      Now the case where one of intermediate domains doesn't implement
      the set_performance_state() callback is handled properly, thanks
      to Viresh and Ulf for catching this drawback and suggesting the fix.

    - Added more r-bs from Ulf Hansson and Viresh Kumar.

v3: - Added r-b from Ulf Hansson.

    - Added new patch "Make of_genpd_add_subdomain() to return -EPROBE_DEFER",
      which was suggested by Ulf Hansson.

    - Improved "Add "performance" column to debug summary" patch by
      correcting the formatting of debug output, which had a superfluous
      whitespace.


Dmitry Osipenko (3):
  PM: domains: Make set_performance_state() callback optional
  PM: domains: Make of_genpd_add_subdomain() to return -EPROBE_DEFER
  PM: domains: Add "performance" column to debug summary

 drivers/base/power/domain.c | 54 +++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 20 deletions(-)

-- 
2.29.2


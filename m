Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343BF29A635
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 09:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894496AbgJ0IIL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 04:08:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35853 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392391AbgJ0IIF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 04:08:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id r10so352549plx.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2020 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=spAX6twQPkh1Ij5Vpvmv0UCnkaB7pdjOtwOnngoJyRY=;
        b=OS4cz0Yof35kjz/q8C/Q6zY5YbN1ZhVmXqUgujYzY0bx+ID1RYEjBmQPG5aFw8eaBg
         a8MLmxkEai51mP+G9akHKBQFnWOEhthTyVhVZvZ7glceq1oktZp/NU0VJEDKCCM26i4/
         sxPZYZCSaXWxda5eF4XhIPkELxhiUGqHCQamxCF2Nn4SoL5gJ6DTcpRe+dxTpYwSRzKT
         5MSezUjBdHR/8Obl+As4B3UZlPx9A+R6eWmCMgEhvWXPT8rs6vKTdeUYX4WFlazMiGvl
         A/F+rfGm9aDgCh028lxbvMItbz82r9WnkCJjvqYpj6OSWBn7xX1m0OQvzvREeKmgd2m0
         DTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=spAX6twQPkh1Ij5Vpvmv0UCnkaB7pdjOtwOnngoJyRY=;
        b=lWxOeVUyxYbxO8ZpKtNqLNFktJeBSicBlE7dH8yUdDzNZLCwO/Pgi+fIl36g/LppgL
         fO3w29IXEGMiJ5/rk/4yNeyrph/cldd8wYA4hHQdh14fd4OP1nqwuGtWEE3Ic6F//ptT
         ImnNOwTFNGD0xX9DwGuU0KBwcfUxUL2D5cYfNf2TX7p49nnZNKix9UAOV44pZM2Moxqe
         XnWnwOAhBVG372fmdWhCW9wbT1+qlkbKrzEmWVsc89EhPVPXvWQDrVvHTZoVjS6jmTM2
         Kv/xJuNq/4QiWE2Gcjwvyf/sVGi4tUft33wrmFa7yzXYhRR9EtzQQHtZ0J0ktfYbbPeU
         TzQA==
X-Gm-Message-State: AOAM532UUBVhV9hdksb6s8tbi4d7wmvLKW0uUqnxT/8QxXxXNqDMaa5c
        CGEQK+e/b9HnrEwDf4Z+FfxswA==
X-Google-Smtp-Source: ABdhPJzp6B76tD8EAX+x+ayGz1Z7YCB7ykmKq0AqUd7XrBy/oHLNLiaHhhpqki3MOetec7aDsTbLsw==
X-Received: by 2002:a17:902:b613:b029:d6:38a2:5244 with SMTP id b19-20020a170902b613b02900d638a25244mr1404971pls.14.1603786084427;
        Tue, 27 Oct 2020 01:08:04 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id t129sm1265614pfc.140.2020.10.27.01.08.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 01:08:03 -0700 (PDT)
Date:   Tue, 27 Oct 2020 13:38:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP fixes for 5.10-rc2
Message-ID: <20201027080801.ztqiud2zcbg4bwr5@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains following fixes:

- Don't remove the static OPPs erroneously.

- Check for the right condition before making an early exit.

- Avoid a lockdep by reducing the size of the critical section.

-------------------------8<-------------------------
The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/fixes

for you to fetch changes up to e0df59de670b48a923246fae1f972317b84b2764:

  opp: Reduce the size of critical section in _opp_table_kref_release() (2020-10-27 13:21:03 +0530)

----------------------------------------------------------------
Viresh Kumar (3):
      opp: Don't always remove static OPPs in _of_add_opp_table_v1()
      opp: Fix early exit from dev_pm_opp_register_set_opp_helper()
      opp: Reduce the size of critical section in _opp_table_kref_release()

 drivers/opp/core.c | 9 +++++----
 drivers/opp/of.c   | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
viresh

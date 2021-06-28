Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54D03B59C0
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jun 2021 09:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhF1Hcy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Jun 2021 03:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbhF1Hcw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jun 2021 03:32:52 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AFDC061574
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 00:30:26 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id b5so884569plg.2
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 00:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=oWlyZVPkShr5SNSDs6XHL2EHI/7sqH/0yqaFQ2+QdeY=;
        b=RdP1xZ6F4bw5gCVIzo1SqQ95V3N9KADkQwhQ5PXocSHyJJCYNg26vnpMH4ljPAGwYW
         5lF5hUvxso1h1kY9ZNdWXz3kyc7AF3HRHprbWhI25QdeISp8TgMYbBuc0pLrWJD/qF2W
         2YpZmtEW5x0vPZi+tHO7in/7r1rRfwjh9/4eSvtbf8TIdHrPtyjqTioonVvIU2gQbWDO
         +/EisF11FlPZvxHjAfI3im8P6ZSgt6ix0K9ffwbcLaXUjB6Y6aPc/n4TlYbqgFuCwwvW
         YTpBoX/vmXC8yvZQNEknhUvkz+3X984f/ZKoM2nnhnymWLwciePVwl06MLf5kdWPDrHV
         JNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=oWlyZVPkShr5SNSDs6XHL2EHI/7sqH/0yqaFQ2+QdeY=;
        b=pGDJBFdTr7vj4l6fMKRWdGsYjDswgGQyRJUEHL8RH/M1o3lPdDLZsUF58Hf04ndjzK
         ygOOItLIOU55tmH/sU7N6H1zAI7XsS+i5pRXxhobAchhmUPasYNJazSeLdQjnkfXA7/H
         JyBTX+DQOlsB3DHzVPSBIK6k4xOXRVmf3u0OM95bb3ABxf2+CT5zEPPd+NHY0hfgHkcW
         VmptSHYhDKyUSo6i5yL/7qYXK5G4WHh96V9js59Y79j3FngqnLFLQt+A9mhgWzIB9r6F
         ZFcxiDLog6LQNeQbGjdm5spicCpzN7Vd96ageZefoy3mnr3KEEomLrgCzumt2BNfco1K
         O1JQ==
X-Gm-Message-State: AOAM532MbOWgHayh41VUIgYM6mA2JQyxLi2ALT42UxaHgBhBQhmDVYbB
        +49uGs9wrzKc09hjuu3SP22smzrjYPP0VA==
X-Google-Smtp-Source: ABdhPJwIHu+vDpl+JP4bxGwtTjD7If4EoFHREXCpHD8/Q1MndpLi4QVDonoGppJSXCcWFnHftFrKOA==
X-Received: by 2002:a17:90b:23d7:: with SMTP id md23mr25699342pjb.45.1624865425690;
        Mon, 28 Jun 2021 00:30:25 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id v21sm18580217pju.47.2021.06.28.00.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 00:30:25 -0700 (PDT)
Date:   Mon, 28 Jun 2021 13:00:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 5.14
Message-ID: <20210628073023.gytz3hkqy64hkzdr@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request:

- allows partial use of required-opps for non-genpd users.

- does a minor cleanup and uses list_del_init().

Thanks.

--
Viresh

-------------------------8<-------------------------

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to 4fa82a87ba55f5eca7d194055572110652daa264:

  opp: Allow required-opps to be used for non genpd use cases (2021-06-18 09:00:55 +0530)

----------------------------------------------------------------
Hsin-Yi Wang (1):
      opp: Allow required-opps to be used for non genpd use cases

Yang Yingliang (1):
      opp: use list_del_init instead of list_del/INIT_LIST_HEAD

 drivers/opp/core.c | 10 ++++++++++
 drivers/opp/of.c   | 27 +++------------------------
 2 files changed, 13 insertions(+), 24 deletions(-)

-- 
viresh

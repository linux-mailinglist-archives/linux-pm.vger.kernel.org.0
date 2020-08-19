Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6915249E9B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 14:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgHSMtC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Aug 2020 08:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbgHSMsx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2020 08:48:53 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B20AC061383
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 05:48:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d4so1068917pjx.5
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 05:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HMCqNR13Rztaop03dZqrfjBLOIYjLJLCo0pczKakWlU=;
        b=MTRxuW6u1pMz84ETEywlUL/OeNCuE+U+8ELKNzWrHqqmpDZN3NWPvuemqYqyHMuqHa
         MZ9RGcozNlvxou4QUzG7+a7VdnHnok7oiYfSSnMqGZ0pSSM05hc86s1ihZWgCa3Rrtom
         6f8Z3VyRCVWSgHkhMQfQMY4ahd4PBx1NtlkZaI3On+LaFy62FFHXcflxkF5HKa6I2bwY
         FmFkQyelyY6+hmbadUehvK9hz10Ynk2FIM9Ri8fIXuKjkd6RYB+5h0rK8kdsNhu8BrGr
         BohCBTXI68nRJtZEy+abG+kcn1X+gTqFpL+7VtYskBqzEviaZfsaWx3DPLoa6ny+qDio
         QCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HMCqNR13Rztaop03dZqrfjBLOIYjLJLCo0pczKakWlU=;
        b=Ncy+/HwpYJ68r1/DFaxIIDwx6D2wa1UUjf6vcjFXjsyMDg/UvctLRoUgceoUPeeXHG
         Nbp1kU84lycOLcxC0wf4T8AlnQWGAXt+e5liw3cqIRsZhc+4QdojUArJIdQIlbHZT4XY
         7Tg4Zz1UYEOq5WC+0bnoSntB2kXGr/7GumcLPgY+LlU1q7DSOy+4cOtHTRqOQZ9DUjyr
         eWJ3t52tWEU+Qqnt+WmsdeBO+8cZM/Lbo/0nl6HknLNo379eKey9mYcwRPOFnaCZ3cqI
         caWOux8co9FWtW13GGNLNBt0/AHgDKhbSRPVu81qnOADrdJakZW6j/sC1RS1X9zcypmd
         iz+g==
X-Gm-Message-State: AOAM531evb6RSn84+xuNak0qfeGwGM7ieuvZiOacFr+UWZZjKZ8z/7dN
        oOHh8OyF7xtBtLusmWi+gDIR8Q4IXzPuaQ==
X-Google-Smtp-Source: ABdhPJzJ2CJVs8BEHovOeYVz0Xu+eErAC0k6O5dmdKk6tbd+3QhZ36nyq6Z2AdwWl9b733ZvzCoxSA==
X-Received: by 2002:a17:90a:bc44:: with SMTP id t4mr3836036pjv.182.1597841332711;
        Wed, 19 Aug 2020 05:48:52 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id t14sm25059522pgb.51.2020.08.19.05.48.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Aug 2020 05:48:52 -0700 (PDT)
Date:   Wed, 19 Aug 2020 18:18:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP fixes for 5.9-rc2
Message-ID: <20200819124850.akwnkeyek4cj7bzj@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains following fixes for 5.9:

- Fix re-enabling of resources (Rajendra Nayak).

- Put OPP table references (Stephen Boyd).

-------------------------8<-------------------------

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/fixes

for you to fetch changes up to ceac7fc18ac7c1d0ad74222e349b24f69c87f1e8:

  opp: Enable resources again if they were disabled earlier (2020-08-17 10:37:11 +0530)

----------------------------------------------------------------
Rajendra Nayak (1):
      opp: Enable resources again if they were disabled earlier

Stephen Boyd (2):
      opp: Put opp table in dev_pm_opp_set_rate() for empty tables
      opp: Put opp table in dev_pm_opp_set_rate() if _set_opp_bw() fails

 drivers/opp/core.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

-- 
viresh

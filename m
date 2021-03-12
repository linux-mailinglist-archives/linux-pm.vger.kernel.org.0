Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD6F33849D
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 05:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhCLEUX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 23:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbhCLEUW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 23:20:22 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF44C061574
        for <linux-pm@vger.kernel.org>; Thu, 11 Mar 2021 20:20:22 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id t29so970930pfg.11
        for <linux-pm@vger.kernel.org>; Thu, 11 Mar 2021 20:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=EW6CjKiSrUazr5kjVU+/bESEpFHZ+EekCyiu+G3hYIg=;
        b=xiBPalO1/rmdqyxBd1z26qBB7QaWa4Wa6roFBZOkCe3ltgisSf/sHWoK/wDC9a60dS
         /fNOhbwVbKclVUJv/uVakl0WC2vaXJrIBd/HOkuH7lYASP1iG7AtGGeQt0jm73Rxa9Fg
         RocvIUE589lp9yxH+0BgB7XbQPClxx6hkXgbfD/iUwyyP28+HheSKHGYL2Oh+sk9XMv1
         H8gCdRoLdH3OzPm4ElETopNNkSORd7RFyLUvE63uJl/vcCdnjy2ROtB5mFFsRjqrpLR9
         bpTzwceuUQ+9uwe3wertCWhAEQoHPxuaOLG1orwlqjpGJgB3GoFQInSV9p+XcD7VYUNX
         Nctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EW6CjKiSrUazr5kjVU+/bESEpFHZ+EekCyiu+G3hYIg=;
        b=ojPAQstam0kq4ixwDn88PAFuZQ+vXOU/UdMUrJ1gB/+qcsoQsQR6aPCo1xKRl7Kl1x
         1A4XyPLLx4wUWpqj10Dngi6jBC6McAkrWSRXE43geJYkkqVm1Ak15V9jJyhJjFw8b1AZ
         yNWu2Cpu3K8AlRjmCkagLrLlZXpw/Ad1UZyDl18IOrtc9m5M0Ytm/TNsFbOAUUDpCTKp
         +TK4smLOJkFSabJGstMChUmOrk5bsNUA3psFuVJmXsXNiCLzaSKyDVlASdQ8jdKSyFRu
         /BnYk6AvT1nwZq4cRpjEXFr/sgdhXdFF9zcgWO6LjX+FojJV8lZ8ylBKMLoCkyUkb3BW
         lSOg==
X-Gm-Message-State: AOAM532/aHZinXuFergxg4uM1rhbaWH97zkwsisAUH0Ydv9cifwwkT7T
        WDuUK3vcQIBiP8OOYr8zukR97hQZZbKEIg==
X-Google-Smtp-Source: ABdhPJxImow2h3lgAaolIHiFNbhuAuLlsef9Hi7M+w2aKVOfbS3tLii/cWZn9O3b71sU5ONT13+sJg==
X-Received: by 2002:a63:5fd6:: with SMTP id t205mr9964120pgb.123.1615522821735;
        Thu, 11 Mar 2021 20:20:21 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id z2sm3817278pfq.198.2021.03.11.20.20.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 20:20:21 -0800 (PST)
Date:   Fri, 12 Mar 2021 09:50:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP fixes for 5.12-rc3
Message-ID: <20210312042019.wpn64ic5y7jjrrwd@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains a single patch to fix OPP refcount issue noticed by
Beata.

Thanks.

--
Viresh

-------------------------8<-------------------------

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to 606a5d4227e4610399c61086ac55c46068a90b03:

  opp: Don't drop extra references to OPPs accidentally (2021-03-12 09:26:52 +0530)

----------------------------------------------------------------
Beata Michalska (1):
      opp: Don't drop extra references to OPPs accidentally

 drivers/opp/core.c | 48 +++++++++++++++++++++++++-----------------------
 drivers/opp/opp.h  |  2 ++
 2 files changed, 27 insertions(+), 23 deletions(-)

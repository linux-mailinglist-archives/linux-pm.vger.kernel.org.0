Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5597624B09B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 09:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgHTH4s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 03:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgHTH4l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 03:56:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC046C061383
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 00:56:40 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id v15so746510pgh.6
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 00:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F2MDOdd0OoGgs6vybFQeYltao1MwvNlpVYOoAb0GyvA=;
        b=GffYcyO/OAQ/1rdq8V28TDq9AIAg37ScewFaIl2hjHMeSYZQi+As5RX8GwIjRa8MzV
         34vz0u+AX9Fw0mNdO4kryIvMgWAShDuvBg5c4r4MFzT7iE7w92D/11ZkHT+iq3GHe3Jp
         KLkPKEuje6/33Kz+NPZDrWx7wtem5Ei/zHFRLICpXDF/LyELxK3OiCaaRM1zCP9rqFQc
         EVO0Hn32/NIVd0AWRSHwkE9ZPnNY8VVIXErTHsu0CSK3GFGeXwyhAeQ7qDEdFqhKZapi
         hrhSq2UML2xWrsewgbA1gIyMaai6mHw7LInNMdsbdRWH4rkRIcnmjBK4tWsxO2YHU1J2
         9FZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F2MDOdd0OoGgs6vybFQeYltao1MwvNlpVYOoAb0GyvA=;
        b=ASxMfUHOzuqe2lKuK0KvZRoXbyXm+T46Wp2u3sJErKvhB0EvSWPgoKg0JrxxJA5sXE
         gkLU2uXHMNRI9lA9qkvKkMF3xDZ2Kk60ZM8cWm6tBTuLblScvKmmjc5bDil3RKArh2zy
         B4rIKNvfno5NZXTj2ob8e+vYn+TgEpOJYaPAX6WpUjFa1KxX3eLgbAb7K4grBg900R98
         j1vJfN1XTen7aVGnzHAH/xOE0Y3jmuVkt1E7ZbMhI+oH9FQJQDuMolGMtVlg3a1hUHln
         8119mo1P+5Y7X9KNPZH68cjf3WH4hZAxyiHQxrOnthNDIUgzwYYk+K4MtdZMs9YvCt7A
         8aVg==
X-Gm-Message-State: AOAM532YfZiliiXnKYJOeevnB/T9def14BEf/9o6uhTEy7gzERZN7XLR
        6knB6eir9FDca75xqUuZUh58ZcKeSttVWA==
X-Google-Smtp-Source: ABdhPJw4Jn/0zPBYEpwTrrLIH/dTHNVC20asNC+zntqyl/7FF3D+c5UZ47geLTS8Gtrc8eaILv75nw==
X-Received: by 2002:a62:6186:: with SMTP id v128mr1349832pfb.211.1597910200301;
        Thu, 20 Aug 2020 00:56:40 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id q18sm1706490pfn.106.2020.08.20.00.56.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 00:56:39 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, sibis@codeaurora.org,
        sbhanu@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/4] opp: general cleanups
Date:   Thu, 20 Aug 2020 13:26:30 +0530
Message-Id: <cover.1597909885.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Here is another version of the cleanups I sent earlier.

Rajendra: Please see if these work fine now.

V3:
- Dropped v2 1/4 as it is already merged.
- New patch 4/4 added.
- Reordered the first two patches here (Stephen)
- disable regulator only if present

Viresh Kumar (4):
  opp: Rename regulator_enabled and use it as status of all resources
  opp: Track device's resources configuration status
  opp: Split out _opp_set_rate_zero()
  opp: Remove _dev_pm_opp_find_and_remove_table() wrapper

 drivers/opp/core.c | 103 +++++++++++++++++++++------------------------
 drivers/opp/cpu.c  |   2 +-
 drivers/opp/of.c   |   2 +-
 drivers/opp/opp.h  |   5 +--
 4 files changed, 52 insertions(+), 60 deletions(-)

-- 
2.25.0.rc1.19.g042ed3e048af


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC2B4F2C5
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2019 02:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfFVAey (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 20:34:54 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:54061 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfFVAey (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2019 20:34:54 -0400
Received: by mail-vk1-f201.google.com with SMTP id b13so3059681vkf.20
        for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2019 17:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KfmaNk0Eu1BHVI+WPNp421IderZkjqwVQ/bXD2IsfF8=;
        b=NfLabKRBPTogQTjXkgamtEim4i76vkVJwx83MWI3SCzeuWvF9TwwKaNDvMPurCPAjR
         +talnPvE7Lku2Pcox/DE0vrSCLDWOWksEpLBWnTeyFb+m2DUXjNsclsDPld122aYvVoh
         P91Yed+76BhBWM7O3oOPV25IDxHfWP0qfh+npG1V856TUCIRmN4sXt63vLOTVt2JyTBr
         ymMAmaPC9t+TnkfT4CAl5fd36UWAd/JKKxHHkZJXq3uOFuW2JbGF2oiP8wVxO2VHZTvj
         jShcAjhAr4uQj7HtBG6/PFiaOAJJIbM9PG7kfaeTuUl1SBnkI/Dd2KqWgpbypE/RXAIu
         QmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KfmaNk0Eu1BHVI+WPNp421IderZkjqwVQ/bXD2IsfF8=;
        b=DCKEcPinI3x2F8v4Labg0/iCjaKudWD99CElKhRRoqZEtkI5I7nXJL2do6LzaBnXhb
         A+Z/Ud4CNULHS6+kUHCpr4dcMWTPTGNJs0VLkYlIe+8Hik7gvRRaOLr+lKQmCU7wZ+B6
         /H2rrASMLOXV5h8sm9XS0c104K+s/SOgkVIoygzCAv8x4Lizjvgi6IIhOK9sL95UIYNi
         f1FXrgeSfYU+knk8Hm9lCk6hqv2I6eajpE5BIEE/3g4wcBsLMaprvqYGDYP+LXgsTOfE
         yjy0BGDQ14dkcLPfOI7aMnJPoVte2SzS19p4+xSw7t72RkeX/mygAENDuYNO9tRtaMy8
         TcMQ==
X-Gm-Message-State: APjAAAWV5bk7jfgvMP+rmLzlS8qMYOfOfAy8n7miqK8wK7+dKPwP9d7m
        iaTIxWAqIqtNS2L/nCPwfefQFQuqP65aISo=
X-Google-Smtp-Source: APXvYqxI0kCH/VP1Tj1BapDK721tlVshuyp1M7qa5xUpC1IcNzSxjKfvyULOjetXxfShkRYS5JKc0oVN8dcjsKo=
X-Received: by 2002:a1f:2b07:: with SMTP id r7mr30702582vkr.65.1561163693358;
 Fri, 21 Jun 2019 17:34:53 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:34:45 -0700
Message-Id: <20190622003449.33707-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v1 0/3] Add required-opps support to devfreq passive gov
From:   Saravana Kannan <saravanak@google.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devfreq passive governor scales the frequency of a "child" device
based on the current frequency of a "parent" device (not parent/child in
the sense of device hierarchy). As of today, the passive governor
requires one of the following to work correctly:
1. The parent and child device have the same number of frequencies
2. The child device driver passes a mapping function to translate from
   parent frequency to child frequency.

When (1) is not true, (2) is the only option right now. But often times,
all that is required is a simple mapping from parent's frequency to
child's frequency.

Since OPPs already support pointing to other "required-opps", add
support for using that to map from parent device frequency to child
device frequency. That way, every child device driver doesn't have to
implement a separate mapping function anytime (1) isn't true.

-Saravana

Saravana Kannan (3):
  OPP: Allow required-opps even if the device doesn't have power-domains
  OPP: Add function to look up required OPP's for a given OPP
  PM / devfreq: Add required OPPs support to passive governor

 drivers/devfreq/governor_passive.c | 25 +++++++++++--
 drivers/opp/core.c                 | 56 +++++++++++++++++++++++++++++-
 drivers/opp/of.c                   | 14 --------
 include/linux/pm_opp.h             | 11 ++++++
 4 files changed, 89 insertions(+), 17 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog


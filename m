Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D4E1987F6
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 01:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgC3XUL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 19:20:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38181 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgC3XUK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 19:20:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id w1so19985406ljh.5;
        Mon, 30 Mar 2020 16:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bE6xbA64+4/+ypbO6EikqEyAaX3P7FX1UfeFwnlD2zU=;
        b=QBoARub8KAADOXu16KRfIrYxWSYJPJxny8zQJqUx5TWyKDx7Rl5lqGkpZ7fRmRQ5k2
         u2L/X2gOIW3uHGoq2AG/Vzs+RCdQ1o0VDP4RBd8b7oIe9JDj1Sa4ZSSqHzHQVMbn9zVn
         IJgsbDLH2TI/CQ7V8lqcD1WBqiEuqaNsXnmMgHlMnUqQrhcepiigtN3LqM9ZfoniLc+B
         dL/RsqQ3wBv1nbCl2L51IkumLx57cPNEHssWxhTayVBVLT0DRPHFPxDbGOoXbZy0mYJD
         wZ+2fSmBNUCGyQ832yeJ8leecDzKOj/zgWg1fe8AF6Z9xSxZXgwW80ZrwXgZi+GTwzpj
         m44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bE6xbA64+4/+ypbO6EikqEyAaX3P7FX1UfeFwnlD2zU=;
        b=EyAcuMCzlK3WAMBfeo+3bu9Yc/OD0/dlbt/jaUa0vVurOU+ZVfvHY5awP/JyTp0qYa
         AY0ZDyP93Ml3ylInE8jI6rxzuhd41WiQh+R+TTH9I9dYzAh58Cm/loQ8Ebb03RBuwV2y
         sAvLtZRKzufB+ZH+PZuOHM8W1yb2n9Jbp51/bV4com9wdXL2ycBi/iMBxcVfQG3W1GWQ
         MJhn4ryLBYhbzXyZfngAwLvD2wHHrWU6Cj/is3hBeF07NwR9Fm4moVhh2ROmZp7EBzU0
         up1GJdsDagG3yycbedLNGleFfn84tzUAJqONHfJcii9qMj0iEkFDRtSDQwiZjiE/8O9x
         5gDw==
X-Gm-Message-State: AGi0PuZOAtVynqY0MsSB9G72D5Wb2Zd2zaNOXBnMMrwzPY57qNc5TT1C
        x9TKjJZDLctad5jSVP3jfLw=
X-Google-Smtp-Source: APiQypLdU3aIWu9z86/NX1JqxLKQ+dBdMwQ2HRs5P+XZUJ86A5j43R6srXcrdFpxTzks4w0GObR7fQ==
X-Received: by 2002:a2e:81cc:: with SMTP id s12mr8513672ljg.90.1585610406263;
        Mon, 30 Mar 2020 16:20:06 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id h3sm8773187lfk.30.2020.03.30.16.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:20:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] NVIDIA Tegra devfreq drivers improvements
Date:   Tue, 31 Mar 2020 02:16:12 +0300
Message-Id: <20200330231617.17079-1-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This series contains minor patches that I was going to send out a month or
two ago, but completely forgot about. More importantly, it also contains new
patches that are needed in order to address an upcoming problem in regards
to adding interconnect API support for NVIDIA Tegra [1].

[1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=167480

The problem lies in clk_round_rate(), which rounds clock rate based on the
min/max clk limits imposed by active clk users. This is not suitable for
the Tegra devfreq drivers because they use clk_round_rate() for building
OPP table, and thus, nothing should limit the clk rate, otherwise the OPP
table values are erroneously getting limited to the clk's limits.

Dmitry Osipenko (5):
  PM / devfreq: tegra: Add Dmitry as a maintainer
  clk: Introduce clk_round_rate_unboundly()
  PM / devfreq: tegra20: Use clk_round_rate_unboundly()
  PM / devfreq: tegra30: Use clk_round_rate_unboundly()
  PM / devfreq: tegra30: Make CPUFreq notifier to take into account
    boosting

 MAINTAINERS                       |  9 ++++++
 drivers/clk/clk.c                 | 49 ++++++++++++++++++++++++-------
 drivers/devfreq/tegra20-devfreq.c |  4 +--
 drivers/devfreq/tegra30-devfreq.c |  6 ++--
 include/linux/clk.h               | 18 ++++++++++++
 5 files changed, 70 insertions(+), 16 deletions(-)

-- 
2.25.1


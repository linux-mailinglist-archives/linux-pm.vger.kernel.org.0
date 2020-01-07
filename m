Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2738E131FF6
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 07:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgAGGqi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 01:46:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44549 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgAGGqi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 01:46:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id 195so27246408pfw.11
        for <linux-pm@vger.kernel.org>; Mon, 06 Jan 2020 22:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hXySPSq7rHgw0OwQs5jXUSVuOO0+vuYf7jbQMni+qeM=;
        b=G7PcX1Rmf79ZcFBicjkH8QhH3XYeIUH8q0VuUV3hK1Itb6Eq+HmTcABldx2TbhJR9Y
         d7YwqA6KpBM/HYjJ5iteZKF2xxBBxhoaEDI91sspCUn9PRa9dNxBhSuiS3vFhmL9boof
         WM/VW/icP0Grj5OaCftyMyInmmZvqrsjlucyl8hiRR29/15R3u7CeAjR8aplO0Uzt6DB
         Rd33jHLXGyNiZejH3ok+twO9Dfczk6n4aYuoUlnqm509NxSOwe4S+14Q4RL02tcKWm8B
         kmZ77m9QtrIT3uEOo+dPEDzQ6FqISoXmYCbQQY8lb6nsadY8OUAVCrKB/KyuzTXMdRKS
         uL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hXySPSq7rHgw0OwQs5jXUSVuOO0+vuYf7jbQMni+qeM=;
        b=U/TvCTDI5aRvFLtPEubFosNsQxNxM4PR7SybLA12mpTlFh3V2r7btGRuGk8twjpfYu
         zsOOr2wj9Yy3XolhaRn96RI4fiSNHY76zSC4MjOi4IIEPe7pTgNItEXoReW0CZ6pc7Wa
         N9v11OAbQuWP6dOItWrVQzwgYWGPv/KvwEtaXv5DmGqeTGLnLqdKzS6jcPiIDERiJ/SK
         HY41HvxpnSl8XnV4uFDBZ7BsQ/3lDGHTYVzXpa+Wbx8rDW/SS6+0EJZxQi1hT8ad+XdD
         2dth9XbAV6ScuQH3hFbI/Ucp0pBRZWO72LAHcKNPRhri/BYTUjXg+kLRgQkyOhD+DKyp
         QAGA==
X-Gm-Message-State: APjAAAXLwDUfFEjE+Mu9O45iQ9rhEULuAIT2XC8CsZM1IyzdMPuD+Yfw
        7LtjOm7gb8aQusFyjVnuoAYfAQ==
X-Google-Smtp-Source: APXvYqxDPL5R5bqOzUh3WYy+QtWEyS3DYUNxELRRjaXJvdZtG2ISVMfMF0IaN1mFv6dtRyuI+Ke12w==
X-Received: by 2002:aa7:9816:: with SMTP id e22mr114969091pfl.229.1578379597303;
        Mon, 06 Jan 2020 22:46:37 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id s20sm26621379pjn.2.2020.01.06.22.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 22:46:36 -0800 (PST)
Date:   Tue, 7 Jan 2020 12:16:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm/fixes for 5.5-rc6
Message-ID: <20200107064634.dqudplqrp47elm64@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains a single commit:

- Blacklist Tegra20/30 for probing by cpufreq-dt driver.

--
viresh

-------------------------8<-------------------------

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/fixes

for you to fetch changes up to 26a7a47510ed12cbbce689184c8d6b63062b4fb9:

  cpufreq: dt-platdev: Blacklist NVIDIA Tegra20 and Tegra30 SoCs (2019-12-16 09:34:45 +0530)

----------------------------------------------------------------
Dmitry Osipenko (1):
      cpufreq: dt-platdev: Blacklist NVIDIA Tegra20 and Tegra30 SoCs

 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 1 file changed, 2 insertions(+)


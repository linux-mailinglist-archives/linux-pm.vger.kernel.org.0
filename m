Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0D9149F14
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 07:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgA0Gnv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 01:43:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33914 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgA0Gnv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 01:43:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so4663708pgf.1
        for <linux-pm@vger.kernel.org>; Sun, 26 Jan 2020 22:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8YWi1QlZo5higpUAxlhxPmgDNgu052UeM+xDT9viQeU=;
        b=i8lQz2fcQ7Ee4VKZyPlEyfEpuj1rHZ4zGEAvaUpSZ/8aoRVPwZsd+Dy/6bZF1LN2mA
         p4KceYeu528meMQov6qHgUnvgNxg15XP4Xe4a8rZzXj7VHbOWiMcLW4rghreWmoWreZL
         uuf9VMRPKBpgTGYjTMy462g+z8QP7SBZm+HQECukP+kRCGrBEgjofvkqwWQPdsdwA2jv
         OJkFS94qZ3rEONqt2gxD1thBDcVlIMIYp905OWBK/tdp2zYmLpABtF7hVQ8lUrPHrVlA
         37dqGPCtl9F2FkBdtqSXV0CqqwT4Tx3LG+vwhcl+2Wr1SxvQuG/3Jdtqdm0YAcBKuMbI
         t50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8YWi1QlZo5higpUAxlhxPmgDNgu052UeM+xDT9viQeU=;
        b=izC7Lvwfnnnc7TQVIwVkIn9dCtpQN7hFLbcOy6hcuWpo2dIov/V02SSdyp7CvMxopQ
         ELZJwuN20zigbB11vVc1tv2dq5+C+vKscIuCKdpChjfqku9u7zieCKgyOijm8c+dEhMP
         Faif2K+Q/El7BsVu0f7cRJf2wC0TPkzrZRg9d1SfX6Ro6+0Libpf5nwEh2zy0908X+2E
         fmofopaN7xN8KQ1UL6CALT6bDxXRTIbZHKvd8zkG29cHMlFk5JowG9eu6nZQCCyEkZ+p
         7hWNOSXXhQZ3glANA05VgqeAgz5TVGaukdaJy+UEXh0lM24QmFBCaHoJIUgREjc32jMv
         WPRw==
X-Gm-Message-State: APjAAAUQelPX3hnIDcZdMDBRw0b9c+Qa4uV+AhXytiDZXjaVA8stQ+s7
        vdNrWks15y2hCPTQYAkdoTE+Wg==
X-Google-Smtp-Source: APXvYqxOjsrDI4B+CslUaWkJjgPZBVxhefzswvDzP/XmROVGBOi/J+AQ+ifNATXe/ZMvvaC7aQfkeQ==
X-Received: by 2002:a63:f410:: with SMTP id g16mr17912982pgi.193.1580107430217;
        Sun, 26 Jan 2020 22:43:50 -0800 (PST)
Received: from localhost ([122.172.51.87])
        by smtp.gmail.com with ESMTPSA id b26sm14292945pgn.1.2020.01.26.22.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jan 2020 22:43:49 -0800 (PST)
Date:   Mon, 27 Jan 2020 12:13:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm changes for 5.6
Message-ID: <20200127064347.npuud5gblrm7iyyi@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains:

- update to imx cpufreq driver to add support for i.MX8MP platform.

- Blacklists few NVIDIA socs from cpufreq-dt-platdev layer.

- Convert few platform drivers to use
  devm_platform_ioremap_resource().

- Fixed refcount imbalance in few drivers.

--
viresh

-------------------------8<-------------------------

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to a48ac1c9f294e1a9b692d9458de6e6b58da8b07d:

  cpufreq: brcmstb-avs: fix imbalance of cpufreq policy refcount (2020-01-20 13:23:34 +0530)

----------------------------------------------------------------
Anson Huang (2):
      cpufreq: Use imx-cpufreq-dt for i.MX8MP's speed grading
      cpufreq: imx-cpufreq-dt: Add i.MX8MP support

Dmitry Osipenko (1):
      cpufreq: dt-platdev: Blacklist NVIDIA Tegra20 and Tegra30 SoCs

Yangtao Li (2):
      cpufreq: kirkwood: convert to devm_platform_ioremap_resource
      cpufreq: tegra186: convert to devm_platform_ioremap_resource

chenqiwu (2):
      cpufreq: s3c: fix unbalances of cpufreq policy refcount
      cpufreq: brcmstb-avs: fix imbalance of cpufreq policy refcount

 drivers/cpufreq/brcmstb-avs-cpufreq.c |  2 ++
 drivers/cpufreq/cpufreq-dt-platdev.c  |  3 +++
 drivers/cpufreq/imx-cpufreq-dt.c      |  6 ++++--
 drivers/cpufreq/kirkwood-cpufreq.c    |  4 +---
 drivers/cpufreq/s3c2416-cpufreq.c     | 12 +++++++++++-
 drivers/cpufreq/s5pv210-cpufreq.c     | 11 ++++++++++-
 drivers/cpufreq/tegra186-cpufreq.c    |  4 +---
 7 files changed, 32 insertions(+), 10 deletions(-)


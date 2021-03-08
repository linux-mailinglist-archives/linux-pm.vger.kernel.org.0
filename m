Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032FE330BD6
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 11:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhCHK4W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 05:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhCHK4E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 05:56:04 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C222BC06174A
        for <linux-pm@vger.kernel.org>; Mon,  8 Mar 2021 02:56:04 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z5so4693784plg.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Mar 2021 02:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dO38jLHHhTlo9vAYLImzzhA3b23qgyQNZ/gvQEXrp/8=;
        b=EqiJJfJwsEFSpmgfqMtBlGMnAJYTQEqGaLiDNeMw9GnmvnCEoFAlQRKtVpo0yPf8ud
         mTxvxz9RRk72jZN+g1jm3EAjGuRJ8Khw2WlnnHp/7A+1c4LYiFwwPNNgaso07HymwqOy
         Py64nUGi64qWF5FHXIEv9PAYw3rU9kRNT6/HIsJpxMShwIEmKshreDEp/EWo6RugLUPy
         yIRsUeI5XGW73/dgdxWrgGB3VqdOmU5WzII70Qbs30CepvpsOo25Uk075ikzGfuq3g+g
         0n13D6H6TrZzPf149cOiVpK/Cha3x5pj9PxlR6hI8ww6pd2WrFkCGhH4otlsv9JlBEOd
         X8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dO38jLHHhTlo9vAYLImzzhA3b23qgyQNZ/gvQEXrp/8=;
        b=QzhSKucMhw87CK0axz5IJGlZoMRt6DjRKBW2VjZO1/vZZM8/fA1317aAJwlP8Kh9pI
         jFqXBo7nlb4IyG2sbUEkbzjQOIu+3wT0C128BumdmPO6+b6KEfhHE14UDQBcvvBwKbOe
         4bNgjYnUWs3o9Fj7bKymPr1H0atXMAL68VUO1AljBEosL3UKT950TDJhF+XHzmGxaujb
         J84ObZs/gGseyYEaUdTiiVqBwqY600WBnGBYqFnW9TEhjG7SVTSIOSAT9P7lyyDdW6e7
         erU4KlYrtLhn/Vf3HGiexCMThZTkt531FPIdYmIEbuAO0v7LAcz+pgT8pFi5B8FItMzX
         Sifg==
X-Gm-Message-State: AOAM530eq0lSIfRc/1/q28akDGsuL6+sN0zTgG7yMKP7987jDTzOIr7k
        nf/hIA/t/4NzmCCjut6xk1k9LlmMNq8wLw==
X-Google-Smtp-Source: ABdhPJz/SldnF2Kwvmhgw6ORJainaMhoHAHJblD1U3T9l6eeP1zFC9VzDgzqWvGFDZyUsEbVoyViMg==
X-Received: by 2002:a17:90b:3551:: with SMTP id lt17mr24455720pjb.89.1615200964251;
        Mon, 08 Mar 2021 02:56:04 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id f20sm10163959pfa.10.2021.03.08.02.56.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 02:56:03 -0800 (PST)
Date:   Mon, 8 Mar 2021 16:26:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm fixes for 5.12
Message-ID: <20210308105601.krfecfcjh6e63bqq@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains:

- Two patches for qcom-hw driver to fix dereferencing and return value
  check.

- Add vexpress to cpufreq-dt blacklist.

Thanks.

--
Viresh

-------------------------8<-------------------------

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/fixes

for you to fetch changes up to fbb31cb805fd3574d3be7defc06a7fd2fd9af7d2:

  cpufreq: blacklist Arm Vexpress platforms in cpufreq-dt-platdev (2021-03-08 16:20:07 +0530)

----------------------------------------------------------------
Shawn Guo (1):
      cpufreq: qcom-hw: fix dereferencing freed memory 'data'

Sudeep Holla (1):
      cpufreq: blacklist Arm Vexpress platforms in cpufreq-dt-platdev

Wei Yongjun (1):
      cpufreq: qcom-hw: Fix return value check in qcom_cpufreq_hw_cpu_init()

 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 drivers/cpufreq/qcom-cpufreq-hw.c    | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
viresh

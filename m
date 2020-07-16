Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50282223C5
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 15:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgGPNVW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 09:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgGPNVW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 09:21:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5626C08C5C0
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2020 06:21:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k6so7065202wrn.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2020 06:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7YbtSjQOGUa/q+irulkRFVoHCpjbJGuPHTve5CYTDyY=;
        b=QOdYFmVlH7OY1uIqGhDN9Cb/bQtBwCY++VIocH0ZX2YtmJfaHdIthkum9ne1K2L3km
         x/NAgqoY9mjWAWQeOMeC1A9qm9IiD23UucmNZy1HSW/z1j6rnZAKtnGmWWhGdeV1PqKm
         7FrW+MdB+6FcFO3z5rVGVLG/4ERXiBkzp5CGYB3LnjDgEezHGOwY/59gjrPTl+FgA5pR
         oSWG13l4Urz3ziXeIXgSRJPCvLJwf9yCj7PyuDSxflm7mTdxfnGz/6eJV+qRz3pUEolf
         CcNrttAD2uDeYWcCbrCH5V+kTsXVbgLtOaVpEcbkjFLig9Og7ut7Etw+m0MQZIVgM45G
         01Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7YbtSjQOGUa/q+irulkRFVoHCpjbJGuPHTve5CYTDyY=;
        b=TkcJiRG914N0N0dHbYcw1OUaaBiamhSxeEwd35bmZgUGkJ/fO/os/iY1I6dR7BAJAL
         hs2nWv1POZcWhSuk0MwdYiTNnctaoBUhhFLfuiAlNX3YNpue4G/kOguoZfcJghrNoarZ
         bZh7ysSgGWU18CWh6+mLlAVm+lraBaBeyrLJREU/npADClo69Ie4UVK0i3sfEJAodOc9
         YeA4WGkblh5JqlLRp7iwM8OmRhBl87yZSBTNv01PKnWmIbG+4lGU3SWboCF/WH+xYcsr
         URAy/LSi4nY7rhDZGknVa/WlB9s8xL9EG/NpLS6nXW8TDKaozfX1t8j4EfI69x+BoyRm
         Kfjg==
X-Gm-Message-State: AOAM531GVDMcerXQ2haaqeEFZxfVVhQoEVq/qeunfkfPt/H50BAGfhbE
        9P4UesEkEZYQMR7ovuqzWH+zeQ==
X-Google-Smtp-Source: ABdhPJziwy34yB77Mu4b5lIbKxi2PVplLfoz+eGeRbOlWefCvTn6vC0VVKdXrNjnmr6t6gwKmfAYTQ==
X-Received: by 2002:a5d:420b:: with SMTP id n11mr5018134wrq.91.1594905680354;
        Thu, 16 Jul 2020 06:21:20 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9880:a643:3e69:6393? ([2a01:e34:ed2f:f020:9880:a643:3e69:6393])
        by smtp.googlemail.com with ESMTPSA id 133sm9027135wme.5.2020.07.16.06.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 06:21:19 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        alex.hung@canonical.com, bsz@semihalf.com
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal fixes for v5.8-rc6
Message-ID: <40ec1ad2-1938-81ee-5ddb-965c18ddd25f@linaro.org>
Date:   Thu, 16 Jul 2020 15:21:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.8-rc6

for you to fetch changes up to a8f62f183021be389561570ab5f8c701a5e70298:

  Revert "thermal: mediatek: fix register index error" (2020-07-15
11:12:48 +0200)

----------------------------------------------------------------
- Fix invalid index array access on int340x_thermal leading to a
  kernel panic (Bartosz Szczepanek)

- Fix debug message level to prevent flooding on some platform (Alex
  Hung)

- Fix invalid bank access by reverting "thermal: mediatek: fix
  register index error" (Enric Balletbo i Serra)

----------------------------------------------------------------
Alex Hung (1):
      thermal: int3403_thermal: Downgrade error message

Bartosz Szczepanek (1):
      thermal/int340x_thermal: Prevent page fault on .set_mode() op

Enric Balletbo i Serra (1):
      Revert "thermal: mediatek: fix register index error"

 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 7 ++++++-
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 2 +-
 drivers/thermal/mtk_thermal.c                           | 6 ++----
 3 files changed, 9 insertions(+), 6 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

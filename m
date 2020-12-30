Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1482E76A0
	for <lists+linux-pm@lfdr.de>; Wed, 30 Dec 2020 07:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgL3GjP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Dec 2020 01:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgL3GjM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Dec 2020 01:39:12 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6C5C061799
        for <linux-pm@vger.kernel.org>; Tue, 29 Dec 2020 22:38:31 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b5so3217860pjk.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Dec 2020 22:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NUwYZ8YKLtAkuo5jKMtJ+rMzB7JbhAiv9pyL9FSsR7A=;
        b=USW9ICiyxg0G3XMT3cL0QyE8aRSumn1uoP1ZEvgoJ53LaclbVy22/kvJvdzSZTNYz5
         C2qMtxfi2E1RBeIAIRfsjaorUp4EAI4LzeRhp0lu2iEEzJvXAeDe7+1utN0nLBo/g/HL
         7Sn7pcKKAHv2TvT1YAkyBcy/2Ks7/sYBsT79zfidIjbdCTV+GAuCdfD+BTGeY2jMS6WT
         TaThao36662lwpFWQKKH+dVk5Gl75DmpV211Iduxm5ttP8v9oeS+V0cuUbXJl/BMSQIk
         HPMvkMLeMxIhHtbZsfWLJVsWwAIu38nR7iFDlerYSLdC3hPNDGeuctQY6fO56/q8fiOz
         eMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NUwYZ8YKLtAkuo5jKMtJ+rMzB7JbhAiv9pyL9FSsR7A=;
        b=ZMhdRMEUnU4PDrgclep4kRaudDmvpqGtlGhHmQEoXFWK81qQMdFaCKoUE4H3+e29sl
         vPwAOrWQyhQGcn/Zg+0/CplvCnh2PyafTVZ0as81MMaFRtfOkEV8gpN/bsEiZYFhD5yJ
         eYX2NNwiRoi4xT2jPzzmE2Bg4bYX9OU0HLLsnBsdBETJ62VG6aC6t9NHAXqIWwghj4ag
         XnnZLkcAI7YE5bosC52UoLPu8HQ4fR0Sgv8R7tN/lde5YRB1dBgDMcxtKTIkzGi3qRpd
         n0VL2lvWJxpJIPuSXN6TPJ6y8gTglh6JQhR9F4mzox5/kx9RcBVPXpyCATLaN3pPkbW6
         yVBw==
X-Gm-Message-State: AOAM532NKQ3lfffHtdAt8LT4zLyjLwqFdtOpNf9oAoioFLlgYAaiV94Z
        tw5YgzcJCFnqNEKatGA4IiMVJg==
X-Google-Smtp-Source: ABdhPJyff9UM+jkJ/DvX/vRHDsEYb6YVHHyOwRfmnE52Yx2+wRC1PHumzX6UHlQjc3S6QVXxFW5+xg==
X-Received: by 2002:a17:90a:a781:: with SMTP id f1mr7362426pjq.111.1609310311375;
        Tue, 29 Dec 2020 22:38:31 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id j1sm41058014pfd.181.2020.12.29.22.38.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2020 22:38:30 -0800 (PST)
Date:   Wed, 30 Dec 2020 12:08:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP fixes for 5.11-rc2
Message-ID: <20201230063828.f6qba2h7nyedb2dt@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains two patches to fix freeing of resources in
error paths.
 
-------------------------8<-------------------------

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to 0e1d9ca1766f5d95fb881f57b6c4a1ffa63d4648:

  opp: Call the missing clk_put() on error (2020-12-28 10:56:22 +0530)

----------------------------------------------------------------
Quanyang Wang (1):
      opp: fix memory leak in _allocate_opp_table

Viresh Kumar (1):
      opp: Call the missing clk_put() on error

 drivers/opp/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
viresh

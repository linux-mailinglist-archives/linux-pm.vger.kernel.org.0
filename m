Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3761221AD4
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 05:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGPDab (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 23:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgGPDab (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 23:30:31 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0844BC061755
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 20:30:30 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k4so3254509pld.12
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 20:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ePFXciCqpmg6FFVlOEDJYpc55GbOIAYjVDlwMgEsVNk=;
        b=bZ7gctRqBF/DFDTSO8idjAQ217Zzyj8aKPRKTYUCYPGgfYDlE/qEvc1g/n0FgOmxAm
         o9Dzk4g4Wxz6ZOT7gxC1K8rBNVEb2pGNpoMhnQKBITeu/2OAoRTGJsiW98Ow7auKOInO
         Zoq/QQtvOsRh8nyhcMenf40AEZyvXrNfXrHSijMMOXS7/mibl/fbdMd8TwUsKPTasJCd
         +LX6g3UfE84pBkowKKfG6zHzjtpVeK+mF45lymBUXFp8ajnuFm4K1qFRlyvORucOGXfS
         zfmiJi1MbtN5OECeR7SNVQPoGv9QDontqbUpmiYysXPyNRsyFhNNFzcuihnqqsynhS5y
         ehzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ePFXciCqpmg6FFVlOEDJYpc55GbOIAYjVDlwMgEsVNk=;
        b=jS041sRCM1sbktJ1BoyAS2wXTGRE2SVz+kt02SgmTcUrbvJj9EeUKaeAgsBtU3zj6c
         FLJwnJYratpc+C4SkinwALWrBHQjkEZ/TfUP/qXD9JBUfrY2zb34fni7Z1r5Nvv4HX28
         0kYAUsYQAgQ9zhLeCDI+BrWI5ezruI+nVa7FkcyFSNVfybOmKxK+H/LFOUnlXeSvT4ED
         wnfHHGeT/ZkXpAqB4HSiQ/SKEQ4RHXKzz1ZxTWquaSIae5nqshsjP1ui12c9BJRAxKzL
         bI7oqU+6hmyNaiAuf7xVjYzhOLt0HvI6joZ8ULQb+Y6qfAtZiGSpoXRZt49kyyWq+Orp
         zrRg==
X-Gm-Message-State: AOAM533/t8zOm9ogoBe/h4Nva6/O5n8Mwlb+rGXtZkAPj02Dlgx0bVeP
        /mie2RBTF2SBySfeI3Uaz7MmSA==
X-Google-Smtp-Source: ABdhPJzzcp67Nqjqnsb96u4lO4j7LbBxtyyeMR72JMWQVqGPPcDw6zFYrSCvhYloD9++WfpEsGDr6A==
X-Received: by 2002:a17:90a:2e85:: with SMTP id r5mr2806355pjd.232.1594870229367;
        Wed, 15 Jul 2020 20:30:29 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id y7sm3211814pgk.93.2020.07.15.20.30.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 20:30:28 -0700 (PDT)
Date:   Thu, 16 Jul 2020 09:00:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP fixes for 5.8-rc6
Message-ID: <20200716033026.uhgnyo6leygfrgac@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request fixes freeing of the OPP entries for the legacy OPP
table type (v1).

-------------------------8<-------------------------

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/fixes

for you to fetch changes up to 6544abc520f0fff701e9da382110dc29676c683a:

  opp: Increase parsed_static_opps in _of_add_opp_table_v1() (2020-07-16 08:50:54 +0530)

----------------------------------------------------------------
Walter Lozano (1):
      opp: Increase parsed_static_opps in _of_add_opp_table_v1()

 drivers/opp/of.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
viresh

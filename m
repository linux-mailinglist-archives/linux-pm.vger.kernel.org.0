Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBAF258858
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 08:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgIAGi5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 02:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgIAGi5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 02:38:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883F5C0612AC
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 23:38:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mw10so130982pjb.2
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 23:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KmBTjDhQfMa0kE/Xz1jHps9NtdA2yQI8SSSW6LFqCaM=;
        b=fOx/9MQ7xAzSAEGvDVvpBT6h1sFtZyb0ZR/cDMC5j9JeVRLawrF2wcsp4q5TAiwt1C
         /mbGr0VhOhdpmvXeAdWgn0m+aJpgnSIt2u63HOPEgJ5XjT0TfEhTCD1vlznJXRBWvYca
         uCfE25nKkw7VQxFGtqxiMhGA6RFExYg13I5aJoAbfU+xpTMa6uyDpu2I3YKdBJfO1MUY
         /J9x7d4eL7puPZO1bU9icVaqihHKwRowdAIClyopxuALeRsGyuphGiLjCeEnK/48+7f8
         GG8JEcOnHvDoTtPPAjEwaz4BAWbwG8qf8eF3ZlBdyYpvRY3fPywsscPPPLS/GG032Ovr
         QOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KmBTjDhQfMa0kE/Xz1jHps9NtdA2yQI8SSSW6LFqCaM=;
        b=B8k5vBOVsa6OiqGu+kQd/zLJvfyIqCDzM3tyRaGyVOm3IDcGlAEIbwm/TaxpJ6joIh
         4/6YV7eK8AR0Qr6wQXoKUwb46fF8EbALb954LqZ5JYNBI+AH7z2c+bbgrR9RTeshK7VW
         qLOZs0XucCaYnhIPtG7TVNwe94NiivaRNDuvAySusrcHoK/3htcaUkUCLD40xFrlSjje
         9p8Ar1wgOXA7830onnuiFrm6u7ZdttXxn9h2ObMfN2F1xLdxWmjD23N/p8qceqWvI74J
         W5mbS6eEKkU7DsLtZoODZa5rdAeX5gpiKSfoJ5NR2TEbAUMX5zvZgzt1kBSBJtf4d3Wj
         U2ww==
X-Gm-Message-State: AOAM532Qc9xF0fwTowgOhUYBLTvmU4Tr7OhvSeKoEk1K4ZNuxdB7guvZ
        ppS7me//nEaHByrnTtit80NOog==
X-Google-Smtp-Source: ABdhPJx4aBWriLPHXjbAbSUC2SXBgqgPJTHHXroYYxQhlM7dZCKhEc9R73GCpjB2ErxkkH6XuQ5DoA==
X-Received: by 2002:a17:902:ff11:: with SMTP id f17mr126498plj.5.1598942336821;
        Mon, 31 Aug 2020 23:38:56 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id bj2sm300197pjb.20.2020.08.31.23.38.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 23:38:56 -0700 (PDT)
Date:   Tue, 1 Sep 2020 12:08:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP fixes for 5.9-rc4
Message-ID: <20200901063843.er7fjmixuooeqdnu@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request fixes reference counting for OPP tables. Few patches
are getting queued (for various subsystems) for 5.10 which depend on
this to be fixed first. 

-------------------------8<-------------------------

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/fixes

for you to fetch changes up to 922ff0759a16299e24cacfc981ac07914d8f1826:

  opp: Don't drop reference for an OPP table that was never parsed (2020-08-31 14:49:47 +0530)

----------------------------------------------------------------
Viresh Kumar (1):
      opp: Don't drop reference for an OPP table that was never parsed

 drivers/opp/core.c | 22 ++++++++++++++++------
 drivers/opp/opp.h  |  2 +-
 2 files changed, 17 insertions(+), 7 deletions(-)

-- 
viresh

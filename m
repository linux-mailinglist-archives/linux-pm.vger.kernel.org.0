Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581BF3F45B2
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 09:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbhHWHTq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 03:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbhHWHTo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Aug 2021 03:19:44 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B5FC061575
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 00:18:58 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x16so14555237pfh.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 00:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Ho2LiNEBbj/KY4I0PmA0/64ftRp71ibYBqUoFwKyN2M=;
        b=gSWMWsJztkCaFQWBbytMUJSIjKHB6hviMT+U6iFRqRyKn0WVNtaWrVPy1kSwbLe83v
         CpbV9VmNifOlzMaNgZQMhP3N2FfwXHAFbpfUu/TnPPER3oXyGDgo5OzR/WNl05+8ZG0k
         R8CoDJfEr0OL+7sisR66M36gbyhdjjkhf0Aj8ZCIezc80ecf7wwaO2cQhkjyTvAZ75R8
         gVhTZmVJDxVnKxO9T9RqHCX1wkJje/xsuARTeaS+2zk0fG2gcdBUir6GASE74flH41bN
         mhlt3e0gBOYblC2PVfrP6WlFbnokU+pusX21WpE0DwrIQ1eIO4eNotAXIUo4DoSVnS3h
         ijOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ho2LiNEBbj/KY4I0PmA0/64ftRp71ibYBqUoFwKyN2M=;
        b=ZuZYW+VTV3ZAlpwC/UFtSqpTC3J6yHEdSY2A2fx7wHBsN+aGlx+yAQDkBoW3pUlp6m
         CPA9ntnefakpLB+dfRM6QxUaZKf0lTmtrLBss9JZBiPNJv9+1i+5+m46eMQPQjlGqGpm
         wWsJuCgNIJ+Y51bxW4V3/TlNLdP/OgJ664dSe3RORIKpl9095XFxZdpefbxLXQN1/GFS
         eziK+TzRw2y56cu0+lsEyPpVpmBwU9nFiaLoiZEVMYJb2FGtp1LZsjXQfMuM+IK2hD/k
         NPfErFnkFbTLEuYChi9YR84tWxmZsoMPGsgOWXjkp/3KnKFPvf+Qzq0VDesABpyEeI10
         6a4g==
X-Gm-Message-State: AOAM5320nFDqN29exq9rdKNK2lx7XIapzUaNsNLS4WVOJA8+RTWdv+4R
        HmV9DFlIbey7KfsEJ88nuxTQ+A==
X-Google-Smtp-Source: ABdhPJzjZVrvpBHAv7lS+AQDrtucTDUp8ZlkXHfQA2B69gKUDyE7FViwk0kUb8drlNQa88ETSYSLlw==
X-Received: by 2002:a63:164e:: with SMTP id 14mr30440089pgw.246.1629703138092;
        Mon, 23 Aug 2021 00:18:58 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id a21sm16942355pgl.51.2021.08.23.00.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 00:18:57 -0700 (PDT)
Date:   Mon, 23 Aug 2021 12:48:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP fixes for 5.14
Message-ID: <20210823071855.l6wklzvuomizklsw@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request fixes regression in the OPP core for a corner case.

Thanks.

--
Viresh

-------------------------8<-------------------------
The following changes since commit c3ddfe66d2bb511f7fbcdc8e64952c7859e7e69d:

  opp: Drop empty-table checks from _put functions (2021-08-16 09:42:08 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/fixes

for you to fetch changes up to 19526d092ceb32d619fce73fe0bdca4370890124:

  opp: core: Check for pending links before reading required_opp pointers (2021-08-23 12:44:55 +0530)

----------------------------------------------------------------
Marijn Suijten (1):
      opp: core: Check for pending links before reading required_opp pointers

 drivers/opp/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AC71A734E
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 08:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405770AbgDNGHo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 02:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405711AbgDNGHl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 02:07:41 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CE3C0A3BDC
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 23:07:41 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h11so4271585plr.11
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 23:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vTnJ49F3FrmAQ5leuCU3bw0S28J+sPvbBnYCNa9wGDk=;
        b=fqD+aXX6y+0KMoVj0skgrgwYbDZrfdk8beU3KX4zF13BEa5qkZ/dbdtdd5pCbRtuBt
         YoMMPh6BJLNpxsqS88Av5eb109McgM3mMJrBJ343fjKdj3jCS50a6sN5Bdi9g8JSjw2J
         5pEwfVH/m4RFCB4SNGOhstiVStjCt26Np4uMrzEh8d+kzIrptrV8TpO19nK+Onfn5ARa
         ha+Z6EaE/0oVgdOZgG/d7RGfBOVX9i64pUOhjmRhujxe6b3Leu2vItDssPIXKol033AJ
         kdE9+4Y6XrBTbuJUfIRpikbrS8OLHp00C+9redeakC+3dfQG4LePn363RLLJGet3sY7T
         YIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vTnJ49F3FrmAQ5leuCU3bw0S28J+sPvbBnYCNa9wGDk=;
        b=X6ww7iHdjg5RQDX6MRwEyM5j2YuhNuwM0pFCrrHfJRXxas7ilHwvVo1x/U4eLopze7
         3EnyjjB4Y7xelTQHWQSeVbs51RMvS+XycorEM9WzazrGHLWv94HW05IgFhxtkoALArrl
         vCqWF+e7yWLP+TAZ1yjs2sSPaNk4lPTlEbrMoko4HzFYDHeFmtyw7BltfkTIEkcQb1h5
         XEYydepEdxImIReEkNJQsLGjifQ0pSVzsYCw+R5tB5GCUtREAFfmO2LrSBKcaPmAQxpD
         BxOGQbvq4DDuXVjXSEWuaSs3b5nS3qSS5x7eJzMufbzF2WahKYWD00bc76H/PH1lUyyv
         AfRg==
X-Gm-Message-State: AGi0PubONCKmLEIA1kDGxtUnNkfO5L6N8YQDFoYtDs4S9sUG9Wq7ZMRA
        AJYR6CBi++1ptnnOWf7zBTtkRw==
X-Google-Smtp-Source: APiQypLUzAlu0Jyx4dBzE708q4J5UOyn2ZidR0Ionl8hNiQQ5QjVcxTUyrFLDeAYBi+FzaEltocNPg==
X-Received: by 2002:a17:90a:65c8:: with SMTP id i8mr25645252pjs.156.1586844460843;
        Mon, 13 Apr 2020 23:07:40 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id e4sm7510024pfn.199.2020.04.13.23.07.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2020 23:07:39 -0700 (PDT)
Date:   Tue, 14 Apr 2020 11:37:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>, rnayak@codeaurora.org
Subject: [GIT PULL] OPP changes for 5.7-rc2
Message-ID: <20200414060737.ckxaa7bff6l24pym@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains a single patch that lets the OPP core to be
used by several IO drivers without making a lot of changes in them for
the case where the same driver may be used by a platform with an OPP
table or a clock node on another one. I am looking to get this into
5.7 release itself, which will enable other users (in multiple
frameworks) to get merged without waiting for the dependency to get
resolved.

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to aca48b61f963869ccbb5cf84805a7ad68bf812cd:

  opp: Manage empty OPP tables with clk handle (2020-04-13 16:14:55 +0530)

----------------------------------------------------------------
Rajendra Nayak (1):
      opp: Manage empty OPP tables with clk handle

 drivers/opp/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)


-- 
viresh

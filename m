Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62EBA149EF7
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 07:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgA0GU4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 01:20:56 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:32849 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgA0GU4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 01:20:56 -0500
Received: by mail-pj1-f65.google.com with SMTP id m7so1784800pjs.0
        for <linux-pm@vger.kernel.org>; Sun, 26 Jan 2020 22:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pX31JO8acXtjclTDC6jsi79s0ov5QcuJNdoc5i9nj8U=;
        b=mjTPQmJ+QPAbkSjYqRqnq6JzTZy6Nz+mLH8yrjP+IQK8FtkxqTTnSoRXBJ4iNMOiBX
         lmNOqPy6rjlI0NNsV/0Af1dUiyAEQCMUmnn0/MWQ5CSPjWwCrPeH76T0FSAj+Nmod8n7
         6mmfdI1b0ihkObMb+p3qb+bPTUYd7HWTe02GLJt3jB8oZFVDZQM+H+sHS4JZ31P3TzhZ
         NLd77uQHWaCw0WMTHVdUsADcIvIE09AHzAJqlFrjcTUAJN9Ctv5YEt23U8HwtdjKjCyN
         ydJhMgCaPwWQd7RpKraY+z2AIQvQnt118hB74Jvd9IRn5zfVutmXLzI8eiWv17PpSwXJ
         4GBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pX31JO8acXtjclTDC6jsi79s0ov5QcuJNdoc5i9nj8U=;
        b=PsjXFO80qMfSr6bbJvYt8OKNu+AaQBKPyj0MAyr4WCd3RW7wDk8YLdYdQCgsvKIIoy
         8vVsFPU9U7lCpklKJAdmQ6oeHfanWLDziJz1LKSOLrbiJAExJKg7M9d+1pxFPdp1Lm29
         /g1xeF2ul49KHB7f+Jk+Be19ViQQ3nNGJ/w9RNyAnvL4+2uZ/9fir6A1T+33IAk9WB7L
         Zm4g5XP9BsSkZDemaAzTf0eafJHNCoYc+he3fjDEgG08qai7YilA3jPguKESCOVGzU6d
         +L22MiI3989INDbNPp1HZgvKixV/kcfQ00Pbu9g4y6HO05wKRjjWX7eeqGn/o7GJga2d
         11/g==
X-Gm-Message-State: APjAAAV9VcdA4QNdqBX6SiKQPe97Z4dRqVe1CayGcpcVUJyYxoRNakmY
        TREzcyNJaXL3mnkh2cONJpizHQ==
X-Google-Smtp-Source: APXvYqx5uh1l75i4zs+d2gD3llCqtoUUJRTnc0KKxEAsbnQX8uVkS2b+xer6KNDacs0XYwH2YSC4Kg==
X-Received: by 2002:a17:90a:3188:: with SMTP id j8mr12524842pjb.82.1580106055288;
        Sun, 26 Jan 2020 22:20:55 -0800 (PST)
Received: from localhost ([122.172.51.87])
        by smtp.gmail.com with ESMTPSA id q25sm13964102pfg.41.2020.01.26.22.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jan 2020 22:20:54 -0800 (PST)
Date:   Mon, 27 Jan 2020 11:50:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP changes for 5.6
Message-ID: <20200127062052.hbu3ubh6budlirm4@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains a single patchset to fix reference counting
of OPP table structures.

--
viresh

-------------------------8<-------------------------
The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to 03758d60265c773e1d06d436b99ee338f2ac55d6:

  opp: Replace list_kref with a local counter (2019-12-10 15:57:00 +0530)

----------------------------------------------------------------
Viresh Kumar (2):
      opp: Free static OPPs on errors while adding them
      opp: Replace list_kref with a local counter

 drivers/opp/core.c | 48 +++++++++++++++++++-----------------------------
 drivers/opp/of.c   | 31 ++++++++++++++++++-------------
 drivers/opp/opp.h  |  6 ++----
 3 files changed, 39 insertions(+), 46 deletions(-)

-- 
viresh

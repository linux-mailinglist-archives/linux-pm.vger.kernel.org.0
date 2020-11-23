Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46532BFF27
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 05:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgKWEtR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Nov 2020 23:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgKWEtQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Nov 2020 23:49:16 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEDCC0613CF
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2020 20:49:16 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id j19so13095089pgg.5
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2020 20:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7zNERZso0FRobWH8r4OKU8m90HavR4qiCuTx4tKO0+4=;
        b=e32byNjkgUyv19Tcfla/RN0QaMEM7pcTqC2dsDxT/4QWbv4ZttWXdYg4MlQAzVgn1V
         2dz5PdcA4MfJ3UOiGQ47oQ40ruiGzvWyJ/aEKmXQ4jQUjLco5jUs3eW9b6gzvbpunWXB
         dtOty79T/fb0X6pgCy24f2vdf6N2AJtgNKvo7CHy27VMV2SHN2dHJKZucTQPmxt64Vhw
         qDxn24TZLWVdVc8Sw8lJgKecS4WaHitNRJuj03tvoEr7xwaH+pMoe6yOjvgMPN89rbIU
         VtqzmrqoSqUza6a56EhLV/xCl+HTRMYtD0GOKOGuW3hsMjsMvEkJH2vOLYp7CMhRcvQt
         852w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7zNERZso0FRobWH8r4OKU8m90HavR4qiCuTx4tKO0+4=;
        b=jgVTVHuOQ2sJsgYSfCz1eyEKsVC73/STNkqJxxZCn1K4ip5Vi+HIvYeF09xO+MQEkF
         uH4nR4SdANHTxetdJFTkZIm8hxj55eaDQmFgnD9Xya9Bf7Ri6ziVJxBYXeWLcURsnaXb
         6D7UZPbtYAmdvG/ePW5KpqdRv6aT4EDQQy9jqlKpD1tlnLyZp25+UYYwqs0n739jBD3T
         YcCS2sS8uX5GxnU3iN/PUObkgSASqLyqefrSG9hHCS00trD3QlCGp+BEKJhI9tSDqJb7
         CtcmUL23aB3FCDGkSPFohoJ//8++v8AAOLv1nuwyScAWA1gr8leiS2BTHORHSkiSJK+t
         TglQ==
X-Gm-Message-State: AOAM533Xo83N0CMg267yJETuLex8L/ksjVWo6GuafRAwCgtBqZpmwQCn
        WNhbmPhqISgVuanQBvCzkHlE6A==
X-Google-Smtp-Source: ABdhPJwuh6Z+BYTgje3DoO6aC15ICOfqLh02o4I0XOVn9Ag9kd7T/MVF7muyHs0VyD+tfckv49xCQw==
X-Received: by 2002:a63:4e24:: with SMTP id c36mr25792886pgb.171.1606106955900;
        Sun, 22 Nov 2020 20:49:15 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id s65sm5231765pgb.78.2020.11.22.20.49.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Nov 2020 20:49:14 -0800 (PST)
Date:   Mon, 23 Nov 2020 10:19:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq-arm fixes for 5.10-rc6
Message-ID: <20201123044907.6xgnqf5d2xnfikhm@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request fixes a build issues with scmi cpufreq driver in the
!CONFIG_COMMON_CLK case.

-------------------------8<-------------------------
The following changes since commit 8410e7f3b31e53bfa7a34c282b4313e79ed7ff8d:

  cpufreq: scmi: Fix OPP addition failure with a dummy clock provider (2020-11-17 10:04:28 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/fixes

for you to fetch changes up to f943849f720689214abb3930623c31ff91990be9:

  cpufreq: scmi: Fix build for !CONFIG_COMMON_CLK (2020-11-23 10:15:56 +0530)

----------------------------------------------------------------
Sudeep Holla (1):
      cpufreq: scmi: Fix build for !CONFIG_COMMON_CLK

 drivers/cpufreq/scmi-cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
viresh

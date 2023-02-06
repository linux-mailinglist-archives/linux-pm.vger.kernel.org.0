Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307B568B4C5
	for <lists+linux-pm@lfdr.de>; Mon,  6 Feb 2023 05:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjBFEHd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Feb 2023 23:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFEHd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Feb 2023 23:07:33 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F321968D
        for <linux-pm@vger.kernel.org>; Sun,  5 Feb 2023 20:07:32 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id h15so3483413plk.12
        for <linux-pm@vger.kernel.org>; Sun, 05 Feb 2023 20:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUGwCC0TqYfky+2w3RZy3zEY15+UU6JCM4Afr3Lin/I=;
        b=bWlU7F2C++OkJrXAhz05fU/w7E2DaRCuPRMkkwoiJMJpuAnNTugu4FLg1FqQNVUIKO
         AKWJApMVBva4zMQ5N45ibuxJVBAisskN9YSgCYR5vXDIp3sCbGm36IxWKT3XFZ6rf+OL
         UcO7B+1KpjsUP09QgNZp4OycpdPFe75lsQgwYyRqFJeh6HMk/+dNGJdnHM8kH3/rHvwU
         L+s5WPZIgdAIKmLnaye7M0LKm9qfaEV+D0Z5KDCusc34F9E+xteSnnPs8XQpZUsvo88y
         UBEBjg9wm8XndHQS9nQQ/Pv0qDKUSA9dHWlCYhCzM/40/ssGv2jijUS2bXQrK4/5naAy
         UQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUGwCC0TqYfky+2w3RZy3zEY15+UU6JCM4Afr3Lin/I=;
        b=zd+EpVc7HZeelfP/dVZJo579Ujcx8A56pwVcvFPBJEq1KqhdSXm/Pm7Uluxu8P0YAW
         VOk5yhfvwRGKhlsxIjGMhJlyvmwSP7LLYXRbDUGiNOfPfoek1acs7AkSw9XCg+45w/CQ
         zjDIZfWViIrz+Zp/PoVa+4QxupracybS5htaGTytOlB/EywTpNUVTY49JL6vf5q8sqnx
         347G3c9GlvT6s29gmpNvjkn6HAeHChUUETt/VzBWfYxY2zCK5Nduq4TbmFKJ9h7ySgVf
         JiYCkb5o+flhUf3ph4UXci/xsSEhpcy7KOQ+vsSE2NdaSK0EupWzK2tCGeCH0vyIULPl
         afJQ==
X-Gm-Message-State: AO0yUKWldglUO5pv68OdgH7IzCDw8j2+WbJq6m8AXnpuvLAzNk5lMRhV
        PRPxGfcJlzdIH9cmYGavvYZHpA==
X-Google-Smtp-Source: AK7set8dnXAT+f6iYDHUdWihLMME0k0qCS+gbcja4ZiW66mhe/2aPr56sWlcqC4JvIMeOiBd7Af2sQ==
X-Received: by 2002:a17:902:ecc4:b0:199:c8b:295c with SMTP id a4-20020a170902ecc400b001990c8b295cmr4029893plh.12.1675656451650;
        Sun, 05 Feb 2023 20:07:31 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902edca00b001990be77abcsm1616929plk.158.2023.02.05.20.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 20:07:31 -0800 (PST)
Date:   Mon, 6 Feb 2023 09:37:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm fixes for 6.2-rc8
Message-ID: <20230206040728.4pla75swp3p4tabb@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-fixes-6.2

for you to fetch changes up to 51be2fffd65d9f9cb427030ab0ee85d791b4437d:

  cpufreq: qcom-hw: Fix cpufreq_driver->get() for non-LMH systems (2023-02-06 09:31:38 +0530)

----------------------------------------------------------------
This pull request fixes

- the incorrect value returned by cpufreq driver's ->get() callback for
  Qualcomm platforms (Douglas Anderson).

----------------------------------------------------------------
Douglas Anderson (1):
      cpufreq: qcom-hw: Fix cpufreq_driver->get() for non-LMH systems

 drivers/cpufreq/qcom-cpufreq-hw.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

-- 
viresh

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16613759C35
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jul 2023 19:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGSRQL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jul 2023 13:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjGSRQK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2023 13:16:10 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A9A10FC
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2023 10:16:09 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b73261babdso20056851fa.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2023 10:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689786967; x=1692378967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5UYZaqyQl5X/MG7Hc8jKe2ADZfiP04W0aXyipc6N98=;
        b=lZWzTiQJ7rn0ijo7zJkK5XBz2SnaoNvE5McyjMa5DM2Kdc9x3U0g2GVobN4mPPu7uw
         q5JQTrBxRgXuiGZ3qx23gCuKIJUxVUgojilHVOUPm6M8JUINb+1GPpnAlakSd9Rhz52J
         0jDgEXDp/Ms5LvOEIyPTtOdXyA7q6fCd1jTPwd1tdMc974rOffyycDTgKHxckOyGhQZ6
         cxsFuran/AlKUccD0hDZrxWbw9B/XZV5wHMF3+Xt1uU7PKuYn4OFCNaJAyahnMNO3rTN
         RrYqkYHpTu6NaYcd4EO0BStihSWN7lD8yubw8nNyHGXWRC9thGKc7RnU8XZd3o01RYIO
         oF3g==
X-Gm-Message-State: ABy/qLYSJ3W9Uk/pHc+IVKRYP33bDNH3kfxytBVy4eeHacYRmRLiMTin
        O0UPOY3X0/nKAOXBYTC/B25/Yebcc9W+CUBjzo5AqBn0
X-Google-Smtp-Source: APBJJlGETttZyk5bVNBeiOPtTL2Vwiwu8w3JYBA2W99J9twK6pN2Xl3lhpWQ7OAuU3UqQu3sxITPmSBWePUuzX3xoLA=
X-Received: by 2002:a05:651c:150c:b0:2b7:3f71:b98d with SMTP id
 e12-20020a05651c150c00b002b73f71b98dmr452030ljf.0.1689786967409; Wed, 19 Jul
 2023 10:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jul 2023 19:15:56 +0200
Message-ID: <CAJZ5v0i3DiLTcqcFbUqQaBcmA0epJz9m0QdSm+45kTepfuWdHg@mail.gmail.com>
Subject: Re: [CfP] Power Management and Thermal Control MC (LPC2023)
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Folks,

It has been possible to submit micro-conference topics through the LPC
website for a while, so please take the time to submit your Power
Management and Thermal Control MC topic to allow the schedule to be
put together.

Thanks!

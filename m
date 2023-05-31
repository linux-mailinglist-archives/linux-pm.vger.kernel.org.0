Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE8C718059
	for <lists+linux-pm@lfdr.de>; Wed, 31 May 2023 14:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjEaMwk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 May 2023 08:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjEaMwk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2023 08:52:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D87B1B5
        for <linux-pm@vger.kernel.org>; Wed, 31 May 2023 05:52:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5035A63336
        for <linux-pm@vger.kernel.org>; Wed, 31 May 2023 12:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBAFC433EF;
        Wed, 31 May 2023 12:50:38 +0000 (UTC)
Date:   Wed, 31 May 2023 08:50:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [CfP] Power Management and Thermal Control MC (LPC2023)
Message-ID: <20230531085034.2421c40b@rorschach.local.home>
In-Reply-To: <20230531080012.17ed9ff8@rorschach.local.home>
References: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
        <ZHcebApf6WCPMxPa@R5WKVNH4JW>
        <CAKfTPtAkCTE+Ef1yqc-CqftfmQnCzm85gpMrWWm5s=qK85Xk1A@mail.gmail.com>
        <20230531080012.17ed9ff8@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 31 May 2023 08:00:12 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Thanks for bringing this to my attention. It seems that the Real-time
> and Scheduling MC is the *only* MC that is not publicly visible in the
> "Proposed Microconferences" section.
> 
> Let me go find out why.

It's now visible.

https://lpc.events/event/17/page/200-proposed-microconferences

-- Steve

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E606911EC
	for <lists+linux-pm@lfdr.de>; Thu,  9 Feb 2023 21:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBIUKD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Feb 2023 15:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBIUJv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Feb 2023 15:09:51 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BE23C0F
        for <linux-pm@vger.kernel.org>; Thu,  9 Feb 2023 12:09:50 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id m2so9875496ejb.8
        for <linux-pm@vger.kernel.org>; Thu, 09 Feb 2023 12:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DriAKiO49LWsP0QSGmEHl4yPWcd2wrpAz25IZBqaU5U=;
        b=yEakpZXSwvXxfeixqakdcK9EJpQaG6k5u/VdzfD2pYdwaxXZysiB0acKsWicrnfyyH
         M3gW7LsLnN2JAwclvaj0mSz/wouS/fdvR4EkUNJvTeaSKYBetOKcVH6uhE0IpbulLk9d
         xqPSfXiF8LQactWTfZIDMIO1yewmMBUJY2pDGB/t0om4IoSjIurrUZn3/tGak4Y2i7ES
         uUfrD+EPz8Kd4uvVitSyW5gqgKM29iScKNcg6vj2MIG1Epvr6Q8+GQINQtgzX67vbsKl
         3RXkRS7eOE1gIqnlBzNcj4lnFYCRFfEAVkyl/YmHk+aUpVdWjxCWyW6flVJ9HcAyZwu/
         tIqQ==
X-Gm-Message-State: AO0yUKVs+PVggPXdkXs6PWgw3pL0QiqJmtYWV06LjhDBf//+WZwjjDs+
        n1XMotmwqKAMck3hQXE+yegPh58sJk+uvW6/ddPy47NH
X-Google-Smtp-Source: AK7set8lXuE53q5Ok3XlKxgG3QxUMv44nNWiJb+dfo1i3F/vKCDxf1sG1FUfGblg7QbuPz8IEG6XkF1Ouei/+ICzwIM=
X-Received: by 2002:a17:906:a2d2:b0:8ab:b606:9728 with SMTP id
 by18-20020a170906a2d200b008abb6069728mr773428ejb.5.1675973389139; Thu, 09 Feb
 2023 12:09:49 -0800 (PST)
MIME-Version: 1.0
References: <E1pPlqm-0008w6-Ou@mx1.net9.ga>
In-Reply-To: <E1pPlqm-0008w6-Ou@mx1.net9.ga>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Feb 2023 21:09:38 +0100
Message-ID: <CAJZ5v0i4WthALOwWPTCW7ESyak6Bq28xWWEzgnDvmFP=WaGtaA@mail.gmail.com>
Subject: Re: kernel/power/Kconfig: patch, typo a single letter missing at line
 32: should have been run-time, not run-tim
To:     u34@net9.ga
Cc:     Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 8, 2023 at 4:29 PM <u34@net9.ga> wrote:
>
> typo at line # 32: a single letter is missing: should have been run-time, not run-tim
>
> config SUSPEND_SKIP_SYNC
> ..
> --- a/kernel/power/Kconfig      2023-02-05 23:31:11.897067253 +0000
> +++ b/kernel/power/Kconfig      2023-02-05 23:31:04.410465595 +0000
> @@ -29,7 +29,7 @@
>           of suspend, or they are content with invoking sync() from
>           user-space before invoking suspend.  There's a run-time switch
>           at '/sys/power/sync_on_suspend' to configure this behaviour.
> -         This setting changes the default for the run-tim switch. Say Y
> +         This setting changes the default for the run-time switch. Say Y
>           to change the default to disable the kernel sys_sync().
>
>  config HIBERNATE_CALLBACKS
>
> --

This patch is not applicable due to the missing Signed-off-by tag.  It
has other problems too, but this one alone is sufficient to block it.

Thanks!

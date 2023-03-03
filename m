Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBA36AA55A
	for <lists+linux-pm@lfdr.de>; Sat,  4 Mar 2023 00:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbjCCXGf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Mar 2023 18:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbjCCXGS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Mar 2023 18:06:18 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A89C637FB;
        Fri,  3 Mar 2023 15:05:55 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so2128839wmq.1;
        Fri, 03 Mar 2023 15:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677884753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EgrFgSn2L/JjbV7et1DCImmFgyou2xEIGwrP4KBZQI=;
        b=JvFe2nmGs6AQpBJTZ5nE8aRF+7NYcyZKIQU0iQZaTdvcvsu8ErPscEr49Y9qqnMv9m
         9OhhgDCrQsBvL0WgpMe4mcWVWjNZDtuzM+/h+7yw8fhS9sTj88g1K8GKsjy7axa42J2t
         ByGfOj+vEXXjDPDvb7cy1ANfPrssIQ8rXb3OIox3SCZ6Ea6jJh7Zq6B3n7jGBGG1ncos
         SoFVTCL21K52PnvtjTV9hBoRTx1OkiouHpyH+RCEvdQy0WfeCATuUf6OmvRrjkH5Lmq6
         BRpCcINgK9I1ncRE0B+cXFiTpY14CA4ux+6TVcLAbaPNZYDXAoWhkEUBK09MRyxKErC1
         vxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677884753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EgrFgSn2L/JjbV7et1DCImmFgyou2xEIGwrP4KBZQI=;
        b=TQyRx8OuJoAkJ1HdGmrvYBlHeankblkcgaGtPgk2AvN3IE0i0SDbR+VwDoPLB1aW71
         aCT52MEO0OYU3zhg8xNiS5ZeBjaCx0olUVKvDcdnq2BGT6V1UvMnjT27IRdXLMiFngnw
         //xVXn6zh57yHXkQKz3xLaDQLrnBTSOoiDrRTCZ7NgiN1UuxSpK9pr27O7Q1pkYghHMg
         zk1Ytj76ARWUZ5ZQkGbQmkRfRNYBxA0Z4S9mRKQkkUIvHzx/dzECnIcf6XSwDve0C9P5
         F8Kx6IisgPUtLYLDisgkkTdafegF/2s76Tw/qjR9DrN5YrYlYbK9DhAaBq1Mt4STxFb8
         WmZQ==
X-Gm-Message-State: AO0yUKXYMZ5WzQ2D+xkMnR7mTay+Rcq8Pvd1/jYoCVFjA+662kmX6qeC
        eZAwwoozIPo7MzwsNsY6AeH/RPptIJOTZz+Ssa/YGxdE
X-Google-Smtp-Source: AK7set9PD8SwH94TEmLPar8J3KVJzkr2ezpBsiid4INLCp6rgd+TdszEsBWiy4UoBJBZKEYlAO7bLZm+wqlhEK13EBA=
X-Received: by 2002:a05:600c:a39a:b0:3e1:eddc:e3ae with SMTP id
 hn26-20020a05600ca39a00b003e1eddce3aemr778840wmb.0.1677884752702; Fri, 03 Mar
 2023 15:05:52 -0800 (PST)
MIME-Version: 1.0
References: <MN0PR12MB6101F4408960BDB9CF63DD53E2AB9@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101F4408960BDB9CF63DD53E2AB9@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Jason Gerecke <killertofu@gmail.com>
Date:   Fri, 3 Mar 2023 15:05:41 -0800
Message-ID: <CANRwn3Tb1JgLpCiYFZBO1+PDHWLT-yxEPQ0TQ19xGDWZR9pmoA@mail.gmail.com>
Subject: Re: "proximity" attribute for input devices
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        "ping.cheng@wacom.com" <ping.cheng@wacom.com>,
        "jason.gerecke@wacom.com" <jason.gerecke@wacom.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Apologies for the delay in replying.

First off: as an immediate action, I'm thinking of changing the Wacom
driver to do lazy creation of the power_supply device. This would mean
that rather than creating it at the same time as the input device, we
would wait until we receive some kind of affirmative indication of a
battery being present. Most Wacom peripherals report battery status in
a "heartbeat" report that is sent every few seconds, so there wouldn't
be much change for the typical user (just a few-second delay between
connecting the hardware and a power_supply device being created). In
the case of the "component" devices that are built into laptops and
other computers, however, the battery status is only reported while
the pen is actually in proximity. For users like you who don't own (or
never use) a pen, this means that our driver would never create a
power_supply device -- preventing GNOME from showing a battery that
isn't relevant. I'm working on a patch set that does this but need a
bit more time to finish it.

That's only a partial solution, however. If a component user were to
bring a pen into prox even just briefly, then a power_supply device
would be created and not go away until the user reboots. The pen's
battery status will become stale at some point in time though --
self-discharge, use of the pen on another device, and even just simple
irrelevance if the user hasn't used the pen in a while (do I care that
the pen which I left at home is at 50% battery?). I agree that it
makes sense for userspace to hide the battery after a while due to
things like this. Are there new signals that the kernel should be
providing to userspace (e.g. an attribute that indicates if we're in
communication with power_supply? an attribute signaling that data
might be stale)? Or are the signals that are already provided
sufficient (e.g. should GNOME just hide power_supply devices that are
in an "Unknown" state? or maybe hide power_supplies which haven't been
updated in more than 1 hour?)

I've added the power_supply list and maintainer for some additional
viewpoints on the second paragraph... If there are questions about how
the Wacom hardware and its battery reporting works, I'm happy to
provide answers...

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....



On Thu, Feb 23, 2023 at 7:39=E2=80=AFAM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
> Hello,
>
> A problem was found that a Wacom device's stylus battery showed up in GNO=
ME even though the stylus wasn't near by.
> As part of discussing how to handle it Bastien proposes a new sysfs attri=
bute "proximity" to let userspace know this.
>
> He asked[1] to start the discussion on Linux-input ML.
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217062#c7
>
> Thanks,

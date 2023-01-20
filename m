Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9696754FE
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jan 2023 13:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjATMuH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 20 Jan 2023 07:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjATMuH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Jan 2023 07:50:07 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26164213C
        for <linux-pm@vger.kernel.org>; Fri, 20 Jan 2023 04:50:06 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id u19so13646010ejm.8
        for <linux-pm@vger.kernel.org>; Fri, 20 Jan 2023 04:50:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNtzNMhM5+lsRf3exl4Xd7sgjfLX4FpbbEoI58EBUqE=;
        b=p2wp/L5ZHyobPoCmaS6Xh50WFXfgDbjsvMbFr1qia94QM4wSpPf+VYeypsa80EJ3kP
         H89Aq7o7bIkrhtX5bZ3iS4NZtLKzbyb0kpLIwP2nbBWe67ZLo2b8rwGVGaNHx3VvRibM
         7+9Pp2hiJ9sNCW/0pX7y3xLQ7TlDtoNEKN3+k9n/H+3eDRrl24q5dqLfpGr4jQdub294
         duf/OuQi/0uS078sj3rwr2HOZd55YdlasgMwyVx/5nyOwtYyx69QmIWBUZYK/cBgK/T9
         ryjWG2g8Lh4JhRrPBZxeMUAoZjuZvhak3ZJYwuv08vgV+TATXzUDPgDAwrf64yzxBiN5
         LhIQ==
X-Gm-Message-State: AFqh2krS26LyXC7dG7jmq9Vne+Nk01inyOzTJDOXNMc9EEeUMe+6IFtb
        lbLNZlpwQu9y3pZRO/WM/7E8iTGEcEK7Nlqxc1k=
X-Google-Smtp-Source: AMrXdXuKkhkzvtqJKl0Vr9czOAFuhR4KSBkNNbXbPD6MyEmcuXME50BbL/BxroO/Lye09iMaqgyp6rQWVik8m8avvGs=
X-Received: by 2002:a17:906:7d14:b0:86f:9fb1:30a8 with SMTP id
 u20-20020a1709067d1400b0086f9fb130a8mr1584240ejo.181.1674219004589; Fri, 20
 Jan 2023 04:50:04 -0800 (PST)
MIME-Version: 1.0
References: <CACT4oucMEZHtRcB_MSjvs-Sp289gp9x5LM35RiNqbMOC1iaixg@mail.gmail.com>
In-Reply-To: <CACT4oucMEZHtRcB_MSjvs-Sp289gp9x5LM35RiNqbMOC1iaixg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 13:49:53 +0100
Message-ID: <CAJZ5v0huPSUXUbQ8JuHqRp2aaoA3QV698WfeS7UCCKuYyktaoA@mail.gmail.com>
Subject: Re: How to test one device pm ops
To:     =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Cc:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 20, 2023 at 1:01 PM Íñigo Huguet <ihuguet@redhat.com> wrote:
>
> Hi,
>
> I'm trying to debug the suspend/resume operations of a NIC device. I
> thought there should be an easy way to force this, but I haven't found
> anything useful so far.
>
> I've only found this:
> https://www.kernel.org/doc/Documentation/power/basic-pm-debugging.txt
>
> Which is not a bad starting point, but it can be a bit uncomfortable
> if I have to do it many times when I'm only interested in a single
> device. Is there any way to force resume/suspend, maybe from debugfs
> or something like that?

There's nothing like that, because testing system-wide suspend/resume
for one device alone is not particularly useful.

The system-wide suspend/resume callbacks run in a special system state
(frozen user space and some additional restrictions) and there are
dependencies between devices/drivers that need to be tested too.

That's why /sys/power/pm_test is there.

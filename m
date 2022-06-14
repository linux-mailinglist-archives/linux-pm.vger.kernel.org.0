Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F6E54B474
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jun 2022 17:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356616AbiFNPRt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jun 2022 11:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356503AbiFNPRq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2022 11:17:46 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EC0BC8D
        for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2022 08:17:44 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p18so14486547lfr.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2022 08:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qsqCOOpowypdiEEM6D2t0JSVN3aZoVBRaXhuF0gjj4c=;
        b=AmQF4Wf65tATmYxp2mWu7sibbamgUZABJkIJTQxkK9eZhiFMsF2tl7amdJBNkL3eN/
         Z64doG+EjZTVMtXwAVQLIW8ercOF0Y8QYLghe/HbrR5t7oinSQy9oxwYU0Xfrl3oPllH
         xs0y4pKlC/0tYi9ogWcpICWNbnj7MXOYysJArbuqOr3QAnovAuZUIVtquP5Na5SS0vEu
         NwhyrhmaqpKRR30QFAEGIYxWL1B+ZFepSf6tWYW3v48f7uUBVRttUGqbi5qyRLWUr9Jc
         TBTjdPIBQlbM/3Vkupv5YUcV68bK2If00+Rqeh0iDMb2uu+NvGo2x8y2ak39JbzwPuTo
         P0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qsqCOOpowypdiEEM6D2t0JSVN3aZoVBRaXhuF0gjj4c=;
        b=sbeieaRUPXe7WpZVdor46k7UBefAnGgIWx9Yz+vXXVZjqd3deqffsmYcFxRZE086lP
         hQYxs4RWjVsT1c+m8lKAW/ek84XvvnmkU5C/h+7kGQ1nqDOPI1X3lkpMVjZt5VkxmIg5
         elXzv+sxnEsQC5ftVTihZ3smEMpJeD/CWyWY8XPmKFzQANeiihOln+oLw9mmayy2VAcQ
         /vleQNXgxU6MugRAX0klPVZLOqB/QrGDX0JAG/1qc5H8CK1UrPyWLP6qpDVQ2sqmQLFa
         0u5SzqIwylZDhyTBZ9TvwRe3zmsSN/FFQcTwmh3yLFGlZ3A/+7kL2p42h3rQ2o1k0wWh
         R+zA==
X-Gm-Message-State: AJIora9iiqHz+x9EI+nIGEVAEsf3rDjZx/KXpHDTsbQx0+JtxMsY5x4l
        spkUORYVgrgtHW2y++sQEGS822GF+q5tKgalqk0i4wPLYKo=
X-Google-Smtp-Source: AGRyM1vG67eI455/430AOTw4pM7yK3NubsqGgZ5A4zt9Qpx7m8+fkwYNJs4FKcxpiGYTpoRTqp4K+HUYIiLY7nmsR3E=
X-Received: by 2002:a05:6512:c26:b0:47d:a6e3:ab51 with SMTP id
 z38-20020a0565120c2600b0047da6e3ab51mr3586675lfu.515.1655219863133; Tue, 14
 Jun 2022 08:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAMMLpeTRZnpQ8b6puhHeKaDgzW12ZM_g3nAWjVP71HbSaeHktQ@mail.gmail.com>
 <20220614141742.j7lrj2q5b3suebb2@mercury.elektranox.org>
In-Reply-To: <20220614141742.j7lrj2q5b3suebb2@mercury.elektranox.org>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 14 Jun 2022 09:17:31 -0600
Message-ID: <CAMMLpeSRQ4T=_J0uwjoh=NNeuO43-Nb3PkzfSoDdUhOfU8_TqQ@mail.gmail.com>
Subject: Re: How to identify the primary battery (for Wine)
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Huw Davies <huw@codeweavers.com>, linux-pm@vger.kernel.org,
        Wine Devel <wine-devel@winehq.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 14, 2022 at 8:17 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> On Mon, Jun 13, 2022 at 07:54:49PM -0600, Alex Henrie wrote:
> > I've been working to improve battery status reporting for applications
> > running on Wine on Linux. However, we Wine developers are not sure
> > what the best way is to determine which battery is the computer's
> > primary battery. Could you take a look at
> > https://gitlab.winehq.org/wine/wine/-/merge_requests/134 and leave a
> > comment there or on the wine-devel mailing list?
>
> /sys/class/power_supply/*/scope is set to 'Device' for all
> batteries, that are not powering the main system. There can still
> be multiple batteries; for example Thinkpads in the 2014-2018 era
> used to have an internal and a removable battery. For a single
> "X %/hours left" info the data from all 'System' level batteries
> must be aggregated.

Thanks Sebastian, that helps a lot! We would really need to test this
API on Windows on a laptop with two batteries to see whether Windows
aggregates the batteries or just reports the charge of the first one.
For now, I hope that not doing any aggregation in Wine is acceptable
(and I hope someone will tell me if I'm mistaken).

> On Tue, Jun 14, 2022 at 2:05 AM Benjamin Berg <benjamin@sipsolutions.net> wrote:
>
> > Wouldn't it make sense for Wine to use the UPower provided
> > DisplayDevice that can be queried through DBus?
>
> UPower does the required data aggregation for the 'DisplayDevice'.
> I don't know enough about the Wine codebase to recommend for or
> against using UPower.

I also don't know if D-Bus would be a good choice here. It would
certainly be a bigger change than the patch that I've proposed. What
are the advantages and disadvantages of querying the battery through
D-Bus, besides it doing battery aggregation for us?

-Alex

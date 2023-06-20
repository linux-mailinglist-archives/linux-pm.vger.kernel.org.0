Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C03B7369FC
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jun 2023 12:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjFTKzJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 20 Jun 2023 06:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjFTKzF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jun 2023 06:55:05 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B9A109
        for <linux-pm@vger.kernel.org>; Tue, 20 Jun 2023 03:55:04 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-98502b12fd4so135563166b.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Jun 2023 03:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687258503; x=1689850503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzgZpbvSArp1Ia5jW9Dl3doB33B7uSycNuuuMVeFyfk=;
        b=lk1Rqm5gAsfI7SHGzD9vecdUYhlZcPPEk3fwtCdOaMh5Fq5ME8nmpI8V+M+wghuW9y
         zdLcVNmW5frpTsLQbhTzidlPSR06OUN3L78yvAChb5ukzB3U/h+Uw8PeQNnAXg/xdK9+
         Ms4Dt685TD2xDE2i08MgFmZ7b80t717lAOz2QzUHr5p4jTogJ4cHvzlFwihnz1LOiH/g
         Vcid6OJooRdlKYVsoLQN8qe8NpWsaVwRGZAz11tp1ImetJCHGbTqeWi3KBvGw4fBQpKr
         pQeeR3RsoMBtEM7LScM8mqj/n9mjYQh3e0bYRRuaW3fsQp0lBpUaTdGXjH8176H7Krs9
         evCA==
X-Gm-Message-State: AC+VfDylaw81oe7eQri94iMG6C3Uy191F0S+9Reux5nYrK1YRFaLOg6c
        1uUv0ISF6lEExlzM5ETYALZ+NcpddO17E7q0Fj0ySxy2
X-Google-Smtp-Source: ACHHUZ67eo1PmSJ3BIIV6TLvyh8BNMWf7O24ABkR9LJ35Z4WwKGSDgw/I34uJudW0Ze6LAZxoG/8inQbPOIrvemaprE=
X-Received: by 2002:a17:906:100a:b0:987:81d:9d49 with SMTP id
 10-20020a170906100a00b00987081d9d49mr7543739ejm.7.1687258503251; Tue, 20 Jun
 2023 03:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org> <e9d2e286-df54-1b6f-484b-afadaf594e82@linaro.org>
In-Reply-To: <e9d2e286-df54-1b6f-484b-afadaf594e82@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Jun 2023 12:54:46 +0200
Message-ID: <CAJZ5v0iDYGJuo0dLaZy2+vvsLPDdwrzZJLbO-axmBizcsy+2ZA@mail.gmail.com>
Subject: Re: [PATCH 0/8] Finish thermal zone structure encapsulation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        thierry.reding@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

Sorry for the delay.

On Tue, Jun 13, 2023 at 4:12 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> On 25/05/2023 16:01, Daniel Lezcano wrote:
> > The series are the last changes to self-encapsulate the thermal zone device
> > structure in order to protect wild accesses to the thermal zone device
> > internals, especially the trip points and the locks.
> >
> > Meanwhile the latest changes, a new driver has come via the network tree which
> > directly accesses the thermal zone device structure information and uses the
> > old thermal_zone_device_register function. The first patch does the change to
> > use the accessor and the new registering function. It is expected to have the
> > changes to go through the thermal tree along with the other patches.
> >
> > The second patch adds a macro to warn at compilation time if the
> > thermal_core.h is included in a file not belonging to the thermal core
> > code. One warning will happen with the nvidia drivers but this is in
> > the way to be solved.
> >
> > The third patch reorders the headers inclusion in the core code.
> >
> > The fourth patch provides an API to update the thermal trips of a
> > thermal zone. This function takes care of the locking and the thermal
> > zone update.
> >
> > The next patches makes the int340x drivers to use the thermal trip
> > update above and the different accessors for thermal zone structure.
> >
> > Finally the last patch moves the thermal zone device structure from
> > the exported thermal.h header to the thermal core private header.
>
> I think we are all pretty busy for this cycle and that series did not
> raised any comments (yet?).
>
> I would like to go forward with the generic trip points changes and
> finish the conversion so we can fix the trip points monitoring once and
> for all. This series consolidate the self-encapsulation of the thermal
> zone device to prevent changing the trip points directly in the thermal
> zone device structure.
>
> Most of the patches of this series don't have functional changes.
>
> If nobody has concern with it, I propose to pick them up in the next days.

Unfortunately, it is not perfect.

I have no objections to the first 3 patches, so please feel free to
add ACKs from me to those.

However, patch [4/8] is questionable IMV, so please drop it for now.
I'll send my comments to it separately later today.

All of the int340* patches need ACKs from Srinivas, who was not
included in the CC of the original submission AFAICS, before they can
be pushed to linux-next.

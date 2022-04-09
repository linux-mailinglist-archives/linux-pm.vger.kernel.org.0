Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A4B4FA1F9
	for <lists+linux-pm@lfdr.de>; Sat,  9 Apr 2022 05:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbiDIDhW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Apr 2022 23:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiDIDhV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2022 23:37:21 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6085BBBA
        for <linux-pm@vger.kernel.org>; Fri,  8 Apr 2022 20:35:13 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 12so10720623oix.12
        for <linux-pm@vger.kernel.org>; Fri, 08 Apr 2022 20:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NhYLnZjSBj3vGUK1h2W/q7E9jlIzGMped+bnp/r8ylc=;
        b=WHVpb8hi7JLuhz2Zor+MoULlhOCIpVXQZs5W+ydESh5QlFHxXdfquBsTXSVjcpNT8/
         MrqOr2JpiL1nodleQMUITY4Epp+3bfaiTGmuq7ulVvp57sFykjfzGsI+n2k9G796KlN+
         JFqQ9z406TQiqnk4ZADdYM3mDCuqqofoxbAB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NhYLnZjSBj3vGUK1h2W/q7E9jlIzGMped+bnp/r8ylc=;
        b=7R9ceULmffWEJASx8MIb+TPrZG0MQFjjn/Xutub4UcRMoyd/RuZsDsb/RH0B4LXR87
         4bbf7JJvNam99pKLztMPt26wBxJnB+AZ5uRncSXIGLbE9x5jciJBO7eKfQJOkSmzqGfa
         uagbpS7xzsUHY183PxZtUhg5pDHTg1007iWJFk0GKaKxtPONpDSREx3vC3rxV0bCC/WO
         lE1HpzHfqdeXF/ivTVkCADDqTd7kZUTEQ3DnYwyyoLuGkET2brqIklF5WSYmKYGpCdxa
         kLXcpkYnh0Zt9kND7fPn3LF3tg/pE7LE/VKBeiVXQSJwoV0S9ArKcJV0o+3kwuEs28xd
         gJ7w==
X-Gm-Message-State: AOAM531Ff4ojglvJdPEc9jjvmPCPb28Q6fOIDBSXiOC3To9HHdiIzLPe
        MsS4aAPHTCF2EOoHgfaA4vvT8PEqBBx/Ug==
X-Google-Smtp-Source: ABdhPJwu8dzfHkBnYtHg1wfF7t23bxZImXoS2cx7gq/0cHGndNzqv1EqQVM+WzCkSsNFchxigwz2Uw==
X-Received: by 2002:a05:6808:152b:b0:2ec:f48f:8120 with SMTP id u43-20020a056808152b00b002ecf48f8120mr1291841oiw.58.1649475312380;
        Fri, 08 Apr 2022 20:35:12 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id q11-20020a05683033cb00b005e686fd52d6sm6608238ott.17.2022.04.08.20.35.11
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 20:35:11 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id y3-20020a056830070300b005cd9c4d03feso7408265ots.3
        for <linux-pm@vger.kernel.org>; Fri, 08 Apr 2022 20:35:11 -0700 (PDT)
X-Received: by 2002:a05:6830:1041:b0:5cd:b09b:2164 with SMTP id
 b1-20020a056830104100b005cdb09b2164mr7808516otp.186.1649475310609; Fri, 08
 Apr 2022 20:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220406014842.2771799-1-briannorris@chromium.org>
 <CGME20220406094558epcas1p4fa0c77a5acd6b73c192f6b19136cd5f9@epcas1p4.samsung.com>
 <20220405184816.RFC.1.Ib865f199d15221eab4ff77f70bd7e9e2eb04d32f@changeid> <c8664eae-4a10-bd1a-8898-01b96c05331e@samsung.com>
In-Reply-To: <c8664eae-4a10-bd1a-8898-01b96c05331e@samsung.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 8 Apr 2022 20:34:59 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNx+nwVKuisMAsHEKLfd=hqBzZmhFxphcYUF=bamqN2kA@mail.gmail.com>
Message-ID: <CA+ASDXNx+nwVKuisMAsHEKLfd=hqBzZmhFxphcYUF=bamqN2kA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] soc: rockchip: power-domain: Manage resource
 conflicts with firmware
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On Wed, Apr 6, 2022 at 9:38 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
> Instead of adding the specific function for only rockchip,
> how about adding new function pointer (like block/unblock or start/stop and others)
> into 'struct generic_pm_domain'? And add new pm_genpd_* function
> to control the power domain.

I suppose that is technically possible, but I'm not sure it makes a
ton of sense.

First, genpd doesn't seem to typically expose operations directly to
client device drivers. It's mostly about abstract handling of the
dependencies of "how do I power on this device?" behind the scenes of
things like pm_runtime_*(). I guess maybe something like
dev_pm_genpd_set_performance_state() is an approximately similar API
though (i.e., a genpd operation exposed to client drivers)? I could
try to go that route, if the genpd maintainers think this makes sense.

But secondly, this isn't exactly an operation on one power domain.
It's an operation on the entire power controller. I suppose I could
make a new domain here for the memory controller, and teach that
domain to implicitly manipulate all the other domains provided by the
PMU, but that feels like a fake abstraction to me.

Lastly, and perhaps least importantly: this likely would require a
device tree binding change. So far, the memory controller hasn't had
its own power domain. I guess one could argue that it has some
similarities to a power domain, albeit one that is managed in firmware
-- so maybe this is a reasonable "bug" to fix, if it really comes down
to it.

> Because it is better to use subsystem interface.

I don't agree this is universally true. It makes sense when there are
truly abstract concepts represented, which are likely to appear across
multiple implementations. Or maybe if the object model is complex. But
this operation seems very SoC-specific to me, and it's pretty simple
to implement this way. Or, do you think this is really something that
others will need -- pausing (and powering) a power controller so
another entity can manage it?

I guess I'd also like some thoughts from the genpd maintainers (CC'd),
of whether this seems like a good fit for a new genpd callback and
API.

Brian

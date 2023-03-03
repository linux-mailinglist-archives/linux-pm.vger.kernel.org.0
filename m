Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A651F6A8E35
	for <lists+linux-pm@lfdr.de>; Fri,  3 Mar 2023 01:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjCCAif (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Mar 2023 19:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCCAia (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Mar 2023 19:38:30 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1AF136E9
        for <linux-pm@vger.kernel.org>; Thu,  2 Mar 2023 16:38:06 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so697616pja.5
        for <linux-pm@vger.kernel.org>; Thu, 02 Mar 2023 16:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VcfZDvVm4xgknbuklXsXdSD5ZB0R1wix+vFAsYNfIKE=;
        b=VjOkE0C9+fP5g1P2e7Sq1Toy1510b9r3NQNzwUd4lceJfWdS5oHAr4FTQYk2wQpmJX
         WAGJ0bsVdBkqMR30Y7NVGNEccohrbagIJdacG/n/lbRLpncp7k6CTU9kq07t/OEONU/V
         1uOMwqPmE2qV3Y1evrIukWhElTZYMAWR8nZN8LdgLFyEVfY+RPfOwZgIh2vfCfNlFGqN
         g9Z48xjg1W+FiXo9Y60fC6uyXBrnzOP6Pere8ZPXuhBaZSh4IhdcdALgfQANeYSb6MPs
         OL+I5Y8NEem3JPW14MEtsMBixvQphfB6tW+aGe6ZfMxzd+9Ft1P1aVuH1wIi5OC/lp1c
         EmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcfZDvVm4xgknbuklXsXdSD5ZB0R1wix+vFAsYNfIKE=;
        b=rebPLpwGWsP9lVH097ydDpoEY/A/BS0nhJILwK1D7VmqAsOq3tLS3dzeYcYur09xxp
         +LbyWyOL2E6G2P3ATiZShD2vKOX/ccj5wKvEXHooWWMpk49JiNUasU48nPlfSC9IXCmE
         pjT/MUagV05Bpy1N7Z6/VTyW7YAAl5t6mJUyC5UKantdZb/l+3jk5KiaJdBu1u7puC3q
         WYNzB1eyIP1BHs/pNnIjTXwxOQIaBgdg3WN9TNoduEm0XLdT2Gia8JX6RGd67CCjKSKj
         EWFOj9UIiup7F+MBHpRZCvZjyYrIsWm+PVJ0mvjaIMN+Sn2f8p1l3F/qJ1ed78udXmiU
         klOQ==
X-Gm-Message-State: AO0yUKWTam2MZnSNItmvJm/QNmwVBP3Pkt7naUs4xESL2zkibCX3QKi0
        LE57BRf6tbD0IqrW1tbgURm+STOoHa4onSeql4QBSA==
X-Google-Smtp-Source: AK7set8ZUETB8jon+NG3TT4zjf+OHnbjSKQeNij98F5TbHRO3Z2PnxCwIWmzrTuqLH0qvVSX83WPP0SJ5h+C+to4bsg=
X-Received: by 2002:a17:902:bd81:b0:19a:b98f:46a0 with SMTP id
 q1-20020a170902bd8100b0019ab98f46a0mr1798311pls.0.1677803886051; Thu, 02 Mar
 2023 16:38:06 -0800 (PST)
MIME-Version: 1.0
References: <20220308082931.3385902-1-shawn.guo@linaro.org> <7da47edd-60ba-d8fc-9d30-4dc0e5969bb2@somainline.org>
In-Reply-To: <7da47edd-60ba-d8fc-9d30-4dc0e5969bb2@somainline.org>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Fri, 3 Mar 2023 08:37:52 +0800
Message-ID: <CAAQ0ZWTx9HpWHwrOryCTtXWAwktkAtSANCk6iVVzas8116=ZYg@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: psci: Iterate backwards over list in psci_pd_remove()
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 2, 2023 at 10:46 PM Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:
>
>
>
> On 8.03.2022 09:29, Shawn Guo wrote:
> > In case that psci_pd_init_topology() fails for some reason,
> > psci_pd_remove() will be responsible for deleting provider and removing
> > genpd from psci_pd_providers list.  There will be a failure when removing
> > the cluster PD, because the cpu (child) PDs haven't been removed.
> >
> > [    0.050232] CPUidle PSCI: init PM domain cpu0
> > [    0.050278] CPUidle PSCI: init PM domain cpu1
> > [    0.050329] CPUidle PSCI: init PM domain cpu2
> > [    0.050370] CPUidle PSCI: init PM domain cpu3
> > [    0.050422] CPUidle PSCI: init PM domain cpu-cluster0
> > [    0.050475] PM: genpd_remove: unable to remove cpu-cluster0
> > [    0.051412] PM: genpd_remove: removed cpu3
> > [    0.051449] PM: genpd_remove: removed cpu2
> > [    0.051499] PM: genpd_remove: removed cpu1
> > [    0.051546] PM: genpd_remove: removed cpu0
> >
> > Fix the problem by iterating the provider list reversely, so that parent
> > PD gets removed after child's PDs like below.
> >
> > [    0.029052] CPUidle PSCI: init PM domain cpu0
> > [    0.029076] CPUidle PSCI: init PM domain cpu1
> > [    0.029103] CPUidle PSCI: init PM domain cpu2
> > [    0.029124] CPUidle PSCI: init PM domain cpu3
> > [    0.029151] CPUidle PSCI: init PM domain cpu-cluster0
> > [    0.029647] PM: genpd_remove: removed cpu0
> > [    0.029666] PM: genpd_remove: removed cpu1
> > [    0.029690] PM: genpd_remove: removed cpu2
> > [    0.029714] PM: genpd_remove: removed cpu3
> > [    0.029738] PM: genpd_remove: removed cpu-cluster0
> >
> > Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> Looks like this was never picked up or followed up on?

Oops!  I thought it was already applied.  I will ping Rafael with a resend.

Shawn

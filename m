Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FA07E0102
	for <lists+linux-pm@lfdr.de>; Fri,  3 Nov 2023 11:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347028AbjKCJVL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Nov 2023 05:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346996AbjKCJVK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Nov 2023 05:21:10 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9FCD46
        for <linux-pm@vger.kernel.org>; Fri,  3 Nov 2023 02:21:04 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5b35579f475so21802277b3.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Nov 2023 02:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699003264; x=1699608064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8yUGJwWjUFhG0kmHn93S//WP4Ss1rDMYRxAiu1Miy5c=;
        b=vOiY5t9/VouTqnqyzxOy/GrHVzDGdm+3ZRUYjUpYjTQzc8PHLPluQDtUKDPKokJHkM
         67CWa6NkH7v5hvfGexp5l0DWw9E+VltiVkyIqz54HZKroQJCtswZnFBZm4aoPD4SCNXG
         m/oMQjr/v1N3J0iyn+A019APUaKzuXrkrOaLLW4szngwkG8cdpU8HTjiCkyJ16MyTESI
         xajzlX/Hpq54PEvwk+8I1cLF5gKtiE8v840aKzERwJ6UrwTlz/6AJGTBaayF9LkuV5T/
         GPblUxtI+4iv0ltr7W70ZLuZvyBx94lrWWEDW8OP9vMbYJ4MEfDfGqdH2S/WOvDEBg6j
         /JmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699003264; x=1699608064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yUGJwWjUFhG0kmHn93S//WP4Ss1rDMYRxAiu1Miy5c=;
        b=Gipufp8+2c9cM46whbG8QywesrVX/plR0W8up/24Ac+UatyqM4pMOjAm09JmK3H6/2
         EmIS8mn2NN3IrHmgvXNstjvb1Rx1a/qNI6odvcPH5OkaJEt4KMD0a42n2dfToJLxE7wK
         CxXeQyhAhH6aoEppyGswmhwqBDzSUMSj9V26TE6gmy4LXjYL44luWK9jpi6uI2kBjfBZ
         H//liCH6KONHYENSU7DhF084XzycTx7JbnlUGns627SHBnG3fwf5XbTUXvOVqp3aD1iq
         eTI4OcJNYrnYD9AivayrkWDEYp/wm5+tcRj2Ni6kNOjbpAS7TW50DU2VqBmm3QHmH9VQ
         +elg==
X-Gm-Message-State: AOJu0Yxq/2+wxRQtLRCEH+LYLNKEmSSzdg6PRpesQ0ijtdfFILuIxkxG
        aVkPsUs2Yy6ovKroJ5lGpfQSW6WK3MB6wnSeKIANaw==
X-Google-Smtp-Source: AGHT+IGVfTFVZn0lSVN3tYQh3Ue+I0LhTn4ErvFF1F/x4t+HAUDarNjQAFKOicdke+qZHhkuhb9FPglk8ojnb1vuZdU=
X-Received: by 2002:a05:690c:d81:b0:5ad:cd52:d6f0 with SMTP id
 da1-20020a05690c0d8100b005adcd52d6f0mr2981404ywb.45.1699003263759; Fri, 03
 Nov 2023 02:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698661048.git.viresh.kumar@linaro.org> <20231103052854.bc7jqaubc5uj6ncj@vireshk-i7>
In-Reply-To: <20231103052854.bc7jqaubc5uj6ncj@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Nov 2023 10:20:27 +0100
Message-ID: <CAPDyKFqLHpmyGhPYZrK_LfHVckgKMybsHS-ggqMpuZSuod4gtA@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] OPP: Simplify required-opp handling
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 3 Nov 2023 at 06:28, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 30-10-23, 15:54, Viresh Kumar wrote:
> > Hello,
> >
> > I wasn't able to test this locally (despite trying to hack it around) and need
> > help from someone who is `virt_devs` field of `struct dev_pm_opp_config`.
> >
> > Pushed here:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/required-opps
> >
> > V1->V2:
> > - Support opp-level 0, drop vote i.e..
> > - Fix OPP pointer while calling dev_pm_opp_set_opp() recursively.
> > - Minor checks and fixes.
> > - Add Reviewed-by from Ulf.
>
> Stephan, Ulf,
>
> Any feedback on this before I merge it ?

I intend to review it within the next couple of days - or at least
before the merge window gets closed.

Kind regards
Uffe

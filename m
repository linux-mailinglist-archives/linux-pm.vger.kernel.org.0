Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FEA518CD9
	for <lists+linux-pm@lfdr.de>; Tue,  3 May 2022 21:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241738AbiECTKn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 May 2022 15:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241733AbiECTKl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 May 2022 15:10:41 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F8B2ED69
        for <linux-pm@vger.kernel.org>; Tue,  3 May 2022 12:07:08 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id i25-20020a9d6259000000b00605df9afea7so11915743otk.1
        for <linux-pm@vger.kernel.org>; Tue, 03 May 2022 12:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=9CGQpWnVnQo7MGm9xTU6pXaEdwhxYD8JsqZkos0xftA=;
        b=kCQSo7SPBG4pQiMa+oHKXJei13jCGwLFxchqNHQRGju6m9P4564X0jrYHeKmrjEL9a
         d1gSyH+NSripPXyzr1fPlDh4U1uCVwPM7TxaJANEWLqz9KbQLvJXnTH8/nl4Kl4vokDg
         lbxqJhbPIfz8uGnJ7dWuf4cCePj0Vcfc2sL5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=9CGQpWnVnQo7MGm9xTU6pXaEdwhxYD8JsqZkos0xftA=;
        b=chp8ERoL9XcVPiJBnD62apQ+x72AS0QLulAq7m4okc5Rk1wBbNdhgV6ioy8cUVlJ+W
         bT6GZwjyHKRz8gpdHI+QxRkTCiE0DqEDawdYYRR+SFsAj7XPwOWPyovdndChAwCHOOvB
         6m4S57eXuUZTMaeekVQ4Ph6KTV6BfziVoer7MMcOHoZFvVoXbWIiYjiP2dQg1vJq8b0n
         K3DGVrzkmXW6DmVOrs+q8gK4fUIOvolBoPraoeioIok2B8+NDpvnnnyRmnUmn9Y8Uem+
         JjI8mPCQLtPAM5Mm8gKjRanZIgFS7mzWPATEptZIzsJAT37EumpaR0tUuDMpBmAxZAlz
         YoiA==
X-Gm-Message-State: AOAM5313Dfb54e1b2E/f5a/Ppa8zrl/O6EzCq+g5Al33QNwCmwKo9XV9
        0yfMzyv44WZ/K2HaYLxzMC91YydRCrINJjExjnC+lg==
X-Google-Smtp-Source: ABdhPJye9eEemAFtR4KgyQT3wFYStWlywE/26JXrKzhMgzQAebZL1VkEQATY6vMwhMBLNcn6h6JRtSLH/6pwCEw+AvE=
X-Received: by 2002:a9d:20a1:0:b0:5e8:d2b6:f63f with SMTP id
 x30-20020a9d20a1000000b005e8d2b6f63fmr6157739ota.159.1651604828022; Tue, 03
 May 2022 12:07:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 May 2022 15:07:07 -0400
MIME-Version: 1.0
In-Reply-To: <Ym/2QJeGHDoZSw8o@dev-arch.thelio-3990X>
References: <20220427013226.341209-1-swboyd@chromium.org> <Ym/2QJeGHDoZSw8o@dev-arch.thelio-3990X>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 3 May 2022 15:07:07 -0400
Message-ID: <CAE-0n519bE6HCK0np-qOrdqATE+buMKu73JQtuFCYeV1pyFcPg@mail.gmail.com>
Subject: Re: [PATCH] interconnect: Restore sync state by ignoring ipa-virt in
 provider count
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Georgi Djakov <djakov@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Alex Elder <elder@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Nathan Chancellor (2022-05-02 08:18:24)
> Hi Stephen,
>
> On Tue, Apr 26, 2022 at 06:32:26PM -0700, Stephen Boyd wrote:
> > Ignore compatible strings for the IPA virt drivers that were removed in
> > commits 2fb251c26560 ("interconnect: qcom: sdx55: Drop IP0
> > interconnects") and 2f3724930eb4 ("interconnect: qcom: sc7180: Drop IP0
> > interconnects") so that the sync state logic can kick in again.
> > Otherwise all the interconnects in the system will stay pegged at max
> > speeds because 'providers_count' is always going to be one larger than
> > the number of drivers that will ever probe on sc7180 or sdx55. This
> > fixes suspend on sc7180 and sdx55 devices when you don't have a
> > devicetree patch to remove the ipa-virt compatible node.
> >
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Doug Anderson <dianders@chromium.org>
> > Cc: Alex Elder <elder@linaro.org>
> > Cc: Taniya Das <quic_tdas@quicinc.com>
> > Cc: Mike Tipton <quic_mdtipton@quicinc.com>
> > Fixes: 2fb251c26560 ("interconnect: qcom: sdx55: Drop IP0 interconnects")
> > Fixes: 2f3724930eb4 ("interconnect: qcom: sc7180: Drop IP0 interconnects")
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>
> This patch as commit ad3cc2f05fda ("interconnect: Restore sync state by
> ignoring ipa-virt in provider count") in -next causes the following
> build warning when CONFIG_OF is disabled because of_match_node is just
> NULL:
>
> drivers/interconnect/core.c:1090:28: warning: unused variable 'ignore_list' [-Wunused-variable]
>         const struct of_device_id ignore_list[] = {
>                                   ^
> 1 warning generated.
>
> Should it just be marked as __maybe_unused or is there a different fix
> that would be more appropriate?

Yeah I think __maybe_unused would work. The other approach would be to
make of_match_node() a static inline that returns false with CONFIG_OF=n
but that's probably a super large change. I hope the compiler would be
able to optimize that whole thing away because the arguments are const
pointers but I don't know.

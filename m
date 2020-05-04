Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216261C48B4
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 23:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgEDVBm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 17:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgEDVBl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 17:01:41 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CDCC061A0E
        for <linux-pm@vger.kernel.org>; Mon,  4 May 2020 14:01:41 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id r1so39941oog.7
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2020 14:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C4pnmV0c/dm6Nv8LiySYrkrUFrQxVYIQ8/fCCGBj3ME=;
        b=AJLldmurbaUk/dT5pTvnHr95+OCQHt8f2LcbXyVAtrwxSiXNAzm/jbddivJGTssLQK
         1CopvPy2PBNrN2MIEP9sJyGs9DhZd7NSglwd3cUDtonBbYbNf6Cx9fs1i2T+K3MshLnr
         fO9qR2ggQeHF3HcC8d+KrQw5iAdjwrhmmT0evp7/yK4mblrSLMKtc8lmeFNVod55ZDF6
         pjmsMyEwp2j1uxlQi9F+zAc82hDhVdiOEZ33hyLBFnsvigf1y/3sFQLEUV942RU27/ut
         Y2ps/n2H8WX8Y5opXM7774yj2JltOgc2e5KX6oy/67ZHDS5uj/pY3ifn37hO8btg1gtq
         vZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4pnmV0c/dm6Nv8LiySYrkrUFrQxVYIQ8/fCCGBj3ME=;
        b=cAjf/yaAnDorfqKuE3Sd7CrsE2PoL5hUhORlIjrQlpA1l4UPi1TOPgg1uX1VbW0hFU
         CbQ9HjsghgMZT71X6zA6DHUSmCH0F1PglCESpgMOoFSJmJGPCnz1dydmmPRvvWCmC/kz
         X9/gGcMfw1fM1BwU8O2flK6xekuBkuhR8NLcLfk5dx/fh6hGxn9rpcqkV7xFoQpq9Oih
         XakJQI0c82/+Q+E2vgx1cAnGcWhqoKCs1yQcc78nIk+Ot1WXDFwdvDc9zT8fas4qZlvU
         7Ka/Qrer7IuQ5zZ9po5byvLxqaw3DVG7NJfGr3tet+IRj8mp6h72B5eUDe7DcTlXsr9Y
         sMPQ==
X-Gm-Message-State: AGi0PuYPOT7KaUza2BRzz0tBbUdmpaBuO9dITKO7c4ivDLzkMo78VtxZ
        YZgA6qXMncF4hGEuD6LtCOGRf7zBtbGeENuNzJt9iw==
X-Google-Smtp-Source: APiQypK8oYJDyP3ObhEIT9SEbws2SoO9/BbsHEmShslZHU9S0WEjfLstz3778FPKfSFcRZWKchUAR+aJlvTfZ7Y/mZo=
X-Received: by 2002:a4a:ca9a:: with SMTP id x26mr194777ooq.84.1588626098771;
 Mon, 04 May 2020 14:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-7-georgi.djakov@linaro.org> <CAGETcx9iAJRW9Y9orHNF-fC53nNob_vZKYUNEpwf_AeAdWCOjw@mail.gmail.com>
 <20200430060901.j7jjw6soo5h5xoul@vireshk-i7> <CAGETcx_zH_KJ7_A7Ofc2M5GfHKX_J__URJB127MSMcTeaqyzjw@mail.gmail.com>
 <20200430075356.rjtctfuenirvhxgn@vireshk-i7> <CAGETcx-W5XjNtgjDz2Ma_miN=cUBb5LFfhzYtKRpf6iAi4bXNw@mail.gmail.com>
 <20200504050017.nsd7fp7gtxxwt3d7@vireshk-i7>
In-Reply-To: <20200504050017.nsd7fp7gtxxwt3d7@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 4 May 2020 14:01:02 -0700
Message-ID: <CAGETcx_3ZrTigJ+CxJFA+N1xZaG9Vg6m0egew+kb-h4jSMsk2Q@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] OPP: Update the bandwidth on OPP frequency changes
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, May 3, 2020 at 10:00 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 30-04-20, 09:32, Saravana Kannan wrote:
> > You are missing the point. This is not about aggregation. This is
> > about OPP voting for bandwidth on a path when the vote can/should be
> > 0.
> >
> > I'll give another example. Say one of the interconnect paths needs to
> > be voted only when a particular use case is running. Say, the GPU
> > needs to vote for bandwidth to L3 only when it's running in cache
> > coherent mode. But it always needs to vote for bandwidth to DDR. With
> > the way it's written now, OPP is going to force vote a non-zero
> > bandwidth to L3 even when it can be zero. Wasting power for no good
> > reason.
> >
> > Just let the drivers/device get the bandwidth values from OPP without
> > forcing them to vote for the bandwidth when they don't need to. Just
> > because they decide to use OPP to set their clock doesn't mean they
> > should lose to ability to control their bandwidth in a more
> > intelligent fashion.
>
> They shouldn't use opp_set_rate() in such a scenario. Why should they?
>
> opp_set_rate() was introduced to take care of only the simple cases
> and the complex ones are left for the drivers to handle. For example,
> they take care of programming multiple regulators (in case of TI), as
> OPP core can't know the order in which regulators need to be
> programmed. But for the simple cases, opp core can program everything
> the way it is presented in DT.

Fair enough. But don't "voltage corner" based devices NEED to use OPP
framework to set their frequencies?

Because, if voltage corners are only handled through OPP framework,
then any device that uses voltage corners doesn't get to pick and
choose when to vote for what path. Also, maybe a one liner helper
function to enable BW voting using OPP framework by default might be
another option. Something like:
dev_pm_opp_enable_bw_voting(struct device *dev)?

If devices with voltage corners can still do their own
frequency/voltage corner control without having to use OPP framework,
then I agree with your point above.

-Saravana

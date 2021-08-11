Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00EE3E9764
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 20:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhHKSOK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 14:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhHKSOJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 14:14:09 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9BCC061765
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 11:13:45 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id o20so5828064oiw.12
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 11:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=V5WHglLnv0tP3zfC+yhvkwyNtvBrV/SwR0eesAKn62U=;
        b=hwOokhJfgA8Q1NrNiSlRyMcNkPDaQB4EOe2hy39eC+AuIwd4/ggS2tEc0fHO5Qmp+Z
         y9KPzOI8Js8v/wII6Rga28g80H9KpIOgnCfYIiW0xNwzwFoBMRvKuZYenFnoJveoQek5
         EERsR88hfvxizbd3GcbhRX/pLyIdUJAvB2V2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=V5WHglLnv0tP3zfC+yhvkwyNtvBrV/SwR0eesAKn62U=;
        b=jNNfQHmJgoxj7LqbAb4oZM+9Se/1miwLL+ivKRfZ8eueClMh969jW4AIGx1CWpL46E
         bSytJJdQylX4weaYPyqmbPpmaZ8a52sfyJR1eS15wlGmV8bFACtC2ZT1WVot4WoiZPdw
         fdws/vbz6Z5YM1S7Qxd0EpuHsgX1ILj6ws7uZfxpbty3wfv8IzMF25+a/KtESJBA/7rz
         HfqFo/dmQAY86sAF3wwBqqk8ibJlKVWJuZkemgaITwp9jlmAKQJgo4dRqhMhjwMxtK8C
         +pn1VWo/RIDovH3oaEHjMQeFWkUfZZpjapcU6gVQT+q3/a+OwftzeE8SLxpH/BnZJ4fy
         seRg==
X-Gm-Message-State: AOAM533k7/MqZ3W9DtxSA3Es84G7VgYBcVmuP4HJ9O5/+Z8UcixJVWVV
        r37Rb0puVv0X70K63225oNpTbq3cH75fDIi0ZsngPA==
X-Google-Smtp-Source: ABdhPJyGT8/mJMEby2FTGsJsH/3yOmOGdPLInfoFlVnHVJiCHdsAVx2+D7Us3p/+8Eau8DxvP3h7N4s5Xe7nXsmjGJo=
X-Received: by 2002:a05:6808:114a:: with SMTP id u10mr147891oiu.19.1628705624806;
 Wed, 11 Aug 2021 11:13:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Aug 2021 11:13:44 -0700
MIME-Version: 1.0
In-Reply-To: <0e659a74-ba52-2262-f7ce-eddf4a655b63@linaro.org>
References: <20210721175432.2119-1-mdtipton@codeaurora.org>
 <20210721175432.2119-5-mdtipton@codeaurora.org> <CAE-0n52iVgX0JjjnYi=NDg49xP961p=+W5R2bmO+2xwRceFhfA@mail.gmail.com>
 <0e659a74-ba52-2262-f7ce-eddf4a655b63@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 11 Aug 2021 11:13:44 -0700
Message-ID: <CAE-0n53GfD-8d0NJ+Hv1wcx0DDACc5_gT3qV0NR-vLiZgtCKpg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] interconnect: qcom: icc-rpmh: Add BCMs to commit
 list in pre_aggregate
To:     Alex Elder <elder@linaro.org>,
        Mike Tipton <mdtipton@codeaurora.org>, djakov@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        saravanak@google.com, okukatla@codeaurora.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Alex Elder (2021-08-11 09:01:27)
> On 8/10/21 6:31 PM, Stephen Boyd wrote:
> > Quoting Mike Tipton (2021-07-21 10:54:32)
> >> We're only adding BCMs to the commit list in aggregate(), but there are
> >> cases where pre_aggregate() is called without subsequently calling
> >> aggregate(). In particular, in icc_sync_state() when a node with initial
> >> BW has zero requests. Since BCMs aren't added to the commit list in
> >> these cases, we don't actually send the zero BW request to HW. So the
> >> resources remain on unnecessarily.
> >>
> >> Add BCMs to the commit list in pre_aggregate() instead, which is always
> >> called even when there are no requests.
> >>
> >> Fixes: 976daac4a1c5 ("interconnect: qcom: Consolidate interconnect RPMh support")
> >> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
> >> ---
> >
> > This patch breaks reboot for me on sc7180 Lazor
>
> If I am using the interface improperly or something in the
> IPA driver, please let me know.  I actually plan to switch
> to using the bulk interfaces soon (FYI).
>

I suspect I'm seeing a shutdown ordering issue, where we start dropping
interconnect requests in driver shutdown callbacks and then some bus
turns off and the CPU can't access a device. Maybe to fix this problem
(if reverting isn't an option) would be to add a shutdown hook to
rpmh-icc that effectively "props up" the bandwidth requests during
shutdown so that we don't have to think about finding the place that the
interconnect is turned off. We're shutting down/restarting anyway, so
there isn't much point in trying to be power efficient for the last few
moments of runtime.

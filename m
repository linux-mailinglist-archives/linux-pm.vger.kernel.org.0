Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDE3227A86
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 10:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgGUIVT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 04:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgGUIVS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 04:21:18 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A6CC061794
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2020 01:21:18 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc9so1214239pjb.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2020 01:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=74cnB8WV/DeG8ebhvgbl1gl2LfYmiA9yZ3/crf8NgJ8=;
        b=vjv+YZ0xo7bDx59HHkmJVxpxxb804vgOrNic7EXsXohB37XDmdDvAkDLDjWUHl1ryq
         TUR7ZVchoL9gVzggDAnFMJjJr685tDFrRySrReEc8Q2L7dC866AzXuJBLs/d98o5eZDu
         t+wVyYg3dIBUMtrSO12IznO74pZhxizVfwqPq48P1DIINB9DpCBfzSoxgoBGuoI8ZsPv
         n68AH2q4cFb+JmNO4pofnMvNzvWmUnUPwY+KmSWxADLcZBalATNrG4XBsY3voIfTQ97p
         GsQN9wA8nbtnVIVSwkfdVsPGiUbdbTQHZxuSDwLMQj1+CK862YkrgsnQB55LZZgw6Ipd
         4pCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=74cnB8WV/DeG8ebhvgbl1gl2LfYmiA9yZ3/crf8NgJ8=;
        b=Jtrq34M+yT1AAZRPrJIMevY+vI3I4Iaua/iVSIqzzE052s37zY1JtFO3bPzQ3ydPEz
         UvhpJGpxVBf2S3+2400OGmEwn6jXlzA394FVJiUfM6SJ8WIzJBsPrEpLign+IPLWb1T/
         wrb2VBkXpVXoV3U215cxTQ1NH75GfRrhcBZBlrmpdjdXbl8utM14taKBwE2G9IGv/Nbw
         4Abjtfwl4hF6CaYVttrUPe2VHnhCaeZZjekG1nw/3GUV/BaWAHC7NOIOH6ZhX0OnyIWh
         /JEy8sge6wsegtP5oRQtYHop3ERlRHDXF/IqW+u/Zuvr7dL0T+82WxKjoIewEW4dNzxT
         7dkw==
X-Gm-Message-State: AOAM533Vwcurd337WdpmKjzRMQIzr0DZzSJh2cwUU3P000vbgczTeBax
        +HOM0zuY7u0KVi2NtmWTAYr5qg==
X-Google-Smtp-Source: ABdhPJw2z2+N0MEss1NXQOPpFBPqV/i3Scy9lXQPLEKMgs7UGAIGKsx3pG54CUXrYnzgC56bil3DTg==
X-Received: by 2002:a17:90a:fa02:: with SMTP id cm2mr3812131pjb.52.1595319678241;
        Tue, 21 Jul 2020 01:21:18 -0700 (PDT)
Received: from localhost ([223.179.133.67])
        by smtp.gmail.com with ESMTPSA id n18sm20123125pfd.99.2020.07.21.01.21.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jul 2020 01:21:17 -0700 (PDT)
Date:   Tue, 21 Jul 2020 13:51:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nishanth Menon <nm@ti.com>, Viresh Kumar <vireshk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: opp: Modify opp API, dev_pm_opp_get_freq(), find freq in opp,
 even it is disabled
Message-ID: <20200721082111.les32oe7hrfikeew@vireshk-mac-ubuntu>
References: <1595235326-6333-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <159531934722.3847286.14813407062714740461@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159531934722.3847286.14813407062714740461@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-07-20, 01:15, Stephen Boyd wrote:
> Quoting Andrew-sh.Cheng (2020-07-20 01:55:26)
> > From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> > 
> > Modify dev_pm_opp_get_freq() to return freqeuncy
> > even this opp item is not available.
> > So that we can get the information of disable opp items.
> > 
> > Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> > ---
> >  drivers/opp/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index eed42d6b2e6b..5213e0462382 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -118,7 +118,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
> >   */
> >  unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
> >  {
> > -       if (IS_ERR_OR_NULL(opp) || !opp->available) {
> > +       if (IS_ERR_OR_NULL(opp)) {
> 
> I wonder why we even have this check. Seems like the caller deserves an
> oops in this case instead of a small pr_err().

I think the reason is same as to why multiple subsystems do similar checks.
While many of them don't do anything if they get a NULL pointer and simply
return, which is fine to support cases where NULL is passed.

But I do agree that maybe we may want to make sure opp-table or opp pointers
passed are all valid all the time and so just remove these checks and let them
crash.

-- 
viresh

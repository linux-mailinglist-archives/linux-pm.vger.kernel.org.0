Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B06251086
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 06:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgHYEYW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 00:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbgHYEYT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 00:24:19 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D26AC061795
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 21:24:18 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id n3so229224pjq.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 21:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WNoNA5qagjn+hJHDWLEGAUu86F/mgyZHandDYgbafhI=;
        b=FG/dbJ6dM9yY2ydqIONvW8BgEZMsFL4E9bpkccz3xeRS5M923Sf/kGBCx3JsoZUQ8Y
         va6T/pyrvWsQeHBUxm+pLVb1zk4+V0dOPkwDRGcHnv6jQxhD6g6APHIujd5/IdLw/uMk
         cMk2Gz1C3IjRyDxcQz5WN+qopA8XnV2/cq6xCERBd/HB+zT774YuHii2kf1uOTiE+p6V
         yA29ngza4Anx/CcLR2zVEg/1te9BN/sxcXs4Q/h0drLAIKDkY8LlTq1A5qwXe6UZGg72
         tbcAHynJuYGKE6dhrAnZezMrVRDvJIPwV2/gTGkP36KNzU1WTC+x+MYebMAkM0sVMxbd
         ZLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WNoNA5qagjn+hJHDWLEGAUu86F/mgyZHandDYgbafhI=;
        b=VIJ5WZJTKAkAaDIsMhVcbC0OncdahuybIdDib6b80GlPEBeqxfpEPMd/CZkSky+egd
         Z951SGAhmxHmW7JMEq4Haa4j6dzphyRUTYn/Mv/9YBfEZx16n8OUBM9n5dt3eHY/7ilH
         i4hJfjBMhjSERyBtFZScLWZi1gwSH2np4xoCuxH0W5+Mr/BqMSB25w/QoxyRslIanb1A
         M01qPl9rD+tjtMvhvUbBTUEpYVlQPtPQmAZLRl/EatiOuLHQKUplS/PsVKDWNbFbMW0/
         bipeAIJmSixw/+GmQDXjgb2WXfTtaGb3Nmj9POz4ntONPOdYPJU3FtZNU0dhEg+A8IAo
         vQfw==
X-Gm-Message-State: AOAM533RuJkbZ+9jIyo/bJTySIa9yjqDl+3KS8en3cSGs9Ep009bzdFf
        cpqKnTiaNH7b1CQgI6hfvNRiMQ==
X-Google-Smtp-Source: ABdhPJz1C07dDr73P9yjNL0m73i3bg1BovXril3uSAZ4HQAGSqR1SqwiW6VLTGUkobN948gWSJC4Tg==
X-Received: by 2002:a17:90a:9288:: with SMTP id n8mr43088pjo.137.1598329458005;
        Mon, 24 Aug 2020 21:24:18 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id f195sm12741963pfa.96.2020.08.24.21.24.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 21:24:16 -0700 (PDT)
Date:   Tue, 25 Aug 2020 09:54:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH - for v5.7 stable] opp: Put opp table in
 dev_pm_opp_set_rate() for empty tables
Message-ID: <20200825042414.n2hoahplhjdhwmgy@vireshk-i7>
References: <e7e9f887328c06800a79f3b48feb623fd15aa3d5.1598261323.git.viresh.kumar@linaro.org>
 <20200824161021.GD435319@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824161021.GD435319@kroah.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-08-20, 18:10, Greg KH wrote:
> On Mon, Aug 24, 2020 at 03:00:03PM +0530, Viresh Kumar wrote:
> > From: Stephen Boyd <swboyd@chromium.org>
> > 
> > commit 8979ef70850eb469e1094279259d1ef393ffe85f upstream.
> > 
> > We get the opp_table pointer at the top of the function and so we should
> > put the pointer at the end of the function like all other exit paths
> > from this function do.
> > 
> > Cc: v5.7+ <stable@vger.kernel.org> # v5.7+
> > Fixes: aca48b61f963 ("opp: Manage empty OPP tables with clk handle")
> > Reviewed-by: Rajendra Nayak <rnayak@codeaurora.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > [ Viresh: Split the patch into two ]
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > [ Viresh: Update the code for v5.7-stable ]
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/opp/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This is already in the 5.7-stable queue, why add it again?
> 
> confused,

Because I received an email from your bot that it failed to apply to 5.7 stable,
rightly so as the patch was required to be modified.

-- 
viresh

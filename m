Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6533847A
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 04:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhCLDu2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 22:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbhCLDtv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 22:49:51 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6036CC061761
        for <linux-pm@vger.kernel.org>; Thu, 11 Mar 2021 19:49:51 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id z5so11294750plg.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Mar 2021 19:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iClR6zNoYi1tdWvry+Z+GUDxBYD0gbeye1VeSZY/vbw=;
        b=nQ9nVaAjkMgb+JuywXQnMMRSNJsrArWT9wZe0Zt4UQcm027HVtc9YmUY0Tgq6pB75n
         avK7mjuDcA6fHWOOKt16Bn6zzPsVXHfXglJLiMuchEDS6iKrGF1BJQ0dsWTentn0DKT0
         RiexBqsQv2mJqfbO8ZCxs8a0Y7+eGkUf4f4UMuSN4XtC2kgNqdJNnnS4B0+LcRsySYrI
         H/54aXYJ+eCSCPLQnLIWnZV6s3uVGake/hY+nXeOmSREonL8Kkaf0VNEIy7kfTaZ/pCP
         xYZuWJSjxST95dEnRYgfh9eYdYRIxgg+QpzRz3snWYZXW3wTl1rPE5YbDXPqpkdliCyH
         b2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iClR6zNoYi1tdWvry+Z+GUDxBYD0gbeye1VeSZY/vbw=;
        b=reWTLkL0anKtbXu6/z0zX83ziUd9vaLEyHghHf6k+FW4nBi5DzNYroNdlPf5Z7iiXK
         E35iKRzOeSI6bMNzHUTPmNOlcG/gClEq7ArYR37YGlqTOLsfbSe1oA8hs5ZWXCYuZrrG
         sUtUoZl7UR1jyk1Y0GLABdDG+wrNoEprF4qNOsHwSQe1lj5WkQMq772ApcInQS6/Tthy
         Yi6LMYv3FQfChReDb8HG+IHyCgig756DN+oZOW1WD9ial3/ioL/P6Cmpy+qIuwJ3qQ4c
         bxluBxEXvN3iCRqNVnLePeiqPBkGOmokhvqaIJ0/FH8QSwGiJi7n/jhUDPaXaRtV+mKR
         d9Kw==
X-Gm-Message-State: AOAM530IOmgO2w/N0Amv8QnZEqsWjhvSCHyPOOrUGHsNWVu/rMYxb4fO
        ujWQ9GS1bbDcTYwpHUoZw5KeYg==
X-Google-Smtp-Source: ABdhPJx1/YXBd5rjm1d6Lv3nqKUlMq082FYhUb2KfFzoFV4X/hbMyfw19avz6xZ5rBO4iKEs9shvNw==
X-Received: by 2002:a17:90a:400f:: with SMTP id u15mr11904527pjc.80.1615520990723;
        Thu, 11 Mar 2021 19:49:50 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id v35sm3454767pga.3.2021.03.11.19.49.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 19:49:49 -0800 (PST)
Date:   Fri, 12 Mar 2021 09:19:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Subject: Re: [PATCH] opp: Invalidate current opp when draining the opp list
Message-ID: <20210312034942.jh3txxoowbo2ekyn@vireshk-i7>
References: <1614870454-18709-1-git-send-email-beata.michalska@arm.com>
 <20210305042401.gktrgach4dzxp7on@vireshk-i7>
 <418fc3cb-d5ec-9216-269a-e055e78718e5@arm.com>
 <20210308115053.ua2gfo6kfnfjslyd@vireshk-i7>
 <20210308181446.GA26783@e120325.cambridge.arm.com>
 <20210309043121.546mlvl4jmshogor@vireshk-i7>
 <20210309121455.GA13095@e120325.cambridge.arm.com>
 <20210310084738.pe7ppyeq6hn7wbvv@vireshk-i7>
 <20210310230300.GA26976@e120325.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310230300.GA26976@e120325.cambridge.arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-03-21, 23:03, Beata Michalska wrote:
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index c2689386a906..150be4c28c99 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -1492,7 +1492,11 @@ static struct dev_pm_opp *_opp_get_next(struct opp_table *opp_table,
> >  
> >  	mutex_lock(&opp_table->lock);
> >  	list_for_each_entry(temp, &opp_table->opp_list, node) {
> > -		if (dynamic == temp->dynamic) {
> > +		/*
> > +		 * Refcount must be dropped only once for each OPP by OPP core,
> > +		 * do that with help of "removed" flag.
> > +		 */
> > +		if (!temp->removed && dynamic == temp->dynamic) {
> >  			opp = temp;
> >  			break;
> >  		}
> How about tweaking the _opp_get_next to use list_for_each_entry_continue
> instead ? It would eliminate the need of tracking the 'removed' status
> and could save few cycles as it wouldn't have to go through the list
> starting from it's beginning each time it is being called.
> Happy to draft another version.

I tried that as well, but the problem is that we need to drop locks in
between and if the next OPP somehow gets freed or another one gets
added there, we can be in trouble. To make this work without any side
effects, the new field was kind of required.

-- 
viresh

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7600C2AB058
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 05:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgKIE5p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Nov 2020 23:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgKIE5o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Nov 2020 23:57:44 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B92C0613CF
        for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2020 20:57:43 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id c20so6961523pfr.8
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2020 20:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FyxKjiZ7wGO9C/98D++nuGu+ry1VQp8BcqI9FcWr6AY=;
        b=RFMbsOm5+b/YkDxzKr40E/wqin22/AhBOE2lwZLG0UQH0AHXwHyRlL1bLgnZWKS2xC
         rPknSvmYqEy+TQV2VWHpgzPz2KTZp3NT1+PIPhpkknp6MDqLPt3ZdfjJgW1D04ue2h3A
         Zkwy+Yi+kYtICK33XlnaUjLsllIVPgXtyAh6878rxTFij9SxZ5enpfPSQQQuCp3wbRIn
         fHrGKUyR71w6HcMhMaLKEuvhzNUy+wdZt0GZhkW3Q1D22EyKTD/NbRFJTcp2S6RCT2ol
         3kzrPKgCimOeaaem2YlEukRl1NhVDQYvDxaY5h2K954VBqJjLuEVQUwL34CqGBw4inIN
         MeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FyxKjiZ7wGO9C/98D++nuGu+ry1VQp8BcqI9FcWr6AY=;
        b=WRXx9V34CQxy90veWYJfJPQc5cDOnOnru3ssPEzKaxnnhuXt8OKpejS1X1q7DsaCEa
         8+aWkDjTwnMp6at4oLENGrfp4JaYgi/8SYcWh1Cz3Gg4SjXRWXgQN8hLOh2j7bjPnpIa
         tG+oqTS2IQNHNoMJ6rCPgnncpVLGWMLnwoH+7jtak9PoAalaADux37c9c2Dkf1BGT5ag
         WE6HBpPjDLEaElPx9Yq3fuS+2q0P5DKKcTOZKKIS44xGWzvd5AFfoXHoTRB7YD/1I3Wx
         jTckxVt3nWFbXpkx2k12jb5DjG4CJ/hEP9iJS+0iRaTPOG6m+W+5uuQMqPCCnT4QqOhE
         CmlQ==
X-Gm-Message-State: AOAM533Hgl2lygoKJRtwUIrowOVxmvAMwe8QaQDDVpf+DuN44QnwLgcn
        leKBYEbn5Qzj0Nm8oYALJpiTTA==
X-Google-Smtp-Source: ABdhPJwM7NF2hWFK9jNfXuDydeaQkSV9pyoWCNDS21hcvCy9gJU7JIjTinuuWKcwD6sHGBdIXToDrA==
X-Received: by 2002:a17:90a:b88f:: with SMTP id o15mr11062332pjr.94.1604897863092;
        Sun, 08 Nov 2020 20:57:43 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id u197sm4610861pfc.127.2020.11.08.20.57.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 20:57:42 -0800 (PST)
Date:   Mon, 9 Nov 2020 10:27:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] opp: Don't create an OPP table from
 dev_pm_opp_get_opp_table()
Message-ID: <20201109045740.y5kpd6tjscoqxhi5@vireshk-i7>
References: <684ff01900180c0a40ec307dacc673b24eab593b.1604643714.git.viresh.kumar@linaro.org>
 <1012a98950355bd5a52424668050a17c3430cbe0.1604643714.git.viresh.kumar@linaro.org>
 <ec9839dd-5d2d-0d6b-6563-b14da4af1a57@gmail.com>
 <20201109043457.xf55kufhjjz2fvct@vireshk-i7>
 <c5078503-ee14-0f84-85fd-9c6e55d2e897@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5078503-ee14-0f84-85fd-9c6e55d2e897@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-11-20, 07:41, Dmitry Osipenko wrote:
> 09.11.2020 07:34, Viresh Kumar пишет:
> > On 06-11-20, 16:18, Dmitry Osipenko wrote:
> >> 06.11.2020 09:24, Viresh Kumar пишет:
> >>> It has been found that some users (like cpufreq-dt and others on LKML)
> >>> have abused the helper dev_pm_opp_get_opp_table() to create the OPP
> >>> table instead of just finding it, which is the wrong thing to do. This
> >>> routine was meant for OPP core's internal working and exposed the whole
> >>> functionality by mistake.
> >>>
> >>> Change the scope of dev_pm_opp_get_opp_table() to only finding the
> >>> table. The internal helpers _opp_get_opp_table*() are thus renamed to
> >>> _add_opp_table*(), dev_pm_opp_get_opp_table_indexed() is removed (as we
> >>> don't need the index field for finding the OPP table) and so the only
> >>> user, genpd, is updated.
> >>>
> >>> Note that the prototype of _add_opp_table() was already left in opp.h by
> >>> mistake when it was removed earlier and so we weren't required to add it
> >>> now.
> >>
> >> Hello Viresh,
> >>
> >> It looks like this is not an entirely correct change because previously
> >> it was possible to get an empty opp_table in order to use it for the
> >> dev_pm_opp_set_rate(), which would fall back to clk_set_rate if table is
> >> empty.
> >>
> >> Now it's not possible to get an empty table and
> >> dev_pm_opp_of_add_table() would error out if OPPs are missing in a
> >> device-tree. Hence it's not possible to implement a fall back without
> >> abusing opp_set_regulators() or opp_set_supported_hw() for getting the
> >> empty table. Or am I missing something?
> > 
> > For that case you were always required to call
> > dev_pm_opp_set_clkname(), otherwise how would the OPP core know which
> > clock to set ? And the same shall work now as well.
> 
> Why _allocate_opp_table() grabs the first default clk of a device and
> assigns it to the created table?

Right, it was there so everybody isn't required to call
dev_pm_opp_set_clkname() if they don't need to pass a connection id
while getting the clock. But for the case of supporting empty OPP
tables for cases where we just want dev_pm_opp_set_rate() to act as
clk_set_rate() (in order for the drivers to avoid supporting two
different ways of doing so), we do need that call to be made.

We need to add the OPP table explicitly and what happened with
dev_pm_opp_get_opp_table() was accidental and not what I wanted.

drivers/mmc/host/sdhci-msm.c has an example of how this is done.

-- 
viresh

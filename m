Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E412AB033
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 05:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgKIEfC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Nov 2020 23:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIEfB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Nov 2020 23:35:01 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A584FC0613CF
        for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2020 20:35:01 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id g7so6919132pfc.2
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2020 20:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VgMOvNA1Ux0qxEI6TA4rcW3mQnTnYdI0FfzgJi/p7s4=;
        b=jJuZvUmBexr8zx1mQzYCuZOVUssmQpohGfQ9N4nQcSoDPF5PZUHuhumYc7I0DV5++z
         7nZE+VKCiHjvHJAZLto/qmTwczNztEBpFEmgF1tWM7qFwhD7Ang2SZF8pQMziLCgferf
         8DoYY4lk0fjfNbrBxcb7VCha3tPcLfiSiyAV3IklHgqD74CQK4LolzVUdtdMcBKQdBFm
         eQebTPyELwDAv7iSKtucHw6PV47iIyizo14I6MnX06j+M+HNHxj2IShOoyniyDuBiYkO
         j/708WAWdZVHYG15zUCCH6RsjVvn3FDc3M4BHKyijcKdpPCQgJGTRzN2AXKKezSd6Btp
         fDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VgMOvNA1Ux0qxEI6TA4rcW3mQnTnYdI0FfzgJi/p7s4=;
        b=WLudiy66mDX/bMDRIwyBlleHM8myETMWuhHvCEbWSl0NOZbNe51lF3YWQ9yh8maGG0
         oBLwhYPZ0xROpc5N2fbwYnXXfO7sDXrvwdY+7uGrxehALoiU/yLwb0UzHXS0enT1gV81
         nVLp6pxITBrWPT9fDcnOXzn6WRDc+9fxBbJ2lX883/RQUyituOfLpkkxWQlZ3jRg2tN+
         hcyWMP0/s8h9aKIOvBELOYKI2f25vCOmGL2nLg4ACxSsqPESbm8FIilNs6ZYfdM60w9j
         w4iMLG00e+rt58dK3IaJLq8CUsq7EqVWstHF7YKaL3C0vEyx+Yijp0/6+yh3f9THbp0r
         p7Bg==
X-Gm-Message-State: AOAM530BD9EDnCJA+b+LU7/uhDwbFbVLE44Gdv9dBsmJUxusSYXipoMS
        Iljk+BOOSt67DFN6ahwZUzkSSQ==
X-Google-Smtp-Source: ABdhPJxd85Plq4wIvoEwgdYY6MZLWrgW8Un9rDIMBb1x2J7AsBgFbBTD9DaCZ9TtYT9Gw8RA6RDF2w==
X-Received: by 2002:a63:2145:: with SMTP id s5mr10709145pgm.288.1604896501055;
        Sun, 08 Nov 2020 20:35:01 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id 82sm8220532pfv.149.2020.11.08.20.34.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 20:34:59 -0800 (PST)
Date:   Mon, 9 Nov 2020 10:04:57 +0530
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
Message-ID: <20201109043457.xf55kufhjjz2fvct@vireshk-i7>
References: <684ff01900180c0a40ec307dacc673b24eab593b.1604643714.git.viresh.kumar@linaro.org>
 <1012a98950355bd5a52424668050a17c3430cbe0.1604643714.git.viresh.kumar@linaro.org>
 <ec9839dd-5d2d-0d6b-6563-b14da4af1a57@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec9839dd-5d2d-0d6b-6563-b14da4af1a57@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-11-20, 16:18, Dmitry Osipenko wrote:
> 06.11.2020 09:24, Viresh Kumar пишет:
> > It has been found that some users (like cpufreq-dt and others on LKML)
> > have abused the helper dev_pm_opp_get_opp_table() to create the OPP
> > table instead of just finding it, which is the wrong thing to do. This
> > routine was meant for OPP core's internal working and exposed the whole
> > functionality by mistake.
> > 
> > Change the scope of dev_pm_opp_get_opp_table() to only finding the
> > table. The internal helpers _opp_get_opp_table*() are thus renamed to
> > _add_opp_table*(), dev_pm_opp_get_opp_table_indexed() is removed (as we
> > don't need the index field for finding the OPP table) and so the only
> > user, genpd, is updated.
> > 
> > Note that the prototype of _add_opp_table() was already left in opp.h by
> > mistake when it was removed earlier and so we weren't required to add it
> > now.
> 
> Hello Viresh,
> 
> It looks like this is not an entirely correct change because previously
> it was possible to get an empty opp_table in order to use it for the
> dev_pm_opp_set_rate(), which would fall back to clk_set_rate if table is
> empty.
> 
> Now it's not possible to get an empty table and
> dev_pm_opp_of_add_table() would error out if OPPs are missing in a
> device-tree. Hence it's not possible to implement a fall back without
> abusing opp_set_regulators() or opp_set_supported_hw() for getting the
> empty table. Or am I missing something?

For that case you were always required to call
dev_pm_opp_set_clkname(), otherwise how would the OPP core know which
clock to set ? And the same shall work now as well.

-- 
viresh

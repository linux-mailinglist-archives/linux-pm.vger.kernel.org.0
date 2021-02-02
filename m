Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5259630B6C9
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 06:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhBBFDO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 00:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhBBFDO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2021 00:03:14 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD36C06174A
        for <linux-pm@vger.kernel.org>; Mon,  1 Feb 2021 21:02:33 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id s23so12846694pgh.11
        for <linux-pm@vger.kernel.org>; Mon, 01 Feb 2021 21:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YMR86T3Gc6PsNY4CGRu+69YTjjxr1NKCD/l/Q/MYNy8=;
        b=hcQy32WgCqN0GXIdDrGBGy/WTHjIzrUl/seYuooQcfy5jHsu0WMWgIn5d+vguKU973
         hfy+D6NOowsrzLgHhmhSPX8LJecCM6odoLcb67yRVOG66vLM/z9UQbhmOyw/SE1+2jE8
         LCIGSadyZo84XwfVlVsE6GZ4X4bhXoomttoUv+LLCob6rtAJV5QHWilVhwSwLy6cQgSB
         2z/jyYBkIJMs6CX5+Jmu2EWaIO6YwjBHhOV0P4BEaSsvf3WDw/H6zBDfaBqBE9RUcyMp
         T+1s/tsZ6Nf1D2djGNpOjmymeJvGwFh/FoH3R34S69kdbtA5r1puMsQiLhP3MvxieUnm
         PCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YMR86T3Gc6PsNY4CGRu+69YTjjxr1NKCD/l/Q/MYNy8=;
        b=rtJyXYnYL0S/u5vIiwUUiuQLEXzAsiTfw+BL+DAjIWvtEcH+IrP+Lqutmfk1ynHu1k
         oss8hVY+f4LiXxpegcJqxxyD++OVx47SdvwRZbB9AnQs0rti3YbNZU00Vu/I0Y2S1Ov/
         0GxrKSnBwX+Vh5q439E03eNoYKjll7jLjv7gyPEF8obTjTm7ow884ZmDFRnw6KJmdy5A
         wV+9CRynHJZ2x8Cln93BHt0L1Uix6/OIQ4J1Ait09hsmjtejB/LxjkoKhhFM+KBIHCWu
         Yj3NIuS7RUiYlJwmdlTtbVjUnyJr4EYfHcwjO3Bss2sb4MQpiqDjn3MvHqVE/2t1GKGD
         oW8g==
X-Gm-Message-State: AOAM532gUJVilmd2UnQtzttTcmiQv33xF3mM7UvVz5hemAVrNcOtUOI0
        tYfALICJqNI0ZP6Gey0zEpViMA==
X-Google-Smtp-Source: ABdhPJxDHiVY99Lo60dBoHtnbnvFFpP2sePoqsmOReNWkh7a4isbbo8kg2wPefgPJXE6wR0oVgS6zw==
X-Received: by 2002:a62:8012:0:b029:1b7:c65b:92f2 with SMTP id j18-20020a6280120000b02901b7c65b92f2mr19156594pfd.23.1612242153252;
        Mon, 01 Feb 2021 21:02:33 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id y22sm20270296pfr.163.2021.02.01.21.02.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 21:02:32 -0800 (PST)
Date:   Tue, 2 Feb 2021 10:32:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] opp: Add dev_pm_opp_of_add_table_noclk()
Message-ID: <20210202050230.g7xxo6373stfvzbi@vireshk-i7>
References: <1b58a72fa4d6aadc9542a66f8150150534752d81.1611817096.git.viresh.kumar@linaro.org>
 <a251d7a7245a2ded97b282b8dfda95359698bf22.1611817096.git.viresh.kumar@linaro.org>
 <72a546c5-8a7b-af8c-43aa-5344073f8623@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72a546c5-8a7b-af8c-43aa-5344073f8623@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-02-21, 23:00, Dmitry Osipenko wrote:
> 28.01.2021 10:00, Viresh Kumar пишет:
> > A few drivers have device's clk but they don't want the OPP core to
> > handle that. Add a new helper for them, dev_pm_opp_of_add_table_noclk().
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > V2:
> > - Split this into a separate patch.
> > 
> >  drivers/opp/of.c       | 18 ++++++++++++++++++
> >  include/linux/pm_opp.h |  6 ++++++
> >  2 files changed, 24 insertions(+)
> 
> For the all current/latest OPP patches:
> 
> Tested-by: Dmitry Osipenko <digetx@gmail.com>

Hmm, I have now added your Tested-by to all the patches that we worked
together on.. 

Thanks.

-- 
viresh

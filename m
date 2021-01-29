Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5B1308BEE
	for <lists+linux-pm@lfdr.de>; Fri, 29 Jan 2021 18:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhA2Rtc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Jan 2021 12:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhA2Rq6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jan 2021 12:46:58 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C22FC061573
        for <linux-pm@vger.kernel.org>; Fri, 29 Jan 2021 09:46:11 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id s23so5912822pgh.11
        for <linux-pm@vger.kernel.org>; Fri, 29 Jan 2021 09:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YvooiHEr081BMnr73xMgUGyshJjAwTDDQTznTrGK/+4=;
        b=KYL++0LwqZuvIn8n71YlhmZyh0idzKaFQkbQk4Bgjqa/nE+9WQFM++GQJxjwSBsUJJ
         zk12PA0N6l8/oAEqBCiUl320O/Ukjv2MrPQMNRf83op9n64TXBKOI3k1nuQAuBG+/UNk
         Omr/jNzAnWdGvmPrPAkGYjRVxS0RCZICUPJNfw2IOlD80oQ0sgGTNk2qtYPbq/lCg3xY
         11twaeBlyAPOw+Efb9JPELFRA0Yb6BFTwG7QOj/nBpsvevimgUjSw+psxl8yU476/x/w
         WdG1aSQULxjl2mejfPXhcrOhc1rAJrQ6LBBJ8DUdiGla2dI4RBOdltG9zz0Sypd4SR9R
         TuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YvooiHEr081BMnr73xMgUGyshJjAwTDDQTznTrGK/+4=;
        b=tCiu1cHoNdJfbtBi6YcqV+0yZ61ZyD3+qA79+QvD2w+mnGqsO7l32mU9A2cH8wODLF
         8i4gQKxAMDpAVmun0iGNmLNhiRzHcT2fqe36H6c2cbEgU0JtXVkIju0pIEXi+TnG15GB
         Lpc0bk6oA9OvJ2zbyeilyeJttWO2lQeg1yeiQL6jhUL6iep/XjmXzafFJMGG1C53BPtI
         KjG4LE9EZY/zqDR1vBUFfUawFJTw87kQRtjzGeMksGBAbSY/NTL+wSh14a1AaddSR7Hu
         fXBEleSDJuu//d+K7oQuyad8QPRpicodPAkTgBBFsOfEqmgiT91bde3HZJd/WqYgm7xj
         MBUg==
X-Gm-Message-State: AOAM532wP9To7IzNmeuXoeejfI8PRJuI+HcUr57Mo6q9d8/tNTWFun3B
        9LhkG4MbYJg7TC0QH3eQKIZCjQ==
X-Google-Smtp-Source: ABdhPJy0GTzGE0h7NzRnlIuyiRC9ZQI4dBknJxwAFnRAYGn8AVBvb7jghTDUMsvBtDFXm6hm8iVlyA==
X-Received: by 2002:aa7:8497:0:b029:1bf:47c6:523a with SMTP id u23-20020aa784970000b02901bf47c6523amr5491081pfn.0.1611942371007;
        Fri, 29 Jan 2021 09:46:11 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id w11sm9766944pge.28.2021.01.29.09.46.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jan 2021 09:46:10 -0800 (PST)
Date:   Fri, 29 Jan 2021 23:16:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Don't ignore clk_get() errors other than -ENODEV
Message-ID: <20210129174608.owianuy6yj5m6fgl@vireshk-i7>
References: <28d24b4c5b9ceabbd32b7b312dee050992610be9.1611917396.git.viresh.kumar@linaro.org>
 <49983ca1-feb3-48f5-bdf5-b2f39c963a74@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49983ca1-feb3-48f5-bdf5-b2f39c963a74@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-01-21, 18:23, Dmitry Osipenko wrote:
> 29.01.2021 13:51, Viresh Kumar пишет:
> > Not all devices that need to use OPP core need to have clocks, a missing
> > clock is fine in which case -ENODEV shall be returned by clk_get().
> > 
> > Anything else is an error and must be handled properly.
> > 
> > Reported-by: Dmitry Osipenko <digetx@gmail.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > Stephen, is the understanding correct that -ENODEV is the only error
> > returned for missing clocks ?
> > 
> > Dmitry: I hope this is on the lines of what you were looking for ?
> 
> Viresh, thank you! This is not what I was looking for because clk core
> doesn't return -ENODEV for a missing clock, but -ENOENT. The ENODEV
> certainly should break drivers.

My bad.
 
> I was looking for this:
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 0305861fee1b..3dd9cdbc0e75 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1264,7 +1264,7 @@ static struct opp_table
> *_update_opp_table_clk(struct device *dev,
>  	if (IS_ERR(opp_table->clk)) {
>  		int ret = PTR_ERR(opp_table->clk);
> 
> -		if (ret == -EPROBE_DEFER) {
> +		if (ret != -ENOENT) {
>  			dev_pm_opp_put_opp_table(opp_table);
>  			return ERR_PTR(ret);
>  		}

You should be looking for this instead, isn't it ?

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 049d45e70807..4bfcbe5b57af 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1268,7 +1268,7 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
        if (!ret)
                return opp_table;
 
-       if (ret == -ENODEV) {
+       if (ret == -ENOENT) {
                dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
                return opp_table;
        }


-- 
viresh

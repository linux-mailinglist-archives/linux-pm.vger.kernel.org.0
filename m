Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0AB2FCBCB
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 08:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbhATHkD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 02:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbhATHjz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 02:39:55 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E220C061575
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 23:39:15 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id j12so6818833pfj.12
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 23:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=c5W9HTV4ZUg3nj2NFCAAbwtU0pgjpXW7Cc6ji/9Up+Q=;
        b=NGQhmaAuVmTRmZ7B7R5DYxNsn4MKeNDRq2cdJO0FHJilzvxiFipzAfUtXcJUVrBV8U
         4H3XL3pM4cru/Im5s61GjBfEISSMInxvS9YWGkUdtaOcxTFhc4Rs22Ph390R+MMVc6s5
         Xz8u+F2Jz6EOYzR6nENXbXT6pPuEPVvrivG5BEsE55VS9qXB/lCfaOY4cUSItvzlHDJc
         RU4oJijPmpMxVvKviXUTzMYYycBwUqgPs85DEmqqjjTnSrkp1E/s9jLyXlZAPFxgAKz/
         rRfNBe/zgFivA5FA3GJE7+zTPK2ESKSMUWVD65kBqdo4nIz/SFz1EwN8jmR0NHe8xnLg
         JeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=c5W9HTV4ZUg3nj2NFCAAbwtU0pgjpXW7Cc6ji/9Up+Q=;
        b=gnHLd8Q1tKAvXvh4eWe+omehwOz6O81rb5j6Q7BbvXzhBg0JjNoCDlhiy1WVTctfbh
         HuijRurm7Pz+44lTJ/KlDy/gOK19RGbUc1ZSJsDSRgPr7iFzMgbH70iU1+DO2Bdr9ZnX
         M2bMz1Y+4FQ2+7DBXUn+y3298JrI4ACcnOOFsYfismH+3dFOoNfnmVKNraaeI/yoPUrO
         NVe5wfo0rne66h4tRO1vV46IL2gwEoL9SAsaVe+yvzisHZWCZs5svOxUbFlRWY+EExNN
         7wc/R+BbbFUcAau60/qRTWmHHihrUXNEnQhd17TpbktjOpgWiNTxBct4NjuapuNB+31M
         ifQg==
X-Gm-Message-State: AOAM533sJoKviTtXOe2jaHUs8VAsnkx2wGIwsbUrbZpBgnRQpYh8+VLQ
        ywZJo0AXsrO7TGQYOsMG0Ubl7w==
X-Google-Smtp-Source: ABdhPJyi7pDcTfCjj8lDyzZ5io4YygHqpt470QGHSaW9p3ziuvuai1Bm9kVo88zy88tBHI9EHn8xQQ==
X-Received: by 2002:a62:e312:0:b029:1b6:cbbd:63e9 with SMTP id g18-20020a62e3120000b02901b6cbbd63e9mr7988186pfh.35.1611128354980;
        Tue, 19 Jan 2021 23:39:14 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id u12sm1207254pgi.91.2021.01.19.23.39.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 23:39:14 -0800 (PST)
Date:   Wed, 20 Jan 2021 13:09:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Prepare for ->set_opp() helper to work without
 regulators
Message-ID: <20210120073912.yl4rgkthdyyznbfh@vireshk-i7>
References: <fb69353c-a35b-9b7c-46bc-d464c6dab6f5@gmail.com>
 <302c014726dbd9fcde852985528c139d2214a1f2.1611038066.git.viresh.kumar@linaro.org>
 <c657b5b0-b841-1b26-8008-2fb4b490d63d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c657b5b0-b841-1b26-8008-2fb4b490d63d@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-01-21, 20:16, Dmitry Osipenko wrote:
> 19.01.2021 09:35, Viresh Kumar пишет:
> > +	mutex_lock(&opp_table->lock);
> > +	opp_table->set_opp_data = data;
> > +	if (opp_table->sod_supplies) {
> > +		data->old_opp.supplies = opp_table->sod_supplies;
> > +		data->new_opp.supplies = opp_table->sod_supplies +
> > +					 opp_table->regulator_count;
> > +	}
> > +	mutex_unlock(&opp_table->lock);
> 
> Why do we need all these locks in this patch?

In case dev_pm_opp_set_regulators() and
dev_pm_opp_register_set_opp_helper() get called at the same time.
Which can actually happen, though is a corner case.

> The OPP API isn't thread-safe, these locks won't make the API
> thread-safe.

I am not sure what you mean by that, can you please explain ?

> At least both sod_supplies and set_opp() pointers should be
> set and unset under the lock.

The ->set_opp pointer isn't getting used for a comparison and so
putting that inside a lock won't get us anything. We are only using
set_opp_data and sod_supplies for comparison at both the places and so
they need to be updated within the lock.

-- 
viresh

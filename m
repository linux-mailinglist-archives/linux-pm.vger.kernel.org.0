Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6456E11B3
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 07:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbfJWFaL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 01:30:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38061 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732167AbfJWFaK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 01:30:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id c13so954825pfp.5
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2019 22:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2rDF05/6n06417wlJVscVUcvibGyzQU00P9mXQIXKPI=;
        b=unyYhVkChYE/uDac0HDbcWN0G8GoHP0zxWY0fxtb/LUoGEbwhJnX7Hq4/MHWxVy0GI
         55H5/ynS1xRqnl675xUK6TOKQbmqdwH403PiCwfecCtzIWLiuQ0Hih64KGKiQcs1moN4
         rmaSUaxUfu1MBS/4nKdguaTTHWlr/AE2gAnOFCZoCY+k2yxizr5uv3QofF1JssrjF177
         g0msVuAH6XdCkxKodaYqaow5W6ZPZTpLu3b1pJ8yn7bKa19VfzWEM/XHUj7yb7uI99f8
         kJFdIJIE2CC7nT7/TqQGv0aN1DbEeoFYAwp9A9K9g8BBGzMVTNqZKZT6sIMOoi6GS7dE
         kD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2rDF05/6n06417wlJVscVUcvibGyzQU00P9mXQIXKPI=;
        b=aeF3By1Gg++USbKWwsiAmCYDgevVFuci6buNwgJalzRU8dDVkHHrByxJ706Z1/EvN6
         X0dZmtha4lnaywYiCVZK93wn2UJvsQR8JXrtDFHVgMuj8cEtHMqGK6BNthhNGEW5u04B
         iXW2DQbu7HdUsgFq55hvXalsNeNpicO5Nx7omAAkSaNKzF1DUpk/jTmzEWvLxTXYUzNm
         dotcQLbyGDYWQjx/u2LLfT/NbRGgT0tbbpuo76jtOKhizNYl7JEudqmucOZqTPwJ7Vbz
         pURapToUb4JlIXGTxhhTQAuLqzRlor0I73FpQgNDW7cLmeUfBTV1TzbFx5/hEUPsFAMM
         h8eQ==
X-Gm-Message-State: APjAAAW5STQFIW9ex98+6EYiGC9vklCK+qI3NmUI9F7nBuOY3of/g0rB
        2aW4iMmPNauknwJjc3E0LqX2Bw==
X-Google-Smtp-Source: APXvYqxRwNayP0aERsMuW4AmJWpia1ARqwMiw0nTvlpYpmTN1wiwajanp5beDtUvou4COtPyjAqQnw==
X-Received: by 2002:a63:d450:: with SMTP id i16mr7822345pgj.126.1571808608951;
        Tue, 22 Oct 2019 22:30:08 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id v1sm20270144pjd.22.2019.10.22.22.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 22:30:07 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:00:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        "v5 . 0+" <stable@vger.kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: of: drop incorrect lockdep_assert_held()
Message-ID: <20191023053005.m4y4bcebgi4km35q@vireshk-i7>
References: <6306e18beab9deff6ee6b32f489390908495fe14.1570703431.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6306e18beab9deff6ee6b32f489390908495fe14.1570703431.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-10-19, 16:00, Viresh Kumar wrote:
> _find_opp_of_np() doesn't traverse the list of OPP tables but instead
> just the entries within an OPP table and so only requires to lock the
> OPP table itself.
> 
> The lockdep_assert_held() was added there by mistake and isn't really
> required.
> 
> Fixes: 5d6d106fa455 ("OPP: Populate required opp tables from "required-opps" property")
> Cc: v5.0+ <stable@vger.kernel.org> # v5.0+
> Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/of.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 1813f5ad5fa2..6dc41faf74b5 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -77,8 +77,6 @@ static struct dev_pm_opp *_find_opp_of_np(struct opp_table *opp_table,
>  {
>  	struct dev_pm_opp *opp;
>  
> -	lockdep_assert_held(&opp_table_lock);
> -
>  	mutex_lock(&opp_table->lock);
>  
>  	list_for_each_entry(opp, &opp_table->opp_list, node) {

@Niklas, any inputs from your side  here would be appreciated :)

-- 
viresh

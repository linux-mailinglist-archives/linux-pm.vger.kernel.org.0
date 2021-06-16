Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D325A3A947B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 09:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhFPH57 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 03:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhFPH56 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 03:57:58 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF03C06175F
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 00:55:53 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id m2so1295085pgk.7
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 00:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z6KkOeNGlBnwNRX+KBmO0OGQfzcjW9cbkiaLTpzY5I4=;
        b=JEg6MHufBlrFldp6IGOX+iYUTopGk6HId0vQtr/zdHgFINopudHfhrhL0I5StbKsQK
         f5PjrkkSpl5MC2wlK0xf8j5l2sIP0UfSy1Xerlo0Gv+5nMbdGvVJWP5uiIVjK6k3gOam
         xwRzeiM3QRCIwauNlJr8swEl+BBMHmv9u3W5ICSiDyIpmBVYtcaSgigb2GLITIL5+/SV
         THUHyjIo6Gc7g7WWpjWYvSKnRmS/iYUJVvBWfDikmJDWtCV9RBYRT/RR2VJGzgs63Zi7
         zdp8VMfcDLrxSAIZTedSWg7JfOIxHuCY/7IQ23xXZHOYnZkOVXPhcow2EdbNjDz6Cuiz
         L2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z6KkOeNGlBnwNRX+KBmO0OGQfzcjW9cbkiaLTpzY5I4=;
        b=MTLPSbq8MMykXk+zeINGw25C18K8lPz2P2VtVsJcpKcnU7AIWXqja/x/fRxYDD4dlK
         ZHDjesXFqUh/3Fga8yTJ9b/8+5eokRO8YXHjSvA17sLOTGSJC+57Ubd947arLZrVY5bQ
         B3gbpG2MudvvzmfXu6gzGdKC1c/nGCxkbdrIlzWyLRi8EeTiQqXmGNpV593dXAAWHSeH
         Va/LL/jW6sNhUeZuKMgN3KGJakO6i2Yjxq5fRuv9qdpohJQWYZkN4sS+CJO1bbFGeTHA
         yGX06t3YkGLJKavIULXLsDtHjPKrfmloUq/IFoFADpI+ArHmf75DdIb23jj3+keamnJL
         7l/A==
X-Gm-Message-State: AOAM530Uq2nWFjGZUC3kaoSVHPtz/4wbvPIRTcvKgyamPDw7TMy6ked2
        HKKeLcBdqUlUcTZk49E718alzQ==
X-Google-Smtp-Source: ABdhPJxsRTQvzjZpns/ytNoGBkXK7Sp1Eke838wNQfEUlb+/eqLtTJIu+KvXGzGjBp31IJe8vGvohQ==
X-Received: by 2002:aa7:979a:0:b029:2f5:2484:ecff with SMTP id o26-20020aa7979a0000b02902f52484ecffmr8151664pfp.13.1623830152488;
        Wed, 16 Jun 2021 00:55:52 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id y7sm1318123pfy.153.2021.06.16.00.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 00:55:50 -0700 (PDT)
Date:   Wed, 16 Jun 2021 13:25:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "Viresh Kumar )" <vireshk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "andrew-sh . cheng" <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH] opp: of: Allow lazy-linking of required-opps to non genpd
Message-ID: <20210616075548.ghp3lmjf4y6pyxoy@vireshk-i7>
References: <20210616053335.4181780-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616053335.4181780-1-hsinyi@chromium.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-06-21, 13:33, Hsin-Yi Wang wrote:
> Don't limit required_opp_table to genpd only. One possible use case is
> cpufreq based devfreq governor, which can use required-opps property to
> derive devfreq from cpufreq.
> 
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> This is tested with the non genpd case mt8183-cci with passive
> governor[1].
> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/1616499241-4906-2-git-send-email-andrew-sh.cheng@mediatek.com/
> ---
>  drivers/opp/of.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index aa75a1caf08a3..9573facce53a5 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -201,17 +201,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>  			lazy = true;
>  			continue;
>  		}
> -
> -		/*
> -		 * We only support genpd's OPPs in the "required-opps" for now,
> -		 * as we don't know how much about other cases. Error out if the
> -		 * required OPP doesn't belong to a genpd.
> -		 */
> -		if (!required_opp_tables[i]->is_genpd) {
> -			dev_err(dev, "required-opp doesn't belong to genpd: %pOF\n",
> -				required_np);
> -			goto free_required_tables;
> -		}
>  	}
>  
>  	/* Let's do the linking later on */
> @@ -379,13 +368,6 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
>  	struct dev_pm_opp *opp;
>  	int i, ret;
>  
> -	/*
> -	 * We only support genpd's OPPs in the "required-opps" for now,
> -	 * as we don't know much about other cases.
> -	 */
> -	if (!new_table->is_genpd)
> -		return;
> -
>  	mutex_lock(&opp_table_lock);
>  
>  	list_for_each_entry_safe(opp_table, temp, &lazy_opp_tables, lazy) {
> @@ -873,7 +855,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  		return ERR_PTR(-ENOMEM);
>  
>  	ret = _read_opp_key(new_opp, opp_table, np, &rate_not_available);
> -	if (ret < 0 && !opp_table->is_genpd) {
> +	if (ret < 0) {
>  		dev_err(dev, "%s: opp key field not found\n", __func__);
>  		goto free_opp;
>  	}

Plus this and few changes to commit log.

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e366218d6736..b335c077f215 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -893,6 +893,16 @@ static int _set_required_opps(struct device *dev,
        if (!required_opp_tables)
                return 0;
 
+       /*
+        * We only support genpd's OPPs in the "required-opps" for now, as we
+        * don't know much about other use cases. Error out if the required OPP
+        * doesn't belong to a genpd.
+        */
+       if (unlikely(!required_opp_tables[0]->is_genpd)) {
+               dev_err(dev, "required-opps don't belong to a genpd\n");
+               return -ENOENT;
+       }
+
        /* required-opps not fully initialized yet */
        if (lazy_linking_pending(opp_table))
                return -EBUSY;

Applied. Thanks.

-- 
viresh

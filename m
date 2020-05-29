Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63291E7516
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 06:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbgE2Eol (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 00:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgE2Eol (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 00:44:41 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31709C08C5C8
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 21:44:41 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cx22so636726pjb.1
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 21:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TSemzb3dqlu5hiVSHS+Hj5ocpjzPNZhkfK/fQHweg94=;
        b=Gc9GC/q6JIDcq5qCFx6QtKtFBG9pGJ0jswzlU/WU8bSCq3SiaZtPd7/Y7qvLkVvBQt
         uUCo8VLB6Eeq4FyWlmRY11LqDDZDBRvyZpv87uWcewyMPVYZa28pWzHgVymu93yZ6+Mp
         qU2sJZg0VP2Yv+wPBP4reiFPcwrkXwek2ZdT4kUiP0HYzM+TBpgRLmnymK54xDv0omAR
         VoEhvuuknaO1ud6O1YBCpipSThcvpKcqHvVceKnmZraUO2dMXbrh65QnHHpnOvvDXsdJ
         ydH9WtErG7aeMUFRxSyYhSTATX8yjfxjEQdlqnQU205ZHcAY4/B4/U22fi3XL+p9+fFo
         5u4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TSemzb3dqlu5hiVSHS+Hj5ocpjzPNZhkfK/fQHweg94=;
        b=r0x/w1YseWa6t9DMK2JvtPgfWj7FAeY/ovUyvfOKaOoIiXSJWfWkExrdR3xpjDm5e+
         q0NzksiN5JN8cy4j8zORijsPhfstuCqGH+5SSIGnq2he+oUzq5BJIGc50hoG3EU0PM84
         sgp/uM9fAtD0guQmmKQKdrxvOr2mMgKaO/3ddXNQaAt4pwm2opN1FgBEOuDfctVtr0sC
         4XPcTkcFZzBoSOzzORTlfZYZNNsPyv6oymr96LYouFPl49b7rY16gY8cQvDID3UPvQM2
         A0QAIkcOKlO1NmWd37L3O3OACSUMUYWlYqh9OTsardqEfYGdyb3ILygsflhK6sCizqZQ
         c4pQ==
X-Gm-Message-State: AOAM530vNjLUU3lB6QZpXlgtpbhTIzz0hrtcm9SIc+tB41iEeqr87Xb/
        VjyvJgi/dz+Iqd4bSws5mA5MMw==
X-Google-Smtp-Source: ABdhPJwCwEYSFkgpKp43mpNdmaCGr0pAiysoJt/rRf7SmuzVNwJa2UYzSDsNkgFLSFiCf/joUZsq7A==
X-Received: by 2002:a17:90a:2242:: with SMTP id c60mr7784943pje.224.1590727480482;
        Thu, 28 May 2020 21:44:40 -0700 (PDT)
Received: from localhost ([122.172.60.59])
        by smtp.gmail.com with ESMTPSA id t4sm3157356pfh.5.2020.05.28.21.44.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2020 21:44:39 -0700 (PDT)
Date:   Fri, 29 May 2020 10:14:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org,
        robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 04/10] OPP: Add support for parsing interconnect
 bandwidth
Message-ID: <20200529044437.5wmbbews2vn66dia@vireshk-i7>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
 <20200512125327.1868-5-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512125327.1868-5-georgi.djakov@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-05-20, 15:53, Georgi Djakov wrote:
>  struct dev_pm_opp *_opp_allocate(struct opp_table *table)
>  {
>  	struct dev_pm_opp *opp;
> -	int count, supply_size;
> +	int supply_count, supply_size, icc_size;
>  
>  	/* Allocate space for at least one supply */
> -	count = table->regulator_count > 0 ? table->regulator_count : 1;
> -	supply_size = sizeof(*opp->supplies) * count;
> +	supply_count = table->regulator_count > 0 ? table->regulator_count : 1;
> +	supply_size = sizeof(*opp->supplies) * supply_count;
> +	icc_size = sizeof(*opp->bandwidth) * table->path_count;
>  
>  	/* allocate new OPP node and supplies structures */
> -	opp = kzalloc(sizeof(*opp) + supply_size, GFP_KERNEL);
> +	opp = kzalloc(sizeof(*opp) + supply_size + icc_size, GFP_KERNEL);
> +
>  	if (!opp)
>  		return NULL;
>  
>  	/* Put the supplies at the end of the OPP structure as an empty array */
>  	opp->supplies = (struct dev_pm_opp_supply *)(opp + 1);
> +	opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp->supplies + supply_count);
>  	INIT_LIST_HEAD(&opp->node);

Added this delta here.

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 7302f2631f8d..dfbd3d10410c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1330,7 +1330,8 @@ struct dev_pm_opp *_opp_allocate(struct opp_table *table)
 
        /* Put the supplies at the end of the OPP structure as an empty array */
        opp->supplies = (struct dev_pm_opp_supply *)(opp + 1);
-       opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp->supplies + supply_count);
+       if (icc_size)
+               opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp->supplies + supply_count);
        INIT_LIST_HEAD(&opp->node);
 
        return opp;


-- 
viresh

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EEB221AC8
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 05:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgGPDXD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 23:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgGPDXD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 23:23:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EBEC061755
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 20:23:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id l6so3255002plt.7
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 20:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5vL2rTMSzdb973P0bKvsekMeIZjsfxMApp0DH5ESVjs=;
        b=d+oERqSXZVucE1V+TQGL/D2zNmxgT3cpGX2KTRh4NEs8kTssviY1Ba3cbAxVizMP02
         QyQEU3W53ITr1t+HZHOPPMmsYI7qPCy/7b0Tjr8VeSDsj8mu6WXpeTZDOhxqb/ow7nVK
         NcPgTUhDwHSP0A5OFe+1+s73uw41VYCG1GGgAlPJBOW28GwS4PcFOCfS2DRUdRWbctIc
         YkK4wpm/cJDaE8S57OdeAa2GK2K8BXXIxe88FCTuIGh1kjXu3U3tZpyI+h8OogQlWncV
         PbsuDk692E0wysOoCWptCn9lHgdR06F01+h/us00y/6VrSGsqiYPnSs3fQlxADphJwnI
         hm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5vL2rTMSzdb973P0bKvsekMeIZjsfxMApp0DH5ESVjs=;
        b=lRn3Xp3Mi0m1Yd6WebbYFapgVe8RSqFIej9UJe4NqIvozjRlG7dkcWWW1qWOrbB09Z
         OaV+BGfAlOahs6sWdqstFzIsl9maij4IY2u64MaZOPsVNoj7f65Kuz7DQjuoxOOk8Xup
         xVCyAltFrH32v4HAR1Pxz3PAkNKu5oipWuJmN37Utc1dYrqIH647+iZjPl3qeU2m4KOY
         60aNh4shDs7QWqe7siK4OrRVlA/DZgssF8RDKTV4+HIlmqMxxRnTtzc7OG9PeQq99Ca4
         VZb0VflEt8lx5y8y5hUQWNfe/QYDtiK5wd3FNCGyk8hlL9Zkhh72U9D0Pw/HKryDm4TE
         NhDQ==
X-Gm-Message-State: AOAM530vyx3fs93TRDVMbsIIMB3GiQe7GlwEhFs1UReGF14tfK/yPovi
        GXDjEpgHYnunMFKwYvXhlQ1PMA==
X-Google-Smtp-Source: ABdhPJyz6+Yw1GquiPJ80G7wUbREi52JSXyMY3Hl9inYjcIG9pgGPETGIXyrrx0B7gL0Fb8xBKJXVQ==
X-Received: by 2002:a17:90a:f00d:: with SMTP id bt13mr2843254pjb.109.1594869782919;
        Wed, 15 Jul 2020 20:23:02 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id g19sm3069589pfu.183.2020.07.15.20.23.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 20:23:01 -0700 (PDT)
Date:   Thu, 16 Jul 2020 08:52:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Walter Lozano <walter.lozano@collabora.com>
Cc:     linux-pm@vger.kernel.org, kernel@collabora.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Increase parsed_static_opps on _of_add_opp_table_v1
Message-ID: <20200716032259.l5ybqetpg74ybogh@vireshk-i7>
References: <20200716025452.25761-1-walter.lozano@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716025452.25761-1-walter.lozano@collabora.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-07-20, 23:54, Walter Lozano wrote:
> Currently, when using _of_add_opp_table_v2 parsed_static_opps is
> increased and this value is used on _opp_remove_all_static to
> check if there are static opps entries that need to be freed.
> Unfortunately this does not happens when using _of_add_opp_table_v1,
> which leads to warnings.
> 
> This patch increases parsed_static_opps on _of_add_opp_table_v1 in a
> similar way as in _of_add_opp_table_v2.
> 
> Signed-off-by: Walter Lozano <walter.lozano@collabora.com>
> ---
> 
>  drivers/opp/of.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 9a5873591a40..b2bc82bf8b42 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -917,6 +917,8 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
>  		nr -= 2;
>  	}
>  
> +	opp_table->parsed_static_opps++;
> +
>  	return ret;
>  }

Merged with this and added relevant Fixes and stable tags.

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index b2bc82bf8b42..314f306140a1 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -902,6 +902,10 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
                return -EINVAL;
        }
 
+       mutex_lock(&opp_table->lock);
+       opp_table->parsed_static_opps = 1;
+       mutex_unlock(&opp_table->lock);
+
        val = prop->value;
        while (nr) {
                unsigned long freq = be32_to_cpup(val++) * 1000;
@@ -917,8 +921,6 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
                nr -= 2;
        }
 
-       opp_table->parsed_static_opps++;
-
        return ret;
 }
 
-- 
viresh

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A44577C2D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jul 2022 09:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiGRHIw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jul 2022 03:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiGRHIw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2022 03:08:52 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FCC2BF5
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 00:08:51 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 5so8232315plk.9
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 00:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ieP8qTBMvXqoNodmOucE/j+ncc9sxK1t2skVFkGc/X4=;
        b=x5nonHlVLyz8S92XQ/slMb+lD22e6A/ZfhqXZooWYpNC1sEHPf352BxMj6TCA1jQbf
         U/Dzz8TyhyjSpJgGPI0oW5WlogwR8bSje2+hBnGkhGT/fkykbscO9qx92XvrPGkEz1sI
         jhd8+y6l0kr9SHR7Eb9ekLzdSL0HtAvRxi+Q7X44xts20UYaLZI3ZToqRjvDL/Hm/+he
         pvTpD0NjSBIWTzNpr9H6rEn9VYI5xDdHzf/9nNaa2BFft8Nx4qV8sThwli4tAltks0qQ
         TSlsshBn/+yOE7eGWmgm4DaJEGogd0z6gG10MGTM3Ep5M5hJfB/B29nMDbuVaIM4ekyt
         7u8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ieP8qTBMvXqoNodmOucE/j+ncc9sxK1t2skVFkGc/X4=;
        b=olSkjEypod3GksuWbXTGHxEfuXymZZcMWhYm7vKP6VU+ncA46NSZlM+Ufla5h1cL2n
         y9uRunX/aoYDzJV25VChVVJ5zp30zNPIC5jpw+y5TAzN46OcofK79a8esFqlZdomO5IF
         H1I4IKQ/AVZndkc4ixODiFVpZjkBk6stZBnO5rMkMg2FWCPO9DGIwcPjD/0eAlx+Grf3
         1GVVbBZl1/H6ZB8AvVaM1vqAbcNHoQjpGV3eIGQ4C9vde44gn7UFTtEMR/8UbvUT+Bum
         Ea6z96hizSfZvBl48vWN4pkIhMZikXjb2N6a3WWJQDbOZdxPiIjkI7MQGW7WInjUkgU+
         fDQQ==
X-Gm-Message-State: AJIora81Vn/lhbX4VjJN+3mpfd1j+1ZDc/Cg8MOCbKkI+4WSyulJWqAt
        6WygvwT7Ei6r4glzFblM5yAdpWPz3cx/GQ==
X-Google-Smtp-Source: AGRyM1tNW4ikmnMsbHijLNTsnQnQS9fZ42uPcKsc5GmgDRytVcNI/lvG/DaiPMyythe3ULEBek/FsQ==
X-Received: by 2002:a17:90b:3506:b0:1f0:81a:6477 with SMTP id ls6-20020a17090b350600b001f0081a6477mr37162504pjb.46.1658128130534;
        Mon, 18 Jul 2022 00:08:50 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id g19-20020a635653000000b00419b128cf98sm7436705pgm.54.2022.07.18.00.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 00:08:50 -0700 (PDT)
Date:   Mon, 18 Jul 2022 12:38:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liang He <windhl@126.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] OPP: Fix two refcount bugs
Message-ID: <20220718070848.s6qziqkr3nmv32fc@vireshk-i7>
References: <20220715144712.444104-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220715144712.444104-1-windhl@126.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-07-22, 22:47, Liang He wrote:
> In drivers/opp/of.c, there are two refcount bugs:
> (1) in _of_init_opp_table(), of_put_node() in the last line is not
> needed as the 'opp_np' is escaped out into 'opp_table->np' and
> ’opp_table' is an out parameter.
> (2) in _opp_add_static_v2(), we need call of_node_get() for the new
> reference created when "new_opp->np = np;" as new_opp is escaped out.
> Here we should also take care of the of_node_put() when 'new_opp' is
> freed based on the function description: "The opp can be controlled
> ... and may be removed by dev_pm_opp_remove".
> NOTE: _opp_add_static_v2() is called by _of_add_opp_table_v2() in a
> for_each_available_child_of_node() which will automatically increase
> and decrease the refcount. So we need an additional of_node_get()
> for the new reference created in _opp_add_static_v2().
> 
> Fixes: f06ed90e7051 ("OPP: Parse OPP table's DT properties from _of_init_opp_table()")
> Fixes: 274659029c9d ("PM / OPP: Add support to parse "operating-points-v2" bindings")

The way I designed the OPP core then was to make sure that np is only used for
pointer comparison and nothing else after it is freed by calling of_node_put().
So it isn't a bug.

But I do understand that it has become difficult to track now if np can get used
later on for other stuff as well or not and it would be better to keep the
reference up in such a case.

That is, you can drop the Fixes tag as I don't want these to get backported, but
yes patches are welcome.

Please prepare two separate patches, one for opp_table->np and one for opp->np.
It is fine to add multiple patches even for the opp->np case, if the reasoning
is different.

> Signed-off-by: Liang He <windhl@126.com>
> ---
>  drivers/opp/core.c | 1 +
>  drivers/opp/of.c   | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 84063eaebb91..70775362eb05 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1576,6 +1576,7 @@ static void _opp_kref_release(struct kref *kref)
>  	list_del(&opp->node);
>  	mutex_unlock(&opp_table->lock);
>  
> +	of_node_put(opp->np);
>  	/*
>  	 * Notify the changes in the availability of the operable
>  	 * frequency/voltage list.
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 30394929d700..0a38fc2c0f05 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -242,7 +242,6 @@ void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
>  	opp_table->np = opp_np;
>  
>  	_opp_table_alloc_required_tables(opp_table, dev, opp_np);
> -	of_node_put(opp_np);

Where does this get dropped now ?

>  }
>  
>  void _of_clear_opp_table(struct opp_table *opp_table)
> @@ -902,7 +901,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  
>  	new_opp->turbo = of_property_read_bool(np, "turbo-mode");
>  
> -	new_opp->np = np;
> +	new_opp->np = of_node_get(np);
>  	new_opp->dynamic = false;
>  	new_opp->available = true;
>  
> -- 
> 2.25.1

-- 
viresh

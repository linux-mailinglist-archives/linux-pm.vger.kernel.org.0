Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BBE389C48
	for <lists+linux-pm@lfdr.de>; Thu, 20 May 2021 06:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhETEFC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 May 2021 00:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhETEFC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 May 2021 00:05:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB69C061574
        for <linux-pm@vger.kernel.org>; Wed, 19 May 2021 21:03:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g24so8412116pji.4
        for <linux-pm@vger.kernel.org>; Wed, 19 May 2021 21:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G2plJT1XiULDHpwMBzOhMAgpJs8GM8boE9+4LAq43YQ=;
        b=uZD7ZMWKjDklh9fS9fiGJFg3u5Nrut0SaIKSJej67+5MslWmJ+BtpfimXuIj6UFcZi
         gu109e76aoAtw5VTXwkTLtTMQtsNAJEZ/8ffkk+01CYWKh16MJQGbJ3WzETzmaZC40ZY
         qtBKyrMYTyilfz/c0FnouapjiN+hWS7rlXXfI6inm3Bc32NwbR4RkKUnAA7azsN8BjAV
         Q/dB+i4MKY5L6A4jj1CGWh7Ln2ZY+XbcReE243nI+nwwBFs5kvL3KzUTfYeKlZ/W/v59
         ntPH5Hp/pC+Em/Gy0u2SK3pIULSXgDyAobs/Z9dVJwi9l2NoqAhJMpSUa280fFMfVLBY
         7GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G2plJT1XiULDHpwMBzOhMAgpJs8GM8boE9+4LAq43YQ=;
        b=kIAGc/1RRq/VvFf232LFkLyPMsJ4eeF6H2TTF4jgJ7gp7QQE0Rxp6hOcPrp5Vim3xB
         DBWJcVN45KJhJT7gUUXXQL5TtDT6azHfm0HBGdxB/YXu9+7k2iKRuuVxoXmxBrpqXtX9
         eal3jK0gBw1rFcLTgzTRYgWQ1EVLvNDDZHFl7Y06FM84vJb4aaQyDIb5FnnIqD/qYtPW
         LgjU2Uy0R145MfR1L2giovnzlgPtEZxnp3Bzbs5NdHaJTMasPa0P1ONdhcYuLhmeHgLE
         K5Gb8PlVPoKb3wru9XEeTFSdbJDjeGJbKVh+xwDJkIgfWGhs5EQOZa1z8BHqCIFhrVFR
         9ndQ==
X-Gm-Message-State: AOAM533IAOcb30qt9g18RrY6Xz4VfIg155mwLPNRe7L7HRVCiuvKaFZf
        v4D6yrWvjRr2iOIT0OewbDx3eQ==
X-Google-Smtp-Source: ABdhPJwY/uIVOZ5D7U0Z5xDFpV9+y9ry8sxg34z+ApagG38ZdmDoTIt36nb73X60pF6yNYcpEftPYg==
X-Received: by 2002:a17:902:a5ca:b029:ef:ac0a:f00f with SMTP id t10-20020a170902a5cab02900efac0af00fmr3326798plq.22.1621483419827;
        Wed, 19 May 2021 21:03:39 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id c3sm685370pfi.213.2021.05.19.21.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 21:03:39 -0700 (PDT)
Date:   Thu, 20 May 2021 09:33:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org
Subject: Re: [PATCH -next] opp: use list_del_init instead of
 list_del/INIT_LIST_HEAD
Message-ID: <20210520040337.k47l2fxstfs2l2q3@vireshk-i7>
References: <20210518044910.608878-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518044910.608878-1-yangyingliang@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-05-21, 12:49, Yang Yingliang wrote:
> Using list_del_init() instead of list_del() + INIT_LIST_HEAD()
> to simpify the code.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/opp/of.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index c582a9ca397b..aa75a1caf08a 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -433,8 +433,7 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
>  
>  		/* All required opp-tables found, remove from lazy list */
>  		if (!lazy) {
> -			list_del(&opp_table->lazy);
> -			INIT_LIST_HEAD(&opp_table->lazy);
> +			list_del_init(&opp_table->lazy);
>  
>  			list_for_each_entry(opp, &opp_table->opp_list, node)
>  				_required_opps_available(opp, opp_table->required_opp_count);

Applied. Thanks.

-- 
viresh

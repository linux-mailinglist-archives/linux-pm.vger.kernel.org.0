Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB53A4ED18E
	for <lists+linux-pm@lfdr.de>; Thu, 31 Mar 2022 04:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiCaCOY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Mar 2022 22:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiCaCOX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2022 22:14:23 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA1D65D30
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2022 19:12:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w8so22138855pll.10
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2022 19:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=23XfkAHDqNFtL26bKDov8Qbam5dCiK7y19fMRZBdXt4=;
        b=qm67aC678igD9cDL/UrGvx7xNWfMGdlcX6eDKXldXuN9aExMlgo1sI9rARaUib4H6D
         0f1Zgv0E2nMHMYwOy8Rd34T6IHiVubFzpPzNipSggMDDmDvN9FYHLu8TCeyMooewNklG
         BDYcTh5Blw9PJdZ8DMO4orLOpxYFckL+ZN/vPMzEpp3AM/3Y7bFP/h3eN4XwLFY3c9pR
         Xl+8wmV7U9V7JSWGwcK67PHf6TgGUAvWJGQ1BmQeyEi0+LzMWzkc3sKhqYGBi6rAvKVn
         56Co8QllBFAv48GN4E8Vl85AQKC8rdQb/2Vz0TVAtIEBQmJjmF1U7afzRhri234sZ83r
         SVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=23XfkAHDqNFtL26bKDov8Qbam5dCiK7y19fMRZBdXt4=;
        b=8HakKSwkScKkbNSbWq8WG7bcTw4ykwjZoTBfFhy+9G3QNCmSjmRn+tO9r2ZVtv761D
         q6GaxB4/Q2VPuWKSBx3xO0QxMmfSK991ZdeYO05SxYS97JvwMg6J4cT+scr2YkwMmPN3
         GLY0wLuTyV82Wf64AiJpL4ZNZJZHsrj6kNTey/b3lVbpabVN3zrKDtxKyImiVgqE/HJo
         Gtf1dYkWPqJ9G2wQByrxlgo0pQWEoeeFgvmD6HUZEbJcIaNZz1mRmqF4fK2mWbMYkRQE
         tCrRDsx2DEMgZuvCDC+KcS0Dmp2EPH4Niim+kT2YYf/erraKmxqZ2Ke+1jy+8UYV3Sj6
         CMxg==
X-Gm-Message-State: AOAM531vW6ymX1kw4g7ePctHYM8ZAFRBB8iw0uB8+rBnVt+WhaLwvjfW
        4zPz1HCk8d/7sQvbhWhJp55IBw==
X-Google-Smtp-Source: ABdhPJy9CjLfyqEnfds3s+9ym0N2LGlzWw/ZN+JoBZJV9H6hqL+LC4pVIxa3u/7cj8q6KKt7N2940A==
X-Received: by 2002:a17:90b:4b88:b0:1c7:666e:7edb with SMTP id lr8-20020a17090b4b8800b001c7666e7edbmr3251434pjb.41.1648692757155;
        Wed, 30 Mar 2022 19:12:37 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id v8-20020a056a00148800b004fa9bd7ddc9sm25067522pfu.113.2022.03.30.19.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 19:12:36 -0700 (PDT)
Date:   Thu, 31 Mar 2022 07:42:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: use list iterator only inside the loop
Message-ID: <20220331021235.bhb4t2g43eva3c3s@vireshk-i7>
References: <20220331015818.28045-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331015818.28045-1-xiam0nd.tong@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Xiaomeng,

On 31-03-22, 09:58, Xiaomeng Tong wrote:
>     dev = new_dev->dev;

Why is this added here ?

> 
> As discussed before,

Please remember that whatever you write here will go in the commit
logs for ever and no one will ever know what you discussed and with
whom.

This area should describe the problem at hand.

> we should avoid to use a list iterator variable
> outside the loop which is considered harmful[1].
> 
> In this case, use a new variable 'iter' as the list iterator, while
> use the old variable 'new_dev' as a dedicated pointer to point to the
> found entry.
> 
> [1]:  https://lkml.org/lkml/2022/2/17/1032
> 
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
>  drivers/opp/debugfs.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> index 596c185b5dda..a4476985e4ce 100644
> --- a/drivers/opp/debugfs.c
> +++ b/drivers/opp/debugfs.c
> @@ -187,14 +187,19 @@ void opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp_table)
>  static void opp_migrate_dentry(struct opp_device *opp_dev,
>  			       struct opp_table *opp_table)
>  {
> -	struct opp_device *new_dev;
> +	struct opp_device *new_dev = NULL, *iter;
>  	const struct device *dev;
>  	struct dentry *dentry;
>  
>  	/* Look for next opp-dev */
> -	list_for_each_entry(new_dev, &opp_table->dev_list, node)
> -		if (new_dev != opp_dev)
> +	list_for_each_entry(iter, &opp_table->dev_list, node)
> +		if (iter != opp_dev) {
> +			new_dev = iter;
>  			break;
> +		}
> +
> +	if (!new_dev)

I will rather make this BUG_ON(!new_dev);

> +		return;
>  
>  	/* new_dev is guaranteed to be valid here */
>  	dev = new_dev->dev;


-- 
viresh

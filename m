Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369327779EA
	for <lists+linux-pm@lfdr.de>; Thu, 10 Aug 2023 15:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbjHJNuV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Aug 2023 09:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjHJNuU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2023 09:50:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BE62686;
        Thu, 10 Aug 2023 06:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 017E0630D3;
        Thu, 10 Aug 2023 13:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FBCC433C7;
        Thu, 10 Aug 2023 13:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691675419;
        bh=lk+n0r3C9A2P72n/Yr2l25n+DKj31xtX4dComhMn9W4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S0eeBT9h+cKYrieeHQghAKv2s3stzvqW86scqcbRsO+QvTv3xUPB/O7cBEzJcrSkC
         lBaB2eK7sdaySqqKRglaqqhM+fdxbZ9nU+geuKI6KgmTHeibZaVD3L8gu+1SDEl8QI
         Iscbu7Q6Yn+4Efr4HjTlfMhGzyrA8nU/WZOJC1HC4LX5y3KJHrEjLmJzTUecJv+Zto
         wPYL32F0hxkJfzvAnsDopxQ1pVxW2ydWxToM48scPtO2meZbUbZi0JpSyLxZRuiy3j
         dZY6cDbcSg75pamaepeeTmf7eKNX0doiSEreeTfQoxErgA47aZbmKmZjW+v8KF69A9
         rjyGyXfX7p0lg==
Message-ID: <b98f9097-6968-c7a2-27e0-ec2f17722644@kernel.org>
Date:   Thu, 10 Aug 2023 22:50:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] PM / devfreq: Fix leak in devfreq_dev_release()
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20230809113108.2306272-1-boris.brezillon@collabora.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20230809113108.2306272-1-boris.brezillon@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23. 8. 9. 20:31, Boris Brezillon wrote:
> srcu_init_notifier_head() allocates resources that need to be released
> with a srcu_cleanup_notifier_head() call.
> 
> Reported by kmemleak.
> 
> Fixes: 0fe3a66410a3 ("PM / devfreq: Add new DEVFREQ_TRANSITION_NOTIFIER notifier")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/devfreq/devfreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index e36cbb920ec8..9464f8d3cb5b 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -763,6 +763,7 @@ static void devfreq_dev_release(struct device *dev)
>  		dev_pm_opp_put_opp_table(devfreq->opp_table);
>  
>  	mutex_destroy(&devfreq->lock);
> +	srcu_cleanup_notifier_head(&devfreq->transition_notifier_list);
>  	kfree(devfreq);
>  }
>  

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


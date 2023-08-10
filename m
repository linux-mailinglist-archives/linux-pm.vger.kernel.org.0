Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F40776F7B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Aug 2023 07:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjHJFVS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Aug 2023 01:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjHJFVR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2023 01:21:17 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9DFE75;
        Wed,  9 Aug 2023 22:21:16 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37A5LBQ9078041;
        Thu, 10 Aug 2023 00:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691644871;
        bh=4h4AVaKEL3ZLFsVo7R1xjKzLpJrtQjd+LPp9S5HFqsw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Sv6HBZCugCXqFZS2vFu9CMU57hK7q8pM5pxm58sy55MqhYoTlfLY3DdS+ajWeH02+
         zA7tmwG7DEpBg++UY+y5kV4EkhT4/4vSay9ph8C1HepELT7gDbqaWOMht7NuV6YdPS
         lTS+TuyuPK5AqWFOHsUdlCO383wU+5B1yGrvKgpc=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37A5LBLR121210
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 00:21:11 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 00:21:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 00:21:10 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37A5L92w012897;
        Thu, 10 Aug 2023 00:21:10 -0500
Date:   Thu, 10 Aug 2023 10:51:09 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        <linux-pm@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] PM / devfreq: Fix leak in devfreq_dev_release()
Message-ID: <20230810052109.q2urzfcwu2vly7b5@dhruva>
References: <20230809113108.2306272-1-boris.brezillon@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809113108.2306272-1-boris.brezillon@collabora.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Aug 09, 2023 at 13:31:08 +0200, Boris Brezillon wrote:
> srcu_init_notifier_head() allocates resources that need to be released
> with a srcu_cleanup_notifier_head() call.
> 
> Reported by kmemleak.

Probably want to give a proper mention like:
	Reported-by: Name <email-id>
?

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

Good catch!
Reviewed-by: Dhruva Gole <d-gole@ti.com>

>  	kfree(devfreq);
>  }
>  
> -- 
> 2.41.0
> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

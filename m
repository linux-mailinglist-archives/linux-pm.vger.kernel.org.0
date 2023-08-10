Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3192B7770B1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Aug 2023 08:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjHJGtt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Aug 2023 02:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjHJGts (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2023 02:49:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52390E69;
        Wed,  9 Aug 2023 23:49:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E8FD46607214;
        Thu, 10 Aug 2023 07:49:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691650185;
        bh=TAT+MweWbCuagcWiDJOmi9OxUAygeBrzhHB/TxoKOeM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KIG4fTLDn0L6Mnxifb2vi/gfUpVFYUT3zR+5wfwd5hpUOXeSIGIn/Owq9FXCVDa8Y
         +3cbnIPBiAEliFzFV1aU4h+rjl8o5g/7WPHicKGuIX32dYlau6aKSuIvFKE2onTO8f
         iqANfkv4OoFhGKwTTzLHjq5YijICKXb8eXYXfDKG9xWyk3ZwOSI3R53aCjbTojYmJm
         aEETHuEd24oLsdnBaM8AEcr6vxhYqQ3yp3UM7fP1loP9OujA7M4B62NTxcxLkU8E4R
         VkI/c8oWlDcEJ+n5oQ4/Cz3pzLPZoTu2HNUhdSB2/e+eHn9+2Q1kBB8311qTdzdewU
         VdtmrFG5VYaPA==
Date:   Thu, 10 Aug 2023 08:49:42 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        <linux-pm@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] PM / devfreq: Fix leak in devfreq_dev_release()
Message-ID: <20230810084942.3769c5d1@collabora.com>
In-Reply-To: <20230810052109.q2urzfcwu2vly7b5@dhruva>
References: <20230809113108.2306272-1-boris.brezillon@collabora.com>
        <20230810052109.q2urzfcwu2vly7b5@dhruva>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 10 Aug 2023 10:51:09 +0530
Dhruva Gole <d-gole@ti.com> wrote:

> On Aug 09, 2023 at 13:31:08 +0200, Boris Brezillon wrote:
> > srcu_init_notifier_head() allocates resources that need to be released
> > with a srcu_cleanup_notifier_head() call.
> > 
> > Reported by kmemleak.  
> 
> Probably want to give a proper mention like:
> 	Reported-by: Name <email-id>
> ?

Does kmemleak have a standard Reported-by tag? Otherwise, the reported
is me (ran kmemleak when developing a driver, and this showed up), and
since I'm also the one fixing the bug, I'm not sure it's worth
mentioning.

> 
> > 
> > Fixes: 0fe3a66410a3 ("PM / devfreq: Add new DEVFREQ_TRANSITION_NOTIFIER notifier")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > ---
> >  drivers/devfreq/devfreq.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index e36cbb920ec8..9464f8d3cb5b 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -763,6 +763,7 @@ static void devfreq_dev_release(struct device *dev)
> >  		dev_pm_opp_put_opp_table(devfreq->opp_table);
> >  
> >  	mutex_destroy(&devfreq->lock);
> > +	srcu_cleanup_notifier_head(&devfreq->transition_notifier_list);  
> 
> Good catch!
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> 
> >  	kfree(devfreq);
> >  }
> >  
> > -- 
> > 2.41.0
> >   
> 


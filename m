Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E4E4FB1F9
	for <lists+linux-pm@lfdr.de>; Mon, 11 Apr 2022 04:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiDKCwz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Apr 2022 22:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiDKCwy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Apr 2022 22:52:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7975EBF40
        for <linux-pm@vger.kernel.org>; Sun, 10 Apr 2022 19:50:42 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id md4so5615088pjb.4
        for <linux-pm@vger.kernel.org>; Sun, 10 Apr 2022 19:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZrZ5rDgqEUbVpEm+O9sloaqEPKbBeBqsdAreas8s0sQ=;
        b=oaNwzIorQSMwZEymn1K2hsZ3/YUxXAz15bafp0ZmVf4q9/79kiNPbLeaVKNCyH9l2J
         lzFTfp0nEG/vPiaPsQVVZtM0dxrwUsn9uiVBxDQSzHfZjdYxDMu6jjJHr/uH779rP9UN
         9GjY5KOJTSaJYsNo5AW3Ym9BKLB+QhFD44ld7PYZFv04BAsuEufCRlP9X16aPxaDdvDv
         4/2n3X2KvwVmI94tqw3dve4ZW+WY0JRp4aqfGPZ/tir/47BYxwJJvBG6Y+mlQ7eKE5iQ
         6Thg60iWCXoGOVPCmo4w2Ij5DYoSMmEdH8bBnKKyMUYxTUXHygJgcBOh3Jr6eeZDs6Xf
         XRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZrZ5rDgqEUbVpEm+O9sloaqEPKbBeBqsdAreas8s0sQ=;
        b=VUaKYqjr5F5PgsnPdg6pTJdzPTM4XJrQIY7ENLQ68rag9aeYgyXohVmHIwVIbTTwt0
         p3j0SKRs1HNWokKsI+Xk5Eqa7upYrd9AJ4070yo5CeiOPWXGqZrLKa88jAQyLL0WDqde
         YNP4K+jYxnB12neKkSbEldROGzMLyxSbRF7b+Ieh/6OLkpPYXqBKZ0ZsB/gaJ76ELhoo
         d+XB3cJROkv82sRXimXwPtEqxxgT+nJI8qwFn2bde1yHj/yk3hsJynXTRgs/xxWMiQkt
         ftdVL3aAoqPwFfrdCtXX1efoRJZcfVCDcvnHxE2lDbqZChAArwpZySB/cfBjM2sxEXYx
         Klpw==
X-Gm-Message-State: AOAM533x/gNLkOrvMGV1llPVPyJCeYZ+aQB5x3jSe20ryKSHQRvSF/fk
        FXlPU1/0MZjJ+Iz0+uO4cSz7Y7oVi6A/nw==
X-Google-Smtp-Source: ABdhPJxe+MoLvnZTblrcT0nPzRDuAIRKLlKtgVSkqtkNQAOEc2bU3+M/mPp/NIzKaXVPsfVmnf6xJw==
X-Received: by 2002:a17:902:b183:b0:14f:c266:20d5 with SMTP id s3-20020a170902b18300b0014fc26620d5mr30506102plr.136.1649645442037;
        Sun, 10 Apr 2022 19:50:42 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id c17-20020a62e811000000b005058e80c604sm8499783pfi.53.2022.04.10.19.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 19:50:41 -0700 (PDT)
Date:   Mon, 11 Apr 2022 08:20:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] OPP: call of_node_put() on error path in
 _bandwidth_supported()
Message-ID: <20220411025039.ptimpe3pwur26spt@vireshk-i7>
References: <20220406064014.GA28099@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406064014.GA28099@kili>
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

On 06-04-22, 09:40, Dan Carpenter wrote:
> This code does not call of_node_put(opp_np) if of_get_next_available_child()
> returns NULL.  But it should.
> 
> Fixes: 45679f9b508f ("opp: Don't parse icc paths unnecessarily")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/opp/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 440ab5a03df9..95b184fc3372 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -437,11 +437,11 @@ static int _bandwidth_supported(struct device *dev, struct opp_table *opp_table)
>  
>  	/* Checking only first OPP is sufficient */
>  	np = of_get_next_available_child(opp_np, NULL);
> +	of_node_put(opp_np);
>  	if (!np) {
>  		dev_err(dev, "OPP table empty\n");
>  		return -EINVAL;
>  	}
> -	of_node_put(opp_np);
>  
>  	prop = of_find_property(np, "opp-peak-kBps", NULL);
>  	of_node_put(np);

Applied. Thanks.

-- 
viresh

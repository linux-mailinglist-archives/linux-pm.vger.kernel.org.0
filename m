Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2118075EB77
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jul 2023 08:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjGXGZ6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jul 2023 02:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjGXGZ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2023 02:25:57 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE068AF
        for <linux-pm@vger.kernel.org>; Sun, 23 Jul 2023 23:25:56 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-765942d497fso374009185a.1
        for <linux-pm@vger.kernel.org>; Sun, 23 Jul 2023 23:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690179956; x=1690784756;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yk843UCRZzZdN9ixhSrioks+d6x4Eo4sYkqbSCpM5OI=;
        b=wXMO6SZXEelEubat3cpQWxktvXbyBbU6Dcnxsu1jEVQXiEAS0GchVGYzqLQ9uy3ljh
         SnkVtS9oDIaHAPyBiO+MosqV56yK6srYi5nHrQD55jVU8p29ottm9m5UnOAgT8JNX+Rm
         95CVm8PZoMZz9wbNm9j3mnFsJLLqiBhUW0uGUgBwKW5MzvAS8B2oLt84aOICazsoC/zz
         u2Zmvh9PEU2f+WN4qISX9zjhBTKv/Kb4fDk6NEg7zKM0eBGV339F7poSOEzdkdIrcSN2
         fbc761F8VOEZd9vjg7jJq2XZu/O6LGgoHDo0eIGadeQWIEk4QBkoNZPXrIyP4jaYG4yf
         cFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690179956; x=1690784756;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yk843UCRZzZdN9ixhSrioks+d6x4Eo4sYkqbSCpM5OI=;
        b=Ncs/TBqPP1XBtEfloRM+dS5+hEiC8YI1yGIsoSwNFKzW0Jtsro935HKNabPWLHsZPK
         kevpqBj2raDSaUVVOgsjMnJidD5iyA2VpKSge6QPgcvO7Bil/jVTGMYivAtJxhkFQGZU
         rhC9FvVnrxkAgTEkHBJ8IULboO0w4qXo9KPxM75zcJXxw6zcVew4FuLmvWHfwENemiPz
         zoBYylHT118HMOriciFWL35fWiA5HYndS2IRdj+qBdcR+7bK7737zvJxgc1necwSxxso
         AMIQ9uHEB6KYXHeQ0FM8p2GjnkzfXJAA380udiWXXRGfJOjIm+/SqTkMUEgalR+DMX3K
         btoQ==
X-Gm-Message-State: ABy/qLZp+2fwdtEs1vD3EGT+ylwNABADobTuOLaXsI7yqlfs5y48Jt0E
        4DZk/gKvL26mLaZZqXHNKXRo
X-Google-Smtp-Source: APBJJlHAeACXEDWIn2PZKctC4An+ShRcT1v5MP6vF2jXouPDO6ejEamgHIMTKhdK3BNFPEtZbOwadw==
X-Received: by 2002:a05:620a:4155:b0:767:2aca:7641 with SMTP id k21-20020a05620a415500b007672aca7641mr8956601qko.52.1690179955945;
        Sun, 23 Jul 2023 23:25:55 -0700 (PDT)
Received: from thinkpad ([117.206.118.29])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a190500b0025bfda134ccsm6382513pjg.16.2023.07.23.23.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 23:25:55 -0700 (PDT)
Date:   Mon, 24 Jul 2023 11:55:47 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] OPP: Update _read_freq() to return the correct
 frequency
Message-ID: <20230724062547.GK2370@thinkpad>
References: <cover.1689932341.git.viresh.kumar@linaro.org>
 <13c3657578d0c054cfcfe4496dde560b6a816e3b.1689932341.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13c3657578d0c054cfcfe4496dde560b6a816e3b.1689932341.git.viresh.kumar@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 21, 2023 at 03:10:58PM +0530, Viresh Kumar wrote:
> Now that we support finding indexed frequencies, lets update
> _read_freq() to return the right one.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 7b1d5724b3d8..95f49fbe431c 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -472,7 +472,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
>  /* Helpers to read keys */
>  static unsigned long _read_freq(struct dev_pm_opp *opp, int index)
>  {
> -	return opp->rates[0];
> +	return opp->rates[index];
>  }
>  
>  static unsigned long _read_level(struct dev_pm_opp *opp, int index)
> -- 
> 2.31.1.272.g89b43f80a514
> 

-- 
மணிவண்ணன் சதாசிவம்

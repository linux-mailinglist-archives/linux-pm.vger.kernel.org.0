Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D7E53785E
	for <lists+linux-pm@lfdr.de>; Mon, 30 May 2022 12:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiE3Jqx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 May 2022 05:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbiE3Jqw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2022 05:46:52 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EB77674
        for <linux-pm@vger.kernel.org>; Mon, 30 May 2022 02:46:48 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y189so10117091pfy.10
        for <linux-pm@vger.kernel.org>; Mon, 30 May 2022 02:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UALvhWndaZ+8NVhyXVMTGWogK9BCZuA7nUC2dpZdhFc=;
        b=nfZTMfLpScX+7i5oxd+QZy4f+mKCKtr/6YCGg5q0/lgh99OiWWiF9Lhh/QN4IyB06x
         2moQEr4XBMjGQbiaC0VpfDMoopZq24/GbvNSsjxuZ6Wg5tXQqYnssMAXVLkV6IBTc1Uc
         I0W43D5oupX+ULjNU0O/Zy079+v15+Hpwi1Lwjcpw8s3TZPuPh46PHH6DRzVVX3YYFei
         voXdEcR5xXF1NbbXIQkCEHvN9PVS5Ua+/Xc5iO8BFurRxfgaDKxQLXF3xBUTYzFjATFp
         nRFunal+5Xm4EQwL9DrkIb+ItUSCfQcxQg4eVXGpxciSU5/WlY+xV84yfqm58TLrPcMt
         dOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UALvhWndaZ+8NVhyXVMTGWogK9BCZuA7nUC2dpZdhFc=;
        b=QmgxiyYgMPiNtEAp+lduTZAw0zlCARsy5P08QejHMgAbZ+Z8cQ8oz0MDIC/3/hZohb
         F5JAWp2pSv1S4ztOOKK94Nzw8I0/gr+WNmitGlFeW2F654tip7d/D7Ye6/ypsQGWk39i
         VI7XII9umcHriiddyx3FI+vV69DH09mLR5NVeeBky8q/+3XFTkAC9rAFIQ4AIr7pyQJY
         /qMDO34/Nvih1MlFke6BCwRchEbCYKm/DIzf91gvXznDjGstzniqMZ49r3GdT2ln/+tL
         dYq+04+wTvsGsbR1RByCxdZMhKEJZj+Js3hmC6kdkEyTFOUa6UfUCVnzDXrtvN71pVfa
         bHcg==
X-Gm-Message-State: AOAM533YJ9D9wQfOekuvuCJ9lvPdKdy1ZCU//ItvFCu9LonWBd8udAR6
        7ba+zwqUO11XsBUmubVk9s59VecRzQUAqw==
X-Google-Smtp-Source: ABdhPJxqfWEVJFwZmG5yodoFspNLPE7pWMsnb8wZBPkQOCSd4+v8Lx2w85ya08P/2p5qJrj2pACptA==
X-Received: by 2002:a63:8243:0:b0:3f9:6c94:5112 with SMTP id w64-20020a638243000000b003f96c945112mr41340598pgd.173.1653904007740;
        Mon, 30 May 2022 02:46:47 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090a588d00b001d9927ef1desm6377266pji.34.2022.05.30.02.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 02:46:47 -0700 (PDT)
Date:   Mon, 30 May 2022 15:16:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Dietmar.Eggemann@arm.com,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] cpufreq: CPPC: Fix unused-function warning
Message-ID: <20220530094645.wky42wwkbszfjjzs@vireshk-i7>
References: <20220530081236.40728-1-pierre.gondois@arm.com>
 <20220530082025.vqzk37dvyzxiq7dv@vireshk-i7>
 <3a26ce90-5d2d-0164-3799-85a9dc1abee6@arm.com>
 <20220530090738.7ycfr7g52b54jzj3@vireshk-i7>
 <2b2df076-f8fe-10f7-9bc4-3e1f3c1639d0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b2df076-f8fe-10f7-9bc4-3e1f3c1639d0@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-05-22, 11:42, Pierre Gondois wrote:
> Ok yes. Just to be sure and except if disagreed, I will use the
> following structure:
> #if CONFIG_ARM64
> #else
> #endif
> 
> #if defined(CONFIG_ARM64) && defined(CONFIG_ENERGY_MODEL)
> int populate_efficiency_class();
> #else
> int populate_efficiency_class();
> #endif
> 
> to avoid having multiple empty definitions of
> populate_efficiency_class() (for eg.) that we would have with:
> #if CONFIG_ARM64
> #if CONFIG_ENERGY_MODEL
> int populate_efficiency_class();
> #else // CONFIG_ENERGY_MODEL
> int populate_efficiency_class();
> #endif // CONFIG_ENERGY_MODEL
> #else // CONFIG_ARM64
> int populate_efficiency_class();
> #endif // CONFIG_ARM64

Look good.

-- 
viresh

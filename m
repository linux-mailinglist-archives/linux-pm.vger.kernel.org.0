Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A86A577C86
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jul 2022 09:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiGRH0V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jul 2022 03:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiGRH0U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2022 03:26:20 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E40E0C0
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 00:26:20 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bf13so9808865pgb.11
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 00:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wBTjlzr9otXTXPW0cCULXTn0FfZMy/zV14xcMR/+aE0=;
        b=WSZOt/WARFmjshFwP3J0imDWzVMDEshnxXHIOXz2kDAw/OpaUwD5Gf9YKn25aCKRjZ
         nvB/5mK/JSDUNLE4aRtXL9hmWKcTLPxdW6XaDrcB69w8KDKYp+c/4+JYaiAI12iMnVBO
         CZk4gy8M0wcpirKT2eE76oOoucrHDhYiWcv3I6wcKPK5FWmCjlXCQRbWi0bNKRCWEiBQ
         Rb0qIsuz7DtOg7xU/+vus5FWxGnbvXQEWsUm5RfGxt7kAlRq68E9LExDMw4qRLWfQC8e
         mtsfRPlqSsVML0GqYSmyczyQ8QZSfj97AhKj4GavMzqkRaBLp9MQEuQL19Mr18RX4e1s
         +7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wBTjlzr9otXTXPW0cCULXTn0FfZMy/zV14xcMR/+aE0=;
        b=2Y1tmrXqJI8D1cOkOUtZh1816zUyhEyBaLYKS2owDcGlwUOPPo/T0RAC7Pa36NNmrt
         kqQptQBYOTEKLl7V5tknq2r0yZm/GxW4wxMu27+3pTKtRWkVFGzY5K5oPudNcH2Kpm6j
         n7qvzuBCBnzx6uC6JWVyJEkdR8mMcet6yDqVKH7UAFlSUv2Bcjh33gtjn98LWm7y92Zf
         Ins8zfiaE46nFn3xRfwcSVkoN8oRNcET4z1vzLiaG2SR7QCNDbTCbA88gV4KF4E5PTSo
         UurXSxL9u+VZLF0z6BtWNs0RgggFpe6UVmTdQdvnNETyDYQt5dfb2YlBCY9K3buovKOd
         Mo5A==
X-Gm-Message-State: AJIora8BHmaUNgZlVsYxHK9Eo8ww65ewOxWz81J1/Xyds6nJ5mgMs2yq
        7Kkh9g6bV7FBEHZkkp6cjfOhIQ==
X-Google-Smtp-Source: AGRyM1tcV64kRsJdFPfiHIJN/GJqXr9CUMYKux00FuhAPiziPeQeqpZr3ASI6OHZSnUP9qQgiq+vCA==
X-Received: by 2002:aa7:82ca:0:b0:51b:cf43:d00a with SMTP id f10-20020aa782ca000000b0051bcf43d00amr26831594pfn.58.1658129179542;
        Mon, 18 Jul 2022 00:26:19 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b00168e83eda56sm8653888plh.3.2022.07.18.00.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 00:26:19 -0700 (PDT)
Date:   Mon, 18 Jul 2022 12:56:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liang He <windhl@126.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] OPP: Fix two refcount bugs
Message-ID: <20220718072617.eiozp2ee5pc332a6@vireshk-i7>
References: <20220715144712.444104-1-windhl@126.com>
 <20220718070848.s6qziqkr3nmv32fc@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718070848.s6qziqkr3nmv32fc@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-07-22, 12:38, Viresh Kumar wrote:
> Please prepare two separate patches, one for opp_table->np and one for opp->np.
> It is fine to add multiple patches even for the opp->np case, if the reasoning
> is different.

Also, please rebase on linux-next/master, in case you haven't.

-- 
viresh

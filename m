Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F491247894
	for <lists+linux-pm@lfdr.de>; Mon, 17 Aug 2020 23:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgHQVQT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 17:16:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37694 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgHQVQS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 17:16:18 -0400
Received: by mail-io1-f66.google.com with SMTP id b16so19128892ioj.4;
        Mon, 17 Aug 2020 14:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mk0YVF1KIXo/nlZJb/+nX3fQI//KWVOFCe5pyNEECZ4=;
        b=kJWlBnkxz9PTJWvbne2ZQbYp50Swsh1tHs0VMEKmP5sJSqccPCdAGLHvL69qQTdXWQ
         O95pDvUfqRTMiA/mt+05mHEtAWu+IzvcCWDWOz6d49WGplpE9Wzlej3NQJhGQUMAFP4Y
         O40BASsOL3LtiDXriBtFWDNpOQXQqrB4je5py0MPomomDo6un2Ljha3SORyQ2gPKekeY
         A9Abu6LG1WX3LhO6yS+sWmJU384xa4k1bUzgBLD0q8Khyq4MXVBx2QSmIY6N7S1lrUVe
         xdjERLzZ7tUd+oDn6lktZBZQWPpa2XhhMIOESvamgxNO7dKC0SWta4DKw4gG+vwMOfQ7
         wQGw==
X-Gm-Message-State: AOAM532s9EfV++kGKQVCAmKqxm82D93jj0wo+WQElON7ATYzi4SfSD6D
        eN1zQUH3XwegEYlA08XGZw==
X-Google-Smtp-Source: ABdhPJyWLspVGtBaMqat77nxctxV6sB3XIRqik0ZsAPYUbR0h6ttAfNgmXMQfvC9WDm1ZdcMh8jnTw==
X-Received: by 2002:a5d:824f:: with SMTP id n15mr13176762ioo.95.1597698977050;
        Mon, 17 Aug 2020 14:16:17 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id l5sm10261966ilj.88.2020.08.17.14.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:16:16 -0700 (PDT)
Received: (nullmailer pid 1576502 invoked by uid 1000);
        Mon, 17 Aug 2020 21:16:15 -0000
Date:   Mon, 17 Aug 2020 15:16:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mike Tipton <mdtipton@codeaurora.org>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        georgi.djakov@linaro.org
Subject: Re: [PATCH v3 2/6] dt-bindings: interconnect: Add property to set
 BCM TCS wait behavior
Message-ID: <20200817211615.GA1576472@bogus>
References: <20200801033215.1440-1-mdtipton@codeaurora.org>
 <20200801033215.1440-3-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801033215.1440-3-mdtipton@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 31 Jul 2020 20:32:11 -0700, Mike Tipton wrote:
> Add "qcom,tcs-wait" property to set which TCS should wait for completion
> when triggering.
> 
> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
> ---
>  .../bindings/interconnect/qcom,bcm-voter.yaml | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

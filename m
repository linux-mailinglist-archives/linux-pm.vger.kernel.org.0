Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771271E70CF
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 01:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437726AbgE1Xwl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 19:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437545AbgE1Xwj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 19:52:39 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C322DC08C5CA;
        Thu, 28 May 2020 16:32:27 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q18so719696ilm.5;
        Thu, 28 May 2020 16:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BZi6tHzaqVOINM6eCQ7Fjz2GRrahqrn6iNrzJqKN3TI=;
        b=NSdSGab+9wxkHte3KclmnLInDM+Ozgw62lC7+Em79c3hEUajYVbtHBri+d1kAUbpXw
         IXk4wmAFzkImWksmbU8F3FB00+MHBLE9UEHdwXeo3ObQEX1FRR9FqB8DbIldWI+su7aY
         MgscDIJp70zugJhBsDeNhtdkrdmwoXsJ6k0SdIFyZBJwUeIAX3CKb8cH0avfQJ88vtoJ
         /g9CI2OikyQ4VvIrgZ4wOdOYnBuoFRfh9vyh+L8JSoHdXQ+OK4HtZHTAwFeTyjP2snmA
         eWfmXmhyTYrT9q+/1swwgXZy4lySaLBs92o/JjhcB6NbT1kTNAPFHbrasmvqvxh7NBGJ
         1GLA==
X-Gm-Message-State: AOAM531xkmM7k7UdNq+xLuozH2mPr0JyqI75mGykkSuD4WfPew2ONSb7
        T4mmrmtW7PYScY5htVrUFA==
X-Google-Smtp-Source: ABdhPJz6C7QcrvueupRQJa7HorI+iAXdaNb7Lq3g5NQJCL3NZrsyI7wQ7jCvvU+e4TRS5EU8jnaesw==
X-Received: by 2002:a92:8818:: with SMTP id h24mr4741049ild.92.1590708747096;
        Thu, 28 May 2020 16:32:27 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id z3sm3174482ior.45.2020.05.28.16.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 16:32:26 -0700 (PDT)
Received: (nullmailer pid 881280 invoked by uid 1000);
        Thu, 28 May 2020 23:32:25 -0000
Date:   Thu, 28 May 2020 17:32:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: thermal: tsens: Add cold interrupt
 support in yaml
Message-ID: <20200528233225.GA881244@bogus>
References: <20200522114626.28834-1-manafm@codeaurora.org>
 <20200522114626.28834-3-manafm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522114626.28834-3-manafm@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 22 May 2020 17:16:26 +0530, Manaf Meethalavalappu Pallikunhi wrote:
> Add cold interrupt support for tsens in yaml.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
> ---
>  .../bindings/thermal/qcom-tsens.yaml          | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

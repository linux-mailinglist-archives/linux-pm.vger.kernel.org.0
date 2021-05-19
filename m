Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E513895F0
	for <lists+linux-pm@lfdr.de>; Wed, 19 May 2021 20:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhESS6w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 May 2021 14:58:52 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:47014 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhESS6u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 May 2021 14:58:50 -0400
Received: by mail-oi1-f180.google.com with SMTP id x15so14030182oic.13;
        Wed, 19 May 2021 11:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yw2vBtY21N4yRC0iwxctO/GkBEp9ciC/k8efOzsLdqg=;
        b=gxjv0NcLQ6jwyzKO8OYz+6SpwkJ1Q1ePFmT900rBidsKHPM2kmI8+BSz+8WCEuta+U
         r4jHVq3tJY0omIjOfXFHV8lZWz+q1tZHzM+6kTUcL8Qqa0d324w3yikfJNQJHxFFQ3OF
         ElJC00O7pRMFA7THGt3tz/KZACKNAAuqkhuhPMDtmtkRJSiXdC/02V22t7AoOdWeOe3H
         N6Vlmcw7J6iJddF17N+N+uRVXjdYus1k8lN0gsJJRZxeIl+IHOsDruQyUr1QcWS9wArx
         5azU2fDCZXzALn+oEN3oZmuFtZhWAwFhABa72OH2o+0DcUeiajJUkuQP44/cS2gqozJE
         NxFQ==
X-Gm-Message-State: AOAM533R9ogQEp99xCoGrO4FTWpQESnyzfER8OT6lSElLr3TsD9p4mUy
        5r+87WMFRvwF8y0DFT0ZZw==
X-Google-Smtp-Source: ABdhPJxjtgwDoIGacrl74xC1RxwJzx59AzYCfysoq2ouzuc/SA25XubhO9xhn6KmSWgP8NvlN6PDkg==
X-Received: by 2002:aca:4dc3:: with SMTP id a186mr644373oib.22.1621450648851;
        Wed, 19 May 2021 11:57:28 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p127sm98789oig.16.2021.05.19.11.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 11:57:27 -0700 (PDT)
Received: (nullmailer pid 3453175 invoked by uid 1000);
        Wed, 19 May 2021 18:57:26 -0000
Date:   Wed, 19 May 2021 13:57:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Lee Jones <lee.jones@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Beomho Seo <beomho.seo@samsung.com>, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: supply: Add DT schema for
 richtek,rt5033-battery
Message-ID: <20210519185726.GA3453116@robh.at.kernel.org>
References: <20210517105113.240379-1-stephan@gerhold.net>
 <20210517105113.240379-2-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517105113.240379-2-stephan@gerhold.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 17 May 2021 12:51:11 +0200, Stephan Gerhold wrote:
> The RT5033 PMIC provides a simple fuel gauge via I2C.
> Add a DT schema to describe how to set it up in the device tree.
> 
> Note that although RT5033 is a MFD with lots of functionality
> (also charger, regulator, LEDs, ...) the fuel gauge has a separate
> I2C bus and is not part of the MFD.
> 
> Cc: Beomho Seo <beomho.seo@samsung.com>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../power/supply/richtek,rt5033-battery.yaml  | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

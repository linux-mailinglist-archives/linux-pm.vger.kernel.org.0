Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFFA107BC7
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2019 00:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKVX7Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Nov 2019 18:59:24 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:38744 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVX7X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Nov 2019 18:59:23 -0500
Received: by mail-ot1-f44.google.com with SMTP id z25so7720850oti.5;
        Fri, 22 Nov 2019 15:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qMG5QPIKoP6GuVB63cWLcg46xGdDzVZ+xRKqB7niit4=;
        b=kWKyb3F3du89pYMjUzomLqHuDy3pE0xlCVfc9mKxEKQPYEAeZ+W+Ikjmg5jJXwhnWX
         4BGzp7wSYWAKftutg/3BGeD1e1mGgsw+N8QxWplo2dssWBbABZZ10kpgsZgIuKIwFBnE
         20TVIw+BohTt1w/yolvCnObyxIUFM7TBQA3R/JWlf6QgIcCUNFbeEZ2qE5sl23KoIXiw
         5iuBeFHO44tH5jh6vHOj0y+2F9bM7PvQYyAlGIw2ub99SP51GhyuU47M9NGsqENB3jMC
         uZuq7BisKgRLIf2q1/DsZxh0GxyItYi1XWjIfr2nP0OJYZ+NadStV9eo8Gjn/UPE1yc+
         HYZQ==
X-Gm-Message-State: APjAAAWuicxYXG9OsU7kwHXMICu67YS4afhDfaCfMra8p/lCdufeFTfj
        DuVp8YhbySLMwSBZ9pS9iA==
X-Google-Smtp-Source: APXvYqyt4hfUhy5ovK7LAKjCGgbL1e4QU5oRi5+hn+zYLKRkKg8qST6m7B2MX/1qFaGvzaDvsjcf6Q==
X-Received: by 2002:a05:6830:1f12:: with SMTP id u18mr13050782otg.58.1574467162830;
        Fri, 22 Nov 2019 15:59:22 -0800 (PST)
Received: from localhost ([2607:fb90:bd7:3743:c9ec:246b:67b7:9768])
        by smtp.gmail.com with ESMTPSA id i15sm2716967otl.69.2019.11.22.15.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 15:59:21 -0800 (PST)
Date:   Fri, 22 Nov 2019 17:59:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, amit.kucheria@verdurent.com,
        mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v4 6/7] dt-bindings: soc: qcom: Extend RPMh power
 controller binding to describe thermal warming device
Message-ID: <20191122235921.GA23550@bogus>
References: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
 <1574254593-16078-7-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574254593-16078-7-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 20 Nov 2019 07:56:32 -0500, Thara Gopinath wrote:
> RPMh power controller hosts mx domain that can be used as thermal warming
> device. Add #cooling-cells property to the power domain provider node to
> indicate this.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> v3->v4:
> 	- Removed subnode to indicate that mx power domain is a warming
> 	  device. Instead #cooling-cells is used as a power domain
> 	  provider property to indicate if the provider hosts a power
> 	  domain that can be used as a warming device.
> 
>  Documentation/devicetree/bindings/power/qcom,rpmpd.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

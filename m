Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92583EF4E2
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 23:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbhHQVYg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 17:24:36 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:39539 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhHQVYf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 17:24:35 -0400
Received: by mail-oi1-f170.google.com with SMTP id bj40so1223657oib.6;
        Tue, 17 Aug 2021 14:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cc1Tee25eLnpmetGn3WxZiNcJ/LLzI5Ywtl6ibNrqCc=;
        b=s6cxB1z+hiY0Ex9KO5i5KbCJAKPbbcZ1H3GC8uFYcvbsUr0FkpJL8obp/fhQma1wwR
         FQzmSDkLH/CWEenTYrvluX6C/RwQbltPw0r0RtfIzQz4ZkQAGgsVQUaYnPeLw+xWBVRO
         vdq5jQ0nNZClLkYqpB4XkyLh8Qx8wQugxt/LWyJClWii7BuIxXWJ1DulOFPRZfsv9BEC
         dC7IHe2l5XCAjIwmqSChOAPmF3BhLVqvIjOeZ68tGYZ3FjxD0V+ceQrhUQCWDQ6erwJ0
         moUvrdppKM/5qK+F4RhVMFBpCPGuEVJ1eQqFPQd3IMbQ9uX4hdBj5KyjEq9RnhokgqF4
         24NQ==
X-Gm-Message-State: AOAM532kXgFXFaCq3lZAt3piehryQAIkZO+DK4pxs4hXTseE5MvKeTN6
        A28dxTVsQyyHgXVJ4iCgXg==
X-Google-Smtp-Source: ABdhPJxB+13MUTodakTypFZWJ0OC1eGz65e3oYzvM2LSxBEUtJ5ZgfSPnWAqFOqmy5Dv97ixorGFbA==
X-Received: by 2002:a05:6808:10d:: with SMTP id b13mr4264105oie.79.1629235441533;
        Tue, 17 Aug 2021 14:24:01 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h19sm610545otr.75.2021.08.17.14.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:24:00 -0700 (PDT)
Received: (nullmailer pid 865404 invoked by uid 1000);
        Tue, 17 Aug 2021 21:23:59 -0000
Date:   Tue, 17 Aug 2021 16:23:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dawei Chien <dawei.chien@mediatek.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Ryan Case <ryandcase@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arvin Wang <arvin.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Nicolas Boichat <drinkcat@google.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Fan Chen <fan.chen@mediatek.com>, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [V11,PATCH 02/19] dt-bindings: mediatek: add compatible for
 MT8195 dvfsrc
Message-ID: <YRwo72vWlsY1cPw+@robh.at.kernel.org>
References: <20210812085846.2628-1-dawei.chien@mediatek.com>
 <20210812085846.2628-3-dawei.chien@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812085846.2628-3-dawei.chien@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 12 Aug 2021 16:58:29 +0800, Dawei Chien wrote:
> This adds dt-binding documentation of dvfsrc for Mediatek MT8195
> SoCs Platform.
> 
> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

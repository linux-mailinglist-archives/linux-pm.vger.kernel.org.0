Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131DC2A0EC1
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 20:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbgJ3TfN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 15:35:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37103 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbgJ3Tea (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 15:34:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id m22so6592318ots.4;
        Fri, 30 Oct 2020 12:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I+UOeLqddKwm96yK8/kkxVHqI4jCc+oL+/3b1gAK09w=;
        b=Pv2i//XFiH0QojFcwx/lwnGdA8vdgfB2oZjIzDWyzsNHPhIlvK8bX5/I4DpuMfOtwT
         r3xRLfWBOTQZQK/htjKW5OThJ8s44dVLlFjsP5xmDU54qWnG1NsS/+brhu0IMZXbLedj
         /wajdFgDlsKuE9GOcYd+K4xXrYPd0kDKd/0aJZivXLz6pwAXBu34j1aUcu5Of1HTl6k0
         llzsKNDO3ZANz8wPv/s0o3n1dCNmA998w9E0HKAaOyq1AuUOpkbPYPpBHb39AMR9tEX3
         j5l3EorItGHypWudx+dDOfINPLRAF1iArMy3JGVmQSAh7/4mNxA2YR19Lf3wi0G7b7S5
         gMVA==
X-Gm-Message-State: AOAM531L/OBIW19NfBb0071MoRPaa4g6CryL1KqC1k2JkTodwWYlA7c7
        6rKx0qGptk3bY5J6J1gxZg==
X-Google-Smtp-Source: ABdhPJzrbgSdZT7jNBJMAOvryFhc8QxGC4cCiqDn1uoYbML+ca7yGo6EtGBIzCnl2qxPgzky7V80fQ==
X-Received: by 2002:a9d:53cc:: with SMTP id i12mr2777619oth.215.1604086469813;
        Fri, 30 Oct 2020 12:34:29 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b21sm1442029ots.30.2020.10.30.12.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 12:34:28 -0700 (PDT)
Received: (nullmailer pid 913 invoked by uid 1000);
        Fri, 30 Oct 2020 19:34:27 -0000
Date:   Fri, 30 Oct 2020 14:34:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vireshk@kernel.org, sboyd@kernel.org, nm@ti.com, rafael@kernel.org,
        sudeep.holla@arm.com, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com
Subject: Re: [PATCH 1/4] dt-bindings: opp: Introduce opp-sustainable bindings
Message-ID: <20201030193427.GA4186428@bogus>
References: <20201028140847.1018-1-lukasz.luba@arm.com>
 <20201028140847.1018-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028140847.1018-2-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 28, 2020 at 02:08:44PM +0000, Lukasz Luba wrote:
> Add opp-sustainable as an additional property in the OPP node to describe
> the sustainable performance level of the device. This will help to
> estimate the sustainable performance of the whole system.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 9847dfeeffcb..cd01028de305 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -154,6 +154,10 @@ Optional properties:
>  - opp-suspend: Marks the OPP to be used during device suspend. If multiple OPPs
>    in the table have this, the OPP with highest opp-hz will be used.
>  
> +- opp-sustainable: Marks the OPP as sustainable. This property can be used for
> +  estimating sustainable performance of the whole system. If multiple OPPs in
> +  the table have this, the OPP with highest opp-hz will be used.
> +

Isn't this just the inverse of the turbo? or boost? flag we already 
have? 

Couldn't this be learned? I ran at this frequency and then overheated. 
That could be dependent on ambient temperatures or dust build up on 
fans/heatsink.

Rob

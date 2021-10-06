Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B5E42489B
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 23:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbhJFVPu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 17:15:50 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:41563 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239591AbhJFVPt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 17:15:49 -0400
Received: by mail-ot1-f51.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so331628ote.8;
        Wed, 06 Oct 2021 14:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hhEh5kd4e+SG2xwNY07ROc2/rt5AxCtyHRuXkRz4T3k=;
        b=ED8BIYVYEqC5aj5MPdxwTjRswWLPYF/qBQ+1SJwW/q0+T82vwMuzr7vntrGAKEueDu
         5YQAaaedioLHMlh9un1hwwxfedC4bFIK1vz61szXnq/qVNAvFd4KRIxD9GJvJ9ifus5M
         z1+lnnzuDZdt8mo8EQs1reJaEGCC2YNdsAwnhHHgVM5KIPq8G1JMS8OAiHaGDcUoG2/J
         piV+CWI24a5pQDkeccPhMWciqDlWUfONmTNGOcQByUu8vrJcnkeBi9LRk1uLHmy+Lu1b
         yf9bz2npIU1dZRSP4AbzaD1FI9zvh5o6Z/0mbEmYse+YgrPV5DIlO0DQObmjdwRGsL7P
         lHKg==
X-Gm-Message-State: AOAM531IIjKfTw636KKgEdTcoiMKGNpWKySz4VIxukXMIUIDhvspz9uv
        mA6huFZI9RXSaAhS6xwTFA==
X-Google-Smtp-Source: ABdhPJzCaOetxDXjKEw1eehKByezoxHask+w4Lv2EHhMvurr3FrCIGFjv9FkOtkcIDUctkQBkf71mA==
X-Received: by 2002:a05:6830:922:: with SMTP id v34mr439300ott.240.1633554836780;
        Wed, 06 Oct 2021 14:13:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z24sm4135433oic.26.2021.10.06.14.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 14:13:56 -0700 (PDT)
Received: (nullmailer pid 2886228 invoked by uid 1000);
        Wed, 06 Oct 2021 21:13:54 -0000
Date:   Wed, 6 Oct 2021 16:13:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, amitk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, heiko@sntech.de, linux-pm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: thermal: allow more resets for tsadc
 node in rockchip-thermal.yaml
Message-ID: <YV4RkjIEMUKlWK4z@robh.at.kernel.org>
References: <20210930110517.14323-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930110517.14323-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 30 Sep 2021 13:05:14 +0200, Johan Jonker wrote:
> The tsadc node in rk356x.dtsi has more resets defined then currently
> allowed by rockchip-thermal.yaml, so fix that in the documentation.
> The driver now uses the devm_reset_control_array_get() function,
> so reset-names is no longer required, but keep it for legacy reasons.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed V2:
>   Remove deprecated
> ---
>  .../devicetree/bindings/thermal/rockchip-thermal.yaml      | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

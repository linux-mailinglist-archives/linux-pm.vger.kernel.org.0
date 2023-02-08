Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F4968FB74
	for <lists+linux-pm@lfdr.de>; Thu,  9 Feb 2023 00:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjBHXqG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 18:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjBHXqA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 18:46:00 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26ED1C5A9;
        Wed,  8 Feb 2023 15:45:41 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1636eae256cso661173fac.0;
        Wed, 08 Feb 2023 15:45:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMbsxtsPaDcMRMJxOKC0VFQqMhagFJRucIidW5fqoA4=;
        b=jdjJnRXvrk7KJcseiSw/mG2NRms5MI1l610/eG/b691fdn1ilihKZfnfqE+ynk9BKg
         VutXOh06ACs3ioC8D4/3zevKi+m1kN185MjW8cTP7MizNyJI/y1DQdiC+59RUICZIsC7
         MlKTZu+GfUJmmIMqG0rkcOT/Swbhhw+GIg0Z3+axyyH53/weuM8cHW9Q5vQWfBTv6Wl9
         /g6TkhohVZQRXtwemaSnZkv6LLrjkq8Uw8FAlfmGEJSkA67skavdcp315RXb2O4cBYlS
         d7YVNTP197hc7sT0zlkuY3AxLDKoHJJWA+P1XVfFY+DdeTCNLKILwAv70afQ9CajrPJO
         V8dQ==
X-Gm-Message-State: AO0yUKUbz21lp7cSqSvCg4Z3+XE0Ei14/qIKEyCktuDcRO60w1N0DOxV
        ULgLOBNqm3XGPeJR/siYGxcMiKDQMA==
X-Google-Smtp-Source: AK7set/HiavAQmjdUI295azWy8VOKgmxDX+rzwF0NMVaOP/jJRv88VuTHKrnggACA0Pq2t3dOvrAyw==
X-Received: by 2002:a05:6870:1c7:b0:160:319a:d1db with SMTP id n7-20020a05687001c700b00160319ad1dbmr5324286oad.3.1675899940841;
        Wed, 08 Feb 2023 15:45:40 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n189-20020acabdc6000000b003645b64d7b3sm52122oif.4.2023.02.08.15.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 15:45:40 -0800 (PST)
Received: (nullmailer pid 2933874 invoked by uid 1000);
        Wed, 08 Feb 2023 23:45:39 -0000
Date:   Wed, 8 Feb 2023 17:45:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Will Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        kernel@pengutronix.de, Heiko Stuebner <heiko@sntech.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 18/19] dt-bindings: devfreq: event: convert Rockchip
 DFI binding to yaml
Message-ID: <167589862804.2903789.1604184239861791827.robh@kernel.org>
References: <20230208093830.143284-1-s.hauer@pengutronix.de>
 <20230208093830.143284-19-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208093830.143284-19-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Wed, 08 Feb 2023 10:38:29 +0100, Sascha Hauer wrote:
> Convert the Rockchip DFI binding to yaml.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../bindings/devfreq/event/rockchip,dfi.yaml  | 61 +++++++++++++++++++
>  .../bindings/devfreq/event/rockchip-dfi.txt   | 18 ------
>  2 files changed, 61 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> 

With the reference fixed:

Reviewed-by: Rob Herring <robh@kernel.org>


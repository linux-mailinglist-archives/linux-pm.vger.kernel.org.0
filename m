Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5559B68FBAC
	for <lists+linux-pm@lfdr.de>; Thu,  9 Feb 2023 00:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjBHXyI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 18:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBHXyH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 18:54:07 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B941E9D8;
        Wed,  8 Feb 2023 15:54:03 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id n132so275906oih.7;
        Wed, 08 Feb 2023 15:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKshMAIjCQCZcUfxR5Hv9kCFKizrcIjGHgXak5rGdyM=;
        b=W0o57iVyRiGZmL39VtKiakLFzsIjaKqDQ5b/n/UUdYWmYDGo53S8mOLUEKcntLy/kl
         DPqiAD+fghNXhASHizNSdFg6aAtIhRMwdu54ePXPBNQ7AT9REgK6p2ML2DPiX1PxFmp2
         vrR8qMpGbNU/uIilo4/zA5CSs8ZNQ61tZUdIyOLnWGMeqevASF0UgpLBraf4OjvttM0W
         CUWrbp08d2xjaruUs9edolUfpb8olZO9i+2zkZtmOJDAi+OUZ0q8dlMw5i/OSJBIzDJC
         XT4xKfVl0W9YpxB1tbudbRkiwxo+oyiMIBxyP+vKhnNGL0CjR6c8hxnxB1Im0pUBrHGP
         Kv8g==
X-Gm-Message-State: AO0yUKUegtf9L0Z1/wpqVop4YFNPZViFeQV9CDMmjhhDzijaqSxXVlHo
        nd7hNleAi7yM2sMMAYaZ9g==
X-Google-Smtp-Source: AK7set+4DuSlqvRBTvMTKw1U2Bwerb5K7w9NF4Oq99nh9XWA6g7YAl0/1wcx7qoQVStLY3kS6go8wg==
X-Received: by 2002:a05:6808:309:b0:35e:c8d9:5946 with SMTP id i9-20020a056808030900b0035ec8d95946mr3792717oie.46.1675900443087;
        Wed, 08 Feb 2023 15:54:03 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l20-20020a056830155400b006729fab72f0sm8798165otp.3.2023.02.08.15.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 15:54:02 -0800 (PST)
Received: (nullmailer pid 2943902 invoked by uid 1000);
        Wed, 08 Feb 2023 23:54:01 -0000
Date:   Wed, 8 Feb 2023 17:54:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, kernel@pengutronix.de,
        Mark Rutland <mark.rutland@arm.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Will Deacon <will@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v2 19/19] dt-bindings: devfreq: event: rockchip,dfi: Add
 rk3568 support
Message-ID: <167590044132.2943843.12824203100309803175.robh@kernel.org>
References: <20230208093830.143284-1-s.hauer@pengutronix.de>
 <20230208093830.143284-20-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208093830.143284-20-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Wed, 08 Feb 2023 10:38:30 +0100, Sascha Hauer wrote:
> This adds rockchip,rk3568-dfi compatible to the binding. Make clocks
> optional for this SoC as the RK3568 doesn't have a kernel controllable
> PCLK.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../bindings/devfreq/event/rockchip,dfi.yaml      | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


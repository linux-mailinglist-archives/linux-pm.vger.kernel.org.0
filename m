Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D654AFEC4
	for <lists+linux-pm@lfdr.de>; Wed,  9 Feb 2022 21:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiBIU5e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Feb 2022 15:57:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiBIU5e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Feb 2022 15:57:34 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24FBC043181;
        Wed,  9 Feb 2022 12:57:36 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso3937242oon.5;
        Wed, 09 Feb 2022 12:57:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TdpGnLDbtUmYIkONqPlMzNkcfEJwfiAXTpSsQ3UYI6Y=;
        b=4Ja8dCs4nSIlGZEpMqpFdkQy8AQhFhlDPMGymAqd3NpiI3na3Gxrt+LxXBZYpzn6Fs
         iCr4kcPCxbaXnwY9bNwV2BnqSXFjQTlavXvQMdEV7Xg0wlifC2Bt65cXZtJiedLmqSFg
         luUyv3OGMXfAqhJWq6EM7/mHbdNWH6xwroGucn2fptW4ZtTqjpFhpUMPb56AafNU+xfL
         wDlaMaEL0QkDXN3+XjzJQNiy8isPD9rDWMnByXfbIJlEVdSXem+J3PUqlIykjgDRaVnI
         Ue2aUV8lZK5dGM5EgkJuZBgZz3uIpAoJjxQtCIYA/7hC1T67++jtAnY6Ys1nv11r18Az
         cAXw==
X-Gm-Message-State: AOAM533lq1Q1cPoVMWsiA26K98teO1UIdEICmcE3xyBvnXCvssc0A2fZ
        HZV9sD4nPkaIoAvtp0Zi5w==
X-Google-Smtp-Source: ABdhPJxNoqzIn6b3mmjwNcw63vru7Sdv0QqazKiNSqtdJpXVfkOjunnfHkoAfxLbzDRMzH/AjqRyGQ==
X-Received: by 2002:a05:6870:6296:: with SMTP id s22mr1567657oan.231.1644440256285;
        Wed, 09 Feb 2022 12:57:36 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m26sm7223572ooa.36.2022.02.09.12.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:57:34 -0800 (PST)
Received: (nullmailer pid 895986 invoked by uid 1000);
        Wed, 09 Feb 2022 20:57:33 -0000
Date:   Wed, 9 Feb 2022 14:57:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     djakov@kernel.org, dmitry.baryshkov@linaro.org, benl@squareup.com,
        bjorn.andersson@linaro.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, agross@kernel.org, jun.nie@linaro.org,
        shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: Convert snoc-mm to a
 sub-node of snoc
Message-ID: <YgQqvVA0HaqWsAMA@robh.at.kernel.org>
References: <20220129032735.2410936-1-bryan.odonoghue@linaro.org>
 <20220129032735.2410936-2-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129032735.2410936-2-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 29 Jan 2022 03:27:34 +0000, Bryan O'Donoghue wrote:
> snoc and snoc-mm in downstream use the same address space a mistake which
> we have carried over into upstream. In silicon terms snoc-mm has been
> tacked on to the original snoc which came from msm8916.
> 
> Convert to a better description where snoc-mm is a sub-node of snoc, thus
> avoiding a mmio remap collision when using the RPM interconnect driver.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../bindings/interconnect/qcom,rpm.yaml       | 33 +++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

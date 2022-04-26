Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9D55109FA
	for <lists+linux-pm@lfdr.de>; Tue, 26 Apr 2022 22:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354771AbiDZUPo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 16:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354721AbiDZUN2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 16:13:28 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB7C13D32;
        Tue, 26 Apr 2022 13:10:18 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-e5e433d66dso20580896fac.5;
        Tue, 26 Apr 2022 13:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w8+fJjcBbHiW0+J6Lz4r0NNKe8qN9LuJDE5FR5Ki9SQ=;
        b=zlmZRphwQKl2yiO0FkEXjGNP1BqYK0aN5EhLSHy2oEy1NzPacPqLkkA0h/t5MzaaUK
         44W1Q2BNBdm8Vj0wIrOluJJFo3JwUhgU/MtkAleH1nNmedBUsNiAF4yV5UcUASbmkAqS
         6uEGCErpXK+QpoIFZorLZnCQHSVflw4ASumHPboJNF7RO3+1jb40KeXTpSI5lAiPHh0o
         Way9NxcJ4+bW4BWOQ3+QKcyph8gAzjMo78JHP7eZ2Bc0nxJI46FBJ6M3Av/fWAvCM/cy
         EiVRTP7rxXNNAHSnrxTQt4F0MXWnKzIhmvzmdj31h/0kulS+f9fW+Xr+yFHJV94b51F0
         q7rw==
X-Gm-Message-State: AOAM532lUBMZg/56Ki2YeGAFuxULRODwRtah6LlKSg4DEqYgIWtHfFGq
        LCGTS1XtqBXxDmpASuJAVQ==
X-Google-Smtp-Source: ABdhPJxn23CXTl4kn0pFn2RQIWE9e7wNSGhpZDSA5KQ9BfdG6/Wt38p4/wVxfXY99e0wYOXuqrblTw==
X-Received: by 2002:a05:6870:79a:b0:e9:109a:1391 with SMTP id en26-20020a056870079a00b000e9109a1391mr7671334oab.105.1651003818223;
        Tue, 26 Apr 2022 13:10:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s2-20020a05687087c200b000e686d1386asm1169997oam.4.2022.04.26.13.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:10:17 -0700 (PDT)
Received: (nullmailer pid 2456245 invoked by uid 1000);
        Tue, 26 Apr 2022 20:10:17 -0000
Date:   Tue, 26 Apr 2022 15:10:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        ilia.lin@kernel.org, devicetree@vger.kernel.org,
        krzk+dt@kernel.org, rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: opp: Add msm8939 to the compatible list
Message-ID: <YmhRqZ7wuzYr2GAy@robh.at.kernel.org>
References: <20220418162226.2983117-1-bryan.odonoghue@linaro.org>
 <20220418162226.2983117-3-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418162226.2983117-3-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 18 Apr 2022 17:22:23 +0100, Bryan O'Donoghue wrote:
> msm8939 will uses this driver instead of the generic dt-cpufreq. Add to the
> compatible list.
> 
> Cc: ilia.lin@kernel.org
> Cc: robh+dt@kernel.org
> Cc: krzk+dt@kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

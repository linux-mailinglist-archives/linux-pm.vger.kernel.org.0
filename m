Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16326573E65
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jul 2022 22:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbiGMU7Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jul 2022 16:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiGMU7X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2022 16:59:23 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038193138C
        for <linux-pm@vger.kernel.org>; Wed, 13 Jul 2022 13:59:22 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so33453fac.13
        for <linux-pm@vger.kernel.org>; Wed, 13 Jul 2022 13:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Iy/UJWKR5huMTWOTUJ7PMuUKCqyKp2GPADHXYhygaqo=;
        b=DA3R8cYIRk7VKjccdgyjTm7HOAuA6Y8SrziD5UUQql3w24Ae4kEhMhp1Lo2MaV+E2O
         n3eJlHO6iPzUY8pxVEGrtax/2QTZfoZD7w97jvsmVxqD/9N2VwC5vvQ2ro6ph00Uv4bc
         kbHVtaQ+hEY2HqZ1jhq/qXkVIsZtvxbDCOOdR5OTv9l8CzAr61OkBOYhvTCTqrBE9Zay
         p9mv8XKfSah3JLLS3Taq0AwK85ucucA1eZ2GNDPUkVLtAxuTrIarWGBjBydZMV9/jK7Z
         sBiBA2y/sjYcBMYsogJh8h5bU7fp46xuR/1EYkyT+UfYWIm7qN9sqeUTwX0h70ZhkjTZ
         O1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iy/UJWKR5huMTWOTUJ7PMuUKCqyKp2GPADHXYhygaqo=;
        b=YA5A8jj0Kn6YV9OJZYBl1VY8I5X3xsrSWZubXQITgGhwLnjyBNVFKaFvrkKQm8JS/h
         B30N/Qc17H6wPKIjnQmOKZxoxmDRtBICNLac7MR7kMSCzV2nsaFzM6iKk4OwZ44w5U0S
         uUcjEQ+75z4qw0HTmpbL30LO4uwHQqfkMZ0XHGo/Ib9xXcu8dKHa3EenUyd6X42bQgy1
         fQuv+WmeCmnWAt4Km3bzEOOLaJ8d0u6WmoWp7mK3r7/W9Kwx3Jri57mqpBx//mZmQk/L
         pm1kPQ/BpOz8ufuePJmGKJWQfJORGPgk2F9nksIAyoLz2DUpfsl3UFoXY4BUj8FOWnxT
         DvvA==
X-Gm-Message-State: AJIora9QpRSz+CcWdQfNpOVzzCVCvWGc/0xodNwEhvbBTtvqUnogKVnc
        qdr+yhVqNmAtoj7YxGfiJZJZpA==
X-Google-Smtp-Source: AGRyM1uMUmDVNAa09N+U5l3pz+CeglZM4P6VYV/blyF9YOHUeJDqtcqxoQfEMA2sCoBJoj4UTgRgUg==
X-Received: by 2002:a05:6871:78b:b0:101:dc48:72c4 with SMTP id o11-20020a056871078b00b00101dc4872c4mr2912688oap.145.1657745961285;
        Wed, 13 Jul 2022 13:59:21 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i10-20020a056830402a00b0060c237c6355sm5119997ots.71.2022.07.13.13.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 13:59:20 -0700 (PDT)
Date:   Wed, 13 Jul 2022 15:59:18 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, konrad.dybcio@somainline.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] drivers: thermal: tsens: Add support for combined
 interrupt
Message-ID: <Ys8yJutlV00q1hFX@builder.lan>
References: <20220708132930.595897-1-robimarko@gmail.com>
 <20220708132930.595897-2-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708132930.595897-2-robimarko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 08 Jul 08:29 CDT 2022, Robert Marko wrote:
[..]
> +static irqreturn_t tsens_combined_irq_thread(int irq, void *data)
> +{
> +	irqreturn_t ret;
> +
> +	ret = tsens_critical_irq_thread(irq, data);

Perhaps you could do something with this return value?

> +	ret = tsens_irq_thread(irq, data);

As written here, return tsens_irq_thread() seems cleaner.

Regards,
Bjorn

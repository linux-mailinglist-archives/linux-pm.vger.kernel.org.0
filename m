Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C827A4C27CD
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 10:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiBXJOu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 04:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiBXJOt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 04:14:49 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A381B8CB9
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 01:14:20 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id u16so1308883pfg.12
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 01:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QH6vcKmOjHclGPrSiGYzmgW08USM5b8guwSq/ZDDFXg=;
        b=GvXbX9L95/PoxktaE3BrW+ifYmtZ7mqj7Q90j5F7WQ2Lf9lmglmjTzl5TEAJxfyF3a
         umd7gQHbgS6eTuMcVb9U/uKq7j6oTAVbbOTXMyFxaSptsFyJugbARNL4ZmXF+XbZuQ8H
         Yd6qMDEMQaGc2yplLbkktBFbWAvJm2qLvT/l+0fo78NeKSuRkhnC2+Md3bDWi6s7z7Uw
         XyBbjmSGg2ZzBRJOnEFqWkX2g6LxNyiDdf296u8vhkWcMSsXL2i0I34s7X+xcFJwNNdd
         fU1Qarl3CYNNv0H1hQeaMUyB7QTh7GE4AatVVluAyNTcaaT+mGEWxjd1VJvvw0a4It4C
         gqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QH6vcKmOjHclGPrSiGYzmgW08USM5b8guwSq/ZDDFXg=;
        b=vUDS3sLAJbGmVANBkAIFebahUohdd3YQOBEi5lYpOahm7MulbeXwTR+p9Z+z3a/OVF
         WM1OVh1zbRWKTq8MVW2U5l7USdcLbIvS1AqzH69lCwNUjKfFuGRYId9Ye2C4028a+qeD
         mCrkEptY+i2dyF11F1cr0HIc0TdrNWX9OsCYD4BPOKbY69ARvKzhbY5caZxUvPSxrspU
         +/NpzGuJLIw5Gi/Bbv+/v2fmvz4xWL3WmHt2QTF0Kx7TRh5fK/Cm/M4a2mWAN4Etvpq3
         gPTzG/tzvVuCUNv4mjv246H3dCBQquFHiii+0anvEkdcylM2lDor18mu4A39iIiP+UI6
         1zyg==
X-Gm-Message-State: AOAM533GYGFuSlz/3jjxI/PhZb4/Mflp4DNy3dIpo8K0WVE1QTvc8w4m
        uChkv2XPfG67tZ24/N4+3+2Kvw==
X-Google-Smtp-Source: ABdhPJyyoPkkvnwKNV7OXnyeehTEBcSsUUIcZZsw3NCCEKUpNeCt/u+qbNyfjrNBnBGRxIhmiA8HMw==
X-Received: by 2002:a63:9351:0:b0:375:8d1a:4766 with SMTP id w17-20020a639351000000b003758d1a4766mr760971pgm.102.1645694060173;
        Thu, 24 Feb 2022 01:14:20 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id k11sm2459550pfu.150.2022.02.24.01.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:14:19 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:44:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/4] OPP: Add "opp-microwatt" supporting code
Message-ID: <20220224091418.wodurdfhzyrtqepg@vireshk-i7>
References: <20220224081131.27282-1-lukasz.luba@arm.com>
 <20220224081131.27282-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224081131.27282-3-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-02-22, 08:11, Lukasz Luba wrote:
> Add new property to the OPP: power value. The OPP entry in the DT can have
> "opp-microwatt". Add the needed code to handle this new property in the
> existing infrastructure.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/opp/core.c     | 20 ++++++++++++++++++
>  drivers/opp/of.c       | 47 ++++++++++++++++++++++++++++++++++++++++--
>  include/linux/pm_opp.h | 12 ++++++++++-
>  3 files changed, 76 insertions(+), 3 deletions(-)

Also update drivers/opp/debugfs.c please.

-- 
viresh

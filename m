Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7935451F908
	for <lists+linux-pm@lfdr.de>; Mon,  9 May 2022 12:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbiEIJsd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 May 2022 05:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiEIJPW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2022 05:15:22 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F90B1ED5AE
        for <linux-pm@vger.kernel.org>; Mon,  9 May 2022 02:11:28 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x52so11718644pfu.11
        for <linux-pm@vger.kernel.org>; Mon, 09 May 2022 02:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7QpxuoVC9zQ059fU/VCO45VAfx6s8GhPEiX2c3POePM=;
        b=NcDYpNTw04yugULw2lGRPP8uvp5iDaWIg0Cp83izxqM6A+vpvp3r73InUADA5S/+yl
         /bUQgAbVun7lO/SrKqe3BscfTx87KV0KGXXOUtm05SEuQT2T/EzBfyBziD+Ru1pSxYxB
         uRheeODB9N5K98Z+wxZkt75t7PyiIEBycBKZiwdobxmqb20wJMq6/69yPJXXtLYiBUta
         p7NLsTeoh0mDe6rxbNgt23gvteCIu4YTAqeHIQTdeOWvQcu5t3cD5n6Q5aaK/JxJcWrw
         qwQLl3kimsJcId7BZDfqPXNvL/Aw5boIH8aoSWxaIuiyYhEyH5CRxIzACxYLjwd96QS9
         TttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7QpxuoVC9zQ059fU/VCO45VAfx6s8GhPEiX2c3POePM=;
        b=2aJfWG/U0eYIiEHlD2LKw0XgYnivVoj6ZoKeyr1AkvIaFD9SliTcAQRn35eO7pEcbR
         oNsOXH5TIr+Cblqgu1o629JnDpGwPHZB/VssB7+baXJNA0dOyIaN3fcUpV4WMM9DO1/c
         5F+hrgu1xMz1cv+GMq/pvrGcRRXq8b0RAi982xI3lt0UVUS5M5s22M7Hki5LUOBzdiZx
         QDFWmqOhVdCnCKtq0TQuYtvTyqU4rYXPZBdSB06Cd69eNyEqO7dMUy27UXBxKtzDrk5A
         LKc0pOjlsLKNNvcmiheiLsUFFG01QEaSxj3/Lp24v00TeWS17fB6PPi+0ogBD7rMiovy
         oXag==
X-Gm-Message-State: AOAM531R3qrs3udsWn48DbFkD5Weyz10fhaegMIkFkfLj3tqvGB036b0
        kGG0wPePAKwOR1dNnT9jNCZuUQ==
X-Google-Smtp-Source: ABdhPJxOwO6usL9axVziBSOIzqmZTG8IQH2ceVvogPLS2D4/RbZmODDEy76gkcTU+6D0WXe67qjY/A==
X-Received: by 2002:a63:d43:0:b0:3c1:475e:8341 with SMTP id 3-20020a630d43000000b003c1475e8341mr12236858pgn.533.1652087488293;
        Mon, 09 May 2022 02:11:28 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id h27-20020a056a00001b00b0050dc76281d7sm8361307pfk.177.2022.05.09.02.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 02:11:27 -0700 (PDT)
Date:   Mon, 9 May 2022 14:41:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     qianfanguijin@163.com
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] drivers: cpufreq: sun8i-r40: Add cpufreq support
Message-ID: <20220509091125.tps3zwaq276jlgh3@vireshk-i7>
References: <20220509084853.17068-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509084853.17068-1-qianfanguijin@163.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-05-22, 16:48, qianfanguijin@163.com wrote:
> From: qianfan Zhao <qianfanguijin@163.com>
> 
> OPP table value is get from allwinner lichee 3.10 kernel.
> 
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi     | 47 ++++++++++++++++++++++++++++
>  drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
>  2 files changed, 48 insertions(+)

Applied. Thanks.

-- 
viresh

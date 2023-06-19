Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF49734B0D
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jun 2023 06:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjFSEU6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Jun 2023 00:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjFSEU5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jun 2023 00:20:57 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48F81BB
        for <linux-pm@vger.kernel.org>; Sun, 18 Jun 2023 21:20:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-543cc9541feso1462039a12.2
        for <linux-pm@vger.kernel.org>; Sun, 18 Jun 2023 21:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687148454; x=1689740454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1l4vsjs5Wz2KIK8r7+WLbl+tZRj7gVMK7Cpr/8uQS9o=;
        b=tcYQRnvrSG8RjCqn+QGoeD/lj68ft/O3mgQshnxYRugup6ddEWZoExwNGzx35QJ50m
         sFoRy7xGlpbraZmXQMt6Kg0nqrqgEN2q+1lfKEQXzc99omrvCGAQkdHV2NXFJk3RakVi
         RYwg/ops7BtTG2jLPGmXjse4UTbM9Me0BDyMuH97tqRG2e7gIZukAgP8kURnkVErFpRy
         BrS5r2Xb9XTtUNbIDsMlcN0fSUPKMj4l2dQ1nFh0FzbV/nJOMgSz7+Y0SWVUtFlKYjzx
         r2oRr3OiQw6zGhRB0KyEUy1KjL8vWscNkFNK+Z+63dNNT5AxH3jWhUKqCeJgx5J/8MlL
         lb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687148454; x=1689740454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1l4vsjs5Wz2KIK8r7+WLbl+tZRj7gVMK7Cpr/8uQS9o=;
        b=TV5PHAo1sXcnhEUj7yFcHlx063zrIa1p5JspN9hutUyILdb8t99gAjjPVi3jvlbj2O
         s9cVQ9Yd8xjt04Ktx3zMmmcarYXRqwnNCC72xjSJ00V9dIqQzrPRdDd9QbEwfvMOQqWa
         2Zi7vVklTrYtwyd1Rj/pIaF6jClzGDFs5geYqIPnOqINZCE6ex0g/Vg2F4s2gOpa4lPe
         sKcjA62uls18yf2qA3X0XR2+jp1RUhmYWe08Yamk+i8Wm4CBlBP+hVTEX8e13MCU7BxC
         lytfq/sjabGMP3GUYo1OnYMeOqaUG83eiB5VG2DPQnuMuG8QZk0jf9tEdMD7wH7rqrzY
         Z9mw==
X-Gm-Message-State: AC+VfDxDa6fhd3tEXENFBrps2UMWZW/D+vrqFhGGAKWDZ4JwKnGCzURV
        fKc1zX32O8CWNsu1UXPMoVNpuw==
X-Google-Smtp-Source: ACHHUZ5CpaCKFhrzTVt1Xuj4yuTUAIz89O01a/+rpBCGJJgPHTspI4ncjd4Gnnvio1m+j0sHa4hXVA==
X-Received: by 2002:a05:6a21:170c:b0:10e:a8e6:35c5 with SMTP id nv12-20020a056a21170c00b0010ea8e635c5mr6856979pzb.59.1687148453749;
        Sun, 18 Jun 2023 21:20:53 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id o6-20020a170902778600b001a1b66af22fsm19397537pll.62.2023.06.18.21.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 21:20:53 -0700 (PDT)
Date:   Mon, 19 Jun 2023 09:50:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Josua Mayer <josua@solid-run.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: armada-8k: add ap807 support
Message-ID: <20230619042050.xtfkpfasuweqiknz@vireshk-i7>
References: <E1qA7pa-00EZw7-R9@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qA7pa-00EZw7-R9@rmk-PC.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-06-23, 12:41, Russell King (Oracle) wrote:
> Add support for the Armada AP807 die to armada-8k. This uses a
> different compatible for the CPU clock which needs to be added to
> the cpufreq driver.
> 
> This commit takes a different approach to the WindRiver patch
> "cpufreq: armada: enable ap807-cpu-clk" in that rather than calling
> of_find_compatible_node() for each compatible, we use a table of
> IDs instead.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/cpufreq/armada-8k-cpufreq.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Applied. Thanks.

-- 
viresh

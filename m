Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849F668EC53
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 11:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBHKF2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 05:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBHKF2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 05:05:28 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DB322007
        for <linux-pm@vger.kernel.org>; Wed,  8 Feb 2023 02:05:14 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u9so14413117plf.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Feb 2023 02:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BKlbX6lSCW4YfG/Sc2r3hgqJi0feeUm3Cf8s3NMDw9M=;
        b=iIhq5y5y3qql2O89N8uOw02N8v4e3sP0m2pxqSNl1QOA3gmjEa42x54KgHjEmyGEhj
         AmCPjfR7vbqOikwIWyqObPv6lCAwHS5ftNjCXTjZf8RhUClbxc6b0zPrHaQ1KiITpAqv
         YVAhFmD++GJsTsO6mhygykVVakA6opy7JoyJb4/1FuQ9GmKw2lu5rhtW0Cq3Fa5aVk20
         ZVR0uqkTYkG5QT0/pybnNGBFChWylM8vNHyKOleGuyjA214vMNRjmvBq1w3jGqybFBvT
         FaggOYnfN/KEitozIjZx3/KjKvYGGVPs/UhC1yY8Qfg/2YdX6A1jNC+gBYRGgpG1TuwS
         gF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKlbX6lSCW4YfG/Sc2r3hgqJi0feeUm3Cf8s3NMDw9M=;
        b=CXCZRPFSUiO9jO2PUaWx7FUd4jCOVXVSkQOWdsH+54JRNvC5kp1AUbBJ0fqWdKNO9f
         nB3ULKFoA+KKXyjpizgHYFKgSxkmmIDwqK9PeyfmBNCuzPEQwECINb+pOfzKj1QRGiui
         h0C2roZwavzuhSDtimnL7zVspDj8t8fdIhDTKsa1ebK0//6rk4qyQv+zwLWKocbI7u7A
         puJU4kkJenJkmwkbCyBbMoa2iUFYUHFODS20dSiQdOyur9Y4cupkACj8SQvSS9kyczqR
         LmFMiGvgm9sRb7g6XacMP2pDp5Xkt+grXxVnG5lwymIsVexNdXFyzLINxrlLmMsP4MrK
         k9qw==
X-Gm-Message-State: AO0yUKX5ZekaXdYpQ3AaZFrWsF8YI5tchYi6C6MBBYmufQ1PhChNoE3o
        eTMM8YszaJDp0gMXPx/3ngY9Xw==
X-Google-Smtp-Source: AK7set8DaL1jJHGRPoRk13+1rZUP+2yOLLcZuHigfM0pq55WBzP8Ac2CERNDBOhtEbjuKzUwa97C2Q==
X-Received: by 2002:a17:90b:4d0f:b0:230:cbb7:b59a with SMTP id mw15-20020a17090b4d0f00b00230cbb7b59amr8019660pjb.30.1675850714097;
        Wed, 08 Feb 2023 02:05:14 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090a31c800b00231157f0439sm974604pjf.39.2023.02.08.02.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 02:05:13 -0800 (PST)
Date:   Wed, 8 Feb 2023 15:35:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@deeprootsystems.com>,
        linux-pm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH] cpufreq: davinci: Fix clk use after free
Message-ID: <20230208100511.uzc2zxyezyyq7ypz@vireshk-i7>
References: <20230208092654.551466-1-u.kleine-koenig@pengutronix.de>
 <20230208094451.wib7on57imsujbaj@vireshk-i7>
 <20230208100222.7fclfhv7oxbojrg6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230208100222.7fclfhv7oxbojrg6@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-02-23, 11:02, Uwe Kleine-König wrote:
> Ah, I intended to write a word about the dependency patch. Do we want to
> backport this patch to stable? If so it might make sense to rework it to
> not depend on the "cpufreq_unregister_driver() return void" patch to
> simplify that.
> 
> I can help with reworking, just tell me your preferences.

It is broken since ever, 2009. I don't see much value in backporting this since
no one found this issue earlier.

-- 
viresh

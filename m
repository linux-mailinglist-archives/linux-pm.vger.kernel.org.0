Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D6877F287
	for <lists+linux-pm@lfdr.de>; Thu, 17 Aug 2023 10:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbjHQI4u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Aug 2023 04:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349149AbjHQI42 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Aug 2023 04:56:28 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ACA2684
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 01:56:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf1935f6c2so1901025ad.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 01:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692262587; x=1692867387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ptze6wxZV514oS0u92VIY9O4Y7H/mluSZc2DMC6gWxY=;
        b=FkGU/hYU22VtQfcjslmCB7Eku6oqlepKKvYflypvWxwE5eJurcUMGULy6KJ4NsCqPY
         TdWSGeDmWVbZftbl7rc9eU5nta2jIa/Xf1nukzVpcLk6macZBlbFHlvrNWMKc35mE+bc
         y+IBiXwDawJN0XHqZQ7rlIjM69uHAMtoREtvYzvQfiBiCDxuIk4WF57HJOLMQx6gUZ2V
         9IeVSD8jE9VfEBD/2J9VKZeC26my7sQM8+OisNt4LFVPHEQLZYeA0g75586NUbLaTDsH
         45lP7QpKCAfYeUhfzLhl8uuXyXCbcBG8nHQ7PIE042Stn8nhF5xSkm/aI8LL3aB/35LN
         zT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262587; x=1692867387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ptze6wxZV514oS0u92VIY9O4Y7H/mluSZc2DMC6gWxY=;
        b=SSIv/dMjTWqz37T5wNEm4t3IYziK05tpCmu3OzQGQWP90fJb0UY4uPX8uSj70P8YT8
         RZ+Km1+wUb7A0jSrYgPp0szVzsdrb4RsYawIMf3LLmbGmAApDCPxwK8evH1nRaISadH7
         1FTgeKbHBD1SWQfku2DCwGB1Npc7Z+Ki1f3ge6wvbq13pA+uxKMg6yBuI1bMgCRxF5T8
         Zayo1LgRU165gr7XqqCW8Zz0KKaOMYEUR2HvCJAdQuR427BvzmnknDMJVEQRbUvNoKsI
         BYxlgkY6Lp7HPVYoBA0XQNGrAcyVPgcvppNK323+4wWJqYy+5JoBTxvdJO/Y7PXzBwtp
         1d/w==
X-Gm-Message-State: AOJu0YzUyIkUdpiULlp5faMn2cNFgriUvSQHe7vP/S5K1GacdWoRmntc
        cPTPAuTBJG8/h1fuKUGi3FzNug==
X-Google-Smtp-Source: AGHT+IFYnONOUzUUhleUOayXtQmkupns0vXfS1SaXmi+vUdyLJtjr255SOUv8MF7357tYQr9D1ZTmA==
X-Received: by 2002:a17:902:d48e:b0:1b8:a67f:1c15 with SMTP id c14-20020a170902d48e00b001b8a67f1c15mr2681591plg.25.1692262587137;
        Thu, 17 Aug 2023 01:56:27 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id jd2-20020a170903260200b001bdcafcf8d3sm10164168plb.69.2023.08.17.01.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 01:56:26 -0700 (PDT)
Date:   Thu, 17 Aug 2023 14:26:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: cppc: Set fie_disabled to FIE_DISABLED if
 fails to create kworker_fie
Message-ID: <20230817085624.dfevjozfpmmxcldn@vireshk-i7>
References: <20230817074756.883380-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817074756.883380-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-08-23, 07:47, Liao Chang wrote:
> The function cppc_freq_invariance_init() may failed to create
> kworker_fie, make it more robust by setting fie_disabled to FIE_DISBALED
> to prevent an invalid pointer dereference in kthread_destroy_worker(),
> which called from cppc_freq_invariance_exit().

Btw, this version information present below should be added ... (see later)

> v3:
> Simplify cleanup code when invariance initialization fails.
> 
> v2:
> Set fie_disabled to FIE_DISABLED when invariance initialization fails.
> 
> Link: https://lore.kernel.org/all/20230816034630.a4hvsj373q6aslk3@vireshk-i7/
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---

... here after the "---" line, this way this not-so-useful information will not
be committed while applying the patch.

>  drivers/cpufreq/cppc_cpufreq.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
-- 
viresh

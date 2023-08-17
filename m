Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E032177F472
	for <lists+linux-pm@lfdr.de>; Thu, 17 Aug 2023 12:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350003AbjHQKsb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Aug 2023 06:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350007AbjHQKsF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Aug 2023 06:48:05 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3163B271B
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 03:48:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bdf4752c3cso23228695ad.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 03:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692269283; x=1692874083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LsCwTVKXAuO2xXELUYhexZa/dCuT2MEKQ5MSpp0SSew=;
        b=OfuI0ynuY5H9DGWIqDv+Tv9TQ4aty074NXkUl9l5AKMiV0unV2WUzItOxniIPeo78q
         CO2y+ewzkMlkLbS6OCryMSQ2UbqglM00OYIn5H1Mlj6+ZL9zgJ/oX7Db/oFNBmNSrVA0
         ZTQMIObVkmBdAsWq4Hc2ZCqo2Xx6CaTFW368nMOMbcog1QWPx7M+lGpv0nkpN4FH54iU
         3bFLjLA8E9HMOT1yU/DTQrfmUTgtUhTcrgBIU13PXxtB6tcg0vJay8MH/PkoEz+uLAY7
         i8dagSKEv4UAdT5tl1JGqi+ALUY8jyILeJ7hUHbBgSjzS261DajAHzimYl1AXUJkAPIP
         +5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692269283; x=1692874083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LsCwTVKXAuO2xXELUYhexZa/dCuT2MEKQ5MSpp0SSew=;
        b=N7l+YhXIArCUvWwVPSG6qaQhs/vQQDXp5hiUvabH1h8iceez2VHX0zB2rlmFYVmZwy
         MgqGxIIGI++dY7hkWuJZVUTrmzWncDGI7HCfQ6uTDowuIdA856YzjPIvkYyQm26KJKv9
         buqEXxTfKz5ZNYaIj/Q/lVjbIDkJKhpZR3mpyArXUvLpKlUwjkm3VE/zVnDRSSqM2xg4
         bZUH2z2UJmAazwd2p0xKxeM9SLH3zRAsG30cIre2WXVrNfSDxNjzUqCjQVCgoD6tWIys
         WLtYa580Ye3ltL5vL0/QsPWa/VRBkT5Pw9FyeqLOy/YNpV4QNPqEV9vVBKCq6kXrtTt6
         veIw==
X-Gm-Message-State: AOJu0YxKRSIsz75JMBacwuMB1pBw0o6q2oAb1XPIr96raPxBmveSSSRc
        eGmVTE3nZQ8RuYLjjOutgQuYpg==
X-Google-Smtp-Source: AGHT+IHsLeBMFMgY2eVPdXu/L8IgwcQA6hGBcRA4M4lekyrTsD8UGMzOJSusK/5TSsXI7DIwD6iTNQ==
X-Received: by 2002:a17:902:bc4b:b0:1bd:f71c:3af3 with SMTP id t11-20020a170902bc4b00b001bdf71c3af3mr4142558plz.32.1692269283603;
        Thu, 17 Aug 2023 03:48:03 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902eb4900b001bc5dc0cd75sm8763622pli.180.2023.08.17.03.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 03:48:03 -0700 (PDT)
Date:   Thu, 17 Aug 2023 16:18:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Liao, Chang" <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: cppc: Set fie_disabled to FIE_DISABLED if
 fails to create kworker_fie
Message-ID: <20230817104801.5bdor4jbdeqlttyz@vireshk-i7>
References: <20230817074756.883380-1-liaochang1@huawei.com>
 <20230817085624.dfevjozfpmmxcldn@vireshk-i7>
 <7fca5d2d-ad02-08b4-01d0-e9d997a7a58d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fca5d2d-ad02-08b4-01d0-e9d997a7a58d@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-08-23, 18:44, Liao, Chang wrote:
> Hi Viresh,
> 
> 在 2023/8/17 16:56, Viresh Kumar 写道:
> > On 17-08-23, 07:47, Liao Chang wrote:
> >> The function cppc_freq_invariance_init() may failed to create
> >> kworker_fie, make it more robust by setting fie_disabled to FIE_DISBALED
> >> to prevent an invalid pointer dereference in kthread_destroy_worker(),
> >> which called from cppc_freq_invariance_exit().
> > 
> > Btw, this version information present below should be added ... (see later)
> > 
> >> v3:
> >> Simplify cleanup code when invariance initialization fails.
> >>
> >> v2:
> >> Set fie_disabled to FIE_DISABLED when invariance initialization fails.
> >>
> >> Link: https://lore.kernel.org/all/20230816034630.a4hvsj373q6aslk3@vireshk-i7/
> >>
> >> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> >> ---
> > 
> > ... here after the "---" line, this way this not-so-useful information will not
> > be committed while applying the patch.
> 
> Got it, I will move the "v2:... v3:..." lines below the "---" line in next patch.

I have already applied the fixed version now, don't resend it :)

-- 
viresh

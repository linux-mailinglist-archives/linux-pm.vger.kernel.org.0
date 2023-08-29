Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1090678C04E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Aug 2023 10:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjH2IcK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Aug 2023 04:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjH2IcA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2023 04:32:00 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481DB98
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2023 01:31:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68bedc0c268so3578369b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2023 01:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693297917; x=1693902717;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kxEvsNmBX1w/FxBOil6ywt2JzLvDO2Z9SpnBsUOMs/g=;
        b=Wg9YQW19Ga4tL5U4iicqXb5DnAOusUtkmDRn1qpV7pcDkElGX3fU6xvrduZd+v2bNQ
         54DR1LvFSBNBYHpkGgyPd4uu2HG3+6L5nDJJDZs0cn0S2k7ILRz4MqlHDqU+e7qaVzs6
         4SatVTRK8vCHErExeGOq08+vO2jNNU+qGwE7xeOGhQwyD1hxWr1WhTnSaTQaoP7YWhnt
         A5BlAaFz0vX0qRQD80A4JPpHzrK9jhUypK5DxHB0fKV+CI+sivRBHjOT6VinaRyKTIom
         2BqpWXDiWP+oCdmo9IL/Z4+0lMZiJ01H+AYDoIG738kZApHE+fZ3uOln+DgjxAb1xa3F
         mBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693297917; x=1693902717;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kxEvsNmBX1w/FxBOil6ywt2JzLvDO2Z9SpnBsUOMs/g=;
        b=BX1NAjw4gXd6Xmd36slRklAiA1/7nYPkxuMcRwHlGJIGCnWXe5k2g2TAChj60R4ypc
         8mLtvZQ7RT4GX33Yatea8boHVSN7cSdr0uWzq8QALq++Qo5EbWIOHlUG6c0ZVBeWVP3d
         yuLlg+3c26VMpq0CMrmFWFX3iFEO/Y2xVjl9Ki+PwC8VIyar/72v1CY3nibKd1e/F3fU
         oY0ULSAi+dPBrV9KOqQH+apzR4Bf9B+C13l2t6lDTMcDNG/eHVDQmcV51NhLAtHXa+uQ
         1fCXDXewzesM9lb6yVJEdvWzGuob8E23ZVmua29dKppLJ7tT/RjOhPVwW+RON3M6gz+H
         TAwQ==
X-Gm-Message-State: AOJu0YxrMYDbvFQDjm0snnTpFk3TNDMWuvJZgccNp5ABK6Kz+IRfETsQ
        E09WOJ43hW2JG6sRjDxE6UrIzg==
X-Google-Smtp-Source: AGHT+IH3Bc9VVldqwH6h3JKmUdZSrwY9deKbBhswjSLhSRD2dJd7heOvhVyrXTB8OXkJSJk/Ino3vQ==
X-Received: by 2002:a05:6a00:1702:b0:68a:2c24:57df with SMTP id h2-20020a056a00170200b0068a2c2457dfmr32445133pfc.7.1693297916743;
        Tue, 29 Aug 2023 01:31:56 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id u24-20020a62ed18000000b0068620bee456sm7818917pfh.209.2023.08.29.01.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:31:56 -0700 (PDT)
Date:   Tue, 29 Aug 2023 14:01:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Chun-Jen Tseng =?utf-8?B?KOabvuS/iuS7gSk=?= 
        <Chun-Jen.Tseng@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sumitg@nvidia.com" <sumitg@nvidia.com>,
        "sanjayc@nvidia.com" <sanjayc@nvidia.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] cpufreq: mediatek: change transition delay for MT8186
Message-ID: <20230829083154.27ckyuwnqk4zpejs@vireshk-i7>
References: <20230818020616.4748-1-chun-jen.tseng@mediatek.com>
 <20230828063904.r7huxclehlblkkjx@vireshk-i7>
 <86f49ce84f32941185c961da8a5c671e7aed46b1.camel@mediatek.com>
 <20230829071022.n7wubb2dhbt3ukyk@vireshk-i7>
 <d0745e1cee9fae33252bb8d3db741c2a463983d6.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0745e1cee9fae33252bb8d3db741c2a463983d6.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-08-23, 08:25, Chun-Jen Tseng (曾俊仁) wrote:
> Actually, the root cause is the CPU freq setting finish time. If MT8186
> needs 10 ms for two clusters findish setting CPU clock done, I should
> set transition delay 10 ms which avoid call clk_get_rate() get previous
> clock value. If I get previous CPU clock and it over 1 Mhz, the
> cpufreq_out_of_sync() will set CPU freq again but it wrong CPU freq.

Even if another attempt is made to update the frequency, it shouldn't
result in crashing the kernel. If it crashes, then there is something
wrong here.

> Howervery, transition delay seting is by individual SoC , it should not
> force 1 ms for all SoC. So, I wish I can do this patch here.

Its fine if you want to make it 1 second too :), the only thing is
that you should do it for the right reason and I don't think we know
it yet.

Why exactly does the kernel crash here ? Any idea ?

-- 
viresh

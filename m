Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDF7640507
	for <lists+linux-pm@lfdr.de>; Fri,  2 Dec 2022 11:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiLBKrh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Dec 2022 05:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiLBKrg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2022 05:47:36 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D59D76
        for <linux-pm@vger.kernel.org>; Fri,  2 Dec 2022 02:47:34 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id h33so4053759pgm.9
        for <linux-pm@vger.kernel.org>; Fri, 02 Dec 2022 02:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgZSbXK5o+bjYMnDUxSeKCoU1ZNZ3QNjnUYkpRFNIuI=;
        b=mX1kjgJc4h7LRgfUswxA//V9WUVhM5wGeGXf0CyYSKUjR7ge2zNybUdZhpqFbewLCT
         u36cI4CItXFWnDXJxYQVy0gRi0y24BymlYVH9WYUAr0Khp9uKO56C9hEBUPau9PMQVHj
         CxOhg4jSYeSzGgZX455R59cDvxqPVOZON0SBVmsSaMzV+D6QoJi22ciGy0O2uIK1AY4F
         E3vO+C6dXnSI3a6wSnp4Z4JvvQgyyvz9PXwCHc3JkQZoigFwlWAavsQsmvGHU5RpgsNo
         5Nvdo5Qnj2jjvZjra5W3KYPx2Nf8uGmMYcL7RT5ZkzNI4t6OLS+CKE3RKH0TctxRgtih
         TEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgZSbXK5o+bjYMnDUxSeKCoU1ZNZ3QNjnUYkpRFNIuI=;
        b=i8RYIrW6eWqOdnV2M/ifCjWh+KA0J6GTc1GYowixdlhP+mrlZgLB8QRQYPPvy2IwFN
         8EL+LaLqOvjhh3M7wXlykBuphpsxbHoaoS1ALT+GnE1mXtbdR+Afney33r+O+q+NH11y
         7miMM4CaN87hliuval9dMiDUhOu4gnOHtignsevLq9yacPlTB58/7iFXFOGdPr8S2XDS
         lThT1oWSPfaKpQKAWmNRf0v6ysIrvCXN2bHD8uAVT7JV2LUoy7DjLmPAB3thYI/xMsTu
         WlQ9LY5pGfmqr0+O635mjKcGhDR5Wee2GLXX05qW1uGmwceN1WdOAQtrALaPme5kzu8M
         gwdQ==
X-Gm-Message-State: ANoB5plPtWpc5gxP0F/KqVVrWnRoljsW5f60zqtp3EOqiONtnKo0biC7
        OXzNyph3+4jvzed5fYNf/OMFng==
X-Google-Smtp-Source: AA0mqf6TS5g3heiZgAiv8Xg5rvRSa1KrPHqVDeAXVy5mSEkOMG6N2DK4oaYrM0TwjOP6KliKXvikkg==
X-Received: by 2002:a05:6a00:1a14:b0:557:ef5e:6db3 with SMTP id g20-20020a056a001a1400b00557ef5e6db3mr55017894pfv.13.1669978054160;
        Fri, 02 Dec 2022 02:47:34 -0800 (PST)
Received: from localhost ([122.172.87.149])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902784c00b001888cadf8f6sm5258938pln.49.2022.12.02.02.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 02:47:33 -0800 (PST)
Date:   Fri, 2 Dec 2022 16:17:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen-KH Cheng =?utf-8?B?KOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "vincent@systemli.org" <vincent@systemli.org>,
        "frank-w@public-files.de" <frank-w@public-files.de>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        Jia-wei Chang =?utf-8?B?KOW8teS9s+WBiSk=?= 
        <Jia-wei.Chang@mediatek.com>,
        Rex-BC Chen =?utf-8?B?KOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>,
        "thomas.huehn@hs-nordhausen.de" <thomas.huehn@hs-nordhausen.de>,
        "daniel@makrotopia.org" <daniel@makrotopia.org>
Subject: Re: Kernel Kernel bug caused by (cpufreq: mediatek: Refine
 mtk_cpufreq_voltage_tracking()) on Banana Pi R64 (MT7622)
Message-ID: <20221202104731.63mfshxwu3mqlbli@vireshk-i7>
References: <bf8d2a8f-7654-29be-1104-a842c6657b5e@systemli.org>
 <02c2c955-940b-b315-0474-85d0eddad7a3@leemhuis.info>
 <Y4jHvomTrU8guBox@makrotopia.org>
 <47a4665e-333d-a6e7-a2da-96cb06c2d87b@leemhuis.info>
 <20221202052716.uj3kzkunazmgazeq@vireshk-i7>
 <0ebef1a2-6b5a-04b9-a79b-79eb3349c32b@collabora.com>
 <c76bd301-0e8d-2d2b-0d3e-a57ece9b496f@collabora.com>
 <b1822bbc3775730c4cedf9652323c7d72e663e4b.camel@mediatek.com>
 <8be3e050-f32a-6761-8ebd-49c38dfcf9eb@collabora.com>
 <c186d104-43e0-ca10-3ce2-c2f922acd8bf@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c186d104-43e0-ca10-3ce2-c2f922acd8bf@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-12-22, 11:41, Thorsten Leemhuis wrote:
> Quick question: is that relative to apply at this point of the 6.1 devel
> cycle? Or would it be better to revert the culprit (already introduced
> in 5.19) for now and reapply it together with that fix for 6.2 (and then
> backport to 6.1 stable later)?

I am not comfortable applying the revert to 6.1 kernel right now, it
is too late and the revert is big enough. Also it isn't something that
came in 6.1 cycle itself, so it isn't ideal to merge it as a fix this
late.

I would like to apply the fix, if we are able to settle on one, for
6.2 and let it get backported via stable to all the affected kernels.

-- 
viresh

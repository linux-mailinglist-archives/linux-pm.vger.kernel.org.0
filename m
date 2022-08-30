Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608E15A5DB8
	for <lists+linux-pm@lfdr.de>; Tue, 30 Aug 2022 10:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiH3IGi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Aug 2022 04:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiH3IGh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2022 04:06:37 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370F1267E
        for <linux-pm@vger.kernel.org>; Tue, 30 Aug 2022 01:06:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u22so10347773plq.12
        for <linux-pm@vger.kernel.org>; Tue, 30 Aug 2022 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=8Z25boPX4asRDgl02aIg3PuDzFAm2vwEFCuCA8c/wKs=;
        b=NTLe3/yVFyjXX7Ndf0xx8fMGW0Z5C1mTOjEEVDLqfOxeecLYNIjIjOw2sqWRhfmDTV
         g4N161eENmlepH9UNxMokK+b7y/TmnBZ85OWQIlRvV8y/5JEDh42WQJE39UZHmMtijH5
         qHb528wNSeXxoTZY0dfjVEj0/7hoZkRIPCoqTmkxWej3UZEUAV56pWuXLGoUKB3Mkjro
         bpkVONpHTaI7xzZ8fmy88o6gx2eDNfJ/P4wXVg4YGbD9wbI5XFhA4Wbzdnd8xTGw1obp
         Zzu4DabMAYhhAHznIsmYkXqNEiGEOrqgLH1feB6LMQZHLeNLVMkhr/1VRBKy7f7SS326
         O2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=8Z25boPX4asRDgl02aIg3PuDzFAm2vwEFCuCA8c/wKs=;
        b=oeR9Erl1xnlRlFsccoiRTSpCCIafqigwkw2OoaHsmzR9io9Lxx5iDaWUFNdVYqn/3Q
         /IqRfnCmwpwrqb+g4vnKECXLyfUWVEkZm8N5ly9AQ1eWDK9zKLnvz4FwVaJDqwgoIcni
         dO47/jLj7RO3zrQMU9XJcB1RtYrqYMLY2496EdtOOCKHQ2uqcyKcgiSbscAB8ns4jbTa
         hCoCfm8u92C/rOMsLBDL7HSkBy+Iv/f9lGenD6POePS/xFB+R3u1szYdeb+V7wvNYPLD
         vfoUAll9jCIo35o+cZAuZB6My9V/xp0RPwk+H+kcnsx1pg7GbiUyCPdMxCCii8D6CKpR
         OaPA==
X-Gm-Message-State: ACgBeo3xROfNyJeMTQfCGV3M92PCg8b/YVQ6KTHk5tFMfmfToFEJuuav
        q0LTC2UzSJz1t4B6LmZlYqMQVA==
X-Google-Smtp-Source: AA6agR7DXJFMnHqD98ybdqHiAh9gSYgLDf34vWnO0ZLUMTHPQ7lPc129/PQ6IxeiMSHcT7dwlzTlCg==
X-Received: by 2002:a17:90b:612:b0:1fd:5ec1:6c74 with SMTP id gb18-20020a17090b061200b001fd5ec16c74mr21275408pjb.221.1661846795669;
        Tue, 30 Aug 2022 01:06:35 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709026e0100b001618b70dcc9sm8876241plk.101.2022.08.30.01.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 01:06:35 -0700 (PDT)
Date:   Tue, 30 Aug 2022 13:36:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "zhangjianhua (E)" <chris.zjh@huawei.com>
Cc:     mmayer@broadcom.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: bmips-cpufreq: Use module_init and add
 module_exit
Message-ID: <20220830080632.2iaq6juv6snma3gu@vireshk-i7>
References: <20220826021845.2283648-1-chris.zjh@huawei.com>
 <20220830052922.aedexy7ovdus5pzk@vireshk-i7>
 <954cdab4-62d3-b413-f615-9c7b1563c1b1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <954cdab4-62d3-b413-f615-9c7b1563c1b1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-08-22, 16:01, zhangjianhua (E) wrote:
> 
> 在 2022/8/30 13:29, Viresh Kumar 写道:
> > On 26-08-22, 10:18, Zhang Jianhua wrote:
> > > - Use module_init instead of device_initcall.
> > > - Add a function for module_exit to unregister driver.
> > > 
> > > Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
> > > ---
> > >   drivers/cpufreq/bmips-cpufreq.c | 10 ++++++++--
> > >   1 file changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/bmips-cpufreq.c b/drivers/cpufreq/bmips-cpufreq.c
> > > index f7c23fa468f0..21c0417c95e1 100644
> > > --- a/drivers/cpufreq/bmips-cpufreq.c
> > > +++ b/drivers/cpufreq/bmips-cpufreq.c
> > > @@ -156,7 +156,7 @@ static struct cpufreq_driver bmips_cpufreq_driver = {
> > >   	.name		= BMIPS_CPUFREQ_PREFIX,
> > >   };
> > > -static int __init bmips_cpufreq_probe(void)
> > > +static int __init bmips_cpufreq_driver_init(void)
> > >   {
> > >   	struct cpufreq_compat *cc;
> > >   	struct device_node *np;
> > > @@ -176,7 +176,13 @@ static int __init bmips_cpufreq_probe(void)
> > >   	return cpufreq_register_driver(&bmips_cpufreq_driver);
> > >   }
> > > -device_initcall(bmips_cpufreq_probe);
> > > +module_init(bmips_cpufreq_driver_init);
> > > +
> > > +static void __exit bmips_cpufreq_driver_exit(void)
> > > +{
> > > +	cpufreq_unregister_driver(&bmips_cpufreq_driver);
> > > +}
> > > +module_exit(bmips_cpufreq_driver_exit)
> > Semicolon ? Did you even compile this ? :)
> 
> Semicolon is not necessary for module_exit, and it can be compiled. I will send v2 patch to keep the format consistent, thanks.

Ahh, because module exit is defined as:

#define module_exit(x)	__exitcall(x);

Yeah, please send V2 with a semicolon in place.

-- 
viresh

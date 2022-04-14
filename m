Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D595019F0
	for <lists+linux-pm@lfdr.de>; Thu, 14 Apr 2022 19:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbiDNRXF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Apr 2022 13:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiDNRW3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Apr 2022 13:22:29 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502A73CFFD
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2022 10:20:03 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q12so5292848pgj.13
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2022 10:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=FfSoG7Td6Wp+hFUw88AieR0tVnt6wZxfF+2zMZy9eaA=;
        b=u1dsiSU8Oc8b8MGmKSXynmmw14Fwb78ccQEfVYdGz2ligTny5q/N6pnA6Ebe28h6Qg
         9rGnEHQNiSaC61xxeIRqzttu6T5MKhxMX6EGXNDv0bHalHqIas60PEfUt06tX9DHEfOH
         V0wRk2ynFkERT2/lHsbehTn5wPHw1thtrieHyN90V8JxpzH5OVYM+zdlH3OWT9Wt27nt
         ptAEJxf0UJYKz8qackmb4vXAapzFRg+BMddZw6pyUOxEtELf4A72XfikvVE1zRTnlRkr
         LfIPUAVJId1kbo7Nrwzic79JTC5bcC8GIxFkxARqw/kkK3YY7mPDEw5RhVBo5f0LH3IC
         zGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FfSoG7Td6Wp+hFUw88AieR0tVnt6wZxfF+2zMZy9eaA=;
        b=j25xESpZ9MT4iCNwTj3YT5smMZgTwq7bIKreCGbM1pst4HjArKFXUD+EftP8XxAZN2
         IbBYBs5s/XyjV5wmB0FumY/p1E2hvzGuBV2TjfvXYzVjdvDiJIfbRiDa5DE8YYrstyd5
         meonI/vYtfOU8BhjqmCJ98VXOMoC9BntAE2ZmvzTzmQpy3sjvHxLCvmcq9MUX+J5kKpy
         le5Pk2qpKR7hrWjjj6gUTNaJuz1oJNQgm+0zZzOtgfbJSnUtwmFK/yVs70nheXou27dX
         FczkSROdiqgLzom2oW7yD1TnNw8a/4VbDneHht9w4BPZh8Jg7UeM7S6bdD/hcvmnSCDX
         CqTw==
X-Gm-Message-State: AOAM531lc5vRn/UCROvDCLOn+lHAvw1ObxjsTXi1K+zjAxKVqP1FxhQ4
        d7NlXxsvvovapRXIBfz5dJoQhg==
X-Google-Smtp-Source: ABdhPJw/SW4QlRCUT88YW6sv8vX3wad3KLpdA5XMS4E4+CURIKOHEWUI9+4tm4ZEYV/Gaq5GfqQoiA==
X-Received: by 2002:a65:5ac2:0:b0:399:dea:cd1f with SMTP id d2-20020a655ac2000000b003990deacd1fmr3117689pgt.80.1649956802674;
        Thu, 14 Apr 2022 10:20:02 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id p8-20020aa78608000000b005082c3cbfd2sm421053pfn.218.2022.04.14.10.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 10:20:02 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH V2 10/15] cpufreq: mediatek: Make sram regulator optional
In-Reply-To: <be86691b529dd691203fbb5b35f8572e7e9119a8.camel@mediatek.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-11-rex-bc.chen@mediatek.com>
 <7ho81b5n9v.fsf@baylibre.com>
 <be86691b529dd691203fbb5b35f8572e7e9119a8.camel@mediatek.com>
Date:   Thu, 14 Apr 2022 10:20:01 -0700
Message-ID: <7hfsmf37lq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rex-BC Chen <rex-bc.chen@mediatek.com> writes:

> On Fri, 2022-04-08 at 13:32 -0700, Kevin Hilman wrote:
>> Rex-BC Chen <rex-bc.chen@mediatek.com> writes:
>> 
>> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
>> > 
>> > For some MediaTek SoCs, like MT8186, it's possible that the sram
>> > regulator
>> > is shared between CPU and CCI.
>> > 
>> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
>> 
>> nit: missing your sign-off.
>> 
>> > ---
>> >  drivers/cpufreq/mediatek-cpufreq.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/drivers/cpufreq/mediatek-cpufreq.c
>> > b/drivers/cpufreq/mediatek-cpufreq.c
>> > index 9e9bce0ff235..8f688d47e64b 100644
>> > --- a/drivers/cpufreq/mediatek-cpufreq.c
>> > +++ b/drivers/cpufreq/mediatek-cpufreq.c
>> > @@ -435,7 +435,7 @@ static int mtk_cpu_dvfs_info_init(struct
>> > mtk_cpu_dvfs_info *info, int cpu)
>> >  	}
>> >  
>> >  	/* Both presence and absence of sram regulator are valid cases.
>> > */
>> > -	info->sram_reg = regulator_get_exclusive(cpu_dev, "sram");
>> > +	info->sram_reg = regulator_get_optional(cpu_dev, "sram");
>> 
>> The changelog says that this regulator may be shared with CCI, so I
>> understand it's no longer exclusive.  But here you make it optional,
>> which should be explained in the changelog.  If it's not actually
>> optional, then it should just be normal "get".
>> 
>> Kevin
>
> Hello Kevin,
>
> Since cpufreq and cci devfreq might share the same sram regulator in
> MediaTek SoC, it is no longer exclusive as you mentioned.
>
> The reason to use regulator_get_optional is we hope regulator framework
> can return error for error handling rather than a dummy handler from
> regulator_get api.
>
> I will add this to commit message in next version.

OK, sounds good.

Thanks,

Kevin

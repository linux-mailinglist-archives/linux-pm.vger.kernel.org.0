Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3925B4FB25C
	for <lists+linux-pm@lfdr.de>; Mon, 11 Apr 2022 05:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiDKDbk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Apr 2022 23:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241820AbiDKDbh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Apr 2022 23:31:37 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4884432EE5
        for <linux-pm@vger.kernel.org>; Sun, 10 Apr 2022 20:29:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n18so12747065plg.5
        for <linux-pm@vger.kernel.org>; Sun, 10 Apr 2022 20:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=glLri0Q5hoPnF9CltB+t3SBRTbSb2KsDjT5cGpcgnl4=;
        b=Lor8cKaxWULoOS+gC8IfE1E+zWobSXFdYdQ9MXCEDM5Br0l/Tc33DpFnB6jfVj9xyD
         RUrlBC9h+YNKwOeF4Bx2uUT3fsAHfeYHJlYDwZWkPQscuKVkwGUionPVKQp3py42IdhN
         sXRAd2yNMYUk+s7wECCWeXGm9ITePH7DEKtMqoIUdqiK1T3VpVkmLMtlSWTT/lr9567F
         b/SXpYq2KVpDDRTy+d6vpGkwepq/NWVmIgGMoQPOEAqw31oMVfCjq5rIzRfaevRaxCKB
         eV037276lxgv3hAQPHBHDPjExa/mKjVtAc4voYESLlWIS9ldT4c6DkVHoQ3Y75V7d87W
         Z95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=glLri0Q5hoPnF9CltB+t3SBRTbSb2KsDjT5cGpcgnl4=;
        b=mkmQ/vCSbE7rHfJmgSx87M1f57RYua6WOJo+Ll0mt0lBVHlE+G/m4k6O7XDhsafCNj
         OR5d337RboKPSKHSmGCHshAzsGDmTgctTyoA+uaWkwX4qhWq8MJm8as58F4FTRjR3++y
         vcl0ENtzFluRFhwYm9nantbbjR0dgPjMCf8m9IcNtD7bzJsGqnGYlcv6lba4qT6R+L7o
         PmVHMClbq3hfStqrVXHWNGyzxyLGm2FwhDWSaNf/TorQljpYWRcnw8IqxhHF7vbQvp5P
         hW/hjBWJStRob+a0ffNebV1JGzWe91a1jBoPHkeEUKJADrhmT2ieNDKLpAn5JCLqBTXb
         aouQ==
X-Gm-Message-State: AOAM532Mu80d5b35pk3gWiuRtKEoBjurQO5zc5SSXcMl14LdzFyJrNRE
        SfHPEeQsS/JE+CgTT1hkdHoKgw==
X-Google-Smtp-Source: ABdhPJzTnmE6XXA7umU2v3xHJBcEhDF7Ru93TRyQrYWdHHOoifJtCYP/hQCVMVgRLXA7Zb4apPNhYw==
X-Received: by 2002:a17:90a:8405:b0:1bc:d521:b2c9 with SMTP id j5-20020a17090a840500b001bcd521b2c9mr34455774pjn.119.1649647764750;
        Sun, 10 Apr 2022 20:29:24 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id s3-20020a056a00194300b004f6664d26eesm35381725pfk.88.2022.04.10.20.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 20:29:24 -0700 (PDT)
Date:   Mon, 11 Apr 2022 08:59:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     rafael@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH V2 15/15] cpufreq: mediatek: Use device print to show logs
Message-ID: <20220411032922.yj4p42is5ky6bgau@vireshk-i7>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-16-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408045908.21671-16-rex-bc.chen@mediatek.com>
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

On 08-04-22, 12:59, Rex-BC Chen wrote:
> Replace pr_* with dev_* to show logs.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 41 +++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 18 deletions(-)

One should always arrange the patches in this form:

- Fix bugs first (since they need to be applied first and need to go
  to stable kernels too).

- Trivial fixes next, like this one which you chose to be present at
  15/15. I would have applied this one right away, if it wasn't he
  last one, because of which we have conflicts now.

- Non-trivial patches later, so reviews on them don't affect other
  patches.

-- 
viresh

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226F05132CE
	for <lists+linux-pm@lfdr.de>; Thu, 28 Apr 2022 13:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345682AbiD1Lv5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Apr 2022 07:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbiD1Lvy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2022 07:51:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B204468989
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 04:48:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so4186955pjf.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 04:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lKWQTGV4dh9PrDo1ht1APvD79N4/klGUKA1N6RBf/GQ=;
        b=G3X+tE3No3MGFynBoTKdGdMfqY90HrjssPASkzvSVM3xa3pYXi6L5rl4CkSVGOR+z+
         ro3lt+PwqdLf+fM7ZKxmcThJNKbQML0/enxTqS50zC4K2hTQcvOt5pxHARNiLVnp9go6
         bL9CKShiWf9WpdXYz4FEgwYeQuM3jLB5igxWwvUMTRop1jMp7JKES0USBPgplpvHCD5B
         WKJZlv0BZVL/6km57R0RivFmVwL+azaU9mWB+VXd92FVWxDUu4qoQzjXk+Kn6xj2ujXS
         fktKKtimTGWrvth41l0ji77mmg+KgJDLWuaxWxQGc1mNEKUqApeJtr8jCBy1bqKY6L1k
         Injw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lKWQTGV4dh9PrDo1ht1APvD79N4/klGUKA1N6RBf/GQ=;
        b=AOUqclvD66VJDFNORG1AZxgkOuxdV9Y7QvRAZ1daBeG09tRqlYgH50ho8kCLD+i+ta
         UcWQUix5wU9WjyDywLcrx1Gh2j6yjJIDNC+Uh4IcrDMtwIRw9cdiAvxxpddsyS70V/Io
         78Q1hicPceyplrk+lU0Ukf8nEoZcB1So8/yMOYANaGLuPQKQbwyCmIHbM9hMgibKDH8I
         /wOyACGXHiPBvcFAoqMRvLrv/VwqlgFYQDDyd6pox0jzkGDgjuAtvrm8xvg3iArm3VIX
         pUcWvAT5uLgfo4dWXOWXw+41rJCD6kNggIlPr93AfDGT+K8BRtFTr21v9p23HAzWlSO8
         P+2Q==
X-Gm-Message-State: AOAM531uilOD/6EyAmYu0USbfSnDjlxJAbxM6LyjU5Y7LiMoJznlNli1
        41Q7VRNHj+QcJREhCZqeor0froKkNgIGNw==
X-Google-Smtp-Source: ABdhPJwfNlUrhObS4CNeZo5g5yFfXpFAPhyzjjlLtni25rafO48eOSIBrFIVd2rGxVJZL+uDhGhNbQ==
X-Received: by 2002:a17:90b:3442:b0:1d9:8af8:2913 with SMTP id lj2-20020a17090b344200b001d98af82913mr20231216pjb.199.1651146518157;
        Thu, 28 Apr 2022 04:48:38 -0700 (PDT)
Received: from localhost ([122.162.207.161])
        by smtp.gmail.com with ESMTPSA id k21-20020a63d855000000b003c14af5063fsm2654765pgj.87.2022.04.28.04.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 04:48:37 -0700 (PDT)
Date:   Thu, 28 Apr 2022 17:18:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     rafael@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH V4 07/14] cpufreq: mediatek: Add .get function
Message-ID: <20220428114835.3ktimyz2tzzqdcbg@vireshk-i7>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
 <20220422075239.16437-8-rex-bc.chen@mediatek.com>
 <20220425053548.72w2jh2g6lpzgz6g@vireshk-i7>
 <64c690e8edf493ec0a4a14e0fdaad2d8e88e6da7.camel@mediatek.com>
 <20220425100058.4kbvmpi63ygni6k5@vireshk-i7>
 <078b1f9b39690da98cbd3c4528ba28374a097083.camel@mediatek.com>
 <20220427031141.or2owu5wrh2cadfo@vireshk-i7>
 <346736a339bed576817179ded3795d61f71fa06a.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <346736a339bed576817179ded3795d61f71fa06a.camel@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-04-22, 19:16, Rex-BC Chen wrote:
> Yes, the call stack will eventually go to __cpufreq_driver_target.
> However, we can observe the mismatch between target_freq and policy-cur 
> with a tiny difference.
> e.g.
> [ 553.065356] cpufreq: target for CPU 0: 500000 kHz, relation 0,
> requested 500000 kHz
> [ 553.066366] cpufreq: target_freq/policy->cur: 500000/499999 kHz

So you are trying to set the frequency to 500 MHz now, but policy->cur says it
is 499 MHz.

> We check the assignment of policy->cur could be either from
> cpufreq_driver->get_intermediate or from cpufreq_driver->get.

policy->cur is set only at two places, in your case:
- CPUFREQ_POSTCHANGE
- cpufreq_online()

From what I understand, it is possible that cpufreq_online() is setting your
frequency to 499999 (once at boot), but as soon as a frequency change has
happened after that, policy->cur should be set to 500 MHz and you should see
this problem only once.

From CPUFREQ_POSTCHANGE notifier, we always set policy->cur from the table
itself, which should be 500000 MHz.

I wonder how you see policy->cur to be 499999 here. Does this happen only once ?
Or repeatedly ?

> But it is strange to have the frequency value like 499999 kHz.
> Is the result of tiny frequency difference expected from your point of
> view?

Clock driver can give this value, that is fine.

> > What do you mean by "voltage pulse" here? What actually happens which
> > you want to avoid.
> > 
> 
> When cpufreq is fixed to lowest opp, "voltage pulse" is a quick voltage
> rising and falling phenomenon which can be observed if 'cpufreq_get' is
> invoked.

Do check if the call is reaching your driver's ->target_index(), it should be
which it should not, ideally.

> Thank you for sharing the correct information.
> Is it possible to get frequency (API) a simple way, like get current
> opp frequency?

Lets dig/debug a bit further and fix this if a real problem exists.

-- 
viresh

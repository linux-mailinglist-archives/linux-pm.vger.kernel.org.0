Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23504FE795
	for <lists+linux-pm@lfdr.de>; Tue, 12 Apr 2022 20:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354335AbiDLSGq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Apr 2022 14:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351377AbiDLSGp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2022 14:06:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68881401F
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 11:04:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id md4so10923531pjb.4
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 11:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Uk7HGQjUL7qBYUmyOj8OBJBQSHFN+LzVXSnG4qGNbTE=;
        b=jFr35tndWJ0nAVVDICGQAaEYIMMXzjz9fKlaFJ8w7nhIihwifPjt1rLJuHO7qRsPaG
         MLEJvbPP7Tuvgl3zCD1VuFPVfFJPnGpG4ktjUjMmoagMYYki7X+05OLs08wQKbsf1RfQ
         zcCaIw/M8l9yCTPfehnrhArzHLMVr6AsJBsc5J5JKXOgWCj46cAd8dr3CBlBwYdlyOtG
         4E1MGgUHyxL+p3looTbwHcp9rCRYQ7OXCe3PDq32Ud6WVK6P7ewbp3QcDDbr0QVw0Bmz
         G1X2C7h2FKGUIHUQZweZyh8vcCyJQKnBZUDV5OQlVHgKkmL1LVevEtn64v5xzNys9pLU
         5HOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Uk7HGQjUL7qBYUmyOj8OBJBQSHFN+LzVXSnG4qGNbTE=;
        b=g1mZK0D8Ag5gcPQ8jfH4J17agEb0DAmdptcQpBATSFSB8eV9p5dyn+NVnr/YUpVPb3
         ebArZsjE04LIYBo+kmJFdZK3MeRSp3ss/Ly9ak0nCGro+fF5S8IOm2s5YWvHTnTa7KfH
         A8jBuwJGt4ULsT4z0/Uf+Cad/s+G+qT8YBUt+w+DqjxdJrHuQahA0g5tLNJHA1CnolAz
         8qs8asRpS/6l5giq4cSi8KJRR32pUIL/ZHd6p+TshGksTzbb5GP2QLjMp9FDl8jOySZ0
         CwBZj+7ZUbTLrvpkXAW7IYTPuo0sSfNxx4TdzTkKUXoGD3MRFxWAPMK6cPK94Ri1wbMl
         7yXA==
X-Gm-Message-State: AOAM530+ylti5tN2SClSl8pFbLzP6I/04vpW4a/DXm/m4Q0u/g6KPmT3
        /+rQdSJsjkusUPy/qfIT+MTcQw==
X-Google-Smtp-Source: ABdhPJw18lgMRgcMa0PPrG0eQ4wWbvTFhILQ4ylHJMGkTSBxH4VIo/Y9Yzc7COxYGeKXAg/XXfScbw==
X-Received: by 2002:a17:90b:380e:b0:1c7:74f6:ae60 with SMTP id mq14-20020a17090b380e00b001c774f6ae60mr6198048pjb.5.1649786665161;
        Tue, 12 Apr 2022 11:04:25 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a0026ca00b004fb266fb186sm40276496pfw.73.2022.04.12.11.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:04:24 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH V2 07/15] cpufreq: mediatek: Add opp notification for
 SVS support
In-Reply-To: <dfe2d3e3401a6f2a7be9db4e8a0590d3dd9a6969.camel@mediatek.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-8-rex-bc.chen@mediatek.com>
 <7hsfqn5nft.fsf@baylibre.com>
 <3b7bf25a3da6c8f780c87784c1f796bf1e464238.camel@mediatek.com>
 <7hzgkr4hmc.fsf@baylibre.com>
 <dfe2d3e3401a6f2a7be9db4e8a0590d3dd9a6969.camel@mediatek.com>
Date:   Tue, 12 Apr 2022 11:04:23 -0700
Message-ID: <7ho81641qw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rex-BC Chen <rex-bc.chen@mediatek.com> writes:

> On Mon, 2022-04-11 at 11:09 -0700, Kevin Hilman wrote:
>> Hi Rex,
>> 
>> Rex-BC Chen <rex-bc.chen@mediatek.com> writes:
>> 
>> > On Fri, 2022-04-08 at 13:29 -0700, Kevin Hilman wrote:
>> > > Rex-BC Chen <rex-bc.chen@mediatek.com> writes:
>> > > 
>> > > > From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
>> > > > 
>> > > > The Smart Voltage Scaling (SVS) is a hardware which calculates
>> > > > suitable
>> > > > SVS bank voltages to OPP voltage table.
>> > > > 
>> > > > When the SVS is enabled, cpufreq should listen to opp
>> > > > notification
>> > > > and do
>> > > > proper actions when receiving events of disable and voltage
>> > > > adjustment.
>> > > 
>> > > So listenting for OPP notifications should be done only when SVS
>> > > is
>> > > enabled...
>> > > 
>> > 
>> > Thanks for your review.
>> > Yes, the OPP notification is only called from MediaTek SVS.
>> > 
>> > > [...]
>> > > 
>> > > >  static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info
>> > > > *info,
>> > > > int cpu)
>> > > >  {
>> > > >  	struct device *cpu_dev;
>> > > > @@ -392,6 +455,17 @@ static int mtk_cpu_dvfs_info_init(struct
>> > > > mtk_cpu_dvfs_info *info, int cpu)
>> > > >  	info->intermediate_voltage =
>> > > > dev_pm_opp_get_voltage(opp);
>> > > >  	dev_pm_opp_put(opp);
>> > > >  
>> > > > +	info->opp_cpu = cpu;
>> > > > +	info->opp_nb.notifier_call = mtk_cpufreq_opp_notifier;
>> > > > +	ret = dev_pm_opp_register_notifier(cpu_dev, &info-
>> > > > >opp_nb);
>> > > 
>> > > ...but here youlisten to OPP notifications
>> > > unconditionally.  Seems
>> > > there
>> > > should be a check whether SVS is enabled before deciding to
>> > > register.
>> > > 
>> > > Kevin
>> > > 
>> > 
>> > Do you think it's ok that we wrap it with the SVS Kconfig define?
>> > like
>> > #ifdef CONFIG_MTK_SVS
>> > mtk_cpufreq_opp_notifier()
>> > ...
>> > dev_pm_opp_register_notifier()
>> > #endif
>> 
>> Generally, we don't like to see #ifdefs in C files[1].
>> 
>> But more importantly, compile-time check is not enough, because SVS
>> feature could be compiled into kernel, but not actually enabled for
>> an
>> SoC (e.g. DT node not enabled, etc.) so checking this at compile time
>> is
>> not enough.
>> 
>> Ideally, the SVSdriver should provide a function that allows others
>> to
>> check if it's enabled.  That function needs to know not only if it's
>> compile in, but if it's enabled/running.  If SVS is not compiled in,
>> then that function just returns false.
>> 
>> Kevin
>> 
>> [1] 
>> https://urldefense.com/v3/__https://www.kernel.org/doc/html/latest/process/4.Coding.html?highlight=ifdef*ifdef-and-preprocessor-use-in-general__;Iw!!CTRNKA9wMg0ARbw!z6SrEcQOLu2u-R1OLedrRUXHYXCzuQoK3F_h9Bhzv8jNFmjV5mdNVy41eND67CuV9uIS$
>> 
>
> Hello Kevin,
>
> After our internal discussion, we think the register of notifier should
> not be bound for certain module.
> If we provide the moethod to adjust voltage/disable opp, we think if
> anyone call dev_pm_opp_adjust_voltage and dev_pm_opp_disable, it could
> be used.

I don't think I understand what you mean.

Do you mean that this OPP notifier could be registered all the time,
even if SVS is not enabled?

That's fine with me.  If SVS is not compiled or enabled, then the
notifiers will never be called, so that's fine.

> May I ask what is your concern?

My concern was primarily that the changelog description did not match
the code.  The changelog says "when SVS is enabled, CPUfreq should
listen to OPP notifications."

But if I understand you correctly above, I think what you mean is that
CPUfreq should always listen to OPP notifications because there are
other users (e.g. SVS) that could change the OPP outside of this driver.

If that's what you mean, then I think the only thing to change is the
wording of the changelog.

Thanks,

Kevin




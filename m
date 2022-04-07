Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0454F896F
	for <lists+linux-pm@lfdr.de>; Fri,  8 Apr 2022 00:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiDGVyg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Apr 2022 17:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiDGVy3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2022 17:54:29 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341C015F56C
        for <linux-pm@vger.kernel.org>; Thu,  7 Apr 2022 14:52:28 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so10146022pjn.3
        for <linux-pm@vger.kernel.org>; Thu, 07 Apr 2022 14:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kWoriqwvAgVuYSUhi7L0THxaE1ScXOQjq9TtzmQJVbU=;
        b=wYFesMUu/TR7A1YIrKfA2suAnhXO78hgQGiRsHo5iwIpfybC070hYksXyX4E7VsFFT
         s9Qg9O+NMguOp45rOJecrJpR665oBHSU6Y7o+w0iAip97QIiQW7Dv9HA4ABVwnyeRitB
         6IsfCfqOtS+z03LEx5B8HemaKMbw6eUbv+sImkmlydGGFVFvmbM67wJr3Bdi9Y6hYmfJ
         U/2ZhiSQRp07tfntX35mJNDTVCM6p3Trdw36gEpPB/gXPenaHlfwjzK3H6RQR9riQ5Tx
         k6pYZ4FkTIWX9ATMwgH6G1Za4Kz465KYZ68UGCgrPymoOWkp40b12SCUcq6Wn7wFzHC5
         AIlg==
X-Gm-Message-State: AOAM532WdrIZpUgh5Op5MAlGNccaEfNL14HN2TTi/rak7UudSFlJUoKj
        DSpMcXS4vjj5Z7vleMB5FGarag==
X-Google-Smtp-Source: ABdhPJx68cwpLQxSWHj/EY+iJVPBQu4+0qXEpeG0cd544c0QToBKKCAVi2UNtKrdsFxQvAYU4s2rRA==
X-Received: by 2002:a17:903:40c3:b0:156:ffaf:5d9e with SMTP id t3-20020a17090340c300b00156ffaf5d9emr6465312pld.134.1649368347628;
        Thu, 07 Apr 2022 14:52:27 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id y75-20020a62644e000000b005056a2a260bsm2765812pfb.129.2022.04.07.14.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 14:52:26 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Hsin-Yi Wang <hsinyi@google.com>,
        Tim Chang <jia-wei.chang@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        roger.lu@mediatek.com, Allen-yy.Lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
Subject: Re: [PATCH 2/3] devfreq: mediatek: add mt8183 cci devfreq driver
In-Reply-To: <CACb=7PUSAF6ui2a7iMYrrXo=v0OaXhCfiF=dPzq4cfUXM3JbDg@mail.gmail.com>
References: <20220307122513.11822-1-jia-wei.chang@mediatek.com>
 <20220307122513.11822-3-jia-wei.chang@mediatek.com>
 <CACb=7PUSAF6ui2a7iMYrrXo=v0OaXhCfiF=dPzq4cfUXM3JbDg@mail.gmail.com>
Date:   Thu, 07 Apr 2022 14:52:25 -0700
Message-ID: <7h7d808sti.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hsin-Yi Wang <hsinyi@google.com> writes:

> On Mon, Mar 7, 2022 at 8:32 PM Tim Chang <jia-wei.chang@mediatek.com> wrote:
>>
>> This adds a devfreq driver for the Cache Coherent Interconnect (CCI) of
>> the Mediatek MT8183.
>>
>> On mt8183 the cci is supplied by the same regulator as the little cores.
>> The driver is notified when the regulator voltage changes (driven by
>> cpufreq) and adjusts the cci frequency to the maximum possible value.
>>
>> Add need_voltage_tracking variable to platforma data. if true, it
>> indicates soc is required to realize the voltage tracking between
>> voltage of sram and voltage of cci by software approach. otherwise, the
>> voltage tracking is realized by hardware appraoch.
>>
>> Add the notifier to cci so that it could react after svs driver changes
>> opp table of cci.
>>
>> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>

[...]

>> +
>> +       passive_data = devm_kzalloc(cci_dev, sizeof(struct devfreq_passive_data), GFP_KERNEL);
>> +       if (!passive_data) {
>> +               ret = -ENOMEM;
>> +               goto out_remove_opp_table;
>> +       }
>> +
>> +       passive_data->parent_type = CPUFREQ_PARENT_DEV;
>
> It's better to add a note below commit message to state that this
> series depends on
> https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing

Not only is this series dependent the previous series from Chanwoo, in
also fails to compile if CONFIG_DEVFREQ_GOV_PASSIVE is not enabled,
because CPUFREQ_PARENT_DEV defined inside of an #ifdef.

Please compile test this with and without CONFIG_DEVFREQ_GOV_PASSIVE
enabled.

Kevin

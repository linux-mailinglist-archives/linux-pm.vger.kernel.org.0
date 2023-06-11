Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382F072BB62
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 10:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjFLIzo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 04:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbjFLIyp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 04:54:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72741711;
        Mon, 12 Jun 2023 01:53:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30aebe2602fso2590363f8f.3;
        Mon, 12 Jun 2023 01:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686559984; x=1689151984;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aS9YsrNAcOn+NlKyUNyoFu7MvoAIEEYn2rw1UEKfcUg=;
        b=dKjArm/xhT6edX4xaOmPXGu4g5jfK0NVxHxgtp+8qwLi0r4ZwcbMwnJElg3YMxWjb/
         4+Oo39SV8Xi8f7hS7tg1LODUTpZh+vLmgw7LUO+F+TtVu/hnh00brmd65WQ2gticoWrM
         NjZeguUUaYjBPL2jeUr9NsoIdQjNeBxXLkmrP0fU0ZdXUrqQUnlTwUJiMrgkze4sMdKr
         F6lq7e+ZDFTiF4VFIvY74ZsZJeXsD82yiB7NzRi5sUUDQbENL7Gt54O0XwzqGhxVSm5c
         JBK8lA/0ptgWGnh9JGGd9fYjTr6DCyG3uLGMa1Dk7jOSFoayjDNCdSZsetYddiWV264F
         j7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686559984; x=1689151984;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aS9YsrNAcOn+NlKyUNyoFu7MvoAIEEYn2rw1UEKfcUg=;
        b=jWEKw1XfJsHbhhdGr5ntczAwdbIntG9lnQFEaG4Un7iw1OBMhP0gaKPcy9JgvrG1dY
         C0qFaKmmtmteIQ6e8oRoMJU9MGX8z06YvEX06rdmy6YOk+ypVrRl9tpMnNqu+TvSrx2V
         Jom+eryflvm8MwCxJ8QJtzKD6MF4yi1jnNNxm7phIlorehndTqRADxmzELawIbUgUT5Y
         iX0vgcHsaFjesHqoFoc+nKeKYwXpICPGxobaB414QUGpmyZT64men52oSassAp/CF/vl
         3BEJz8LW0yN23GjPKTLBDU+LJ6PZfptLYS/HeC2ee5QwGY0rBG0j9GQPT54GVFu8SSS7
         tokg==
X-Gm-Message-State: AC+VfDxN3kEQc8SKNqrTCqvPWrpfzc4WOAxYgK/ux9rUdTIC8mwoZ9p+
        p67aLk9Pzi0XQcibZw/2lZ8=
X-Google-Smtp-Source: ACHHUZ6OCXAHFB7ym2sqsJaX2aXW1mpqMoedSF5d27PM8ZVqy+wqMdokykjds2qq2trJkyITWxNVrw==
X-Received: by 2002:adf:f10c:0:b0:30f:bb83:e6f6 with SMTP id r12-20020adff10c000000b0030fbb83e6f6mr2965454wro.0.1686559983908;
        Mon, 12 Jun 2023 01:53:03 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000050300b003068f5cca8csm11758463wrf.94.2023.06.12.01.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 01:53:03 -0700 (PDT)
Message-ID: <6486dcef.050a0220.4c054.4c59@mx.google.com>
X-Google-Original-Message-ID: <ZIX12RbMtonZb+yM@Ansuel-xps.>
Date:   Sun, 11 Jun 2023 18:27:05 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 00/18] ARM: qcom: apq8064: support CPU frequency scaling
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 12, 2023 at 08:39:04AM +0300, Dmitry Baryshkov wrote:
> Implement CPUFreq support for one of the oldest supported Qualcomm
> platforms, APQ8064. Each core has independent power and frequency
> control. Additionally the L2 cache is scaled to follow the CPU
> frequencies (failure to do so results in strange semi-random crashes).

Hi, can we talk, maybe in private about this interconnect-cpu thing?

I see you follow the original implementation of the msm_bus where in
practice with the use of the kbps the correct clock and voltage was set.
(and this was also used to set the fabric clock from nominal to fast)

On ipq806x and I assume other SoC there isn't always a 1:1 map of CPU
freq and L2 freq. For example on ipq8064 we have max CPU freq of 1.4GHz
and L2 freq of 1.2GHz, on ipq8065 we have CPU 1.7GHz and L2 of 1.4GHz.
(and even that is curious since I used the debug regs and the cxo
crystal to measure the clock by hardware (yes i ported the very ancient
clk-debug to modern kernel and it works and discovered all sort of
things) the L2 (I assume due to climitation of the hfpll) actually can't
never reach that frequency (1.4GHz in reality results to something like
1.2GHz from what I notice a stable clock is there only with frequency of
max 1GHz))

So my idea was to introduce a simple devfreq driver and use the PASSIVE
governor where it was added the possibility to link to a CPU frequency
and with interpolation select the L2 frequency (and voltage)

From some old comments in ancient qsdk code it was pointed out that due
to a hw limitation the secondary cpu can't stay at a high clock if L2
was at the idle clock. (no idea if this is specific to IPQ806x) So this
might be a cause of your crash? (I also have random crash with L2
scaling and we are planning to just force the L2 at max frequency)

But sorry for all of this (maybe) useless info. I checked the other
patch and I didn't understand how the different L2 frequency are
declared and even the voltage. Is this something that will come later?
I'm very interested in this implementation.

> 
> Core voltage is controlled through the SAW2 devices, one for each core.
> The L2 has two regulators, vdd-mem and vdd-dig.
> 
> Depenency: [1] for interconnect-clk implementation
> 
> https://lore.kernel.org/linux-arm-msm/20230512001334.2983048-3-dmitry.baryshkov@linaro.org/
> 

-- 
	Ansuel

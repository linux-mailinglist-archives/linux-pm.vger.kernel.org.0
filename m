Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BB94C1140
	for <lists+linux-pm@lfdr.de>; Wed, 23 Feb 2022 12:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239856AbiBWL2C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Feb 2022 06:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbiBWL15 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Feb 2022 06:27:57 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD1B3C71F
        for <linux-pm@vger.kernel.org>; Wed, 23 Feb 2022 03:27:30 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 195so19629976pgc.6
        for <linux-pm@vger.kernel.org>; Wed, 23 Feb 2022 03:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SHFYegUo03DjCxdS0Gu5tYZKm6OzwquBbzLjVdntcXk=;
        b=i5LJtE7uwG6kpWKGBodkWlbpgX52o368X518RNlIpeyHlkCkynvrx1At+yOSAeufGu
         djbOWwiuFNCqUPu/DzSMpmlkx3ahZk1v84UBd4Xpd9cfrlPJLpLJDx+B1WjFmoQc28t3
         TTMnPkEhHpMiyFNjcb2iSxpfx257y/sytifC29WTguckha8pyjJm18ehKx0R1YyyjO8K
         b2YuU3eUXamZQWnFmCxK7SYxKY1yskcxVmj2+CtUrTMy44XpEVJD4rgLHZY8rwSEcrLV
         sfT/UqzKJg6JzPZe6LX0fqYWwGwPoSReLugxvjlq0J1DsLdh5D/7cFO8tN1kXglJCVAE
         OPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SHFYegUo03DjCxdS0Gu5tYZKm6OzwquBbzLjVdntcXk=;
        b=dFZHIFZJXRn7S7pg7Be6PEj8Br5rpYijYtY4LQlhYVjVQ9ul0RGUDDgvNQ6oub3K1U
         HhDBIGMLZTTM4ZbWOm69EbR4C0uAoJKy5yT8pooS6o00tSGgrpwTCV7iod6Oo8CiVOw0
         JnpNJC+Xhqk7u0Lv7wBT/RkLaUMP4LHAdg2YXwJLxX0qMM3BvJEJRRq6VeHQhtGFYdex
         RiQMi3VQbvNEkVQhQzeYvu1uSp5Hi3KS6Pqcr9rOSErkd6KElW6sbPTqOcDo9cQdaP20
         bmqEDtKcOunxP2JvBKoRNJwQwMdfGvF6qnvCImndIhS7XRZFSr+2qVmaddHSJaxH4mbq
         vpXw==
X-Gm-Message-State: AOAM532lq3ljs6ds0yCVBA7y5ZmUFQdFmIGEkSuuPdIwKAp4kWBJsC5W
        BEzcTK+J7xQ4YM7Z4TbjYtxhjw==
X-Google-Smtp-Source: ABdhPJw3BRAmUjieArpqYJc7cltWKssHfIhl6hTr4Mo8DxuN4xlikUgPz9OL2RIHSoi4ljl0vP/BOw==
X-Received: by 2002:a63:6c43:0:b0:373:7202:6e13 with SMTP id h64-20020a636c43000000b0037372026e13mr23738814pgc.110.1645615649506;
        Wed, 23 Feb 2022 03:27:29 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id j4sm14582389pfj.218.2022.02.23.03.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 03:27:29 -0800 (PST)
Date:   Wed, 23 Feb 2022 16:57:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, nm@ti.com, sboyd@kernel.org, mka@chromium.org,
        dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Introduce 'advanced' Energy Model in DT
Message-ID: <20220223112727.akprxqglyr7ostqh@vireshk-i7>
References: <20220222140746.12293-1-lukasz.luba@arm.com>
 <467a7de4-df84-8e9e-a26a-80449ca55950@linaro.org>
 <20220223104341.jh5hjcv6ugaexgoa@vireshk-i7>
 <94d3f2a3-4145-afdc-d810-61f2120df579@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94d3f2a3-4145-afdc-d810-61f2120df579@arm.com>
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

On 23-02-22, 11:22, Lukasz Luba wrote:
> On 2/23/22 10:43, Viresh Kumar wrote:
> > On 23-02-22, 10:52, Daniel Lezcano wrote:
> > > why not extend the energy model to any kind of devices?
> > 
> > FWIW, the OPP core supports a wide range of devices now, not just CPUs.

There are many other devices which still use Freq.

> Is that the "opp-level" thing which would allow that?

For power supplies/regulators, we don't have freq and they use level, right.

Also for interconnect we use bandwidth, in a similar way.

> I can see some DT files with regulators(?) using it e.g. [1].
> It looks flexible, the opp-hz is not hard requirement,
> the opp-level can be used instead IIUC.

Right.

> It might be a next step which might meet Daniel's needs.
> If that 'level' can be any number and frequency is not available
> then EM must have 'level' filed in the struct em_perf_state
> for this kind of new devices. I'm open for such change.
> We can discuss this as a next step. We would need to find some examples
> how this new thing would be used.
> 
> [1] https://elixir.bootlin.com/linux/v5.17-rc5/source/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi#L4

-- 
viresh

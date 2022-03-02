Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7644C9CC5
	for <lists+linux-pm@lfdr.de>; Wed,  2 Mar 2022 05:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbiCBEy1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Mar 2022 23:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiCBEy1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2022 23:54:27 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41E9B0EA4
        for <linux-pm@vger.kernel.org>; Tue,  1 Mar 2022 20:53:44 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id em10-20020a17090b014a00b001bc3071f921so3745384pjb.5
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2022 20:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Art1lpH3Xd1yIuokeU2fg9jz+WGOi3eEm+HrCqgLuUs=;
        b=v9OjizihOkXYFafRbxPwD5euHZ49r6cYW6YeAVXYBBR0WsJLx2cemhILv/lR2XLHDT
         VCRP03fRU+lJTvpV5Y/1KwNqQ6AmKXILl4ialZWSy9Ot4g4DlytKSDrgVqqmdGDR/TBn
         +DpsyoGW7mHhwmS2lA3uL3jrRkanBe4MVVNjwUoXhGRUVEOg76NcF9zUojPbJySLPwwj
         EDVJ7qlJ43sSUJWZX2zJKptvmuUskT2339JBUD04JCtZ5rJ3K+goKuLvE53aJHPQvbu1
         VW/oxKDUNGdv/rE8xyeI5lsC7D/+8IPSvQlSjaUTFHA3tI8aJiPJGsbxhrW2vfrWDPZP
         sHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Art1lpH3Xd1yIuokeU2fg9jz+WGOi3eEm+HrCqgLuUs=;
        b=i+FdJYh2QEX9ziGufxn25r0XFpY8HoEvjPEFrftTjUdVSoP+U7sU84MWO96v/d/0Hy
         wSl6h3xC3eKwiEYbXCOoH/76a/hK4mPbrUk5C+lrN4BP3dn/gk+K7UBAxef9Nk+cq6Jf
         PKYRlVy3mZg1F9W/1SrFay21N+bNyBEys/+sCdo6vFPhLlEIzk/3y/8zl5Uf8QiS0hVm
         fjRmW5VNmU3tVf0bFXdj0h+SU5AbCP/TjhUPfqvYRRoX2dvXp85VSE4daxpMaHm6s2YE
         ecEgC9q392vnlKjprjPIISRcVMSHQvcNc/Jcke9asRiXRlAKZ22IuDuN5y3GyAi7d1Fq
         ug7g==
X-Gm-Message-State: AOAM530EPzJ5woSWB76Nfxl6RTwZ/8u5JZf7uSFoNS+YxPgdx+mf6hSR
        98v+7DBO/cbpez9AS6H4goK3oR3Yp7e3jQ==
X-Google-Smtp-Source: ABdhPJzZLkCxbC3sCJSa2mvfxwNZuETEYREDcexC4q3Kztp8279zUxrtwps7oNwm0eyCnNJXcYn7Pw==
X-Received: by 2002:a17:902:e884:b0:151:89d6:fa78 with SMTP id w4-20020a170902e88400b0015189d6fa78mr5110397plg.154.1646196824301;
        Tue, 01 Mar 2022 20:53:44 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id g15-20020a056a0023cf00b004e17e11cb17sm19314451pfc.111.2022.03.01.20.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 20:53:43 -0800 (PST)
Date:   Wed, 2 Mar 2022 10:23:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Introduce "opp-microwatt" and Energy Model from DT
Message-ID: <20220302045341.uzdflllpj7d55ekb@vireshk-i7>
References: <20220301093524.8870-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301093524.8870-1-lukasz.luba@arm.com>
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

On 01-03-22, 09:35, Lukasz Luba wrote:
> Hi all,
> 
> This patch set solves a few issues:
> 1. It allows to register EM from DT, when the voltage information is not
>    available. (Some background of the issues present on Chromebook devices
>    can be checked at [1].)
> 2. It allows to register 'advanced' EM from the DT, which is more accurate
>    and reflects total power (dynamic + static).
> 
> Implementation details:
> Existing machinery in the OPP framework now handles "opp-microwatt", similarly
> to "opp-microamp". It also has helper exported function to get power from OPP.
> For the EM, it adds a new callback in OPP framework to use this new API and
> read power while having an opp pointer. It's agreed to work with OPP-v2.
> 
> Comments, suggestions are very welcome.
> 
> changelog:
> v4:
> - changed calculation of power, summing add all supliers power for an opp
> - added opp debugfs for u_watt
> - added patternProperties in dt-bindings for this new opp-microwatt
> - changed the EM opp registration flow and used one EM api registration call
> - changed name of _get_opp_power() to _get_dt_power()
> - removed 'advanced' word from the new paragraph and content in EM doc changes
> v3 [2]

Apart from one minor things, the patchset looks fine now. Thanks for
considering the review comments :)

-- 
viresh

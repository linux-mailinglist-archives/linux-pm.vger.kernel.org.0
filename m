Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C8B4CA0CD
	for <lists+linux-pm@lfdr.de>; Wed,  2 Mar 2022 10:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbiCBJbW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Mar 2022 04:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240249AbiCBJbV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2022 04:31:21 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C38B7159
        for <linux-pm@vger.kernel.org>; Wed,  2 Mar 2022 01:30:39 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 12so1184349pgd.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Mar 2022 01:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GJBBkuVoOY0NadmNicSfZEUGciYZ9mVdm2SUcdDUa1o=;
        b=BiwF3Cgiq4NVJYHfcc9TVwFXiK/Plrkz9Icej7HVS5zeBpmXcxn/Y6OtaRy0iWYKKw
         GuT4yZgy1INWhZJwxlOYi4bPJ9B72nL1ga0lPC8lALKz6E63s7JZrhb/SozMC0//IVj7
         Q7c3jR/C3CmwE2Ovn3NV9+ZtGBwe4bt69pfIK3KwECUpDuf+4HS2LrYrpumJqMCinOlw
         5VLGyVpBy8itZ9mUfzjPyYIvDPXUZzi+KjLpnCZ0fb4ON/2zIttKydFKH/VYORW84qM8
         DhqkcPOQL97TuYPRA8kH/fefSoVVY/L5FK5nIDO6fxFoQCaeqbOE5pHTh+2huidDkWf+
         z3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GJBBkuVoOY0NadmNicSfZEUGciYZ9mVdm2SUcdDUa1o=;
        b=XGBVdZ2yM3/xAqzKxTBvP5AdSkUgg/e9gNkBKFx9YZUTEjGPRS6S4in+XvePvow+dh
         jf+bHvxFKU41xo2+MNJQ+C7bzBriOp4EmCGR8MCEMc7RO2frjN0IbHZzlXRjMY9qKVI/
         KHbWxty+yMpT2M5XSiydbW9QHW06PpsmhDy2LPXcF60zBG7Skdx9G/IG/BgANQlGnmiB
         J46uyJHWpTsABW19qr5OAZVJW69RvGzHa2ZD8MvlUngoHCARQOrIg314JnpBdLfv3KwV
         MGt5WNkgYbJEJjk8zNitYK0mRdrmkdWtBFxhSUCrDltieSfakwZWSsfwncNhJRts2CGc
         memQ==
X-Gm-Message-State: AOAM531lGSSJHo7a/uT17HderT/WAB1ykR1dfl3mA+ty6rS06SkQcpEK
        xTTgQ35SCoDPIpnZvGKkQZvCgA==
X-Google-Smtp-Source: ABdhPJzKj3BxnxWBDF7gcRkF9CxOl4nkip25FQ/GRhoYU1H823jjPKs1ppyAbnJL3/5gQrYHU9aP6g==
X-Received: by 2002:a05:6a00:140c:b0:4e1:530c:edc0 with SMTP id l12-20020a056a00140c00b004e1530cedc0mr32224862pfu.18.1646213438591;
        Wed, 02 Mar 2022 01:30:38 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090aa38600b001bce781ce03sm4554983pjp.18.2022.03.02.01.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 01:30:38 -0800 (PST)
Date:   Wed, 2 Mar 2022 15:00:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 3/4] OPP: Add support of "opp-microwatt" for advanced
 EM registration
Message-ID: <20220302093036.qanm3vxuajinzbwb@vireshk-i7>
References: <20220301093524.8870-1-lukasz.luba@arm.com>
 <20220301093524.8870-4-lukasz.luba@arm.com>
 <20220302074515.dqzoutfiobildiph@vireshk-i7>
 <e02d9113-d1ae-c029-750f-aece1cefab2d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e02d9113-d1ae-c029-750f-aece1cefab2d@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-03-22, 08:50, Lukasz Luba wrote:
> If you like, I can introduce new dual-macro implementation
> in energy_modle.h which would sole this issue:
> 
> ifdef EM:
> #define EM_SET_ACTIVE_POWER_CB(em_cb, cb) ((em_cb).active_power = cb)
> 
> ifndef EM:
> #define EM_SET_ACTIVE_POWER_CB(em_cb, cb) do { } while (0)
> 
> 
> Then we would keep the single call to the registration EM and
> we would have:
> 
>         if (_of_has_opp_microwatt_property(dev)) {
>                 EM_SET_ACTIVE_POWER_CB(em_cb, _get_dt_power);
>                 goto register_em;
>         }
> 
> 
> 	
>         EM_SET_ACTIVE_POWER_CB(em_cb, _get_power);
> 
> register_em:
>         ret = em_dev_register_perf_domain(dev, nr_opp, &em_cb, cpus, true);
> 
> 
> I can do that, please let me know.

That will work as well.

-- 
viresh

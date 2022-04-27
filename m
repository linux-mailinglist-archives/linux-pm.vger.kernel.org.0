Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABA8510F32
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 05:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348836AbiD0DOz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 23:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242711AbiD0DOy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 23:14:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463A61208E
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 20:11:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c23so493799plo.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 20:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QeLNBCirVB+9azObthHDc+zDjnH2MBnHQLYuB1xHpSg=;
        b=LauZkNXFuJxaHO6AZzzSQgT1RBnzkVe5AbyhIWjE+cpUPZuWrYw7k821kWGkOnIuE3
         m/JeFVATc5PxS0lQ887DbBw5TVS/eqya/BvOe3aA6XPgTag2bL9kb7jEf/kMG4bgT9+n
         nZ4Pz/7m5DTWrrhU+lVyo01hBxzoezE3kQRPJtik54IIGjq118i9mOUrWBOOqsEzyOMX
         ig2zp9I6b1JafAnW9a+BENcFZ4C2riyTniq/P446KJ60roW7SyNUDvtC1mYPejb7zbKT
         sT6Q5G19soERJMdKju6fH5HpCCcnGBh6ZC1knxH5n9BRqbbiYBU6dJDqTM/+fmMdDQwv
         rovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QeLNBCirVB+9azObthHDc+zDjnH2MBnHQLYuB1xHpSg=;
        b=5H7wvoslaOmRxwSmWCdNzPsvajYLaos7sbmLx4rI6tczW4Gmmc3LGyOQ9Y9bjkwM7E
         AuFeZEVFdb6nwckI7il5dCGzRzt7Wobq6emxbOnEEuJqKsG6l6sG9vraoj5a6qdedQAz
         JzbJ5qCWpBqMqO73h5se9UZj+kulbiUWotTe66vT/zxoLJ3Gwue6ClSOUTSCVnUK8v4J
         +34jhS+BgszoEm7vJZSBaBtUs17LdCe4rLIizdvS7+gM1+AgE2vYM56Aob/tEDGcs0gm
         BlGwT999xtPY1v1P9J5DUtS/idEjpQrVGOLXJZeIDK0VN0cG5finupQXm5s5RIQlzhX6
         SkjA==
X-Gm-Message-State: AOAM532P0C3EUW6ln7ymoi1gLN2KvFFg8SHXRx5qM+vFeM66c5fwdpHL
        P8VzphtKYT6g4osULfCwY+GotA==
X-Google-Smtp-Source: ABdhPJzIzlWaNfocqWrXkXaX43UuhbhI/L6BzhFoDVBeU6ZHYI+09qW0rRQP2y7SIq2VIL6q5Hfmtw==
X-Received: by 2002:a17:90a:3486:b0:1d9:3abd:42ed with SMTP id p6-20020a17090a348600b001d93abd42edmr22017909pjb.32.1651029104494;
        Tue, 26 Apr 2022 20:11:44 -0700 (PDT)
Received: from localhost ([122.177.141.190])
        by smtp.gmail.com with ESMTPSA id u25-20020a62ed19000000b004f140515d56sm16544735pfh.46.2022.04.26.20.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 20:11:43 -0700 (PDT)
Date:   Wed, 27 Apr 2022 08:41:41 +0530
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
Message-ID: <20220427031141.or2owu5wrh2cadfo@vireshk-i7>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
 <20220422075239.16437-8-rex-bc.chen@mediatek.com>
 <20220425053548.72w2jh2g6lpzgz6g@vireshk-i7>
 <64c690e8edf493ec0a4a14e0fdaad2d8e88e6da7.camel@mediatek.com>
 <20220425100058.4kbvmpi63ygni6k5@vireshk-i7>
 <078b1f9b39690da98cbd3c4528ba28374a097083.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <078b1f9b39690da98cbd3c4528ba28374a097083.camel@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-04-22, 19:13, Rex-BC Chen wrote:
> We have a non-upstream driver which tries to get frequency by
> 'cpufreq_get'.

This is the right thing to do there.

> When we use that non-upstream driver, 'cpufreq_verify_current_freq'
> will be further invoked by 'cpufreq_get' and it would cause voltage
> pulse issue as I described previously.

I see this will eventually resolve to __cpufreq_driver_target(), which
should return without any frequency updates.

What do you mean by "voltage pulse" here? What actually happens which
you want to avoid.

> Therefore, we apply the solution in this series.

I won't call it a solution but a Bug as .get() is supposed to read
real freq of the hardware.

> Recently, we found that using 'cpufreq_generic_get' directly in our
> non-upstream driver can do the same thing without pulse issue.

That would be an abuse of the cpufreq_generic_get() API. It is ONLY
allowed to be used while setting .get callback in the driver.

-- 
viresh

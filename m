Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7AD64680D
	for <lists+linux-pm@lfdr.de>; Thu,  8 Dec 2022 04:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiLHD5s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Dec 2022 22:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLHD5r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2022 22:57:47 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB67264D2
        for <linux-pm@vger.kernel.org>; Wed,  7 Dec 2022 19:57:45 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 21so308382pfw.4
        for <linux-pm@vger.kernel.org>; Wed, 07 Dec 2022 19:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fIdeGYn0pUMc9zqzDo6PSNFrxv8rG8wn0R7kkWts/Ik=;
        b=i51TYzZV2mWOb0Qse6S2uQ3yR2h/qhnrGvi0/7ho3AXfvUeirNMruzTELPP8eCdPtV
         +qCnpdo7UiCdXnr4/JViRumlZ4IXZLZ94FCDbpR7Jt/Ol1en/DfIWeP4aU6DkHx+sZLu
         bfPQxegvXj7EsCWi50gg5l3gIGBbNUqU8AQOUhHox/13dzLFpIBv4JZGnJyWEWqd3uTD
         Etq4fSlOlsTpZ9eXwjQ+/wfn4GY40EyHU77b4bMS7lhVJUY3EItsLHEk4veawAR2WjPu
         Rd0Nq8MqF4MdlqDdXgi11Up8cAMBIzwdzlLQagn/kUJFoJo0wTnJxeWzavfbeUFmNii3
         /oiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIdeGYn0pUMc9zqzDo6PSNFrxv8rG8wn0R7kkWts/Ik=;
        b=7tGTvoBV9ygpi2/hY5qNXpdmKeIfQiew0ZyJ3vERi36TuWiBRD8WxoIZXUMVU8K1xa
         +SrhqnJvjggeLEz9E9EgJQ84MRUcZHALstIeFQQStiaVKBotrFHiIOwso0wrzLU4HNWj
         Ww1KiOHQmh9PUFEzmn71u/Y8j9jnT5pcC1qybx9nXz4pdToesHsh+zeg8kC09WBZFcdn
         3mImEBRTcAMOph1PwbPEBVU+gyhKKH3q79bfbmvekOqUai4vDMVB0hHhbuz8L9MMrQZr
         /yphttqStX9QLe/ovOEhYStYL4Nf0yAL0FxdyZFNUmAbuorKXUJenhS3KCWiDHO+Lgqx
         ckIQ==
X-Gm-Message-State: ANoB5pkbmG6ZpOc1YRo1nf0uG5KEJrdaDWrBx6OAT2lOEQVgHYf+nkID
        /70pXYvKm0DkGkSFUvBwfyPJm94834cP3HVW
X-Google-Smtp-Source: AA0mqf6MciT9QGviI6NRSXLScURwvu1yds34CBsXLgxR0yZQUf6l0FR8/qYvfkhJ0MTWjO6czR8XPg==
X-Received: by 2002:a05:6a00:1310:b0:561:a494:b299 with SMTP id j16-20020a056a00131000b00561a494b299mr74155494pfu.34.1670471865240;
        Wed, 07 Dec 2022 19:57:45 -0800 (PST)
Received: from localhost ([122.172.87.149])
        by smtp.gmail.com with ESMTPSA id n12-20020a170903110c00b00186a6b63525sm15440409plh.120.2022.12.07.19.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 19:57:44 -0800 (PST)
Date:   Thu, 8 Dec 2022 09:27:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, saravanak@google.com,
        wusamuel@google.com, isaacmanjarres@google.com,
        kernel-team@android.com, juri.lelli@redhat.com,
        peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de
Subject: Re: [PATCH v2 1/2] cpufreq: schedutil: Introduce single max CPU
 capacity for freqency domain
Message-ID: <20221208035738.rscvrsatcchwiawq@vireshk-i7>
References: <20221207101705.9460-1-lukasz.luba@arm.com>
 <20221207101705.9460-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207101705.9460-2-lukasz.luba@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-12-22, 10:17, Lukasz Luba wrote:
> Prepare the code for optimizations and move the max CPU capacity
> into the sugov_policy struct. This will allow to leverage the fact that
> the max CPU capacity is the same for all CPUs in the frequency domain.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

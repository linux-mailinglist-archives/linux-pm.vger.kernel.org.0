Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E105950F134
	for <lists+linux-pm@lfdr.de>; Tue, 26 Apr 2022 08:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245433AbiDZGmF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 02:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiDZGmA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 02:42:00 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96671AF3E
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 23:38:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e24so521555pjt.2
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 23:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6pV6AUjp2V1UC4cOoLtl5XlEXuEwCEfH5h8T/x9bk1s=;
        b=Hmq+v0Iu9XUEYI+1g/J9Ol51Ng1sNDpr9SRXE0a6waomwbD4nITRtU1TL2MQeNMjBR
         uCPbmlFUp8wLu327lk1gbpkTH5/aBUUMRSIWRYfgbmFwhdMBYP/kxqBRsYdJmgfWqcaP
         FeH38Tfr10wIkoay+CkyGAHTGYyTEykVIUf+pmAn36fed5XzOD/nWBN4EQOilIQl6ClE
         MbIeVR7Lz6VvVwzRNX5d5KdS7xWchAx2kOVATgQTkGDlehTPiNoDx3YaFWlcfdSUCTZu
         qQ9YxtvkOKA2CNcvuARwJ8VZp5ljq+XililkDbnPHrCCZhZ35q2sszDuNULxC5aHF7f1
         1t7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6pV6AUjp2V1UC4cOoLtl5XlEXuEwCEfH5h8T/x9bk1s=;
        b=69o5uQ1EvrbtZZ9/2MSOvobU9u8kv5ucXWvkHfokot6FtG3pqqxb3ddvUefTGm82un
         9XuHfIusa/7yhKwquhdOrOTa5V0k99jkD9TRO3KDWiD3Cs1Sc6hDg3CkvRc6377/rXoY
         uiNdtKQFPnMcwQKCpCI+9rISkPKsBCInD5wun9Tf4Dmt+tz+tSXFX7wk8mgMRnzUauhJ
         Z6DQKL57huM4dfCGFn0TI/q+3tlC6h2kYzrXZvy8rfUcZhMMHSCKI4tUw+4Scl4jeXeA
         V7DIVsl419EJfgeX3pa/5yvAJwBafIfiaaI0wlJy7vR7Fl8e3o/f9U53i1cXT9Tk4TUs
         gDOw==
X-Gm-Message-State: AOAM533IRZyZRKkQyvoyIGtj0gopc5dblB9cat23YyBat0WuD2cQwvoF
        nWopB1eWyHQ8iI6uVXvg6leeuA==
X-Google-Smtp-Source: ABdhPJzrYFXkv18FmVHTmLX062X8RhEqAtjZP26tpHCie3BswX1/uq501vZuyAz3S/LIowMNf08Raw==
X-Received: by 2002:a17:90b:605:b0:1d9:b208:7507 with SMTP id gb5-20020a17090b060500b001d9b2087507mr1431242pjb.125.1650955133468;
        Mon, 25 Apr 2022 23:38:53 -0700 (PDT)
Received: from localhost ([122.177.141.190])
        by smtp.gmail.com with ESMTPSA id d16-20020a056a00245000b004f771b48736sm14770838pfj.194.2022.04.25.23.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 23:38:52 -0700 (PDT)
Date:   Tue, 26 Apr 2022 12:08:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: qcom-cpufreq-hw: Clear dcvs interrupts
Message-ID: <20220426063851.u65lyudtatnaribr@vireshk-i7>
References: <20220407200919.3054189-1-vladimir.zapolskiy@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407200919.3054189-1-vladimir.zapolskiy@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-04-22, 23:09, Vladimir Zapolskiy wrote:
> It's noted that dcvs interrupts are not self-clearing, thus an interrupt
> handler runs constantly, which leads to a severe regression in runtime.
> To fix the problem an explicit write to clear interrupt register is
> required, note that on OSM platforms the register may not be present.
> 
> Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

Applied. Thanks.

-- 
viresh

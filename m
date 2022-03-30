Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B674ECB7A
	for <lists+linux-pm@lfdr.de>; Wed, 30 Mar 2022 20:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349849AbiC3SN4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Mar 2022 14:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349861AbiC3SNy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2022 14:13:54 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B703F898
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2022 11:12:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id u26so25379249eda.12
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2022 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7EeHvbWk//qAFbeA6A5Z8GvHq/HktOwS8ahcApKNqcE=;
        b=SesD38yYKpqPNksIzQ8aZoV15Upa3FHXViA/NI7jvTW+rkEQtWH8Z3N0Pou1LmTWMU
         nxlFXncclEX4cUFu+7vp5s7R1aJicX03Jzc53nwUnyIlTZ5Ra5vyCVARZDXgJO7y13CO
         5I80HLWC0ozhk4+wT2Za1SQWmMrY6zfskmvbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7EeHvbWk//qAFbeA6A5Z8GvHq/HktOwS8ahcApKNqcE=;
        b=KIPbAyuYAQ8gh7YRExgTuwzMGmPix85q9g1RMg/VwvVa6eZzisRHjHguTSgyRAuCtV
         +v0lYBYy/kK/2YISY10N+xEB1jLgda4nYM1zzj6U7bre2B8VFcKM0jflndLia5VKYdN3
         WQlHf6jxOkuWkTl7O5+2ENWlTeApWf7KIkMLl/C0Z87HRUPxOART/BlWnXz/hXZm1lyB
         sRjToGjufy2wrqKoHUasGK03H8stdferhWYM0X47anwn9yLbvNH93/43s4qqa9hYOSXr
         r+SiK6/VEO99CC4uDts85dKPE4ymvfe8tJ2uXcDV9z+koWcuc2ErYEbjYaR6YE9KyP33
         +dtA==
X-Gm-Message-State: AOAM533j8Xr8TRkjD0U2wo6LGRlx/4Kyhb9l/Z8fc6RClmvSLiCvId6b
        xFn+N7zy/jGjJs2WMYGSEwvPqQ==
X-Google-Smtp-Source: ABdhPJw2lHDcULcX0Y44ZQPyalM8UaR0/qMr3M2rNaqPICn61olCaEuZxQ9/+ZpEl3lSdfrWAQwspQ==
X-Received: by 2002:a05:6402:2142:b0:413:6531:bd9e with SMTP id bq2-20020a056402214200b004136531bd9emr12398254edb.5.1648663920818;
        Wed, 30 Mar 2022 11:12:00 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:c1bb])
        by smtp.gmail.com with ESMTPSA id h30-20020a056402095e00b00412b81dd96esm9912801edz.29.2022.03.30.11.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 11:12:00 -0700 (PDT)
Date:   Wed, 30 Mar 2022 19:11:59 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: Thermal notifications without setting thermal governor to
 userspace?
Message-ID: <YkSdbwVTFZGu6X/1@chrisdown.name>
References: <YkR6/KnH/f9U+2qf@chrisdown.name>
 <f48f8bcc-0d1c-0a36-0e50-2e6b17a645a2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f48f8bcc-0d1c-0a36-0e50-2e6b17a645a2@linaro.org>
User-Agent: Mutt/2.2.2 (aa28abe8) (2022-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

Daniel Lezcano writes:
>I'll answer to your email but meanwhile this can have some interest for you:
>
>
>https://lore.kernel.org/all/20220330100444.3846661-1-daniel.lezcano@linaro.org/

Thanks! Glad to see that it's making progress.

I'll wait for your reply on the e-mail overall then :-)

Thanks,

Chris

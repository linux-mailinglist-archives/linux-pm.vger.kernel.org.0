Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DED4F181C
	for <lists+linux-pm@lfdr.de>; Mon,  4 Apr 2022 17:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352482AbiDDPTG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Apr 2022 11:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359409AbiDDPTF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2022 11:19:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBF528E34
        for <linux-pm@vger.kernel.org>; Mon,  4 Apr 2022 08:17:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k23so2449336wrd.8
        for <linux-pm@vger.kernel.org>; Mon, 04 Apr 2022 08:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=b7ChT65i4gfSCcnFk9aDuZ6e2KPwh8t9VhJlJc/QWaA=;
        b=TG5SILvJHyXcUIPe/gwH7o2nBcmVkdnfnqA36DXF4bnPHyVQp4gZXkXjM/p0c6/f2z
         7cWGoLT0NEERZIf0bKMy+1Ku6Gs00Suo2HzUHGrB9h8DL3Cz4vb9BEsAirbHFVYnOGSi
         V6JQZ+Ne/eNx4TaWJJOYH0PHSWQvaac9sOngY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=b7ChT65i4gfSCcnFk9aDuZ6e2KPwh8t9VhJlJc/QWaA=;
        b=CHIQfc6G+pUwv0ldGqjEYB1+2QAEPIwm5O+Y1ShjMpnnoN9eGES8VrW4cdnU4afhnd
         OrsCMSQKHuxNwqZ7t18a5Lg5w+IQfElre1GP7VwK2hNLMv5z4c7DnjVQ7TRlbuo3nH7u
         r8bSv1NSBlDSeUTil8XUi/ykqT8kpjKO1psTc+gohsRxlBuxFI91rjz6H8b3y1mWRkY1
         ljL6vwu6H4Su5E15ex5G0zmGH0R70PECSTV/+vrWXSlIn+EeVxamIjiSXXQueYZNNp0y
         im+F2+i3xzv9iz/wN10MQOE3ijY19zYxOZXUMoSZxvnC1/Y9s5IMFtDiO45RJTBovN8w
         7wGQ==
X-Gm-Message-State: AOAM533lovgce4f+fLw2nT58Vz0ldmbzwMZVdSYvkeYXQJfPLlNKRXyO
        XcoLKldsaD99c2f1ufmWDQP1LA==
X-Google-Smtp-Source: ABdhPJwr/YeRHQxnWj/lgz5qSlwUax/Ei60CfNy2RK6WxJD55ianFx2iA63Qjou20himxKxGHdLkJg==
X-Received: by 2002:a5d:6c67:0:b0:204:ff0:87a8 with SMTP id r7-20020a5d6c67000000b002040ff087a8mr127181wrz.627.1649085426989;
        Mon, 04 Apr 2022 08:17:06 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::4:521a])
        by smtp.gmail.com with ESMTPSA id 2-20020a1c1902000000b00380d3873d6asm9813971wmz.43.2022.04.04.08.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 08:17:06 -0700 (PDT)
Date:   Mon, 4 Apr 2022 16:17:05 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: Thermal notifications without setting thermal governor to
 userspace?
Message-ID: <YksL8a+cINo7K/xX@chrisdown.name>
References: <YkR6/KnH/f9U+2qf@chrisdown.name>
 <faf9e24f-4419-cdbb-573f-4cf2d9e506e2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <faf9e24f-4419-cdbb-573f-4cf2d9e506e2@linaro.org>
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

Hey Daniel,

Thanks a lot for getting back!

Daniel Lezcano writes:
>For that it would require to setup a trip point from the firmware 
>dedicated to userspace management along with the writable trip point 
>kernel config option.
>
>On embedded systems, the trip point can be added easily in the device tree.
>
>You would end up with:
>
> - one passive trip point : writable and used by userspace
>
> - one passive trip point to protect the system tied with a cooling 
>device and handled by the kernel
>
> - one hot trip point to notify the userspace critical is about to be reach
>
> - one critical trip point to reboot the system
>
>From the userspace, you change the trip temp to 50°C, 70°C and 90°C 
>when crossing the way up or the way down.
>
>The sensor should implement the set_trip in order to program the 
>register to fire the interrupt at the specified temperature. 
>Otherwise, monitoring will be needed.
>
>On ACPI, except hacking the table and reload from the kernel I don't 
>see how to do that.

In my case I'm dealing with "normal" desktop machines and a distribution 
kernel, so it isn't possible to have fine grained control over the kernel 
configuration or device tree (especially since ideally this would be 
usable as an unprivileged user).

Is it still possible to use this in such a scenario?

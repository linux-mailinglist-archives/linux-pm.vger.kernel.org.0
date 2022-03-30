Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0244EC8B0
	for <lists+linux-pm@lfdr.de>; Wed, 30 Mar 2022 17:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347415AbiC3Pqt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Mar 2022 11:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345538AbiC3Pqs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2022 11:46:48 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C13D3CFDC
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2022 08:45:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lr4so33923523ejb.11
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2022 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ldsl3d/m65WqjxPhfzfiRyXz5uTXf2P6C5lw5IWz+2c=;
        b=SHBefDbuCenbZPAn7PSuQqxLAo8DscyjaiwclCBVX+0uhNfsBYFP66V9GnI3HhLnrN
         Y+nqow/PDOSGbPlG3pAE/X9TUKv8EnOr8CBbUZYJaCaNeI4J/2G3NzGcj3puKXxWAQGZ
         UTQiUdK48Sn68PLOTQBeR8HRArkEq3vA4aYxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ldsl3d/m65WqjxPhfzfiRyXz5uTXf2P6C5lw5IWz+2c=;
        b=qSv044cpsldMhB5WduEj9+qxLLaDixNs4BdKzjsZJ1CzSXQ8g+s16j+gDKNzbrh7PD
         mK1TKu4arvwYa+l1JdmMZwHtRKnjBtIyJs7q1e0V2PDeH8VNX5IeTCdppaNhonju4IBQ
         Tf3Xs4KdezT66kkO0SovzBhWDO9rVn+u5cfebVo17ipssKxZxQ1v6UybaU/F0tREQWq/
         YjE2+p+xLW1yaHownbtlkcnWcsGke4WmtKpz82msGN2vghw74KpLRsOIVI5ZbD5SCnJU
         SoGqb6heSGr8hn4sHvd2H5tweW69F8YpNZnG1GMlBMMtGdSb7AmwcLVo2ar/FG1/cXwL
         BjTg==
X-Gm-Message-State: AOAM5301JqR5iGmxpflZ0ZghnRgv7gvh7CsWerDMjfOqqQAShfePYY1F
        kipUOPghNi0LOqLaFO8IiZbuAYMWmqaJZA==
X-Google-Smtp-Source: ABdhPJyd5sovDcZEVzukj0VS5orHwE7ckwNXSD0E77jc44TfajsUyUMXbqAp0r9V1ZdEAly9MinKcg==
X-Received: by 2002:a17:906:794f:b0:6e1:2c94:160f with SMTP id l15-20020a170906794f00b006e12c94160fmr78598ejo.635.1648655101588;
        Wed, 30 Mar 2022 08:45:01 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:c1bb])
        by smtp.gmail.com with ESMTPSA id a4-20020a170906274400b006da9456e802sm8393435ejd.102.2022.03.30.08.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 08:45:01 -0700 (PDT)
Date:   Wed, 30 Mar 2022 16:45:00 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Thermal notifications without setting thermal governor to userspace?
Message-ID: <YkR6/KnH/f9U+2qf@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
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

Hey thermal folks,

I'm hoping that you'll be able to provide some guidance on what options are 
available for getting thermal notifications without changing the policy to 
userspace control.

To be clear, my intent is to have a userspace daemon which can set multiple 
temperature trips at runtime on which it can receive a notification (preferably 
by a simple mechanism like uevents), and to be able to distinguish which 
threshold was tripped. For example, to be able to set trips at 50C, 70C, and 
90C, getting events both when the temperature exceeds that and when it dips 
back under the specified threshold.

Right now I am polling /sys/class/thermal/thermal_zone*/temp but this can be 
expensive, especially for the ACPI thermal zone.

As it is, I see four options:

1. Set thermal_zone to use user_space governor and use uevents

As I understand it, this means that the default critical temperature will no 
longer be respected and user space is now responsible for taking action to 
control thermal events.

If that's correct, then it seems dangerous to set it to user_space for 
userspace applications which only want to monitor their own trip temperatures, 
but not take direct action.

2. Use hwmon thermal events

I see that commit 1597b374af22 ("hwmon: Add notification support") adds 
notification support to hwmon, but as far as I can tell this is based on 
statically defined trip temperatures from ACPI or similar inputs. I see you can 
change it with the thermal.crt boot option, but that's too early for a normal 
userspace daemon to do anything (and it doesn't allow any dynamic 
reconfiguration).

3. Use thermal over netlink

I see that commit 1ce50e7d408e ("thermal: core: genetlink support for 
events/cmd/sampling") which was merged a couple of years ago adds support for 
thermal netlink events.

I also see articles suggesting that support for this new netlink interface will 
be or was added to libnl, but I can't seem to find anything about it in the 
libnl sources.

Is this mature enough to use? If so, does one have to hack up their own 
userspace netlink library for now, or what's the plan there?

In general I would prefer something simpler that fits into the existing strong 
tooling around uevents/etc though, this looks useful, but it does a lot more 
than I need and requires adding another userspace dependency on libnl.

4. Poll /sys/class/thermal/thermal_zone*/temp or hwmon

This is what I'm currently doing. It's slow, and often unnecessarily costly on 
weaker systems.

Are there other options I'm not considering here that might help me out here?

Thanks,

Chris

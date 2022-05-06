Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7671251CFF7
	for <lists+linux-pm@lfdr.de>; Fri,  6 May 2022 06:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388852AbiEFEJu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 May 2022 00:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiEFEJu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2022 00:09:50 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0666B4B84F
        for <linux-pm@vger.kernel.org>; Thu,  5 May 2022 21:06:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p6so5729247plr.12
        for <linux-pm@vger.kernel.org>; Thu, 05 May 2022 21:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9xUjY/Sk1s4u2esh57fjrL6TCcB4aUwi+kflp6Fv2t8=;
        b=vZPpQvL1o6mLIpHBQJcuUdaxxwP8V87v52/wrzRkz1TkrAtEJeHmq35SHTv+gTpD4L
         5jEqB6oj8/EjqpJbaGYPu4NNdJ+74CEZF3uY3B/eoItBXf3iVh0vMFSJt0jwtSLKXdgl
         4UX9q4yNJOBJeWC3troOuSVLKDokz5dqpZcltI2rqWktv6pPDY06w8+MfNAxsvwahhtt
         eywjmHiTp8wPX3UELcHUxjhIJ/gvQaMMl9M7gGdScWSCXbuwP+YWAavvZwMJdrxQA9EU
         SeVyi89aAr68/9g9uFXtPXO8xoiiQd6cl9ZVAhf/H+T7xegllLovV6AmICCfqR8szrf9
         +FgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9xUjY/Sk1s4u2esh57fjrL6TCcB4aUwi+kflp6Fv2t8=;
        b=1M9JH3hcI/NNSSlRfswK8xVWXYGQ5iNHNlaEMpTsdT/SbxI/gjBvQ2OmjkzwHJhBHA
         r3ZS8YkQyu9ZCz67/a5Kzwu705htZ339XXwx1QXAPuMOzmgmBMdWXV9g9HV4t+FC00bT
         Rn8RDUuVEQyVwkhBM/hDtq97TUOvcb/lp9oDuqHy28PaWdrXIVBPr6z4IOH1xh3ocBFM
         UNoKuPeuEU/1Q5M9wCzfS6sr/nJiKy69y9eJOD7OIqbYfCxK3c420nngKqelhou5R/hM
         bBnxCCukaSb2hIkgvChGwMVZtlXFnegbOAQO0EtrU5sqM9vOfPFi6kfuhhGam70TbZfQ
         5sow==
X-Gm-Message-State: AOAM532GTpjE5qjydoKa/D9U9PDRlOxd8yjzW7szKRVwFmhQATMfUf/K
        P+8fUWUlhOh0MRP9q/+HefUw0g==
X-Google-Smtp-Source: ABdhPJzZ8j4w4qg6Gct1rEZ8SPcaL3UOakO/Qy/CAepj696EjjU/cEWU79AeqN+ilk56PGwCDQAu6g==
X-Received: by 2002:a17:90a:4417:b0:1ca:a861:3fbf with SMTP id s23-20020a17090a441700b001caa8613fbfmr10164152pjg.80.1651809966534;
        Thu, 05 May 2022 21:06:06 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090a550a00b001d954837197sm6072611pji.22.2022.05.05.21.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 21:06:05 -0700 (PDT)
Date:   Fri, 6 May 2022 09:36:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1] opp: add config option for debug
Message-ID: <20220506040603.xumqemlcrlrolqmw@vireshk-i7>
References: <20220504174823.156709-1-linux@fw-web.de>
 <20220505055857.bqjm72qkzwcbuvuh@vireshk-i7>
 <trinity-6a6249b9-69eb-459c-96f1-dbf8f031a86f-1651766058085@3c-app-gmx-bs47>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-6a6249b9-69eb-459c-96f1-dbf8f031a86f-1651766058085@3c-app-gmx-bs47>
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

On 05-05-22, 17:54, Frank Wunderlich wrote:
> you mean something like this:
> 
> https://www.kernel.org/doc/html/v5.17/admin-guide/dynamic-debug-howto.html#debug-messages-during-boot-process

Yes, though I haven't used it in a long time myself :)

> so enabling debug only with cmdline-param...

Yes and via debugfs file. You can basically control debug messages
based on subsystems, files, functions, etc.

> have you a simple example how to implement it? have not done anything with dynamic-debug yet...seems mighty but not trivial to implement.
> 
> currently dev_dbg() is used for the messages that i try to disable...but show others from driver_debug at debug level.
> 
> What needs to be changed to filter it via DYNAMIC_DEBUG?

Nothing, just enable the config for dynamic debug.

> found this, but i'm not sure if i interpret it the right way...
> 
> https://elixir.bootlin.com/linux/v5.18-rc5/source/drivers/acpi/utils.c#L495
> defines __acpi_handle_debug
> called via acpi_handle_debug macro
> https://elixir.bootlin.com/linux/v5.18-rc5/source/include/linux/acpi.h#L1136
> 
> so basicly convert dev_dbg to __dynamic_pr_debug
> 
> at least much more changed code because all dev_*/pr_* needs to be changed to own handler which does the switch based on CONFIG_DYNAMIC_DEBUG set or not.

You aren't required to change anything there.

-- 
viresh

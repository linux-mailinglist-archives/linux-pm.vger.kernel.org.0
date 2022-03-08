Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5834D0EB2
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 05:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbiCHEez (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 23:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiCHEez (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 23:34:55 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FCF2B249
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 20:33:59 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id t187so11100863pgb.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Mar 2022 20:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1JA5Z/EYU1nbIzaZj57XSliufXfheSF11Z7gEq/7lCI=;
        b=j2WSzDTvmIerAcsI/yVsu7Wfas9RFnCIU/9KDmbDy08KiOarEH/KgF2KZPyl3/0ddp
         ypm9/sfmk1G10uwPbZx0tSMTYP3YkmEvEX1CFq2GKz0yXN/h+Qq9OaHsVCoGhim89utH
         m2dg/JAVZ1aFoLMsMQZeSTd7rVNGHTzNYO0hCo+w8Gu84K62pmZS7DfLRWjByTHN/4Vv
         n2eGq88O7uJvnnj3JuPVEBPJLI01xOD8kHeceyZRsRaE6NhMwtm6BpEBe04OpN0yhQLk
         Vx5oBwKOaHOUoHqlSLbutF1eTaTSmgaKw/FHvjkfojQkL4G0+5ITt02+gwvOBicBcxsf
         CylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1JA5Z/EYU1nbIzaZj57XSliufXfheSF11Z7gEq/7lCI=;
        b=M/q14PPoWR3jty+VZ27S3/CRyiMxUkE94uKZQ8EjLIkJEtbiKgYdXPL/buhhPVtiOP
         Al/5EYhvba3zBnLLWItfIxnsyHEELa+ZAAAmN1Au36fwhrwMO6QSCAZWY6yeAx0eIeFX
         zT+rc4STMkKRv4w+NX4Kbk+Rlb6VFK0Sq1v0EI5Cst/o3gOA+Fe67kQIne4JIAtIA2KN
         tSuTOXQiuVoQegobFeGusTZaOco9WO7KpqhfzaagUZ9Ji+1NLyrDaB7zHBCr/d+yh6v1
         kCUdnsA4IAF0OPv27tMcB91SoqhjJgMz9rcfRldxDk1EPsbIQUIqGVQ6Se7VD+WRoA2/
         ZXpg==
X-Gm-Message-State: AOAM530Yffm49eFaofp+7nRq5gFhZcignR0VfhTcNWjU+x/7O/oZp52x
        eKHb96D15Mp0B6zt1ki4wnjQ1g==
X-Google-Smtp-Source: ABdhPJx4Ktdin/Ue+RHteGOx8uo3FLzM4C8cCEeFh81JobBBBk2MPe/a9UNy13+3ZSdhjFGz8lEZQw==
X-Received: by 2002:a63:5d5b:0:b0:375:983d:7c9d with SMTP id o27-20020a635d5b000000b00375983d7c9dmr12509365pgm.595.1646714039300;
        Mon, 07 Mar 2022 20:33:59 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id m5-20020a056a00080500b004e174acd876sm18438042pfk.216.2022.03.07.20.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 20:33:58 -0800 (PST)
Date:   Tue, 8 Mar 2022 10:03:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] opp: Don't print error message if getting optional
 regulator fails
Message-ID: <20220308043356.cpqtopiyns24auw7@vireshk-i7>
References: <91e37a12-b393-8ae9-996b-6cbb63ea9255@gmail.com>
 <20220307052744.s4ed3vinz5umbtlm@vireshk-i7>
 <39bce0ca-2ff1-399e-d3d4-f424e141a553@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39bce0ca-2ff1-399e-d3d4-f424e141a553@gmail.com>
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

On 07-03-22, 18:18, Heiner Kallweit wrote:
> There are two types of users of dev(m)_pm_opp_set_regulators():
> 1. Caller ignores -ENODEV and goes on.

This is abuse of the API as far as I can tell. If the OPP core was
doing something like this automatically for everyone, then we can
agree that missing regulator isn't necessarily a problem.

But in this case the platforms (lima and panfrost) are asking
explicitly to get the regulators added. To me this is a plain and
simple error.

Take cpufreq-dt for example, it makes sure beforehand if the supply is
available or not, and then only calls this API.

> For type 1 callers a missing regulator should not result in an error message.
> Switching to regulator_get() wouldn't be too nice because then a missing
> regulator would result in the dummy regulator being used. This would create
> a related warning and a functional change that may break something.
> 
> Type 2 callers still have the option to print an own error message in
> case of -ENODEV. AFAICS all of them do so already.

-- 
viresh

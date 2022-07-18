Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB76D577952
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jul 2022 03:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiGRBlg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jul 2022 21:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiGRBlg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jul 2022 21:41:36 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C75813F1A
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 18:41:35 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c3so8491011pfb.13
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 18:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xnIJoYLpIvHvbUckkGET3V4yPviwtzxI5DctiD6Z4a4=;
        b=XFylKDrn1R8VcuymuNfyKg0UF5E3So5WdBdtvlQ4t2k4HBhOFiNoVcZotxhRTtgFk9
         o/aQH5/SSsSAORihP7aE6NFKICOzK7RaJpYUc/M/M1x3sEdaMYuHvF+5SkApOwt3cnv3
         ilICQihm/5EEdC4zjmkcb4TvjZZz/B0CcVWRcJy7h+/s6QW7IH9g9TC3+kO1g4lYOoLu
         4WCTxP+ZEDX6HUUQh2NO/3LG98LRe+nNUoEZ2I2GqNNQ2D/MWpyu7xeWtNBtFRU31Fub
         3LZfacO+JjrNDy+XfjYAAAnk0fQ7ouKziRuarMDJWZWlucwp2yr4a1KVCHrgOKY/gd1l
         OV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xnIJoYLpIvHvbUckkGET3V4yPviwtzxI5DctiD6Z4a4=;
        b=6wuftSMRAHEQrdwTnGJkAcn/9auVqBoeUSu21RtRv48TCJyraJss5RON7vJnglfKUD
         Cqg+WajNBrDasnmUx2TMJ5LGXu8udpQhjUeJTCIfVv1WgoU/8F8KVW+wVj62b3NJPuCG
         wtUY6ONaCEjLkxh30WqFSTMK3M0O2Q9eB4/6iuH5l75cpnPsQJHq9z3X6hYeKYvvTo46
         FsDZN6Iy80URDU182/wnEUJmWYmQX5j8gADhQ/G4rC2t3g8EJ3BaAyWMqUv0cNq1bsMi
         dEL6Jxwu4Oqpj3ItwdqoEqVj2FUsWcJOExKCr+K6qKKAYGguwEwYPybHJM4yfoJfNOCj
         WEfA==
X-Gm-Message-State: AJIora8CM2LtPG1UtCyGP17czkFyWnhSQu51i9IYM8r2JHt21MW6+91G
        tE48ssKbkYakhktvbrGFSvrKfeQnlbb9fg==
X-Google-Smtp-Source: AGRyM1tp8IrllG/N8Nte2ebDf1tVB3pOQ7AC9BkLqXRCI498PMjwkYNolL7U1sU2lOvuB657ZDFGkQ==
X-Received: by 2002:a63:1522:0:b0:412:6c1e:8cf4 with SMTP id v34-20020a631522000000b004126c1e8cf4mr22885592pgl.392.1658108494679;
        Sun, 17 Jul 2022 18:41:34 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id i28-20020a056a00225c00b005289521b656sm8036654pfu.92.2022.07.17.18.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 18:41:34 -0700 (PDT)
Date:   Mon, 18 Jul 2022 07:11:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 5.19-rc7
Message-ID: <20220718014132.uammson5fsnr2ri2@vireshk-i7>
References: <20220715045936.xsrxduwit4beijzi@vireshk-i7>
 <CAJZ5v0ioZCPLXOOFxeNOV_OKHS1fe-foaSkVj+Ta_u+j9mS=YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ioZCPLXOOFxeNOV_OKHS1fe-foaSkVj+Ta_u+j9mS=YQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-07-22, 14:00, Rafael J. Wysocki wrote:
> Pulled and pushed out, but I would appreciate getting pull requests
> somewhat earlier before the -rc I'm supposed to be pushing them for.

Yeah, that's what I try too. But this time the patch itself came in on
July 13th and I sent the pull request on July 15th.

I mentioned -rc7 as that was the next rc in line, but it was actually
fine for this to be applied after rc7 too, before the 5.19 release
though. Should I send the pull request (and tag) without mentioning
the rc number in future ?

-- 
viresh

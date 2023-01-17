Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D6F66E3C1
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jan 2023 17:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjAQQiz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Jan 2023 11:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjAQQis (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jan 2023 11:38:48 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E0D40BD9
        for <linux-pm@vger.kernel.org>; Tue, 17 Jan 2023 08:38:46 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mg12so4354895ejc.5
        for <linux-pm@vger.kernel.org>; Tue, 17 Jan 2023 08:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGt3taqkfQNtUXdS8P0ISc5oukWa5ussrZyaKbMEgG4=;
        b=7AAGdJ2lP3NAfke5Nele3LjbLLc+b2UGABWPVmB5FTyzTVuqDS/a0j8GgPiX70+FbP
         MIubFwAvZh5H5d/35nBl/0hged5mC9QCuBf1C88UlMwg5SGstc+8/F+7Z5hbFtXpnf50
         CpB1r2yE5aFaFgtcfzMWim4iRum8mcw86ufkBjp9HCLyX7uwgfs/RPLQbqTXuRMMZqQq
         JAQkcCtPCxkMQKOwfuIInz99yMLgVjpnAbOQU6Eo9yIYxQQtKpWZVQ9SEzJ/Jn9h8S5y
         TO8nX8Ux6fHWjGckTasVT0jlmG9h+te+T+XQdvkM7FHFkbsng9uwj5yJBWp7MVRVcfdV
         zPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGt3taqkfQNtUXdS8P0ISc5oukWa5ussrZyaKbMEgG4=;
        b=eAytDZDrFT/K1wi33Q+0KEFhzXFhMiNWycU2DEIP3UEihQON1qrF5GopYmqeaVjIKA
         f2UE8dXTAYN9+tIoC1WTJWMXLUYLzI/dOSA9tntN82fvjUc3dGzOLEfQr1+J7aij3TQK
         U2APH67e53SoCt5xn9MVwFWZV6qX/k4Fka3IJTLIjc1mcSEhOtQUK5jJO8XVGfskpL9O
         8j0bIrnbMbuEEU9atCfOa253I810kEheNP8PXeUjvQRr5Db9vIz+SVV2c7OB+G8Fg2iv
         pUPqudXhhEE4FqgulX1gEzFz7tHWxTpUWy8L+8WGGPugSFZEOBm1tZcOo4vzHbszC8Yf
         cMUw==
X-Gm-Message-State: AFqh2kp2FNkoArbCx5WrNCzClK3UNzPadCT5953HkGWKa8Lg5gaKQoCT
        OhqeiS7HjKhIduX8FGQr+P10UQ==
X-Google-Smtp-Source: AMrXdXtnPJbLSz3z6ouhNvSwIea01W/5k3WwvIvgrDwOeoZykQFCWzCe69J1N5rk1OrhUbDofqKkXg==
X-Received: by 2002:a17:906:edc9:b0:870:2f70:c63e with SMTP id sb9-20020a170906edc900b008702f70c63emr3590282ejb.18.1673973524437;
        Tue, 17 Jan 2023 08:38:44 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id f17-20020a170906495100b0086dd8f20a6asm4177738ejt.77.2023.01.17.08.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 08:38:44 -0800 (PST)
Date:   Tue, 17 Jan 2023 16:38:41 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        peterz@infradead.org, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukasz.luba@arm.com, wvw@google.com,
        xuewen.yan94@gmail.com, han.lin@mediatek.com,
        Jonathan.JMChen@mediatek.com
Subject: Re: [PATCH v3] sched/fair: unlink misfit task from cpu overutilized
Message-ID: <20230117163841.d5jv6ysqf5kmvvmh@airbuntu>
References: <20230113134056.257691-1-vincent.guittot@linaro.org>
 <78bf2d91-0076-f748-7c6a-530dad466787@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78bf2d91-0076-f748-7c6a-530dad466787@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/16/23 09:07, Dietmar Eggemann wrote:

[...]

> Not sure if people get what `performance requirements` mean here? I know
> we want to use `performance` rather `bandwidth hint` to describe what
> uclamp is. So shouldn't we use `utilization but also uclamp`?

We do have the uclamp doc now which explains this, no? I'm not keen on
utilization because it's an overloaded term. In the context of uclamp
- utilization _signal_ in the scheduler is used to indicate performance
requirements of a workload, no?

Using 'uclamp hint' if you found it really confusing, is fine by me. But I'd
rather steer away from 'bandwidth' or 'utilization' when describing uclamp and
its intention.

I like using performance requirements because it enforces what this hint
actually means.


Cheers

--
Qais Yousef

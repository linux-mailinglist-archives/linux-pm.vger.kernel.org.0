Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0AE799F4F
	for <lists+linux-pm@lfdr.de>; Sun, 10 Sep 2023 20:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjIJSUb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Sep 2023 14:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjIJSUb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Sep 2023 14:20:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23751A5
        for <linux-pm@vger.kernel.org>; Sun, 10 Sep 2023 11:20:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31768ce2e81so3705399f8f.1
        for <linux-pm@vger.kernel.org>; Sun, 10 Sep 2023 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694370025; x=1694974825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MvwmuK6zDdHxLtx5clgb/iLgnTsb5Ioo/98jIe0vnGA=;
        b=KGHWr6rbu+ye0YoE2kwzD1VRRkkWEcdzuDoMqaOx6R0jjBVYo++MFSLi12QwUjkNJQ
         1yPKQoLm14x8C3SyO4rtKdJVBS7XosiGM0Ope2Z0/ivbNZRS5X1tm+BQTvN9bkWoYtU5
         +Urryfl4v08n1cxQua3UqKJu0iIWMCI47vMY+ZqX1zGxHlQK7kQjpMWGwFVDmRqfpGoX
         mIeUWU9UO6sbQoQ5By+31nlAc/Y8IR+OFENuNthoiZvcUswB1+NuKinsi4HC0O18nCgp
         /Yb8hzRSBglzLJk9Dt8uJsBJqywzlX4XZwsnw08pXhH32iudblp2aRrzW3iDz0xOFbzQ
         NV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694370025; x=1694974825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvwmuK6zDdHxLtx5clgb/iLgnTsb5Ioo/98jIe0vnGA=;
        b=XZPcYA3MC/Cetud1sg27PybbMGYvnTjhPyKcYaAtiYWurS/Xz0q2EKqZswv4tNFhZm
         MzJk8eHGq4elnOOF30qS1BzhC1XY05Gn0a7bdQGf9a4qfekzazgo5Xt0VyOQS15hIdSl
         51EvVfc1ftcOFLZQisViaXuORotI8tpz+nP1aJhaMOy0Q26hBfO064j6PzI6S+654TUh
         8N+xicj2G2AcYaRg/NtCXTZ1Ty8/oaar8fm0IyqvHImrxaGu6m416MmQ19No8IN7w0r7
         ot50ElIW1EIakcWFhwjMaKP3O02I5esmy0bsJRasAfW/XAIsf4e6x5gTtY+y7UxHlRvc
         s/Tw==
X-Gm-Message-State: AOJu0Yx/95YvhhFsO2f5aeVdnAm1Z5HrfpMQHnrGF842HqwDb9tX1eYP
        owkCpf14jsd14XF1zJy/ph+cyfhJUOOwYwuCZZU=
X-Google-Smtp-Source: AGHT+IGzeTX7urFedcuJSmfm2ibmKjyj75DLKVYU44V+a+Vsk9c+iC0EcICiPNkTDKEWD/xg83btSA==
X-Received: by 2002:a5d:4b83:0:b0:313:dee2:e052 with SMTP id b3-20020a5d4b83000000b00313dee2e052mr6387818wrt.26.1694370025136;
        Sun, 10 Sep 2023 11:20:25 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id x14-20020adff0ce000000b00319779ee691sm7767632wro.28.2023.09.10.11.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 11:20:24 -0700 (PDT)
Date:   Sun, 10 Sep 2023 19:20:23 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230910182023.hdrhx6b5bq5r4vfo@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
 <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
 <6011d8bb-9a3b-1435-30b0-d75b39bf5efa@arm.com>
 <20230907115307.GD10955@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230907115307.GD10955@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/07/23 13:53, Peter Zijlstra wrote:
> On Thu, Sep 07, 2023 at 08:48:08AM +0100, Lukasz Luba wrote:
> 
> > > Hehe. That's because they're not really periodic ;-)
> > 
> > They are periodic in a sense, they wake up every 16ms, but sometimes
> > they have more work. It depends what is currently going in the game
> > and/or sometimes the data locality (might not be in cache).
> > 
> > Although, that's for games, other workloads like youtube play or this
> > one 'Yahoo browser' (from your example) are more 'predictable' (after
> > the start up period). And I really like the potential energy saving
> > there :)
> 
> So everything media is fundamentally periodic, you're hard tied to the
> framerate / audio-buffer size etc..
> 
> Also note that the traditional periodic task model from the real-time
> community has the notion of WCET, which completely covers this
> fluctuation in frame-to-frame work, it only considers the absolute worst
> case.
> 
> Now, practically, that stinks, esp. when you care about batteries, but
> it does not mean these tasks are not periodic.

piecewise periodic?

> Many extentions to the periodic task model are possible, including
> things like average runtime with bursts etc.. all have their trade-offs.

The challenge we have is the endless number of workloads we need to cater for..
Or you think one of these models can actually scale to that?


Thanks!

--
Qais Yousef

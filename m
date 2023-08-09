Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1200F776681
	for <lists+linux-pm@lfdr.de>; Wed,  9 Aug 2023 19:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjHIRhU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Aug 2023 13:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjHIRhT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Aug 2023 13:37:19 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B1CE71
        for <linux-pm@vger.kernel.org>; Wed,  9 Aug 2023 10:37:18 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-686fc0d3c92so21487b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Aug 2023 10:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691602638; x=1692207438;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9yArT/awXRkYrPki92Zws/80hTWdY4r8NmlN6iV95PI=;
        b=XNXjfIsXLMPjgKRDaQ0xEgk5QpgFW6+fKyzEjDmW1FsDA8+99NxHlE0jfdTcyiA0ze
         uBqW6FbpKLKa9DkvoK/0dkFuyhYDIgaY+0c46vOPvbDt3xH0sBSOM7+HpNXEDaNnMLHJ
         KvrdjcQzOB0VFGvUyuTkauOlQk9wtkdfylQTnjelnjfgNefPy0bOevZkliR+8q6hqugE
         Dzjb9qJuublADI6x5G7hDF+NDHu0/3JBuuFYx/JPuqPbcCUAMaMpvrUBm3hQHDGb3vVj
         MK8iP1rCPICz0dvt3jXMv/Wq2jQpAuUN3hoh1nE06ZjfAFkOtJaNfofqic52oUJe5Yiz
         aBiA==
X-Gm-Message-State: AOJu0YxVHV4x/5NQgtLsoZTpJOim42tdJuEeGOyMKAZhGwuRBYo9CkB/
        wujJE/TNq8HnP/orrbeGM3SNyg==
X-Google-Smtp-Source: AGHT+IEOe/X404gAnI9Qj8z0UDy2WHWR3jxWz9myYIGG/dCeUzQac/1bjO6kMws5dZZ6Ia4S1Lp7Bw==
X-Received: by 2002:a05:6a20:428a:b0:140:a25:1c1d with SMTP id o10-20020a056a20428a00b001400a251c1dmr3891567pzj.51.1691602638385;
        Wed, 09 Aug 2023 10:37:18 -0700 (PDT)
Received: from localhost ([75.172.135.98])
        by smtp.gmail.com with ESMTPSA id j21-20020a62b615000000b00687375d9135sm10158999pff.4.2023.08.09.10.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 10:37:17 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Dhruva Gole <d-gole@ti.com>, Andrew Davis <afd@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>, Georgi Vlaev <g-vlaev@ti.com>
Subject: Re: [PATCH V6 4/4] firmware: ti_sci: Introduce system suspend
 resume support
In-Reply-To: <20230809072330.GB11676@atomide.com>
References: <20230803064247.503036-1-d-gole@ti.com>
 <20230803064247.503036-5-d-gole@ti.com>
 <3882f0ac-b74c-6eb2-197c-34ca233cd7a3@ti.com>
 <20230803155541.nwsfwobfkbpefoyw@dhruva>
 <8c330bd9-5f4e-8cd0-ed02-c3a696d7473a@ti.com>
 <20230803160815.yfpkdfssv75d4inf@dhruva> <7ho7jifrda.fsf@baylibre.com>
 <20230808115403.dkz6ev5vc6bhcmzh@dhruva> <7httt9dq2x.fsf@baylibre.com>
 <20230809072330.GB11676@atomide.com>
Date:   Wed, 09 Aug 2023 10:37:17 -0700
Message-ID: <7ho7jgdsmq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@kernel.org> [230809 00:20]:
>> To me, it sounds like you might want to use ->resume_early() or maybe
>> ->resume_noirq() in the pinctrl driver for this so that IO isolation can
>> be disabled sooner?
>
> For calls that need to happen just before the SoC is disabled or first
> thing on resume path, cpu_cluster_pm_enter() and cpu_cluster_pm_exit()
> notifiers work nice and allow distributing the code across the related
> SoC specific code and device drivers. See for example the usage in
> drivers/irqchip/irq-gic.c for CPU_CLUSTER_PM_ENTER.

Indeed, this is an option too, but for things that already have "full"
drivers (e.g. not an irqchip), they already have a full range of PM
callbacks, and adding another set of callbacks/notifiers for cpu_pm_* is
a bit clunky IMO.

That being said, for things like this IO isolation stuff that is
system-wide, and needs to happen very late in suspend (and/or very early
in suspend), cpu_pm_ is worth considering if the same cannot be done
with the normal PM callbacks.

Kevin


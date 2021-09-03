Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD75A3FFA16
	for <lists+linux-pm@lfdr.de>; Fri,  3 Sep 2021 08:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242759AbhICGCH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 02:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238297AbhICGCD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Sep 2021 02:02:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D5AC061760;
        Thu,  2 Sep 2021 23:01:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p38so9660910lfa.0;
        Thu, 02 Sep 2021 23:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pgs3kLLPKzcjFcrSbgZkVPLdLHwMQc7gUvwcn4k6Fwk=;
        b=fKqBIrEaXQgsLWgf0iZOXlQ0VJkZkUKWbEEtRyL7rfK9FATg3lmTYsUT3s2cF2NEjb
         Bt7vCRe3CFwn5bTK8AF7jNWT3D/eo2DGNCTnoy5y3l0vTmqhtJYnOcaOBUAefoSo7Nak
         SYYV/DYrCUJ0ukcD2yPs725IGwep8AfidmGJh+wFSTS4VTQ05f7k7ijU0269echC8FaU
         gTo2fQ3ShgW49KnOrWSZH6hL4XKEaPQYfIGw534uRwBTiJKN9N55eOZHNZ+SRoxV/fi7
         5nb6hGxaqqJJcPgnZPlCZZtQFdyLhWJkEgrDI2BMULg4ZbEqzCVFK3bCKBsoOHLZKTYe
         BI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pgs3kLLPKzcjFcrSbgZkVPLdLHwMQc7gUvwcn4k6Fwk=;
        b=oGxci/E6m3GgtdPqfN5ary+Ztyghtlmk9/SQVhAH2R5J8wjfruLwPkTXBff0eygPfw
         yIjEo0AoKvFHt++7rXJvb1Nxi/EiNKwxZXD8f6fHI1gAkV9xXIR+AHt8FxlehOeDxCAD
         EaFxeqBri8/Uwt/p8B6j1N76oSg0Ac0JVkhbuzJeMb9pMjY2AkX9M/et/5T6aHkb0xJj
         /k3vUz7FCdd48Nv0H6a990EBqt4a17onJl9x33wOot6Ho318QP9nLiK6x8BBBD6iwPtP
         494r5q5+Iy2r3htHKA443n4UCnh0YDxNHZ97gAwpr423YlxpYfYzVhsO+yqbnzZWArM+
         Fs9w==
X-Gm-Message-State: AOAM532HIsNME9keoANrXA6xltMyG3NoQMr1zxaGI/xfc+HwAFokSPhY
        2ofMWH0fcIljJLBZQxE/t0HnDZ/fDoM=
X-Google-Smtp-Source: ABdhPJxN+4FC6fCSw3slkr+iUqZZHmtD/YEMsm+izm8dyAttXrN/XDOUHbpAJwY1Y1aOh1ewHzNvbg==
X-Received: by 2002:a05:6512:3503:: with SMTP id h3mr1462072lfs.564.1630648861576;
        Thu, 02 Sep 2021 23:01:01 -0700 (PDT)
Received: from [192.168.2.145] (46-138-26-37.dynamic.spd-mgts.ru. [46.138.26.37])
        by smtp.googlemail.com with ESMTPSA id w3sm473175ljm.13.2021.09.02.23.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 23:01:01 -0700 (PDT)
Subject: Re: [PATCH 1/3] PM: domains: Drop the performance state vote for a
 device at detach
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-2-ulf.hansson@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <08335cd4-7dc8-3b8b-d63f-374585ffa373@gmail.com>
Date:   Fri, 3 Sep 2021 09:01:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210902101634.827187-2-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.09.2021 13:16, Ulf Hansson пишет:
> When a device is detached from its genpd, genpd loses track of the device,
> including its performance state vote that may have been requested for it.
> 
> Rather than relying on the consumer driver to drop the performance state
> vote for its device, let's do it internally in genpd when the device is
> getting detached. In this way, we makes sure that the aggregation of the
> votes in genpd becomes correct.

This is a dangerous behaviour in a case where performance state
represents voltage. If hardware is kept active on detachment, say it's
always-on, then it may be a disaster to drop the voltage for the active
hardware.

It's safe to drop performance state only if you assume that there is a
firmware behind kernel which has its own layer of performance management
and it will prevent the disaster by saying 'nope, I'm not doing this'.

The performance state should be persistent for a device and it should be
controlled in a conjunction with runtime PM. If platform wants to drop
performance state to zero on detachment, then this behaviour should be
specific to that platform.

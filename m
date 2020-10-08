Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B393286C56
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 03:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgJHBIL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 21:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgJHBIL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2020 21:08:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B233CC0613D2
        for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2020 18:08:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g12so4469043wrp.10
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2020 18:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xm6G93I/kiU5WNNhxogPGvPfXFNKFqMEdWdZrehhfck=;
        b=Uxk7VSF7MRI3ohv3f/EHZ3mQLG47yd8Z0crJy3aFn/hLYKDRrLXjo1dZgvsxh6a46h
         q6qniej7L3XwNymck+dPi0/HnV24/jxAGPa7cyNN4h+5lr8xWgsR41iLqBNIKhoLcA2z
         FOIqvGZOm2fqF3kgpmZtT3D3dY6jReaCeKpDrrnzrnMKJQ8WNm3TgUoMHq5G2nsMscKU
         o7OISh48Uog8wcHOghHkz+NBm3uAqo+MeyP9LL8iH7ou+U9PdEk3bObfXhnDrD5Ye+iD
         ZQezZIy8cXcv+xLmdKlKyF4Cq0qgOCmAjQSRkYyxx14Xd8rQC0Apjqlp92PF13ltjHES
         mE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xm6G93I/kiU5WNNhxogPGvPfXFNKFqMEdWdZrehhfck=;
        b=PQDK8YX9NI9/pORWV96LGmG+YbnYPHMAG7uWBBhlKKYoa7vW8hTx0myJ+x9VLQPaWL
         heRSWkq7nyqtJrjhSkr1q8v0uEjWCHD4++Vc4bEVGwQtqEq9v8I/6LBqc209iwoi87vy
         y4f59C8ldf34qZ93rPvLH+jjblWSJXuVT0vvEqdjc9Lyj/cFzBQApDe+DqAmhodYhJHp
         9oL7uZ7B16zD+9aAM7QbA+J694FkywcXv3lgJjkxxgnBYeF/jAr1nRO2rRcNmJw1BJHt
         VWXSxjy3SBaPAGfaU7oPmDZQj/A/HyVIHiHbJS2wTo/CTtGb8u2BGytBw/UDXmgZBYWA
         SP2Q==
X-Gm-Message-State: AOAM530eYDHohjBf6+0h3Q2jvDdWpc6oWCbhW+kL4pRjxcOHGiCZj0CC
        ddS7x29994KEXUf6bZbB49TipA==
X-Google-Smtp-Source: ABdhPJwi5G/ckrzPjYQ/bmCk4CS0dLMl2/fwN5uXLfxMESusYJvQR9WLt94VXE1CJ47+cQ38kpGNYQ==
X-Received: by 2002:a5d:5748:: with SMTP id q8mr6279945wrw.299.1602119289296;
        Wed, 07 Oct 2020 18:08:09 -0700 (PDT)
Received: from [192.168.1.9] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id x6sm4728126wmb.17.2020.10.07.18.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 18:08:08 -0700 (PDT)
Subject: Re: [PATCH] PM: runtime: Use pmruntime sync variant to put suppliers
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20201007001934.18606-1-stanimir.varbanov@linaro.org>
 <CAJZ5v0hxdxV6pB5q94qCEmeDXOMJQzL3b8ZokgTn00i0MbykvQ@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <e24794e5-419c-ad5f-c281-12a6e15cfa4c@linaro.org>
Date:   Thu, 8 Oct 2020 04:08:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hxdxV6pB5q94qCEmeDXOMJQzL3b8ZokgTn00i0MbykvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 10/7/20 5:37 PM, Rafael J. Wysocki wrote:
> On Wed, Oct 7, 2020 at 2:20 AM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>>
>> Calling pm_runtime_put_sync over a device with suppliers with device
>> link flags PM_RUNTIME | RPM_ACTIVE it is observed that the supplier
>> is not put (turned off) at the end, but instead put asynchronously.
> 
> Yes, that's by design.
> 
>> In some case This could lead to issues for the callers which expects
>> that the pmruntime sync variants should also put the suppliers
>> synchronously.
> 
> Why would anyone expect that to happen?

It is logical to me that when I call pm_runtime_put_sync the device and
its suppliers are put synchronously. If I want to put device and its
suppliers asynchronously I'd use pm_runtime_put. Is that wrong assumption?

> 
>> Also the opposite rpm_get_suppliers is already using pmruntime _sync
>> variant of the API.
> 
> Yes, it does, because that is necessary.
> 
>> Correct this by changing pmruntime_put to pmruntime_put_sync in
>> rpm_put_suppliers.
> 
> It is not a correction, but a change in behavior without good enough
> rationale, as it stands.

In my driver case I want to deal with a recovery of a crash in remote
processor (the remote processor is used to control and program hardware
blocks and also to communicate with host processor through shared
memory). To restart the remote processor I have to disable clocks and
turn off few power domains (one of the power domains is made a supplier
of my main device) in order to complete the cold-boot.

The problem I'm facing with this design is that when I call
runtime_put_sync (to disable device's clocks and turn off power domain)
the clocks are disabled (part of pmruntime_suspend callback) but the
pmdomain (the device supplier) is not turned synchronously. I workaround
this by checking the supplier device via pm_runtime_active() until it
becomes inactive and the continue with rest of the steps.

From my point of view this check for supplier activity should be part of
pmruntime API.

> 
> Thanks!
> 

-- 
regards,
Stan

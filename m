Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B696B524ACF
	for <lists+linux-pm@lfdr.de>; Thu, 12 May 2022 12:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352766AbiELKwv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 May 2022 06:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348325AbiELKwu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2022 06:52:50 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEDB43ED6
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 03:52:49 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id bg25so2784318wmb.4
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 03:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bhLFZhLOR9onxP484HtUMsK0gwVtyvrIXG0q9mh+mB8=;
        b=oQh7bAgWJKuPkOFCZlwH/GCKyuTYyJBoNv0Z/xBneQ/z5viblDRKuSwn1nCSZnqf1v
         i7ZMJ0bTEu3+l4mcrcU88szFyOS7bLCn4ZVnbSq/g2csHU0nVdNAj85USOj6sw8kqy/r
         wxUPxfYPOpAqoQ4n/Itk5kQArJXSzTaJoWaIVmkb92XdnKkk7J9ah+bUx84EgYkEoLGr
         y0cbwdDaUtHASxOvTSMnGYgGv895MHq6LtWGpRUizqyS06Jl9CXOGMLvEcSAF75mCEvv
         xCwahgWPnBoguv21RqwsRI4IS4sXq8RpIgWZFDqZPLNfTbwRFeRzArKhQv3vGvk+whYr
         YSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bhLFZhLOR9onxP484HtUMsK0gwVtyvrIXG0q9mh+mB8=;
        b=2k4MBrixeAf5WGZRytx7MzAr6iOQ4EP4WSC1zmr4bloXhtiUtbQ9/3MWEc6h0r4tsl
         fRRNNdTnIFEiwNQtxfpPVMg4ikWUlJzCOm9+0tbKCGb8kpvO85hhttkutn1UmRf+vN+/
         ie87RUWlm9MaaZYPyFht/yEVdInKUCMNW1imaxHvie/faZbsgvitRB++t9QeuQkt6Njw
         IY0aRxMMcmISegC+opFMTyOVQ6LgOuz50EZvySHxd6i8oDQYtF0eYJjqnaVFRVpK4GFz
         sHphYATWux12tumIy0cILfQTSXrxO0bmgdezg2LWGxYhCdfZplR0aTVCLz6O+qXI26X/
         VX5A==
X-Gm-Message-State: AOAM532kVwuQc+EJ0vbrHxqyz8jOMO+v1VySrIQ4HRJlels+5Vz6GJlb
        QlQfP/1QPu7kWddRa5LpeVWVbssDVSSKYQ==
X-Google-Smtp-Source: ABdhPJwUwARiT0JiS8onhePQzPpGHIHKLwPey9ZANnfcwYX9ORx5RbY3ysiI34m2IZBuDq+PBdKV9A==
X-Received: by 2002:a1c:2784:0:b0:392:b4f9:c6ef with SMTP id n126-20020a1c2784000000b00392b4f9c6efmr9220341wmn.201.1652352767915;
        Thu, 12 May 2022 03:52:47 -0700 (PDT)
Received: from [192.168.1.41] (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id c6-20020a056000104600b0020c6fa5a797sm3800787wrx.91.2022.05.12.03.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 03:52:47 -0700 (PDT)
Message-ID: <7f5a919c-2fa1-a463-1f6b-6b531d5ee27d@linaro.org>
Date:   Thu, 12 May 2022 12:52:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1] thermal: imx: Update critical temp threshold
Content-Language: en-US
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        Tim Harvey <tharvey@gateworks.com>,
        Amit Kucheria <amitk@kernel.org>,
        Jon Nettleton <jon@solid-run.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220420091300.179753-1-francesco.dolcini@toradex.com>
 <486c5c72-812a-d4ea-0c5a-49783bdc4a1f@linaro.org>
 <20220512073600.GA36153@francesco-nb.int.toradex.com>
 <6918b1a7ba401cd4db2db0601137766acd93bc63.camel@pengutronix.de>
 <20220512102454.GA39979@francesco-nb.int.toradex.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220512102454.GA39979@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/05/2022 12:24, Francesco Dolcini wrote:
> Hello Lucas,
> 
> On Thu, May 12, 2022 at 12:08:08PM +0200, Lucas Stach wrote:
>> Am Donnerstag, dem 12.05.2022 um 09:36 +0200 schrieb Francesco Dolcini:

[ ... ]

> Anyway, would it be fine to have a patch that make the critical
> threshold write-able (in my initial message I mentioned this as my
> preferred solution also)? If anybody has a pointer on how
> to do it, it would be great, I'm not familiar with that code.

What about a module param ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

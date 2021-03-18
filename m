Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9119B34037E
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 11:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhCRKiW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 06:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCRKiL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 06:38:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54C4C06174A
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 03:38:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a132-20020a1c668a0000b029010f141fe7c2so2876184wmc.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 03:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oNThMP/eK7GYdaIG4MwRKOT/FT2V43stC7bvB6kYKTU=;
        b=Yt0pb4UO9fIJvdL8d6BO/JGMIfTfuxY3e9yXfrIaHJMFCgg+WrXZcEPAt6PXTULAmf
         Zl4whxZhLFt1AoBUvREpI0GD5sXP38io5CoWWZJypOoaPkT7TBxFCHo81RQjQldjsAtC
         RSU/Gre7031PSRxFPUthiOqm+PVucs/LeEWHbtRBeCUzVI9jT2Hw7122KjMcEvVnJjaq
         2c3dmtjxoWOOwU0kPb6tMkv0ae4BvpEiN4ay2JEEhUs0O4E0TzItXEEXZhdQK+ALSOF6
         dngofwdGvjKNxdK7jqIGhcfViKSVyKtVLW9vBS1pnRbctm+VuD9JJZTtvjwitO2BI7rj
         FYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oNThMP/eK7GYdaIG4MwRKOT/FT2V43stC7bvB6kYKTU=;
        b=VjAVI2pCOP/ajmUvxVsJ6RaBaw+KnRY6kNxX6ibj2UhtIDVKUAMA5RfbQr3VwStQlq
         qWnKuIFqaB9854oE+RRVi9AzHaasTPqMHofvDnri1E4EbRjOcLUhPxn/F3MkvzGUjlNl
         9K1h4D+Jev9Rf9QRi/59R4baDr/X5fKnzGkjSa7VPC3Csyj35ypVlx8gW4AO0UC8dbX9
         Rap+bGhjGsjgdVFokZ5fg1ch2UtJ5OxVYXXmEB79Rm1H72HdZeolHZttjIBn680rJ6Ft
         a62fIIUT21iLJj0J5XJZ9EFKd6qs/Uap9jSKoLYgt4zLnGX8dI/pbIZC8Y/IRtsk+UJn
         eFvg==
X-Gm-Message-State: AOAM530dmCtdtq8JERGNjcIRVBSlasl5n6AIFTBgfUvB+0Qbpz+Abr9b
        TIKC7arDWhZH/IC7EryT91gA5NGPJ2voNw==
X-Google-Smtp-Source: ABdhPJy6864sa0ruuOcj5B1/NFaHOKhVKPsrjAyiArGY3Wvs/Dt1pUIpAr09IUtP7lyuK0Rwx7Lovw==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr2908239wmj.124.1616063889529;
        Thu, 18 Mar 2021 03:38:09 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:94c7:f1f0:53fd:90e4? ([2a01:e34:ed2f:f020:94c7:f1f0:53fd:90e4])
        by smtp.googlemail.com with ESMTPSA id j14sm2364289wrw.69.2021.03.18.03.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 03:38:08 -0700 (PDT)
Subject: Re: [bug report] thermal/drivers/cpuidle_cooling: Use device name
 instead of auto-numbering
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-pm@vger.kernel.org
References: <YFMpUDNGIiLOzr0/@mwanda>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6f6e7b1d-c718-d68d-69f9-998f7b7829e2@linaro.org>
Date:   Thu, 18 Mar 2021 11:38:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFMpUDNGIiLOzr0/@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/03/2021 11:20, Dan Carpenter wrote:
> Hello Daniel Lezcano,
> 
> The patch 6fd1b186d900: "thermal/drivers/cpuidle_cooling: Use device
> name instead of auto-numbering" from Mar 14, 2021, leads to the
> following static checker warning:
> 
> 	drivers/thermal/cpuidle_cooling.c:218 __cpuidle_cooling_register()
> 	warn: 'name' was already freed.

Indeed. I'll fix it.

Thanks for the report

  -- Daniel



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

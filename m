Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6920F24F88D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 11:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgHXJeq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 05:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgHXJeZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 05:34:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1582C061573
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 02:34:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c15so7927188wrs.11
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 02:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oQFrC1o3Nda9YLxSbgopWEOdNnQxrkWudyF2nTbVXVU=;
        b=iI4wNU1gyMDP3WOfbrMsV5PNzotxiKE+bg3HG4dL4ZNpFQ5QXR1VjF7EaZVhqM5pbR
         /apqB/5NXnbQO/3QcPmJa2ymAJrRdh3q+VNx0a0WUjVrqorgAvwGbIygf/nWdu0FJnlR
         2VF43WNvEHWPrUMPWGcStgXCXrQu0Wt4FMh6t/B7KsM4x98lcwZjW40VVfETqRVT7u+B
         YNLoQECf0W2p2wXdHaMUWqr7ZK7KKqGr2dI98GzCd0Gk03gAkK+va2bB9KNnzETyhrA4
         SKMppU9b3ulLFxpyUTLBv1CO7H+HQ/8rLi1gdJkfeb+dDWshGrYd+KTB+cB2lMYgNSoL
         4qeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oQFrC1o3Nda9YLxSbgopWEOdNnQxrkWudyF2nTbVXVU=;
        b=Ohq+01PpAW+9VTdTaaxLrweFs7CSuWdaO4dnpnvTTeHhBXCLnQDRCXRMssyXf2/FMY
         XohlMHJjGEWGcmgumWf7d7FBBB5odzwcC20ZgtzLp3ecRLgQaotBHkgY4YliUSU4FkQX
         +VFYK3aY9LEkZgBDzcxIEja7bZHlp+sjVQhRgTvyzn8Jz0aYYK2ibfdYpyxjVZVnbsU4
         iNDsydm43N0tPU/DvQpGd2r6ytIHnl17soUAaxQ/ZamDslguCufQnFDwUjK3N8z0OEg9
         pFU6dgJc9zhhfQFfIcpSyNLwGKVKMWWgaXpNYYYByM2dgJuJHOEu3qSQ2HlMYTLSWKEv
         Y6QQ==
X-Gm-Message-State: AOAM532DxmQH1e4tABLm6dy9rKHOI04BcP6dEmrmjU3v/DxDEVba02b7
        tz2C9D+LEI0RMLEa+Du7S6R5dQ==
X-Google-Smtp-Source: ABdhPJzfp+hZthOM0E1QMoXJyd50y7e6J2eC0nSOR2g0GL2084Jm9DgaEpMukZ1glzmBjUeTo56zoQ==
X-Received: by 2002:a5d:630b:: with SMTP id i11mr5231552wru.95.1598261663543;
        Mon, 24 Aug 2020 02:34:23 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0? ([2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0])
        by smtp.googlemail.com with ESMTPSA id y17sm5682961wma.17.2020.08.24.02.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 02:34:23 -0700 (PDT)
Subject: Re: [PATCH v2] thermal: core: Fix use-after-free in
 thermal_zone_device_unregister()
To:     Dmitry Osipenko <digetx@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200817235854.26816-1-digetx@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <84ecfc78-bbe7-b4e0-a815-46b6225eca09@linaro.org>
Date:   Mon, 24 Aug 2020 11:34:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817235854.26816-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/08/2020 01:58, Dmitry Osipenko wrote:
> The user-after-free bug in thermal_zone_device_unregister() is reported by
> KASAN. It happens because struct thermal_zone_device is released during of
> device_unregister() invocation, and hence the "tz" variable shouldn't be
> touched by thermal_notify_tz_delete(tz->id).
> 
> Fixes: 55cdf0a283b8 ("thermal: core: Add notifications call in the framework")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Applied, thanks !


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28B62B03EE
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 12:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgKLLdB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 06:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgKLLcx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 06:32:53 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5ABC0613D6
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 03:32:52 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p22so4962623wmg.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 03:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=os5khahHPpWn88KMb1Vr8p8L3JIWYK0ZBr9FMB2vL0w=;
        b=fki1c333F915w4zFn8q2oOpYqkI7PxR0+mBFi4LEeODBMzzkPfR+IPXf726dBZaqD0
         f9RQewNzP/8HvVg0NAZmNJOlBfDB6r/EGLAKj7KJgmEwtZkXDAuCeFTFaNKVSKCSF4i0
         lT5c51hDRifK7TQPpYZ5EHNcvgT7AULWAUFJMqmDJgPDbNM19DXdzy2kKSYzc13/oxVi
         wvdNfkUBxhlkuZlbrGweY8e59SDhpSec54qntjAXNM8aubDywJ7BlYmSRK02+p0Ut6nD
         8x87nqMBQShPpoVh57f8+40KlJ0nSSo0oDn/UFKoMTacizC66jJlDIzNXgQahKEqHVvU
         E98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=os5khahHPpWn88KMb1Vr8p8L3JIWYK0ZBr9FMB2vL0w=;
        b=dV4adzbYg9KQWFT+UteKP7xVM7sHEZG8eNUB8Fs8hMG1Bkd8rCW9UtJaE/QP3FrSG4
         Cd8PbaScL0YJ8qhI+aaZaDSNqByh00H+xWqOGI4nNmo4lJQjoVkxsyB06daBXlUx/LO1
         ww+Inu86JSGIcXN2AClaPmPoelVsPOrnUj2mfDM8sXHe6oBWqFgBO5ACOyxtJ0nKV20l
         Kfva+HTs/Fe78dYFj/sL30a1IIgNPa4KEuQNrzQw4QFLhLxpV1QsT3deDP3ivyqtep5c
         iXjgadOj53Xx7r86y1phawf7Rw6yCOfy6+iOQ9E8ulL6DOClOeV70LPMPr7V3Df5wKfJ
         iEfQ==
X-Gm-Message-State: AOAM532k90lVbnj8IL2NwDPFqxRvDgvMrDK3sRYRkBJVhUPw1sy7pBXh
        Y68FmJUI1TM24BBBOP3s4A6gOA==
X-Google-Smtp-Source: ABdhPJxFHnwQpKvKP0sLSEDE51QQO9sH5IG91X48mB+/3vpw9ApQgn+iMRc5v+DP5drtBLYqVugkGw==
X-Received: by 2002:a1c:acc1:: with SMTP id v184mr8648685wme.63.1605180771454;
        Thu, 12 Nov 2020 03:32:51 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6971:b700:3764:fa96? ([2a01:e34:ed2f:f020:6971:b700:3764:fa96])
        by smtp.googlemail.com with ESMTPSA id t74sm6330516wmt.8.2020.11.12.03.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 03:32:50 -0800 (PST)
Subject: Re: [PATCH v3] dt-bindings: thermal: rcar-thermal: Improve schema
 validation
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Rob Herring <robh@kernel.org>
References: <20201028153541.1736279-1-geert+renesas@glider.be>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7c83cb9f-d8fc-b349-1da8-5e0bcb6da89f@linaro.org>
Date:   Thu, 12 Nov 2020 12:32:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028153541.1736279-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/10/2020 16:35, Geert Uytterhoeven wrote:
>   - Factor out common required properties,
>   - "interrupts", "clocks", and "power-domains" are required on R-Mobile
>     APE6, too,
>   - Invert logic to simplify descriptions.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

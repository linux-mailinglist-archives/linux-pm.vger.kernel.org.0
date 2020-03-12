Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54A20182E3F
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 11:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgCLKuj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 06:50:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36438 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgCLKuj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 06:50:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id s5so6824130wrg.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2020 03:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0oTfpkffBRPhCDgSx9RwG3CEjZua2w+TS9rgfT94Gx4=;
        b=ybRwjh0cHJAaYsBUekuNJkLizHG2Gto55KbE0BPQ7tzltvCmWb97SI+G1gkapOuTap
         nJrscxzYS49j7dOygUYXMfKqZ//GDWYlN92DA/OaqOL54/ce6zJzVu6Halgjr+GNLCnp
         kvlLJNmAhpIr5NqFFuA62Hw6UsZn4SivAfjF7Aw0vSCFvcE5LUj9UWWgnf3tJwhP/Q/b
         yNEYTFAksIHo0pJsHi/KibrtsJAtTTrWXvvS45SRorFnJGiqcZNKvwy3n4UYhPotdbJf
         5kEgXj2ejxlgZjLnMqGrGu/RUZbc1/ESkUAqv54rFDkMk6ni4RcwCPKND7ZgGLQZvcbH
         HUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0oTfpkffBRPhCDgSx9RwG3CEjZua2w+TS9rgfT94Gx4=;
        b=lvFF4g/5ryAf7rDl6EszMxATAJXjW/YOyKNhO/ArnPzZPatx8jgz0mXSEOSF4SS5Am
         w0q/vO0ELi+DH7GQoMBDMXFGKWBgkZqz5ou3Tj0Q24Tv3i/9SwteyCor4TEavGTRfKFk
         U3OgAuE61icin69WxoDhmhu0fPKL5oQ6SGpc3ASaxGbESuYmzejV1wiE9qcMNE+ChtIC
         Lwpab0HrvkjP16oNAyzN3cW1W4wwIDtV/MSL7PYPaPdeX9dAlGipmV+ef15vSkNiHWIM
         4wm0qRuYE2YEoJESQLH+LKJ01QXp6AKcQLxBnFjPyKQ8yKG1iCsXzneEdEsJEn9/yOOX
         4Cuw==
X-Gm-Message-State: ANhLgQ0DYf/XvYNsnNK9VEmwCRVBHJw8GSXiQuAfcaY6mnJN1zCq13HB
        gvGsNVlfAoECvUFXGrlGLjpo632XHRM=
X-Google-Smtp-Source: ADFU+vtNJCTxoZwdJsJgUdCcXKLLRY7GRBSthsVCLGltbXDyqFN1KTNEBhohyGN0E/I5Z0389FD0fQ==
X-Received: by 2002:adf:e9c4:: with SMTP id l4mr10489678wrn.421.1584010235687;
        Thu, 12 Mar 2020 03:50:35 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:3880:fdc2:ef6b:879f? ([2a01:e34:ed2f:f020:3880:fdc2:ef6b:879f])
        by smtp.googlemail.com with ESMTPSA id j15sm35544931wrp.85.2020.03.12.03.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 03:50:35 -0700 (PDT)
Subject: Re: [PATCH v6 0/8] thermal: tsens: Handle critical interrupts
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
References: <cover.1582548319.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5c7153cf-903d-607a-a783-35a4db7d8500@linaro.org>
Date:   Thu, 12 Mar 2020 11:50:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1582548319.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Amit,

I tried to apply the series but I've got a plethora of warnings about
WARNING: line over 80 characters from checkpatch.

Also the log contains the Link, but actually it is not necessary as my
scripts are automatically adding them so it ends up duplicated.

Can you resend the series without these warnings and the Links?

Thanks

   -- Daniel

On 24/02/2020 13:58, Amit Kucheria wrote:
> TSENS IP v2.x supports critical interrupts and v2.3+ adds watchdog support
> in case the FSM is stuck. Enable support in the driver.
> 
> This series was generated on top of v5.6-rc2.
> 
> Changes since v5:¬
>  - Introduce a function tsens_register_irq to handle uplow and critical
>    interrupt registration and reduce code duplication
>  - Clarify reason for patch 04
> 
> Changes from v4:
> - Add back patch 1 from v3[*], I mistakenly didn't post it for v4.
> - Remove spinlock from critical interrupt handling
> - Change critical interrupt handler to fall thru watchdog bark handling to
>   handle critical interrupts too
> 
> [*] https://lore.kernel.org/linux-arm-msm/77dd80eb58f0db29a03097cb442d606f810a849a.1577976221.git.amit.kucheria@linaro.org/
> 
> Changes from v3:
> - Remove the DTS changes that are already queued
> - Fix review comments by Bjorn
> - Fixup patch description to clarify that we don't use TSENS critical
>   interrupts in Linux, but need it for the watchdog support that uses the
>   same HW irq line.
> - Separate kernel-doc fixes into a separate patch.
> 
> Changes from v2:
> - Handle old DTBs w/o critical irq in the same way as fix sent for 5.5
> 
> Changes from v1:
> - Make tsens_features non-const to allow run time detection of features
> - Pass tsens_sensor around as a const
> - Fix a bug to release dev pointer in success path
> - Address review comments from Bjorn and Stephen (thanks for the review)
> - Add msm8998 and msm8996 DTSI changes for critical interrupts
> 
> 
> Amit Kucheria (8):
>   drivers: thermal: tsens: De-constify struct tsens_features
>   drivers: thermal: tsens: Pass around struct tsens_sensor as a constant
>   drivers: thermal: tsens: use simpler variables
>   drivers: thermal: tsens: Release device in success path
>   drivers: thermal: tsens: Add critical interrupt support
>   drivers: thermal: tsens: Add watchdog support
>   drivers: thermal: tsens: kernel-doc fixup
>   drivers: thermal: tsens: Remove unnecessary irq flag
> 
>  drivers/thermal/qcom/tsens-8960.c   |   4 +-
>  drivers/thermal/qcom/tsens-common.c | 185 ++++++++++++++++++++++++----
>  drivers/thermal/qcom/tsens-v0_1.c   |   6 +-
>  drivers/thermal/qcom/tsens-v1.c     |   6 +-
>  drivers/thermal/qcom/tsens-v2.c     |  24 +++-
>  drivers/thermal/qcom/tsens.c        |  63 ++++++----
>  drivers/thermal/qcom/tsens.h        | 103 ++++++++++++++--
>  7 files changed, 320 insertions(+), 71 deletions(-)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


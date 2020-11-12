Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4905C2B03A6
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 12:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgKLLPf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 06:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgKLLPe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 06:15:34 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBACC0613D6
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 03:15:33 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id w24so5171555wmi.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 03:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/FhKisUgi05Fi36Lpqm8o1v5iZqeSoZV/MjuIdxFVwg=;
        b=ep5JvcpkgFIJ5q2HS/xiPhp7fZ1WmU0nCy25mzKSXLPh19xQj97YARcWa/ZkxIaHZn
         rf1D3pRLFBmPomdbvsD1SYdnx0BMstIqnOBnbWzlDtE/eBdrmnn0Ru4u5gSE+id3l0To
         EWatXOJKrMYxRdncb7jhpwxtZu1hzinTHQSyJZelfSh8K0RXB9Pkxl/p0yGa8Si7qmyK
         p/U5fWMG17qjmXXZfc2xykZ4YU+jt8UwT3g9zwIbvvs/SFzLP5VoL48+mYw0h6xFUolW
         qbI/atiaD2yZl3fROBjHkmY+6436T81WO+fvea07dkRxH8Ju8flpHTKlYBkOctqFoqas
         mfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/FhKisUgi05Fi36Lpqm8o1v5iZqeSoZV/MjuIdxFVwg=;
        b=C6bTIq4+ukZAOquaSjpi38NViLII3v6V5H2sSgkuMP0EzEtztjzwCi9sC2m6sovHjw
         cSaE+aRd36NPxQCDxV3PNAFTHNL+SVq5iWV5M31hNe0N1T4jU0oVy2Mf4pJAXDZNFpi9
         tN24ek203tz50mNJ+0yH5cHanErMjlMejcF5YLNIEpaanCkG2M0HF18kyd9oD465TgmU
         pSDjPe23LKUnnlt/yCOGXyGianuHUYMvKPfJc0RUVz6CU1jDC2+cZqS/4Gc9/Qp/qJbg
         4Ok3E11SttdR3tzRSBthnWadGOvtzU0RaJX9MqGcoq5deP6oZRo0mFbbtD+GVW1JrtpZ
         6hvA==
X-Gm-Message-State: AOAM531ymNmmHWUwcmh5ocZEYLkwJ0PAtjQkYiaYp0Bkvj9Br+Yzd1iu
        NuCBr9nj3pKpOcMlkg1Y9QDeRg==
X-Google-Smtp-Source: ABdhPJz9Fus+KqIsOo74z1TaBGnXodgiOyhTpBXfTins6KZYPxa9jaGe+xpzadIQhfbr4OErt9zpiw==
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr9509953wmi.78.1605179732188;
        Thu, 12 Nov 2020 03:15:32 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6971:b700:3764:fa96? ([2a01:e34:ed2f:f020:6971:b700:3764:fa96])
        by smtp.googlemail.com with ESMTPSA id g186sm14107194wma.1.2020.11.12.03.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 03:15:31 -0800 (PST)
Subject: Re: [Resend][PATCH] drivers/thermal: cleanup coding style a bit
To:     Bernard <bernard@vivo.com>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <APoA5gC4DV1j7eiIeLvDwqqi.1.1604995820664.Hmail.bernard@vivo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <72dceb1f-64e7-c6dd-20c6-486e4002bbbc@linaro.org>
Date:   Thu, 12 Nov 2020 12:15:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <APoA5gC4DV1j7eiIeLvDwqqi.1.1604995820664.Hmail.bernard@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/11/2020 09:10, Bernard wrote:
> Function thermal_add_hwmon_sysfs, hwmon will be NULL when
> new_hwmon_device = 0, so there is no need to check, kfree will
> handle NULL point.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---

Applied, thanks



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8548E220885
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 11:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgGOJTN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 05:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbgGOJTM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 05:19:12 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836E0C08C5C1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 02:19:12 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f139so4829791wmf.5
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 02:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6S4rQcbbTZAnnQ2mAS4yWMNRrJk1s3+AGlDrxLO8KXg=;
        b=ZTSEyblPv2P83EojiNZREKOaW+HEbHXuQwZA+qzHoDEeevYBXsbb/m7Cv2JKaRUPSC
         OMB2+0GdNF/GhRmuYrohmDcZPNviTo39lIFcOjNItuFg9iC6sSjI/0gxJSYjOA64Hnp/
         V0VP57wQFxu+O9su7OIDG57xbfzaTmscPLBmK+zp8eVmLJ/IGvHVlj1ENw7MdYwUmKz0
         3+zmUDmRqQlHD1KpGX7yMHc/YHXnDZUAQjUG1Nh03TgiZAinVyQqrl+RG0RoAOfdwKSo
         /XLiw9utxk91lHgTqrPuKUYEs1l4gC+Xw7ZQRa8Mb3Gaf72hktg0TmZLVm29pQWo+44b
         Yemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6S4rQcbbTZAnnQ2mAS4yWMNRrJk1s3+AGlDrxLO8KXg=;
        b=B9HoJ//mMtatvuwm+Lud6UApGJw64BImOlyMBX6SV2vVackBQ8bMHAo04Qf7tJlVeA
         ZbWyIpe6SOJTUuOdFRdkiuV/gjTeLoBfLsgvVRR4B0dzOGRNDYl/0fns6d6UWb4UKIy7
         XNbhp7MG7droBl2GxVRmqx4kpbZZ3gYX7UoPnFG/xTVUyeRUPZL7kD8cfNAE3gBxEb18
         32e9JbZwY8dg8CCUwljCVq/mU+q3uM/1/2Sxy3fAj0cTeP4kPEJxlwoc4xZSozp5638P
         N2dHm1F6eqMp7vabYB4AI7XaHoT+ua3JSnnrf/zAOJEg5LLS/J+RUrJbaf0KVHbmNCfb
         Qkgw==
X-Gm-Message-State: AOAM531DEfuiFhDUZ5SgZsq0jkg4nKOyMiGTuwBjj4batQLN05KTJQsh
        sCJjJJ1XrJvv1/tRiTI3ULEnoLgY6QI=
X-Google-Smtp-Source: ABdhPJz01iAz6XrxpaOaf1z0Na2lpWh6FhP27ILMosYGk50ZrcsrE3mRryySLa/rmuI3t6DXkfpSwA==
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr7477060wmf.87.1594804750107;
        Wed, 15 Jul 2020 02:19:10 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:814b:c0b2:8c76:b6a9? ([2a01:e34:ed2f:f020:814b:c0b2:8c76:b6a9])
        by smtp.googlemail.com with ESMTPSA id q3sm2371916wmq.22.2020.07.15.02.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 02:19:09 -0700 (PDT)
Subject: Re: [PATCH] Revert "thermal: mediatek: fix register index error"
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Michael Kao <michael.kao@mediatek.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20200707103412.1010823-1-enric.balletbo@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7aa6c0a5-3fc4-fd27-ece8-d062078c6faa@linaro.org>
Date:   Wed, 15 Jul 2020 11:19:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707103412.1010823-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/07/2020 12:34, Enric Balletbo i Serra wrote:
> This reverts commit eb9aecd90d1a39601e91cd08b90d5fee51d321a6
> 
> The above patch is supposed to fix a register index error on mt2701. It
> is not clear if the problem solved is a hang or just an invalid value
> returned, my guess is the second. The patch introduces, though, a new
> hang on MT8173 device making them unusable. So, seems reasonable, revert
> the patch because introduces a worst issue.
> 
> The reason I send a revert instead of trying to fix the issue for MT8173
> is because the information needed to fix the issue is in the datasheet
> and is not public. So I am not really able to fix it.
> 
> Fixes the following bug when CONFIG_MTK_THERMAL is set on MT8173
> devices.

Applied for v5.8-rc6


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

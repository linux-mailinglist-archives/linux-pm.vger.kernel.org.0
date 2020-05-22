Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3433C1DEBF1
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 17:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgEVPdu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 11:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgEVPdt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 11:33:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14FAC061A0E
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 08:33:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u12so5426241wmd.3
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 08:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hcAXj+h6riPB6ZVFEUDphaR6SMt//XrFMgdCLb/lUPw=;
        b=ZXPT8vQKI0THre0nWQptX5DX3OQEF0MPvOLZC7BlkLaE8b8NlW7h8xPy4kbSwyIZHV
         pWs116H27CkgzXUT7qAcDmdmELdwgYchJL2Wm/AczM9aL0p/p7gE2uGxh2SV0rFX7XHl
         RxcaGG0N7CkRI162e7zraSaqMieQFCIrcm3Xuwm+s2vSd6PyqmJbKTs4BD9MDjdvWpbp
         efG81d4dq20GG9GGcLe9ZagCLUuMs/imDDvN9h5F6VPHNcCzTdZb4Nhkfu1AjzTQJVhd
         6+qPw/syj140kRSQa8Ae/WBtvlLjXn6BaoIpSYLcUuzNmVu9CoerPfegvw+D7g1xaLLA
         2SbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hcAXj+h6riPB6ZVFEUDphaR6SMt//XrFMgdCLb/lUPw=;
        b=PNYUfSZn4Qy15BBhsXkemjyq8V0A3y7YXtnlmSxZ63w9o5yY8DQOSkxq3CT5lIiCo2
         +39JXHORFm1U7jNi4Osvsrtm/SMRR5pYegCGeZzu4iYLgmVRkfWK4UhrBXEykOl4+FD9
         ml+qIyWZ7exrAzseR4fy8pT5biSQByaPqWqxX4ufX8GZdy6n2SwC0hzrDELi0YIMfINy
         cbCGzUFB+OAoy0HqOZbWbuL9BtSBLh4keStIrLXi9e9MDiiS/0jC8HvqkZcA0eoeyqLa
         zP5q3vJvmvQVi10MOA6a4gfhrIrPFmRQKmk9iKtspUgbOLbeDxp5jIOBQGICmxrD3+oh
         xRGQ==
X-Gm-Message-State: AOAM530BaytSiheZzJgP9QRDGM5He6N6gsOu6MdNvFE+dcQUXzlIz2WK
        2yofIbIqh17e5ef/WD/RpfqiqA==
X-Google-Smtp-Source: ABdhPJxxBsnw5zL4lBpgkFI3TE2YpKrnDJ7HYXK3kVd96/lV1AeheFpxuXyyvMvX9yH1jJgZavj/BQ==
X-Received: by 2002:a1c:9d85:: with SMTP id g127mr12895128wme.149.1590161626832;
        Fri, 22 May 2020 08:33:46 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a82f:eaec:3c49:875a? ([2a01:e34:ed2f:f020:a82f:eaec:3c49:875a])
        by smtp.googlemail.com with ESMTPSA id d13sm9605844wmb.39.2020.05.22.08.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 08:33:46 -0700 (PDT)
Subject: Re: [v4,5/7] thermal: mediatek: mt8183: fix bank number settings
To:     Michael Kao <michael.kao@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, hsinyi@chromium.org,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200323121537.22697-1-michael.kao@mediatek.com>
 <20200323121537.22697-6-michael.kao@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c88aab57-7c0b-cb9a-3ee0-68e7c140c985@linaro.org>
Date:   Fri, 22 May 2020 17:33:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200323121537.22697-6-michael.kao@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23/03/2020 13:15, Michael Kao wrote:
> MT8183_NUM_ZONES should be set to 1
> because MT8183 doesn't have multiple banks.

Apparently this is a hot fix. Can you confirm and explain what is the
procedure to hit the bug?

I'll pick it for the next -rc if possible

> Fixes: a4ffe6b52d27 ("thermal: mediatek: add support for MT8183")
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/thermal/mtk_thermal.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 76e30603d4d5..6b7ef1993d7e 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -211,6 +211,9 @@ enum {
>  /* The total number of temperature sensors in the MT8183 */
>  #define MT8183_NUM_SENSORS	6
>  
> +/* The number of banks in the MT8183 */
> +#define MT8183_NUM_ZONES               1
> +
>  /* The number of sensing points per bank */
>  #define MT8183_NUM_SENSORS_PER_ZONE	 6
>  
> @@ -497,7 +500,7 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
>   */
>  static const struct mtk_thermal_data mt8183_thermal_data = {
>  	.auxadc_channel = MT8183_TEMP_AUXADC_CHANNEL,
> -	.num_banks = MT8183_NUM_SENSORS_PER_ZONE,
> +	.num_banks = MT8183_NUM_ZONES,
>  	.num_sensors = MT8183_NUM_SENSORS,
>  	.vts_index = mt8183_vts_index,
>  	.cali_val = MT8183_CALIBRATION,
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

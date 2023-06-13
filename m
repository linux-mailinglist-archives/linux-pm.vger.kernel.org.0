Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E9772DD88
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jun 2023 11:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241860AbjFMJTf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jun 2023 05:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241868AbjFMJTe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2023 05:19:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3538EE47
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 02:19:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f7a8089709so55087975e9.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 02:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686647971; x=1689239971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85h3cBiBNVC64etO4MoXxUSwuanSFultgefQOTEuL4w=;
        b=aP7wu7PqoUhTitgvxiazJdC0gQUWdtj6ghI8C/XKnQrm6udF1Y2P1591QhK5by6AZC
         XWbtLCDD299KLNRGKTHTzM7eQxJZMqYoKHQTUZfJqH7TmOjtSm8AAQtMeG7N+ZBeBvyV
         ahBqCM2fG0BXwxMGAh/ae5VWevZa4KaPVH1DXrQbVq8p5RE3p7qtvnbnq2v3wowrHd03
         8L7IG3Es1RaryRAuLZoLnIf7n0sRp//vKk4k3FXWVRjLselzcKcwatHwNrjag+fnzaYF
         FSCjSrAa1tfa63AEjy52IVRb2G4wediAsD/iRH0VcocTkbX2PSDBtgVC5XWbraeg9DAp
         ZpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686647971; x=1689239971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85h3cBiBNVC64etO4MoXxUSwuanSFultgefQOTEuL4w=;
        b=RoG8nKmrXBXuwI+vdG+biOwVGnF8O6mqe5wyhnWUyu5G9rgoeDgs39ZovFqxkkUjsI
         E21HcZBa7rOEZzHTO1od1XIKYOcx+zsgcUD25NT0Q+DK0fYe1fkoYhQhgod6E9iBFCvc
         kLA1NldUpieRFGD3glyXg4h/jKkCAiLbZS8Mz4NPrmqhAr2RhIGKZgIYYx/5nIu93JWh
         GXOsfLsrpDGWFlm3BZekA32I+rTeq+SJAyumDFNsKQ/1UOIVUGEnE0qjIZjSQisksPj0
         Y7XoMq8GZ1IF5Y+9hugvtqHw8hAGWReWaEPKReJOe3KDWG9BVvdvbPbgQtUW1jW3d7Kl
         c9Ng==
X-Gm-Message-State: AC+VfDySRZlRMpMtxWGpQ4M1uy7CgBmG3Jo+N/hLmxS//bMegTzerjlF
        LiCG9ByT9weA0cfI0SMZh9fptg==
X-Google-Smtp-Source: ACHHUZ413zhzKv18Vi3+GAmUiNoP2SFNamiwUJslNmUrmfdr2gkL892xPE21dUAL3Lv0juaLsX9EoQ==
X-Received: by 2002:a7b:cc84:0:b0:3f6:476:915 with SMTP id p4-20020a7bcc84000000b003f604760915mr9169425wma.6.1686647971564;
        Tue, 13 Jun 2023 02:19:31 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b5a8:28ff:af00:a97f? ([2a05:6e02:1041:c10:b5a8:28ff:af00:a97f])
        by smtp.googlemail.com with ESMTPSA id v5-20020a05600c214500b003f819faff25sm6523480wml.13.2023.06.13.02.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 02:19:31 -0700 (PDT)
Message-ID: <318837d7-72fd-00cd-d57e-03aabc24f506@linaro.org>
Date:   Tue, 13 Jun 2023 11:19:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RESEND] thermal/drivers/mediatek/lvts_thermal: Register
 thermal zones as hwmon sensors
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230613091317.1691247-1-wenst@chromium.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230613091317.1691247-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/06/2023 11:13, Chen-Yu Tsai wrote:
> Register thermal zones as hwmon sensors to let userspace read
> temperatures using standard hwmon interface.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


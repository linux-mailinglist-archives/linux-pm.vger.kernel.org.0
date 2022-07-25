Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC5F57FF0B
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jul 2022 14:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiGYMfY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jul 2022 08:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiGYMfX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jul 2022 08:35:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9F3A1BB
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 05:35:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u5so15762557wrm.4
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 05:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JCziedm4VsI0JyKxRR8HuqE2xr15IJT2FvFr4HkbAys=;
        b=U+mrpd9LNpGmAP3SfYjz6gtSgwo66PCEUslFJW5DZlqum7KNdCF04NYy912hYs8JOl
         VR+ZMy5Q/sKyEqrRAYIPlolkFWg6DMEvRZk8SlxoKJeGgz8xvviAahdrQ2ZCE1/p/5Hq
         zc+80zHj8BXsZ0L9wU/ilfc9lfGUAVPRxFzRb2gpXWzXPBibBxm8iGRAJxihVoQGhakK
         DdxqEm/hu/MwcsDtudyvFN2rR3U14MmvplpMwoZ+H7Pe46Wm5fyHb/UeQQi7Prkw0QSw
         smen0BQx3Xg9rduq1t0ZI8w7QsFPy+Pa+rvGVHnJ+eVjA9efNUjVu5P0dC+P3WCMnsV+
         qopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JCziedm4VsI0JyKxRR8HuqE2xr15IJT2FvFr4HkbAys=;
        b=uE/fHfNy6kbCSuJMH3v47seTzrjJ2qYV2b46+u65FXIorooHsLOrDTL9EwTAUAp8Z+
         DXLy9PYaS6Nbj/EJdVRG/xubtvZP1NF+H6yR3skPS5Nq5Rl19xPwmVdMeM2KFQbA51AI
         1q6ianM9OEq2o6nxS4zQoqkBw3ur9luWC8jTY2Q1NOfS3/NoyD87calaDXM7lBE7a1W8
         aP3O1L3h5b1FnQiBE8ulRx8hzuncpHrk54mSECP4GFzGVO5pllyCTHT7p9X8bTlYzhgB
         pu0momKHApLUI6lT5wolVZ4hsM6QE3Cb8mYT+Vl22ctNfGY9v911StrDQLiDUFJZfRyZ
         9k3w==
X-Gm-Message-State: AJIora+rAlClUvlkMVlzo3ctKcRqclfQylmLxBjofM/cW6HvJkJOS+BZ
        z+QrXUt3iF3CLfDkC1mFhPX8jKMSXZqaZQ==
X-Google-Smtp-Source: AGRyM1uln4UZKBIVdu3PXTPZC/SWMyl/3hMznU7MW8sraTZW+pc7/dQtLrrEkBidd9Seo4x0JaqmDg==
X-Received: by 2002:a5d:64cf:0:b0:21e:84da:de2 with SMTP id f15-20020a5d64cf000000b0021e84da0de2mr4210754wri.578.1658752520013;
        Mon, 25 Jul 2022 05:35:20 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1780:8e54:dd38:6668? ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.googlemail.com with ESMTPSA id i6-20020a5d5226000000b0021d6d9c0bd9sm11782356wra.82.2022.07.25.05.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 05:35:19 -0700 (PDT)
Message-ID: <32657ad8-eb1a-1b70-d903-916640b2eeef@linaro.org>
Date:   Mon, 25 Jul 2022 14:35:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] thermal: imx8mm: register with hwmon subsystem
Content-Language: en-US
To:     Lucas Stach <l.stach@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, patchwork-lst@pengutronix.de
References: <20220722165815.1601124-1-l.stach@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220722165815.1601124-1-l.stach@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/07/2022 18:58, Lucas Stach wrote:
> Provide standard sensor monitoring via the HWMON subsystem by
> registering the sensors with hwmon when CONFIG_THERMAL_HWMON is
> enabled.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

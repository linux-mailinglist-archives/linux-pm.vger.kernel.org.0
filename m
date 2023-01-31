Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18EB682FF0
	for <lists+linux-pm@lfdr.de>; Tue, 31 Jan 2023 15:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjAaO5x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Jan 2023 09:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjAaO5c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2023 09:57:32 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149314900C
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 06:57:24 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg26so4695997wmb.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 06:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oHAz431bQVsrWdf09rNRXz2YYOaoDWdEG53YOtzyMSQ=;
        b=NPd6zNRKzONuD2Bt3nTD1S2D1/hPxA1Tii6pwOg3YI2S7XlGqO3PVRx8DjdKC7usic
         WRgM72iqDgdYDvTlpvokkexd98wusJk2S5CFituZpGdGu59bTyMPueBrOFFDaymNyNJv
         huEHZktGRtEtyL+zjP7bhPjYfRxGhuypLfDcQntqcq5bfg0qw6ivIfp/XiHuWS6nHcD9
         f1K2aJC8SrxaBfk+ytz4zeq5xqeBibECPZy6TW/3gYrB+ec7xhv8+HMWVrT6cPrG/tU2
         iHSxaG8QWDtevNoImOV2yp94wEONl6/SqrtoSGWuRJoUGGyQ3RzlV6sfAHSoi7tgfPcz
         SP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHAz431bQVsrWdf09rNRXz2YYOaoDWdEG53YOtzyMSQ=;
        b=mTStpzMA4IwBDNIJbDJ/0ThXHaZiA6/ZDPvmvKvA1yOawm87u3M0XGh7gkUdM9wNYt
         W9XjC18v9aGDk88Lz1RIyhaXLu7787bEFhk01D6eCjHoV9a7NKtOCSqZ4FAMJwhy7slT
         gyxAe0VpJ4dIDseJTUAyuxaNwWwOfI2XRgTCwpGMJxKdg+BsQuIMbGg+TW4Twm3II65I
         be3Tjo1ZTmcPAb3vHa3oL93V0o7xET2QHhN059TFTMPBrfpwS6YWFbw4vfyWIuPN8aq4
         UNYUV9S7P7+n6Tvoouqsfuda2nzYiqelgmkSZPhz0XrzV4Y0b/XAJZu1d9cU+S6M/oOd
         e7aw==
X-Gm-Message-State: AFqh2kq3s134aAAB3fUg07bMrJ3A3OZ3WpWeePF7sr0VXt4c8t+2Dr40
        Akd4JdfioUTTml6GPjIdxjWHxg==
X-Google-Smtp-Source: AMrXdXt/MYfxZlWFqCP9KNKC+s3TYem6ne/GKkZEeZLYLy2NQfumKPXr30pG4kvYeFN7am8u18dT4Q==
X-Received: by 2002:a05:600c:5386:b0:3cf:9844:7b11 with SMTP id hg6-20020a05600c538600b003cf98447b11mr56227425wmb.23.1675177042481;
        Tue, 31 Jan 2023 06:57:22 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v6-20020a05600c444600b003db09692364sm21691874wmn.11.2023.01.31.06.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 06:57:22 -0800 (PST)
Message-ID: <8897ee56-3043-d2cb-4dbc-3ddc97e19854@linaro.org>
Date:   Tue, 31 Jan 2023 15:57:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 4/8] thermal: intel: intel_pch: Eliminate device
 operations object
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
References: <1751684.VLH7GnMWUR@kreacher> <2141577.Mh6RI2rZIc@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2141577.Mh6RI2rZIc@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/01/2023 20:02, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The same device operations object is pointed to by all of the board
> configurations in the driver, so effectively the same operations
> callbacks are used by all of them which only adds overhead (that can
> be significant due to retpolines) for no real purpose.
> 
> For this reason, drop the device operations object and replace the
> respective callback invocations by direct calls to the specific
> functions that were previously pointed to by callback pointers.
> 
> No intentional change in behavior.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


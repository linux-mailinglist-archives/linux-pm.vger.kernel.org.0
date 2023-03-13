Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0893C6B74B8
	for <lists+linux-pm@lfdr.de>; Mon, 13 Mar 2023 11:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjCMKxh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Mar 2023 06:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCMKxa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2023 06:53:30 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A4C9743
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2023 03:53:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j2so10836058wrh.9
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2023 03:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678704792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JqG4tabqiNjJWGiRS0dD4BwqXnjwKnTsxw9IC1NkNdU=;
        b=Z6xcObKjT5VO/v8zz5o3YCZMnxYOiJxel4xnyDt3lTF+8jZgDEvVcw7wJReioCWatd
         pozZo4wMo0S3BdIveMErwjzHQuCIFaRn94RKfNQVvvVHMDzt/KX1WyUkRjP4VKrG3zOd
         lpNkGqFhkzq3OKUtqQczIX6ALry8wKGPH6R1gYOWGXimT++O0SRWIQuUKDyU4WZSZHhH
         FCHisfASJ27UT0QrqKVmuoui9pubFPD43kBDhZ+YpPwvxAMD5xRx8piAWGjmhxDcWBkq
         CyhWJBQog2RHVCBu3I5oX42o+0/U3Jb0M/859uy4YBcSWWRLB4QbyRJOiInTmc9zfU4B
         ckaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678704792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JqG4tabqiNjJWGiRS0dD4BwqXnjwKnTsxw9IC1NkNdU=;
        b=y7qRUQthDtm4xlGvxF3tLbbLtoTxxhkyOH7kjh3dVIbe2QIIzUi7xaQ7INzpPZoO4+
         omIp/4SSdydEeGSP33NN3Vzwc/rUzITjXnc6das8qVsmUcb6yKgYGSjXxDrYbg9C+wsd
         EL5uNIip46TtH6EYZGXsz7OjVZaQZYMVC6DTdBXJBjiIm4UaPNQ2nhuYV49aMwhWGO7E
         Vad/XFYNgIWvnooZ9mnj6qdZ4MvgO6c7XZEi1U1OXdcm9aH+kldhbrTCx78V5FVfw4L/
         6STDZQwJOeWHuutQNWtVaDCEY3yIRwkJdodpegfm3dLnphd1i6rJpoS6qQ3bZ9aoTo4N
         NJ5g==
X-Gm-Message-State: AO0yUKWkP/gQfsfnPzVGKV5uxnCg4YIc/2f0PeiOItw3VYQUL0dyGGLg
        zJPyXsfz6ZDzfqiLgKGTtHD7Vg==
X-Google-Smtp-Source: AK7set+Im09dd0mpndL5xYZrPJyJHqNjZ00qZTMHZyRVaUlxpFkx5ZlcRDlO0Tn7Eza770Eemylnyw==
X-Received: by 2002:adf:dd42:0:b0:2c5:4659:3e76 with SMTP id u2-20020adfdd42000000b002c546593e76mr7909281wrm.18.1678704792390;
        Mon, 13 Mar 2023 03:53:12 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8522:ca6e:1db4:96c6? ([2a05:6e02:1041:c10:8522:ca6e:1db4:96c6])
        by smtp.googlemail.com with ESMTPSA id q18-20020a056000137200b002c7163660a9sm7497025wrz.105.2023.03.13.03.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 03:53:11 -0700 (PDT)
Message-ID: <01b68043-7d86-3d1d-2e1f-98bbd21d80eb@linaro.org>
Date:   Mon, 13 Mar 2023 11:53:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/2] thermal/drivers/imx: Remove get_trip_temp ops
Content-Language: en-US
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230309092821.1590586-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230309092821.1590586-1-daniel.lezcano@linaro.org>
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

On 09/03/2023 10:28, Daniel Lezcano wrote:
> The i.MX thermal sensor uses the generic trip points. The thermal
> framework can return the critical temperature directly.
> 
> Remove the pointless get_trip_temp ops.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


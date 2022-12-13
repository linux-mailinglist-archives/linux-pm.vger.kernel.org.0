Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB8464B19C
	for <lists+linux-pm@lfdr.de>; Tue, 13 Dec 2022 09:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiLMI43 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Dec 2022 03:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbiLMI41 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Dec 2022 03:56:27 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173EED65
        for <linux-pm@vger.kernel.org>; Tue, 13 Dec 2022 00:56:26 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 206-20020a1c02d7000000b003d1e906ca23so1302342wmc.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Dec 2022 00:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQ3A0vYkVQCwU1Z7CfcyivsPXuz89CFz3h/4i51NMoU=;
        b=jYrDfbXDRiz+bsSiTAfRiNdvzZCEaVYZ5lr7cHehm0hDWi1BQcFjbpSgjamigtdWCM
         QXpcYrcID5aMl4fWfK9xtZs04k2JxctPS0G7qUd3Pji2Zk4jnLGBXDjD1+jHUzW563wn
         q0o3mLVg0HY3N2uhDmLfyq9hliwW95vvYuW9wtp39xOMsJ5XlfS7wqDmWcQBKYJqG0rS
         FXNnVq/21VVvBwcC7t2wUXe/obffcp9NOOZgxcOV1tWgDreX/H9T2V8uPzPfNP+pkofp
         RynEbiAavuVVHeTDWlc/DnFTFFITICK9aij02K4RHNRAzl09xZzubM1VPJ4q9Ps7fIQW
         fETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQ3A0vYkVQCwU1Z7CfcyivsPXuz89CFz3h/4i51NMoU=;
        b=d0UUkKiHa+rQaboNpYuRN475E81SGy20V2Ui3LtjOIsO0M/0LmtdJXhWdojFP4MTVw
         4AlPPXDluuT3U8d7221eMjd7qCH9MrWgSJgTFJTkkDK7mKq5EabXXXbRoy1H6SkrGss1
         NyheBiRddNblxsB0kMzYwnaV9Ai0Xycn+NxOTuMV4JSiyfxANmrSI0D0oztYgGVh6o7b
         RcL929NF+ypMPkBQAJOaSemT+Si63gOHqQOjb+FFIGtQSlh3B8Uq3EYpxydOaLsdmczY
         4XFLL/4k9Hu5R0cQUuY1ceP/Zw05przfPk5LlKr7qw9OlkgSwjNGHS/rOHyPSbrGshUd
         wpTQ==
X-Gm-Message-State: ANoB5pn+N1+z5hGbl1NOYr8UJndzAoZtwOdlxuX5CBabXnwACwl2ISug
        gfSOSuY4pDrv8cpmNBZCgf0KXRzTf+dsk17q
X-Google-Smtp-Source: AA0mqf5rimGN7hLdZ/oay5nBDMeCgaxFzHE/T7Hi9TqKhTGdA9t/vfrWflXjGEgqrTLtWu4VQoaSIw==
X-Received: by 2002:a05:600c:5546:b0:3d1:f6b3:2ce3 with SMTP id iz6-20020a05600c554600b003d1f6b32ce3mr17843377wmb.35.1670921784546;
        Tue, 13 Dec 2022 00:56:24 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m186-20020a1c26c3000000b003cfa80443a0sm11958583wmm.35.2022.12.13.00.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 00:56:24 -0800 (PST)
Message-ID: <a778f7e9-9f48-f5cd-b1b1-2867997f9f02@linaro.org>
Date:   Tue, 13 Dec 2022 09:56:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal: imx_sc_thermal: Drop empty platform remove
 function
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Amit Kucheria <amitk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20221212220217.3777176-1-u.kleine-koenig@pengutronix.de>
 <0df3eb81-9795-a747-8cce-96e6ccd40716@linaro.org>
 <20221213081355.qat43wnbiyw763wc@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221213081355.qat43wnbiyw763wc@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/12/2022 09:13, Uwe Kleine-König wrote:
> Hello Daniel,
> 
> On Tue, Dec 13, 2022 at 08:46:45AM +0100, Daniel Lezcano wrote:
>> On 12/12/2022 23:02, Uwe Kleine-König wrote:
>>> A remove callback just returning 0 is equivalent to no remove callback
>>> at all. So drop the useless function.
>>
>> AFAIU, without the remove callback the module can not be unloaded, no?
> 
> This is a wrong expectation. As Marko already pointed out the relevant
> code path in platform_remove(), having no remove callback is equivalent
> to a remove callback that returns zero unconditionally.

In a previous discussion (don't remember which one) someone asserted a 
null remove callback will prevent the module removal like not having the 
exit module callback but I did not double check.

Thanks for the clarification.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


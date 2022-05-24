Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADCD532B0A
	for <lists+linux-pm@lfdr.de>; Tue, 24 May 2022 15:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiEXNRb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 May 2022 09:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiEXNR3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2022 09:17:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945D19344B
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 06:17:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e28so25065209wra.10
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a2ygfMAPWttk3NX9KoZrm2L1NTEtjK96CkgBXeZd5E0=;
        b=bhdtqRY2lf+APtqsxe6UQbGJHZjCj98ZCSISX2086noM9cjwcY4tqoTbTSPdwhX3wD
         V5ebN5jx1YMwW+KfMWCZuKxf0ab5bP8m65/ZhAQYAOhaq0XIFwkGtIpcBv3+hHbPIQ03
         kNV/4LKT4w0xwbaLmpofSX6YBEcNCI3VetJxm5Kz3/L9BXuVDpvF8JKgzom+04dNx4ng
         vz7cYbV0lwDGYl2QZpfe9rG5qOwLCsgW4W1oqCIQZPJ58Db0Y8B3EUdi86Sf2Iwzqs06
         HcEyvHv1sb4bjw2YsIGNngcwiyyrGBl4O64MJOg98+eE2hHelObn4UZ1yqqt/Idfge74
         97mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a2ygfMAPWttk3NX9KoZrm2L1NTEtjK96CkgBXeZd5E0=;
        b=yiQzouGG5iLuLo2k5+UsQUNU6TlBsDCLxzOmKcYxmbw5beBym6tpuhSfp+bpmDcubF
         E7j5Z5i2eQGq4tnLKf1qO/cijs5RR3NHVfT6Q+eaasJHAtKoWg8PN3ElHcw7RWJ9cW90
         nRgvwUbYmg3Wfv5NhmDN3uQmjm1ekBwCHleJTbs+Yndt6mNPl5qf9dXwDcs1UZc+GFSo
         nCbeqhThBqyWseapOB2147LpKgiT3b/wcu1Hdhhsp6cKwbVq9JX/e1Dqysf0nypvPcbY
         A3yK9M6MOtgJYxHjKgMMGcxLZPnvWQ8qURLQo/XF5dIewmwIlM780OMspaOFMWuDQED+
         5xWw==
X-Gm-Message-State: AOAM5323HqTQpLVccJVSsctBvN+SmIdx1nbgV1+ZatlIfDti0rRH5zjc
        FpM5EnpwRnbaIGPfNgH4qVMlJQ==
X-Google-Smtp-Source: ABdhPJyc/jNlYEcQrDyYQ8TOt0Jj8KmdmxFOUtIADKFtf55OdflalFTUCblfMIURzz2uyGT7tNTSYA==
X-Received: by 2002:a05:6000:1e1a:b0:20f:c403:9180 with SMTP id bj26-20020a0560001e1a00b0020fc4039180mr14933177wrb.147.1653398247008;
        Tue, 24 May 2022 06:17:27 -0700 (PDT)
Received: from [192.168.1.41] (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id p13-20020adfba8d000000b0020cdcb0efa2sm13123226wrg.34.2022.05.24.06.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 06:17:26 -0700 (PDT)
Message-ID: <4ba1d7d2-3e8c-ba60-37fd-9598f415c076@linaro.org>
Date:   Tue, 24 May 2022 15:17:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1] thermal: imx: Make trip point offset configurable
Content-Language: en-US
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     l.stach@pengutronix.de, linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Amit Kucheria <amitk@kernel.org>,
        Jon Nettleton <jon@solid-run.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220516190001.147919-1-francesco.dolcini@toradex.com>
 <20220518085522.3fpzy37kkbkn4hpl@pengutronix.de>
 <20220518094916.GA27037@francesco-nb.int.toradex.com>
 <0006b8cb-b4fc-5015-5c86-be2a6a39be93@linaro.org>
 <20220523143545.GA30537@francesco-nb.int.toradex.com>
 <20220524083514.btjjv6ai6ve74bdc@pengutronix.de>
 <20220524100728.GA99192@francesco-nb.int.toradex.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220524100728.GA99192@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Francesco,


On 24/05/2022 12:07, Francesco Dolcini wrote:
> On Tue, May 24, 2022 at 10:35:14AM +0200, Marco Felsch wrote:
>> On 22-05-23, Francesco Dolcini wrote:
>>> On Wed, May 18, 2022 at 12:10:34PM +0200, Daniel Lezcano wrote:
>>>> It would have been easier if the imx6/7 platforms were defining the thermal
>>>> zones in their DT ...
>>
>> After checking the driver I completely agree with you... But this would
>> need much more rework.
>>
>>> Marco, Lucas,
>>> What about a &tempon { fsl,tempmon-critical-offset=<0>; } dt property?
>>
>> I would not introduce a special binding for it. Instead I would add the
>> support to parse the already exisiting bindings so the new-tempmon node
>> would look like:
>>
>> tempmon: tempmon {
>>          compatible = "fsl,imx6q-tempmon";
>>          interrupt-parent = <&gpc>;
>>          interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>;
>>          fsl,tempmon = <&anatop>;
>>          nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
>>          nvmem-cell-names = "calib", "temp_grade";
>>          clocks = <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
>>          #thermal-sensor-cells = <0>;
>>
>> 	commercial-thermal {
>> 		trips {
>> 			commercial_trip_passive: trip-point0 {
>> 				temperature = <85000>;
>> 				type = "passive";
>> 			};
>> 			commercial_trip_crit: trip-point1 {
>> 				temperature = <90000>;
>> 				type = "critical";
>> 			};
>> 		};
>> 	};
>>
>> 	extended-commercial-thermal {
>> 		trips {
>> 			ecommercial_trip_passive: trip-point0 {
>> 				temperature = <95000>;
>> 				type = "passive";
>> 			};
>> 			ecommercial_trip_crit: trip-point1 {
>> 				temperature = <100000>;
>> 				type = "critical";
>> 			};
>> 		};
>> 	};
>>
>> 	industrial-thermal { };
>> 	automotive-thermal { };
>> };
>>
>> That way we can reuse the existing dt definitions and if no *-thermal
>> child device nodes exist we can keep the original logic.
> 
> Good for me, it's more work, of course, but if this is the way to do it
> let it be.
> Daniel: I'd like to have an ack from you before implementing this.

It sounds like a correct approach, especially that is back compatible 
with old DTs.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5126D33DA
	for <lists+linux-pm@lfdr.de>; Sat,  1 Apr 2023 22:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjDAUkH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Apr 2023 16:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDAUkG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2023 16:40:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D39427800
        for <linux-pm@vger.kernel.org>; Sat,  1 Apr 2023 13:40:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso15884017wmo.0
        for <linux-pm@vger.kernel.org>; Sat, 01 Apr 2023 13:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680381600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=54WZlKFOH7z5ow1TMELZBNq0Ok+OKChGqnAavsTIt50=;
        b=Zi6RFMmsqxCOCubKiabzmroMnsnSzzswgQogx2DJo7nlLLcHzNFfMrQddlDKYNaMMR
         yXrp55GZvc/XtcGNMVmYP/GCiTroSWzEhO+IHGFbz8hYP7MtBK/r+7Tgnq5UKC3Dyr0b
         yDlTqS7Yn2qu6zn5MUIi38OHjc+vjL3DLRs1XDoOu4koZ9hHgIbUHV6PaYHWkYwqgmE8
         z37ad18320vLGNnWT3G9cyrTp1zxRkDz7Zk6T2sc0ChlugqjtKV1NFAHB4d+ByC1FrGp
         fgwB7za1HTwoMHJ7abtg8Y8OwaRbXhqg4KxHnRjx8Z7ztY0WU7hmGC53nS4du9cIEEVL
         2fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680381600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54WZlKFOH7z5ow1TMELZBNq0Ok+OKChGqnAavsTIt50=;
        b=zZG7fnqGp22/sp3CL3ot4shKmY/yJ3oAVE43U/IKqpL4zQdd/PmDwswbsNlA+7WLSU
         vSLwceygObluV0TXz2YwesHqHV8mrejU9oXecFD1UmZQHqz4+anO4tcxandTFFdFawVJ
         ETEtY7ssz4PCkubA+tsSR/6f8lS2ZTghzP6gTmEl74fnvPGYOo4Fl0j8Z3EUT9mqlB7y
         iBHw+efaeScApPUlWlVmcdbbtjor49bu7g5SejnjsH/4kN+PK2sI2QxMmxa+UQTasWLT
         gj5zxnR8PdapllwVPCeC3LvaRHEhU58UNuV4674myDg/YZZH1u3PVxFVhBxdaKEb/OyJ
         9HYQ==
X-Gm-Message-State: AAQBX9fVC/LR61k+D5e8gs+6HRyxsST7/K/TqD0yYThOLK9whk/ilF0+
        ywj/B/ion/XQQe4cH66c3tay6w==
X-Google-Smtp-Source: AKy350agutLAusoP7ESlN2zNEl/9Hx3qYZ9lnD2QfxKiwZHrGUaPAddBOpSu0Jn/T9RctFKUwc2U6A==
X-Received: by 2002:a1c:f207:0:b0:3f0:4f83:22f4 with SMTP id s7-20020a1cf207000000b003f04f8322f4mr83242wmc.20.1680381599641;
        Sat, 01 Apr 2023 13:39:59 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b36a:1186:309c:1f9a? ([2a05:6e02:1041:c10:b36a:1186:309c:1f9a])
        by smtp.googlemail.com with ESMTPSA id m9-20020a7bcb89000000b003ed4f6c6234sm7078132wmi.23.2023.04.01.13.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 13:39:59 -0700 (PDT)
Message-ID: <93922fdb-331a-15bb-514a-2015e65ee4c3@linaro.org>
Date:   Sat, 1 Apr 2023 22:39:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] thermal: amlogic: Use dev_err_probe()
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, glaroque@baylibre.com
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <202303241020110014476@zte.com.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <202303241020110014476@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/03/2023 03:20, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with dev_err_probe() to simplify the code.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


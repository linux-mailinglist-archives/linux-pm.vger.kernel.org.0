Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D78F7AD96E
	for <lists+linux-pm@lfdr.de>; Mon, 25 Sep 2023 15:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjIYNpU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Sep 2023 09:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjIYNpT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2023 09:45:19 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FA3109
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 06:45:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99de884ad25so800190466b.3
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695649511; x=1696254311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=84D7PUCePQFRdDvu62AGfV5k8flmGsh21RMLVVMuFo4=;
        b=ifHFgFtblJYBz/kVUmR/tU+nFN/vzWULOGae1UDTbAWO//v2tLMi98iyUFdFoE6Yvn
         08yCOIbHhyLs1JwYS5dWV8v3DGxZkw7fURiNVF+n2v8NabHgpwOzlAyUQdhIa/5SYpoR
         PFG37m2eK9DG8aew7ZvUTEzOdx6uO3YAElzaflwIZPYRMuvkaHWuQmvxYevGP89ThC4w
         ZYEATY2xjbcBxckEbkK/13dNv09mzrlMcnhrwYmPbzvBCmWjUTQoV/f6K98VozTwDyBN
         d8fhRimdp93+3DXN9Yo2M/GJU1RuT3sSf76rakRqyoB9apLV+qPBwjz/5uK8UN/tYPiK
         h7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695649511; x=1696254311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84D7PUCePQFRdDvu62AGfV5k8flmGsh21RMLVVMuFo4=;
        b=GDjHyvMdLmFc66Z82lUl2ubD8HGq+BJ/aOdf3NrcFyYxJPO/X2iP3O1A13ORooUW/n
         NCxnJ8ArkDu4y1gd3SyQF4wgmZax9uQtV29DfXcYF+V/U8+FSTYHyi6V8KkVMAI9Yt3/
         t/i1VxEazwUJOd8neqSB3wqIl0EwsDeNcdxfRVj6CV6oz0TG859zmagDQU12esGcE4l/
         y1NFOhx4XJRKD9s4WMnHd9fon8HwcY6TmOfWVbBnj1FA3LqNrThb7vinON8QQxSlqmzs
         JO6HZZdt7kjOAtm6Nifejy6FSa4oV/ngOM11/3MAth/+jwUbvxGoXpaKbAahuXqW05A4
         qU7w==
X-Gm-Message-State: AOJu0YwYQD+m6ejm8hW4BBvSOhG6eYYA7tvCRv4PF03a+4U9bkbBiWJU
        pwx/WhEeSpg81jM7qgBDq8wcz1j44uo6gmwVe8k=
X-Google-Smtp-Source: AGHT+IHvPWYEayt34nl/PR7DhItXzsockASsra1AeLMx+QWFmGE2UZXNROAwEZtXhcRI1+w8Rhf+dA==
X-Received: by 2002:a17:906:2258:b0:9a9:f2fd:2a2b with SMTP id 24-20020a170906225800b009a9f2fd2a2bmr4920386ejr.73.1695649510994;
        Mon, 25 Sep 2023 06:45:10 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id dt11-20020a170906b78b00b009ae482d70besm6275624ejb.134.2023.09.25.06.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 06:45:10 -0700 (PDT)
Message-ID: <93cd247e-3491-d8aa-ed02-6c77247023dd@baylibre.com>
Date:   Mon, 25 Sep 2023 15:45:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] thermal/drivers/mediatek/lvts_thermal: fix error check
 in lvts_debugfs_init()
To:     Minjie Du <duminjie@vivo.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Cc:     opensource.kernel@vivo.com
References: <20230921091057.3812-1-duminjie@vivo.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230921091057.3812-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 21/09/2023 11:10, Minjie Du wrote:
> debugfs_create_dir() function returns an error value embedded in
> the pointer (PTR_ERR). Evaluate the return value using IS_ERR
> rather than checking for NULL.

-- 
Regards,
Alexandre

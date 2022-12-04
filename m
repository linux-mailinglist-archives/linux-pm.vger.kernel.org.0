Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92CC641DF6
	for <lists+linux-pm@lfdr.de>; Sun,  4 Dec 2022 17:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiLDQjd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Dec 2022 11:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiLDQjc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2022 11:39:32 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547D1E1E
        for <linux-pm@vger.kernel.org>; Sun,  4 Dec 2022 08:39:31 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id f18so15307567wrj.5
        for <linux-pm@vger.kernel.org>; Sun, 04 Dec 2022 08:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hjauPfl6b9+hDUXiuYoEi7XjS5nDASILjQvzS5BTEs=;
        b=eREZ80dNGNIKy0LQYS28K0koLe6fMSQ399p/GwTe4hxstqNn65DB1ckQufgUGPurSg
         KG2asoldkl2b+UFUE0taDCb+HaCNIniAGWuoutJHcQpwIyyRMfFWwhNQXl+hyBbR81AU
         E8VBkeXT8XMLQlBQJ21hOeKRN36tCeLKcEQeezUYzJ62xvXWxlgIg4wnnEf/aaUOIQpW
         ZhQ0H8ihBvPzLahmCTCk15Boqjb7c6mIDJ3x34veq0PbowR4a61oActaAnXe/KuHc6v0
         /QdLEQFOmcoT8h49NwwoVsQ+BNdkJaSoq7johkulTKs/1QTwZg1wfKBl15R/lqCpfnWM
         Rx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hjauPfl6b9+hDUXiuYoEi7XjS5nDASILjQvzS5BTEs=;
        b=okFTDi8c4CbaQVNlplj4PVXoaLHOL71GDpXOgbIIfUWWOmFRsoqu4BPpNU5S9MEArR
         /9nEWJ1N/O6CBH9ko5Mf9c6YdYz7HgPQsoQ2IjQRfyrwvuU1oHg1EPAGCEFnM5rJ3dMl
         fJSdDpgT03y02GBIeXOlswJz4S+yo1XILvkyV+L+HrKNu0hsPMDKpuQrOuFhVgbBZH2J
         TbpOKGDdubbievte2q03aSa979Y2ooIIqvvUGfQ7CGsdg4/7KvUCvogWZQrkGDU4Mzs9
         W6T0jZZl8kgu0ol1X7L/rWYnFCbS3Iz3goaOkCXAXWgzOa26r5SP/CcObwRFUSwOTf+H
         EtkQ==
X-Gm-Message-State: ANoB5pmf2rQgywY4dcyCNi9/6DOPnY4trG7kNgu0BVUsbkTq+hZJjQYt
        kDZddQQZrHRAPKHVBHa8JIrXkg==
X-Google-Smtp-Source: AA0mqf62CxDeqJaJzT6Vbnb4tyoIdln++K2Im02dq03xOgBnDhGLJK2kLuo27+yA2/uX8ARrrh9vjQ==
X-Received: by 2002:a05:6000:884:b0:241:b92c:6d73 with SMTP id ca4-20020a056000088400b00241b92c6d73mr36378271wrb.242.1670171969845;
        Sun, 04 Dec 2022 08:39:29 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id p33-20020a05600c1da100b003d070e45574sm15720740wms.11.2022.12.04.08.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 08:39:29 -0800 (PST)
Message-ID: <93cc7011-176f-b90c-fe7b-036afb945555@linaro.org>
Date:   Sun, 4 Dec 2022 17:39:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/1] thermal: imx8mm: Add hwmon support
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220726122331.323093-1-alexander.stein@ew.tq-group.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220726122331.323093-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/07/2022 14:23, Alexander Stein wrote:
> Expose thermal sensors as HWMON devices.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6116449E2
	for <lists+linux-pm@lfdr.de>; Tue,  6 Dec 2022 18:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbiLFRCc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Dec 2022 12:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbiLFRCb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2022 12:02:31 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A232A416
        for <linux-pm@vger.kernel.org>; Tue,  6 Dec 2022 09:02:29 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d1so24361645wrs.12
        for <linux-pm@vger.kernel.org>; Tue, 06 Dec 2022 09:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6TfdMZJx6YwYGMzVOHSPGcZQcm/YvSKhyLP6Zb9LW3U=;
        b=f8K+WmGUuSv8KswBqRGfezQk9LzOPL2MIF5hXavcrXyDmnppRVRbUmum7GmqK0ilHd
         e7i/rRxDuNaug60YHu+zo1baN8lGd+/QKrT2dRibC6K7zbh/KdMAm3HwrnxQjC50YDKi
         OsL4WLNJeo5ssdO0AsAeZiovFmmE1hI9YNlgEi/xwQ+Vh57UnCHDY9sKit0u6cMlebVH
         DFNJt+KjeAeFoNFGqv+ooLw1JWXUCaDuj7xJLIw4Nx3kEPjVOpFG62qXyWAjX+2+wvnL
         lnlor2txuaOFufx+UQkHYeBF9q2vguDA6pBj4/m3k0iC+nCdeT+MsrMJ3BeKOBVuVZfc
         b24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TfdMZJx6YwYGMzVOHSPGcZQcm/YvSKhyLP6Zb9LW3U=;
        b=Jpdcvl917cC4yUO41vcTH75f1WAOzmbM8aHrb5XlP/9EaHHJIUWUmXsqkoFi6ceN8a
         3Dv9nkc7qh5saee300W6OyOaMQGa3YYR0k3ETsTS7wTRfBXs9/xxHlHJcuz6KmbJjlYI
         kX7HgpGa6axhxyg687jszA7TdpIlcsZUTXmzIPo+8uSoM8gOSwrzTdq/hWrJGuJcZo97
         Ok1dzvgU/yR02E/oEKlGb/KJDxAxOwcXO9uj7z604g+Itue1En0t0G/R6K7rg/CYPUNJ
         h6oLhIv/14Ijt/sHCN+ZzMnb3qo7B8Thq+mOV60qIZCycw6TFLCwiZ0ZSbEvwj/ZacZn
         NQ0w==
X-Gm-Message-State: ANoB5plNLi2TghbDcQ+Rh8ItIXigvSetMBc2gwXZ/vTP3kcXZrIM8Jua
        gtVv9hJcoX9VFHKhFxbvFNoBnA==
X-Google-Smtp-Source: AA0mqf42cYPf54pb3sxtziLBo7bdoS9uWV6Lhv4ERuK8x1zeExLMMZE086K/IaYZpTuoyHCqCnHi1w==
X-Received: by 2002:a5d:4810:0:b0:242:4cf5:f391 with SMTP id l16-20020a5d4810000000b002424cf5f391mr9902226wrq.174.1670346148292;
        Tue, 06 Dec 2022 09:02:28 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id w12-20020a05600c474c00b003b435c41103sm32934264wmo.0.2022.12.06.09.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 09:02:27 -0800 (PST)
Message-ID: <617ffbbe-5043-d27f-6579-d5f5544f03d1@linaro.org>
Date:   Tue, 6 Dec 2022 18:02:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 00/11] enable VTM node for all TI's K3 SoCs
Content-Language: en-US
To:     Bryan Brattlof <bb@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, Linux PM <linux-pm@vger.kernel.org>,
        Device Trees <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LKML ARM <linux-arm-kernel@lists.infradead.org>
References: <20221031232702.10339-1-bb@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221031232702.10339-1-bb@ti.com>
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

On 01/11/2022 00:26, Bryan Brattlof wrote:
> Hello again everyone!
> 
> This series enables the VTM nodes for all of Texas Instrument's K3 SoCs
> 
> Most of this series updates the k3_j72xx_bandgap driver to conditionally
> map an eFuse region used by the j721e to work around an issue in its VTM
> implementation and allows us to save the SPARE_FUSE region on other SoCs
> 
> We can then update the device tree bindings for the driver and finally
> define the VTM nodes for each device
> 
> Thanks for reviewing again
> ~Bryan

patch 1-6 applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


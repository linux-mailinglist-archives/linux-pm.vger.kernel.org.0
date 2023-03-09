Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A622D6B2AB2
	for <lists+linux-pm@lfdr.de>; Thu,  9 Mar 2023 17:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCIQ1d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Mar 2023 11:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCIQ1H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Mar 2023 11:27:07 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54105F8280
        for <linux-pm@vger.kernel.org>; Thu,  9 Mar 2023 08:18:40 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id i34so9147250eda.7
        for <linux-pm@vger.kernel.org>; Thu, 09 Mar 2023 08:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678378639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nfkr47uMkCiXVxXdwdLHVRDx52SBPipOfF4MJ+yNxeQ=;
        b=f2GNQOaSEYn2K875iDD1m+O+ehA0xtEb0yn0Y3GjyxfPFIVnmb4tThLnnJKqnSaMj8
         zDHzpMR77KKioLJkBdpLg/PaYCp7Ws33K4MsmI2FEGrvDP3tsZokVnZk5WApoMrNXE7M
         yPggHYe+D7cqElZgjppZi2/tpChF2SOt7Jd4bMjQ/D5m9zbVC464kiwTsblIXJjsBn6X
         WPqhPaKdcPtxHoUGn0o+fDAIB+RZwBKO0dphMGn7MybHHohoqL06AXkS9nNmBDGgD+MU
         QV0pEAaMKMlvDL1d7aLYKg4eHzthZ+X21YrEGjI353q3yfZuOanAv+wYH/TBDb871Zf2
         Z0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678378639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nfkr47uMkCiXVxXdwdLHVRDx52SBPipOfF4MJ+yNxeQ=;
        b=kNMuOQvAY5OK6Hx8SmiqrF8P/G14f6JyZJFIyXOlbbMUxmqNvtEOpSDSXVezoA/C+x
         HKCuvE8xWgUJ0GUiEkbiVUUVk6JiFappdGtf5/UPBPB+q51nR13PLHRVCvxYf2QKNenz
         8rDSHTqUYilM2M0qZKIdtmLs/SSbB1HGYePxwlOYc0kO8LzqH9mfZL8I/uGTAADkOWVE
         Aqk5nEx2OV0yiuAj3KP7b54OZknIgX07/ghtSjQnSSe/3KrQBlZGFmwURwWFnbVg2sw9
         S62WU1+3WqGLxjUMbL/eFRR5WPMrkovNg2WRArIG9cDTkJH1mnOGYZNQQpvbNUqw9jCe
         r/zw==
X-Gm-Message-State: AO0yUKVCmkgSSzpVEipmX9NMRspTn0ksJ5HQTmKJyGHPGpgcI3A6aH0o
        C0lga+d3DSAZDyNv0S4yPiGITw==
X-Google-Smtp-Source: AK7set9tLG7OqxL36Iw+EQSmEvEdnsYuLYCe5O2o6Pafsa9Ob3uXQyp15aFbfmwbSFuiC7AoVMAwgA==
X-Received: by 2002:a17:907:1c1f:b0:884:930:b014 with SMTP id nc31-20020a1709071c1f00b008840930b014mr28489263ejc.6.1678378638898;
        Thu, 09 Mar 2023 08:17:18 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id dc23-20020a170906c7d700b008b17e55e8f7sm8977100ejb.186.2023.03.09.08.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 08:17:18 -0800 (PST)
Message-ID: <1d7f051b-761b-df8d-4407-9c6c3d95cf51@linaro.org>
Date:   Thu, 9 Mar 2023 17:17:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/4] dt-bindings: thermal: mediatek: Add LVTS thermal
 controller definition for mt8192
Content-Language: en-US
To:     bchihi@baylibre.com, daniel.lezcano@linaro.org,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230307163413.143334-1-bchihi@baylibre.com>
 <20230307163413.143334-2-bchihi@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230307163413.143334-2-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/03/2023 17:34, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add LVTS thermal controller definition for MT8192.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B91572DCD8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jun 2023 10:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241659AbjFMIlU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jun 2023 04:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241662AbjFMIkl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2023 04:40:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C15B199A
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 01:40:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f8d0d684f3so2033185e9.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 01:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686645627; x=1689237627;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNiICPsLQLIgFEOjAZE7SmBkD5zH7qfRQmETS3TMEtA=;
        b=eSmsgf9fjF/TSYZCNneFweS+x2xAzcFBp/E4Jnq6I/bXUrC9r6x5pGyx52+kM+M27g
         3IlTpZ2S88CCKS9NXoJmUH7z8mPhMblDrbIBizobA6VG5nJW2R1S05WjFPGMKp7aOkYM
         HvItcOnShrcUlL+CBtHP7ZRG3VFbPAxAk+hOieQ00z6r5DuGgQorZCng74pv/+NZu+c9
         P/iPmA1pGpxVwYLku/outN50DM/tIXsBV1t04fBDb0bSxI3PXtE0P6mRHqKztE5ahE4p
         5shdVpQ0Q3i2yX90M4Eh8aI2UFXNaH/dETqzEuTm8uonqviul+XQi6lAAL+X8frfdojX
         w/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686645627; x=1689237627;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNiICPsLQLIgFEOjAZE7SmBkD5zH7qfRQmETS3TMEtA=;
        b=AZFd1E0MQYGda/WBY5ORdB4zcXs+g5UXpx+qw5NH37wdNLc/F2ZOzhcCMzjgPsZhdI
         wq04QTy679ZMcpBLF0eupNphfsZ0CKC+7OAh3glzpDi80nD+7JBwFRTWORyXOcT+hzou
         GF777pqYaBdQuli6IgBZPhalyjqU2v/ERg7FuyDD6fKUfr8CvBPqFMad8jg/TMzsGt6R
         Gf2vdkY7Vf37xw1eYiaImtziRIXPLaeFhsiPCNenjiyMl+S/gYFDrQBVbO2IbRQoVSp7
         aMAXyXk3dxZL9/GOtm8UafRVJsae5Fbs1tv+Gt52M2X2eDvfQP6HNRC0v+vpgAeoHlnI
         +OWw==
X-Gm-Message-State: AC+VfDzMD/7RUj7gz6edhhn1M2nFx4qpMO/GFqPx5MB5wMiKp+/WtX8x
        /j+c9bIZu68y3TdfoIZZ4UYYlQ==
X-Google-Smtp-Source: ACHHUZ4NEZA3RKdwcGEdV6TgpfyHraQdHx4D2B3hpjdE/u7c9ynnZ19MNLHZ8/g+4k1ruSevyU5iBA==
X-Received: by 2002:a7b:cb90:0:b0:3f5:878:c0c2 with SMTP id m16-20020a7bcb90000000b003f50878c0c2mr8143809wmi.3.1686645627468;
        Tue, 13 Jun 2023 01:40:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b5a8:28ff:af00:a97f? ([2a05:6e02:1041:c10:b5a8:28ff:af00:a97f])
        by smtp.googlemail.com with ESMTPSA id o6-20020a05600c378600b003f42d8dd7d1sm13809957wmr.7.2023.06.13.01.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 01:40:26 -0700 (PDT)
Message-ID: <2b73ec3e-43e6-4fd0-034c-7541b6f53443@linaro.org>
Date:   Tue, 13 Jun 2023 10:40:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] lvts_thermal.c: Drop error checking for
 debugfs_create_dir
Content-Language: en-US
To:     Osama Muhammad <osmtendev@gmail.com>, rafael@kernel.org,
        rui.zhang@intel.com, angelogioacchino.delregno@collabora.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, amitk@kernel.org,
        wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230530172439.13683-1-osmtendev@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230530172439.13683-1-osmtendev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/05/2023 19:24, Osama Muhammad wrote:
> This patch removes the error checking for debugfs_create_dir
> in lvts_thermal.c. This is because the debugfs_create_dir()
> does not return NULL but an ERR_PTR after an error.
> The DebugFS kernel API is developed in a way that the
> caller can safely ignore the errors that occur during
> the creation of DebugFS nodes.The debugfs Api handles
> it gracefully. The check is unnecessary.
> 
> Link to the comment above debugfs_create_dir:
> https://elixir.bootlin.com/linux/latest/source/fs/debugfs/inode.c#L451
> 
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

Is this patch tested ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


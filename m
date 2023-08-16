Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689DA77DE63
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 12:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243830AbjHPKTL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 06:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243892AbjHPKTG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 06:19:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8DD198E
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 03:19:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-307d20548adso5630608f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 03:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692181144; x=1692785944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qcvp3MWwwx4QbPrWpcXGYed0ndxGMfH/Koz4hMKrwps=;
        b=S+foF+R8oCFzohvuJtdcYYZYxMNRp7rc4emBvG+zAzOeSMM0LYGiIiXMOJPUVQ0o6+
         rOsr/+5eRlvUIHwc2b/REGLOhfOxMyZnsinXcBuItdaUT+irisHXHMwzHlFqcpLaNEPn
         s6/SRymq4SYLwpc+VA6agIzt0DV+tmfnjLLstA3EeeIP21uzf4gAv4E4/5G3pqhu7Fe9
         0S7r88egy37O6xZpn/M2dqMBJTruBhbGsu04tOXvHBNQZWFdCYz3DJrpvjlwMfuf23C1
         JY4rpMhKiueE7DylEG3rACJWK+HfwHAhCihKhdVM6kUGH0fm5No1qQ0qifUU14USqy+I
         1JgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692181144; x=1692785944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qcvp3MWwwx4QbPrWpcXGYed0ndxGMfH/Koz4hMKrwps=;
        b=IDF78WiRGwCYsixG5odZEFy27T1Jt5PQbRBL7hEWwSjVpGfYuZxe5c06YG0H4fkwa9
         DjxGzYfXPAQRJHgNB3XJkigo6HyYNAQqBLp0sQ044mxLfXIounav2Opfl64I+2T6CpIM
         qkcQ7wZkb9jnqpiXKT+olkKfae2jfV4IdZIZr9EAEWnOofs9oMB85sM2ZdcFI/XH/LcK
         CoRGUCQJi7+anoLsuGlzqbkTCQbj3XN/KS8peyXyVeEMX4DaB72BUthunnCbnNo5KtU8
         gJ4aXLgIH3/jZq7T3xC9F0YZR3b2IvrwkLNiAAkAqvCTkD9LyP9wRsTToEuE+A4TFOs4
         suVQ==
X-Gm-Message-State: AOJu0YzGw5GtIqL3upX73MElkbCWOvCS5PQBi3aTwdwsAu5iCcsZv8cs
        t5nUUXlVOL1etTkk7sc7swyEjQ==
X-Google-Smtp-Source: AGHT+IHXh6mc9GDHoDPjMXKS+zm0Ku+ago7fw9nHpNBMb9LXW5TlFwS3GTmVOoBqFdNZF1nfYzSjBw==
X-Received: by 2002:adf:fa90:0:b0:317:55c:4936 with SMTP id h16-20020adffa90000000b00317055c4936mr1204930wrr.9.1692181143939;
        Wed, 16 Aug 2023 03:19:03 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id y7-20020a5d6147000000b00317e77106dbsm20763190wrt.48.2023.08.16.03.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:19:03 -0700 (PDT)
Message-ID: <e2659dd1-9c60-a815-1263-a837c0e137fa@linaro.org>
Date:   Wed, 16 Aug 2023 12:19:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal: k3_j72xx_bandgap: removed unneeded call to
 platform_set_drvdata()
Content-Language: en-US
To:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, amitk@kernel.org, rafael@kernel.org,
        alex@shruggie.ro
References: <20230810112015.3578-1-aboutphysycs@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230810112015.3578-1-aboutphysycs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/08/2023 13:20, Andrei Coardos wrote:
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Also,
> the private data is defined in this driver, so there is no risk of it being
> accessed outside of this driver file.
> 
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


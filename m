Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB766C44DC
	for <lists+linux-pm@lfdr.de>; Wed, 22 Mar 2023 09:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjCVIZc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Mar 2023 04:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCVIZa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2023 04:25:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01FD14EB2
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2023 01:25:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eh3so69448202edb.11
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2023 01:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679473528;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nHHBsgPcqoQXv3IcnxrVjy+sbpU6VtUmrNRMJlsrD0=;
        b=NpflurRqiUYKopD7KIHpNLoR5YvWeMLnIYeI2l0cZGSjpgJUP+kZYxeTpZbPVD4wII
         +TWHTPWMqOFr+l5dxZ/z8jP59hyLu48X6C3huhXbLLQWBxylYVyPTYAvsouRCe4aaxZc
         c2qY7qz5ymlqdPZ758sjXJhQGMgjQ0HcYhKl1VWnPXfcRy7xSLCo+l6MxpK4eqjVZymV
         Uc8GE0drVRIhVLEE+XYVTaFV2uFUv8XHPtf1z7MXFcATnNkSRxzsYxkEtMXEknouZpGa
         gZoOr/FoRAwfEEkCVOrCw+T5hxb/bpnH5iVMl9q/Km4CVgaUjAduls5QLFcIumaHQ2bP
         dxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473528;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nHHBsgPcqoQXv3IcnxrVjy+sbpU6VtUmrNRMJlsrD0=;
        b=CJkbdlfjtMeFMLbtzXnFm47aBjSUxSrayHP0VIN5CXNy7AcSeKUvlw4I91JTgWBHZn
         c4qE7imL0269zGrM+z3zn9s4tz2KTYMb2i+1nyZVvZvGC1vu3yHXJSeXLfIqfiRj4hvR
         mYEiR2J9uhsTK5lU9We974u1WI2RBnre56/7s0h3M8CVrSMRxz73U3aepPL7RWEfh064
         nq76BcOAImCqcJuSbXjZt/3SCm+8CrrQHvnk4DDDXmSLvVezeiPavjM7qYDup/1TdXkq
         1H/MwUDGuuPyOJhPHcoD+EPhoy99qMg9EFg4Zux973DVU/eQZWOxrks+IBQJ0ny8r2tk
         tCCw==
X-Gm-Message-State: AO0yUKUXb89csGrif3iaiqnGllHWG8LZDkX7rBu/2BFh9oxMNrjTDct1
        63hO656OlmM8N/m4jlHm+Et0ew==
X-Google-Smtp-Source: AK7set/ax3+09r7oIGAkbTOKrf/V2QVQAWE9pGnIkMxFOPEYcn/hQHTOSOa4OK5LgciOw1TKWuuCNA==
X-Received: by 2002:a17:906:7c8b:b0:931:624b:680c with SMTP id w11-20020a1709067c8b00b00931624b680cmr5697043ejo.29.1679473528257;
        Wed, 22 Mar 2023 01:25:28 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id u6-20020a50d506000000b004fd2aab4953sm7339300edi.45.2023.03.22.01.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:25:27 -0700 (PDT)
Message-ID: <ce89857a-53b3-d63b-c1ad-5d28fd7d8f80@linaro.org>
Date:   Wed, 22 Mar 2023 09:25:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/8] regulator: max77658: Add ADI MAX77643/54/58/59
 Regulator Support
Content-Language: en-US
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     Nurettin.Bolucu@analog.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
 <20230322055628.4441-3-Zeynep.Arslanbenzer@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230322055628.4441-3-Zeynep.Arslanbenzer@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/03/2023 06:56, Zeynep Arslanbenzer wrote:
> Regulator driver for ADI MAX77643/MAX77654/MAX77658/MAX77659.
> 
> MAX77643/MAX77659 has 1 LDO regulator.
> MAX77654/MAX77658 has two LDO regulators.
> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>



> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id max77658_regulator_id[] = {
> +	{ "max77643-regulator" },
> +	{ "max77654-regulator" },
> +	{ "max77658-regulator" },
> +	{ "max77659-regulator" },

Why do you need so many entries? They do not differ.

Best regards,
Krzysztof


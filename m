Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E4954B8CA
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jun 2022 20:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiFNSkK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jun 2022 14:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbiFNSkJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2022 14:40:09 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761D041F8F
        for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2022 11:40:08 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d13so8430129plh.13
        for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2022 11:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VMRLILcAuZfWHWL4+u5qy2fvXJUzHg7ML+JvyBdPww8=;
        b=LPePoEAd2RE5ad+qpang/x6MBZQqe8c+MY+oskJDKl0FP/nK6/UyH3T057+2dwVI3y
         jrBBsALPsRmcs+oI38K2y3wHudZ5VZg5K5mP9B0b57TJQ02kbio5YVm4Av5UWlW8Y569
         oddEFhMmMWOSO/CMHBNLXqr7HG+5V4wktBFzbDZ13TxmMOeDSyfrtOMoZitQzBUHTozt
         M1KNFkFERB9TFGK47pGCCxTGN+WS2E85nbhjZ7hSt/pll+OsxuZTX3Vx/MxH5uAlNVL6
         8wgZY8rIEydCd4lRTcMWHE6o8kiIt0sT76aCWth48oJzRMsFiVP9pUbCHQY6FwOLV9A8
         n/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VMRLILcAuZfWHWL4+u5qy2fvXJUzHg7ML+JvyBdPww8=;
        b=1YMu/ICBwmseDu6T2HNKixixYr/V8PFsJdy1WzTn88w9G2NVuHeyo2i9rbD8s38DFN
         ZTu2YEnk69zdoYmFX22w2sXGwzNKd6rY9xjvkjM5R7iYMqnzA6oKMfOf4a6P3CABtgb3
         1oWuf/YM0v3w9Nt0peW1yVjAJ5zx/6Oe8nR/kaFAD5F3DGAl/zy4nsNQGUrpYG4LKPjg
         XYvOd53YQ7A12f+zVzumOnfyFgQEMjqpaxQW2eO1/DKf6Wki3QkX2N/DaTgPY09gX/+f
         ZG/Bo0rqIhF8PpBSQd7XrYK0S3SM9aRJoAPVJIPAFWfjrl3AkL8xNB/hrz/7eDKmDXz+
         D0bw==
X-Gm-Message-State: AJIora9QYPeNZMQ8Nb7OPhMPk5ndGI55CZDQGYYW/CdusEQkkwDkWcLX
        eNNKxnHqWlDA3X3tY4JV07LDwQ==
X-Google-Smtp-Source: AGRyM1vbSe14m+2wgDQc5pjjUBxKw2CUwxdD7eoFuL4AQSdHu3ZD+H5HuZM3i7A/ctCS9wllK48y/w==
X-Received: by 2002:a17:903:32c4:b0:163:e765:5071 with SMTP id i4-20020a17090332c400b00163e7655071mr5579647plr.153.1655232007923;
        Tue, 14 Jun 2022 11:40:07 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id y9-20020a170902864900b00168c1668a49sm7584558plt.85.2022.06.14.11.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 11:40:06 -0700 (PDT)
Message-ID: <d427ed94-facf-e0ed-50b4-f4471fd0adfb@linaro.org>
Date:   Tue, 14 Jun 2022 20:40:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] MAINTAINERS: add include/dt-bindings/thermal to THERMAL
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220613124309.28790-1-lukas.bulwahn@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220613124309.28790-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/06/2022 14:43, Lukas Bulwahn wrote:
> Maintainers of the directory Documentation/devicetree/bindings/thermal
> are also the maintainers of the corresponding directory
> include/dt-bindings/thermal.
> 
> Add the file entry for include/dt-bindings/thermal to the appropriate
> section in MAINTAINERS.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Rafael, Daniel, please pick this MAINTAINERS addition to your section.

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4080672A63
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 22:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjARVZQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 16:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjARVZI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 16:25:08 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601775D13D
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:25:07 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o17-20020a05600c511100b003db021ef437so2551840wms.4
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TWd6+wNJKKjYQWcD6g2sjIQKybHqKELFrBmWsbQqh4=;
        b=WFNuPZTWGv27KxhKGjRd/0jgFflCDzUWk/ctctvIRI5pEKMFlDM1zYkrnxkfVXDfEY
         AG54NNr5tSVqEzOcgtP66u0qFrVzKgir/D/eXBNVomXXmL/gZCW5ESWnFeCi0zBjcJKJ
         S3b69EqXqqq8qyaBArNn3BGMFgUJFbfnr2a2Jdjc+l4VmUmKMgn9A/MiLsrFtyDd9G/E
         68bfoIDZ97Q2+B7rmCVswfNul2oa1Th4jLW8vosJDIDJSyv3n3NCaKtbljT2uEDBTI10
         gJe0d4H3bsuBy47LLlNubLmXDA4/hwWuyJXjCnFRsLxqhWwdUMqPZr+aNTONLMZVJEbQ
         Ycjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2TWd6+wNJKKjYQWcD6g2sjIQKybHqKELFrBmWsbQqh4=;
        b=cOfkPRdVEyGd1O+vq9SyOGZonsURHjLU6XpFva9jNl36VVt4/BeCfeeifh5+WyGsqk
         9F6mf/yKwVCqfHfleK2EkPlolrwLbc70Anb2XObfzLq/3lMJv5hD9CgzF7K1kjUOo9Hp
         REbzveKZ/tbbYVMrsLph4984w25MSFz6puHkxOS3Vt1Tii4xLA1Kibl7jDlPvOFF1b6A
         MdjAxP5z12WgU+OiTUj7HWjuB1KwjqWScVmCQwmh3CyO5rLwmM5q4LgCknpEzq4nRjTX
         9ImuD9zURsgX3CWrOTrwzgnMWFq+N7DGiOSR5At24/h14xrsZmiybIgi9yLG7Son4rYk
         +yfQ==
X-Gm-Message-State: AFqh2krfIgv5D58IesFauJz2/ezzauJt2WH9lS1JewmgGXaTsx+m9sz+
        j9grZGqB5/KrH6/9k+V5G06wMg==
X-Google-Smtp-Source: AMrXdXuC+FctSFrD1vCtm5tKuX/l/TWFDhoYAKOni2z3jHEv755mY0dIPzncHyhVXpfWnrMfNkCcmg==
X-Received: by 2002:a05:600c:3b07:b0:3d1:cdf7:debf with SMTP id m7-20020a05600c3b0700b003d1cdf7debfmr7773498wms.26.1674077105876;
        Wed, 18 Jan 2023 13:25:05 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id o2-20020a05600c510200b003c6f8d30e40sm3356061wms.31.2023.01.18.13.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 13:25:05 -0800 (PST)
Message-ID: <ac238fbe-fe8f-3866-034d-6d784dd9543d@linaro.org>
Date:   Wed, 18 Jan 2023 22:25:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_thermal/drivers/thermal=5fmmio=3a_Use?=
 =?UTF-8?B?wqBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Language: en-US
To:     ye.xingchen@zte.com.cn
Cc:     talel@amazon.com, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <202301181641194943741@zte.com.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <202301181641194943741@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/01/2023 09:41, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


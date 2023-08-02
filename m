Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0606D76D06C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Aug 2023 16:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjHBOq0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Aug 2023 10:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjHBOq0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Aug 2023 10:46:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3C11BE7
        for <linux-pm@vger.kernel.org>; Wed,  2 Aug 2023 07:46:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-307d58b3efbso6163456f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Aug 2023 07:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690987583; x=1691592383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ymWK9bG9jdEZyfPNHsibJ8r0dEZV7nyeVovpnCCjU4E=;
        b=MS/eRg1LH4J6sqfCdTGOObLmBMKX3Zet1rZvgYRXzSNCYvwIT0eRXeqm4pS9I2fSA9
         pjv0qEecirVnMRykRwxSLNhC9r4Pwkf+lMPf1vgXnHixWYnRPni6I3rIRsF3WZf0UE2S
         imEgFVL5TxArUAFTFLwjn5bdt7DldVY6TZzjScCxN+lDKJOFoEGVi9adeNvA4ipEC8rx
         hST65/qL6H0Bx8fi0hHJMQP6wE+7ABt+YLzeuroL4p5RR7TJXqoekJtYuQxp88D8NyM7
         1zCUWpR1Rlv3ofBm+puH+EJxDLgF73jRpg8eHryXIC/9qhmO/MCOH4BqMRi89DE+D6cg
         fYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690987583; x=1691592383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymWK9bG9jdEZyfPNHsibJ8r0dEZV7nyeVovpnCCjU4E=;
        b=QA8Hz4wKIOTGlsmV0tE/0kTtfOFuO7AzMt1coV/3/OIDhkMzKnpEI/1qByMH5koaF7
         aaMFN/Qt9ak8kLwdE2fOmwYtyb0gvGZRKEGlaYrWpNm/30mhHsXttVT/hc3EcLL46IRr
         szsQKEBwL38OSNpFMpJDOxoH6blQjjn9D241ZAwA5WbXawYICu9cWFgsHCU/Hwrorznl
         X0jhj7SDR+YpZp1v4+Nx97F9+XPCGukNDBNjf21ebpLa1lImv5ehWeuz0IR6wipYKunO
         Q7hZvCpxaQ6aQ7pPimkBCuifnq9KjRpYvXkpMLFkpibVZL8qS9vxrO7SZ4z7LTdiUNKw
         7iSQ==
X-Gm-Message-State: ABy/qLaqEaH6V7mKFtMSaLerk+XB95AOl4xV6T4jq9ySkXgNYKHic0It
        paYwFXKQTsjMZ4jwjuPSyNwCZW12F9Und83C00dJeJzE
X-Google-Smtp-Source: APBJJlEik+21/qO5gHn30TMPlcz4FvOsr1Stw8tMO8x3YC5D9ioAMQjPr3GeUZv0HTxSF3288HsQDA==
X-Received: by 2002:adf:e70d:0:b0:317:6fff:c32b with SMTP id c13-20020adfe70d000000b003176fffc32bmr4796013wrm.53.1690987583345;
        Wed, 02 Aug 2023 07:46:23 -0700 (PDT)
Received: from [192.168.1.14] (host-92-17-103-66.as13285.net. [92.17.103.66])
        by smtp.gmail.com with ESMTPSA id f11-20020adff58b000000b003143aa0ca8asm19099646wro.13.2023.08.02.07.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 07:46:23 -0700 (PDT)
Message-ID: <add4d151-c202-d7b8-f946-929eb3b1244c@linaro.org>
Date:   Wed, 2 Aug 2023 15:46:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] power: Fix uninitialized variable usage in
 smb2_status_change_work()
To:     Yu Liao <liaoyu15@huawei.com>, sebastian.reichel@collabora.com
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pm@vger.kernel.org, liwei391@huawei.com
References: <20230802023130.2516232-1-liaoyu15@huawei.com>
Content-Language: en-US
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20230802023130.2516232-1-liaoyu15@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 02/08/2023 03:31, Yu Liao wrote:
> smatch warnings:
>   drivers/power/supply/qcom_pmi8998_charger.c:565 smb2_status_change_work() error: uninitialized symbol 'usb_online'.
> 
> usb_online is used uninitialized whenever smb2_get_prop_usb_online()
> returns a negative value.
> 
> Thus, fix the issue by initializing usb_online to 0.
> 
> Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202307280638.556PrzIS-lkp@intel.com/
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org
> ---
>  drivers/power/supply/qcom_pmi8998_charger.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/qcom_pmi8998_charger.c b/drivers/power/supply/qcom_pmi8998_charger.c
> index d16c5ee17249..cac89d233c38 100644
> --- a/drivers/power/supply/qcom_pmi8998_charger.c
> +++ b/drivers/power/supply/qcom_pmi8998_charger.c
> @@ -556,7 +556,8 @@ static int smb2_set_current_limit(struct smb2_chip *chip, unsigned int val)
>  static void smb2_status_change_work(struct work_struct *work)
>  {
>  	unsigned int charger_type, current_ua;
> -	int usb_online, count, rc;
> +	int usb_online = 0;
> +	int count, rc;
>  	struct smb2_chip *chip;
>  
>  	chip = container_of(work, struct smb2_chip, status_change_work.work);

-- 
// Caleb (they/them)

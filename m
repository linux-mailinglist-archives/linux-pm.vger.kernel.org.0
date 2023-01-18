Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB80C6727EE
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 20:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjARTO4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 14:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjARTOx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 14:14:53 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6548053981
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 11:14:52 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so2133681wmb.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 11:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3mWqMucuGpq8fv9a5lwN/fhw44RIjCbRAJRCKFTDUqs=;
        b=lsYStuKsDR663Oyni0zWaIKP5UQb1ItCfwdjCu18/DhZaSoZryUhIVUSOcsv4kMxqy
         mLZY19LQvMNGCAyfIB/wteTMhCsoZcvsg9TJ0cirKsviUHf08NyKoqUoBY0budmGIdgD
         oQ4n8gSDohWZGfu135zjyAxFfPzZTcefIRvD3R2u9qmW0lgWqq3qrU+Ebn1N7PM9btX8
         f6VlyLFRnwAt7AC5Ut3wwOuHvxjNf9ucCv4FajfjPz29C9d98hHGP3fXrMGV5neFSXuy
         s4VKAF1FZa9Z3ays0zg9It6Dq61bigbYecL1i0rhnVRqlBmCzxjlGPc+rTCKdUqpv1G3
         jd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3mWqMucuGpq8fv9a5lwN/fhw44RIjCbRAJRCKFTDUqs=;
        b=iesGAa/v1bPUuaz+jcIPAWP4lk1Up6STEqZ/MWLPfSIePUFax3YytrNze3VfoLhUE2
         Vn0Dg3l0WOYIFVdRH9s8yP4hqvz5smXf9DMCbet2WzaDGakYEXrt2dD8h95p7fV0VcIZ
         nllDk5CFQ2ogBxu8DbVM2CyhGJVoDWs1md7VaG7q5nNfjPGqc4yLVHUZHWhpnNAjsZjd
         MbMvmD+MgsUFWC40sbFaPWxSOG9nXFdgNQxA/xOhZViOdaaKTe322X2kf1CpxcQUcFlp
         zSoM3rwgonw6KTpNxak6bogcmyPKvDjSSDLeBkhdVOwqoax9FAMb0ZqdCnS215cAIyZ6
         jxcg==
X-Gm-Message-State: AFqh2kpdkOTNHAXtIRUeju+CS4CXpLPfQ92+ru6fHkTTayDBDPsnaIeq
        gExrdLm7NybDTcJyhK6L9+S+tw==
X-Google-Smtp-Source: AMrXdXtwRrohFTxHYrnzeZNvNBXFuLxJ8FGzUVNk+ZVtv0rBx2bX7rxjxsdTUxbaVd/KqOCQEh4CPg==
X-Received: by 2002:a05:600c:4e14:b0:3c6:e63d:adaf with SMTP id b20-20020a05600c4e1400b003c6e63dadafmr7468399wmq.31.1674069290907;
        Wed, 18 Jan 2023 11:14:50 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id q10-20020a1cf30a000000b003d1e3b1624dsm2703278wmq.2.2023.01.18.11.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 11:14:50 -0800 (PST)
Message-ID: <098e960b-d2d8-92e1-4401-23402ce33e5e@linaro.org>
Date:   Wed, 18 Jan 2023 20:14:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 0/3] Thermal ACPI APIs for generic trip points
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
 <f76c13de-d250-ebc0-d234-ccb3a9ce3c28@linaro.org>
 <2627c37e07dce6b125d3fea3bf38a5f2407ad6a1.camel@intel.com>
 <5aabdd3010a02e361fbbe01f4af0e30d11f0ae6b.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5aabdd3010a02e361fbbe01f4af0e30d11f0ae6b.camel@linux.intel.com>
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


Hi Srinivas,

On 18/01/2023 20:01, srinivas pandruvada wrote:

[ ... ]

>> The whole series looks good to me.
>>
>> Reviwed-by: Zhang Rui <rui.zhang@intel.com>
>>
>> But we'd better wait for the thermald test result from Srinvias.
> 
> A quick test show that things still work with thermald and these
> changes.

Thanks for testing. Shall I consider as Tested-by or do you want to test 
more ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


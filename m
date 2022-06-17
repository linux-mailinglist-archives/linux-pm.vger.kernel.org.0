Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC78D54FDBD
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 21:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbiFQTgs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jun 2022 15:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiFQTgs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 15:36:48 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7607A59966
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 12:36:47 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q140so4836341pgq.6
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gG+jqViWEs45yJkCZnV2xTv9YCGXnKCFEDvuitfwlf8=;
        b=jCInQDC2pP3j7Ra2AuZL/mre+/4GdQoDEZ1DM7x2suGYH/ih1PqcA45Ed8uRzV8sWo
         BkFdc4fqIskGzYBiLy43cJnaanbijKxFJZr/s4TDka4OXZbTeD/rdD/4zD8TyTEUtFLi
         0YcBwatI0VWdUM0RSw0Xoig53lA3lS7GOFCH0ViiZuz32xzg1oyk3Ms1wCiAWCRu9C6z
         7mmIq68VMYhatTPPN56KW0mJSGDJeZ7dlc1aSxsSpviSriD1VCEjV+claufldXI134Yb
         qkSaftq4kcyoW2TxsMBpXO0W6T/Zgiq9Ui1+Vrb1fKKxTaoIzFNAB82WFeD4/+8+J1Hh
         WQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gG+jqViWEs45yJkCZnV2xTv9YCGXnKCFEDvuitfwlf8=;
        b=r4i74/UklATor++xyVZaEg9CBc5hQ+B5QKTxrwg1B26z6GgTqgepqGzIOkuxX6dP3U
         ay/8J4XUtf2lL5nV5CRaW+T7UIFrKBqyer4M7Jf2BXb9TiZD7RTsoWMkjPcQJAAzc467
         W+4HADm+z43c25cSy0K19GRgEBuScdTZkmAVOD2HzWvTAH6tHamAkD8M54bXGEloDVbz
         Wr8Gi58WSZRNM7S44qnd3L23RIUlOAdzGn1f3EJXBreQpdbruuBvLbkcioNoXUpE3ztj
         XcOcl6FCXcFQZBjeYfY5OLLYhHiEEjaG/H591I/ZnoeVu+5hNsatSug73pkYjgGI91Vn
         VsVQ==
X-Gm-Message-State: AJIora+RAtIxjrqGPbGUnvpNIgy1Hdv5UI3DcLkoMOXnd/MoQM45lAvK
        ho5GvJqTk+8fAkm+KiIb9kLZHocHnSQ=
X-Google-Smtp-Source: AGRyM1sE+5nA/3rHoi/eNATccw6ybZX7/vDjYNQ9uS62uE0g5K5aHefzjp5ugxc7WeGjaXXIqdZ8WA==
X-Received: by 2002:a05:6a00:124d:b0:51b:f2ac:ef8a with SMTP id u13-20020a056a00124d00b0051bf2acef8amr11763825pfi.72.1655494606889;
        Fri, 17 Jun 2022 12:36:46 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id gz24-20020a17090b0ed800b001ea90dada74sm3623309pjb.12.2022.06.17.12.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 12:36:46 -0700 (PDT)
Message-ID: <1b38d764-109f-0ed4-bf71-b96a71471280@gmail.com>
Date:   Sat, 18 Jun 2022 04:36:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] PM / devfreq: passive: use HZ_PER_KHZ macro in units.h
Content-Language: en-US
To:     Yicong Yang <yangyicong@hisilicon.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        linux-pm@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, daniel.lezcano@linaro.org
References: <20220610075428.62268-1-yangyicong@hisilicon.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220610075428.62268-1-yangyicong@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22. 6. 10. 16:54, Yicong Yang wrote:
> HZ macros has been centralized in units.h since [1]. Use it to avoid
> duplicated definition.
> 
> [1] commit e2c77032fcbe ("units: add the HZ macros")
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/devfreq/governor_passive.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 72c67979ebe1..a2cf6c6a1a39 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -14,10 +14,9 @@
>  #include <linux/slab.h>
>  #include <linux/device.h>
>  #include <linux/devfreq.h>
> +#include <linux/units.h>
>  #include "governor.h"
>  
> -#define HZ_PER_KHZ	1000
> -
>  static struct devfreq_cpu_data *
>  get_parent_cpu_data(struct devfreq_passive_data *p_data,
>  		    struct cpufreq_policy *policy)

Thanks for the fixup. Just use capital letter for first character
of patch title as following: 
- PM / devfreq: passive: Use HZ_PER_KHZ macro in units.h

Applied it.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

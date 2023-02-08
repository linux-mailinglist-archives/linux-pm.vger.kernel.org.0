Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8499968E749
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 06:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjBHFER (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 00:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBHFEQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 00:04:16 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A5E206A6
        for <linux-pm@vger.kernel.org>; Tue,  7 Feb 2023 21:04:15 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id r18so11892116pgr.12
        for <linux-pm@vger.kernel.org>; Tue, 07 Feb 2023 21:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XfGha2jBR7nbX6HKLcuXsRFKDkIwgWc3pCTulMIV25U=;
        b=crDzTJh2i0tbVRr2WCHRYHyQnXGgkFglLCgzNSNN+tvm4Ak6zvRdfPRiRy2/QFsCM1
         W7wL7+Jdpii9VpEGcM0gj2jOJmFaGVod6fS+Q1G/8Bun1btbmKiCM2fwjp7t/TZdkD1q
         BPNMgWRJGIJaxgazCL3+UGtaiMSKMwnuTLWEpyQtc79fDSLWhjlv4kej/eysjXXdD0rq
         DeDlpu695/Je/McDRTLJbvMoWGkFJVAW5amBKNew/J7ELIX1iJWmrkVZ8eUXm6xzUuhY
         dLTdKi9HZ/432tqZbZenMx9DVWZrBDdl2Revn+1xf/uPTN6JsdK2v3LP/rORoCuBoSnW
         jmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XfGha2jBR7nbX6HKLcuXsRFKDkIwgWc3pCTulMIV25U=;
        b=KLObgzzyUKae4PIjPxOcYRsj2yU1BOsF1wBFhwhZIazT7IqGbYGSM0KMPVtaGSF3pU
         Cztp7IcKze5IBddv7/2hadcH1P4gV2aX8E4qV2dcIfM5vUg6azNs1P+6J+GbGnrx2lAE
         Y73eSniRt0CW58VCpV4kuA2hMUO3ybskLgXOQ3fqs7VnXTz7Pj7U7scpm/c97oEunshl
         INcqn7VVSKrj5MuinkpJsCD3/jqOuXoTNVd7hw1yUWCJfzQ/9fcFrnfB9wTfWJellna3
         IAir1vmwJ+X1GOaXHgSTOKsmzuGp4cCxmUWDtElewxXzoRn/j4egpjW47hsQrFBvQOjv
         6dsg==
X-Gm-Message-State: AO0yUKVetVYjzZS5/PRygB/wMUyFwtPVpDbX0+Imn5Fhp2CyHgvFrUSv
        vnI87j/5bw8X4JAiFWnBwTE0iQ==
X-Google-Smtp-Source: AK7set+Xl6SEZHkpKzc+nQxQgc5MHVrA4DBRhIvb1+7sazlqe29I5G/BnML+D+zFn7xgdE4s2f4I2Q==
X-Received: by 2002:a62:524d:0:b0:590:7678:27c9 with SMTP id g74-20020a62524d000000b00590767827c9mr6210392pfb.7.1675832654495;
        Tue, 07 Feb 2023 21:04:14 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id x16-20020a62fb10000000b005813f365afcsm2872256pfm.189.2023.02.07.21.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 21:04:13 -0800 (PST)
Date:   Wed, 8 Feb 2023 10:34:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Make kobj_type structure constant
Message-ID: <20230208050411.2byi4nfsfiyakfyq@vireshk-i7>
References: <20230207-kobj_type-cpufreq-v1-1-c7fa2dbd0754@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230207-kobj_type-cpufreq-v1-1-c7fa2dbd0754@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-02-23, 19:58, Thomas Wei�schuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Wei�schuh <linux@weissschuh.net>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7e56a42750ea..ceb1574417f9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -993,7 +993,7 @@ static const struct sysfs_ops sysfs_ops = {
>  	.store	= store,
>  };
>  
> -static struct kobj_type ktype_cpufreq = {
> +static const struct kobj_type ktype_cpufreq = {
>  	.sysfs_ops	= &sysfs_ops,
>  	.default_groups	= cpufreq_groups,
>  	.release	= cpufreq_sysfs_release,
> 

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

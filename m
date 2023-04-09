Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BC76DC210
	for <lists+linux-pm@lfdr.de>; Mon, 10 Apr 2023 01:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDIXz1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Apr 2023 19:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDIXz0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Apr 2023 19:55:26 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ECC3598
        for <linux-pm@vger.kernel.org>; Sun,  9 Apr 2023 16:55:24 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6375ec15c48so113889b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 09 Apr 2023 16:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681084524; x=1683676524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SON/w6LDQiDETPiGQ/zl8VHnkF1L55Ud/Wk1KLsgG8A=;
        b=EtGPFhdcuXTvwgsRWu5qu/5US/kBdtVKAhT38aPBS/m83gxoHx6fLpw+0jCs2r+A0E
         +xkX0G4fBwbc+seWDmAGTQdIF3hyTYtZ4TzAJgSCR6xjroaj+2i9YFyoP2RYVYACR1X4
         IYug6Omyv7LMQpAaLlNuuvwkWrk/gifFft6TeTUFdssPykECKxI2sPInOweXB3ppVCpQ
         rfe2YauA0RXWiA9QPRjbKdMKKcyyje/Qu9Gby8ue37kk26Xlb14MU+0q8rML3VLjCIIr
         pmrV12JZYVACyCIh7ZcxX1+/DcP3LMqP87hh6T/c5ofy0Q3kRu8TAGTMlkjemqZ23UVZ
         rvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681084524; x=1683676524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SON/w6LDQiDETPiGQ/zl8VHnkF1L55Ud/Wk1KLsgG8A=;
        b=srAGZrpcVFBN/W9AwBhcnfgZ0CwFGImFsIXt1BvTKeIsnc3aovOamhp3Uw13HfETFv
         PgOOoR64DCSOWH0ugwJDKCJYy0idK7niwYneQCa5g5nxzmqNzZxpDTFj/GbJwg+v4871
         BQ/AjpI1Fy+jcHPiX8YITfQa64l+Ja3Ef/LC3/5Ua/nfU7ChYjiifeDl+o9/D/xiD1Ac
         kpSHRFaOdqjkkNXjSyMkN3CshCo4BLIGU5OefqK2wRBSbP9HiwcDIB0uT4ODydGteU8a
         Ej2K8GohtHH3th1/VuqqTy0WF6UlwIe/afySA/SVcMqK0Qmpeps5nabPDxxsXSSlIDCw
         xD6Q==
X-Gm-Message-State: AAQBX9dnl7dLIV5cXEElYqjz85KqE6m2/weRJPw74Imqrso8k4t/QHTg
        nKgR28UDrlmeoSqcIW9mXa4oWQ==
X-Google-Smtp-Source: AKy350bs+7Fe/k1n+5DbGgX3YEcQTx8p4gKmmgjFpwNNT25FSioHdZDpK5OB1qGF465jxSpcBK42dg==
X-Received: by 2002:aa7:9ac7:0:b0:5a8:bcf2:125 with SMTP id x7-20020aa79ac7000000b005a8bcf20125mr9106011pfp.21.1681084524282;
        Sun, 09 Apr 2023 16:55:24 -0700 (PDT)
Received: from localhost ([122.172.85.8])
        by smtp.gmail.com with ESMTPSA id x25-20020a056a00271900b00636caef0714sm1307236pfv.144.2023.04.09.16.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 16:55:23 -0700 (PDT)
Date:   Mon, 10 Apr 2023 05:25:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: sparc: Fix exception handling in two
 functions
Message-ID: <20230409235511.7xxqdxsqtflrhifk@vireshk-i7>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <b3cce5b3-2e68-180c-c293-74d4d9d4032c@web.de>
 <2d125f3e-4de6-cfb4-2d21-6e1ec04bc412@web.de>
 <20230403033529.x6n3ihhkypwizq3b@vireshk-i7>
 <39342542-9353-6a7b-0aa9-f9c294b158cb@web.de>
 <20230403230432.xeubpa3cc2gt4mw3@vireshk-i7>
 <68b1988b-987f-fa2b-111e-b1b42f9767ab@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b1988b-987f-fa2b-111e-b1b42f9767ab@web.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-04-23, 19:48, Markus Elfring wrote:
> @@ -337,21 +337,17 @@ static int __init us2e_freq_init(void)
>  		driver->get = us2e_freq_get;
>  		driver->exit = us2e_freq_cpu_exit;
>  		strcpy(driver->name, "UltraSPARC-IIe");
> -
> -		cpufreq_us2e_driver = driver;

This changes the behavior of the code here as "cpufreq_us2e_driver"
is used in us2e_freq_cpu_exit(). If some failure occurs after a
policy is initialized, and driver doesn't register successfully, then
we won't set the frequency to the lowest index of the table anymore.

Same with other file.

-- 
viresh

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0DB50F350
	for <lists+linux-pm@lfdr.de>; Tue, 26 Apr 2022 10:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344511AbiDZIFU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 04:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344209AbiDZIFT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 04:05:19 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68472FFDC
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 01:02:12 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so1548894pjb.5
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 01:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sY4O+RzpKnSGDKBPK1hz7c+s2+2s7DFvtQjl7kYI0kE=;
        b=km6eMTt1CnWFml1Gs1AUXYBobJZVkLujTH/tO/pU5SLaZN0ICyJbWPIkkcnemP/QA1
         uBGCV124HoS/Wh6KMj8Bu5BtDPoVSaPwQ7dogVw/boUrG5lzVOGygFntdpO43BdeWIgj
         mxEaGybKihC0VtzCb6lYr93OCVqwOkho4lehtZ5VCebI10At9BdrvMWR+10mBHXGdSMu
         eRb9Ee3pU0RYRT0AaKZxOsEo8wJSsATJiI14Dt8w0Tma082AQrxFKQp4EkHJa1kZV9J5
         ulbznt8l8ertyQxeTNzl+cN3GzGbPl0x5KktVuuQ9FpUKMbsiDEBftTmcS5EaNPBpoa9
         qCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sY4O+RzpKnSGDKBPK1hz7c+s2+2s7DFvtQjl7kYI0kE=;
        b=awKM++DtVjnUhac6rlIgb25rZn1zTfKG9inl7jtOcXI9DR3Q5501MDFmAy6AtcRcRe
         pXv8yK661Xg77qR4/hNw4qiE51ax+6/2R8+fQQeePzcFCJQgVknyCb0wTGxiZmDx0ar4
         4sqc0IopoLx/ppz0QQEK78zUCl5nBZNNOoQ8p+U3jop1TcLoLaxyWNIXsCmcAurrDjGv
         3MgLnvB3wXsf4mC2CNtVc1lyVI5hp6c2tf1UzIYEWIB1Vco/PCFiEUGyS8Lt05/3hIrE
         0ZDk9E55RjhuMUg3EwB8TkpRmhP2wykeLwVbrl6lGryu1FrNwzJmnYe6uTkSxGSeDYre
         KIMw==
X-Gm-Message-State: AOAM531xYTLFqqEev7+UI2W/cdexNrR+DrtM5+MST38N7t10e/82nAwS
        UgOKmTuFEtk2yWuCcqXYaPYfkw==
X-Google-Smtp-Source: ABdhPJzmefDjeFZNT16cNedZlqvBpDb8CQECn14oYN1fVVbtSKAEykCNzNcCSTqTrif4lsSBsUKE4g==
X-Received: by 2002:a17:903:1249:b0:154:c472:de6b with SMTP id u9-20020a170903124900b00154c472de6bmr22548931plh.38.1650960132296;
        Tue, 26 Apr 2022 01:02:12 -0700 (PDT)
Received: from localhost ([122.177.141.190])
        by smtp.gmail.com with ESMTPSA id w123-20020a623081000000b005056a4d71e3sm14145005pfw.77.2022.04.26.01.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 01:02:11 -0700 (PDT)
Date:   Tue, 26 Apr 2022 13:32:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, amit.kachhap@gmail.com,
        linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/5] Introduce Cpufreq Active Stats
Message-ID: <20220426080210.hvzrsa4kmxesn6dv@vireshk-i7>
References: <20220406220809.22555-1-lukasz.luba@arm.com>
 <20220426031125.ozaxwecwvuby6wo3@vireshk-i7>
 <f6bb20c6-38a0-57d6-8979-d14e445da623@arm.com>
 <20220426075402.qjpato6sqy2kes4x@vireshk-i7>
 <9eac86b6-0221-0f62-ac4f-f9e3b1613422@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eac86b6-0221-0f62-ac4f-f9e3b1613422@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-04-22, 08:59, Lukasz Luba wrote:
> :) but I didn't dare to make it sysfs. I don't know if anything in
> user-space would be interested (apart from my test scripts).

Sure, I was talking about hierarchy in debugfs only. Will be useful if
you can show how it looks and what all data is exposed.

-- 
viresh

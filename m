Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11714E5416
	for <lists+linux-pm@lfdr.de>; Wed, 23 Mar 2022 15:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240717AbiCWOQp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Mar 2022 10:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237026AbiCWOQo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Mar 2022 10:16:44 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF1A78049
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 07:15:14 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-d39f741b2bso1801732fac.6
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 07:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DFtEmgZVX6NiJWN1EIlkixm8UH2mcAaGVWOGdvWx5L0=;
        b=iNO65oB/mp5isctZY+S65CnNbLX41ffwYCjiATwqO+Gd9wrBD8tc6M3rRSqP37ym7h
         2VdY5gkRH2zWLfOr00I8JLckRLHV1qdgQoxHgr8EQ5zVJs/1o8L8vzCWYGF+S2DEXN1+
         VS32nVT3W4MElcYv7u+XznxYCVd5LH4m45R48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DFtEmgZVX6NiJWN1EIlkixm8UH2mcAaGVWOGdvWx5L0=;
        b=zLci5jqeX0niwXQ/5OGy9estQNTWOAIGo0V9AZD5IwYD1DumtdmMlNK3AV9Qs6ODD0
         VT2TCuAW+pflrT5A/jOSK+b4U4B8ZmkuQz0LyCylFAj+N7Df6QiIzdgMrnaPt0DmZYc9
         DhrG7vbUwJDVYQjt/w2e/XgH4fLnKAyov/5MndkKgz5v8z64jg7dFXd7P24pYipyW39W
         6jeVPLweYFIWjVkdsH82sDCWnauxT/xKjVkbpdF5yKKsxEh96itvwzTsmH8mHdD8oGE6
         DAm3SIT017W4DfZZDFi7uiIqHKEMC4pwsaWp5OdtT0QvLymfdSxDsryh1QBI5kDJesCC
         VFFw==
X-Gm-Message-State: AOAM531TRcQb2h2KFZt2PuOhjmky1slFGtrAa3nfEfHorHoJuDLR2SUw
        Jysbo3tcdBZqS6HuwXRHowBdVg==
X-Google-Smtp-Source: ABdhPJyHvOHu8vwC/q8Dg1feQn4ailDPfpY521LQc4BTzjQ8YDa1POhIV4BsRDI+Ay5k+Jws/Iuw5Q==
X-Received: by 2002:a05:6870:898b:b0:da:b3f:3246 with SMTP id f11-20020a056870898b00b000da0b3f3246mr12866oaq.246.1648044913585;
        Wed, 23 Mar 2022 07:15:13 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id gk6-20020a0568703c0600b000de4880b357sm2264202oab.50.2022.03.23.07.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 07:15:12 -0700 (PDT)
Subject: Re: [PATCH 2/3] cpupower: Introduce a new unit test module for AMD
 P-State driver
To:     Meng Li <li.meng@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org
Cc:     Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220323071502.2674156-1-li.meng@amd.com>
 <20220323071502.2674156-3-li.meng@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4c13d97e-1471-5642-39dd-d381fa441753@linuxfoundation.org>
Date:   Wed, 23 Mar 2022 08:15:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220323071502.2674156-3-li.meng@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/23/22 1:15 AM, Meng Li wrote:
> amd-pstate-ut is a kernel module for testing the functions of AMD P-State driver.
> 
> It can verify the required conditions and basic functions of AMD P-State
> driver before integration test.
> 

Can you elaborate on the need for a kernel module? It would be helpful
to know tne value the mdoule adds and why it is necessary. Include
details on why it can't be done as part of the user-space program.

I am not saying it isn't necssary, I would like to know the reasons
before I review the patch.

Also if this is a driver test, why not use other test frameworks
such as kunit or kselftest. cpupower is user-space utility and
driver debug code would not belong in here.

thanks,
-- Shuah

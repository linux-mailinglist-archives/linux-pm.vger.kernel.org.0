Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826FA41C9FE
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 18:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344020AbhI2QYG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 12:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245575AbhI2QYG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 12:24:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB76C06161C;
        Wed, 29 Sep 2021 09:22:25 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i25so13112720lfg.6;
        Wed, 29 Sep 2021 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CcWRHT628g8uLLrXHcaoMAVejqE4eYmkHN2oa1pbhm8=;
        b=OtcTySMa5bM6txuOtQ6WAclsYjcJ5p3+2QB9ao3AQEkUrT1SekyoveZvxQdcrKWz05
         1wU0uLX+fBUDneV4YZGPp+783zPJSsxb81m8dLY9Pd5Eske33EK6UxZOQ9M2IudDwuqk
         HhED0FTxqkK1qSbVuue9dEwzMo7lKYj93NVLP2qf3alSUKGVkEiywhtWsv5Rk3Oyie6n
         tQSTF7DW/VfihFvd1nljtfXLwOgm1f6tSqxbkpZrGo8nMNCkbsZuYfdDZOGHTfL0k3Bu
         dbgho6tGJjwUwyjHiLU/p3RrS1p8cFJS2T/4mu7hWUaaS/u/gw0InSC8RuXjClxYWyDD
         xfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CcWRHT628g8uLLrXHcaoMAVejqE4eYmkHN2oa1pbhm8=;
        b=e/eJ30u32gN7r9C1PpnJcpHOh9nKV2QUhCsbdSwl2hq2B5Sz+n4q1sw4XHxXKsnw1m
         MnCBI3q+iNZFb0k8NqqqOMPrY/cnNVJFLGoqo7E2uHhHwaq1GB5KKt19HsHy69Cmp7lA
         Rz/zfgzAFFYU40qcQu6W7/VcHKqURGtWg154bAtSnY/koml5Y0dUJq2YHqpTJqKFEsER
         vs/7d8kUVn9z2sPgOxsPF1tK1Pl9Cmm4OokHEpTI0L13D75NaLkHhEDRuwHHE1nQYMqs
         cYDCdJ4O24CPRrfjtdv5y2xXXbDjs/a7p9XhzvNmiBIpvLCi+T6KcbOIcFykm0OIo6XR
         rCdw==
X-Gm-Message-State: AOAM533fOhTh0qYOrQc35Ta+fjivy4xNV1EnJ/BPl9KahYauF7mlwNOQ
        38CDwf8/mx0IXgdBMu7bhE+uj/MuVGw=
X-Google-Smtp-Source: ABdhPJwT9hESx5WAv7KuHP3/jNKV9R4zJ7va3JfHYmxp1yM5pwdEgVGj8jpRsvLeJr5APP0T4jQHkA==
X-Received: by 2002:a2e:6f1d:: with SMTP id k29mr777666ljc.209.1632932542411;
        Wed, 29 Sep 2021 09:22:22 -0700 (PDT)
Received: from [130.238.84.122] (emp-84-122.eduroam.uu.se. [130.238.84.122])
        by smtp.gmail.com with ESMTPSA id l13sm36937lfk.211.2021.09.29.09.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 09:22:21 -0700 (PDT)
Subject: Re: [RFC] add standardized attributes for force_discharge and
 inhibit_charge
From:   =?UTF-8?Q?Nicol=c3=b2_Piazzalunga?= <nicolopiazzalunga@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-pm@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Thomas Koch <linrunner@gmx.net>,
        "smclt30p@gmail.com" <smclt30p@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
References: <21569a89-8303-8573-05fb-c2fec29983d1@gmail.com>
Message-ID: <57e605d8-e59e-1c58-78ee-7248e97b9e90@gmail.com>
Date:   Wed, 29 Sep 2021 18:22:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <21569a89-8303-8573-05fb-c2fec29983d1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Hans,

you are right, I swapped 1 and 0 there of course, my mistake.

Nicolò

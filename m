Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB05047DF3C
	for <lists+linux-pm@lfdr.de>; Thu, 23 Dec 2021 07:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346674AbhLWG7P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Dec 2021 01:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346671AbhLWG7O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Dec 2021 01:59:14 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E25C061401;
        Wed, 22 Dec 2021 22:59:13 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so2716659wmc.2;
        Wed, 22 Dec 2021 22:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=7rTDzbdFUFK7GKusqP/JZXHXtXUlNZ62iT+tZRNz+dg=;
        b=SXoHnTuPQDi9Jju5amOmhy1Eujd+uiotnYMUp6grUUiWVS+EZzj3oySBXLxiGyCPA4
         8gkJNsjRm0Z7nEUkxNgINiYhmOzHBQXioWyNL9AwjILONnmfUUzDP+KMwjF47VDBndSK
         RSAjomBFYuMvvPmbSdaJg9gCthHvb7k42dhIbph6sjnx0Sn+mIQN6qzcCSYu9KTXw19t
         JTqTolWkkt46GfshbJFQEqmLjB54PLF30ZwesG0B8EL8D6B66Hyd0P/mAXQ9wbBcgf26
         YjQK9g833fa+ZEqNKhHwvKGdJNrFzFU16GL9JbWzoKYQ59UM8n+HIBRslNhkvmJcDtPL
         7K8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=7rTDzbdFUFK7GKusqP/JZXHXtXUlNZ62iT+tZRNz+dg=;
        b=69+vEonIRYL4J5RFik9CVYSMIPDx8FyTaoVQ/lnwGHmQ9hhRK7ekjRT9M2C+F18qnz
         kwNjqcGIND1Z6ruJWqNjp23NGZ6vC2zyJ2qdDzQ0rmb/F5i33BBumL8U9Hz//NSUu5oq
         4lKScnKGuKBxJzw/A+yHiyo1gtHpE/0vrYxKWAXZlG5lPTH7BDkMarn942x46jyW75vw
         lW0YOXJw2sQPx2EExKwGHcnui/BWh1t2V1VghY6u2cRzPfwS2bR7Qf1lcIAqRcL9gfge
         plqQwRShNH7PBca3l3CEL3zPsYB3LIic+B6q3CaWRn4G+rml+g7XLF81g55NOgBZDDCR
         jJ4Q==
X-Gm-Message-State: AOAM531/Bo3WVWXgNPvISwMXuw4tbZE5GXtMtm8PMCIj68jZHPvWZP+T
        kePidZfSvfPkcrVdZNQp2eD/WXGDzy0=
X-Google-Smtp-Source: ABdhPJx7UL5AdRz+b7OrXZdyDMozqYvEf+baGSn1nuJtQnRtn15jTSAPileLY9WLX6atkJ9Avh2eZA==
X-Received: by 2002:a1c:23d2:: with SMTP id j201mr751942wmj.76.1640242752295;
        Wed, 22 Dec 2021 22:59:12 -0800 (PST)
Received: from ?IPV6:2003:ea:8f24:fd00:91a0:6ae6:f368:5418? (p200300ea8f24fd0091a06ae6f3685418.dip0.t-ipconnect.de. [2003:ea:8f24:fd00:91a0:6ae6:f368:5418])
        by smtp.googlemail.com with ESMTPSA id w21sm374413wmi.19.2021.12.22.22.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 22:59:11 -0800 (PST)
Message-ID: <8dd55bd0-ccb6-ea4e-5679-51f88925c40f@gmail.com>
Date:   Thu, 23 Dec 2021 07:59:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
References: <0edfdadc-336b-657d-5566-beeb4f4343ac@gmail.com>
 <CAJZ5v0gps0C2923VqM8876npvhcETsyN+ajAkBKX5kf49J0+Mg@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Annotate pm_runtime_resume_and_get() as __must_check ?
In-Reply-To: <CAJZ5v0gps0C2923VqM8876npvhcETsyN+ajAkBKX5kf49J0+Mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03.08.2021 15:07, Rafael J. Wysocki wrote:
> On Sat, Jul 31, 2021 at 11:36 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> Seeing an erroneous use of pm_runtime_resume_and_get() in a patch I wonder
>> whether we should annotate this function as __must_check. If the caller
>> doesn't check the return code he doesn't know whether usage counter was
>> bumped or not. Therefore I see a good chance that this results in a usage
>> counter imbalance.
> 
> Sounds reasonable.  Please send a patch to make that change.

It took some time to fix the callers that use pm_runtime_resume_and_get()
w/o checking the return code. Last pending patch is [0], all other fixes
are available on linux-next meanwhile.
I'll submit the patch to annotate pm_runtime_resume_and_get() as
__must_check, so that we hopefully can get this into 5.17 (incl. pending [0]).

[0] https://lore.kernel.org/all/ed1ac2f8-5259-684d-42c8-effdf2920e78@gmail.com/T/

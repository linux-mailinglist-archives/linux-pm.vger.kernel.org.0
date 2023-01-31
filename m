Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BB368320B
	for <lists+linux-pm@lfdr.de>; Tue, 31 Jan 2023 17:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjAaQAd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Jan 2023 11:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjAaQAc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2023 11:00:32 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4774DBF7
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 08:00:30 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so10980763wms.2
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 08:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hIWF6+rDNwuec/a/FmTrKbLY7Rx4X05xxp2R5XVAmaQ=;
        b=tqU8FM8I89gU05iRzo1MYBYTs83zOlqhYvFDzk4kgZgIPep1UW1CSnDpwHmS1nyQcg
         GPFyafo9RrzT1Pz6q2cQ72ZqRYpzIINIb614gYtYRsDRl6EA0FPU0pWo7FamKSHPwmVF
         Hx/atZglgRepg9StSaiQm4/cGqQijUOOi+wxrKs3xiP7PvuBG/ArSd/MorNUNmqSWUSc
         pGxUyaBO/8bCvDbI1THOr3Ne8ZVcrycbRbjZafahl5g84PJ+kq+8QW3ElND7IMgkad5K
         g2aVhdtkN1kg9vgWzgkjCCq9DbxsUdbwf7AJozZ1diqIbm3XyhKWJWnU9LE1UShUstTT
         hqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIWF6+rDNwuec/a/FmTrKbLY7Rx4X05xxp2R5XVAmaQ=;
        b=idrLqtGdPzHh1t5HDP4UTkkjjNjVQM/+fI+m0E6/sXi4FHjh5ziiLDLb0Cln2lzeqC
         9iOILX76npcSRcNFLk7EVH1qLbN79t17/bVnqc7zvL1PTGf3m2ietk6KsQ9jEyxeMlJH
         pOYXyV0fRXfRgDnv1maqviZNECaQ4K0taZ9HApdd5wDOe3F5NNvEtEfxnvtolTSoIEca
         O/3+sVZ/SGcDzPz0Sh+QeKehUvRqWBTa1N5FVxLHLcYLL6w5fBgw3Sn6T319JkRszn/A
         3+n+9k/CsYmlc5ZgFTNLP5Oe+ah83KXP3M67xIL62RVVdzA3ba3974ZFsqY/gNEIr9PL
         /VlQ==
X-Gm-Message-State: AO0yUKV2kKiEPiEU8e0VzkjKK5w99umh9L730yv2LxiWwB8U28pUw6gt
        rXFy41WH/xWV3fKMYUsht45Y/w==
X-Google-Smtp-Source: AK7set99xSHSAfywQRdJuIeJGyCNdOWw0pOZh/gGppvNbxWCJR3SYprGc/fzAu+7TQaVMF4qOUhGHw==
X-Received: by 2002:a05:600c:3552:b0:3d3:49db:9b25 with SMTP id i18-20020a05600c355200b003d349db9b25mr4192651wmq.26.1675180828705;
        Tue, 31 Jan 2023 08:00:28 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m7-20020a05600c4f4700b003dd8feea827sm2160265wmq.4.2023.01.31.08.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 08:00:28 -0800 (PST)
Message-ID: <00dd9051-a6df-820d-1824-2c5a25dcfbcf@linaro.org>
Date:   Tue, 31 Jan 2023 17:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 7/8] thermal: intel: intel_pch: Rename board ID symbols
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <1751684.VLH7GnMWUR@kreacher> <2144306.Icojqenx9y@kreacher>
 <03b213dd351605d34f3d2ebc29fc3795cd2a58d2.camel@intel.com>
 <12166249.O9o76ZdvQC@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <12166249.O9o76ZdvQC@kreacher>
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

On 31/01/2023 14:08, Rafael J. Wysocki wrote:
> On Tuesday, January 31, 2023 12:17:55 PM CET Zhang, Rui wrote:
>> On Mon, 2023-01-30 at 20:04 +0100, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Use capitals in the names of the board ID symbols and add the PCH_
>>> prefix to each of them for consistency.
>>>
>>> Also rename the board_ids enum accordingly.
>>>
>>> No intentional functional impact.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C13B45A6B0
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 16:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbhKWPmT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 10:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbhKWPmS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 10:42:18 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBB7C061574;
        Tue, 23 Nov 2021 07:39:10 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so34289071otk.13;
        Tue, 23 Nov 2021 07:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pZP84rGDQfIlxway4qqlI3Z/NoLSkf0mKY5sHSXBqIs=;
        b=cusKE08jTZgcetM2oJDXVLht0Igo15fB9rtAg9nYffiihUF/46Tk/YZrdjSwffhBMm
         G2r49R/iXjNnoRsJrTDpWCVFSOctjbo/9XNhRF0rXoRXkqA8KcPT5GSi4/x0EFPc4wbN
         E60xTCAG/VBqBk7RKASqPojBJ7DZdzy6PeMK2GT2KBSAzooYEgJ4V6nzVHiSlfdZ/m6O
         j7To9/31FrMQesUUPFiCjGS5GhCe4KxbFDeuXy712/G9M5rbKdaPlHdXsToZ67kAFO1a
         uafK3+/aIM5Lxy0EtCGLm7A7cVbgK5HET3z8v+OGieyMXWQA0yP9hL+hLzEvIaeKZBWF
         5JqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pZP84rGDQfIlxway4qqlI3Z/NoLSkf0mKY5sHSXBqIs=;
        b=qCU3Ae/XFv6s9QppnxixamVvimMZN43EJiQGcJpYAZYGIPCmIZgYrNcniQH5k8Fg+W
         sdgorR6LKILBAIe03TrUwRuQIDIrDRGU+pS2PWnK/nnOaIm1qpA0qPTSKWBMbyajdCIB
         ltmsEDhRs30p/ZowTgqFzTEDAJQhDnVE2LUlArKtAozCkFifgkEuctDVnkmp3osKjDap
         tlUuCdMwzkcMLQG7Jpb1BYXhQjFltmUhqR2uKHVB3bMyKEFqkDxiyq7RpCtXdQQwlYBc
         xRCLtxNEniR6Zd5GcSqJC3Vh4c3r5E6thlZlyRku96xqDtz9tyaDV1GfVNTD8H3T9j99
         KBHg==
X-Gm-Message-State: AOAM532baVc/ThUZR1AteeTV7VIQW175yygL/WWVfgAGLUc5B8YGN5bv
        LIFU6vSB7hI+zfH4rPp2Ch4=
X-Google-Smtp-Source: ABdhPJxRURELdzcv9o3p3x4E2ucXnwb1I3nImlDQPydk63Pp/LVd2gRlnQarBhM4bsKP0Wf9TqGZWA==
X-Received: by 2002:a9d:12f3:: with SMTP id g106mr5284804otg.175.1637681949600;
        Tue, 23 Nov 2021 07:39:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f7sm1983501ooo.38.2021.11.23.07.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 07:39:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Alistair Francis <alistair23@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>, lgirdwood@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rui.zhang@intel.com, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-hwmon@vger.kernel.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
References: <20211110122948.188683-1-alistair@alistair23.me>
 <20211110122948.188683-4-alistair@alistair23.me>
 <20211116000634.767dcdc0@aktux>
 <CAKmqyKPFOqWD7t6tC1Act97CVcY+yazrhwMLLr3j_wOyH50GTA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v15 3/8] mfd: simple-mfd-i2c: Enable support for the
 silergy,sy7636a
Message-ID: <00d68181-ad3b-17d2-0150-00029d399f0f@roeck-us.net>
Date:   Tue, 23 Nov 2021 07:39:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPFOqWD7t6tC1Act97CVcY+yazrhwMLLr3j_wOyH50GTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/23/21 4:14 AM, Alistair Francis wrote:
> On Tue, Nov 16, 2021 at 9:10 AM Andreas Kemnade <andreas@kemnade.info> wrote:
>>
>> Hi,
>>
>> this all creates a lot of question marks...
>> One of my main question is whether sy7636a = sy7636 (at least the
>> driver in the kobo vendor kernels does not have the "A" at the end,
>> whic does not necessarily mean a difference).
>>
>> https://www.silergy.com/products/panel_pmic
>> lists only a SY7636ARMC, so chances are good that the letters were just
>> stripped away by the driver developers. Printing on chip package is
>> cryptic so it is not that helpful. It is just "BWNBDA"
> 
> I don't have a definite answer for you. But I think it's sy7636a
> 
> The page you linked to above lists SY7636ARMC as well as SY7627RMC,
> SY7570RMC. That makes me think that the RMC is a generic suffix and
> this actual IC is the SY7636A.
> 

Almost all chips have an ordering suffix, indicating things like
temperature range or packaging. The datasheet says:

Ordering Information
SY7636 □(□□)□
             | Temperature Code (C)
          | Package Code (RM)
        | Optional Spec Code (A)

The datasheet otherwise refers to the chip as SY7636A.

Guenter

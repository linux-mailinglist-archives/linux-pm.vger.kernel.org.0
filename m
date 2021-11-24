Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E840B45CDA6
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 21:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhKXUM7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 15:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbhKXUM7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 15:12:59 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74287C061574;
        Wed, 24 Nov 2021 12:09:49 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso6020712otj.11;
        Wed, 24 Nov 2021 12:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4xNXRuhIBU453ImJBo0Cx8qkVWsTpMmqNZWaGTk7aa0=;
        b=kgOrqZKZgqiyvjxRBPyF3KQVhyjLrkcvHA6lsKos93OSoL/gH0rHHdB36neF6LrIkc
         U3XTS1w/zHtTnOAUccH+XHxd9rzCwBbegk36ntd1ZSplBst50yxNkMU2DRQ/eJ/URZb0
         NSK8PrOtoXFq/PmL3+9zbRstg6QOOvxVerI9gVg5E3BWIyEzH2UipeSn73VhO2gNKlVF
         AEzEGVO7jqTqK04bmKw4Do/xXkYM+Uz01Yzy2Nj+fpQ5oJGIlr1dojsx4dfVi8XMj4dd
         80SnUJWlu9i3sHJg1EKZtxbtjtO247aaae0OA5Fb1xbj4KEQmCEF4KY/qsId2yiocFqQ
         7Y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4xNXRuhIBU453ImJBo0Cx8qkVWsTpMmqNZWaGTk7aa0=;
        b=shUUtNmQaesFHXk19u7jnNvf7OJl7DrHAqqmGhakpt90Jbut6OymV5XuXHJpuwx+u3
         MNmP2v0io7lODnIqK7ZoBJcisaANtlQx4uSi+DdW7iPTj9eeu8rM7qZaByWSux1dijkz
         6dy1FqajQQKGn44ye5L2u+IAAe50Ebzw7ucSQhirfNtRSe6s6UzQ0LxiJuWgc80ui40v
         fbKMZsB7JmI2l/3/BPICRzJheb9NYUGcXfyBhLdkwH640xaEr7kaKAHdRDSWE5nAOqEt
         R8OlaQj+MV8dLUbzu/a9PlyO0OmY4RNlpn2T/INc4qf6AmUuqybcQwMgi/o/RTb69W1W
         hMGA==
X-Gm-Message-State: AOAM532gm6IM977UtWHrI4Vu7KbsEmjDzo7UKIKDUR1OoeVRLFHUobA0
        5jzLuim/Jnm2O9EKvtyiMjg=
X-Google-Smtp-Source: ABdhPJyr2zIQORx6RQRObn7/Ddhw3CCbycyekrE8s5E/apgzlTJeH0lPBWhbpP4U1xZ67thg7BrVlg==
X-Received: by 2002:a05:6830:1049:: with SMTP id b9mr16091463otp.60.1637784588808;
        Wed, 24 Nov 2021 12:09:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c8sm135240otk.40.2021.11.24.12.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 12:09:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Alistair Francis <alistair23@gmail.com>,
        Alistair Francis <alistair@alistair23.me>,
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
 <00d68181-ad3b-17d2-0150-00029d399f0f@roeck-us.net>
 <20211124203532.30577a50@aktux>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v15 3/8] mfd: simple-mfd-i2c: Enable support for the
 silergy,sy7636a
Message-ID: <a2fd5089-14a5-e36e-63ce-d73be3cd99a2@roeck-us.net>
Date:   Wed, 24 Nov 2021 12:09:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211124203532.30577a50@aktux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/24/21 11:35 AM, Andreas Kemnade wrote:
> Hi,
> 
> On Tue, 23 Nov 2021 07:39:05 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On 11/23/21 4:14 AM, Alistair Francis wrote:
>>> On Tue, Nov 16, 2021 at 9:10 AM Andreas Kemnade <andreas@kemnade.info> wrote:
>>>>
>>>> Hi,
>>>>
>>>> this all creates a lot of question marks...
>>>> One of my main question is whether sy7636a = sy7636 (at least the
>>>> driver in the kobo vendor kernels does not have the "A" at the end,
>>>> whic does not necessarily mean a difference).
>>>>
>>>> https://www.silergy.com/products/panel_pmic
>>>> lists only a SY7636ARMC, so chances are good that the letters were just
>>>> stripped away by the driver developers. Printing on chip package is
>>>> cryptic so it is not that helpful. It is just "BWNBDA"
>>>
>>> I don't have a definite answer for you. But I think it's sy7636a
>>>
>>> The page you linked to above lists SY7636ARMC as well as SY7627RMC,
>>> SY7570RMC. That makes me think that the RMC is a generic suffix and
>>> this actual IC is the SY7636A.
>>>    
>>
>> Almost all chips have an ordering suffix, indicating things like
>> temperature range or packaging. The datasheet says:
>>
> yes, they have. The only question is where it starts. So did you find a
> public datasheet which you can chere
> 

I registered an account on the Silergy web site, and I was subsequently
able to download the datasheet. The document has a "confidential"
watermark, so I can not share it. You should be able to register an
account and download it yourself, though.

>> Ordering Information
>> SY7636 □(□□)□
>>               | Temperature Code (C)
>>            | Package Code (RM)
>>          | Optional Spec Code (A)
>>
>> The datasheet otherwise refers to the chip as SY7636A.
>>
> so there is no indication of something like this where the A really
> makes a difference:
> 

I may be missing it, but I see nothing in the datasheet that would indicate
that or if the "A" has any relevance other than "Optional Spec Code",
and I do not see an explanation for that term either.

Guenter

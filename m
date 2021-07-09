Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4D03C2ADC
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 23:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhGIVdo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 17:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhGIVdo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 17:33:44 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12950C0613DD;
        Fri,  9 Jul 2021 14:30:59 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e20so10179138ljn.8;
        Fri, 09 Jul 2021 14:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7W1D2O2qCEKR7zKJko/Cm8ADrfYCvs83FXBwHmuFLyE=;
        b=BdGDQ6jSViMaKzGdsr6ZoU0Tvd2zdumu+PG7fYrDZ3n2CsSldNFUxvbWKD+yRrc8PM
         t4o6jkAlroYfRR0emUYH/ZW6ziAilDLfp7/DtRyw+GY/w5gVGcvS8pNq+4F42ooggwrq
         rUis38T7r91qvNISo6AbW6w8KVIh67BQUibiklO3cT7XrYpsApINVpHvuSWKYCpMTHvz
         YbOipvwDmtEQyq3vPTGMUoqTcQETjs8wDYrdIkUykFnlc2zGJMqd22iaSYMXIzJFZVuS
         lVSjcItQzxhY95u2nBTIsxKlQRpjYYmUJr+cYcjxzuZCTCw3mUHyuGgaOuMCn4SMAhmq
         ZGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7W1D2O2qCEKR7zKJko/Cm8ADrfYCvs83FXBwHmuFLyE=;
        b=RgERSvzzvNzCt2rStGN0ZfKGfLYukqARtvD+Qvi5KqyUkU1wJMA+pKTfTVNUK5LiHW
         JRHYirr0r6nFj/6A30ZeolzU9CBYo5/48GzIdfSdLhYbjS1A3YxVdSZjK3fCly7Glz81
         KymAbh4ADlfWLh+QcL+73M7cCgyeowD0q6PJz951gGF42g4K4yrbMundgCG7JO4lt7eC
         hgZU/+LMtsWEHKGt/dY52p7migt1oyWrT9ukhgzynVoDSIAgbSUuiCzhCC+EWwQY0GCA
         Mm7fXSZI4233c6pZr6LyxnBOz2uJdNxEmwKO7eRyi0MSIRJtrm9oMe3WGbfkpXXx55dG
         VTBQ==
X-Gm-Message-State: AOAM5306S+jXFGsarwgO7ET4QhakFEdqrsHePPKff0Vh9VXqKRt91mFy
        i91roIDYDvy3uwq8o1jaQ+d0Zg/fdGU=
X-Google-Smtp-Source: ABdhPJx7Ivk1JigvlM02oU8v95RxaDB+0vSAbo5j+QhkyIX8MAl/FYsqYFAam37aCC/eIPTOxvoHkg==
X-Received: by 2002:a2e:8001:: with SMTP id j1mr31741200ljg.332.1625866257344;
        Fri, 09 Jul 2021 14:30:57 -0700 (PDT)
Received: from [192.168.2.145] (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.googlemail.com with ESMTPSA id y12sm681083ljh.19.2021.07.09.14.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 14:30:56 -0700 (PDT)
Subject: Re: [PATCH v1 05/12] usb: otg-fsm: Fix hrtimer list corruption
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210701022405.10817-1-digetx@gmail.com>
 <20210701022405.10817-6-digetx@gmail.com> <YOd/SfxC26esmVXU@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7b0940a9-ea65-d83e-7450-a09a0082bcd5@gmail.com>
Date:   Sat, 10 Jul 2021 00:30:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOd/SfxC26esmVXU@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.07.2021 01:42, Michał Mirosław пишет:
> On Thu, Jul 01, 2021 at 05:23:58AM +0300, Dmitry Osipenko wrote:
>> The HNP work can be re-scheduled while it's still in-fly. This results in
>> re-initialization of the busy work, resetting the hrtimer's list node of
>> the work and crashing kernel with null dereference within kernel/timer
>> once work's timer is expired. It's very easy to trigger this problem by
>> re-plugging USB cable quickly. Initialize HNP work only once to fix this
>> trouble.
> [...]
>> -	INIT_DELAYED_WORK(&fsm->hnp_polling_work, otg_hnp_polling_work);
>> +	if (!fsm->hnp_work_inited) {
>> +		INIT_DELAYED_WORK(&fsm->hnp_polling_work, otg_hnp_polling_work);
>> +		fsm->hnp_work_inited = true;
>> +	}
>> +
> 
> Maybe you could just add an initialization function to be called by
> users of otg_fsm? It seems that only chipidea driver uses this
> struct currently.

If there are any out-of-tree users of the OTG FSM, then they will all
get the fix too using the universal solution.

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689F0476CE0
	for <lists+linux-pm@lfdr.de>; Thu, 16 Dec 2021 10:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhLPJIm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Dec 2021 04:08:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59619 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232732AbhLPJIl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Dec 2021 04:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639645720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/S2bBf2H4Ywg/G1YUzMTQsACFOpl5qi7kASq0wmmZwk=;
        b=V4Y/QMOfjRmHBaXd9HnZ9l/HznmfcBDxrYrfbtnTCt5oFguu1BEGcNyhSdSd3UypKQ19p2
        i9yqAcHhwZTiR+XMkBBvqXwDJ8O3CM0d40/QbGpW/iliPqpS/53F/GeYtcRRy5flmUXpoO
        DiNYr6SgQx/dGH2MSAGvtqGL7jBd7vs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-dLXe2DmxNIiw5ijnErZ8hw-1; Thu, 16 Dec 2021 04:08:39 -0500
X-MC-Unique: dLXe2DmxNIiw5ijnErZ8hw-1
Received: by mail-ed1-f72.google.com with SMTP id b15-20020aa7c6cf000000b003e7cf0f73daso22618404eds.22
        for <linux-pm@vger.kernel.org>; Thu, 16 Dec 2021 01:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/S2bBf2H4Ywg/G1YUzMTQsACFOpl5qi7kASq0wmmZwk=;
        b=UwRxD4ufEGbiVFiVgVxeaWHY4bvNob2fx6eON+QPR5ozGCNS9bNkn8iELr1xtGue/W
         lpgcn+pE34F2RutwimY2e1SixsGaaOdJrez32g9ipYihED71jXimjiHCJLXTH00IyfPH
         vooBW07f74ATVhi9/cGS+dVAZD8Sp/bCG0DyD75mFNI4IuT0SNec8873mWMG4eK9EB7D
         BxcLcDQuNR0EvvA7K9FX/AtOQLvJn9zPFl1jYOW10rWkfaD2Yg4oqo2CC9YLnj7tjlBM
         cQ3/QCE8ldy+nJRzc7LLxaRXtvrs8uEsrby7Lp8ggcWBUy/ELALjeIPegJyB3VzBDi0N
         4rLQ==
X-Gm-Message-State: AOAM533uTaznanq41xyv0W/feEUcSD6x06cu8mvITTV2IfgQzkmji1+v
        kvPNocf+ENJ5jMRLtFpO3OvTVH3wYpPaSWiUcqog4ySS9qM6BSEx6faQOSrV2K017E8t65+X7tV
        QfDnmf6xo1z5K362cXjg=
X-Received: by 2002:a17:907:3f1e:: with SMTP id hq30mr13896368ejc.579.1639645718164;
        Thu, 16 Dec 2021 01:08:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpoQtb8C3nM8xfkYi5jPPX96MzG1owNVpw3oKsZ+pHTY4AgBMB+VD4ViJdhbRHyy6UcznxMg==
X-Received: by 2002:a17:907:3f1e:: with SMTP id hq30mr13896352ejc.579.1639645718010;
        Thu, 16 Dec 2021 01:08:38 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id s13sm2204024edd.15.2021.12.16.01.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 01:08:37 -0800 (PST)
Message-ID: <4855a130-b16b-d8d6-ec9b-ab1ac024e4a7@redhat.com>
Date:   Thu, 16 Dec 2021 10:08:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] extcon: fix extcon_get_extcon_dev() error handling
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <CGME20211123084357epcas1p14833147710153f9606f14941ac8b0d96@epcas1p1.samsung.com>
 <20211123083925.GA3277@kili>
 <562b12ff-e395-c818-787e-7fd6ee6d53fb@samsung.com>
 <20211216075233.GD1978@kadam>
 <b4d0c326-3122-c5f9-f376-b122f263d92c@samsung.com>
 <20211216080558.GE1978@kadam>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211216080558.GE1978@kadam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 12/16/21 09:05, Dan Carpenter wrote:
> On Thu, Dec 16, 2021 at 05:24:30PM +0900, Chanwoo Choi wrote:
>> On 12/16/21 4:52 PM, Dan Carpenter wrote:
>>> On Thu, Dec 16, 2021 at 03:39:46PM +0900, Chanwoo Choi wrote:
>>>> Hi Dan,
>>>>
>>>> First of all,  sorry for late reply.
>>>>
>>>> There is one issue. About this issue, I already discussed on patch[1]
>>>> [1] https://lore.kernel.org/lkml/5BEB63C3.1020504@samsung.com/  
>>>>
>>>> extcon_get_extcon_dev() is used for anywhere except for probe step.
>>>> But EPROBE_DEFER is only used on probe step.
>>>>
>>>> So that it is not clear to return EPROBE_DEFER from extcon_get_extcon_dev()
>>>> because extcon_get_extcon_dev() never know either call it on probe function
>>>> or not.
>>>
>>> Currently extcon_get_extcon_dev() is only called from probe so it's not
>>> an issue.
>>
>> Even if extcon_get_extcon_dev() is used on probe until now,
>> it is possible to use on anywhere as I commented.
>>
>> It is difficult to agree this approach without any other solution.
>>
>> Basically, the subsystem core never know either probe time or not.
>> It means that this issue should be handled in each device driver.
>>
> 
> To be honest, I'm not sure how this differs from other functions which
> return -EPROBE_DEFER.  How do other functions guarantee they will only
> be called from probe()?

Right I have to agree with Dan here, all "get" functons for resources
like gpios, clks, regulators, phys, pwms, etc. may return -EPROBE_DEFER
and since these functions may return -EPROBE_DEFER they *must* only be
called from a driver's probe() function.

So I believe that the solution here is to simply add a kernel-doc comment
on extcon_get_extcon_dev() which documents that it may return -EPROBE_DEFER
and that it thus *must* only be called from a driver's probe() function.

Regards,

Hans



> 
> regards,
> dan carpenter
> 


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2297CB52C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 23:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjJPVQY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Oct 2023 17:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbjJPVQV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2023 17:16:21 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE4EB4
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 14:16:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4066692ad35so51218865e9.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 14:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697490978; x=1698095778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DcZOeSXh+u7zYgVbz4jeD55N5KKrZbWxg9Gitt8s0ZU=;
        b=InfiUZ9zoQwgpzaKujbu97hHvHIeMgQC6u62XMCGBugZuG58Gvn/RB0/yvwG1mWewW
         pzmi86ofAeZzVGJ95vf+RA1A2DTWNAaRAAoiOG2MHbtzw8Dkcp9UnCK1B3RW4VAVHocg
         +JV62HK92H371RN7zdPXMY6hSgvHZmbjWQ8SAGo5u1NrwF+NwhA0c+VTJKW/vII18l1c
         /I6cm5NIiAsJ6B5RRZSM19ST3R2JCLS7ha2q1PXu84oEMOpO7TtfX2yGf5faIJxgQDX5
         FDLyGF+3qlVPH0u1TKK6TY7EJR+cEhHatmm6nnrYEbUiCXdTN/pJW8rAcOp+xr7EwGHp
         8QZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697490978; x=1698095778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DcZOeSXh+u7zYgVbz4jeD55N5KKrZbWxg9Gitt8s0ZU=;
        b=C/P4uEXEwJzHbV5Iau7mJ7UjATxZkB3nAVdwcLzUC/DY9WfhVuL07LBhOLgE5ABY2X
         T8HEdg2B1ZT2r+apo2mEo+WsXZC968nXd+fO5DzAYL5cMznSwB0SUpAuL1meTD19EcOk
         Q/41nI9C97iopVAqt4z5vgE5ETwsIUvD2bUrIGcCCCcGRyLpHppbVl65fMWpl7zgU+mV
         4fB0WOy82wnK21bVeNBh3bj7FrWkYHx/vCWoDWgsj4o8w1zM2Fvzn0gOI7HyLovjTtrw
         5NvBOLH0hrxAY3v2qMEEP7tcNHUcdEdMmui4HEm9083FDT3LgCVTiHGEMuJY/JA6w/eZ
         AuGg==
X-Gm-Message-State: AOJu0YzJifulPBUXo36twT0OopxP3wW9b+Vbv/9zWpW+HY2uaMnlbOF7
        TdGD/IVhjizyZGgFLz6lXHEWmo6Rzv47IJ/+nqM=
X-Google-Smtp-Source: AGHT+IGUgnLMTGGXEqlNHo3bXWZ4BGLGJVUdQ4WNOO1wSLEr7rxdXnR4D9OyNMwDTbjQ/qWjcX9h8A==
X-Received: by 2002:a05:600c:5494:b0:3fe:5501:d293 with SMTP id iv20-20020a05600c549400b003fe5501d293mr230568wmb.30.1697490978060;
        Mon, 16 Oct 2023 14:16:18 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id n7-20020a05600c4f8700b00406408dc788sm8233988wmq.44.2023.10.16.14.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 14:16:17 -0700 (PDT)
Message-ID: <be30d282-bc50-43ac-9a34-a904cd357718@linaro.org>
Date:   Mon, 16 Oct 2023 23:16:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PM QoS performance aggregator
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM mailing list <linux-pm@vger.kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <734738ec-b72f-49b4-9a4e-6aaf2a44c9f3@linaro.org>
 <CAJZ5v0j4ceLwx3sh-AOPwtPk6_mya0TvtMRC+d_v0r_hk8jnsQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0j4ceLwx3sh-AOPwtPk6_mya0TvtMRC+d_v0r_hk8jnsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/10/2023 19:46, Rafael J. Wysocki wrote:
> On Mon, Oct 16, 2023 at 3:03 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi,
>>
>> the kernel provides an API to specify latency timings for devices and
>> CPUs. In addition, it allows to deal with the frequencies.
>>
>> However, the unit is Hz and that may not fit very well with some devices
>> where the performance is an index. The devices can have different
>> performance capping mechanisms under the hood (IOW the firmware).
>>
>> The pm QoS seems to not have an interface to describe constraints based
>> on performance index.
>>
>> In the same page, the devices can also be requesting power values
>> instead of performance indexes or frequencies. So having a power based
>> pm QoS would make also sense IMO.
>>
>> Actually, performance indexes, power values, frequencies are just all
>> values but in different units.
>>
>> Would it make sense to create a generic PM QoS constraint with values
>> and units ?
> 
> All of the existing QoS types are frontends to the same underlying
> mechanism and each of them is about using a specific unit, so it's a
> matter of creating a new one for each new unit.
> 
> That said, using performance indices as QoS values directly is
> fundamentally problematic IMV, because they are device-specific and
> not portable in any way and letting user space operate them would be a
> mistake.

What about normalizing them to 1024 ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


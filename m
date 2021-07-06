Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A933BC48B
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 03:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhGFBSU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Jul 2021 21:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhGFBST (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jul 2021 21:18:19 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCDAC061574;
        Mon,  5 Jul 2021 18:15:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bq39so22708878lfb.12;
        Mon, 05 Jul 2021 18:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xG6P1+sDQl4jEV3cq/HGM+DddaPYqM/HhUpbXndOJ58=;
        b=HhsZ0ceURhcOFz0Vj0ytT1juZaq7agnU9T1ESybefYQGZPdHYOu6SPYBjEIBXwZMyw
         zfpxxRW6w5uHhpT63pNPeB0Q7av4f6MWeAVz9f+hnbqjeMDogGshggk8FRMk8Vt0l3NX
         0mc6lfcyV3/RE+2cNDGfY/6Z+22eoBmtqwxxpCwoPDHIw+K1CD9xvdbU0BKZ/qEbsINs
         l4RqAxTy6eHzaeAzw0ado/C4Ns0k6POG/PmsXeW8nDWWSQggOjnhBytjgw4xPZRkS64x
         cyzfsWt8kW9ncdpiz/KehBgmmyoQPzGncWOjuKoRPsSUVyqojrK1y6EhIiu9BXxYdRyM
         q7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xG6P1+sDQl4jEV3cq/HGM+DddaPYqM/HhUpbXndOJ58=;
        b=aZ5lMsgsazkX1O0KedjGWpwVVGYMXR33h7FjbfbJaoaG7jQxNSDa+5AnB9HE/L0kUM
         vb43WFyluDbEJbfUYiegYe185+QjWepgGPBrd9lK3hMVf5R724ywYURA0hrp3c/agiJ+
         hBWj7hbCI+S20CvtIyX587AHquIsUMrqpjJ/3rAs/RLgoxuvijNLrgFA1gW1tym+SphL
         8nsBWMV+RQQ5U+U7A8DUairL58e5hSjFVBUWZa4yI49ezpj2kt5ykPJkXrK/oURtB47e
         dTW61Mh2PbJJYnCOmX8Pz4mfTZiZSjtnwq1EjEnFfuSsUSxvhptTzbYHCqmSXxxDFx+7
         OIAA==
X-Gm-Message-State: AOAM5319fthad/HkAclvA6+KUJToXdy6JSN6vtp2hkfgbimXhowGdi6F
        IJggWxyX3MkNh/50TX6R4ed5FfXWSIs=
X-Google-Smtp-Source: ABdhPJx0b1UAbp7vUWsVA5lY+rJ5RQHv58/MSrNSLpj0P8z7RSnb7ral8ckTetYkrbknjOFXB26Q0Q==
X-Received: by 2002:a05:6512:3c89:: with SMTP id h9mr12102895lfv.17.1625534140087;
        Mon, 05 Jul 2021 18:15:40 -0700 (PDT)
Received: from [192.168.2.145] (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.googlemail.com with ESMTPSA id a8sm1532867ljq.127.2021.07.05.18.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 18:15:39 -0700 (PDT)
Subject: Re: [PATCH v3 05/12] usb: otg-fsm: Fix hrtimer list corruption
To:     Peter Chen <peter.chen@kernel.org>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210704225433.32029-1-digetx@gmail.com>
 <20210704225433.32029-6-digetx@gmail.com> <20210706005739.GA19143@nchen>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <04a679be-ec66-f71f-5b61-59b8ef82e128@gmail.com>
Date:   Tue, 6 Jul 2021 04:15:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706005739.GA19143@nchen>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

06.07.2021 03:57, Peter Chen пишет:
> On 21-07-05 01:54:26, Dmitry Osipenko wrote:
>> The HNP work can be re-scheduled while it's still in-fly. This results in
>> re-initialization of the busy work, resetting the hrtimer's list node of
>> the work and crashing kernel with null dereference within kernel/timer
>> once work's timer is expired. It's very easy to trigger this problem by
>> re-plugging USB cable quickly. Initialize HNP work only once to fix this
>> trouble.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Acked-by: Peter Chen <peter.chen@kernel.org>
> 
> It is better to append kernel dump if you have v4 patchset.

The stacktrace isn't very useful because it crashes within a hrtimer
code from a work thread, i.e. it doesn't point at usb at all. It
actually took me some effort to find where the bug was.

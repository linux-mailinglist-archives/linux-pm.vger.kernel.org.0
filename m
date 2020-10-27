Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A567B29C8D7
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 20:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372151AbgJ0T0o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 15:26:44 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44956 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443855AbgJ0TX1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 15:23:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id b1so3765278lfp.11;
        Tue, 27 Oct 2020 12:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OFeC1CtOzMgLJVc4bc3YLVqRdX5EEq2f1kDG30jsGew=;
        b=GsGzkw+whcBAy310+2NrYkyda+y5HtVgZPLk6L2HtDsITYHr7DvjGFng3ghy3fucRc
         TRX8olu54JANer1GN2PQ+aZQrLRSrLeo95uRegPlAhUZ4PnMEntVwjbW7/txByf8iUbt
         mz9ELt5DSMp+MZAWlbY/30OKQkPBPldk372ta8ur5OUSa9KV/KcVTCEQpIMgyAgWPz0A
         V6LYL0RQmBMrpigUrfMzFShDXlUUP4ecqD0sC4+nulvQOSyBsz8q7XhLhQ/1EIfhXdww
         OXf/pPWqx7zZtO62GMvNICWKwNuPriPaaqb68xMAp/bT/QAM58yl7rpPO7R2GjGCDWmr
         k3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OFeC1CtOzMgLJVc4bc3YLVqRdX5EEq2f1kDG30jsGew=;
        b=GDQs5+ByPfghp3cN0c1A4rqNp5xSyWCZegzCCNbwSX2nXIHD4mb+M22Kp+AsVBsKuf
         zJMQfs2c2u3RB5HHAZO0zeygWZywLXiHu1lEuVRo+h+XyT6oXixpWc2Mi7iRLsIf74X/
         JQBPEbcjCC2vkYK9lLttXAvzjYbsQcqle/LxE4uZkL0CDhYv28ijgdFt7+AFsOXkhp1y
         N8zThVT9ak3Ww0BsgDzocoxA4YfruG8bCuQ2Ao+WVB7/EapknHKhhbiSF+/qjc1gyayi
         3wcAtt3tDQpkcFTNnYIg7ndlPYm5lZeNlpXRC8EWidkPzm2tdBvSc6IGHTuTe/JRKT7e
         nMUQ==
X-Gm-Message-State: AOAM533UL3HRWyRiAEV8vuwSKJusVXJFDLbClSzABpu++t6PH2DWxkGW
        r+soGbMrcW2tdz9ruEbataBIA8S/2iA=
X-Google-Smtp-Source: ABdhPJx10YPJeQ857EsWYyVLQuMavOWrFwdTDPW1oJMMHhLrhJH9XKs2nZRmDYuSHJ4+oAxFeZALRw==
X-Received: by 2002:a19:3f52:: with SMTP id m79mr1323112lfa.58.1603826604035;
        Tue, 27 Oct 2020 12:23:24 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id z14sm287943lji.84.2020.10.27.12.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 12:23:23 -0700 (PDT)
Subject: Re: [PATCH v6 08/52] dt-bindings: memory: tegra20: emc: Document
 mfd-simple compatible and statistics sub-device
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-9-digetx@gmail.com> <20201027132241.GG1822510@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0a619270-b301-4eeb-6216-0ad5fed6a20a@gmail.com>
Date:   Tue, 27 Oct 2020 22:23:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027132241.GG1822510@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 16:22, Thierry Reding пишет:
> On Mon, Oct 26, 2020 at 01:16:51AM +0300, Dmitry Osipenko wrote:
>> External Memory Controller can gather various hardware statistics that
>> are intended to be used for debugging purposes and for dynamic frequency
>> scaling of memory bus.
>>
>> Document the new mfd-simple compatible and EMC statistics sub-device.
>> The subdev contains EMC DFS OPP table and interconnect paths to be used
>> for dynamic scaling of system's memory bandwidth based on EMC utilization
>> statistics.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../memory-controllers/nvidia,tegra20-emc.txt | 43 +++++++++++++++++--
>>  1 file changed, 40 insertions(+), 3 deletions(-)
> 
> Why does this have to be modelled as a separate device? Isn't this just
> using a couple of registers out of the EMC register range? If so, this
> would better just be integrated into the parent node and implemented as
> part of the EMC driver. No need to further complicate things by adding
> a dummy child.

Maybe true, I'll take a closer look.

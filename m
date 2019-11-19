Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFAF71029FA
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 17:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfKSQ5c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 11:57:32 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42384 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbfKSQ51 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2019 11:57:27 -0500
Received: by mail-lf1-f65.google.com with SMTP id z12so17641545lfj.9;
        Tue, 19 Nov 2019 08:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=53ruBaQSDnrBitdIBpjgYyR4OHZkTHQbljASTrm8H0Y=;
        b=VMPaO7PmUawdArVnpsmpKxbhWrC0NTg3FABfGEHFT3LHle5b5rmM5crPIrtMeRre2K
         g/bNDLnomL5iL5XfGZyxjnMPge3wlA49Dl+Wb7pBh5Yx6anjdujkIRi+4OYfI2RVSEBk
         6w8vwwpOknSkyqZFMAdXBTSrf7lrJYhiQzu3+mxki+8cchWbt5pG6h4SWWA16Q7SKZcx
         DRtUJz9hL7g3BgocQRAtnfG1CBB5Bxx/XBYrDvCfbHwO3YzoR9182tkUoCWYVAsWEKyh
         Z/LHGGC8BC8NHcII+3FslAKkOFd+O0iA10sgJX3iLybWJXKohzW/fta2BFkz98oyPcUF
         5VBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=53ruBaQSDnrBitdIBpjgYyR4OHZkTHQbljASTrm8H0Y=;
        b=s+Q+/6MqhDDoRwPfCR2uv1p/ZvZ5gj9c6m+j229Z31tX0/OtxkIKlCgyBQSdqsA4Ne
         nIKZh4euaQVqnoO6HrvK83cKypMklUzG9MYxP1xPi4jwTLUnyWQhQj7PVPLqr/2/KxLN
         V5QIod+kafhu3ZjNEv2Y/atmLntYZm4UJxxQeGy064qbO+ojnsFY3LBxboBarSor0PRV
         K19o4KSwapF3leGLNhml9yrC6cm3H2w9w+G/Nh2SgwhM+/67DlcpcyLOhc9YtYd622Hc
         oZvamByWTKwYX5xuE0b4isdiuDwXTAdA9Bo7xIIFl95uchBt1Y4rAh+Mtu0sck3P/H80
         ycvw==
X-Gm-Message-State: APjAAAW/3EVL7JgtVv74IhlvlES7U+xy+Ks2ed+sg06VbKsFTaYBYwdY
        PfodonJiGCZrZ9HTV/tjdsXddIJu
X-Google-Smtp-Source: APXvYqzZSiDsbH+MyTiWXSb4FyjNHsOgnrf11qIbaSuRVvsJY1pHPQguNgqovNvA+wS/faGG3COv+Q==
X-Received: by 2002:a19:a410:: with SMTP id q16mr4958560lfc.184.1574182644074;
        Tue, 19 Nov 2019 08:57:24 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id d5sm10202535ljc.51.2019.11.19.08.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 08:57:23 -0800 (PST)
Subject: Re: [PATCH v1 02/29] dt-bindings: memory: tegra20: emc: Document new
 interconnect property
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20191118200247.3567-1-digetx@gmail.com>
 <20191118200247.3567-3-digetx@gmail.com> <20191119062156.GB2462695@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <bbe612b6-fc07-fb7f-0f13-bca2c0864d73@gmail.com>
Date:   Tue, 19 Nov 2019 19:57:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119062156.GB2462695@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

19.11.2019 09:21, Thierry Reding пишет:
> On Mon, Nov 18, 2019 at 11:02:20PM +0300, Dmitry Osipenko wrote:
>> External memory controller is interconnected with memory controller and
>> with external memory. Document new interconnect property which designates
>> external memory controller as interconnect provider.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../bindings/memory-controllers/nvidia,tegra20-emc.txt        | 4 ++++
>>  1 file changed, 4 insertions(+)
> 
> Do we really want to describe this particular connection? It's pretty
> static and the only real connection here is the EMC frequency, so the
> whole interconnect infrastructure seems a bit overkill.
> 
> Sounds to me like we could piggyback on top of the existing
> nvidia,memory-controller property of the EMC to make the connection.

Ultimately each memory client talks to EMEM through MC and EMC, although
it should be okay to ignore the EMEM from a driver's / software perspective.

[snip]

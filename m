Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAEBE1A49D5
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 20:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDJS22 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 14:28:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35690 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJS22 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 14:28:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id k21so2824125ljh.2;
        Fri, 10 Apr 2020 11:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q+S9FQcm44gCkUcVdVprrI4SiEYMw4o+DCvVDXTf1yI=;
        b=SwMy/QxroluHVUM/6FKQ9+IjMym0OdlVEJKFzpjegXVVqhuLuWEfr20uoodqRoOjw6
         uq+cxx0rfMJPB6s2le8gCs8JBuibGGUBV+UL3HQzGhtDGpSXSoijrdjL9ZNPMPhHwd5R
         YdUk53GHoolSl/2lIcXaByAF/ny4tC1WEYi3ppiPSOY9+g8nVM8+4kpvTQgvHoRYwaK0
         uBrSLTeQFZw+9gp9cQAPvUIvnnBeQl4YfWTF13D2e8h0N8KzEzCuTZZEzej3/KVmfvfd
         LEBwQRNlNzYStJK76cU/05M/P32BTPi90t2JfffuZzQ5nT407MJghhQu1deDjYOYKjLc
         mZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q+S9FQcm44gCkUcVdVprrI4SiEYMw4o+DCvVDXTf1yI=;
        b=bWBfBOvaIn4GxzEay+cYFhUfob7/34qpf5BveRoJBZrxlxkcvEA5YssyLWyD1wcohk
         pUqXPqs1TNQvQrFGSSAI+pjH7j2bozI415pUnh8Bz9cjetx0Ihk3LwYBPeBAidTqIzFv
         /TY4y5Qep4tEcrxi8ot4cHD8URoophn9fotO/ESUq3JgdckEAqwkWmTMRp1YVO6mFr8q
         eIpODbgSfCsjUDTiqDwRaPKgHWV72kCeMUKs7DJ6HEnWMMasLe9wpdFEq7Sx/d6ShL/j
         25gAisaJgsL0Z27y2+sjJJFIv4Gd7bxmUzuVzl+WddO/8rEOMnMR8o0oYDg2SeXkIrX9
         bpug==
X-Gm-Message-State: AGi0Pub9wys7lunZeI65Xab6ffJs4NhrZM5ZlaQZKHuGEsJL8LUsvyq7
        ehId14RIUBGPl7r4LBUjMimTxg+R
X-Google-Smtp-Source: APiQypJDMRwiWxqCQIVoO1DjqAKbxN9a3USsG+5h8JhkdiiSyqW5X2ClXQ9wa/FUBYCazlrhcZe10w==
X-Received: by 2002:a2e:904b:: with SMTP id n11mr3658147ljg.171.1586543304167;
        Fri, 10 Apr 2020 11:28:24 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id u13sm1487881lji.27.2020.04.10.11.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 11:28:23 -0700 (PDT)
Subject: Re: [PATCH v2 05/22] dt-bindings: host1x: Document new interconnect
 properties
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20200330010904.27643-1-digetx@gmail.com>
 <20200330010904.27643-6-digetx@gmail.com> <20200410170929.GA1498@bogus>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <98d28983-0c50-1155-adc0-8ddbd15cc701@gmail.com>
Date:   Fri, 10 Apr 2020 21:28:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200410170929.GA1498@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

10.04.2020 20:09, Rob Herring пишет:
...
>> +  Optional properties:
>> +  - interconnects: Must contain entry for the MPE memory clients.
>> +  - interconnect-names: Must include name of the interconnect path for each
>> +    interconnect entry. Consult TRM documentation for information about
>> +    available memory clients.
> 
> Is the TRM public? Perhaps refer to the header.

Yes, you can download it from NVIDIA website (after registration).

I'll add "Consult Memory Controller section of TRM..." in the next version.

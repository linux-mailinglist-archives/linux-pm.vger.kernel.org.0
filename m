Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECF910589F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 18:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfKUReF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 12:34:05 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41238 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUReF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 12:34:05 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so1449151lfp.8;
        Thu, 21 Nov 2019 09:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6J1piRgV0I8ZeSxFU2hLB+lhIu/EsMKbTjoUdKhBoh4=;
        b=cI7WavVQXW6YTTsx24kyro2bKraJeez/5xvP+u/FCt+8IEeH++xRr7bppVVaMcdStl
         VqYxOPhucE+noi9PVTucRx3xce0OO49s9ls3Rn0f9DRBFLG6X54uc7hLeS10i4nF8zW1
         vuqLnHyIWSOvQTAvI4OJmhjUiY1gpB1znoS71dGYEKG5c26PdBdXjfB9+3tj8FSe1rlq
         smug1wpdMdRqaG6e0+o44KHpGF9s9eBS5+SP7KBhUOEvIakX82SUDuzGwQOlKU2wAIuo
         Tc4AiK8LReNqyA9rHaQQkFQxFrOOMP1aSH1H1iqDr3iROHhqGnFIYNZ6wnBnJV6FlKXk
         Lb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6J1piRgV0I8ZeSxFU2hLB+lhIu/EsMKbTjoUdKhBoh4=;
        b=XHCnykBwKKHnIbnbZQ8vBM03/0psfRrMD4mdUp3wh6FBP1373W4m25d4nhqv6YtIa9
         6CaKaitc1P8StcVgF4GCbJv3ebY6uRKm2E6UAsxp2gTXjd4FOR46zeVnYz89TbF0sL4F
         4WtDZSG7cHaLogRIZhS/4E5wZF3kiTvmgqnzEIluxeWs/za6LXg8kw85pjfB4gPudlar
         McLR+lufE4rUH6l0QztxeMc9GuZqcjTHXQBS9hUhFpSr2gQoCNlG7XgsXux22C6r9OyJ
         T8OHACYCOtsreSCTJdbkhG4s+NEiv70jkmrKTIOC+uUKhLXRi9KFFBtElCqyMBSayHJ2
         /8Gg==
X-Gm-Message-State: APjAAAVpK83nPfTd7JTIYgO/dvFhstaLdEJESDxnCVgG9E1dLjJzLzxi
        cULPYtDx1MeM8s2nVBVj8NUUpQ5+
X-Google-Smtp-Source: APXvYqzI4efW+jpylCKcwwlKWAScScn1OR7oGncmwtojSpUNDIX2q6OMNOWDFnG0E3FBtdAKJO/UzA==
X-Received: by 2002:ac2:5dcc:: with SMTP id x12mr8758634lfq.163.1574357640859;
        Thu, 21 Nov 2019 09:34:00 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id y7sm1738852lfb.75.2019.11.21.09.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 09:34:00 -0800 (PST)
Subject: Re: [PATCH v1 12/29] interconnect: Add memory interconnection
 providers for NVIDIA Tegra SoCs
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20191118200247.3567-1-digetx@gmail.com>
 <20191118200247.3567-13-digetx@gmail.com> <20191119063002.GE2462695@ulmo>
 <a16b54bf-a881-84d0-4437-993dc275487c@gmail.com>
Message-ID: <a9bbe36e-8082-8cab-7377-f71f2489fb30@gmail.com>
Date:   Thu, 21 Nov 2019 20:33:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <a16b54bf-a881-84d0-4437-993dc275487c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

19.11.2019 19:58, Dmitry Osipenko пишет:
> 19.11.2019 09:30, Thierry Reding пишет:
>> On Mon, Nov 18, 2019 at 11:02:30PM +0300, Dmitry Osipenko wrote:
>>> All NVIDIA Tegra SoCs have identical topology in regards to memory
>>> interconnection between memory clients and memory controllers.
>>> The memory controller (MC) and external memory controller (EMC) are
>>> providing memory clients with required memory bandwidth. The memory
>>> controller performs arbitration between memory clients, while the
>>> external memory controller transfers data from/to DRAM and pipes that
>>> data from/to memory controller. Memory controller interconnect provider
>>> aggregates bandwidth requests from memory clients and sends the aggregated
>>> request to EMC provider that scales DRAM frequency in order to satisfy the
>>> bandwidth requirement. Memory controller provider could adjust hardware
>>> configuration for a more optimal arbitration depending on bandwidth
>>> requirements from memory clients, but this is unimplemented for now.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/interconnect/Kconfig               |   1 +
>>>  drivers/interconnect/Makefile              |   1 +
>>>  drivers/interconnect/tegra/Kconfig         |   6 +
>>>  drivers/interconnect/tegra/Makefile        |   4 +
>>>  drivers/interconnect/tegra/tegra-icc-emc.c | 138 +++++++++++++++++++++
>>>  drivers/interconnect/tegra/tegra-icc-mc.c  | 130 +++++++++++++++++++
>>>  include/soc/tegra/mc.h                     |  26 ++++
>>>  7 files changed, 306 insertions(+)
>>>  create mode 100644 drivers/interconnect/tegra/Kconfig
>>>  create mode 100644 drivers/interconnect/tegra/Makefile
>>>  create mode 100644 drivers/interconnect/tegra/tegra-icc-emc.c
>>>  create mode 100644 drivers/interconnect/tegra/tegra-icc-mc.c
>>
>> Why does this have to be separate from the memory controller driver in
>> drivers/memory/tegra? It seems like this requires a bunch of boilerplate
>> just so that this code can live in the drivers/interconnect directory.
> 
> It fits with the IOMMU separation. To me that it's a bit nicer to have
> the separation for the ICC as well, but having ICC within memory
> controller driver also will be fine.
> 
> Indeed it looks like there is not much in the MC's provider code right
> now, but maybe more stuff will be added later on.
> 
>> If Georgi doesn't insist, I'd prefer if we carried this code directly in
>> the drivers/memory/tegra directory so that we don't have so many
>> indirections.
>>
>> Also, and I already briefly mentioned this in another reply, I think we
>> don't need two providers here. The only one we're really interested in
>> is the memory-client to memory-controller paths. The MC to EMC path is
>> static.
> 
> Perhaps it is fine to drop EMC path, I'll revisit it.
> 
> [snip]

One advantage of having both MC and EMC as ICC providers is that there
won't be a need to mess with a custom coupling of MC-EMC drivers
together because interconnect API naturally takes care of the coupling
for us by telling ICC users to defer until both providers are registered.

I'll take another look at this over the weekend, but for now my v1
variant looks appropriate in terms of a better hardware description and
implementation in the code.

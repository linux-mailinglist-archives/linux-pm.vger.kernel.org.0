Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F297F102A3B
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 17:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfKSQ65 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 11:58:57 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44258 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbfKSQ6x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2019 11:58:53 -0500
Received: by mail-lf1-f67.google.com with SMTP id n186so5224379lfd.11;
        Tue, 19 Nov 2019 08:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xiX0EqzPXmfl9+8cycQGn6gTe/lI1705Bk47uYfm4oU=;
        b=ktleR1QkiRWXpJ1PymOF+AnwE7Q9PBQG4UVHVcltdxluMcrO7oMme2qW6uYcxu9BmM
         5eVsufxlWyMMLypvEN5Rft13s81NH2I12Nhodkw5VzivVryLVBn78eJPsiCjavVjwiVE
         crv4IfEd/KThz46OLInqN0ZxYZerI0Hz0a6/Poj40xkFmg6RM/xpzNyhzSLIfslGeSXP
         SU+ZGVH00vtrS+muuiIgHjd1kYOHNSL7kDvVA88gYYRKFLMJKQRkf+pCNKLlHuLPlKV7
         ZFY4YR6GsuOrwjsGk5fH9j0kpxj7xB02oBoAd1mNClvz1VZ5Wtewa9dBJZQbsw5VgAKE
         VqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xiX0EqzPXmfl9+8cycQGn6gTe/lI1705Bk47uYfm4oU=;
        b=qCLW9QeB8ootVjRjp0/5dFKp5SbHPVLYfThbnWS4Ur4nn5MydtjXYXC92fQ6pLPN+k
         /PGqJ70vR/xeRHRfKo/wJAodh1qDggP8ti2M8KxytH6d6xk3wtltXzQC+jRfj+8q0gDX
         5KKbBiRx8E1PMwDth27v/vA0aHDebATWr3Tol5Fjeo+Fsy6jyG03BJ9bofCvsC9Es3DS
         vVoTka0efbZCyXYGF8B8tbWUMalebwwRD42+0HGYtoJquyoae1RbUlSrP3H/g0hrjAzW
         LAVWmIEhv1cwkya3OMi/O2Qzz/FzJrxENNuCPh/2JUkyqchvpAY2OGZVdLU5JtG0pgVI
         smXw==
X-Gm-Message-State: APjAAAU5loJp8fxqHtdBmtKyK7yW2B1bAd5NlPqsSM+nDdH990Z6OaHV
        Vt5wvVwkQvXCwyfsOtOdk8+c0M/2
X-Google-Smtp-Source: APXvYqxOFPeDqctZEbuJVO4GYrRKbyIayL3pi6tIsdyQWNkua6J7ci15SiL5pULo3eySWzEJD8Bv1A==
X-Received: by 2002:ac2:5216:: with SMTP id a22mr4824691lfl.169.1574182731139;
        Tue, 19 Nov 2019 08:58:51 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id 141sm10189491ljj.37.2019.11.19.08.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 08:58:50 -0800 (PST)
Subject: Re: [PATCH v1 12/29] interconnect: Add memory interconnection
 providers for NVIDIA Tegra SoCs
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a16b54bf-a881-84d0-4437-993dc275487c@gmail.com>
Date:   Tue, 19 Nov 2019 19:58:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119063002.GE2462695@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

19.11.2019 09:30, Thierry Reding пишет:
> On Mon, Nov 18, 2019 at 11:02:30PM +0300, Dmitry Osipenko wrote:
>> All NVIDIA Tegra SoCs have identical topology in regards to memory
>> interconnection between memory clients and memory controllers.
>> The memory controller (MC) and external memory controller (EMC) are
>> providing memory clients with required memory bandwidth. The memory
>> controller performs arbitration between memory clients, while the
>> external memory controller transfers data from/to DRAM and pipes that
>> data from/to memory controller. Memory controller interconnect provider
>> aggregates bandwidth requests from memory clients and sends the aggregated
>> request to EMC provider that scales DRAM frequency in order to satisfy the
>> bandwidth requirement. Memory controller provider could adjust hardware
>> configuration for a more optimal arbitration depending on bandwidth
>> requirements from memory clients, but this is unimplemented for now.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/interconnect/Kconfig               |   1 +
>>  drivers/interconnect/Makefile              |   1 +
>>  drivers/interconnect/tegra/Kconfig         |   6 +
>>  drivers/interconnect/tegra/Makefile        |   4 +
>>  drivers/interconnect/tegra/tegra-icc-emc.c | 138 +++++++++++++++++++++
>>  drivers/interconnect/tegra/tegra-icc-mc.c  | 130 +++++++++++++++++++
>>  include/soc/tegra/mc.h                     |  26 ++++
>>  7 files changed, 306 insertions(+)
>>  create mode 100644 drivers/interconnect/tegra/Kconfig
>>  create mode 100644 drivers/interconnect/tegra/Makefile
>>  create mode 100644 drivers/interconnect/tegra/tegra-icc-emc.c
>>  create mode 100644 drivers/interconnect/tegra/tegra-icc-mc.c
> 
> Why does this have to be separate from the memory controller driver in
> drivers/memory/tegra? It seems like this requires a bunch of boilerplate
> just so that this code can live in the drivers/interconnect directory.

It fits with the IOMMU separation. To me that it's a bit nicer to have
the separation for the ICC as well, but having ICC within memory
controller driver also will be fine.

Indeed it looks like there is not much in the MC's provider code right
now, but maybe more stuff will be added later on.

> If Georgi doesn't insist, I'd prefer if we carried this code directly in
> the drivers/memory/tegra directory so that we don't have so many
> indirections.
> 
> Also, and I already briefly mentioned this in another reply, I think we
> don't need two providers here. The only one we're really interested in
> is the memory-client to memory-controller paths. The MC to EMC path is
> static.

Perhaps it is fine to drop EMC path, I'll revisit it.

[snip]

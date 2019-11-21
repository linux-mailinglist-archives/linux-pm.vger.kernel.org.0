Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA7A6105854
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 18:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfKUROk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 12:14:40 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34374 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKUROk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 12:14:40 -0500
Received: by mail-lf1-f65.google.com with SMTP id l28so3287250lfj.1;
        Thu, 21 Nov 2019 09:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cAzhUxhbi0ipJJRlq7LEPrGywJG5HkdxE06SxVESVKU=;
        b=PXTQz/+Hd1s0CfRFTJDfyk4lkxAwzEQmZwcZZUy9l91K9JI/XZfGPbFhBdnt5WVooS
         df2ySPhZBMZoQsNlxicqFixYOg9eiDRQcpBqB0rDmPCDWwflyXiLf3kOJs37sGuoADnl
         SxAF5+GVCBpludbWA/oTghn5Z0/D5IT+q5rEIraqu3CY7AIcUqkZFRkYHO096ViBly50
         Ru4c/1mhi5dsBboNqrLLr5LyBMkY3ZT8pK1B90JtQCOr+kgNrtxENg+n3RWLUMmIRfGr
         vFY9PwdyXdEqQ9agz0Rj7R0mQBfIGQ4wxznDrQKmvdqpSgLh+hT0FZKl/X5VfHHLdWZS
         WXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cAzhUxhbi0ipJJRlq7LEPrGywJG5HkdxE06SxVESVKU=;
        b=Tck4EqklIx6OYyMO8Iv+00FhxZMM2BCUdJAdfLw0iJbHZ15p+P1dBdJxz2YZOtivfi
         ThAfN7GqeDAh/Ebhe4KiFW3D3DR0X7nPQQGz5zoy1GkpdfS9i9oA9nMKo/dgE+8YdnAo
         OGdZI74wvKtJa0t9YTQKJzdZvG7VKwaJUi1bRuH0A4b6qFmXPLArb6A0QD6i5DzdmiyR
         ACiknQeM/uyH8eeQ3KYTPZBgt7mOzgXZUh92NlmRwSzQOSOP06cow0s8KP+tqRQwA8T5
         fJSCaKjgR98doO7eCQvgfOXbiwhSJlTkfCaDHf889rILz4qSH9auxllzTrpTwLBEj94a
         aC0A==
X-Gm-Message-State: APjAAAU8COqpFSrcBIg8zTAoBV6PPsCYN2UVhOZsj346GDvtT0g1uJNe
        OgrpHRNNgi7jJGMEaquZpoCxQ6W6
X-Google-Smtp-Source: APXvYqwWYb4yZPpewD8z8jU6llJI5iWJWK6txjiQJN0ChqrVUrDu6k8kR6SO8R5t194m7diWfvyJjg==
X-Received: by 2002:ac2:4c3b:: with SMTP id u27mr8918560lfq.131.1574356477219;
        Thu, 21 Nov 2019 09:14:37 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id z19sm1583151ljk.66.2019.11.21.09.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 09:14:36 -0800 (PST)
Subject: Re: [PATCH v1 08/29] dt-bindings: interconnect: tegra: Add initial
 IDs
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
 <20191118200247.3567-9-digetx@gmail.com> <20191119062535.GC2462695@ulmo>
 <8cff3af3-42c7-3312-5f98-cd5eb98b7b7a@gmail.com>
Message-ID: <f0f36176-8070-08a6-a61f-77221d916f04@gmail.com>
Date:   Thu, 21 Nov 2019 20:14:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <8cff3af3-42c7-3312-5f98-cd5eb98b7b7a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

19.11.2019 19:56, Dmitry Osipenko пишет:
> 19.11.2019 09:25, Thierry Reding пишет:
>> On Mon, Nov 18, 2019 at 11:02:26PM +0300, Dmitry Osipenko wrote:
>>> Define interconnect IDs for memory controller (MC), external memory
>>> controller (EMC), external memory (EMEM) and memory clients of display
>>> controllers (DC).
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  include/dt-bindings/interconnect/tegra-icc.h | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>  create mode 100644 include/dt-bindings/interconnect/tegra-icc.h
> 
> 
> Hello Thierry,
> 
>> There was a bit of discussion regarding this for a recent patch that I
>> was working on, see:
>>
>> 	http://patchwork.ozlabs.org/project/linux-tegra/list/?series=140318
> 
> Thank you very much for the link.
> 
>> I'd rather not use an additional set of definitions for this. The memory
>> controller already has a set of native IDs for memory clients that I
>> think we can reuse for this.
> 
> I missed that it's fine to have multiple ICC connections defined
> per-path, at quick glance looks like indeed it should be fine to re-use
> MC IDs.

Well, it is not quite correct to have multiple connections per-path.

Please take look at interconnect's binding and core.c:

  1. there should be one src->dst connection per-path
  2. each connection should comprise of one source and one destination nodes

>> I've only added these client IDs for Tegra194 because that's where we
>> need it to actually describe a specific hardware quirk, but I can come
>> up with the equivalent for older chips as well.
> 
> Older Tegra SoCs have hardware units connected to MC through AHB bus,
> like USB for example. These units do not have MC client IDs and there is
> no MC ID defined for the AHB bus either, but probably it won't be a
> problem to define IDs for them if will be necessary.
> 

Since interconnect binding requires to define both source and
destination nodes for the path, then MC IDs are not enough in order to
define interconnect path because these IDs represent only the source
nodes. Destination node should be either EMC or EMEM.

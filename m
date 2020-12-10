Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDB02D6378
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 18:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390924AbgLJR0H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 12:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388162AbgLJRYP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 12:24:15 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CE5C0613CF;
        Thu, 10 Dec 2020 09:23:35 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id o5so4807865pgm.10;
        Thu, 10 Dec 2020 09:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+LIa9ilbcIDe7I5GjNGlnS7I8eoClTdzZMGkmPCk9uI=;
        b=peqmHg5V1XarqOftCJXiXDAPDhTKsa75nNNSERs4fJKyWV6OJcYaqdN6rD1ZjUW2ia
         4MGcJBVW+aM1TOnvEbVbPuhd/tCVxptojIfeBCsGLuDLLhBdpT3dITduQfrLUHz1aPHl
         +WLc9x3pZrES+UnSxjTipGdJ5lRwyv63yLt69Mli+IZDx9KUTZ9CPy6e5bAVC0k2X4SA
         7LuJ8y/oM79wT5iwUYtO2GgIQ8pGNQJrZpKsjCK39V77qwwfuhERvmI+0ZAL+MByDu2O
         5ZhoC+za3fbpbeeYeHIF1IXpklYGUHMC/J0XoYrPUPefFm6swHq0MVqMvICWlEp6y6Fz
         D2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+LIa9ilbcIDe7I5GjNGlnS7I8eoClTdzZMGkmPCk9uI=;
        b=f/XfCHwMKkth0g49eGw+7W1Eg04IEuWQaVXkch+We2rgyOyIrPKbK1KakxQ9BpQr+w
         9DXswu+o0T8prDBQ50Mn9M0/JPkoLDNlmLJf5F+RLM+IHvBf6Z5f4GRKFdGq4b9Acqh+
         x2H56jXQ5uCd3cDoslpqVObSQXbhSZeH3VQwu7sfq1GXvjUgZGe287cbHHUEmRRo02rR
         s5DdgNDDkLNNp76y6x/5F2N4lvMNgwLXq6bAI9ACS/MwF2ylNHtqUwAkwAtAp0DRlLp/
         O2sbEc1SpsiWTc2VxJazo1KvhCcejUJ+zlmK2lymxBgVLNuGZCffHDNYA3yOFqAGaGPh
         UfkA==
X-Gm-Message-State: AOAM532+rgXwI6RjthkSeI7pPIlE3O9OTcdO/JG8TLytSGG6pLNw0Js4
        XamBUeib6lqMRbNFRKa+PKI=
X-Google-Smtp-Source: ABdhPJz+sNoa4IauymiO0QPYoGU3qEZ+1oxwE2kF+OyKboio7NNBxS5o2iKbDI/RYlo6BENrQ4ErhQ==
X-Received: by 2002:a63:ef15:: with SMTP id u21mr7606542pgh.56.1607621014536;
        Thu, 10 Dec 2020 09:23:34 -0800 (PST)
Received: from [10.230.29.166] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 193sm7070169pfz.36.2020.12.10.09.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 09:23:33 -0800 (PST)
Subject: Re: [PATCH -next] thermal: broadcom: simplify the return expression
 of bcm2711_thermal_probe()
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, nsaenzjulienne@suse.de,
        linux-pm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20201210135432.1249-1-zhengyongjun3@huawei.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <168fadb8-85b9-3d9f-42dc-e9d7fb3ce6ec@gmail.com>
Date:   Thu, 10 Dec 2020 09:23:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201210135432.1249-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/10/2020 5:54 AM, Zheng Yongjun wrote:
> Simplify the return expression.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

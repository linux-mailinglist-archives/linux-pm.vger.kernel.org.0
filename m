Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008D53BC7CF
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 10:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhGFI2y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 04:28:54 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:35785 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhGFI2x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jul 2021 04:28:53 -0400
Received: by mail-pl1-f181.google.com with SMTP id b5so11613441plg.2;
        Tue, 06 Jul 2021 01:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qabbY+pEzBX5IabOFy4EagDM+c+oQRQVcWIiQMtPGRg=;
        b=ZejeOlc7CtGvJ7gMs7RU4kkBRSCPAPyCzrcSj2MjP940+jjoKDaICEw498qvwr/on1
         gLE1nYi4sHD2cgFiwauZby0wA1Jhksm0fMjthDl9y81dz/twGWyVq/TdHIVvqLuzjvLn
         1KUCKoDTXW4yq+vH2dD3zZh5EM9KYrYaaKm1sWmd+abGMulpeftfa4lQ8fbMrwNw+UX2
         EGIYJJJCYklDk1XVEhWfGgO37BYyQMkLMFGHZw9hvQE4/RDMq32I2IHGMTYmAg1PA+zL
         F95OiS/F3Y+Cytqaytv8BVYBxZ3oOf71ha8BvQGTnP3PpiXgQsP0KrDN0+LwmpIfkkLh
         /XEg==
X-Gm-Message-State: AOAM532EO/9na2h+6lgEoNm9QaCtgjqkZGmIsrl8T2Vx1be93St9sQi0
        +H4luca46IDYu+y/GFXn1lM=
X-Google-Smtp-Source: ABdhPJyNc3BK2TXYevT7SstZQep53CWbA0XwUTRU/qUJj+GSi9cfM3os4sgERAEFaWn3nAQAfRibtw==
X-Received: by 2002:a17:902:be0d:b029:11d:6614:88cd with SMTP id r13-20020a170902be0db029011d661488cdmr15980079pls.40.1625559974416;
        Tue, 06 Jul 2021 01:26:14 -0700 (PDT)
Received: from [10.101.46.79] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id gk20sm13457113pjb.17.2021.07.06.01.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 01:26:14 -0700 (PDT)
Subject: Re: [PATCH 0/2] thermal: int340x: processor_thermal: Add additional
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com
References: <20210517061441.1921901-1-srinivas.pandruvada@linux.intel.com>
From:   You-Sheng Yang <vicamo.yang@canonical.com>
Message-ID: <4d0a0a3a-432f-95af-7a98-21277c81d2e3@canonical.com>
Date:   Tue, 6 Jul 2021 16:26:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210517061441.1921901-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Works for me for bringing up PCI MMIO based thermal device.

Tested-by: You-Sheng Yang <vicamo.yang@canonical.com>

On 5/17/21 2:14 PM, Srinivas Pandruvada wrote:
> Add additional attributes to RFIM, which use mailbox commands. 
> 
> Srinivas Pandruvada (2):
>   thermal: int340x: processor_thermal: Export mailbox interface
>   thermal: int340x: processor_thermal: Export additional attributes
> 
>  .../processor_thermal_device.h                |  2 +
>  .../int340x_thermal/processor_thermal_mbox.c  | 12 +++-
>  .../int340x_thermal/processor_thermal_rfim.c  | 55 +++++++++++++++++++
>  3 files changed, 66 insertions(+), 3 deletions(-)
> 

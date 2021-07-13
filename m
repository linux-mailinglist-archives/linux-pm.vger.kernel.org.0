Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97D23C7724
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 21:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbhGMTj1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jul 2021 15:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbhGMTj1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jul 2021 15:39:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4BFC0613E9;
        Tue, 13 Jul 2021 12:36:36 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso2748202pjp.2;
        Tue, 13 Jul 2021 12:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TpQHf65Ik3D6LEmz8uYca7Nj09jMm6ic1Na904x1Oew=;
        b=Nzu5ep0h8kxJfsQQoxoMvx4VODiQ4xwwkUG1FTG38JHH1SMCH1W9kUuxqPyqRAGwqS
         1ELVYZ3lfp2U3oUWRJLxeUUhyTketHHEvgPehoP6cJJrVv+ACqSOJ7UtV6eDPABB4qEE
         Pe8DJk12p4dMRY/GKzI+m2QfTX0UnmHV+dYmM8NAIqoo8jmllDWKjfY7otD+xrhI2t1D
         ahcrfr/0G5lInU3A3edSXaYnwDWRGCeos0r0rF/3JksepiN0AWDH18EvbzYaTzb72iwj
         nsywTZG7kT5za/eYihFs8KfKMBcmEGUPEtidZC1ZTkyhJ9UC5Yy2KyEU5fANt3mFTqKo
         hBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TpQHf65Ik3D6LEmz8uYca7Nj09jMm6ic1Na904x1Oew=;
        b=nL58fnWlQPYZuhpAhKEyytbs5pgZAKuKgr90l28Cq8Klyu6r/JJ2py+vAtEZ0DBmIH
         g4R3PbXRj+6aRDghO/AhRJzDV26P4AlHs7WzZ1XMybHY2FTQVWuIUHkPDxZFmU49Ayxf
         qriPxJ4/NFkmoqVqngK7P8XP+AyKtX+VCrPQvjogskb6cWX3+KZNaJQH6OTFBgGZJgCp
         zciXLt3LQK6GVPtwgXVGYTJj1JzIoH3St1bZlgiIHhU1+LqMAGAdMz3ZybqxZgzjcetP
         VmB30hqjPd9UlpTVAINb7XTqgGqURTC64gB9rRBrHrqZi39JVxlfsytc1r9UWpvJb8nz
         fQQA==
X-Gm-Message-State: AOAM532DWB0SSlcFduJrBYesXxlWU2p14zn5ftSDlTNihPOnwY8ZE+dl
        K1a0btn7Iivpajqpb2dFdxuCNp/hiMqqRA==
X-Google-Smtp-Source: ABdhPJysc3FzLP2lhiD8Y5oiNHV3g8wZhAYHFqX2wUzW3EDBdZo/JYqv2Mt+QRRJcwto5EZqWHaYLQ==
X-Received: by 2002:a17:90a:6d82:: with SMTP id a2mr5783514pjk.150.1626204996028;
        Tue, 13 Jul 2021 12:36:36 -0700 (PDT)
Received: from [172.30.1.52] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id x9sm229575pfd.100.2021.07.13.12.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 12:36:35 -0700 (PDT)
Subject: Re: [PATCH 2/4] PM / devfreq: Export devfreq_get_freq_ragne symbol
 within devfreq
To:     Matthias Kaehlcke <mka@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     andrew-sh.cheng@mediatek.com, hsinyi@chromium.org,
        sibis@codeaurora.org, saravanak@google.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        chanwoo@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210617060546.26933-1-cw00.choi@samsung.com>
 <CGME20210617054647epcas1p265359058d489661e09d8d48d4937ca7b@epcas1p2.samsung.com>
 <20210617060546.26933-3-cw00.choi@samsung.com> <YNIqsJLqWNSg2oxM@google.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <539530bb-12f2-3537-4e52-f5c07631f4c4@gmail.com>
Date:   Wed, 14 Jul 2021 04:36:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YNIqsJLqWNSg2oxM@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 6. 23. 오전 3:23, Matthias Kaehlcke wrote:
> On Thu, Jun 17, 2021 at 03:05:44PM +0900, Chanwoo Choi wrote:
> 
>> Subject: PM / devfreq: Export devfreq_get_freq_ragne symbol within devfreq
> 
> nit: s/ragne/range/
> 
>>
>> In order to get frequency range within devfreq governors,
>> export devfreq_get_freq_ragne symbol within devfreq.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> 

Thanks for the review.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

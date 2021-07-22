Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB9B3D2681
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jul 2021 17:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhGVOkl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Jul 2021 10:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbhGVOhq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jul 2021 10:37:46 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8EDC0613D3
        for <linux-pm@vger.kernel.org>; Thu, 22 Jul 2021 08:18:21 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id y6so5649529ilj.13
        for <linux-pm@vger.kernel.org>; Thu, 22 Jul 2021 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NI1tkVPHHCoVNKoha3MwqOvNjOSw9sWtWtPdC8h3zH4=;
        b=Ahn32Cse8RzK3iPlUhzEXMgCqlvtSlil4ECp75F5+sIaZ02CcWWp9/Vd+RcRBiYgAc
         93II+fSGzfGxh82aVjM64byakIpTqHX62IghtE6b5xsu1RYBFcHOka8xRRbgXrx+h8o8
         apYS0erZEFF0VBhVVxk4aFiSs6ee3qCc0EIdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NI1tkVPHHCoVNKoha3MwqOvNjOSw9sWtWtPdC8h3zH4=;
        b=OWJd15flKOI4Wb4ny0BYCmT1oVfUTp1NlU0JJlqsREmMhiVCRe53fo9vMzMBPsjozR
         hU53Fu1EdWrjjHY0hiEfZJlLKPBDEmvjp8JeYErd01jxHwiTbDUuREOlzanOgic+D1T6
         4RMMC9BUzWLc7/E0/1gQsABYGtnczib6I0lyqQVOGSC2HoJLoQqijD3p8Hvfvnp/b2Gj
         vN3LIC+8svhl0QABGSNSNWKofAktzvX9fz3fLzr5wSFadW3v4vc2YaeBdYLC31VGOWDV
         9KQsOLPw4W6YYL4r5b/6io9wBQbf1lslQER214BjnJ+hax0gg+WvvTZVvvhJezUOQpEi
         OYAQ==
X-Gm-Message-State: AOAM530SoHpevbgVKiDuXmpw8KHXAnOkwKlyHTSod1VLtlRF2Z847pBo
        5HeI6D4o15WkWvOoCDFGfG4ThQ==
X-Google-Smtp-Source: ABdhPJxPORMVGq60hUklsfidz/YTKslTfwxtHpvsxEKSZRelKAXW+THXMg90COpcDtEtyUVxutzd8w==
X-Received: by 2002:a05:6e02:170c:: with SMTP id u12mr261404ill.116.1626967100492;
        Thu, 22 Jul 2021 08:18:20 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e14sm14805326ilq.32.2021.07.22.08.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 08:18:20 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] cpupower: Fix amd cpu (family < 0x17) active state
 issue
To:     =?UTF-8?B?5b6Q56aP5rW3?= <xufuhai1992@gmail.com>, shuah@kernel.org,
        Thomas Renninger <trenn@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lishujin@kuaishou.com, xufuhai <xufuhai@kuaishou.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <b709dee3-4337-56bd-9ecb-a983142e416d@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f4a86da9-446b-7104-e785-b4380dbc216a@linuxfoundation.org>
Date:   Thu, 22 Jul 2021 09:18:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b709dee3-4337-56bd-9ecb-a983142e416d@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/30/21 12:58 AM, Ðì¸£º£ wrote:
> From: xufuhai<xufuhai@kuaishou.com>
> 
> For the old  AMD processor (family < 0x17), cpupower will call the
> amd_pci_get_num_boost_states function, but for the non-root user
> pci_read_byte function (implementation comes from the psutil library),
> val will be set to 0xff, indicating that there is no read function
> callback. At this time, the original logic will set the cpupower turbo
> active state to yes. This is an obvious issue~
> 
> Reproduce procedure:
> 	cpupower frequency-info
> 

Please resend this patch and the following from the same
address as the Signed-off-by.

https://patchwork.kernel.org/project/linux-pm/patch/2dccdf57-1546-e55e-2efe-3ac91ed7f043@gmail.com/

thanks,
-- Shuah

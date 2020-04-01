Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6AB019B5F9
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 20:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbgDASxL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 14:53:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37492 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgDASxL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2020 14:53:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id t11so611339lfe.4;
        Wed, 01 Apr 2020 11:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VQyVAIIzutwqkyfYTNBDUtxgmiM5XluCAPUUzt8tYzA=;
        b=f6gySMu1/KZQldaiJU0HZJUMHNrOnxP9JYzubf0ZtdqHGg17TYXOEPnL2zzm6i60z+
         fyvd+zeJaDcjjpP063I5iap8UpVQ/W6MlvDFoz5f3Pqu3bVS2ILx5LlQcy8vv8BqFgGe
         P8e59Mx99j2zmRknwfwagy6FdFytVtcFDuZwl33FQY0hQo7yxEK2iabBX4JPOJK8naoz
         3mAnrOUHLaPHKH3zkGwpDDrwP8DaKxRum47ipUBYKF4ZFrdDUFwqj8Xu9ZBZZJqk56UJ
         G/EvoiOxAA9DA6YC6QpSaa0i3U85CfZtWtxWUxyUIoRYNjIAHbmHmr+jmpC/39TtX6gI
         cVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VQyVAIIzutwqkyfYTNBDUtxgmiM5XluCAPUUzt8tYzA=;
        b=oxVEsRdxDSsuvnJlSRvLlpRKSRq9iAICd9dm9vqSTZo5Wr8hyHqoskF/Rm0A3kLVqV
         LEgqRku+mhdQgp37/Ci63l5wROlE5astNjLr/AXG8FikMvlDUeISbvSqfgVvYZuIb8U1
         t4cogiZmgjq22l/Bv6W6U0C0E8R/lVkYsA5kdecK62ymlL991xgvtHJcbLpd0YdZfWT1
         z/3xE1SqYs15x/KsXO/L+EoSSTRQX/rHiw9sbH9jOmpSp3j/2JZicW/nM2mIlqFnqd9q
         aUHRCJKGPAy80jg5BSnkjoa0muyY427hqkvbsAc0ZXea4W/8jiYRKI3E3ifjYKsp3RUp
         LCMQ==
X-Gm-Message-State: AGi0PuZVlTlCY8Fct5/ypKloHrFUsEu2wp2anu47X4C1l/6ffZVurGKX
        5lOp/3RWB3H/6gxpRokJVRGSCiY/
X-Google-Smtp-Source: APiQypIV05zgsqDTXLVW5bZguap7w/VMZhzPsGkTPE9hu+3T5hqetEJ2wZ/8yhmmfTcgVkqrD50d/Q==
X-Received: by 2002:a05:6512:66:: with SMTP id i6mr15684865lfo.48.1585767188616;
        Wed, 01 Apr 2020 11:53:08 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id t144sm2224533lff.94.2020.04.01.11.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 11:53:08 -0700 (PDT)
Subject: Re: [PATCH v1 5/5] PM / devfreq: tegra30: Make CPUFreq notifier to
 take into account boosting
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200330231617.17079-1-digetx@gmail.com>
 <CGME20200330232026epcas1p2234ae241b9693555b4df74aab3d8aee9@epcas1p2.samsung.com>
 <20200330231617.17079-6-digetx@gmail.com>
 <afcc9f80-c102-da42-8f7f-9b66417a9d4d@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9b79b19d-3cd2-6ea1-1e86-dd008ded3d3f@gmail.com>
Date:   Wed, 1 Apr 2020 21:53:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <afcc9f80-c102-da42-8f7f-9b66417a9d4d@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.04.2020 02:29, Chanwoo Choi пишет:
> Hi Dmitry,
> 
> On 3/31/20 8:16 AM, Dmitry Osipenko wrote:
>> MCCPU frequency boosting needs to be taken into account in order to avoid
>> scheduling of unnecessary devfreq updates.
> 
> "in order to avoid scheduling of unnecessary devfreq updates."
> I don't understand the correct meaning of following description.
> Could you explain it more detailed?

Hello Chanwoo,

I'll update the commit message with a more detailed description and make
this patch standalone in v2. Thank you very much for taking a look at
the patches.

BTW, please also take a look at this patch
https://patchwork.kernel.org/patch/11409037/

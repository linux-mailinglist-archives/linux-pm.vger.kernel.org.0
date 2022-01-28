Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C454A0432
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jan 2022 00:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344498AbiA1XXS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jan 2022 18:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344371AbiA1XXS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jan 2022 18:23:18 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D062C06173B
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 15:23:17 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id k14so6544139qtq.10
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 15:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FpAj9Y7dvaJZf6ZzQS5VW7bcqjc+TlVLM4FJ3l3N0hc=;
        b=sl1WjZxq/DMnPgMxbKR9Vp7K5qz284aeb5QD4IhjFx6HNiN6lT5XUAohvJxXf6HNWY
         jUWILOCJUg7Co1NTYYAqix5kl/l4sRpuh7TALBwNe00yEZEAxquXHx0I1G8ui3LAgcJh
         FovH88Qm9hNsXl68Hym6MEaox/UPaagUYz31TctPFiR5q4ea5YETz5pf0T865kILo/7z
         i1pKRSftU4mSvVlOzAw6X0kAXmwfADOsTregF/MzjWndMFM5TUBpatxy4DxOZDIHU5SL
         8WOt/q+kMR+cmoCeLyifg2A6w2IEbv1rwZQkl2lsrMz0R+Tpfj3K/fV01knQtNR/NBeD
         QXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FpAj9Y7dvaJZf6ZzQS5VW7bcqjc+TlVLM4FJ3l3N0hc=;
        b=tIg9DZUx81h6OiOKEZrxew7E6mWxigItRpIbtRIR/Q3noQ+voWLtYbH1lPaOdKg6GA
         ajOzfdNc8KvMOp7Q6wDokwKOIV5/tKJTZseHm5hpnpc9HITOBsUCHuZCdKzNOiDNJA8S
         FmZQKGWGtOP1tvuNje1FI8kyE1Zf5uCW7IFIJoLLb8uV68Sy2j68eLptUzkkLxvp9HP+
         YRasCLkXa4TgkJcsamwOJK/lTfeQeaI8gTPO2u4aC6JjBb7uEkai5jhlCDAYfhuJgauy
         egrFkAKLzTeS/bwjEWt6ftb7CvTmlWsAFCTSxpOG1zqL6k7cBIFF/gyxsLtRZErYgO66
         Adzg==
X-Gm-Message-State: AOAM530nZdhBoO7xHnkredg8uAQll31lWsavMlytw1mYjiHexuRc4IUa
        n+nzQwXxGp+WjHbKrYCqCGIK2w==
X-Google-Smtp-Source: ABdhPJwrb50Aks/jPsN8k3q1XydK6Rql5r3L6QCZ3EWehRR5kFzSnP2QFAIBWNVAZw1K2SFj6WDVCw==
X-Received: by 2002:ac8:594b:: with SMTP id 11mr7813040qtz.463.1643412196394;
        Fri, 28 Jan 2022 15:23:16 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y15sm4173023qko.133.2022.01.28.15.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 15:23:15 -0800 (PST)
Message-ID: <251a8515-7f8d-2535-e222-17443266f275@linaro.org>
Date:   Fri, 28 Jan 2022 23:23:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 2/3] interconnect: qcom: msm8939: Merge snoc and snoc_mm
 into one
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     djakov@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        jun.nie@linaro.org, shawn.guo@linaro.org, benl@squareup.com
References: <20220128161002.2308563-1-bryan.odonoghue@linaro.org>
 <20220128161002.2308563-3-bryan.odonoghue@linaro.org>
 <CAA8EJpqvDqTH3+ATsdC2pwtfT-OWpLNSUgOPmeU_Tpu8Uqa1+g@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CAA8EJpqvDqTH3+ATsdC2pwtfT-OWpLNSUgOPmeU_Tpu8Uqa1+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/01/2022 22:24, Dmitry Baryshkov wrote:
> This would lead to higher frequencies being set on both 'normal' and
> mm snoc clocks, thus (possibly) increasing power consumption.
> 
How so ?

There are four clocks

bus
bus_a
bus_mm
bus_a_mm

The last two clocks

SNOC performance points are
0 | 19.2  | XO
1 | 50    | GPLL0
2 | 100   | GPLL0
3 | 133.3 | GPLL0
4 | 160   | GPLL0
5 | 200   | GPLL0
6 | 266.6 | GPLL0

SNOC_MM performance points are
0 | 19.2  | XO
1 | 50    | GPLL0
2 | 100   | GPLL0
3 | 133.3 | GPLL0
4 | 160   | GPLL0
5 | 200   | GPLL0
6 | 266.6 | GPLL0
7 | 320   | GPLL0
8 | 400   | GPLL0

Its GPLL0 being set, the snoc_mm clocks really just map back to GPLL0

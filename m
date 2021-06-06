Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C869939D1F5
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 00:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhFFWnN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Jun 2021 18:43:13 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:38649 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhFFWnM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Jun 2021 18:43:12 -0400
Received: by mail-lj1-f179.google.com with SMTP id a4so19482203ljd.5;
        Sun, 06 Jun 2021 15:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1GGJToq6i4FyeVRgJK+tocSjb9/+pC5ZQ5M4IXJpq6o=;
        b=Mem2B/UUWNTL5KuAVNcaL+JsgqvSnNRdJmEc38/EL5Bd7Z2BKqK9r1EKj8Sj457dyO
         iU4G5KCRV5XLcqfZQScec5zKVJilmpzfesbGYHQAAx0wZ6PP2Gg5NI/c5BO6h4JqJS2g
         ZtpTL8R9ZCuPEhq3OtDeO5wQFRh88cSWcmnwsiG2He/FErIA/Fhp+iFz/mXJ31TF1Jrr
         11pFrQHZtZzv07LhoJblgiaqh8P/f1+Lbq/FkOjdRpkKOhTMIoPUO+wDR+wFM7D47Fb1
         Uatr90zTItMQHqKNlDGTFwdbhQwgLTIKhGH/yY1Ceju2E6wSAqtlSivrUXYcFiW5vTQ6
         R8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1GGJToq6i4FyeVRgJK+tocSjb9/+pC5ZQ5M4IXJpq6o=;
        b=Z9ZucJ2F9NvwQmD/SVGL4EP6MtDcZSDmBs3+5Lx3nMsFhSN4W4EuUG/pDpTFTCp1EW
         UxEIK+hCjs+HVhpJrciIGSDX3CMjB6PtwjVxTiafkVwKfkCprAxsBeLiST0aDmJMuRlp
         k2aJx6o90mswUtENzUfSm8JSQf/8EUXdkolchWPIeHngcx5DWAWS+DEi50HuZmG+n/aq
         TH3NsVTBeCeWsbFvyp8iqHHG8P5jQYbV8SKgw9vmmnM3va1Frs2Cwd53wFXEaD+FcG9v
         CjEJlFgSoXdWs6IlKcIoRzi3LDSNNIe4TAytFMIGquFuiZE1nBxSPrxFsCB3rauCTVs6
         CZQA==
X-Gm-Message-State: AOAM532JP2LK0Qc6hzwLAbxhbeAgGPdMbVc+NS86kDYv/HKbJBKhEp5J
        zoXr8i1GyReldM56zucKJ+A=
X-Google-Smtp-Source: ABdhPJyMQu9/FcrHkV8dRQItFculAkw1RXMxChQnHeiFJuNFbl7PO6XBoALQ1s94VBaENxwY6u/FNQ==
X-Received: by 2002:a2e:7018:: with SMTP id l24mr12562657ljc.12.1623019208259;
        Sun, 06 Jun 2021 15:40:08 -0700 (PDT)
Received: from [192.168.2.145] (94-29-51-134.dynamic.spd-mgts.ru. [94.29.51.134])
        by smtp.googlemail.com with ESMTPSA id q184sm1728861ljb.54.2021.06.06.15.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 15:40:07 -0700 (PDT)
Subject: Re: [PATCH v18 0/2] Add memory bandwidth management to NVIDIA Tegra
 DRM driver
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Matt Merhar <mattmerhar@protonmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20210601042108.1942-1-digetx@gmail.com>
Message-ID: <8accfe1e-fc48-21ca-f7c6-bd2d60162e6d@gmail.com>
Date:   Mon, 7 Jun 2021 01:40:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210601042108.1942-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.06.2021 07:21, Dmitry Osipenko пишет:
> This series adds memory bandwidth management to the NVIDIA Tegra DRM driver,
> which is done using interconnect framework. It fixes display corruption that
> happens due to insufficient memory bandwidth.
> 
> Changelog:
> 
> v18: - Moved total peak bandwidth from CRTC state to plane state and removed
>        dummy plane bandwidth state initialization from T186+ plane hub. This
>        was suggested by Thierry Reding to v17.
> 
>      - I haven't done anything about the cursor's plane bandwidth which
>        doesn't contribute to overlapping bandwidths for a small sized
>        window because it works okay as-is.

Thierry, will you take these patches for 5.14?

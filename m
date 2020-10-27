Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763F829CA86
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 21:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436598AbgJ0UnY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 16:43:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46981 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410965AbgJ0UnY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 16:43:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id 2so3253565ljj.13;
        Tue, 27 Oct 2020 13:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VlRzTBC/wBfxIpRQ0M8e1w6Q9iv9Exe50KxjDSUm4w4=;
        b=G1BlqOi2pjvzRVs3HvfPFPkqbhpWnWCJiikVWY0XuAuqM2kF+Ylp+lx+m8xXO8j3tc
         FfClw88SUXnmRYXe0FMsD6HQAG4SRghdehMeuK0zJVRl3sjwXsM6bb9yEFtD4bmGCJgA
         +DWETyLdbSMC8wm7X0rtyDEf6+L9sxL2MWju8h/QC1mLgPSp1wQHq1hJ7A24lKZM61UH
         EHukawD/+jWnvnkhA++W0M7yz9LqwPpOxeaJhv2IfZ8tgabsj9J/XOwQ9qD+le2+Ebaz
         fC6W/2k8GNKYtMgPj2q/p7ic1/0HiJIHyhwtyTtES3vbiTPy5x+kYvyiyaWnRdZgT9W0
         e/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VlRzTBC/wBfxIpRQ0M8e1w6Q9iv9Exe50KxjDSUm4w4=;
        b=S3JClarjrXpLon1bNF1u65eXwjXYniifP8j0Tlj3/sp6UpEd8n5B9XeHQ+XcRhG9Xz
         8JY9fYHBEdrJKTVak0OZw41REXFbHFALPsvAHCT3c2+t/MP3/+/UvpRG0zIqCeKvubWk
         mvS5Lg+IqiM0n94pnSPbh1tEObY7YEvUTXDJDZNxIpWKQjvdT+WY9tmX+/DJTJDs3IPV
         9vnAP1eL09jJVZX/Y7q687q0w9yhzoBQkZ6xyuMKRyn9KsCZXlE1wuX7Q8MioVrqajo8
         ey5yhJHEdP5de7xUWkVPBcgCvRyC2g/qscRWSzwl4vbm4aDEInDa+Rq3INkQaIOdawbU
         W2yA==
X-Gm-Message-State: AOAM532HvH5u1kQouVpkXFrALDGgqqORJynp2qSG4VmLB14JYDjOUwhT
        oDgnVeE8sROF1jaMXVe6S0RvJeOnzS0=
X-Google-Smtp-Source: ABdhPJwV7piP5X+R0inxjR4SPntPEKhqLLUshXb2nOipuobs7nneYkUyh3iE9F/yaRbx+xb1ibcoxQ==
X-Received: by 2002:a2e:7018:: with SMTP id l24mr1904408ljc.313.1603831400162;
        Tue, 27 Oct 2020 13:43:20 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id b2sm313232ljo.5.2020.10.27.13.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 13:43:19 -0700 (PDT)
Subject: Re: [PATCH v6 20/52] ARM: tegra: Correct EMC registers size in
 Tegra20 device-tree
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-21-digetx@gmail.com> <20201027091043.GJ4244@kozik-lap>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <42802a15-734e-5531-88fc-c82f0248a9d8@gmail.com>
Date:   Tue, 27 Oct 2020 23:43:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027091043.GJ4244@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 12:10, Krzysztof Kozlowski пишет:
> On Mon, Oct 26, 2020 at 01:17:03AM +0300, Dmitry Osipenko wrote:
>> The Tegra20 EMC registers size should be twice bigger. This patch fixes
>> the size.
> 
> Don't use "This patch" (this appears here). Better to use:
> "Fix the size of ..." or just "The size should be twice bigger" as it is
> obvious that you fix it.
> 
> https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L151
> 
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks, I wasn't aware that it's a preferred wording style now.

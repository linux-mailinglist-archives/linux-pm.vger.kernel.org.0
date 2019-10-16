Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19BD1D9394
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 16:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393947AbfJPOUH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 10:20:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40846 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393943AbfJPOUH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 10:20:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id f23so2142479lfk.7;
        Wed, 16 Oct 2019 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+5GVeXUsNTKRD7nI80WxY7NGPp8wxmIdfIuqXlentqk=;
        b=sBh6QYKgOgCu4gMfkvOftsEMGSteOjetdyaAI1OsXKNFyHllDHwkEPyOP/YI7MzDFS
         i9XUsdtl5lJ2avwDtXmahDALdD6jKGKFn76Bl0AfISFgvTYxidpJMRZIEDoAbx0g8mTW
         6cqNbqTHEG/7635IgoQyzRdRWE3zhdGK2q2iLO6oPrfEt+7lfjK9OQxWLYIdMRDpB09t
         uQU3Wj3VfXAuotv/V54LRQMtvNlve9U8l7aHgTXJN3H1/uWKtJTtpmrLHXZC4soU7mpP
         f2YPytDFjxsDqa6v2I/dMSppH05wrW2i5H7piRr35zKdyKP9yBR2/d7/oyhiuBQugmYE
         2e8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+5GVeXUsNTKRD7nI80WxY7NGPp8wxmIdfIuqXlentqk=;
        b=aZpddXhm4o8f3KejeYTsulOKZouOj1UN3zyNUmsgmSqmHF1Yey7lTl8m12AsUWiZgm
         R5Zv2ouGd1NKUb0jinnIh8WqGv/2xWq/pWWrCpjRx19fuNZoPL5Vjt601+BXdHnvfqaF
         4l6qvKTtpcFvwJ5+NvxVj1XRsNxSiwGMHUvj6LYi29bsKubCjxF10qnGsPKXsulYgvcZ
         VFRcWMm//4sMlRS6WRAW6iUjZ3SK9pldgmd50sRtV4yOdTaH+jf5anU8ZLvzyZnsv4xY
         Dj7UszM93LZvJfBwmHea5kvcZHC5JtMMOc7/MAquYAEKbKoNj1Y/sB2YmfPqaJgvurTP
         Ai6g==
X-Gm-Message-State: APjAAAUXZy2Tf3piUZKA3CRx+ofaDMOj9nKvHHQX0M624bSEihaMiQp6
        +uFj+j6hoGZYgPbpabSTqcYd6W8t
X-Google-Smtp-Source: APXvYqycvQtQ48h3Trd2F44847GlKWuh2TeLS/AO5nfxSjr3wgNCA7+XnvoMdGiGkUg6rDTL3w9aYQ==
X-Received: by 2002:ac2:4650:: with SMTP id s16mr1212030lfo.32.1571235603749;
        Wed, 16 Oct 2019 07:20:03 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id c21sm6429120lff.61.2019.10.16.07.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 07:20:03 -0700 (PDT)
Subject: Re: [PATCH v1 00/17] NVIDIA Tegra20 CPUFreq driver major update
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191015211618.20758-1-digetx@gmail.com>
 <20191016052716.yipztnpg7bcuzhfn@vireshk-i7>
 <8cf055a3-57fd-c275-9e74-a9fb5d284866@gmail.com>
 <20191016140121.GA1862769@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d0cf9fca-eb95-1986-4c2d-ae3cded324b0@gmail.com>
Date:   Wed, 16 Oct 2019 17:20:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016140121.GA1862769@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.10.2019 17:01, Thierry Reding пишет:
> On Wed, Oct 16, 2019 at 04:16:27PM +0300, Dmitry Osipenko wrote:
>> 16.10.2019 08:27, Viresh Kumar пишет:
>>> On 16-10-19, 00:16, Dmitry Osipenko wrote:
>>>> Hello,
>>>>
>>>> This series moves intermediate-clk handling from tegra20-cpufreq into
>>>> tegra-clk driver, this allows us to switch to generic cpufreq-dt driver
>>>> which brings voltage scaling, per-hardware OPPs and Tegra30 support out
>>>> of the box. All boards need to adopt CPU OPPs in their device-trees in
>>>> order to get cpufreq support. This series adds OPPs only to selective
>>>> boards because there is assumption in a current device-trees that CPU
>>>> voltage is set for 1GHz freq and this won't work for those CPUs that
>>>> can go over 1GHz and thus require voltage regulators to be set up for
>>>> voltage scaling support (CC'ed Marcel for Toradex boards). We could
>>>> probably add delete-node for OPPs over 1GHz if there are not actively
>>>> maintained boards.
>>>
>>> How do you want to get these patches merged ? Can I just pick the cpufreq bits
>>> alone ?
>>>
>>
>> The cpufreq bits strictly depend on the clk patches and the regulators
>> coupler/balancer series. Hence all patches in this series should collect
>> acks from relevant maintainers and then Thierry will pick up the
>> patchsets in a correct order via tegra tree, at least that's my vision.
>>
>> Thierry, are you okay with that approach?
> 
> Works for me. I already have a set of clock patches that I'd like to
> merge via the Tegra tree because of a runtime dependency, so it'd be
> easy to apply these on top of that.

Awesome, thank you very much!

Viresh, then only acks to the patches related to cpufreq driver are
needed from you for this series.

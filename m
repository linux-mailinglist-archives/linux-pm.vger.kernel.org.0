Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA147E0C1
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 19:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbfHARKr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 13:10:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40591 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732281AbfHARKr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 13:10:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so63904736wmj.5;
        Thu, 01 Aug 2019 10:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FghonA4IabkJaTgLr8fM3E6htRJ5CzRRLsDA7y0O0VY=;
        b=IXREDAqVq4+TQykJaNC3vMKRY1s8sfyb4cqoqV1qIJHds766TvFSenvnluadnn3JGN
         49vKKJKm4LipWYwD5He7qF0AHhwSe10Hu6DLske6AsXxiaporx3njUEjBmcYekgdTvnq
         5rnH632NNorGfygsGzzUazJX3QP618R5+SyZTlK0ExbbWUDfmVF3Jk4RMtOx1pdVAtBR
         FAgM8kIL74JD/bfgmJe8IA2dfAay3nmkLdGTZX6V3YX+tmUEMojSASxMsyyif6AqBJCm
         gpQEsHfz/KJkXN18bals8U3lmH6qEhVmI0Eftbhtdy0yHkLKIm05QttGenqwbLX2x+CC
         n5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FghonA4IabkJaTgLr8fM3E6htRJ5CzRRLsDA7y0O0VY=;
        b=VpWkZr5nMewFWFhg3z7jh7UVwyfYThXdTu6I4Y0xhWtGfkP0kKgpcKb57HUDXulSOk
         0tZ9ckDMCsLvqHt8ef0QzbnOzBMU8ZVr7+el5zRa88uUvh8H6lSPwc2XXKmL3e4H/B4v
         iWaw8h7n6mM14k/6/2PuJV//u+iJf32iH2PZL0q+G2HVCzED61RUhMvy6jVkLQpEeDey
         Rh4uIhhmJybU4Zm31dyWVI0wbYpwNuevv5Zw+tYRRJv2LaBSnvmg/eOOWraggysuiW2y
         uT+mNWMVIhoS5l4HFR6Zxp2IhVHVQ0BeIhDL1s8qcoCxkAt+p81dpaEfOd+G/GmlSoNP
         MOaQ==
X-Gm-Message-State: APjAAAUzntiNPvwmjqM2zAbcW2YQ8vgKYYOniYMuLAodcvRYuNlmT851
        C6Rn//DDIypXrEXR4RSD8GPWZeqe
X-Google-Smtp-Source: APXvYqxByZB/gh88C6wRDNij3X4Fh7cbfowCUmSN5SWstCnDpG/3spte6L9Wyr3/77AaFAU2sLB6xg==
X-Received: by 2002:a7b:c455:: with SMTP id l21mr119115981wmi.114.1564679444023;
        Thu, 01 Aug 2019 10:10:44 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id u2sm5377105wmc.3.2019.08.01.10.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 10:10:43 -0700 (PDT)
Subject: Re: [PATCH v7 10/20] clk: tegra: clk-dfll: Add suspend and resume
 support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Jui Chang Kuo <jckuo@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>, Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Sandipan Patra <spatra@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
 <1564607463-28802-11-git-send-email-skomatineni@nvidia.com>
 <4400ffef-685f-b9e6-3b07-4790f851282c@gmail.com>
 <501a9d0e-ce78-9b35-642d-dff7f9223926@gmail.com>
 <BYAPR12MB3398C388471BC5811614C8FEC2DE0@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <31990250-e237-ddb9-ce71-29b7c2302fc3@gmail.com>
Date:   Thu, 1 Aug 2019 20:10:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB3398C388471BC5811614C8FEC2DE0@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.08.2019 19:10, Sowjanya Komatineni пишет:
> I didn’t updated any patches. This is still same v7 just resent with
> CPUFreq maintainers in CC as I missed to add them earlier.

There are now two different threads for the same patches, which is not
very good. When I said that CPUFreq maintainers should be CC'ed, I
didn't mean to resend it all, sorry for not being clear about it. You
should've wait for more comments to the original patches and then make a
v8. I suggest to do the same in the current situation as well, please
address all the current comments and wait for 1-2 days, then make a v8.

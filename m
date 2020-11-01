Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34E32A1F4B
	for <lists+linux-pm@lfdr.de>; Sun,  1 Nov 2020 16:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgKAPtU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Nov 2020 10:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgKAPtT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Nov 2020 10:49:19 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52950C0617A6;
        Sun,  1 Nov 2020 07:49:19 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id l28so14139514lfp.10;
        Sun, 01 Nov 2020 07:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+IMMWwTBpIuU34muTgua4oEKfGJdORV+B0XtK66fJrc=;
        b=CH53aYEYM+ZxNJAYZtHdmiWk27hMZvw57vtMxIUKweWLPnQ1zL8KTxXSLLaQP6pJ6H
         CUeC1l9MqRH+Nno4rcVnD6fZ9Tr/yDkBUk4cu2wdh8Dji0FhT7jXrEc+4pL9X/ptuPD3
         Hb3Sys5CXMsgTzKwZGJouWzFlc41nQfJ6NftUYNSEAqjIPus7ZcGWGTmt0HXysGzbVp6
         aQ+4zxSgXSuvGkWWcGlJhJMNyo1BiZxfp+Ku9L/APZSBgeE61Xkp9p4kL6htxBH2WzZ6
         4R90X1KyAl1/KNdI99Z0ZX1Le9FoJabWU2LXGilSKg8cj1/R8jCESOeHWYofOZLaWOAB
         o3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+IMMWwTBpIuU34muTgua4oEKfGJdORV+B0XtK66fJrc=;
        b=ILvtkWct2W3TQRDNEglI8IoiRWB5V/aaiQ1y2Qj7cHNtYaophPM871Z4s6dfHVwtr8
         GsNS5FxC7NiMblEUG00YdADrRmW5nz6UxiQT6S9UxOFYNtU0pLd2p0mVrxSWv08tFNxm
         /ypJ35NolU/fNn/npnG67P8BK6DzK10TnL7rAJfNtdPXvy1udFlPl1ocvdZWoI88VODS
         SmsEfgH5QWAvOsAwqvxd4ueBch/q1MRP94dsQQeLFzmoOWGZxJd/7GC2AE+Ta1WKh0rc
         XRTuqXknyr2k+6tuHdZtajwv7JBn2Kw417ms2Y39nyZvLbdfjjsDrGZ07ZiikKsDxWYR
         0wKA==
X-Gm-Message-State: AOAM530LzpQw8vICdCo8z4NNWW2ZglgVAY/BX2S8EK52wilw/Pcprfbx
        Xk1+Ek3E1n3k4XFT0XyFQA04aKCq27k=
X-Google-Smtp-Source: ABdhPJyfbmcSEmTMH443D7OLJRec3W7yiy/1SR2NX2guVnd/pVsXQbN96ATE9WOlpP88kx03VxbOzQ==
X-Received: by 2002:a19:414b:: with SMTP id o72mr4634104lfa.23.1604245757706;
        Sun, 01 Nov 2020 07:49:17 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-177.dynamic.spd-mgts.ru. [109.252.193.177])
        by smtp.googlemail.com with ESMTPSA id 196sm1571873lfg.209.2020.11.01.07.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2020 07:49:17 -0800 (PST)
Subject: Re: [PATCH v6 51/52] PM / devfreq: tegra30: Support interconnect and
 OPPs from device-tree
To:     cwchoi00@gmail.com
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-52-digetx@gmail.com>
 <CAGTfZH1PV4r-pD=zTKD71nQb5+UobJKa5mBv-Nb2ZgSubkscjA@mail.gmail.com>
 <2ebd184c-60e8-19e2-9965-19481ced1c70@gmail.com>
 <CAGTfZH0=6R02euOR3JHgA0iLq5++Yvp3Z_wBCEs7bzkfuorEFQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5f5a22b1-4d01-5698-1bca-6bcc66c55e6f@gmail.com>
Date:   Sun, 1 Nov 2020 18:49:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGTfZH0=6R02euOR3JHgA0iLq5++Yvp3Z_wBCEs7bzkfuorEFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.11.2020 18:44, Chanwoo Choi пишет:
>> OPP core will try to grab the clock reference for the table and it may
>> cause EPROBE_DEFER. Although, it shouldn't happen here because we have
>> devm_clk_get() before the get_opp_table(), hence seems the deferred
>> probe indeed shouldn't happen in this case.
> It is my missing point. If there, you're right.
> Could you provide the code point to check the clock reference on the OPP core?

Please see it here:

https://elixir.bootlin.com/linux/v5.10-rc1/source/drivers/opp/core.c#L1101

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCE92A34C8
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 21:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgKBUAi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 15:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgKBUAg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 15:00:36 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F507C0617A6;
        Mon,  2 Nov 2020 12:00:36 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id v6so18969671lfa.13;
        Mon, 02 Nov 2020 12:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fmGeQz4Og6FDipaMU7MfHyA+Ho1Q2EbyeVQm7OOUMbk=;
        b=Met36lmBPZbI3Bg/Pi0BDLI/08hKmflwudKsCksniYRSnC2W/wiUPktXMcCMYINb+O
         rnW3KpYgGqt6fxwfqGSoOmb4XiPe3VezWY7KCiemXYzWkwNgSEGpOgUogVpm09EeZivV
         xIgQ/72kcfGJSipTedh4kjJc48ivxagpm/moGDHqHS/jm2iNCk4KY/KZ7aWfTGumeg7n
         CwFwoVUuEoXAZz1cgjbeIJAtWqlAxKUci6wnx2w/PRfbQWjp6xzpnK+i5K8n1hdDrO1z
         +nnfSO1vJ9GcSOU8KxsEicROpjhfr3ZgX6xqqRr7xqWzgo4/xB1cn7CdgvRcWL96lURq
         PUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fmGeQz4Og6FDipaMU7MfHyA+Ho1Q2EbyeVQm7OOUMbk=;
        b=e9P1j1W3qot0kvdkeodpjHikzRG5QdhzjrVtWCKXLTpcLgYnwqG/P1WyfubQOs1iNZ
         r2/pbTiPTmo3BiVupunRi9dP+wP3A0zCujDxxxx5hqOdinzjDkW5hfN9QiYDyLTEWwj6
         JcxjpphlHs0Z9s84UtNT6acKdJj2iyDfm1p9Z0zABlVa37PmGqFfeJc9neouypUIUs53
         FLehNou3RJ3sUf6OIEIjshJG8981HPH5j0XxyisdmG8GbtBt9/MPtg8K+B0JtiVf+9Ca
         Rlfj6e6jbXWHPCbm46weSuHvSOjK2h0PVj6MVdFiY9R6g9ZMaKb2CCk1fbYc7wmnDBTh
         942w==
X-Gm-Message-State: AOAM531GcGvcX63r0sRgFNjhItEitGNfxi1+UUEXCqHAmWqF6tPFzXiR
        igG8761V73fFfViT7H+9tTbqEY0UjBs=
X-Google-Smtp-Source: ABdhPJzGAN9ixbmRmzZSK6h8lOS09fz7Yt/jWFfwFXsjxUpkLxmWqAQ38fK9Cv8CucOCcjXzDPd2iw==
X-Received: by 2002:a19:5f5c:: with SMTP id a28mr6131558lfj.434.1604347234537;
        Mon, 02 Nov 2020 12:00:34 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-177.dynamic.spd-mgts.ru. [109.252.193.177])
        by smtp.googlemail.com with ESMTPSA id h26sm2932372ljl.55.2020.11.02.12.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 12:00:33 -0800 (PST)
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
Message-ID: <85772f5b-1b3d-5bff-7b2e-5b00b83c8a20@gmail.com>
Date:   Mon, 2 Nov 2020 23:00:33 +0300
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
>>> I recommend that you use dev_pm_opp_of_get_opp_desc_node(&pdev->dev)
>>> to check whether a device contains opp-table or not.
>> I'm not sure what are the benefits, this will make code less
>> expressive/readable and we will need to add extra of_node_put(), which
>> device_property_present() handles for us.
>>
>> Could you please give the rationale?
> IMO, 'operating-points-v2' word was defined on OPP core. I think that
> the external user
> of OPP better to use the public helper function instead of using the
> interval definition
> or value of OPP core directly. Basically, I prefer the provided helper
> function if there.
> But, it is not critical and doesn't affect the operation. If you want
> to keep, it is ok.
> 

I'll prefer to keep it since it's better for the readability of the
code, thanks.

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289232516F7
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 12:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgHYK7m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 06:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYK7k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 06:59:40 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE8DC061574
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 03:59:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x64so5223779lff.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 03:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZkjxOJSy0BoPadr9ot2GqBBcEBJI6dWcsWXbUglkcTg=;
        b=td2eqSucUtlTxkX+np5yb/3VWeWVlwqboVblvIJxYkOw8/iFH/c0C9tvasHmnWpxTZ
         sdcBr6GQAp6pP4LC/q9Onzvq4HDo6UeGbaS384EVLBkNQede9GsTEKiz44w4N5Wh3s07
         cxotiy0mlZrUP7h9eeVoN4uIZ5iSQwQO2nq9AS2yE7oACuGq4mzprc+o+LArWVpUilk3
         eWtYQgN+gO2mM4y9Cosn0vKM1RSIFBq4sIX0uvXZZWGD5h/KU/a2inLzPTIcRZkJ0s2Z
         PWjESHBaorAsotQxw0pmv/OPNZrwWKibSxGuBzu9OyZ41d6rYUv6F3nwS3u5LLC7wFIS
         51rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZkjxOJSy0BoPadr9ot2GqBBcEBJI6dWcsWXbUglkcTg=;
        b=Z99jK5gJ/2vKKt2XyffVVahbl36cHuI/GKK/CXk+bnRCWA7ssxED6+k3eDJvP2MeBx
         4ilfYLY0ojM01aExyHgl5pDAfC4TEyg46KhLPtHYkVVSE9ARE/ZaXweaoikaWAOajoTY
         atVZpscgu6MygvUQjbw5+TA3RTDaN2AmLlil2VGgHHhK8DYdX/PuHTyfsOzW/IVxHUE/
         MMIZmMt32depInYNqaWnVn4dXXuTnlgAz/blBeRNnHRU6H+413/zIAA/ZzemCgVeT2Y8
         PnGbvK4YYGcqEBVmZXErrlBe5rbwoIZxYzF6RJsY+Gr9gJ8BXQPLOmznHThz4AdM6HqB
         elow==
X-Gm-Message-State: AOAM533XJXS/yTGfds8hk9yTZeusOBK3dzKJutBbSdU1W3VlWjsaU6kY
        FqHaaV/g8RtUHgZmp8bl6tinyj+6nyM=
X-Google-Smtp-Source: ABdhPJyByBJNR3MO/Ad+rovxRl/kMOr19tW5gUl/epq7JoLbWtbGS1Hvxl0MzsURcSHPtmhs/Y3MCg==
X-Received: by 2002:ac2:4837:: with SMTP id 23mr2564404lft.145.1598353177915;
        Tue, 25 Aug 2020 03:59:37 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id l13sm2970445lfk.18.2020.08.25.03.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 03:59:37 -0700 (PDT)
Subject: Re: opp: How to use multiple opp-supported-hw versions properly?
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org
References: <20200825074452.GA1322@gerhold.net>
 <20200825081637.opfmtccwczn6jtlo@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cf786fe1-0725-705a-b239-6080166e6a64@gmail.com>
Date:   Tue, 25 Aug 2020 13:59:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200825081637.opfmtccwczn6jtlo@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

25.08.2020 11:16, Viresh Kumar пишет:
> On 25-08-20, 09:44, Stephan Gerhold wrote:
>> Hi Viresh,
>>
>> (an unrelated questions while I investigate the device links ;) )
>>
>> I'm a bit confused about how to use "opp-supported-hw" properly
>> when you have multiple versions defined.
> 
> Documentation/devicetree/bindings/opp/opp.txt gives some explanation which I
> thought should be enough, maybe it isn't :(
> 
> Or maybe I am oversimplifying your problem and I myself have forgotten this
> property and its usage :)
> 
>> In my case I have two version numbers from 0-7, so theoretically up to
>> 64 versions. This does not fit into a single version mask
> 
> I don't think this is correct. The opp-supported-hw property must be thought of
> as a bitfield where each bit represents a version.
> 
> In your case a single 32 bit value should be enough IMO.
> 
> <0x00FF00FF>, here each FF can support upto 8 versions, which is exactly what
> you need. Now if you want to support version 3-3 (where version are numbered
> from 0-7) for an OPP, you set this value to: <0x00080008>
> 
> Does that make sense ?
> 
>> so I added
>> them as separate versions to the OPP table.
>>
>> Now let's say I want to limit an OPP to v0.1, v1.0 and v1.1, but not
>> v0.0. With a single "opp-supported-hw" I think I can only say:
>>
>> 	opp-supported-hw = <0x3 0x3>;
>>
>> but that does also include v0.0...
>> I think to exclude that I would need multiple version ranges, e.g.
>>
>> 	opp-supported-hw = <0x1 0x2>, <0x2 0x3>;
>>
>> This does not seem to be supported, though.
>>
>> I believe a similar situation exists in tegra20-cpu-opp.dtsi:
> 
> Dmitry, can you please explain why you were required to have multiple entries
> for each OPP ?
> 

Like Stephan said correctly, this was done in order to exclude the
unwanted overlaps of the versions.

I wrote a script that generated all the OPP tables and there was no
intention to make output human-friendly because there shouldn't be a
need to change the default OPPs on Tegra ever. It's still possible to
easily specify customized OPPs per board if this will be needed by
anyone because the common_opp.dtsi is included by each board DT
individually and not by the common tegra.dtsi.

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD842116BC
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 01:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgGAXlI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 19:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgGAXlH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 19:41:07 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DF3C08C5C1;
        Wed,  1 Jul 2020 16:41:07 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id s16so9296602lfp.12;
        Wed, 01 Jul 2020 16:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RRbpFTrpv2CAyc73C39i4Eh5fUq8y8ua8EeETi+isng=;
        b=rIOsGHd2+UGL+iszD1JJDQkzBEEDzUF0t4Ww/jguiyg3EmeFGYUlODeIQcGLWkMBU6
         F4c6vdB9WBAxG8nc5C4n2l8rhBxP47vpZ7xH5yBRJlLx1ed0vD5uB+h7jUGmprpZ2Vi6
         eN20HFNMgQfmODS7LwYGJd5KtpGUElA2mAtmWVQACQWUK9B2e7QuYRcr6/RgyuSRvDFh
         L2E/BDeJBHN/0Mt18JmoeStrgbMHA+5aaYWbGSOoHE53KYOOlhavE9GqfyT3SjHgIiOj
         Jhk/q6w18OQxpkxz6LDXO6P7kox7XYZc8KAsr9iZgqUi7+lcR3uWnbt6HzOpJaIZRKBl
         muPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RRbpFTrpv2CAyc73C39i4Eh5fUq8y8ua8EeETi+isng=;
        b=qrS4rK2+gpZuNqvp/pB8zfGOsJw9pPyDpQHB9xSOz/hjEUjfxz8d+81ALBw0SmzvE3
         bTuvD54FCMLLuHyEJN5oAYoVhab0toJAPPjstjExfj9sQiTW8JYGCqI2ZtQCjpqDJRSM
         +Si1vV5wMdGLcum3C9ODcz/QRNbOi7I5W3qL8TWYDOfvgSjlQ1jIzGoVHeFqYJj+K/b3
         zSYuWa5MKULTewavTHRLipqgWRO3bQCnyOH7OAtNzs/KuYoexYJacUYDXGO2wv76UuEU
         bOKBrb1DVwTm3GWW+NDHY8Au4loj2rScHDVyf1/6HhkgkPPayXq/Z6vJULhMu4t95qiB
         QD6w==
X-Gm-Message-State: AOAM533UCAuGqNMTWmV0WVb1R+oxD3X9Ij5wy6Esl4AyHSDTrjihoXVn
        zQkcEgeMs1Wav/FBT8fEhF9gGxjIDJc=
X-Google-Smtp-Source: ABdhPJz6pai9jEk4qOJM3yHcyoJZJ3X5EJNiH6TMgrwAtCtMNVi1xc0abdH95NFEfjbBLreScuwj3A==
X-Received: by 2002:a19:23cc:: with SMTP id j195mr16661019lfj.210.1593646865567;
        Wed, 01 Jul 2020 16:41:05 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id l5sm2864306lfp.9.2020.07.01.16.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 16:41:04 -0700 (PDT)
Subject: Re: [PATCH v4 27/37] interconnect: Relax requirement in
 of_icc_get_from_provider()
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20200609131404.17523-1-digetx@gmail.com>
 <20200609131404.17523-28-digetx@gmail.com>
 <3b410ea3-26d3-6f7a-213c-40dbabbde8d1@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <95f476ce-081d-a222-2b98-96e6f8217c30@gmail.com>
Date:   Thu, 2 Jul 2020 02:41:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3b410ea3-26d3-6f7a-213c-40dbabbde8d1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.07.2020 20:10, Georgi Djakov пишет:
> Hi Dmitry,
> 
> On 6/9/20 16:13, Dmitry Osipenko wrote:
>> From: Artur Świgoń <a.swigon@samsung.com>
>>
>> This patch relaxes the condition in of_icc_get_from_provider() so that it
>> is no longer required to set #interconnect-cells = <1> in the DT. In case
>> of the devfreq driver for exynos-bus, #interconnect-cells is always zero.
>>
>> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
>> [digetx@gmail.com: added cells_num checking for of_icc_xlate_onecell()]
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> I have already applied the original patch by Artur, so please make the cells_num
> check a separate patch.

Okay, I'll update this patch! Thank you!

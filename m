Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB988263850
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 23:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgIIVQH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 17:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbgIIVPz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2020 17:15:55 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ADAC061573;
        Wed,  9 Sep 2020 14:15:55 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u21so5417672ljl.6;
        Wed, 09 Sep 2020 14:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HnVKigTPD0SFBmS6CufvtEE5hp82hUFW+McOGmr8ObQ=;
        b=AEMv6CEcQnDBpdKHTGDMpkqWbBkkyC3XIxDghgAq6QwSz0FWI1czP7m0rAzo79YaUO
         HhSPr/YEjsCxhLZNISf2Be4NR3orDy7ZMU3ziy+PCzsbiOvedaK+eULC3/znoKwQpZQN
         yEFMKl+0lLsRF885mZeeYpXmXqdzwu2hriKD0arnoUdoFgdQq/W7VbK0tMmb4llhPzLH
         mylxshFdjPd7CFrrJjAFAcdxxmHgEZQUtW8vDl46F6E2AS+0y0rImqP+AIcfI+PYsOlt
         0lsDcTyRVia/TrfsxcEeguz4Au8Zcsz1oZXSrbyLfaWKtThupylDm5rqOR7ozYYE3wOt
         ou7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HnVKigTPD0SFBmS6CufvtEE5hp82hUFW+McOGmr8ObQ=;
        b=j6YOlfc+i9nYu4BbHNVQbikoz3VLtx3rKUbGHci6QejzkdvPQtYnom1IAI18aKAspo
         HiHJLVYkLp4Q8n5vBO7Q+e24u5HM+H7z9me9Bqa8Pn95esVHwCSgL/WmWSnRzeUB+gKp
         u0tBOHrEy8iIaCcI9RqJuyr57FrHZ1lhdi9kNbfTpftF3stT+SfP69ECRb7WX19qiiD6
         2pIpVYB6NGMsXwYXVl72YbOYJmlF9vU+0HceaCTcp1miAQpbH1FZeqJCjKwwyeDI9EHg
         o5vebFgTAxU5RFjI0A8TdaGEyCDG75CywStqg+0LPX5XwtAfYp8IMOsM79AFdl3Cgga3
         sT8A==
X-Gm-Message-State: AOAM530NuBi/HUzoz2zhQPZS4csxmEaW8rqw/WjWoEr6i4sj6lXLQ5N4
        6fMvbysnFNdhHhvLdR/N5tYO6ALxong=
X-Google-Smtp-Source: ABdhPJxp8VYmLXdjWwfoDoXk3NH/mFiHKjQmDtqVaj5hvvbbW+sEPnZMlMfqd4r/5YSVXyKy5zLhqw==
X-Received: by 2002:a2e:3c08:: with SMTP id j8mr2597735lja.358.1599686153003;
        Wed, 09 Sep 2020 14:15:53 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id j7sm821561lfb.41.2020.09.09.14.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 14:15:52 -0700 (PDT)
Subject: Re: [PATCH v5 27/36] memory: tegra-mc: Register as interconnect
 provider
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20200814000621.8415-1-digetx@gmail.com>
 <20200814000621.8415-28-digetx@gmail.com>
 <923b6801-5194-b936-13c6-0972761c29b8@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <01996606-84cd-909d-8dfc-4f33bdf8f3cc@gmail.com>
Date:   Thu, 10 Sep 2020 00:15:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <923b6801-5194-b936-13c6-0972761c29b8@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.09.2020 11:31, Georgi Djakov пишет:
> On 8/14/20 03:06, Dmitry Osipenko wrote:
>> Now memory controller is a memory interconnection provider. This allows us
>> to use interconnect API in order to change memory configuration.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Thanks Dmitry! Looks good to me.
> 
> Acked-by: Georgi Djakov <georgi.djakov@linaro.org>
> 

Thanks you!

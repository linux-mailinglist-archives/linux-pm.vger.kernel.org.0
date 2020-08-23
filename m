Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D2C24ECAD
	for <lists+linux-pm@lfdr.de>; Sun, 23 Aug 2020 12:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgHWKMr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Aug 2020 06:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgHWKMr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 23 Aug 2020 06:12:47 -0400
Received: from [192.168.0.50] (89-70-52-201.dynamic.chello.pl [89.70.52.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CBE82072D;
        Sun, 23 Aug 2020 10:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598177567;
        bh=vgekt/oUcGhRishM57H2nAdn1OyccYawtqidY+MMVB0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=m8eVVKbLGNZEYV7BzTl0k74Z50K49rt9jOLt3TV9b/ClVUOn3pYCGzTd3rlqOgrP0
         Z9F1H8rZLi0oGfKBVMhML/nKp2HK6iW33TdsXVRezfEUkXs6lUwJtfJQio4uDuJkzD
         wt0X9QnkusGHSOXA3e4dz/K0/t4e2N1yfQPU8hSw=
Subject: Re: [PATCH v2] clk: samsung: Keep top BPLL mux on Exynos542x enabled
To:     Stephen Boyd <sboyd@kernel.org>, linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <CGME20200807133152eucas1p1d83611a984f5c5d875192d08e2f5711f@eucas1p1.samsung.com>
 <20200807133143.22748-1-m.szyprowski@samsung.com>
 <159780685238.334488.5802955284004610550@swboyd.mtv.corp.google.com>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <f4c87130-25a0-2195-9caa-be805d207c34@kernel.org>
Date:   Sun, 23 Aug 2020 12:12:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159780685238.334488.5802955284004610550@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/19/20 05:14, Stephen Boyd wrote:
> Quoting Marek Szyprowski (2020-08-07 06:31:43)
>> BPLL clock must not be disabled because it is needed for proper DRAM
>> operation. This is normally handled by respective memory devfreq driver,
>> but when that driver is not yet probed or its probe has been deferred the
>> clock might got disabled what causes board hang. Fix this by calling
>> clk_prepare_enable() directly from the clock provider driver.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>> Tested-by: Lukasz Luba <lukasz.luba@arm.com>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
> 
> Can I pick this up for clk-fixes?

Sure, thanks for taking care of this.



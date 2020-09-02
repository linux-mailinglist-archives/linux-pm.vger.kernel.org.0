Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C96E25A889
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 11:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIBJZB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 05:25:01 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33418 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgIBJZA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 05:25:00 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200902092458euoutp02d1fd867414a1afe485847837248046ba~w7TlWEM0h3112931129euoutp02P
        for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2020 09:24:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200902092458euoutp02d1fd867414a1afe485847837248046ba~w7TlWEM0h3112931129euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599038698;
        bh=vjWXrHTj5eNzI1zdagqPNoplLBM/K1uaia5vsTTRxTQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PFfP3UltAo/saDaa1XqLuzHz+dIXKUBgPOFxYQXiB/xok0u5sjFzrKfF1o/mMgnxH
         JMbCEQ/DiuAx2p052jClqApyWCg3rU9MZSDDPQtmd4dRFpzBkovoyHbb6+VCObT2Ul
         bHtRpMF9uyp5kVkV8T7QB7hEcU5IZCAtil/D06xs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200902092457eucas1p24ea31e1b21f996f04174c0b4ddfe7829~w7Tk_Cfx-2940729407eucas1p2S;
        Wed,  2 Sep 2020 09:24:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EE.B1.06318.9E46F4F5; Wed,  2
        Sep 2020 10:24:57 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200902092457eucas1p2c0e5ed604adb999fd6b9035947c4d1dd~w7Tkk7LUp2537025370eucas1p2a;
        Wed,  2 Sep 2020 09:24:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200902092457eusmtrp194ec73312ae73d4660d3f2fa3e8fafe3~w7TkkR7Pd1202412024eusmtrp1N;
        Wed,  2 Sep 2020 09:24:57 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-c1-5f4f64e91d4f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5C.F6.06314.9E46F4F5; Wed,  2
        Sep 2020 10:24:57 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200902092455eusmtip15fe23ccada9ec741a6442a8c36cff619~w7Ti8Y2r02015220152eusmtip1l;
        Wed,  2 Sep 2020 09:24:55 +0000 (GMT)
Subject: Re: [PATCH v2] clk: samsung: Keep top BPLL mux on Exynos542x
 enabled
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <3ba7cf94-1b1f-a500-4c4f-a9769531097b@samsung.com>
Date:   Wed, 2 Sep 2020 11:24:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824103123.GD25860@kozik-lap>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTm3b3b7lazu2l40KgYBiWkDRUuaGLhjxWV/Yh+FLlWXubMfbS7
        WfqjxMzKpkkJm+vLLLKmsjY/irIRoptOahlYosuIBrZipvkBmmjNq+S/53nOc97nnMNLYBIn
        N45Qa420QasslPKEeIdnzr8zlJej2FU7nkQ5rQ4u9Wl6jEv5/c/41KR5lEtNVXUjyup3c6gH
        ZeV8qqX7M59a/OjEswTy5nvNSO6yX+PJq9vsSD7l2nwYPybMyKML1UW0ITnzpDD/cUMnX78g
        Ot/qG8RLUcu6SkQQQKbC+6d0JRISEvIJgqb5AcSSaQQ+n2+FTCHo/T7Jq0SC5Y6hu90cttCI
        4MbSoxUyicBT48UirmgyB/rcvfwIjiH3g2e4lhcxYaSZAy2VLm6kwCNlUNVTjSJYRGaCtYyN
        wMkEeD17eVnfSOZCu3eQw3rE0FcXxCNYQCZD02Bo+R2MjIXh4H0Oi7fA8/AdLBIGpJsPpU11
        fHbubAj8qkcsjoYf3rYVfRP03zLjbMMlBOZXI3yW1CD44l3tSIfAu3le5GYYuQMcL5NZeQ9Y
        Rm9z2FNGwVBYzA4RBTc7LBgri+BqhYR1J8Afu4XD4ji4HlzCa5DUtmY125p1bGvWsf3PrUe4
        HcXSJkajopkULX0uiVFqGJNWlXRap3Ghfx+pf9E78wK5F051IZJA0vUiq+KQQsJVFjHFmi4E
        BCaNEe19258rEeUpi0tog05hMBXSTBeKJ3BprCilIXRCQqqURvoMTetpw2qVQwjiStHBiZge
        nYYI3U83ejPSiTqBMzzBNbk9X7NmxQ5HYKQ2m/4w3qbLMYgzGoySgtQCRcXvcv12nkymTnMc
        2Xp2fnxgTupIVAS3jZWM0Re/WTT14itMQvzuzqMa9PNASJymaraL9r1xb3gYFM8oOsONFzL1
        5Zrj6tb2cG9AOSTFmXylLBEzMMq/8laJvUQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xu7ovU/zjDd5+FLHYOGM9q8X1L89Z
        Lc6f38Bu8bHnHqvF594jjBYzzu9jsljY1MJusfbIXXaLf9c2sjhweqyZt4bRY9OqTjaPvi2r
        GD0+b5ILYInSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3S
        t0vQy1i2aA97wR/eis2nrrI0MK7l7mLk5JAQMJG4MfcIUxcjF4eQwFJGidnrm5i7GDmAElIS
        81uUIGqEJf5c62KDqHnPKLHh7nM2kISwgK9E36ZFrCC2iICXxLFbU8CKmAX6mCTu7L3CCtHx
        lEni6JOnYFVsAoYSvUf7GEFsXgE7iRlNH8EmsQioSOz91goWFxWIk3jc+58ZokZQ4uTMJywg
        NqeAvsTqqy/B5jALqEv8mXeJGcIWl7j1ZD4ThC0vsf3tHOYJjEKzkLTPQtIyC0nLLCQtCxhZ
        VjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG4LZjPzfvYLy0MfgQowAHoxIP74x4v3gh1sSy
        4srcQ4wSHMxKIrxOZ0/HCfGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MDnklcQbmhqaW1ga
        mhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgdLtxIWDbLQWp6PXT6i4uCtR7+m/Z
        1N+89VNKL83NOO0l3Cb8yY21JGrHT+e/VxWvLOkSYn3QFa6QsuQbb9K65o3zJqbbr5Y9PPt2
        7Ry1RqY7CgfvWgUJrr33JWFltIfik8cCszdx/g7/c9ChcWKfZ5KopqlQ4Zmp2l/WFy0V6t/A
        Jtu4nm8WrxJLcUaioRZzUXEiAH107z3WAgAA
X-CMS-MailID: 20200902092457eucas1p2c0e5ed604adb999fd6b9035947c4d1dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200807133152eucas1p1d83611a984f5c5d875192d08e2f5711f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200807133152eucas1p1d83611a984f5c5d875192d08e2f5711f
References: <CGME20200807133152eucas1p1d83611a984f5c5d875192d08e2f5711f@eucas1p1.samsung.com>
        <20200807133143.22748-1-m.szyprowski@samsung.com>
        <159780685238.334488.5802955284004610550@swboyd.mtv.corp.google.com>
        <f4c87130-25a0-2195-9caa-be805d207c34@kernel.org>
        <fff07b05-f1f6-5333-a056-69ba6995ed4f@kernel.org>
        <20200824103123.GD25860@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24.08.2020 12:31, Krzysztof Kozlowski wrote:
> On Mon, Aug 24, 2020 at 12:28:51PM +0200, Sylwester Nawrocki wrote:
>> On 8/23/20 12:12, Sylwester Nawrocki wrote:
>>> On 8/19/20 05:14, Stephen Boyd wrote:
>>>> Quoting Marek Szyprowski (2020-08-07 06:31:43)
>>>>> BPLL clock must not be disabled because it is needed for proper DRAM
>>>>> operation. This is normally handled by respective memory devfreq driver,
>>>>> but when that driver is not yet probed or its probe has been
>>>>> deferred the
>>>>> clock might got disabled what causes board hang. Fix this by calling
>>>>> clk_prepare_enable() directly from the clock provider driver.
>>>>>
>>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>>>>> Tested-by: Lukasz Luba <lukasz.luba@arm.com>
>>>>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>>> ---
>>>>
>>>> Can I pick this up for clk-fixes?
>>>
>>> Sure, thanks for taking care of this.
>>
>> OTOH, I planned to queue that patch for next merged window, together 
>> with a patch that depends on that one, since the fix is not for an issue
>> introduced in the last merge window.
>> I guess it's better to avoid pulling (part of) the clk-fixes branch to
>> the clk/samsung tree for next merge window?
> 
> All current multi_v7 and some of exynos defconfig boots fail on Odroid
> XU3-family, starting from v5.9-rc1. On kernelci and my boot systems. If
> I understand correctly, this is a fix for this issue, so it should go as
> fast as possible to v5.9 cycle.
> 
> Otherwise we cannot test anything. The current v5.9 RC is then simply
> broken.

Right, we need that patch in v5.9. Stephen, can you please apply
the patch to your clk-fixes?

--
Thanks, 
Sylwester

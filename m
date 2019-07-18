Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1121D6CB81
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 11:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfGRJGC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 05:06:02 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:26511 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfGRJGC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 05:06:02 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190718090600epoutp03cd294ddd4cf8ebc60717b2f4ee40ec63~ydRaBomfT0833008330epoutp03m
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 09:06:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190718090600epoutp03cd294ddd4cf8ebc60717b2f4ee40ec63~ydRaBomfT0833008330epoutp03m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563440760;
        bh=qWrYdPfDRW4odSxkNZfEskpNsPLhKp0Foumpb2G/9bE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rQbKY5tTFxoZGFiiU29Ri4fmyVIuCTqClnzpMUkE3o3MdO9VfpSNymZoWHV/kU9sm
         lQusZZw6cSAOSIY9e6DpZdQ2GtAmBOzxmmF3Y8fC8OyHP3X+ZSSuKbY/5nwA6oelyj
         UAKXbry+6977g5fwgovtlYeak6gbOhTs52vYSc9A=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190718090559epcas1p3d8ce45f251b1989b3dfd227040f38f89~ydRZO3zRB1230012300epcas1p3g;
        Thu, 18 Jul 2019 09:05:59 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 45q7XP19Q3zMqYkf; Thu, 18 Jul
        2019 09:05:57 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.04.04088.576303D5; Thu, 18 Jul 2019 18:05:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190718090556epcas1p1ecf1dd1ae605ab33a62dabb56667aa9a~ydRWrl5OO0925709257epcas1p1S;
        Thu, 18 Jul 2019 09:05:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190718090556epsmtrp2cc7a9806a955c34e8f06fdfd59be2429~ydRWqeIXR1846618466epsmtrp2h;
        Thu, 18 Jul 2019 09:05:56 +0000 (GMT)
X-AuditID: b6c32a35-845ff70000000ff8-65-5d30367556da
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.5A.03638.476303D5; Thu, 18 Jul 2019 18:05:56 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190718090556epsmtip297663eca605c694ff1a6cc8b4673708e~ydRWcir8a1349213492epsmtip2n;
        Thu, 18 Jul 2019 09:05:56 +0000 (GMT)
Subject: Re: [PATCH v4 12/24] PM / devfreq: tegra30: Inline all one-line
 functions
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <45621f73-2f86-cde7-a92e-2a34810b9c05@samsung.com>
Date:   Thu, 18 Jul 2019 18:09:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b7da3fa2-00d1-5bd6-408c-202c85be917d@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTYRTv2+PuKs6+puZpRdmN/lDU7Wqzq2QERQySMHqZIPOitynuxb1b
        lAVZ9jJSSotqpb2jl1RLSwUb6DBNeif0Mitt9ND1MKOy17a7yP9+53d+5zvnd75DSlWXCDVZ
        bLFzvIU1UUS47Gp7fHKSI02bp/3SSDDnP/UjZovzuIy5tXlQwTxoOUwww5UexFR8cRLM001n
        COZ7S52Mqaq/T8wL0zf1nkT6ZmevQl9Z7iP0VQ3nkH7YNTVbnlsyp4hjCzk+jrMUWAuLLcZM
        atFSw3yDLk1LJ9HpzGwqzsKauUxqQVZ20sJik38gKm4Na3L4qWxWECjN3Dm81WHn4oqsgj2T
        4myFJlu6LVlgzYLDYkwusJozaK02RecX5pcUuQbeKmy15Frv9U5ZGeomdqIwEvAsGOp5iHai
        cFKFmxA0vW6XiMFnBK8quxVi8BXB++c+xb+SJ4335GKiFUH3vr5gQoU/IPhWkxjAUXgZvDjz
        IyiKxr8RVHwvDzaU4lXQ3nxeEsAETgD3m0dBfjyeDj3f+lEAK/Fc6Dv2KaiR4ZlQ6fMGcQzO
        gZueOpmomQBdBweCOAxnwskRLxLfj4UnA0ckIp4G5Y2HpIEhAP8hoKPshFy0sAAa+lyhDUTB
        uxsNIWtqGPa1hvj1cLbLQ4jFOxA0uO+GilPBfarG34H0d4iHiy0akZ4OzaO1oSEiwTeySx6Q
        AFbCjm0qUTIDHrzolYh4EpzYXkHsRpRzjB3nGAvOMRac/5sdRbJzaCJnE8xGTqBt9NjvdqHg
        tSbomtDe21ltCJOIilA+ojR5Kjm7RlhnbkNASqlo5dO3fkpZyK4r5XirgXeYOKEN6fzb3iNV
        xxRY/bdvsRtoXUpqaiozi07T0TQVq6z7GZ+nwkbWzpVwnI3j/9VJyDB1Gar2xG4ad6Am/YoV
        Wofa+A3ecMOk/fTW1a72GY8j52/MeUbjJbkXLl/rl3fe/7yc7wlf4akdWabe76OSX9qqI1Zm
        kR+91VMWJ6L6mdu7FhuPsx0Zu6K67iTueRbTMTvS7rn+ymg9VpVyb7Im7dIv6vTezlvvct2D
        +Tp7qSZaOugepWRCEUsnSHmB/Qsxmma5wwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSvG6JmUGswYt/sharPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY7HoW3uJzYHTY8fdJYweO2fdZffobX7H
        5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZm568ZC+Yy1HxbN8JlgbG02xdjJwcEgImEre2
        XmQFsYUEdjNKrN9eCRGXlJh28ShzFyMHkC0scfhwcRcjF1DJW0aJ/z3nmUFqhAVCJB6s+MUK
        khARaGKS2NR7gR0kwSwQKdEzdwsbxNA5TBLLVgqC2GwCWhL7X9wAi/MLKEpc/fGYEcTmFbCT
        uL/wIxOIzSKgKtH77hmYLSoQITHp2k4WiBpBiZMzn4DZnAK2Eku+PmOE2KUu8WfeJWYIW1zi
        1pP5TBC2vETz1tnMExiFZyFpn4WkZRaSlllIWhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7N
        S9dLzs/dxAiOMC2tHYwnTsQfYhTgYFTi4b2hpB8rxJpYVlyZe4hRgoNZSYT39kugEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcV75/GORQgLpiSWp2ampBalFMFkmDk6pBkYLxfzp1qtT7M2CVdTO
        H9U0+dJ+uqbHye/axavz/hmeejXz6ZHwI+0cYhEnPzgf1DuWljg15G188PMJNe2f469tfTuP
        h4l31wG7Pm8l24rX68I6X9Yzz2p9os8TwytyR/7h03tTF7vzdp82kDieV8MvyqNtU+5/4Mp6
        TQ517r/TwhiWpq+xvqTEUpyRaKjFXFScCADhFw+brAIAAA==
X-CMS-MailID: 20190718090556epcas1p1ecf1dd1ae605ab33a62dabb56667aa9a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223633epcas4p3873704f3199126be0e8d5cb7454c7a51
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223633epcas4p3873704f3199126be0e8d5cb7454c7a51@epcas4p3.samsung.com>
        <20190707223303.6755-13-digetx@gmail.com>
        <b5634fbe-8bc1-0f04-e13b-6345dfbb5615@samsung.com>
        <b7da3fa2-00d1-5bd6-408c-202c85be917d@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 16. 오후 10:35, Dmitry Osipenko wrote:
> 16.07.2019 15:26, Chanwoo Choi пишет:
>> Hi Dmitry,
>>
>> I'm not sure that it is necessary.
>> As I knew, usally, the 'inline' is used on header file
>> to define the empty functions.
>>
>> Do we have to change it with 'inline' keyword?
> 
> The 'inline' attribute tells compiler that instead of jumping into the
> function, it should take the function's code and replace the function's
> invocation with that code. This is done in order to help compiler
> optimize code properly, please see [1]. There is absolutely no need to
> create a function call into a function that consists of a single
> instruction.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc-9.1.0/gcc/Inline.html
> 

If you want to add 'inline' keyword, I recommend that 
you better to remove the modified function in this patch
and then just call the 'write_relaxed or read_relaxed' function
directly. It is same result when using inline keyword.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

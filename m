Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68926F877D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 05:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKLEfd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 23:35:33 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:34679 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLEfd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 23:35:33 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191112043529epoutp0130cf11daf6a4cecdd51670708b58e30a~WUDnYwKxf0938809388epoutp01W
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2019 04:35:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191112043529epoutp0130cf11daf6a4cecdd51670708b58e30a~WUDnYwKxf0938809388epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573533329;
        bh=vI6ohHryc6PDtdKo8eUipNTcP5NEU8Utqt5Y2U0CRfY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JEdKTnGJx7VoAKfUQa9epKTxnIGfgXKmoBaYOhg7K17MfF1TldfMXMA33Y98Nzy6z
         Qbrr9CjWeGZ6L3BKK/btJUWGV+/fAFY9juImPnAZ/JhS1T7vMYOfkroowkgM7m4wcP
         bD5Otzd4ofdmt3j0isyfqzqEI0H+luZsL9MyjUME=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191112043528epcas1p1408f56fa0480d574ffa88d17a7484881~WUDmwlXir1543215432epcas1p1Z;
        Tue, 12 Nov 2019 04:35:28 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47Bw0G4s2NzMqYkY; Tue, 12 Nov
        2019 04:35:26 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.9D.04144.B863ACD5; Tue, 12 Nov 2019 13:35:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191112043523epcas1p4a9242f2d35592913bbad377f5f3ac73c~WUDhpY0kf3058330583epcas1p4S;
        Tue, 12 Nov 2019 04:35:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191112043523epsmtrp26fbc7da902183f77c47701e4737032d8~WUDhorfXg0809708097epsmtrp2e;
        Tue, 12 Nov 2019 04:35:23 +0000 (GMT)
X-AuditID: b6c32a35-2c7ff70000001030-90-5dca368b7282
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.F4.24756.A863ACD5; Tue, 12 Nov 2019 13:35:22 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191112043522epsmtip198ab7e8d7a6c2702b9a41e7dbf2f05ca~WUDhZb-IR2865228652epsmtip1N;
        Tue, 12 Nov 2019 04:35:22 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Add usage_stat file to sysfs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <960f4bc4-b1ad-34ae-22dd-aa6b4fadade0@samsung.com>
Date:   Tue, 12 Nov 2019 13:41:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112042608.5of2bn7ubpokhqxn@vireshk-i7>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj229nONnF5XJlfBjVP9ENr6XHOjqF2pRaGGf4wApkHPcy1Kzub
        l/rRKsprF0sqp6El6hTEHFYrldWKzKzIsouaIRmkpusilhBFOztF/nve533ey/N+nwiRutBI
        kdZopS1GSo+jwfwb96Ll8srER9lxZcMo6X1wXUg+OTYjJJ1jXwXk3Kn7gJy7NgHI0aNOlHw8
        8FxA9rVnkZ3zqi1iVa19kK96+6oHVXX63DzVXV8PT9X1soSvOt3VBlRzrlUZwgO65HyayqMt
        MtqYa8rTGjUpeFqmertamRhHyIkkciMuM1IGOgXfsSdDvlOr9y+Gywoovc1PZVAMg8emJltM
        Nistyzcx1hScNufpzUnmDQxlYGxGzYZck2ETERcXr/QLc3T5X1ovCs2daNGZ6kw7KBWUA5EI
        Yglwqm1zOQgWSTE3gL0zCwIu+AbgFcdplAu+A3jtejOvHIgDFedarwIu0Qvgu9kJIZuQYp8B
        9Nr3sngpthlWnRkC7IhlWAycGqZZPYKN8mDNVDfCalA/75l8g7I4FIuCLxcmAIslWKq/51k+
        i/nYWvhx+hKP7ROO7YcD8xQnCYP9NR8CEjGWBFueDgVaIlgEHPlQz+Pwanhztg7hdq4QwjpP
        Ied4B7zzW8nRS+F0X5eQw5FwzteLcvgwbO2/H/AOsVIAuzzPBFxCAT1N5wPrIFg07Lgdy9FR
        8NbPy4AbuwT65iv/HlcCS09KOcka+GJ87O8FV8DGkjL0LMAdi8w4FhlwLDLg+D+sAfDbwHLa
        zBg0NEOYicUP7QKB/xqjdIPqp3u8ABMBPEQSlNOfLRVQBUyxwQugCMGXSdxFD7Olkjyq+BBt
        MaktNj3NeIHSf+oqJDI81+T//UarmlDGKxQKMoFIVBIEHiHZ2tKULcU0lJXW0bSZtvyr44nE
        kXYQ3rK7viKqRFymW0h9FmsNyQoO+qm+F/rYEzs+YD+4TlFScUFuW3nkuCw9QTse9inrzpFf
        2tuzJ3o6+CEzhQWuiom+hpZ0vGbc2eO0va5MttSOZP2YPPqm2DVYWu1MyzSc29dd/75wV2P7
        NqoqOphxN0crynk2XXzUu49hpvV2H85n8ikiBrEw1B9cnYjSxQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSnG6X2alYg2u/LC0OHdvKbnG26Q27
        xYq7H1ktPvceYbT4vOExo8XtxhVsFmdOX2K1OL423GLjVw8HTo/ZDRdZPO5c28PmsfHdDiaP
        g+/2MHlsudrO4tG3ZRWjx+dNcgHsUVw2Kak5mWWpRfp2CVwZH1ZOZy/YyFbRPyW4gbGDtYuR
        k0NCwERi0spFjF2MXBxCArsZJV5sfc8IkZCUmHbxKHMXIweQLSxx+HAxRM1bRon/MyGahQXs
        JSb2X2EEqRER0JJ4eTMVpIZZ4C6TxMt1c8HmCAlMZZJo2MgOYrMB1ex/cYMNxOYXUJS4+uMx
        WA2vgJ3EvbcTWEBsFgFVieevZjCB2KICERLPt9+AqhGUODnzCVgNp4ClxPJzV5hBbGYBdYk/
        8y5B2eISt57MZ4Kw5SW2v53DPIFReBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwLDvNRy
        veLE3OLSvHS95PzcTYzgeNPS3MF4eUn8IUYBDkYlHt4VsSdjhVgTy4orcw8xSnAwK4nw7qg4
        ESvEm5JYWZValB9fVJqTWnyIUZqDRUmc92nesUghgfTEktTs1NSC1CKYLBMHp1QD4+IDbY2L
        dl4/U1FvHGuvuDjb6ojH7K+rtBtqWmZNa/nU0nTtO8PsjBBOH6tbd5cyF5m9eP5ow8zvnGFm
        61lvGlxaKND+Pa6G+d2s148eOjfv9nhaLWKTY5a7anHxu8Dz4tP1KswXzblk4cmguDpwi9DD
        fw+ET5989cv3jrPDqlelBs+37ohQaVRiKc5INNRiLipOBAB9f2ogswIAAA==
X-CMS-MailID: 20191112043523epcas1p4a9242f2d35592913bbad377f5f3ac73c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191111215534epcas5p35b69167fa14a5c026b765c43faa5ec67
References: <CGME20191111215534epcas5p35b69167fa14a5c026b765c43faa5ec67@epcas5p3.samsung.com>
        <f70ebc907933717ae5fe2af5bc7f53eed0ef3308.1573508311.git.leonard.crestez@nxp.com>
        <41c7e481-7bbd-cf5c-a18c-31b4a3dd907e@samsung.com>
        <20191112042608.5of2bn7ubpokhqxn@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/12/19 1:26 PM, Viresh Kumar wrote:
> On 12-11-19, 09:46, Chanwoo Choi wrote:
>> Hi Leonard,
>>
>> The role of sysfs is not the debugging. We cannot add new sysfs entry
>> in order to get the load tracking for the debugging. 
>>
>> For the debugging, use the perf event in linux kernel generally.
>> And devfreq core already merged the perf event as following:
>>
>> [1] commit 1be0730f1dcd ("trace: events: add devfreq trace event file")
>> [2] commit cf451adfa392 ("PM / devfreq: add tracing for scheduling work")
>>
>> In result, Not Ack of this patch.
> 
> Such information if useful can be added to debugfs though.

Right. So, I have the plan to make the basic code for devfreq debugfs
because there are some requirements. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

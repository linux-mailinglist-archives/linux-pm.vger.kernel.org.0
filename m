Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C41C66BDE9
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 16:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfGQOMs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 10:12:48 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54669 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfGQOMs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 10:12:48 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190717141246euoutp01fd2e41453def55ab7b65540018dadff9~yNz_AoR8Y0958609586euoutp015
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2019 14:12:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190717141246euoutp01fd2e41453def55ab7b65540018dadff9~yNz_AoR8Y0958609586euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563372766;
        bh=e7owagyzm32/x8fQaeiUS1HzPuby4JB3XeoTnzx54mQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ABpsfu/AoPIpQ92e1e+OBC5bBSrkVN1FDhP4sqoygoxo8n0bTjyktWFxwegStsYog
         lnh3m1MItmuBO2A7SR05R/CGqpxlYFsFHW5Pp+dbD8whn9Q+SFaxS91pSHqkpMgaM5
         hCeLB9S3jPiZKjX66W+VJZPXuAm7z9sdIEyIdeCc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190717141245eucas1p2c16ff22a3ed0ebf0f56c021d47ca5616~yNz9Otly70335803358eucas1p2Y;
        Wed, 17 Jul 2019 14:12:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E5.49.04298.DDC2F2D5; Wed, 17
        Jul 2019 15:12:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190717141244eucas1p2f2a29627d97d942a7afad36f794a5190~yNz8UkrW40549205492eucas1p2P;
        Wed, 17 Jul 2019 14:12:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190717141244eusmtrp298844cfbbfdb6604b73f714120ca8a82~yNz8GN5zb3155131551eusmtrp2H;
        Wed, 17 Jul 2019 14:12:44 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-1d-5d2f2cdd021f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 36.A8.04146.CDC2F2D5; Wed, 17
        Jul 2019 15:12:44 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190717141243eusmtip2a6e78e0dcb3c2d83be7dcabbbaf919ef~yNz7aE4OC2299922999eusmtip2e;
        Wed, 17 Jul 2019 14:12:43 +0000 (GMT)
Subject: Re: [PATCH v2 1/4] opp: core: add regulators enable and disable
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
Message-ID: <297179a4-a542-0836-6192-e06369fdcae5@partner.samsung.com>
Date:   Wed, 17 Jul 2019 16:12:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9acc7dd0-614b-ccd3-a485-eeca3dab494b@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0iTURjGO/su+xSnx7nwRSNjEV3UWZR0SLtSuaAioj/Cslz6YZIz3Zym
        /dFmljdSUciaogXdMM2ctxS7TXOEmpRRM82GZnaTyksk0sztU/K/33ne5+F9XjgcJbUxPlxs
        fBKviVfFyVlXuqF9qjvwfUBQxNrqSh9Sc6WaIW8nRhhS3vaCIflD3yjS3X1fTLrSv4uJaegN
        Q3qaS1kyfqkNkSvdj0Skqu29mNx8+1JE+gx3WPL9T5eIXHjYJib2NzU0qbW1s9s8lZVllUhp
        qshmlbU3zinz6iqQ0mJtFCnHTUsPsOGuodF8XGwyrwnaEul60lRURCfUys68erZPj5pwDnLh
        AG+A6SfXaAdL8R0EVaMJOch1licQFD0zscJjHEF7p5GdT0ykD1LC4DaC4inrnGsUwZcffxmH
        ywsrwfJ6xJmQ4VVw9e9r5DBRuIeGy4OFThOLN8JgY6fIwRK8G2rqOygH03gF6PP6neHF+DCM
        2VoZweMJz69+dJZ1wVuh4XMfcjCFveHdx3KRwH5wvr7EWQ+wgYOahlqx0Hsn5NfdpAT2gq+W
        ujl9Ccw0CWHAKTB8PU8shDMQ2DJ/0cIgBFotL2dbcLMbVkN1c5Agb4fCklvIIQN2B+uop9DB
        HQobiilBlkDWRangDoSymU5GYF/ImbnHFCC5ccFlxgXXGBdcY/y/9xqiK5A3r9OqY3jtung+
        RaFVqbW6+BhF1Gm1Cc3+uw67ZewBmnx1wowwh+RuEv2yoAgpo0rWpqrNCDhKLpNsnvSPkEqi
        ValpvOb0cY0ujteakS9Hy70lZxfZjkhxjCqJP8XzCbxmfiriXHz0qGhTpf6xLHuP/ZZcEZi4
        0l4SOp15uXeAoxWG372dBn84pkg/6rXb/jQsuEWeV74yY/Gn9A8juYl+VVmKkVHdGVl4wMAO
        jyFDeEtHT1rpXc1a893P0ba44ahNVY3rM04Eq62HdMF7H3lEin8O9O9fnniwYFe026rsXOtF
        c25+SJi3nNaeVK1bQ2m0qn9iGAzTcwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xe7p3dPRjDfZdlbTYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XaI3fZLZZev8hk
        cbtxBZvFmx9nmSxa9x5ht/h3bSOLxeYHx9gcBD3WzFvD6LFpVSebx+Yl9R59W1Yxehy/sZ3J
        4/MmuQC2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27
        BL2MTZMnsxRsFqm4dNS3gXGnQBcjJ4eEgInEl6ZHzF2MXBxCAksZJS7uecUKkZCWaDy9mgnC
        Fpb4c62LDaLoNaPEs77zYEXCAh4Sx688ZwOxRQQ0JGb+vcIIUsQscJVF4vzGOWAJIYE2Jon3
        E1RBbDYBc4lH28+ATeUVcJPYuPU0M4jNIqAq0dB3B6xeVCBC4vCOWYwQNYISJ2c+YQGxOQXs
        Jba9uA0WZxZQl/gz7xIzhC0ucevJfCYIW16ieets5gmMQrOQtM9C0jILScssJC0LGFlWMYqk
        lhbnpucWG+oVJ+YWl+al6yXn525iBEb4tmM/N+9gvLQx+BCjAAejEg/vDSX9WCHWxLLiytxD
        jBIczEoivLZftWOFeFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YfPJK4g1NDc0tLA3Njc2N
        zSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTAWVIhl16SXv1+4ws8/RNiDp2/fGY7bfGKx
        VhflZj3kUJ4T3VFYe6h+5blAEdO8jeEhBRfVl/2PiH/Im7raZlPN5RknueN0W68ceBrZaSMY
        OEdwysLIwoc22kf7ctPa+5XuJlp0JpsIaHnePeYyS/xr86cpot63mOO6/u1cr7PU6+uqJr9t
        O5VYijMSDbWYi4oTAS3AVUMGAwAA
X-CMS-MailID: 20190717141244eucas1p2f2a29627d97d942a7afad36f794a5190
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715120430eucas1p19dddcc93756e6a110d3476229f9428b3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715120430eucas1p19dddcc93756e6a110d3476229f9428b3
References: <20190715120416.3561-1-k.konieczny@partner.samsung.com>
        <CGME20190715120430eucas1p19dddcc93756e6a110d3476229f9428b3@eucas1p1.samsung.com>
        <20190715120416.3561-2-k.konieczny@partner.samsung.com>
        <9acc7dd0-614b-ccd3-a485-eeca3dab494b@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16.07.2019 06:03, Chanwoo Choi wrote:
> Hi Kamil,
> 
> On 19. 7. 15. 오후 9:04, Kamil Konieczny wrote:
>> Add enable regulators to dev_pm_opp_set_regulators() and disable
>> regulators to dev_pm_opp_put_regulators(). This prepares for
>> converting exynos-bus devfreq driver to use dev_pm_opp_set_rate().
> 
> IMHO, it is not proper to mention the specific driver name.
> If you explain the reason why enable the regulator before using it,
> it is enough description.
> 
>>
>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>> --
>> Changes in v2:
>>
>> - move regulator enable and disable into loop
>>
>> ---
>>  drivers/opp/core.c | 18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index 0e7703fe733f..069c5cf8827e 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -1570,6 +1570,10 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
>>  			goto free_regulators;
>>  		}
>>  
>> +		ret = regulator_enable(reg);
>> +		if (ret < 0)
>> +			goto disable;
>> +
>>  		opp_table->regulators[i] = reg;
>>  	}
>>  
>> @@ -1582,9 +1586,15 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
>>  
>>  	return opp_table;
>>  
>> +disable:
>> +	regulator_put(reg);
>> +	--i;
>> +
>>  free_regulators:
>> -	while (i != 0)
>> -		regulator_put(opp_table->regulators[--i]);
>> +	for (; i >= 0; --i) {
>> +		regulator_disable(opp_table->regulators[i]);
>> +		regulator_put(opp_table->regulators[i]);
>> +	}
>>  
>>  	kfree(opp_table->regulators);
>>  	opp_table->regulators = NULL;
>> @@ -1610,8 +1620,10 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
>>  	/* Make sure there are no concurrent readers while updating opp_table */
>>  	WARN_ON(!list_empty(&opp_table->opp_list));
>>  
>> -	for (i = opp_table->regulator_count - 1; i >= 0; i--)
>> +	for (i = opp_table->regulator_count - 1; i >= 0; i--) {
>> +		regulator_disable(opp_table->regulators[i]);
>>  		regulator_put(opp_table->regulators[i]);
>> +	}
>>  
>>  	_free_set_opp_data(opp_table);
>>  
>>
> 
> I agree to enable the regulator before using it.
> The bootloader might not enable the regulators
> and the kernel need to enable regulator in order to increase
> the reference count explicitly event if bootloader enables it.
> 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thank you, I will change commit description and send v3.

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland


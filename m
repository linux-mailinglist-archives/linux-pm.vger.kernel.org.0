Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72054390E82
	for <lists+linux-pm@lfdr.de>; Wed, 26 May 2021 04:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhEZCv6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 22:51:58 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:40188 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhEZCv5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 May 2021 22:51:57 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210526025024epoutp02baecd34024714476c74548c81b8a41f1~CfhBkcoMX0867208672epoutp02-
        for <linux-pm@vger.kernel.org>; Wed, 26 May 2021 02:50:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210526025024epoutp02baecd34024714476c74548c81b8a41f1~CfhBkcoMX0867208672epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1621997424;
        bh=tyBZ7OFuRi9bEQ8p2rvrGW0NFjmKK4W+w9n1YR0iE+Y=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RtEMFS6qmpLDpTg3LAZYp87Jh4mu3R8UjhyydBxR663opS8xPuWtZ/qzagH0PEvhA
         6vt+uqBFihSbE9i1Fy8StmYtFM/msW4o4zYezjDW3eJ3Epg00yk8SYAAlocWU1LtLY
         x+o0ee3fBp/YyIsUoqUBB+GkG82huqb3OBBwl00c=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210526025023epcas1p3dac4849351c6d4f49c42e87e5ab1a357~CfhAmXhWv2533925339epcas1p3t;
        Wed, 26 May 2021 02:50:23 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.155]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Fqb652NFKz4x9Q1; Wed, 26 May
        2021 02:50:21 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.0B.09701.D67BDA06; Wed, 26 May 2021 11:50:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210526025019epcas1p48e8136bc939e4fd65cbbf56db4ccb239~Cfg8phb6f2104521045epcas1p4E;
        Wed, 26 May 2021 02:50:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210526025019epsmtrp2330a7961f7312d554b36506126411e20~Cfg8oiu5q2922929229epsmtrp2x;
        Wed, 26 May 2021 02:50:19 +0000 (GMT)
X-AuditID: b6c32a36-631ff700000025e5-9d-60adb76d7f63
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.27.08163.B67BDA06; Wed, 26 May 2021 11:50:19 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210526025019epsmtip2eebbc2657eb498ec01613c5d68bafcd4~Cfg8Xg2nC3137531375epsmtip2J;
        Wed, 26 May 2021 02:50:19 +0000 (GMT)
Subject: Re: [PATCH V8 1/8] PM / devfreq: Add cpu based scaling support to
 passive_governor
To:     "andrew-sh.cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, Sibi Sankar <sibis@codeaurora.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <dd58c29a-35b1-b853-bc4a-3225b21b082a@samsung.com>
Date:   Wed, 26 May 2021 12:08:43 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1621995727.29827.1.camel@mtksdaap41>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPJsWRmVeSWpSXmKPExsWy7bCmnm7u9rUJBi9/cFpsX/+C1WLqwyds
        FvOPnGO1ONv0ht3i25UOJotNj6+xWlzeNYfN4nLzRUaLz71HGC2WXr/IZNHUYmxxu3EFm8Wb
        H2eZLM6cvsRq0br3CLvFv2sbWSyuLXzPajH9rpDFxq8eDsIea+atYfS43NfL5LFz1l12j02r
        Otk87lzbw+axeUm9R8vJ/SweW662s3j0bVnF6HH8xnYmj8+b5AK4o7JtMlITU1KLFFLzkvNT
        MvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CeU1IoS8wpBQoFJBYXK+nb2RTl
        l5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl5+daGRoYGJkCFSZkZ+zrbGQpmK5esfzvUfYG
        xqmKXYycHBICJhKN3/8wdTFycQgJ7GCUWHHnLSuE84lRYsKsqewQzmdGiTvzP7LDtDR8WMEC
        kdjFKDF5byszhPOeUWLtmo2sIFXCArESv87fYwGxRYA6dsyczQhiMwv0skrMPAS2nE1AS2L/
        ixtsIDa/gKLE1R+PwWp4Bewkvmx8BBZnEVCVWDC7nRnEFhUIkzi5rQWqRlDi5MwnYPM5BYwk
        Pt/oYYOYLy5x68l8JghbXmL72zlgx0kIzOaU2DrvKyvECy4SN04vYIGwhSVeHd8C9ZqUxOd3
        e9kg7GqJlSePsEE0dzBKbNl/AarZWGL/0slAGziANmhKrN+lDxFWlNj5ey7Uk3wS7772sIKU
        SAjwSnS0CUGUKEtcfnCXCcKWlFjc3sk2gVFpFpJ3ZiF5YRaSF2YhLFvAyLKKUSy1oDg3PbXY
        sMAIObo3MYJTvpbZDsZJbz/oHWJk4mA8xCjBwawkwnuweW2CEG9KYmVValF+fFFpTmrxIUZT
        YABPZJYSTc4HZp28knhDUyNjY2MLE0MzU0NDJXHedOfqBCGB9MSS1OzU1ILUIpg+Jg5OqQam
        VsdrGYWBKY0OO7b89ebU9eX/f79PrV8hzuH5lpq1CYve960LX5Ry6LGxtPaVudWBDq/1/qf3
        r9OqM55yg9E/XYPpmgJD6lNj089d0vaJfAeWTI6L3LKmyr2Ny5xzm5xr2LHdW44wHJLy4rCa
        dXD+13oJ2yo12ZPPprIYiP2eMn3rZ603iWa/X807Jsu7c3dx/Gyzb7GXHKa/zvnmuH+CNqNX
        rOfTXK/8/apRPpXFH+Z2fFl6dxKfobu8xDpdp31X/7/+yT5R0qCEN07utLtfG9fiB5tFy6/e
        s9w2bY/s/KhbR94Yhq/pfb/OqENz8tTLlxuNm/Mfdj9gfb1qqdaVm+fsuk+l/LPdv4hnfmy6
        EktxRqKhFnNRcSIAVRKMlYIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsWy7bCSvG729rUJBh8+CVpsX/+C1WLqwyds
        FvOPnGO1ONv0ht3i25UOJotNj6+xWlzeNYfN4nLzRUaLz71HGC2WXr/IZNHUYmxxu3EFm8Wb
        H2eZLM6cvsRq0br3CLvFv2sbWSyuLXzPajH9rpDFxq8eDsIea+atYfS43NfL5LFz1l12j02r
        Otk87lzbw+axeUm9R8vJ/SweW662s3j0bVnF6HH8xnYmj8+b5AK4o7hsUlJzMstSi/TtErgy
        9nU2shRMV69Y/vcoewPjVMUuRk4OCQETiYYPK1hAbCGBHYwS736UQsQlJaZdPMrcxcgBZAtL
        HD5cDFHyllGi4RkbiC0sECvx6/w9sFYRoDE7Zs5m7GLk4mAW6GeVePmjiwnEERJ4xCJxZ8Ia
        VpAqNgEtif0vboB18wsoSlz98ZgRxOYVsJP4svERWJxFQFViwex2ZhBbVCBMYueSx0wQNYIS
        J2c+AdvGKWAk8flGD1g9s4C6xJ95l5ghbHGJW0/mM0HY8hLb385hnsAoPAtJ+ywkLbOQtMxC
        0rKAkWUVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZw5Gtp7WDcs+qD3iFGJg7GQ4wS
        HMxKIrwHm9cmCPGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp
        1cBkONe+d7mOhl9xqrrl7+X3f8nP5hHcHG+4w/njzI0/FDQr12kXlkj22q44eZK3vDzo2ubl
        telPlOdcSJcwuLohWPbR9fNlDL7HFdOy3Qu7H9yRaN2273AE9+fvqu3ru7P2aS59WNtQ0vYw
        5m7i4855U0RfripwrdmWs/zZ7Bn3jFVuJf1TiBQJvvKywKcykun/zPvlPROvW7xxerBPS3zb
        w39OF40+6ghMuiD6U2OFbrq3Ttq5r80vGP8mz8nJabC80b7Wqu3335ZXxvx8u2clHTPxurFN
        znh90LlbqkVBKRWXS24u2jfPttmRsbTxmcal1xfuhPP8OZW1pFxFNd16kvCCaO+pZ0XYb/V7
        cTIqsRRnJBpqMRcVJwIAHz+jaGsDAAA=
X-CMS-MailID: 20210526025019epcas1p48e8136bc939e4fd65cbbf56db4ccb239
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210323113411epcas1p3b4367563007ca91c30201d7fc225bb67
References: <1616499241-4906-1-git-send-email-andrew-sh.cheng@mediatek.com>
        <CGME20210323113411epcas1p3b4367563007ca91c30201d7fc225bb67@epcas1p3.samsung.com>
        <1616499241-4906-2-git-send-email-andrew-sh.cheng@mediatek.com>
        <233a3bd6-7ab1-5da2-9184-a745eb253d86@samsung.com>
        <1617177820.15067.1.camel@mtksdaap41>
        <2ae8604d-0da6-4243-1b92-81b3917d7d48@samsung.com>
        <cad52436-b291-05bf-236f-7b7cb1fdbbff@samsung.com>
        <1617195800.18432.3.camel@mtksdaap41>
        <fbb6c44b-eb77-14ce-9175-3f06030e6e0c@samsung.com>
        <cfdd3973-e4a7-8c09-8a7e-57118a7a3b9b@samsung.com>
        <1621995727.29827.1.camel@mtksdaap41>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,
On 5/26/21 11:22 AM, andrew-sh.cheng wrote:
> On Thu, 2021-04-08 at 11:47 +0900, Chanwoo Choi wrote:
>> On 4/1/21 9:16 AM, Chanwoo Choi wrote:
>>> On 3/31/21 10:03 PM, andrew-sh.cheng wrote:
>>>> On Wed, 2021-03-31 at 17:35 +0900, Chanwoo Choi wrote:
>>>>> On 3/31/21 5:27 PM, Chanwoo Choi wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 3/31/21 5:03 PM, andrew-sh.cheng wrote:
>>>>>>> On Thu, 2021-03-25 at 17:14 +0900, Chanwoo Choi wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> You are missing to add these patches to linux-pm mailing list.
>>>>>>>> Need to send them to linu-pm ML.
>>>>>>>>
>>>>>>>> Also, before received this series, I tried to clean-up these patches
>>>>>>>> on testing branch[1]. So that I add my comment with my clean-up case.
>>>>>>>> [1] https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing-passive-gov__;!!CTRNKA9wMg0ARbw!zIrzeDp9vPnm1_SDzVPuzqdHn3zWie9DnfBXaA-j9-CSrVc6aR9_rJQQiw81_CgAPh9XRRs$ 
>>>>>>>>
>>>>>>>> And 'Saravana Kannan <skannan@codeaurora.org>' is wrong email address.
>>>>>>>> Please update the email or drop this email.
>>>>>>>
>>>>>>> Hi Chanwoo,
>>>>>>>
>>>>>>> Thank you for the advices.
>>>>>>> I will resend patch v9 (add to linux-pm ML), remove this patch, and note
>>>>>>> that my patch set base on
>>>>>>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing-passive-gov__;!!CTRNKA9wMg0ARbw!yUlsuxrL5PcbF7o6A9DlCfvoA6w8V8VXKjYIybYyiJg3D0HM-lI2xRuxLUV6b3UJ8WFhg_g$ 
>>>>>>
>>>>>> I has not yet test this patch[1] on devfreq-testing-passive-gov branch.
>>>>>> So that if possible, I'd like you to test your patches with this patch[1] 
>>>>>> and then if there is no problem, could you send the next patches with patch[1]?
>>>>>>
>>>>>> [1]https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-testing-passive-gov&id=39c80d11a8f42dd63ecea1e0df595a0ceb83b454__;!!CTRNKA9wMg0ARbw!yUlsuxrL5PcbF7o6A9DlCfvoA6w8V8VXKjYIybYyiJg3D0HM-lI2xRuxLUV6b3UJR2cQqZs$ 
>>>>>
>>>>>
>>>>> Sorry for the confusion. I make the devfreq-testing-passive-gov[1]
>>>>> branch based on latest devfreq-next branch.
>>>>> [1] https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing-passive-gov__;!!CTRNKA9wMg0ARbw!yUlsuxrL5PcbF7o6A9DlCfvoA6w8V8VXKjYIybYyiJg3D0HM-lI2xRuxLUV6b3UJ8WFhg_g$ 
>>>>>
>>>>> First of all, if possible, I want to test them[1] with your patches in this series.
>>>>> And then if there are no any problem, please let me know. After confirmed from you,
>>>>> I'll send the patches of devfreq-testing-passive-gov[1] branch.
>>>>> How about that?
>>>>>
>>>> Hi Chanwoo~
>>>>
>>>> We will use this on Google Chrome project.
>>>> Google Hsin-Yi has test your patch + my patch set v8 [2~8]
>>>>
>>>>     make sure cci devfreqs runs with cpufreq.
>>>>     suspend resume
>>>>     speedometer2 benchmark
>>>> It is okay.
>>>>
>>>> Please send the patches of devfreq-testing-passive-gov[1] branch.
>>>>
>>>> I will send patch v9 base on yours latter.
>>>
>>> Thanks for your test. I'll send the patches today.
>>
>> I'm sorry for delay because when I tested the patches
>> for devfreq parent type on Odroid-xu3, there are some problem
>> related to lazy linking of OPP. So I'm trying to analyze them.
>> Unfortunately, we need to postpone these patches to next linux
>> version.
>>
> Hi Chanwoo Choi~
> 
> It is said that you are busy on another task recently.
> May I know your plan on this patch?
> Thank you.

Sorry for late work. I have a question.
When I tested exynos-bus.c with adding the 'required-opp' property
on odroid-xu3 board. I got some fail about 

When calling _set_required_opps(), always _set_required_opp() returns
-EBUSY error because of following lazy linking case[1].

[1] https://elixir.bootlin.com/linux/v5.13-rc3/source/drivers/opp/core.c#L896

/* required-opps not fully initialized yet */
if (lazy_linking_pending(opp_table))
	return -EBUSY;  


For calling dev_pm_opp_of_add_table(), lazy_link_required_opp_table() function
will be called. But, there is constraint[2]. If is_genpd of opp_table is false,
driver/opp/of.c cannot resolve the lazy linking issue.

[2]  https://elixir.bootlin.com/linux/v5.13-rc3/source/drivers/opp/of.c#L386

/* Link required OPPs for all OPPs of the newly added OPP table */
static void lazy_link_required_opp_table(struct opp_table *new_table)
{
	struct opp_table *opp_table, *temp, **required_opp_tables;
	struct device_node *required_np, *opp_np, *required_table_np;
	struct dev_pm_opp *opp;
	int i, ret;

	/*
	 * We only support genpd's OPPs in the "required-opps" for now,
	 * as we don't know much about other cases.
	 */
	if (!new_table->is_genpd)
		return;

Even if this case, there are no problem on your test case?

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

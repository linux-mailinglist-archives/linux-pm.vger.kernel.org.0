Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B084B39564A
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 09:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhEaHju (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 03:39:50 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:23161 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhEaHjh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 03:39:37 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210531073752epoutp046a4d63051865ddce7ef507b2fd23a138~EFqcLX2av2532125321epoutp04K
        for <linux-pm@vger.kernel.org>; Mon, 31 May 2021 07:37:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210531073752epoutp046a4d63051865ddce7ef507b2fd23a138~EFqcLX2av2532125321epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622446672;
        bh=QRvCFCW+U281AxWgQYdjwG9s7N9u/EHX6hqvoWa12hU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hajtiqZANBdFhZDgvP4/rVM4HYJJ9V0jLMy4P/Il5He6/NYCYlSU4VlbkH/Np7CNs
         SX47QTmYR4bU/qUjY+amOMsH9izJDdj0ZENL+jMM5ghFtPLuZ6EBka4pToXlJu0QnY
         7luK3LIIHJ6WgY757D8vfRZvWvFYIjCTbv7dJ/88=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210531073751epcas1p3d499a1311859554bdf4249c70ad56a51~EFqbW8zCh2849228492epcas1p3X;
        Mon, 31 May 2021 07:37:51 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4FtnFT11k4z4x9Q7; Mon, 31 May
        2021 07:37:49 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.EA.09578.C4294B06; Mon, 31 May 2021 16:37:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210531073748epcas1p28936dbbff9506eccd933816521a43948~EFqYZSxsI2525825258epcas1p2l;
        Mon, 31 May 2021 07:37:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210531073748epsmtrp2ba01e19ff9f4bbcaec3b8b04d6285dc7~EFqYXU2Hm0775507755epsmtrp2C;
        Mon, 31 May 2021 07:37:48 +0000 (GMT)
X-AuditID: b6c32a35-58cdfa800000256a-70-60b4924c3622
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.22.08163.C4294B06; Mon, 31 May 2021 16:37:48 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210531073747epsmtip1fea3dad0ec42cc9fb4f045fb343a2cba~EFqXnbSKL2270722707epsmtip1w;
        Mon, 31 May 2021 07:37:47 +0000 (GMT)
Subject: Re: [PATCH V8 1/8] PM / devfreq: Add cpu based scaling support to
 passive_governor
To:     "andrew-sh.cheng" <andrew-sh.cheng@mediatek.com>,
        Hsin-Yi Wang <hsinyi@google.com>
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
Message-ID: <316af76d-fc63-eeff-7419-cb4b44ee62fe@samsung.com>
Date:   Mon, 31 May 2021 16:56:33 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1622431376.14423.5.camel@mtksdaap41>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTZxjde9veFiL1ruJ8xw8pVxiRAeUClasRtohZLsEtbGZssi20g2tB
        Slv64cpgDhUnMFAQt2nDAAUJMhyjNHyUFWatYcyiQKUwkTkDZkw+A/IxWXQtrRn/znNyzvM+
        53nzcBi8FdSHky5T00qZWIqjnszWGztDQt4+ZxCF2S4xyLamSRb5zcMJlKyy3GaRJuMIg+w7
        Mc0ml+8WIKR+3M4ibcYKlLSdHADkYokFkFeGBxDyRH4EOXq8HiWnV/sQ0nprkEWeMlnY5DN7
        M5O0X5pjkd+N8cjmJepNb6qxshFQtjMlCNWhG2NT1XoNpW8oRKn79p9RqqX2Syq/t5tJGYZO
        M6kzhgZA9Yy0IdSifnvCpqSMvWm0OJVW8mlZijw1XSaJxuMPJscmC3eFESHEbjIK58vEmXQ0
        vv9AQshb6VJHSpx/VCzVOKgEsUqFC2L2KuUaNc1Pk6vU0TitSJUqditCVeJMlUYmCU2RZ+4h
        wsLChQ6hKCNt6twqU9ERqW03dbHyQFVwEfDgQCwSLlsvI0XAk8PD2gG8d/8Ry1UsANhuGma7
        ikUAfzQPoi8sZSWP3BYjgG0P65iuYg5Aa08tcKq2YJ/Ap3f+YDqxN/YhPP7v3DrPwEpY8KLZ
        z4lRLAh2T46sd92M+cGh1fF1jRcWA58v1jswh8PEAuDNp1wnvRVLhL2t+W7Jy7D34sR6ew8s
        HI60zLNd7bfBexNViAv7wraZCoZzNoj94AGX6syIK8F+aO8vZLnwFvi4x8B2YR+4OGtyp8yB
        V3stqMtcAKChu99tiIDdV8oR53AMbCdsMgpctB/sWPvenZELZ5eKWU4JxLxgwVc8l2QHtP05
        5h7hVVhzuhAtBbhuQxzdhgi6DRF0/z9WDZgN4BVaocqU0CpCQWz8bT1Yv4AgYTsom5kPNQOE
        A8wAchi4t5dV2yzieaWKsz+nlfJkpUZKq8xA6NhvGcNna4rccUIydTIhDI+IiCAjiV1CgsC3
        eUlic0Q8TCJW0xk0raCVL3wIx8MnDxHjC0VH2DWHL/M6JceSXosVzHuzuptHcwWzlfzb8aN+
        wZ/dONwax/s1sGPSf/p5VNStoLCmI+e16ZUDPscOjecmCWq4awde+klaiz8YU+gntHF9OfWa
        D9quDb0xZkj8beC9cVFi8bfKQevr7+8ou8oLjO/3PavehL2rywpYIS60B2cjMZZA3/5wra7F
        3+Td2nmw650pwcqz7U/kv/xTfv3CcvXJ4X1fq7jXfu8Eg6V3m59c/yLOyKdH/Blnu/4uJ/ac
        OpQV8Jj+i3vUmFeY3bjPVlHH7VjS9iuWVo08MFUuWfjUM3kitzQ/azVFtNl+c+gjdl0x1lP7
        wJKxdidxxkp+fB5nqtLERBBDqRL/B/nDcvmKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsWy7bCSnK7PpC0JBveaBC22r3/BajH14RM2
        i/lHzrFa7N11g9nibNMbdotvVzqYLDY9vsZqcXnXHDaLy80XGS0+9x5htFh6/SKTRVOLscXt
        xhVsFm9+nGWyOHP6EqtF694j7Bb/rm1ksbi28D2rxfS7QhYbv3o4iHismbeG0eNyXy+Tx85Z
        d9k9Fmwq9di0qpPN4861PWwem5fUe7Sc3M/iseVqO4tH35ZVjB7Hb2xn8vi8SS6AJ4rLJiU1
        J7MstUjfLoEr4/WkHywFO00qduzdx9rAOF+ni5GTQ0LARGJi71OmLkYuDiGBHYwSXy/cZoVI
        SEpMu3iUuYuRA8gWljh8uBii5i2jxKNDX5hBaoQFYiV+nb/HAmKLCERI/Pt0jRmkiFmgn1Xi
        5Y8uqKn7WSVWLNvODlLFJqAlsf/FDTYQm19AUeLqj8eMIDavgJ3E/88rGEG2sQioShz9xQcS
        FhUIk9i55DETRImgxMmZT8CWcQoYSdzY/AFsJLOAusSfeZeYIWxxiVtP5jNB2PIS29/OYZ7A
        KDwLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcDLQ0trB
        uGfVB71DjEwcjIcYJTiYlUR4z1RsTBDiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpi
        SWp2ampBahFMlomDU6qB6czJ3e/2v3kbuvaNnal7Qobduha9FP9pd6xWRdtldeqcdTK3a7Vw
        u6xg+3jH0SO/xOL4grsvHpfcoiQ7N27K3aC5TydG2d/+rt5zXnzZ1k3/9uZODvF2k7LgnKBz
        YOGrku1hLFlmF0OkxLjmfIr9ukrNaf0LzUvL/z47HMA5If5Wd5pHReAZ19oJ/Y8UYltLO3ZP
        2KaiNzVhSv6UK1utHbTTZfJ+Wh+eyrrg+ia7jtia2F9P322dsc6brdU9UY4zbOPpq49y793d
        ppOVutLjSKSTmN8ryclfpvSdCny/zNfdK3t2aK7iG6sgpue1jspL3lo25l2b3Ce678bL3lpu
        t+/FJysyZn7/uOlY1NT+UiWW4oxEQy3mouJEAGT2WzB1AwAA
X-CMS-MailID: 20210531073748epcas1p28936dbbff9506eccd933816521a43948
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
        <dd58c29a-35b1-b853-bc4a-3225b21b082a@samsung.com>
        <1622431376.14423.5.camel@mtksdaap41>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 5/31/21 12:22 PM, andrew-sh.cheng wrote:
> On Wed, 2021-05-26 at 12:08 +0900, Chanwoo Choi wrote:
>> Hi,
>> On 5/26/21 11:22 AM, andrew-sh.cheng wrote:
>>> On Thu, 2021-04-08 at 11:47 +0900, Chanwoo Choi wrote:
>>>> On 4/1/21 9:16 AM, Chanwoo Choi wrote:
>>>>> On 3/31/21 10:03 PM, andrew-sh.cheng wrote:
>>>>>> On Wed, 2021-03-31 at 17:35 +0900, Chanwoo Choi wrote:
>>>>>>> On 3/31/21 5:27 PM, Chanwoo Choi wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 3/31/21 5:03 PM, andrew-sh.cheng wrote:
>>>>>>>>> On Thu, 2021-03-25 at 17:14 +0900, Chanwoo Choi wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> You are missing to add these patches to linux-pm mailing list.
>>>>>>>>>> Need to send them to linu-pm ML.
>>>>>>>>>>
>>>>>>>>>> Also, before received this series, I tried to clean-up these patches
>>>>>>>>>> on testing branch[1]. So that I add my comment with my clean-up case.
>>>>>>>>>> [1] https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing-passive-gov__;!!CTRNKA9wMg0ARbw!zIrzeDp9vPnm1_SDzVPuzqdHn3zWie9DnfBXaA-j9-CSrVc6aR9_rJQQiw81_CgAPh9XRRs$ 
>>>>>>>>>>
>>>>>>>>>> And 'Saravana Kannan <skannan@codeaurora.org>' is wrong email address.
>>>>>>>>>> Please update the email or drop this email.
>>>>>>>>>
>>>>>>>>> Hi Chanwoo,
>>>>>>>>>
>>>>>>>>> Thank you for the advices.
>>>>>>>>> I will resend patch v9 (add to linux-pm ML), remove this patch, and note
>>>>>>>>> that my patch set base on
>>>>>>>>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing-passive-gov__;!!CTRNKA9wMg0ARbw!yUlsuxrL5PcbF7o6A9DlCfvoA6w8V8VXKjYIybYyiJg3D0HM-lI2xRuxLUV6b3UJ8WFhg_g$ 
>>>>>>>>
>>>>>>>> I has not yet test this patch[1] on devfreq-testing-passive-gov branch.
>>>>>>>> So that if possible, I'd like you to test your patches with this patch[1] 
>>>>>>>> and then if there is no problem, could you send the next patches with patch[1]?
>>>>>>>>
>>>>>>>> [1]https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-testing-passive-gov&id=39c80d11a8f42dd63ecea1e0df595a0ceb83b454__;!!CTRNKA9wMg0ARbw!yUlsuxrL5PcbF7o6A9DlCfvoA6w8V8VXKjYIybYyiJg3D0HM-lI2xRuxLUV6b3UJR2cQqZs$ 
>>>>>>>
>>>>>>>
>>>>>>> Sorry for the confusion. I make the devfreq-testing-passive-gov[1]
>>>>>>> branch based on latest devfreq-next branch.
>>>>>>> [1] https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing-passive-gov__;!!CTRNKA9wMg0ARbw!yUlsuxrL5PcbF7o6A9DlCfvoA6w8V8VXKjYIybYyiJg3D0HM-lI2xRuxLUV6b3UJ8WFhg_g$ 
>>>>>>>
>>>>>>> First of all, if possible, I want to test them[1] with your patches in this series.
>>>>>>> And then if there are no any problem, please let me know. After confirmed from you,
>>>>>>> I'll send the patches of devfreq-testing-passive-gov[1] branch.
>>>>>>> How about that?
>>>>>>>
>>>>>> Hi Chanwoo~
>>>>>>
>>>>>> We will use this on Google Chrome project.
>>>>>> Google Hsin-Yi has test your patch + my patch set v8 [2~8]
>>>>>>
>>>>>>     make sure cci devfreqs runs with cpufreq.
>>>>>>     suspend resume
>>>>>>     speedometer2 benchmark
>>>>>> It is okay.
>>>>>>
>>>>>> Please send the patches of devfreq-testing-passive-gov[1] branch.
>>>>>>
>>>>>> I will send patch v9 base on yours latter.
>>>>>
>>>>> Thanks for your test. I'll send the patches today.
>>>>
>>>> I'm sorry for delay because when I tested the patches
>>>> for devfreq parent type on Odroid-xu3, there are some problem
>>>> related to lazy linking of OPP. So I'm trying to analyze them.
>>>> Unfortunately, we need to postpone these patches to next linux
>>>> version.
>>>>
>>> Hi Chanwoo Choi~
>>>
>>> It is said that you are busy on another task recently.
>>> May I know your plan on this patch?
>>> Thank you.
>>
>> Sorry for late work. I have a question.
>> When I tested exynos-bus.c with adding the 'required-opp' property
>> on odroid-xu3 board. I got some fail about 
>>
>> When calling _set_required_opps(), always _set_required_opp() returns
>> -EBUSY error because of following lazy linking case[1].
>>
>> [1] https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v5.13-rc3/source/drivers/opp/core.c*L896__;Iw!!CTRNKA9wMg0ARbw!3eNxwDZRy-Ev5BHGxT-BxCz4qrNy0NZohQuBGW36krkwOkl_WX8yBmxlqSk9hxp_kxspMJI$ 
>>
>> /* required-opps not fully initialized yet */
>> if (lazy_linking_pending(opp_table))
>> 	return -EBUSY;  
>>
>>
>> For calling dev_pm_opp_of_add_table(), lazy_link_required_opp_table() function
>> will be called. But, there is constraint[2]. If is_genpd of opp_table is false,
>> driver/opp/of.c cannot resolve the lazy linking issue.
>>
>> [2]  https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v5.13-rc3/source/drivers/opp/of.c*L386__;Iw!!CTRNKA9wMg0ARbw!3eNxwDZRy-Ev5BHGxT-BxCz4qrNy0NZohQuBGW36krkwOkl_WX8yBmxlqSk9hxp_QFUVY9E$ 
>>
>> /* Link required OPPs for all OPPs of the newly added OPP table */
>> static void lazy_link_required_opp_table(struct opp_table *new_table)
>> {
>> 	struct opp_table *opp_table, *temp, **required_opp_tables;
>> 	struct device_node *required_np, *opp_np, *required_table_np;
>> 	struct dev_pm_opp *opp;
>> 	int i, ret;
>>
>> 	/*
>> 	 * We only support genpd's OPPs in the "required-opps" for now,
>> 	 * as we don't know much about other cases.
>> 	 */
>> 	if (!new_table->is_genpd)
>> 		return;
>>
>> Even if this case, there are no problem on your test case?
>>
> 
> Hi Chanwoo~
> Sorry for late reply.
> Yes, we meet similar issue.
> Google member Hsin-Yi had helped deal with this issue on Chrome project.
> 
> Patch segment:
> @ /drivers/opp/of.c
> 
> /* Link required OPPs for all OPPs of the newly added OPP table */
> static void lazy_link_required_opp_table(struct opp_table *new_table)
> {
> 	struct opp_table *opp_table, *temp, **required_opp_tables;
> 	struct device_node *required_np, *opp_np, *required_table_np;
> 	struct dev_pm_opp *opp;
> 	int i, ret;
> 
> +	/*
> +	 * We only support genpd's OPPs in the "required-opps" for now,
> +	 * as we don't know much about other cases.
> +	 */
> +	if (!new_table->is_genpd)
> +		return;
> 
> 
> Hsin-Yi replied this issue in the discussion list in the original lazy
> link thread:
> https://patchwork.kernel.org/project/linux-pm/patch/20190717222340.137578-4-saravanak@google.com/#23932203
> 
> Loop Hsin-YI here.
> You can discuss with her if needing more detail.
> 
> Thank you both.
> 

Thanks. First of all, we need to resolve and discuss this issue.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

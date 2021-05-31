Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBD0395688
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 09:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhEaH4u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 03:56:50 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:31187 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhEaH4t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 03:56:49 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210531075508epoutp015b4a69fc34d916e5adb1024978df442a~EF5gu0Og40787807878epoutp01g
        for <linux-pm@vger.kernel.org>; Mon, 31 May 2021 07:55:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210531075508epoutp015b4a69fc34d916e5adb1024978df442a~EF5gu0Og40787807878epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622447708;
        bh=Vj8hRqbR1C1cKwt8NAB/INFdikKtaqmGX/SzMeC8K/0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OoSYxIZKd8s48BwOFKVK971rtGuZA0Huo/zrKqDePiTvyFFGEqJCVRs3YiBmhQbNJ
         tqa5RY1QaaG27uGCiTjm9RD+WWDLqnWz5koO0hTuA0XDeHfIBpCCqJCmvfo/O1wqIB
         LDW/22Y2//P35BSoCLnq6ANMzakrzfj4ovkFRRfY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210531075506epcas1p433b2a501642967f044d73170f644e646~EF5fh_Vuz3217532175epcas1p4q;
        Mon, 31 May 2021 07:55:06 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.155]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FtndN5XyYz4x9Q7; Mon, 31 May
        2021 07:55:04 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.F1.09701.55694B06; Mon, 31 May 2021 16:55:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210531075500epcas1p250d5252aa5ecd54c0c5ca4e6874ef1e4~EF5Z_Eylk0159601596epcas1p2t;
        Mon, 31 May 2021 07:55:00 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210531075500epsmtrp12d2729c5a0dec68d9fb942244482e2ce~EF5Z8_w9-1539815398epsmtrp1F;
        Mon, 31 May 2021 07:55:00 +0000 (GMT)
X-AuditID: b6c32a36-631ff700000025e5-46-60b496557c0d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.74.08163.45694B06; Mon, 31 May 2021 16:55:00 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210531075500epsmtip1b6bbf16c135572726a2aa444e9f6450f~EF5ZiCMYe3070730707epsmtip1K;
        Mon, 31 May 2021 07:55:00 +0000 (GMT)
Subject: Re: [PATCH V8 1/8] PM / devfreq: Add cpu based scaling support to
 passive_governor
To:     Hsin-Yi Wang <hsinyi@google.com>
Cc:     "andrew-sh.cheng" <andrew-sh.cheng@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
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
Message-ID: <16412023-9c28-f47b-7719-7d836319b6da@samsung.com>
Date:   Mon, 31 May 2021 17:13:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <CACb=7PUkpMkDOJ6dDHXhJ5ep4e9u8ZVYM8M2iC-iwHXn13t3DQ@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc27b2xaH3FWQM8wcXJ2JbDxKKRwQzBaZXMfCMG5kL1IauCuP
        0tZeuiE4h4KCDTJQ1NAKqDxE6GboCmg3RLGK1SJDhOEcywyPIfNBQEwDzq2lNeO/7+93Pr98
        z/ec/HgsgR3342Uqcmm1QioncQ92x5WNwUEfHzOlhv7U/jbqPDfFQUfvj+OoznKLg7rMIyzU
        t+8hFz27U4oh49gwBw2aT+BosGgAoLlDFoAafx3A0L5iEbq3txlHD+19GLLdvM1B+7ssXPRi
        uI2Nhk894aDjowLUNk+9400Zag2AGiw/hFEXdKNc6qRRQxlbDuLU78M/49SPDd9SxdZuNmUa
        KmFT5aYWQPWOdGLUnHFt0iufZcdk0NJ0Wu1PK9KU6ZkKWSyZsEOyRSKOCBUGCaNQJOmvkObQ
        sWTcB0lBWzPljpSk/1dSucbRSpIyDBmyOUat1OTS/hlKJjeWpFXpclWUKpiR5jAahSw4TZkT
        LQwNDRM7wNTsjLY7ZRzV9cS8vZf72YVgJFoL+DxIhMPTlyY4WuDBExDnAXxa/QK4ilkA79a0
        slzFHICTU/dYL0ee1VS5KTOAD/4ucRdPADSfesR1UquIFLjQ/wfbqb2J9bCpq5PrhFhENwcW
        Lt5dgnAiEHZPjeBO7UUEwCH7GHBqT2IznO60Yk7NJt6ER6cWlhgfIhlaO4rdzKvQWj3uMODx
        +MR2aG/Oc7ZZhC/8bbwOc+k3YFG7fikCJFr5sPTMRcwVIQ4eH7jmjrMKTveauC7tBx98d8Ct
        C+BZqwV3DZcCaOr+heM6EMHuxiOY05hFbITnzCGudgC8sFgDXMYr4eP5Mo4TgYQnLD0gcCHr
        4OCfo+4rvAbrSw7iFYDULUujWxZBtyyC7n+zk4DdAlbTKiZHRjNCVdjy7zaCpRUIjDgPDj+a
        Ce4BGA/0AMhjkd6etry2VIFnunRXPq1WStQaOc30ALHjfStZfj5pSscOKXIlQnGYSCRC4cII
        sVBI+nrKthSkCgiZNJfOpmkVrX45h/H4foXY94mLR3z16jOBvlrTikbbzJo9ya+3xOWlpuzI
        s637K8qrprLj5ie9RfVNfTEBOnlTo0wkLKjdsKeg9xLWpf33va/D36L+ObZTYl+5s3/T0xse
        q7FOQUj8/c/zt22/zPsmvqOnVfTc53FCxYmUrMQvJc3brFM5G37IzicZfNrQMJFoC5udfN/n
        +uQunca4Ij2L4cv3G+wVhWsYqDl8O2JMuztEW4vy115trT7Ni68kAy8WhZrFGT3JxtmP6n0s
        A1kzs2Ucfljkwu40lkH/RVVklX7iGgOC8m3tz4e8JryvGBLW+0d76D9tjtgUUHtWV4fhA/ra
        2Fs3rjaUvyvdKp5P+JBkMxlSYSBLzUj/AzBwD1SLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTURiAOd/Nz9Hoa648KikOwxCyXDNOknZR4euPFF1+BKkjPy/ldGxp
        2sXU2cWhKzSTVjozKzNpuVzT0i5eUsvysjS7CbkVIlpaWV5q1TYC/z287/Nwzo+XxgUjhCed
        lHKQU6RIk0UUj7jbKvJetfN8fewalWYVMulHSVTywUohXdsLEjXfG8LR89xxF/Tj5WkMGSyD
        JDLfu0Qhs6oPoG+FbQBdfdWHody8tehtTjWFxmeeY6j7WT+JTjS3uSDbYB2BBi9/IVHpewGq
        m2Y3Cdna8lrAmjWFGNuofe/CVhjSWENNPsW+G2yi2DtVx9m8rocEWz9wimA19TWA7RgyYew3
        g/e2RXt4G+K45KR0TrE6LJaXWPeygJR3RmXkPO4hssFQiBq40pCRwB9l54Aa8GgB0wBgnspG
        ORce8HxfO64G9D92g62tSqczAeBYezlhd9yYvXCuZ9jBQsYPXms2udglnGkloa72FOks7lPw
        0qwe2C2KCYAPR4ccLyxmfOHAjMUx5zNhcMzUhdmZYFbAktE5h7OU2Q0bqyyY01kCuy5YCfuP
        XJntcKY6wz7GGX/4q7wfd7I7fGPVYU72gSrjRfwscNMuqLULEu2CRLsgqQBEDfDg5EpZgkwZ
        JBencIcClVKZMi0lIXBfqswAHGcQENAAmmomA1sARoMWAGlcJOR3Z9TFCvhx0szDnCI1RpGW
        zClbgBdNiNz5vequGAGTID3IHeA4Oaf4v8VoV89srCBuXZZ/cVlZ0Xe/iY3mrFn68tHtc73L
        mm75PhXl+A/w18vnr0gmK59KtlpXtKhOuo/4xcuqIyaiu73ISostsZMTR2ae2ZdkrChnP4q1
        obk+keH9tzcE2uJ7L7bPl4ampgdPBxU1bvEyPObCu2OGh91ro/ebxU82Ga9Pzo9ZEpPn9dGK
        9D/WBz4XpvRxD0KNFSPFo9T1T8sLo7G8KJn3/mOmSN6Tn7teU8PbZjMfmWxkQuViv5X3cXnY
        i5IdVOlnS/zp/OnM2R36Q0ckms7G8bCbnpUdxWrVFGYN7xCGmLNXy4uEX29s/h0iJpuqJMYb
        Ok18UESUruOTR85k8HSDiFAmSoMCcIVS+hfzDc3QdQMAAA==
X-CMS-MailID: 20210531075500epcas1p250d5252aa5ecd54c0c5ca4e6874ef1e4
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
        <316af76d-fc63-eeff-7419-cb4b44ee62fe@samsung.com>
        <CACb=7PUkpMkDOJ6dDHXhJ5ep4e9u8ZVYM8M2iC-iwHXn13t3DQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/31/21 4:42 PM, Hsin-Yi Wang wrote:
> 
> 
> On Mon, May 31, 2021 at 3:37 PM Chanwoo Choi <cw00.choi@samsung.com <mailto:cw00.choi@samsung.com>> wrote:
> 
>     Hi,
> 
>     On 5/31/21 12:22 PM, andrew-sh.cheng wrote:
>     > On Wed, 2021-05-26 at 12:08 +0900, Chanwoo Choi wrote:
>     >> Hi,
>     >> On 5/26/21 11:22 AM, andrew-sh.cheng wrote:
>     >>> On Thu, 2021-04-08 at 11:47 +0900, Chanwoo Choi wrote:
>     >>>> On 4/1/21 9:16 AM, Chanwoo Choi wrote:
>     >>>>> On 3/31/21 10:03 PM, andrew-sh.cheng wrote:
>     >>>>>> On Wed, 2021-03-31 at 17:35 +0900, Chanwoo Choi wrote:
>     >>>>>>> On 3/31/21 5:27 PM, Chanwoo Choi wrote:
>     >>>>>>>> Hi,
>     >>>>>>>>
>     >>>>>>>> On 3/31/21 5:03 PM, andrew-sh.cheng wrote:
>     >>>>>>>>> On Thu, 2021-03-25 at 17:14 +0900, Chanwoo Choi wrote:
>     >>>>>>>>>> Hi,
>     >>>>>>>>>>
>     >>>>>>>>>> You are missing to add these patches to linux-pm mailing list.
>     >>>>>>>>>> Need to send them to linu-pm ML.
>     >>>>>>>>>>
>     >>>>>>>>>> Also, before received this series, I tried to clean-up these patches
>     >>>>>>>>>> on testing branch[1]. So that I add my comment with my clean-up case.
>     >>>>>>>>>> [1] https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing-passive-gov__;!!CTRNKA9wMg0ARbw!zIrzeDp9vPnm1_SDzVPuzqdHn3zWie9DnfBXaA-j9-CSrVc6aR9_rJQQiw81_CgAPh9XRRs$
>     >>>>>>>>>>
>     >>>>>>>>>> And 'Saravana Kannan <skannan@codeaurora.org <mailto:skannan@codeaurora.org>>' is wrong email address.
>     >>>>>>>>>> Please update the email or drop this email.
>     >>>>>>>>>
>     >>>>>>>>> Hi Chanwoo,
>     >>>>>>>>>
>     >>>>>>>>> Thank you for the advices.
>     >>>>>>>>> I will resend patch v9 (add to linux-pm ML), remove this patch, and note
>     >>>>>>>>> that my patch set base on
>     >>>>>>>>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing-passive-gov__;!!CTRNKA9wMg0ARbw!yUlsuxrL5PcbF7o6A9DlCfvoA6w8V8VXKjYIybYyiJg3D0HM-lI2xRuxLUV6b3UJ8WFhg_g$
>     >>>>>>>>
>     >>>>>>>> I has not yet test this patch[1] on devfreq-testing-passive-gov branch.
>     >>>>>>>> So that if possible, I'd like you to test your patches with this patch[1]
>     >>>>>>>> and then if there is no problem, could you send the next patches with patch[1]?
>     >>>>>>>>
>     >>>>>>>> [1]https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-testing-passive-gov&id=39c80d11a8f42dd63ecea1e0df595a0ceb83b454__;!!CTRNKA9wMg0ARbw!yUlsuxrL5PcbF7o6A9DlCfvoA6w8V8VXKjYIybYyiJg3D0HM-lI2xRuxLUV6b3UJR2cQqZs$
>     >>>>>>>
>     >>>>>>>
>     >>>>>>> Sorry for the confusion. I make the devfreq-testing-passive-gov[1]
>     >>>>>>> branch based on latest devfreq-next branch.
>     >>>>>>> [1] https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing-passive-gov__;!!CTRNKA9wMg0ARbw!yUlsuxrL5PcbF7o6A9DlCfvoA6w8V8VXKjYIybYyiJg3D0HM-lI2xRuxLUV6b3UJ8WFhg_g$
>     >>>>>>>
>     >>>>>>> First of all, if possible, I want to test them[1] with your patches in this series.
>     >>>>>>> And then if there are no any problem, please let me know. After confirmed from you,
>     >>>>>>> I'll send the patches of devfreq-testing-passive-gov[1] branch.
>     >>>>>>> How about that?
>     >>>>>>>
>     >>>>>> Hi Chanwoo~
>     >>>>>>
>     >>>>>> We will use this on Google Chrome project.
>     >>>>>> Google Hsin-Yi has test your patch + my patch set v8 [2~8]
>     >>>>>>
>     >>>>>>     make sure cci devfreqs runs with cpufreq.
>     >>>>>>     suspend resume
>     >>>>>>     speedometer2 benchmark
>     >>>>>> It is okay.
>     >>>>>>
>     >>>>>> Please send the patches of devfreq-testing-passive-gov[1] branch.
>     >>>>>>
>     >>>>>> I will send patch v9 base on yours latter.
>     >>>>>
>     >>>>> Thanks for your test. I'll send the patches today.
>     >>>>
>     >>>> I'm sorry for delay because when I tested the patches
>     >>>> for devfreq parent type on Odroid-xu3, there are some problem
>     >>>> related to lazy linking of OPP. So I'm trying to analyze them.
>     >>>> Unfortunately, we need to postpone these patches to next linux
>     >>>> version.
>     >>>>
>     >>> Hi Chanwoo Choi~
>     >>>
>     >>> It is said that you are busy on another task recently.
>     >>> May I know your plan on this patch?
>     >>> Thank you.
>     >>
>     >> Sorry for late work. I have a question.
>     >> When I tested exynos-bus.c with adding the 'required-opp' property
>     >> on odroid-xu3 board. I got some fail about
>     >>
>     >> When calling _set_required_opps(), always _set_required_opp() returns
>     >> -EBUSY error because of following lazy linking case[1].
>     >>
>     >> [1] https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v5.13-rc3/source/drivers/opp/core.c*L896__;Iw!!CTRNKA9wMg0ARbw!3eNxwDZRy-Ev5BHGxT-BxCz4qrNy0NZohQuBGW36krkwOkl_WX8yBmxlqSk9hxp_kxspMJI$
>     >>
>     >> /* required-opps not fully initialized yet */
>     >> if (lazy_linking_pending(opp_table))
>     >>      return -EBUSY; 
>     >>
>     >>
>     >> For calling dev_pm_opp_of_add_table(), lazy_link_required_opp_table() function
>     >> will be called. But, there is constraint[2]. If is_genpd of opp_table is false,
>     >> driver/opp/of.c cannot resolve the lazy linking issue.
>     >>
>     >> [2]  https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v5.13-rc3/source/drivers/opp/of.c*L386__;Iw!!CTRNKA9wMg0ARbw!3eNxwDZRy-Ev5BHGxT-BxCz4qrNy0NZohQuBGW36krkwOkl_WX8yBmxlqSk9hxp_QFUVY9E$
>     >>
>     >> /* Link required OPPs for all OPPs of the newly added OPP table */
>     >> static void lazy_link_required_opp_table(struct opp_table *new_table)
>     >> {
>     >>      struct opp_table *opp_table, *temp, **required_opp_tables;
>     >>      struct device_node *required_np, *opp_np, *required_table_np;
>     >>      struct dev_pm_opp *opp;
>     >>      int i, ret;
>     >>
>     >>      /*
>     >>       * We only support genpd's OPPs in the "required-opps" for now,
>     >>       * as we don't know much about other cases.
>     >>       */
>     >>      if (!new_table->is_genpd)
>     >>              return;
>     >>
>     >> Even if this case, there are no problem on your test case?
>     >>
>     >
>     > Hi Chanwoo~
>     > Sorry for late reply.
>     > Yes, we meet similar issue.
>     > Google member Hsin-Yi had helped deal with this issue on Chrome project.
>     >
>     > Patch segment:
>     > @ /drivers/opp/of.c
>     >
>     > /* Link required OPPs for all OPPs of the newly added OPP table */
>     > static void lazy_link_required_opp_table(struct opp_table *new_table)
>     > {
>     >       struct opp_table *opp_table, *temp, **required_opp_tables;
>     >       struct device_node *required_np, *opp_np, *required_table_np;
>     >       struct dev_pm_opp *opp;
>     >       int i, ret;
>     >
>     > +     /*
>     > +      * We only support genpd's OPPs in the "required-opps" for now,
>     > +      * as we don't know much about other cases.
>     > +      */
>     > +     if (!new_table->is_genpd)
>     > +             return;
>     >
>     >
>     > Hsin-Yi replied this issue in the discussion list in the original lazy
>     > link thread:
>     > https://patchwork.kernel.org/project/linux-pm/patch/20190717222340.137578-4-saravanak@google.com/#23932203
>     >
>     > Loop Hsin-YI here.
>     > You can discuss with her if needing more detail.
>     >
>     > Thank you both.
>     >
> 
>     Thanks. First of all, we need to resolve and discuss this issue.
> 
> 
> Hi Chanwoo, 
> 
> We think removing the genpd check is sufficient for our use case since we only use the lazy link for opp table translation.

Hi Hsin-Yi,

IMHO, I think 'is_genpd' checking should be removed for devices except for genpd
like as following:

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index c582a9ca397b..b54d3a985515 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -201,17 +201,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
                        lazy = true;
                        continue;
                }
-
-               /*
-                * We only support genpd's OPPs in the "required-opps" for now,
-                * as we don't know how much about other cases. Error out if the
-                * required OPP doesn't belong to a genpd.
-                */
-               if (!required_opp_tables[i]->is_genpd) {
-                       dev_err(dev, "required-opp doesn't belong to genpd: %pOF\n",
-                               required_np);
-                       goto free_required_tables;
-               }
        }
 
        /* Let's do the linking later on */
@@ -379,13 +368,6 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
        struct dev_pm_opp *opp;
        int i, ret;
 
-       /*
-        * We only support genpd's OPPs in the "required-opps" for now,
-        * as we don't know much about other cases.
-        */
-       if (!new_table->is_genpd)
-               return;
-
        mutex_lock(&opp_table_lock);
 
        list_for_each_entry_safe(opp_table, temp, &lazy_opp_tables, lazy) {
@@ -874,7 +856,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
                return ERR_PTR(-ENOMEM);
 
        ret = _read_opp_key(new_opp, opp_table, np, &rate_not_available);
-       if (ret < 0 && !opp_table->is_genpd) {
+       if (ret < 0) {
                dev_err(dev, "%s: opp key field not found\n", __func__);
                goto free_opp;
        }


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

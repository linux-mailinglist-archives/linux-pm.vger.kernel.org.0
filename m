Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3FA1365B9
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 04:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbgAJDKT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 22:10:19 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:24636 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730970AbgAJDKT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2020 22:10:19 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200110031016epoutp03c5e2faf70d3ec89560da7de38ec64854~oZ9Domrze1966419664epoutp03H
        for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2020 03:10:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200110031016epoutp03c5e2faf70d3ec89560da7de38ec64854~oZ9Domrze1966419664epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578625816;
        bh=ddOYSE7uFXXb5sEYz8IUlxWybjMBlURrjAYw2XVsczI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fr6pqJ0heMpCm1OP7IJJrLX6lBLjQSFaC++8zf2gBAZM7f67FHUush+1upkKDrr9B
         Rgzdxw0RR94nDk+kXD2xOvsSxS4SMlINoUMk26m9MZgKQfwOFVQbgMgKz34cnImjW0
         Gv2E04mFFZv155aoXntQEzlA3xh/q5A2N27KKIWU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200110031015epcas1p1df4254525167d59eac7e36aaaf96753e~oZ9DF3hmE0982509825epcas1p1U;
        Fri, 10 Jan 2020 03:10:15 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47v7Jj4PPbzMqYkY; Fri, 10 Jan
        2020 03:10:13 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.74.51241.51BE71E5; Fri, 10 Jan 2020 12:10:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200110031012epcas1p362738235f4594c598c4c5070d267ee60~oZ9Afg1Gl1353213532epcas1p3d;
        Fri, 10 Jan 2020 03:10:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200110031012epsmtrp2cf032baab23eadff2d74d44bb2e93949~oZ9Aeh0S92673026730epsmtrp2L;
        Fri, 10 Jan 2020 03:10:12 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-54-5e17eb15868c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.57.10238.41BE71E5; Fri, 10 Jan 2020 12:10:12 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200110031012epsmtip11ddd78ff686440fdf20458c360c01c73~oZ9APP4Du1678816788epsmtip1R;
        Fri, 10 Jan 2020 03:10:12 +0000 (GMT)
Subject: Re: [PATCH 0/2] PM / devfreq: Add debugfs support
To:     Kamil Konieczny <k.konieczny@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, digetx@gmail.com, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <dc967728-7c6d-f5df-fbc9-2484ae1304f6@samsung.com>
Date:   Fri, 10 Jan 2020 12:17:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <fb1e88a2-8a5d-3dc6-e36d-523c556e67b1@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOJsWRmVeSWpSXmKPExsWy7bCmga7oa/E4g6MflC3uz2tltDi9/x2L
        xcQbV1gsVn98zGix5vYhRosfG04xW2xckG2x4NMMVouzTW/YLVbc/chqcXnXHDaLz71HGC0W
        NrWwW6w9cpfd4nbjCjYHfo8189Ywelzu62Xy2HF3CaPHzll32T02repk87hzbQ+bx8Z3O5g8
        /s7az+LRt2UVo8fnTXIBXFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlAbygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL9IoTc4tL
        89L1kvNzrQwNDIxMgQoTsjM2db1mLeg3rZj4dBZLA+NdxS5GTg4JAROJ+/1XGbsYuTiEBHYw
        Spw8+JIFwvnEKPH76Gko5xujxJ/Tj1lhWq49XgDVspdRYsGFKWwQzntGieXvljGDVAkLWEm8
        +LKBBcQWEUiXmPjrJVgRs8AyJomTz26AJdgEtCT2v7jBBmLzCyhKXP3xmBHE5hWwk7j3oRPM
        ZhFQlXi8sYMdxBYVCJM4ua0FqkZQ4uTMJ2BzOAXsJQ6f+gMWZxYQl7j1ZD4ThC0vsf3tHGaQ
        xRIC59gl1vVsZ4T4wUXi+5+3ULawxKvjW9ghbCmJz+/2skHY1RIrTx5hg2juYJTYsv8CNACM
        JfYvnQy0gQNog6bE+l36EGFFiZ2/50IdwSfx7msPK0iJhACvREebEESJssTlB3eZIGxJicXt
        nWwTGJVmIXlnFpIXZiF5YRbCsgWMLKsYxVILinPTU4sNC0yR43sTIziRa1nuYDx2zucQowAH
        oxIPb4aweJwQa2JZcWXuIUYJDmYlEd6jN8TihHhTEiurUovy44tKc1KLDzGaAkN7IrOUaHI+
        MMvklcQbmhoZGxtbmBiamRoaKonzcvy4GCskkJ5YkpqdmlqQWgTTx8TBKdXAWD553ZTykFqG
        eZEsp2UU7R5Irb8cdC1fvS16jda+j2LfvnaVGTB1ZXv/2J2wf/XZZUZ195q19dn988TqdV/p
        1Pq82q7WnfwrK7hOs1xnSW1Ry76X/yaUpLb+NjyuW6AvO3FCSxef1YkjddKqN3NWHXL/cvVZ
        QtHf7Vwfa/o+mp/6WrG50nyjEktxRqKhFnNRcSIAtEC0hvoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02RbUhTURiAObt323U1vG2rHQ0M14e0ypQSDhVWf+oSEhIoGDi75GWa25y7
        TjMITLNy4koCsYvMiaNkLXSjUjNcbBrqSjDTJFslmyKZI7MPBaPcRrB/D7zPc15eDoFJxvFE
        olhXzhh0tEYhEOFPvYqkA7JFuSqty5yBPlnqAPK5Qzhqmn6Lo4fLAYAcMx6AVrtHMeS0liDr
        9xY+el3zVYg6/ct8NPGsVYBWGgcBaq+5LkSPBv1CNHOtU3AinnJYHICaMDfyqF6/DVB9nF9I
        uez1AurD1HMB5Qz18qg/nBunzI/tgFpxJWWLzouOFTKa4grGcDDzgqjIZVrk629nXG6a4/Bq
        4E82gTgCkofhVMAKTEBESMh+AP/6HuDRQQJsHh/CTIDYYCn0etmoswTgVF07P+xIySNw4Ud3
        xJeRauit5SIPYeR9HhwO3sCihQfALsuwIGwJSCV0L0xHOJ5MhpOrARBmMZkJP36rjzBO7oYB
        5y1hmLeSubDPFuBFnS1w5F4wsi2OPA69o+sRHyNT4LrlDRZlOXwfbONFeQfsWWrF7gApF5Nz
        MQkXk3AxiRXgdpDA6FmtWsum69N1TGUqS2tZo06derFU6wKRj1bu7QUTtgIPIAmg2CwukspV
        Ej5dwVZpNy4mMIVMPDS9TSURF9JVVxhDaYHBqGFYD9hO4Aq5eE73Mk9CqulypoRh9Izh/5RH
        xCVWgzOzN335Cx6E/X7hbMiqlYT663eqOnsELa9OTtq5JxrlLqPIlFcG+lT5wtwsx13z1Yau
        TZU5s2mXEN22T+Yw7pnHEsYGUtLe/cLKfobWz7YFx77Y3ffBosGXfWh/TUvp6Zzc5nkb8vjM
        q2trmZ87TsGRjtr2MbUcsx4dOKfA2SI6XYkZWPofVz1Yz+QCAAA=
X-CMS-MailID: 20200110031012epcas1p362738235f4594c598c4c5070d267ee60
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200107085812epcas1p4eb4f51c2ade10db700fbfd62ab4779fb
References: <CGME20200107085812epcas1p4eb4f51c2ade10db700fbfd62ab4779fb@epcas1p4.samsung.com>
        <20200107090519.3231-1-cw00.choi@samsung.com>
        <fb1e88a2-8a5d-3dc6-e36d-523c556e67b1@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/10/20 12:06 AM, Kamil Konieczny wrote:
> Hi,
> 
> On 07.01.2020 10:05, Chanwoo Choi wrote:
>> Add debugfs interface to provide debugging information of devfreq device.
>> It contains 'devfreq_summary' and 'debug_transitions' debugfs file
>> in order to provide the simple profiling to user via debugfs
>> without any specific profiling tool.
>>
>> [Added debugfs file]
>> - "/sys/kernel/debug/devfreq/devfreq_summary"
>>   : Show the summary of the registered devfreq devices.
>> - "/sys/kernel/debug/devfreq/devfreq_transitions"
>>   : Show the frequency transition of the registered devfreq devices.
>>
>> Recommend the each patch to check the detailed description
>> of each fields of both devfreq_summary and devfreq_transitions.
>>
>> This series contains the patch[1] and add the patch2 for 'devfreq_transitions'
>> [1] https://patchwork.kernel.org/patch/11320265/
>> - [v3] PM / devfreq: Add debugfs support with devfreq_summary file
>>
>>
>> For example on Exynos5422-based Odroid-XU3 board,
>> - In order to show the multiple governors on devfreq_summay result,
>> change the governor of devfreq0 from simple_ondemand to userspace.
>>
>> $ cat /sys/kernel/debug/devfreq/devfreq_summary
>> dev_name                       dev        parent_dev governor        polling_ms cur_freq_hz  min_freq_hz  max_freq_hz
> 
> Imho either drop "_hz" or change it to "_Hz".

hz -> Hz

> 
>> ------------------------------ ---------- ---------- --------------- ---------- ------------ ------------ ------------
>> 10c20000.memory-controller     devfreq0              userspace       0          206000000    165000000    825000000
>> soc:bus_wcore                  devfreq1              simple_ondemand 50         532000000    88700000     532000000
>> soc:bus_noc                    devfreq2   devfreq1   passive         0          111000000    66600000     111000000
>> soc:bus_fsys_apb               devfreq3   devfreq1   passive         0          222000000    111000000    222000000
>> soc:bus_fsys                   devfreq4   devfreq1   passive         0          200000000    75000000     200000000
>> soc:bus_fsys2                  devfreq5   devfreq1   passive         0          200000000    75000000     200000000
>> soc:bus_mfc                    devfreq6   devfreq1   passive         0          333000000    83250000     333000000
>> soc:bus_gen                    devfreq7   devfreq1   passive         0          266000000    88700000     266000000
>> soc:bus_peri                   devfreq8   devfreq1   passive         0          66600000     66600000     66600000
>> soc:bus_g2d                    devfreq9   devfreq1   passive         0          0            83250000     333000000
> 
> Imho it better looks with freq aligned to right, eg.:

OK.

> 
> soc:bus_gen                    devfreq7   devfreq1   passive         0          266000000     88700000     266000000
> soc:bus_peri                   devfreq8   devfreq1   passive         0           66600000     66600000      66600000
> soc:bus_g2d                    devfreq9   devfreq1   passive         0                  0     83250000     333000000
> 
>> soc:bus_g2d_acp                devfreq10  devfreq1   passive         0          0            66500000     266000000
>> soc:bus_jpeg                   devfreq11  devfreq1   passive         0          0            75000000     300000000
>> soc:bus_jpeg_apb               devfreq12  devfreq1   passive         0          0            83250000     166500000
>> soc:bus_disp1_fimd             devfreq13  devfreq1   passive         0          0            120000000    200000000
>> soc:bus_disp1                  devfreq14  devfreq1   passive         0          0            120000000    300000000
>> soc:bus_gscl_scaler            devfreq15  devfreq1   passive         0          0            150000000    300000000
>> soc:bus_mscl                   devfreq16  devfreq1   passive         0          0            84000000     666000000
>>
>> $ cat /sys/kernel/debug/devfreq/devfreq_transitions
>> time_ms    dev_name                       dev        parent_dev load_% old_freq_hz  new_freq_hz
>> ---------- ------------------------------ ---------- ---------- ---------- ------------ ------------
>> 14600      soc:bus_noc                    devfreq2   devfreq1   0      100000000    67000000
>> 14600      soc:bus_fsys_apb               devfreq3   devfreq1   0      200000000    100000000
>> 14600      soc:bus_fsys                   devfreq4   devfreq1   0      200000000    100000000
>> 14600      soc:bus_fsys2                  devfreq5   devfreq1   0      150000000    75000000
>> 14602      soc:bus_mfc                    devfreq6   devfreq1   0      222000000    96000000
>> 14602      soc:bus_gen                    devfreq7   devfreq1   0      267000000    89000000
>> 14602      soc:bus_g2d                    devfreq9   devfreq1   0      300000000    84000000
>> 14602      soc:bus_g2d_acp                devfreq10  devfreq1   0      267000000    67000000
>> 14602      soc:bus_jpeg                   devfreq11  devfreq1   0      300000000    75000000
>> 14602      soc:bus_jpeg_apb               devfreq12  devfreq1   0      167000000    84000000
>> 14603      soc:bus_disp1_fimd             devfreq13  devfreq1   0      200000000    120000000
>> 14603      soc:bus_disp1                  devfreq14  devfreq1   0      300000000    120000000
>> 14606      soc:bus_gscl_scaler            devfreq15  devfreq1   0      300000000    150000000
>> 14606      soc:bus_mscl                   devfreq16  devfreq1   0      333000000    84000000
>> 14608      soc:bus_wcore                  devfreq1              9      333000000    84000000
>> 14783      10c20000.memory-controller     devfreq0              35     825000000    633000000
>> 15873      soc:bus_wcore                  devfreq1              41     84000000     400000000
>> 15873      soc:bus_noc                    devfreq2   devfreq1   0      67000000     100000000
>> [snip]
>>
>>
>> Depends on:
>> It depends on patch[2] for preventing the merge conflic.
>> [2] https://patchwork.kernel.org/patch/11320257/
>> - PM / devfreq: Add missing function description and rename static functions
>>
>> Chanwoo Choi (2):
>>   PM / devfreq: Add debugfs support with devfreq_summary file
>>   PM / devfreq: Add devfreq_transitions debugfs file
>>
>>  drivers/devfreq/Kconfig            |  13 ++
>>  drivers/devfreq/devfreq.c          | 206 +++++++++++++++++++++++++++++
>>  drivers/devfreq/governor.h         |   3 +
>>  drivers/devfreq/governor_passive.c |   2 +
>>  include/linux/devfreq.h            |   1 +
>>  5 files changed, 225 insertions(+)
>>
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

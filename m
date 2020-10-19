Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834D5292188
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 05:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbgJSD6P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Oct 2020 23:58:15 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:13859 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731755AbgJSD6O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Oct 2020 23:58:14 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201019035810epoutp0237e1881ab2aa2c7d19a3a1515deeb9ab~-SKrRmKXM2298522985epoutp02Y
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 03:58:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201019035810epoutp0237e1881ab2aa2c7d19a3a1515deeb9ab~-SKrRmKXM2298522985epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603079890;
        bh=m+psVG5ydnEfTR+95veMJooA8oISCSXl0ADz2z9f3vc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tDDmGefdbi8lV8Y4493ZWzVFk9z9ERA1rj4yVgEidB/kV5Q9/wrIQ//wRF0wqvR+f
         FTY31B4j0iseor4nej03oWbGqHpQRq1dE5Lf7qDo/EzPKF4yCpqShsAbPlqcexITU5
         I1vAajgJWnxpwH/n3bpwDdN0+ZVKaHZRo2PwIPPo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20201019035810epcas1p3082bbc6b2c88c010f4851f8e07ef3e9e~-SKqgSgrs1980819808epcas1p3K;
        Mon, 19 Oct 2020 03:58:10 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4CF2zM3VXrzMqYkg; Mon, 19 Oct
        2020 03:58:07 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.F1.10463.FCE0D8F5; Mon, 19 Oct 2020 12:58:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201019035806epcas1p22dc6646d6f40e36a4797ad00fa46dd42~-SKnh7cv32489824898epcas1p24;
        Mon, 19 Oct 2020 03:58:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201019035806epsmtrp13b638c0179070576732b49b1624337f3~-SKnb2NaH2438224382epsmtrp1B;
        Mon, 19 Oct 2020 03:58:06 +0000 (GMT)
X-AuditID: b6c32a38-efbff700000028df-48-5f8d0ecfbbdd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.03.08745.ECE0D8F5; Mon, 19 Oct 2020 12:58:06 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201019035806epsmtip1c9effe648e0cf6e3afc88f0fa608f611~-SKnJExgc1389113891epsmtip1E;
        Mon, 19 Oct 2020 03:58:06 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] PM / devfreq: Add governor attribute flag for
 specifc sysfs nodes
To:     Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <1db2fb62-0b82-409d-20a7-c2ef376d4580@samsung.com>
Date:   Mon, 19 Oct 2020 13:11:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <4cb8ece7-9399-9ee0-5f93-6c19630308d6@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJsWRmVeSWpSXmKPExsWy7bCmnu55vt54g5PzJS2WXTrKaLFxxnpW
        i4k3rrBYrP74mNFize1DjBY/NpxitmiZtYjFYsGnGawWZ5vesFusuPuR1eLyrjlsFp97jzBa
        dH6ZxWaxsKmF3eJ24wo2i5+75rE4CHismbeG0WPH3SWMHjtn3WX32LSqk82jt/kdm8fGdzuY
        PP7O2s/i0bdlFaPH501yAZxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5
        ibmptkouPgG6bpk5QH8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgosC/SKE3OL
        S/PS9ZLzc60MDQyMTIEKE7Izvl6bzF7wgq3ib/95lgbG/axdjJwcEgImEk+XfmPqYuTiEBLY
        wSixb+pOFgjnE6PE1KUP2CGcz4wSFz/sZYdp+fByJ1i7kMAuRolPBxwgit4zSjy48B0sISwQ
        L3Fz/TdmEFtEoFbiyMUHbCBFzAIrmCTWrD/LApJgE9CS2P/iBhuIzS+gKHH1x2NGEJtXwE7i
        /rT5YNtYBFQlti94CGaLCoRJnNzWAlUjKHFy5hOwOZwCthKX360Hm8MsIC5x68l8JghbXmL7
        2znMIIslBH5wSDTc3Qb1govErNPnoCEgLPHq+BaouJTEy/42KLtaYuXJI2wQzR2MElv2X4Bq
        MJbYv3Qy0AYOoA2aEut36UOEFSV2/p7LCLGYT+Ld1x5WkBIJAV6JjjYhiBJlicsP7jJB2JIS
        i9s72SYwKs1C8s4sJC/MQvLCLIRlCxhZVjGKpRYU56anFhsWmCBH9yZGcCLXstjBOPftB71D
        jEwcjIcYJTiYlUR4IwW74oV4UxIrq1KL8uOLSnNSiw8xmgIDeCKzlGhyPjCX5JXEG5oaGRsb
        W5gYmpkaGiqJ8/7R7ogXEkhPLEnNTk0tSC2C6WPi4JRqYJLhli5qrNV4Xhv1nT3N4+Pvy8fP
        LjRdIpIjrZzfoP9x+z3XxtWWV1xK+Pb+tJ8eJLTmRFnsn8j7Syq+HP78/9kfUe/yEqNZaZmx
        Kbpykxi2LgucmvRXeIv19uS54odrM9TK/lxwPNJx6dq7aP/TC82+l6WYv5xkVqHtUX94tbjC
        Hrufr9efLxJiW3mi68Cc9vv2Le77s8+1LKiUCWdS/j3FZUqImvJ+i3pen9OOBa/tDmQr73sb
        NfvfjRLfS9IKWvNn8B2exWYlaN/2Sq/31dFvMslXD6zdVl/O7caw8lR3XEjrRYHdnzyu1ykd
        5bBwCC35nm/xLvSi7sufy/cnfPx+o0HeNVpytfGdspvvdiqxFGckGmoxFxUnAgDFiERkbQQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCSnO45vt54gyMrVS2WXTrKaLFxxnpW
        i4k3rrBYrP74mNFize1DjBY/NpxitmiZtYjFYsGnGawWZ5vesFusuPuR1eLyrjlsFp97jzBa
        dH6ZxWaxsKmF3eJ24wo2i5+75rE4CHismbeG0WPH3SWMHjtn3WX32LSqk82jt/kdm8fGdzuY
        PP7O2s/i0bdlFaPH501yAZxRXDYpqTmZZalF+nYJXBlfr01mL3jBVvG3/zxLA+N+1i5GTg4J
        AROJDy93gtlCAjsYJZ6f5YOIS0pMu3iUuYuRA8gWljh8uLiLkQuo5C2jxNee+UwgNcIC8RI3
        139jBrFFBGolXq2eDjaHWWAFk8TCz0IQMz8xSryYawhiswloSex/cYMNxOYXUJS4+uMxI4jN
        K2AncX/afHYQm0VAVWL7godgtqhAmMTOJY+ZIGoEJU7OfMICYnMK2EpcfreeDWKXusSfeZeY
        IWxxiVtPIG5jFpCX2P52DvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LjPJSy/WK
        E3OLS/PS9ZLzczcxgqNZS2sH455VH/QOMTJxMB5ilOBgVhLhjRTsihfiTUmsrEotyo8vKs1J
        LT7EKM3BoiTO+3XWwjghgfTEktTs1NSC1CKYLBMHp1QDU9nKHNHjL3jXhJ86mB3Et/vWxBe/
        llTknjA6rO/55J6+9+SiP3zdotU2Mx2W3XqVpxu4K7mzLrHufXH114f8LzU5rkWl7T5bYVVx
        6OCPxW67t0SHJMadYvuW5r/cVmH2fKfEmDXpP50zEzoSA/vXrF+w4Ja56r2SzVzfr2/YFxGx
        o3vROxsr/qyeWKnY3kyFwB1n5YzMe4q2O7tKLLhSx7m7drPipqs5xxUZ7xy9aumzfvapPboy
        Ggrt+np3l30+eNz497b/pUocNxs5H+9ZtrvxsPCDJdG/5Pa3KN3wvckZ6/ifWVLyx8fG1do7
        xTqXxsf1M+iZsRbtjK3fHLArM600wtF4Vc1vh9b5M+bcUWIpzkg01GIuKk4EAHzXfChVAwAA
X-CMS-MailID: 20201019035806epcas1p22dc6646d6f40e36a4797ad00fa46dd42
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201007045340epcas1p3b4d0f9187f5330a45d20d9d9b79f1767
References: <20201007050703.20759-1-cw00.choi@samsung.com>
        <CGME20201007045340epcas1p3b4d0f9187f5330a45d20d9d9b79f1767@epcas1p3.samsung.com>
        <20201007050703.20759-3-cw00.choi@samsung.com>
        <4cb8ece7-9399-9ee0-5f93-6c19630308d6@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/19/20 9:39 AM, Dmitry Osipenko wrote:
> ...
>> @@ -1361,6 +1373,9 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>  		goto out;
>>  	}
>>  
>> +	remove_sysfs_files(df, df->governor);
>> +	create_sysfs_files(df, governor);
>> +
>>  	prev_governor = df->governor;
>>  	df->governor = governor;
>>  	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
>> @@ -1460,39 +1475,6 @@ static ssize_t target_freq_show(struct device *dev,
>>  }
> 
> The further code may revert df->governor to the prev_governor or set it

prev_governor is better. I'll change it.

> to NULL. The create_sysfs_files(df->governor) should be invoked at the
> very end of the governor_store() and only in a case of success.

OK. I'll add more exception handling code.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792E3292178
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 05:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbgJSDkS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Oct 2020 23:40:18 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:44845 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731538AbgJSDkR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Oct 2020 23:40:17 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201019034014epoutp01549008db9b2ab03662e52ffc9df8f671~-R7Aldz2c2806428064epoutp01T
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 03:40:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201019034014epoutp01549008db9b2ab03662e52ffc9df8f671~-R7Aldz2c2806428064epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603078814;
        bh=Fu9FxWTZj8KK0hKciFpjNBpeDe9Ru6cUtyGHj3g2giU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LbAd6nh8ZKSWVqxd6i/kuSVhwNM6rO8OW4ctvJUhhlZC815H5mrj2P5v0NRkCNrwm
         mOLrsGcSSGTfhm5Xox3AHRu2oeVWl+gottJXGUHVm8F9CJt4YC4U+XFoboGAC8n2uj
         oJEOMcX3kdOhRPBzCn4ITRhzt0fhVgN7xXwRhKbE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201019034013epcas1p2f08a08b0958a3c9fc496ee28d3493bd4~-R6-1rdTm2094920949epcas1p2B;
        Mon, 19 Oct 2020 03:40:13 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4CF2Zf5vwGzMqYks; Mon, 19 Oct
        2020 03:40:10 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.1C.09577.A9A0D8F5; Mon, 19 Oct 2020 12:40:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201019034009epcas1p442daef3ca119825a1faebc541fc559eb~-R68ixOhA2048620486epcas1p4h;
        Mon, 19 Oct 2020 03:40:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201019034009epsmtrp14a627db8699bd6ce7d6e65103969f4a6~-R68h409M1670516705epsmtrp1S;
        Mon, 19 Oct 2020 03:40:09 +0000 (GMT)
X-AuditID: b6c32a39-c13ff70000002569-10-5f8d0a9aff36
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.AF.08604.99A0D8F5; Mon, 19 Oct 2020 12:40:09 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201019034009epsmtip1436bd147693d86079a9e245c2afe1972~-R68GwcsU0772407724epsmtip13;
        Mon, 19 Oct 2020 03:40:09 +0000 (GMT)
Subject: Re: [PATCH v3 1/2] PM / devfreq: Add governor feature flag
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
Message-ID: <9267f046-1adc-b43d-51ef-2e0ad41dc322@samsung.com>
Date:   Mon, 19 Oct 2020 12:53:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <83b952ab-a25e-8984-8804-1dd990eec835@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJsWRmVeSWpSXmKPExsWy7bCmvu4srt54g8VTdC2WXTrKaLFxxnpW
        i4k3rrBYrP74mNFize1DjBY/NpxitmiZtYjFYsGnGawWZ5vesFusuPuR1eLyrjlsFp97jzBa
        dH6ZxWaxsKmF3eJ24wo2i5+75rE4CHismbeG0WPH3SWMHjtn3WX32LSqk82jt/kdm8fGdzuY
        PP7O2s/i0bdlFaPH501yAZxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5
        ibmptkouPgG6bpk5QH8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgosC/SKE3OL
        S/PS9ZLzc60MDQyMTIEKE7Iz9hw8wlawn6+ie/tc9gbGfdxdjJwcEgImEpdu/2LvYuTiEBLY
        wShxtmkGE0hCSOATo8SdRZIQiW+MEiueXmaG6fi7dx0bRGIvo8TRw0ug2t8zSjRu+ADWLizg
        LNHTDjKXk0NEoFbiyMUHYB3MAiuYJNasP8sCkmAT0JLY/+IGG4jNL6AocfXHY0YQm1fATqJx
        222wGhYBVYmXxzeBxUUFwiRObmuBqhGUODnzCVgNp4CtRP/N+WDLmAXEJW49mc8EYctLNG+d
        zQyyWELgB4fE5SNToX5wkZgxsY8FwhaWeHV8CzuELSXxsr8Nyq6WWHnyCBtEcwejxJb9F1gh
        EsYS+5dOBtrAAbRBU2L9Ln2IsKLEzt9zGSEW80m8+9rDClIiIcAr0dEmBFGiLHH5wV0mCFtS
        YnF7J9sERqVZSN6ZheSFWUhemIWwbAEjyypGsdSC4tz01GLDAlPk6N7ECE7kWpY7GKe//aB3
        iJGJg/EQowQHs5IIb6RgV7wQb0piZVVqUX58UWlOavEhRlNgAE9klhJNzgfmkrySeENTI2Nj
        YwsTQzNTQ0Mlcd4/2h3xQgLpiSWp2ampBalFMH1MHJxSDUyFZrpqag7ThX7XbTu9Jzwr5fqR
        9eZd1pMF+ido3J/bvnmVsMZOgfqmE7bCO19uTFNKO7XmlzvXXu398rOF5cR3zX3pFzdnj17J
        xs8MPjIdWfO+MeyZ+XXTRP9lro+O3p75tcO5QEHPNdT4t+glSbvdO35e3PCkdX9hcXYjh1uZ
        6LJ9zJ+vcWaalhrfvOPkXeB4ZpKMctT7xDYbA5d6vtNLc2/ccrnuEnZqRmDpZLlVh3ZfXnX5
        hkZ2LUfbPdmDGZ+6jv7i0jV1jJzpcjlTIGx1t/HHCr4jpXk95h6PLF3O7/Ge/K5ocv3NC+9u
        pC1OSu4st/hf+LLliFm/nP/EG+bSvkycGQb5Jy4frjs7J1CJpTgj0VCLuag4EQBvAyo3bQQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWy7bCSnO5Mrt54g0PzdCyWXTrKaLFxxnpW
        i4k3rrBYrP74mNFize1DjBY/NpxitmiZtYjFYsGnGawWZ5vesFusuPuR1eLyrjlsFp97jzBa
        dH6ZxWaxsKmF3eJ24wo2i5+75rE4CHismbeG0WPH3SWMHjtn3WX32LSqk82jt/kdm8fGdzuY
        PP7O2s/i0bdlFaPH501yAZxRXDYpqTmZZalF+nYJXBl7Dh5hK9jPV9G9fS57A+M+7i5GTg4J
        AROJv3vXsXUxcnEICexmlFh0oJMdIiEpMe3iUeYuRg4gW1ji8OFiiJq3jBIfj+xnAakRFnCW
        6Gn/BVYvIlAr8Wr1dFYQm1lgBZPEws9CEA2fGCUuN/1kBEmwCWhJ7H9xgw3E5hdQlLj64zFY
        nFfATqJx222woSwCqhIvj28Ci4sKhEnsXPKYCaJGUOLkzCdgNZwCthL9N+ezQyxTl/gz7xIz
        hC0ucevJfCYIW16ieets5gmMwrOQtM9C0jILScssJC0LGFlWMUqmFhTnpucWGxYY5qWW6xUn
        5haX5qXrJefnbmIER7SW5g7G7as+6B1iZOJgPMQowcGsJMIbKdgVL8SbklhZlVqUH19UmpNa
        fIhRmoNFSZz3RuHCOCGB9MSS1OzU1ILUIpgsEwenVAPT0RmnJBVuLdom0s4hc3v9q85f1rzn
        TZ5ZOdxc/GNlSMqke0qGCtZ3T1ieu2nXt3qhj2HhuQoxIVb1mb2Gy4VD0+bzSHmvN5mSHBvw
        8E/STw1/wfUt6lEPtlX8fNTTK/Ryw54lOix9C55wfNi5R89m8Xbjol8ifdy1hZftzYP/x989
        en1N2AxLh7QrClyveyL/5f3cmnvku+abY+tTk59/0XXPaS2Nq/2z/zLPsV+OXL/7DT59uPKh
        68SN6z+E4mXyNZO+L9zWt0Vzdo+dboK3wP4jJruFdddk2GxxunL0iKqKfOk1IS6t0l+ZXBe1
        Kvub1x05/eL+jh0BVeUVWc7hn8Ivipxzt0uP4L2+/1iFEktxRqKhFnNRcSIAob/C7lcDAAA=
X-CMS-MailID: 20201019034009epcas1p442daef3ca119825a1faebc541fc559eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201007045340epcas1p4e63955385b1841f44e7a07e2d5d962c4
References: <20201007050703.20759-1-cw00.choi@samsung.com>
        <CGME20201007045340epcas1p4e63955385b1841f44e7a07e2d5d962c4@epcas1p4.samsung.com>
        <20201007050703.20759-2-cw00.choi@samsung.com>
        <83b952ab-a25e-8984-8804-1dd990eec835@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/19/20 9:57 AM, Dmitry Osipenko wrote:
> 07.10.2020 08:07, Chanwoo Choi пишет:
>> The devfreq governor is able to have the specific flag as follows
>> in order to implement the specific feature. For example, devfreq allows
>> user to change the governors on runtime via sysfs interface.
>> But, if devfreq device uses 'passive' governor, don't allow user to change
>> the governor. For this case, define the DEVFREQ_GOV_FLAT_IMMUTABLE
> 
> s/DEVFREQ_GOV_FLAT/DEVFREQ_GOV_FLAG/
> 
> ...
>>  /**
>>   * struct devfreq_governor - Devfreq policy governor
>>   * @node:		list node - contains registered devfreq governors
>>   * @name:		Governor's name
>> - * @immutable:		Immutable flag for governor. If the value is 1,
>> - *			this governor is never changeable to other governor.
>> - * @interrupt_driven:	Devfreq core won't schedule polling work for this
>> - *			governor if value is set to 1.
>> + * @flag:		Governor's feature flag
>>   * @get_target_freq:	Returns desired operating frequency for the device.
>>   *			Basically, get_target_freq will run
>>   *			devfreq_dev_profile.get_dev_status() to get the
>> @@ -50,8 +57,7 @@ struct devfreq_governor {
>>  	struct list_head node;
>>  
>>  	const char name[DEVFREQ_NAME_LEN];
>> -	const unsigned int immutable;
>> -	const unsigned int interrupt_driven;
>> +	const u64 flag;
> A plural form of flag(s) is more common, IMO.

When need to add more feature flag, I prefer to add
the definition instead of changing the structure.
I think it is better.

> 
> It's also possible to use a single bit:1 for the struct members. Thus,
> could you please explain what are the benefits of the "flag"?

I think that anyone might add the some optional
feature. So, I used 'flag' for the extensibility.



-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

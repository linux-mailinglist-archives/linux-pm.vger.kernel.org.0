Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028F641E5DD
	for <lists+linux-pm@lfdr.de>; Fri,  1 Oct 2021 03:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351548AbhJABkY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Sep 2021 21:40:24 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:53060 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351512AbhJABkW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Sep 2021 21:40:22 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211001013836epoutp011d600088f287eceae5450a994671fa76~pxG4GxiKW2502025020epoutp01M
        for <linux-pm@vger.kernel.org>; Fri,  1 Oct 2021 01:38:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211001013836epoutp011d600088f287eceae5450a994671fa76~pxG4GxiKW2502025020epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1633052316;
        bh=+dR6dxuL1XdtM5EYvhXaj9aP8mSTomPAnLV58Bkjyqc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WQ/mTd6UCSult0+i1xQjfTK8e8dHWgYzTbYBgsHRy6Lo8LiNsuli+sY7d4pjh+t1T
         Zgtz7ETNtnye5lZ0q6MhKWe4c+Jajd8YJeJb1+ibo1S+McP6PMYUZXTzs73vVAA1vN
         TetkmEJOmEo/Ov6cUoSUCnHMyXnmeTYgtYLg3MSw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20211001013836epcas1p2a7c0f1bf1a2124fc289bc0e5eab823b4~pxG3d5DmN2214122141epcas1p24;
        Fri,  1 Oct 2021 01:38:36 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.235]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4HLCS6489jz4x9QX; Fri,  1 Oct
        2021 01:38:30 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.BA.24398.E8666516; Fri,  1 Oct 2021 10:38:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211001013822epcas1p1b21ebd1027ae8acf925b80e210b7bb28~pxGqfu3XW3141431414epcas1p10;
        Fri,  1 Oct 2021 01:38:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211001013822epsmtrp234a1fd80c4df4db53004d40ee6a9c111~pxGqesTTG2205522055epsmtrp2V;
        Fri,  1 Oct 2021 01:38:22 +0000 (GMT)
X-AuditID: b6c32a35-0edff70000005f4e-45-6156668e5edb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.93.09091.D8666516; Fri,  1 Oct 2021 10:38:21 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211001013821epsmtip239204c4b13eeddbbfad70cc767745cf6~pxGqMv-RO2802528025epsmtip2L;
        Fri,  1 Oct 2021 01:38:21 +0000 (GMT)
Subject: Re: [PATCH 02/10] PM / devfreq: Do not require devices to have OPPs
To:     Samuel Holland <samuel@sholland.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7d404f89-6567-61e6-7964-d2ca578ed652@samsung.com>
Date:   Fri, 1 Oct 2021 10:59:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <d0a2c36b-4019-2f52-13f0-be76db5a48ec@sholland.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmgW5fWliiQfMWC4v5R86xWjyfv47R
        4mzTG3aLTY+vsVpc3jWHzeJz7xFGiyn7drFZtHUuY7W4eMrV4nbjCjaL1r1H2C2eP+pks/h3
        bSOLxc9D55kc+Dze32hl99jwaDWrx85Zd9k9Nq3qZPPYvKTe48XmmYwefVtWMXq8+jqX0ePz
        JrkAzqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg
        25UUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BaYFesWJucWleel6eaklVoYGBkam
        QIUJ2RnHlp9jKWiWrbi0rIu1gXGHeBcjJ4eEgInEqTNT2LoYuTiEBHYwSny/PZUJwvnEKHHo
        9GMo5xujxN4jl1lgWh49OcEIkdjLKHHhVDsLhPOeUeLYhQ1MIFXCAj4SN1+tYAOxRQTqJN4d
        PAU2ilmggVniwd5JYKPYBLQk9r+4AVbEL6AocfXHY0YQm1fATmL3vD9gNouAisSqSe1gQ0UF
        wiRObmuBqhGUODnzCdgcTgEHidcHZ4HFmQXEJW49mc8EYctLbH87hxlksYTACw6JBS/XM0H8
        4CLxr+EIG4QtLPHq+BZ2CFtK4vO7vVDxaomVJ4+wQTR3MEps2X+BFSJhLLF/6WSgQRxAGzQl
        1u/ShwgrSuz8PRfqCD6Jd197WEFKJAR4JTrahCBKlCUuP7gLdYKkxOL2TrYJjEqzkLwzC8kL
        s5C8MAth2QJGllWMYqkFxbnpqcWGBYbw+E7Oz93ECE7ZWqY7GCe+/aB3iJGJg/EQowQHs5II
        7w/x4EQh3pTEyqrUovz4otKc1OJDjKbAAJ7ILCWanA/MGnkl8YYmlgYmZkbGJhaGZoZK4rzH
        XlsmCgmkJ5akZqemFqQWwfQxcXBKNTDFnj3YG3Iu/Vn2dvZKpzKBoPbaaqUZlYu8P/5Q+VYh
        lLr/A6N86emda87qn/+z8OOqzjtMz91WrlOLrVy5PlTzS2FhasHWxAc/fr488HWHz3b77Zsl
        J9gXZCc1Ld7dvOXFvNzT/s9viMgxTL0+wbtKQNj5l4BpeP8p9ZMru68J26x2mpl24UYb29Ja
        Dpsn2X2xJ92fJrUHHlvL5DzBtkti2Zntn95tdXwVZM/3YUOzpMnJ9Z/bxAS+n9/I5Hloy7ue
        l282/bt9w0nr3aazVycclGDbG5upvExXZXn96k2dNaGs8vvDKrSf3dp1Z/XkkpWh2X92r+lZ
        s3XnqUKdu0+1Yx61KFty7RK2zU/TLD+/SImlOCPRUIu5qDgRAI3FjCdiBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSvG5vWliiwZw1xhbzj5xjtXg+fx2j
        xdmmN+wWmx5fY7W4vGsOm8Xn3iOMFlP27WKzaOtcxmpx8ZSrxe3GFWwWrXuPsFs8f9TJZvHv
        2kYWi5+HzjM58Hm8v9HK7rHh0WpWj52z7rJ7bFrVyeaxeUm9x4vNMxk9+rasYvR49XUuo8fn
        TXIBnFFcNimpOZllqUX6dglcGceWn2MpaJatuLSsi7WBcYd4FyMnh4SAicSjJycYuxi5OIQE
        djNKXPzyghEiISkx7eJR5i5GDiBbWOLw4WKImreMEqs+/mYGqREW8JG4+WoFG0hCRKCBUWLa
        t71gzcwCDcwSh/fUQXQsY5K4vO41G0iCTUBLYv+LG2A2v4CixNUfj8EaeAXsJHbP+wNmswio
        SKya1M4EYosKhEnsXPKYCaJGUOLkzCcsIDangIPE64OzoJapS/yZd4kZwhaXuPVkPhOELS+x
        /e0c5gmMwrOQtM9C0jILScssJC0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIE
        x66W5g7G7as+6B1iZOJgPMQowcGsJML7Qzw4UYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T
        8UIC6YklqdmpqQWpRTBZJg5OqQamlc8Zj69bp3rKaVJb2xOv+ZXTmxdVn6r8GrP7z8L7F+pz
        Kz9ZShr/2RC0cnHjn2uVATqpchs1dD1X9HrPEu8UlHbdXXDmbt42r7+H1c4tuKm+esXum/vc
        TTOmrfn0TbNkmffcr8vazdU2XvJc9KJNdn99/+TC560Lj13MDCp4WV9xJ095t6TQxjy/WOmO
        F2/neAfnefvcPrtXVy+gqKXWWTfTsn2LwxcZj5v7l7UYrOb/bvtqX7hI8Y1GznhZ9t/Fp57l
        bHDVf1O7d5uF3v/Q0MAXK3/eehe37uUsBvmJSd3CTOqaFoJ7Ftirbmaufluz/OW/p/9dfXxr
        wqZOZg/RF2nMy8nrC3jY7yDUMuGyEktxRqKhFnNRcSIAiExww0wDAAA=
X-CMS-MailID: 20211001013822epcas1p1b21ebd1027ae8acf925b80e210b7bb28
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210929044301epcas1p4d69083b46ca38d610981db6f01cfe9e4
References: <20210929044254.38301-1-samuel@sholland.org>
        <CGME20210929044301epcas1p4d69083b46ca38d610981db6f01cfe9e4@epcas1p4.samsung.com>
        <20210929044254.38301-3-samuel@sholland.org>
        <114afa7e-6218-6b1f-f87e-84690f10029c@samsung.com>
        <d0a2c36b-4019-2f52-13f0-be76db5a48ec@sholland.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/30/21 8:37 PM, Samuel Holland wrote:
> On 9/29/21 11:19 PM, Chanwoo Choi wrote:
>> Hi Samuel,
>>
>>
>> On 9/29/21 1:42 PM, Samuel Holland wrote:
>>> Since commit ea572f816032 ("PM / devfreq: Change return type of
>>> devfreq_set_freq_table()"), all devfreq devices are required to have a
>>> valid freq_table. If freq_table is not provided by the driver, it will
>>> be filled in by set_freq_table() from the OPPs; if that fails,
>>> devfreq_add_device() will return an error.
>>>
>>> However, since commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when
>>> adding the devfreq device"), devfreq devices are _also_ required to have
>>> an OPP table, even if they provide freq_table. devfreq_add_device()
>>> requires dev_pm_opp_find_freq_ceil() and dev_pm_opp_find_freq_floor() to
>>> return successfully, specifically to initialize scaling_min/max_freq.
>>>
>>> Not all drivers need an OPP table. For example, a driver where all
>>> frequencies are determined dynamically could work by filling out only
>>> freq_table. But with the current code it must call dev_pm_opp_add() on
>>> every freq_table entry to probe successfully.
>>
>> As you commented, if device has no opp table, it should call dev_pm_opp_add().
>> The devfreq have to use OPP for controlling the frequency/regulator.
>>
>> Actually, I want that all devfreq driver uses the OPP as default way.
> 
> The current code/documentation implies that an OPP table is intended to
> be optional. For example:
> 
>  * struct devfreq - Device devfreq structure
> ...
>  * @opp_table:  Reference to OPP table of dev.parent, if one exists.
> 
> So this should be updated if an OPP table is no longer optional.

Right. Need to update it.

> 
>> Are there any reason why don't use the OPP table?
> 
> dev_pm_opp_add() takes a voltage, and assumes the existence of some
> voltage regulator, but there is none involved here. The only way to have
> an OPP table without regulators is to use a static table in the
> devicetree. But that also doesn't make much sense, because the OPPs
> aren't actually customizable; they are integer dividers from a fixed
> base clock.

You can use OPP for only clock control without regulator. OPP already
provides them. OPP already provides the helpful function which
implement the functions to handle the clock/regulator or power doamin.
It is useful framework to control clock/regulator. 

If the standard framework in Linux kernel, it is best to use
this framework in order to remove the duplicate codes on multiple
device drivers. It is one of advantage of Linux kernel. 

Also, if OPP doesn't support the some requirement of you,
you can contribute and update the OPP.

 And adding a fixed OPP table to each board would be a lot of
> work to replace a trivial loop in the driver. So it seems to be the
> wrong abstraction.

I don't understand. As I commented for patch 10, you can add
the OPP entry of the clock without the fixed OPP table in devicetree.

> 
> Using an OPP table adds extra complexity (memory allocations, error
> cases), just to duplicate the list of frequencies that already has to
> exist in freq_table. And the driver works fine without any of that.

'freq_table' of devfreq was developed before of adding OPP interface to Linux kernel as I knew. Actually, I prefer to use the OPP interface
instead of initializing the freq_table directly by device driver.
I just keep the 'freq_table' for preventing the build/working issue
for older device driver. I think OPP is enough to control frequency/voltage
and it provides the various helper funcitons for user of OPP.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

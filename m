Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAC21DE1D9
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 10:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgEVIa6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 04:30:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37320 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgEVIa5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 04:30:57 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200522083055euoutp02f35bb913b643fddc71e414c2f1fcd90a~RTH-tbry-0905609056euoutp02B
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 08:30:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200522083055euoutp02f35bb913b643fddc71e414c2f1fcd90a~RTH-tbry-0905609056euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590136255;
        bh=923XDMPvMzBITkxCzoob3x8KxkiiUCf6+LVatdycTQ8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=q008Qyo2wTwXxLNYtAHHo8awe2hshjYVyg2Ki46zc7KG+sldsQB7KZlY5PLWZucVf
         GmLhY8uhp+iA2byPmCa8Hl189laubAjJ6kUXdT2gD8Z8VqvBEANrG8UZIjuua5kB+Z
         FcHy84kCCy8KAADCQeRkVUo6QZg+aJnbywIQR2do=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200522083055eucas1p25bec40701c5cda42e86e8a5082d52088~RTH-iP1z51044210442eucas1p2V;
        Fri, 22 May 2020 08:30:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 29.F0.60679.FBD87CE5; Fri, 22
        May 2020 09:30:55 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200522083055eucas1p1dfb4629dd7be586eef47f9782770e96d~RTH-FQs7n0903709037eucas1p1s;
        Fri, 22 May 2020 08:30:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200522083055eusmtrp1160b036d120ac281cbbc61f424f7882c~RTH-EoJaz2090920909eusmtrp1K;
        Fri, 22 May 2020 08:30:55 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-ff-5ec78dbf816e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 98.11.08375.EBD87CE5; Fri, 22
        May 2020 09:30:55 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200522083054eusmtip20ba8de3babb48f8af37f9e2c277595f5~RTH_m79wL3017030170eusmtip2Q;
        Fri, 22 May 2020 08:30:54 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] extcon: max14577: Add proper dt-compatible
 strings
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <a1f499fa-1907-93f5-6f57-13187ae10d7e@samsung.com>
Date:   Fri, 22 May 2020 10:30:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <8ec0c604-8cdc-04f8-fc5c-fd967f52022b@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjl3d3uruL0dVo+WCoMDAr8SqmBYWURYkRCSSU5nfPiRJ2yq9b6
        EfYlOpxYktpU1DSnAz/adM2VjWYpsvAjAyuTElaitr40obLI7Wb575znOc97zoGXIoQ6XiCV
        rSiklQpproj05JqGv4+FWTUjkkitIVh8t66HJ7455yDF0yvzPPH4eC9fPGVpIMXLmsdIPHOp
        gxTb7xceoBIM+nIyobJPjxKWDcFJRIrnvkw6N7uYVkbEpXvKW6at/IJ33ufbHItECWr2UiMP
        CnAMGA1NpBp5UkLcgeDlted8lqwgGHAauSxZRqBxdnM3ThrVMwS70CFoe2hCLPmEoNli57tU
        fjgJyhyfOS7sjzOg3tzPcYkIPIngveY66VqQOArUTrUbC3AcWDVWngtzcSg8aPnixltwKthb
        jYjV+MLoLYc7hgfeD3XDNjcmcAjcczYQLA6AV44mtxlgPR+WJmZJNvdh6G2d+NvBDxZH+vgs
        3g726goue3AFwdxYF58lFQimLtchVhULr8d+rL9ErVvshB5LBDs+CP1rFo5rDNgbXjh92RDe
        cMNUS7BjAZSVCln1DtCOdP+zfTTxjKhCIu2matpNdbSb6mj/+zYjrh4F0EVMXhbN7FbQ58IZ
        aR5TpMgKl+XnGdD697H/HlkxI8tahg1hCom8BG9lwxIhT1rMqPJsCChC5C9o8XkiEQoypaoL
        tDI/TVmUSzM2tI3iigIE0bcXUoU4S1pI59B0Aa3c2HIoj8ASVJ3988zXPZmp8uS0o986f6WX
        jeWYfU4l6kaZnqCPtoHWO2VLYUGyI2drSk/I4k/OJscqQlS17TVXu4ZIJ9Z2T1JPT38YMkuO
        dezFb0LbUWKKROdrOnRcvhy5dX4hxjiv7W3MapBVDFpXq1Sd9Y16YsrQUDkYfTF+bbWpPLq+
        WcRl5NKoXYSSkf4BFkJUFToDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7r7e4/HGcxYw2SxccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbP43HuE0eJ24wo2i9O7Sxw4PDat6mTz6NuyitHj8ya5AOYoPZui
        /NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYyF1/ezFzzl
        q1jy5BVzA+MCni5GTg4JAROJuV23mbsYuTiEBJYySqy92M0CkZCRODmtgRXCFpb4c62LDaLo
        LaPEvJNPwYqEBfwk/uw4zAZiiwgkSeyY0gQ2iVngMqPE1ps9jBAdvxgl7q17yg5SxSZgKNH1
        tgusg1fATmJ/736wFSwCqhJ7Fn4Es0UFYiVWX2tlhKgRlDg58wnYNk4Be4kZxw6B2cwCZhLz
        Nj9khrDlJba/nQNli0vcejKfaQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFhnrFibnF
        pXnpesn5uZsYgdG27djPzTsYL20MPsQowMGoxMP7IPlYnBBrYllxZe4hRgkOZiUR3oX8R+OE
        eFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YCPJK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmk
        J5akZqemFqQWwfQxcXBKNTBm1yWvvZkZELt115nStp1XunYv5sub83G90rHOmBVf7mmuP12X
        51zx06TVhaerKjmh/dLnsDvdldKmDq93rxNtPlXO8Xv1ukBWHc5ZJ/x1Zm1aan7b44PT8rl+
        hwN1Ai7l+r1cknnou+s1eYt240PPPk/YKrzNP/q3XrWFx4HKWR/mil34z3xOiaU4I9FQi7mo
        OBEABMLxn8wCAAA=
X-CMS-MailID: 20200522083055eucas1p1dfb4629dd7be586eef47f9782770e96d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200522064807eucas1p2665d6b3928b2ad515abe54513cbd7fd8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200522064807eucas1p2665d6b3928b2ad515abe54513cbd7fd8
References: <20200522064801.16822-1-m.szyprowski@samsung.com>
        <CGME20200522064807eucas1p2665d6b3928b2ad515abe54513cbd7fd8@eucas1p2.samsung.com>
        <20200522064801.16822-2-m.szyprowski@samsung.com>
        <8ec0c604-8cdc-04f8-fc5c-fd967f52022b@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 22.05.2020 09:08, Chanwoo Choi wrote:
> On 5/22/20 3:48 PM, Marek Szyprowski wrote:
>> Add device tree compatible strings and create proper modalias structures
>> to let this driver load automatically if compiled as module, because
>> max14577 MFD driver creates MFD cells with such compatible strings.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>> v2:
>> - added .of_match_table pointer
>> ---
>>   drivers/extcon/extcon-max14577.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
>> index 32f663436e6e..03af678ddeba 100644
>> --- a/drivers/extcon/extcon-max14577.c
>> +++ b/drivers/extcon/extcon-max14577.c
>> @@ -782,9 +782,19 @@ static const struct platform_device_id max14577_muic_id[] = {
>>   };
>>   MODULE_DEVICE_TABLE(platform, max14577_muic_id);
>>   
>> +static const struct of_device_id of_max14577_muic_dt_match[] = {
>> +	{ .compatible = "maxim,max77836-muic",
>> +	  .data = (void *)MAXIM_DEVICE_TYPE_MAX77836, },
>> +	{ .compatible = "maxim,max14577-muic",
>> +	  .data = (void *)MAXIM_DEVICE_TYPE_MAX14577, },
>> +	{ },
> How about changing the order between max77836 and max14577 as already added structure
> like platform_device_id if there are no specific reason as following:?
>
>
> static const struct of_device_id of_max14577_muic_dt_match[] = {
> 	{ .compatible = "maxim,max14577-muic",
> 	  .data = (void *)MAXIM_DEVICE_TYPE_MAX14577, },
> 	{ .compatible = "maxim,max77836-muic",
> 	  .data = (void *)MAXIM_DEVICE_TYPE_MAX77836, },
> 	{ },

Sure. I will swap them and send updated patch. This order comes from 
drivers/power/supply/max14577_charger.c, which also lacks 
.of_match_table, so I will also fix it.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


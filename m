Return-Path: <linux-pm+bounces-12909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E5E95FAF5
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 22:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBE628968D
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 20:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BF719CD0F;
	Mon, 26 Aug 2024 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J7nfFFY+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDD319ADB6
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705394; cv=none; b=VK/C2c5VG3zUpqkS8yIaLjl2laCmGIDJmXyxpnLxRSX07FMW4j504u/IA0Iyz1Jh/ZHJMvoktpLiUZbNLzuVi4VGFpg4uY3TwJto+dRapdSLISnJV6sU8y5erL+LaGt2dLrTW4Q5JLJKeamcx/x7XNhT8LgqX07EmQaOQZOsZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705394; c=relaxed/simple;
	bh=7CwGDAI4+fDUbBMkZSzTE7nNHqjO0muqXNuxv74F2Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=i0tNzaPUHeLgK/nedrBzcu8p9hwgfb6gjIOqAB4pH/4U/+zLMgh5m0XL2HJYhbe17yz9Iq+fsHM7lcUyNmqmkS5SxmNMz0oL5El69s591kDld1fNQNrWDRZAxi0ZAfqjQA6FlKJavOyLhkp9qD37MI6zHBGXO3Yw1vh6FWjuc4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J7nfFFY+; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240826204948euoutp01390509eb9b9694941a0d7cf747070186~vYmm3rJAX2645326453euoutp01a
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 20:49:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240826204948euoutp01390509eb9b9694941a0d7cf747070186~vYmm3rJAX2645326453euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724705388;
	bh=4rebIsHgGpe9kjnkdd2isgLAS+T1XfSGDMjRcmic9Iw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=J7nfFFY++U7ersfvpQKsiGvI+XD44S4VbJllaKj+oaMHLqoza9c7IgiRbTwkYWW1q
	 u0aYmVAkaQ+6qiwagoPzwtR94keBIiMgW5an9ellz45SfjK+xW5RE1cDjdXabCoA+W
	 dkXIItnO463XZFZx4xomutsfOEhLkRe34XBiGMCg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240826204947eucas1p2ca45b0683afb530c6bf3559f690b3604~vYmmMF54M0153901539eucas1p2v;
	Mon, 26 Aug 2024 20:49:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id B9.ED.09624.B6AECC66; Mon, 26
	Aug 2024 21:49:47 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240826204947eucas1p2f648781e2a641fef11d61f55e777c708~vYmlijHxe0150201502eucas1p2p;
	Mon, 26 Aug 2024 20:49:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240826204947eusmtrp28267c42beacf04153164872f0848c566~vYmlh8z2e0801108011eusmtrp2G;
	Mon, 26 Aug 2024 20:49:47 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-ea-66ccea6b9da6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C3.6B.08810.A6AECC66; Mon, 26
	Aug 2024 21:49:46 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240826204946eusmtip1e907729c0ac54601310fd3d59378378f~vYmktAT171021410214eusmtip1N;
	Mon, 26 Aug 2024 20:49:46 +0000 (GMT)
Message-ID: <0e710ff1-4ff4-403a-b85d-b1e51c03378a@samsung.com>
Date: Mon, 26 Aug 2024 22:49:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] thermal/of: Use the .should_bind() thermal
 zone callback
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
	<linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Daniel
	Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>,
	Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Linux Samsung SOC
	<linux-samsung-soc@vger.kernel.org>, Mateusz Majewski
	<m.majewski2@samsung.com>, linux-amlogic@lists.infradead.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAJZ5v0gOqNi+-Hi8uyeEJ9dHzhwU6GyL6t_7Xjt5Knf2yJmH-w@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7djP87rZr86kGez4rWkx77Osxd7XW9kt
	Fszmtri8aw6bxefeI4wWM87vY7JY2NTCbjHx2GRmi7lfpjJbnDl9idXiycM+NgdujzXz1jB6
	LN7zkslj06pONo871/aweWxeUu+x5Wo7i0ffllWMHp83yQVwRHHZpKTmZJalFunbJXBlvGr1
	LpgoVrHz5D7GBsZ2oS5GTg4JAROJ3k3P2bsYuTiEBFYwSky4cokNwvnCKNFy/CwThPOZUeL0
	2xmMMC3vJu1khUgsZ5SY+rwbquUjo0TP/PssIFW8AnYS++f+YgexWQRUJXZfeA8VF5Q4OfMJ
	mC0qIC9x/9YMsBphgQiJFY8msoHYIgLaEksWXWUGGcossJZZYs+vjWANzALiEreezGcCsdkE
	DCW63naBNXAKBEpMfjyLEaJGXqJ562ywZgmBdk6J9V8+AjVwADkuEv/nykC8ICzx6vgWdghb
	RuL/zvlMUPWMEgt+34dyJjBKNDy/BfW0tcSdc7/YQAYxC2hKrN+lDxF2lOg6dJQZYj6fxI23
	ghA38ElM2jYdKswr0dEGDWw1iVnH18GtPXjhEvMERqVZSMEyC8mXs5B8Mwth7wJGllWM4qml
	xbnpqcWGeanlesWJucWleel6yfm5mxiBSez0v+OfdjDOffVR7xAjEwfjIUYJDmYlEV65yyfT
	hHhTEiurUovy44tKc1KLDzFKc7AoifOqpsinCgmkJ5akZqemFqQWwWSZODilGphULv5Z1fFr
	66oinpArhjEOxVM+7xVmsaiIzJC5dWidaeOjLdzTmb+72U5q/vSfsenBxF8bo/0b1iy5+fZH
	696pbfNPbIy7MP/n1ethZgv+KrrZ7WLa5195/oDldo55rNvq1F64zdk5a/8e5cMxPZEdM29s
	tzCfu1d+x39WN/1/PZLZvHtWOrdERHXZiW78/XGd+vJjUbc1j2ZFNPfEb/y0dP9xyaCeFrVw
	v4OtKZliVTku9fpiHb42vlXXWYK/NS36sP7lsu2Tj12a+4shaKbA2Z9d9Vu+N/V5n71haSqd
	f/RvcNtJ+dc1Aln6RvNXN9Uef+m6Zzdn7pxVFf/sYmR+SorkyM9QLpvt/jt52o2HSizFGYmG
	WsxFxYkAm1Q7kNEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xu7pZr86kGcxpt7CY91nWYu/rrewW
	C2ZzW1zeNYfN4nPvEUaLGef3MVksbGpht5h4bDKzxdwvU5ktzpy+xGrx5GEfmwO3x5p5axg9
	Fu95yeSxaVUnm8eda3vYPDYvqffYcrWdxaNvyypGj8+b5AI4ovRsivJLS1IVMvKLS2yVog0t
	jPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyXrV6F0wUq9h5ch9jA2O7UBcjJ4eE
	gInEu0k7WbsYuTiEBJYySvz/38EIkZCRODmtgRXCFpb4c62LDaLoPaNEy4YuFpAEr4CdxP65
	v9hBbBYBVYndF95DxQUlTs58AmaLCshL3L81A6xGWCBCov1tM1hcREBbYsmiq8wgNrPAWmaJ
	Bdv4IRYsZpLo//qJCSIhLnHryXwwm03AUKLrLcgVnBycAoESkx/PYoSoMZPo2toFZctLNG+d
	zTyBUWgWkjtmIRk1C0nLLCQtCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG7bZjPzfv
	YJz36qPeIUYmDsZDjBIczEoivHKXT6YJ8aYkVlalFuXHF5XmpBYfYjQFBsZEZinR5Hxg2sgr
	iTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamCSOdqxfKbTpJA9zrrv
	bz0+KPOrqvf7uYyJ/oJM+wV+Bdu7Kd3XTDtlmJD83aaoRN/5Zmn+C42cWRq77ydOsoqtSPqb
	Wlhq/0N23iT2v7GFK/rsdXZcXJ7gbP3+hH5+o/oJpi2d2fuy0+LnpVSpSyzb5M+bbcDz753C
	o1VRvzufKrS2zdUpMos++4FhW6vDw0s9lyT3qT9SuPIxi8m/Q6Ql83bXvLdvltbPztZ3qnfe
	vunv87KHLz1MLn9be1L9v6LRiqg93P0bHP+pH2OY87T1Znzi/3/Vvf0XMt2kszOeVfYKH9iX
	e/DPR3nRWTpn1TYYMKUW/C/wfnj9Mbe3EtO9GJEflm0KVrcKDjjN6VdiKc5INNRiLipOBABb
	MTeTYwMAAA==
X-CMS-MailID: 20240826204947eucas1p2f648781e2a641fef11d61f55e777c708
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240826113153eucas1p110e90b4cd98aa70601770fe93d7aa1e5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240826113153eucas1p110e90b4cd98aa70601770fe93d7aa1e5
References: <2205737.irdbgypaU6@rjwysocki.net>
	<CGME20240826113153eucas1p110e90b4cd98aa70601770fe93d7aa1e5@eucas1p1.samsung.com>
	<2236794.NgBsaNRSFp@rjwysocki.net>
	<ef729a47-b7f9-48b6-a14d-692565ef1d38@samsung.com>
	<CAJZ5v0gOqNi+-Hi8uyeEJ9dHzhwU6GyL6t_7Xjt5Knf2yJmH-w@mail.gmail.com>

On 26.08.2024 14:14, Rafael J. Wysocki wrote:
> On Mon, Aug 26, 2024 at 1:32 PM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 19.08.2024 18:30, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Make the thermal_of driver use the .should_bind() thermal zone callback
>>> to provide the thermal core with the information on whether or not to
>>> bind the given cooling device to the given trip point in the given
>>> thermal zone.  If it returns 'true', the thermal core will bind the
>>> cooling device to the trip and the corresponding unbinding will be
>>> taken care of automatically by the core on the removal of the involved
>>> thermal zone or cooling device.
>>>
>>> This replaces the .bind() and .unbind() thermal zone callbacks which
>>> assumed the same trip points ordering in the driver and in the thermal
>>> core (that may not be true any more in the future).  The .bind()
>>> callback would walk the given thermal zone's cooling maps to find all
>>> of the valid trip point combinations with the given cooling device and
>>> it would call thermal_zone_bind_cooling_device() for all of them using
>>> trip point indices reflecting the ordering of the trips in the DT.
>>>
>>> The .should_bind() callback still walks the thermal zone's cooling maps,
>>> but it can use the trip object passed to it by the thermal core to find
>>> the trip in question in the first place and then it uses the
>>> corresponding 'cooling-device' entries to look up the given cooling
>>> device.  To be able to match the trip object provided by the thermal
>>> core to a specific device node, the driver sets the 'priv' field of each
>>> trip to the corresponding device node pointer during initialization.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> This patch landed recently in linux-next as commit 6d71d55c3b12
>> ("thermal/of: Use the .should_bind() thermal zone callback")
> It has been fixed since and it is commit  94c6110b0b13c6416146 now.


Confirmed. Thanks for fixing it and sorry for the noise.


> Bottom line is that it was calling of_node_put() too many times due to
> a coding mistake.
>
>> In my tests I found that it breaks booting some on my test boars: Exynos-based
>> (OdroidXU4 with ARM32 bit kernel from multi_v7_defconfig) and Amlogic
>> Meson based boards (OdroidC4, VIM3 with ARM64 defconfig+some debug
>> options). Reverting $subject on top of next-20240823 together with
>> c1ee6e1f68f5 ("thermal: core: Clean up trip bind/unbind functions") and
>> 526954900465 ("thermal: core: Drop unused bind/unbind functions and
>> callbacks") due to compile dependencies fixes the issue.
> Thanks for the report!
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland



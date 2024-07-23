Return-Path: <linux-pm+bounces-11337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D234593A274
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 16:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8991D285468
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 14:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B133A154BFC;
	Tue, 23 Jul 2024 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cOg1Ua6J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92A015445D
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744229; cv=none; b=Jz61kqcp5Bx8VoMYDzcHdXH4xlgT2KITAxoHkNnVi7trpBcwXnjRgkQiD2lzRyYes36UmQ5C4CPDPo4hAbEqm8Xfz+4kaP37/RQVbjGx2zsnm+quEvgHjvepqD5mkp194E7VXUJyU0VHCSnqUFM1N5e/gsAh4YSPge2du4YK9VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744229; c=relaxed/simple;
	bh=HwHLA3rfZYsbiPHmlGtsmkih2j77vdnLLBymEvn9N0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=QVHdic+GHJDhCk6ES/JvQ/O2k7p06WRaY5Te361vPVViw/nzzsDGif3h6wIVnWVuZ8nEOn8yxBDZkhQckkkocGa1R1srCJ33WsEfsR5df6Bn/w7LntpesPdTw8SqLXk4C2gZygxW5qd913/TnBGtre2TL/8J8aVD6JN9VOEmMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cOg1Ua6J; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240723141706euoutp01bbdeb7339ff8811b07725f8ce0e208bc~k3UB1zLS13253332533euoutp01e
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 14:17:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240723141706euoutp01bbdeb7339ff8811b07725f8ce0e208bc~k3UB1zLS13253332533euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721744226;
	bh=HwHLA3rfZYsbiPHmlGtsmkih2j77vdnLLBymEvn9N0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOg1Ua6Jc33qYfFyRFgO9ycN0zr7vpRCH430ZzFQFS43IKD9DYjr75lV+0M+FG3xT
	 e2IKLx3OZKm658pG2pHhwgqusj8eiMAC5FNQ9cypS1l4R2YJ2PNC2kUZ8u2gdzWQS0
	 lGhKhAu3FgNTCHPOOHM1uS1p5Soc8mssECw/D5oA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240723141706eucas1p2d4b0c035091326668409b954be4ac1e8~k3UBZIy_71984019840eucas1p2W;
	Tue, 23 Jul 2024 14:17:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id BE.68.09624.16BBF966; Tue, 23
	Jul 2024 15:17:05 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240723141705eucas1p1bbe72a6d543031a41efdbe81d1b03ac3~k3UA7uE-10792907929eucas1p1O;
	Tue, 23 Jul 2024 14:17:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240723141705eusmtrp21a8bb62bf27b5e187d7e5ba96df119c1~k3UA646ES2759727597eusmtrp2Q;
	Tue, 23 Jul 2024 14:17:05 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-2c-669fbb610730
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A7.C0.09010.16BBF966; Tue, 23
	Jul 2024 15:17:05 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240723141704eusmtip2f31289a1887725ea7b0f51e106d12ef1~k3UABooue2238622386eusmtip2Z;
	Tue, 23 Jul 2024 14:17:04 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Mateusz Majewski <m.majewski2@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH 5/6] drivers/thermal/exynos: add initial Exynos 850
 support
Date: Tue, 23 Jul 2024 16:16:54 +0200
Message-ID: <20240723141658.374755-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <CAPLW+4n6XB3fm8KQA=6_2z8ay9pDPtu-VFgAaW5imZkRH2ywkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87qJu+enGez9a27xYN42NovvW64z
	WazZe47JYt5nWYv5R86xWpw/v4HdYtPja6wWl3fNYbP43HuE0WLG+X1MFgubWtgtJh6bzGwx
	98tUZov/e3awWzx52Mdm8bxvH5ODgMeaeWsYPXbOusvusXjPSyaPTas62TzuXNvD5rF5Sb1H
	35ZVjB6fN8kFcERx2aSk5mSWpRbp2yVwZVw8/Jqx4KhwxdwTjxkbGE/zdzFyckgImEgcPPmZ
	sYuRi0NIYAWjxJXJPSwQzhdGiXOvZjJBOJ8ZJd6uaGeBadk39yMrRGI5o0Rz33Oo/lYmif+H
	z4NVsQkYSDx4s4wdxBYR0JNYN/MVO0gRs8BmFokLT2eygiSEBQIlzq9pAmrg4GARUJU4vYgb
	JMwrYCvx5T7IUSDb5CV69/cxgdicQOX3nnSxQdQISpyc+QRsFzNQTfPW2cwg8yUE+jklNq29
	yQ4yU0LAReLOHDGIOcISr45vYYewZST+75zPBGHnS8zY/J4ForxC4u5BLwjTWuLjGWYQk1lA
	U2L9Ln2IYkeJ71NuQc3mk7jxVhBiP5/EpG3TmSHCvBIdbUIQ1aoSx/dMYoawpSWetNxmgijx
	kJg3k3UCo+IsJI/MQvLILIS1CxiZVzGKp5YW56anFhvmpZbrFSfmFpfmpesl5+duYgSmtdP/
	jn/awTj31Ue9Q4xMHIyHGCU4mJVEeJ+8mpsmxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc1RT5V
	SCA9sSQ1OzW1ILUIJsvEwSnVwKSn1MlsonP+pat5xMe7b1fVREkbbfjMmO9V0csbYKAvz7R9
	66Sn9w9+nvr6vQ//pcYvzvJ6Ahc2lz99auN7MyxrelfSjPf++v8+nTScGpzNuUhwdrvIqdn3
	2Z01A/fuumB2Zuqea+y5c30Kb53zDIm1uH6l6LJyi8HF/5Uy11QY72vo3FjY8lau2KNriZ4D
	q8/qAPlt8+ZJWW84vHH+xEyFr4k2aYaL491qz83btc5jZ6pQ0ualb9p9yhWsTvzaH3i59brA
	rA3LeYQSRH2ObFjjNldJ3vLhit05N3Y935f41+cY7wvhMIc93oUpoleDV7R4rCxL5FPUCP31
	2XR2RAm7//aZWabTF8sujT3FFqXEUpyRaKjFXFScCAAXJoJv2gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xe7qJu+enGaxfL27xYN42NovvW64z
	WazZe47JYt5nWYv5R86xWpw/v4HdYtPja6wWl3fNYbP43HuE0WLG+X1MFgubWtgtJh6bzGwx
	98tUZov/e3awWzx52Mdm8bxvH5ODgMeaeWsYPXbOusvusXjPSyaPTas62TzuXNvD5rF5Sb1H
	35ZVjB6fN8kFcETp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
	pRbp2yXoZVw8/Jqx4KhwxdwTjxkbGE/zdzFyckgImEjsm/uRFcQWEljKKLHvdxBEXFri8Jcp
	7BC2sMSfa11sEDXNTBJ/J1WD2GwCBhIP3iwDqxER0JNYN/MVkM3FwSxwkEWi7/UVZpCEsIC/
	xPcL7SxdjBwcLAKqEqcXcYOEeQVsJb7c/8wIMV9eond/HxOIzSkQKHHvCcwuHolXG/YzQtQL
	Spyc+YQFxGYGqm/eOpt5AqPALCSpWUhSCxiZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRG
	4bZjP7fsYFz56qPeIUYmDsZDjBIczEoivE9ezU0T4k1JrKxKLcqPLyrNSS0+xGgKdPZEZinR
	5HxgGsgriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamDaHP/0sz7L
	bHGlNqnVJfZRUfPY9lmwHwtfecKz2StU6e3J9IrpLZeuJB7dc5WJ0/Kw1rRtTAqHfl/dFFVU
	UVcw84FRe95csZRz7InlD5btrOJb5V8z2bB/+/4pt6qcPmibtAZ2VDh/YP5q7M1z/tbmOT/u
	rPGTXdF+lLFHoCnL/vyMf79Y7dq3f/wj+l7ZPsrhwhUepXmz3ipcdxbU8jk25avKBy3pjYHP
	IvOT5zMyrL+0MWlP1InGgmltC+eIdkhPP/Sm6dyE12WytpoTZvEGOCQvVk1jvHlIaX9sidPE
	v70H7q0wYbryvkB+6e0Srhf+5QWtecoLcm5tdlgmzBtU87D+sOojv/WyB+abfwpVYinOSDTU
	Yi4qTgQA5JGYSUsDAAA=
X-CMS-MailID: 20240723141705eucas1p1bbe72a6d543031a41efdbe81d1b03ac3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240723141705eucas1p1bbe72a6d543031a41efdbe81d1b03ac3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240723141705eucas1p1bbe72a6d543031a41efdbe81d1b03ac3
References: <CGME20240723141705eucas1p1bbe72a6d543031a41efdbe81d1b03ac3@eucas1p1.samsung.com>

> Do you know what are the possible implications of not using ACPM? As I
> understand, ACPM is a Samsung's downstream framework which uses APM
> (Active Power Management) IP block internally to act as an IPC
> mechanism, which makes it possible to offload any PM related
> operations (which might get quite heavy, if we are to belive the TRM
> description of APM) from CPU to APM. I'm not against the direct
> registers access based implementation (in fact, I'm not sure how that
> APM/ACPM thing can be implemented in upstreamable way and if it's
> worth it at all). Just curious if we understand what we are
> potentially missing out, and if at some point we'll be forced to
> implement that ACPM thing anyway (for something else)?

Not sure honestly. The downstream v4.10 driver does many operations on
registers anyway...?

> Not sure if that's true, as already discussed in my comments for the
> previous patches. Looks like one clock is still needed, which is the
> PCLK bus clock (to interface registers) which might simultaneously act
> as an operating (functional) clock.

The code seems to be working correctly without this clock, both register
reads and writes. Maybe the support for extra sensors, which I couldn't
get to work, would require this clock?

> Exynos850 TRM says AVG_CONTROL offset is 0x38, and 0x58 is actually
> for THRESHOLD0_TEMP_RISE3_2 register.

Thank you so much! Will fix in v2. Though writing to the right place
doesn't seem to change much in practice, probably just means that the
correct mode is being used.

> Something seems off to me here. How come the shift value for EXYNOS7
> case is 8, but the mask is actually 9 bits long? Does it mean the
> first error field is 8 bits long, and the second error field is 9 bits
> long for EXYNOS7? I don't have the Exynos7 manual, so it's just a
> hunch. But if it's true, maybe this shift value has to be added in
> your [PATCH 2/6] to fix Exynos7 case?

I did not really want to mess with Exynos7 code, as we don't have an
Exynos7 board sadly. Honestly I feel like I should drop the 2/6 patch
completely and only modify the code to run on 850 correctly.

> Also, just an idea: those values (and other similar values) could be
> pre-calculated somewhere during the probe, stored in some struct (e.g.
> _variant or _chip) and then just used here.

sanitize_temp_error is only called one per probe and once per resume, so
probably little to gain?

Will also do all other.


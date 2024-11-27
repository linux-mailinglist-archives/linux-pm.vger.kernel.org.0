Return-Path: <linux-pm+bounces-18141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F8B9DA254
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 07:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D74164C3A
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 06:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A0113D518;
	Wed, 27 Nov 2024 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gqQv2B56"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D39F9DD
	for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2024 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689082; cv=none; b=CsU1+cEA47sMw/UBCgFiHtw6lNbAfSznrmOyTUjKw2hKw1mDoqGxXYNUOthJVKBF+BZs1tmjMhQf81MbiFPm8AadnjRxEf27TI0cjO1wPHF7Ro8HdTztcVwybaQ3CKey8I+eJLZnWMitjcAXEisdKT1pE423FSNDOQB2mdP9oYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689082; c=relaxed/simple;
	bh=6gup5rcGcHRqPaqbv7qNhCeBnwcpAntWNNS9tN6rf90=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=NCC6rwl/hvxsTriUB2HLBXLX8ceuopcznjFcHHrNxiZQELYktxbnwNQ72RbZXv+YuMB14wNqDGy8l+gODinErnCIUWzsR/LTNA0aeDc7TNSi1SfM9up3iyajKyraRGRYoBA8kdaUJKnF0d+wIW5BAUgf+Z99SjARo/TOvkGUJuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gqQv2B56; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241127063116epoutp03deb4f03998e30777eac8734ecca6598b~Lv4kD2jee2613726137epoutp03C
	for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2024 06:31:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241127063116epoutp03deb4f03998e30777eac8734ecca6598b~Lv4kD2jee2613726137epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1732689076;
	bh=oyBPiDFxpugLhphojTwQAjaCBZHDWP9JHzRTzwk1kMM=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=gqQv2B56GMrLUb4irjYWq1FjcAi/tNSZMVkkvCqlyOY3H3n4DX6J4mJJYxeheH3zG
	 Wq4Vi7CnreSAVMmo3odlPA8koNPbXzAe2otMVNtp29w8gQfvQ9vypiiFQfgOvOXeDN
	 XEBtP2M/xQTi7FnvUKr3RIoPcGdDCqArlR/W4uqs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241127063116epcas1p266d4cac491878746784f1d8fb9272cb4~Lv4jzoIYN1360513605epcas1p25;
	Wed, 27 Nov 2024 06:31:16 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.145]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4XyqMl4dffz4x9Q1; Wed, 27 Nov
	2024 06:31:15 +0000 (GMT)
X-AuditID: b6c32a35-9a75224000005492-21-6746bcb20918
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	B3.1B.21650.2BCB6476; Wed, 27 Nov 2024 15:31:14 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH] PM / devfreq: Remove unused devfreq_event_reset_event
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Chanwoo Choi <cw00.choi@samsung.com>
CC: "linux@treblig.org" <linux@treblig.org>, Kyungmin Park
	<kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241127063114epcms1p5aac02aa2dee6506cd7c70511c42568f0@epcms1p5>
Date: Wed, 27 Nov 2024 15:31:14 +0900
X-CMS-MailID: 20241127063114epcms1p5aac02aa2dee6506cd7c70511c42568f0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7bCmvu6mPW7pBq9mC1tc//Kc1eJs0xt2
	i8u75rBZfO49wmix/vkNJgdWj74tqxg9Vi6fwO7xeZNcAHNUtk1GamJKapFCal5yfkpmXrqt
	kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0EolhbLEnFKgUEBicbGSvp1NUX5pSapC
	Rn5xia1SakFKToFpgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGzEnH2QuuiFX8bbvI0sDYLdzF
	yMkhIWAi8eRgO3MXIxeHkMAORoktyy8xdTFycPAKCEr83QFWIyzgJbHm2Q4mEFtIQEmi4eY+
	Zoi4vkTHg22MIDabgK7E1g13WUBsEQENiZl/rzCCzGQWuMQocbZlETPEMl6JGe1PWSBsaYnt
	y7cyQtiiEjdXv2WHsd8fmw8VF5FovXcWqldQ4sHP3VBxSYm+O3uZQBZICGxjlNhxZA4bhLOf
	UWLKwzaoSfoSZ+aeZAOxeQV8JZZf3QlmswioSrzfsBNqqotEy4flYFOZBeQltr+dwwzyPbOA
	psT6XfoQYT6Jd197WGEe2DHvCROErSZxaPcSqFUyEqenL4Qa6SGx7MpENkhoBUo86NjFNoFR
	bhYiTGchWTYLYdkCRuZVjGKpBcW56anFhgWG8GhMzs/dxAhOZ1qmOxgnvv2gd4iRiYPxEKME
	B7OSCC+fuHO6EG9KYmVValF+fFFpTmrxIUZToDcnMkuJJucDE2peSbyhiaWBiZmRsYmFoZmh
	kjjvmStlqUIC6YklqdmpqQWpRTB9TBycUg1Mu94qPKwNvfZp/lax4LzNHcctp6cnu/Ye0RFZ
	ztdyyudjnpxug5bsiqa30yIEWiMesx0ttH3Vc0r4/9c8ke+tBlzvk57ETJ/T9kmslyMsyv98
	drp/AwPzUb2OS8c2bl97vOupYVt31UMj6ctmS3lyOwyfv4+7WqnF8f2gNzuXtuZ67l1TD7D1
	zrnEuPL4GpPZElNZ3ZL2Nxm8e7FrXgPvOcUjd+qsLi3mTeNdbqKV3vj0DeOsOuOaox4hr69d
	/Cb9xu76b+99/SYTwjjTnkp1vF78cEpN/jeFJQV+ix6WfTuruytoqdmhLX+ytDpE1xYWJ1yP
	mT7Z1++EzZ4QpX7vsI5DrREG/tt5XGW2K6crsRRnJBpqMRcVJwIAyx/G4PADAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241127063114epcms1p5aac02aa2dee6506cd7c70511c42568f0
References: <CGME20241127063114epcms1p5aac02aa2dee6506cd7c70511c42568f0@epcms1p5>

>From: "Dr. David Alan Gilbert" 
>
>devfreq_event_reset_event() was added in 2015 by
>commit f262f28c1470 ("PM / devfreq: event: Add devfreq_event class")
>
>but has remained unused.
>
>Remove it.
>
>Signed-off-by: Dr. David Alan Gilbert 

Chanwoo: 

do we really don't have any drivers using these?
- devfreq_event_reset_event
- devm_devfreq_(un)register_notifier
including both the upstream and forks?

Anyway, I couldn't find one.

Cheers,
MyungJoo

>---
> drivers/devfreq/devfreq-event.c | 26 --------------------------
> include/linux/devfreq-event.h   |  6 ------
> 2 files changed, 32 deletions(-)
>
>diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
>index 3ebac2496679..a60703374006 100644
>--- a/drivers/devfreq/devfreq-event.c
>+++ b/drivers/devfreq/devfreq-event.c
>@@ -183,32 +183,6 @@ int devfreq_event_get_event(struct devfreq_event_dev *edev,
> }
> EXPORT_SYMBOL_GPL(devfreq_event_get_event);
> 
>-/**
>- * devfreq_event_reset_event() - Reset all opeations of devfreq-event dev.
>- * @edev	: the devfreq-event device
>- *
>- * Note that this function stop all operations of devfreq-event dev and reset
>- * the current event data to make the devfreq-event device into initial state.
>- */
>-int devfreq_event_reset_event(struct devfreq_event_dev *edev)
>-{
>-	int ret = 0;
>-
>-	if (!edev || !edev->desc)
>-		return -EINVAL;
>-
>-	if (!devfreq_event_is_enabled(edev))
>-		return -EPERM;
>-
>-	mutex_lock(&edev->lock);
>-	if (edev->desc->ops && edev->desc->ops->reset)
>-		ret = edev->desc->ops->reset(edev);
>-	mutex_unlock(&edev->lock);
>-
>-	return ret;
>-}
>-EXPORT_SYMBOL_GPL(devfreq_event_reset_event);
>-
> /**
>  * devfreq_event_get_edev_by_phandle() - Get the devfreq-event dev from
>  *					 devicetree.
>diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
>index 4a50a5c71a5f..461080280de9 100644
>--- a/include/linux/devfreq-event.h
>+++ b/include/linux/devfreq-event.h
>@@ -104,7 +104,6 @@ extern bool devfreq_event_is_enabled(struct devfreq_event_dev *edev);
> extern int devfreq_event_set_event(struct devfreq_event_dev *edev);
> extern int devfreq_event_get_event(struct devfreq_event_dev *edev,
> 				struct devfreq_event_data *edata);
>-extern int devfreq_event_reset_event(struct devfreq_event_dev *edev);
> extern struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(
> 				struct device *dev,
> 				const char *phandle_name,
>@@ -149,11 +148,6 @@ static inline int devfreq_event_get_event(struct devfreq_event_dev *edev,
> 	return -EINVAL;
> }
> 
>-static inline int devfreq_event_reset_event(struct devfreq_event_dev *edev)
>-{
>-	return -EINVAL;
>-}
>-
> static inline struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(
> 					struct device *dev,
> 					const char *phandle_name,
>-- 
>2.47.0
>
>
>


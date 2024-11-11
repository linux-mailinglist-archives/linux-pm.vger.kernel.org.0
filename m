Return-Path: <linux-pm+bounces-17309-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D62839C3994
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 09:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5E3B21506
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 08:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DA915A86B;
	Mon, 11 Nov 2024 08:19:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869A013E02E;
	Mon, 11 Nov 2024 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731313176; cv=none; b=uGVuseeDCGxKQeOhLwrWwpEVvYYenF3U28mLfkxcOxChcu4dz2HSW+fvfCi8bPxEe65JI3TkSLHPJB+ZqXZkTc2vC0C3Y9ndYSZg6u/CyXuff9z5alSq393EoNxnq1c/zWDz6J4H9VNZVUyRMPR5A49E4o8qGgX5PuH+1zj+A7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731313176; c=relaxed/simple;
	bh=UrMHmMibXxLuxC7cq6KCdFjhLGzisbnz7OopfqqHEvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJS20f0gP0zSPUeZmILFm/0n2kBky7XbsD8Z6wdKMk7gDfTY1atbFdNuPgakkzr+VXwS4Mx2XvsIjNdJkXMTPoL8lVUnGT8UtlOLf1JnoT9hojydfB5D1Sw82eslGkWKmzdzTwDuNJYo2spfqhVWVnEMVzUbkMwgn8UhFnOFWew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16731be0a068-d497d;
	Mon, 11 Nov 2024 16:19:22 +0800 (CST)
X-RM-TRANSID:2ee16731be0a068-d497d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66731be09bd1-27283;
	Mon, 11 Nov 2024 16:19:22 +0800 (CST)
X-RM-TRANSID:2ee66731be09bd1-27283
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: rafael@kernel.org
Cc: daniel.lezcano@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	rui.zhang@intel.com,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: Re: [PATCH] tools/thermal: Fix common realloc mistake
Date: Mon, 11 Nov 2024 16:19:18 +0800
Message-Id: <20241111081918.15229-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAJZ5v0gHGrRn0cLvsSTaX=tX8mVhxudoJ4aSh5jWNxh171oKgg@mail.gmail.com>
References: <CAJZ5v0gHGrRn0cLvsSTaX=tX8mVhxudoJ4aSh5jWNxh171oKgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

On Fri, 8 Nov 2024 13:09 PM Rafael J. Wysocki
<Rafael J. Wysocki> wrote:
>>On Fri, Nov 8, 2024 at 7:39 AM zhangjiao2
>><zhangjiao2@cmss.chinamobile.com> wrote:
>>
>> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>>
>> Do not set thermometer->tz NULL when realloc failed.

>Presumably, this fixes a problem.

>What problem does it fix?
Thermometer->tz is NULL when realloc failed.
This will cause memory leaks. 
We should use temporary variables to 
check the return value of realloc.

>> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>> ---
>>  tools/thermal/thermometer/thermometer.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/thermal/thermometer/thermometer.c b/tools/thermal/thermometer/thermometer.c
>> index 1a87a0a77f9f..e08291a97fd8 100644
>> --- a/tools/thermal/thermometer/thermometer.c
>> +++ b/tools/thermal/thermometer/thermometer.c
>> @@ -259,6 +259,7 @@ static int thermometer_add_tz(const char *path, const char *name, int polling,
>>  {
>>         int fd;
>>         char tz_path[PATH_MAX];
>> +       void *tmp;
>>
>>         sprintf(tz_path, CLASS_THERMAL"/%s/temp", path);
>>
>> @@ -268,12 +269,13 @@ static int thermometer_add_tz(const char *path, const char *name, int polling,
>>                 return -1;
>>         }
>>
>> -       thermometer->tz = realloc(thermometer->tz,
>> +       tmp = realloc(thermometer->tz,
>>                                   sizeof(*thermometer->tz) * (thermometer->nr_tz + 1));
>> -       if (!thermometer->tz) {
>> +       if (!tmp) {
>>                 ERROR("Failed to allocate thermometer->tz\n");
>>                 return -1;
>>         }
>> +       thermometer->tz = tmp;
>>
>>         thermometer->tz[thermometer->nr_tz].fd_temp = fd;
>>         thermometer->tz[thermometer->nr_tz].name = strdup(name);
-- 
2.33.0





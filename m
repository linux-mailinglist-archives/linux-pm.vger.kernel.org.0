Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5718030B4EE
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 03:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhBBCAQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 21:00:16 -0500
Received: from pv50p00im-ztbu10011701.me.com ([17.58.6.53]:59983 "EHLO
        pv50p00im-ztbu10011701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229527AbhBBCAQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 21:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1612231160;
        bh=rGl5/iosVM/5pN5iya5pmf6fh8L6VxYZ78FobWeoRvk=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=mEWdeyPUHIQXfuu3//mKjmjXXvCjOkyEth0dBwJEQ0fv+SHpSnyFXmnF5F0F6U4QI
         ELTiBQuDdPGrgN7p2RNT/blAPeTYiqx9Yti0sdogKAW78QWmt06bGMldYIA6l5JYkT
         Gb2ujFoyvOFT8ZvMPyU8cK4BohWiUvLeq7gFUtil6xLt/I+cczbcxDO3FTERBm4OFz
         5UkMSUTORkI62VSfhs5iLAWapTmp/u80LruMr1z0MlwAf8z7Q8kLT9SdgPdkgk3XkT
         RMUclNRvYqiZAwdNyHS+QfpDth7kapx0x8+v0SHVmnOiPwqttKhIEvLUENhZtZdGZo
         a3EqYrzjzHSzA==
Received: from [11.240.15.70] (unknown [119.3.119.19])
        by pv50p00im-ztbu10011701.me.com (Postfix) with ESMTPSA id 3C4218A0551;
        Tue,  2 Feb 2021 01:59:17 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] PM: hibernate: add sanity check on power_kobj
From:   Abel Wu <abel.w@icloud.com>
In-Reply-To: <20210201105243.GA23135@duo.ucw.cz>
Date:   Tue, 2 Feb 2021 09:59:11 +0800
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, hewenliang4@huawei.com,
        wuyun.wu@huawei.com
Content-Transfer-Encoding: 7bit
Message-Id: <F87648CF-E5D6-41C7-9F4E-87A4BA2A4786@icloud.com>
References: <20210201075041.1201-1-abel.w@icloud.com>
 <20210201105243.GA23135@duo.ucw.cz>
To:     Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_14:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102020012
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> On Feb 1, 2021, at 6:52 PM, Pavel Machek <pavel@ucw.cz> wrote:
> 
> On Mon 2021-02-01 02:50:41, Abel Wu wrote:
>> The @power_kobj is initialized in pm_init() which is the same
>> initcall level as pm_disk_init(). Although this dependency is
>> guaranteed based on the current initcall serial execution model,
>> it would still be better do a cost-less sanity check to avoid
>> oops once the dependency is broken.
> 
> I don't believe this is good idea. If the dependency is ever broken,
> this will make failure more subtle and harder to debug.

Thanks for reviewing. I think the cmdline parameter initcall_debug will
help in this case.
Actually we are trying to make initcalls being called asynchronously to
reduce boot time which is crucial to our cloud-native business. And we
resolve this kind of dependencies by retrying failed initcalls.

Best regards,
	Abel
> 
>> Signed-off-by: Abel Wu <abel.w@icloud.com>
>> ---
>> kernel/power/hibernate.c | 3 +++
>> 1 file changed, 3 insertions(+)
>> 
>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>> index da0b41914177..060089cc261d 100644
>> --- a/kernel/power/hibernate.c
>> +++ b/kernel/power/hibernate.c
>> @@ -1262,6 +1262,9 @@ static const struct attribute_group attr_group = {
>> 
>> static int __init pm_disk_init(void)
>> {
>> +	if (!power_kobj)
>> +		return -EINVAL;
>> +
>> 	return sysfs_create_group(power_kobj, &attr_group);
>> }
>> 
>> -- 
>> 2.27.0
> 
> -- 
> http://www.livejournal.com/~pavelmachek


Return-Path: <linux-pm+bounces-6868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DC98ADB68
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 03:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19B53B217CE
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 01:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D4EF9D4;
	Tue, 23 Apr 2024 01:10:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727C8E57E
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713834635; cv=none; b=XHs2D9wbInXPT33VcN6pOyfWcQpxWS7TJ+rgbVPTOeeBMIqm1CmE2oeqF5FQKC47aKz/VYps0gYe2FqONvfWG3qRJvDvKyPak9cvOtn5fHvbYRxMkPBBnsNSmszth+bvYHoQZMPt4G2pdJv1gqrIcqeVZ1vECnwDwVW4dXa2EEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713834635; c=relaxed/simple;
	bh=GgMf3uMCmN0oqH6RpZtN3zKEbU5HvZScf/MrhNa7EcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWe+RjdL/EymK9G7SDmpAKtujevSsj+hZK03TYmN7X/WxhPLvmNsTN0sAMQIYhsmZz/gLIBq0lMH/OkYeDxTEdGtQNcaPw+XhWEPeSAgDw40wh3ATo+74fctzpgNan5h7JDwAAtNLXBhylpHDPIObhk/oWeZgGaupVlz2vM5eIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c338fb32010c11ef9305a59a3cc225df-20240423
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:41c87912-8174-4536-b24c-c2a4e066c345,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-6,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:14
X-CID-INFO: VERSION:1.1.37,REQID:41c87912-8174-4536-b24c-c2a4e066c345,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-6,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:14
X-CID-META: VersionHash:6f543d0,CLOUDID:50d37eff2965001d29c24b493887e7db,BulkI
	D:240422223350JJOW0951,BulkQuantity:8,Recheck:0,SF:24|16|19|44|64|66|38|10
	2,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_USA
X-UUID: c338fb32010c11ef9305a59a3cc225df-20240423
Received: from node4.com.cn [(39.156.73.12)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1734081977; Tue, 23 Apr 2024 08:59:39 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 8D14016002082;
	Tue, 23 Apr 2024 08:59:39 +0800 (CST)
X-ns-mid: postfix-662707FB-4514967
Received: from [10.42.116.201] (unknown [10.42.116.201])
	by node4.com.cn (NSMail) with ESMTPA id 5C9E316002082;
	Tue, 23 Apr 2024 00:59:38 +0000 (UTC)
Message-ID: <4cf0d1cb-34df-4be3-926a-8fc645ff8f17@kylinos.cn>
Date: Tue, 23 Apr 2024 08:59:37 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "include/linux/suspend.h: Only show pm_pr_dbg
 messages at suspend/resume"
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org
References: <20240422093619.118278-1-xiongxin@kylinos.cn>
 <37847b26-1c1e-48d3-a74e-bd2bcc6e1fda@amd.com>
 <CAJZ5v0gmF0Lcy_nHSvTDnu4C3N0mipaeJqHff=00fgWdtwOzMw@mail.gmail.com>
 <2888cd41-65d9-4832-a913-399a074de7a9@amd.com>
 <CAJZ5v0ggFGSsPKWxowqn89WtLbmXVjUWZvc5KO-ab-UZHagR+Q@mail.gmail.com>
 <7b739eb8-573e-4479-9225-be3d2f4adbff@amd.com>
 <CAJZ5v0itOXsVCvU0kXgZA8v6OX5yy=RZn1d9FTe-fo1tqVy90w@mail.gmail.com>
 <cf3a8d4c-846e-4d7c-ba6e-b774dff420d8@amd.com>
 <CAJZ5v0jp2ici368ebaHyBjhdsEPbgkdNg4FLCfS6kAfNZjd7mA@mail.gmail.com>
Content-Language: en-US
From: xiongxin <xiongxin@kylinos.cn>
In-Reply-To: <CAJZ5v0jp2ici368ebaHyBjhdsEPbgkdNg4FLCfS6kAfNZjd7mA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

=E5=9C=A8 2024/4/23 00:04, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Mon, Apr 22, 2024 at 5:54=E2=80=AFPM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>> On 4/22/2024 10:43, Rafael J. Wysocki wrote:
>>> On Mon, Apr 22, 2024 at 5:25=E2=80=AFPM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>> On 4/22/2024 10:18, Rafael J. Wysocki wrote:
>>>>> On Mon, Apr 22, 2024 at 5:02=E2=80=AFPM Mario Limonciello
>>>>> <mario.limonciello@amd.com> wrote:
>>>>>> On 4/22/2024 09:45, Rafael J. Wysocki wrote:
>>>>>>> On Mon, Apr 22, 2024 at 4:33=E2=80=AFPM Mario Limonciello
>>>>>>> <mario.limonciello@amd.com> wrote:
>>>>>>>> On 4/22/2024 04:36, xiongxin wrote:
>>>>>>>>> This reverts commit cdb8c100d8a4b4e31c829724e40b4fdf32977cce.
>>>>>>>>>
>>>>>>>>> In the suspend process, pm_pr_dbg() is called before setting
>>>>>>>>> pm_suspend_target_state. As a result, this part of the log cann=
ot be
>>>>>>>>> output.
>>>>>>>>>
>>>>>>>>> pm_pr_dbg() also outputs debug logs for hibernate, but
>>>>>>>>> pm_suspend_target_state is not set, resulting in hibernate debu=
g logs
>>>>>>>>> can only be output through dynamic debug, which is very inconve=
nient.
>>>>>>>> As an alternative, how about exporting and renaming the variable
>>>>>>>> in_suspend in kernel/power/hibernate.c and considering that to t=
ell if
>>>>>>>> the hibernate process is going on?
>>>>>>>>
>>>>>>>> Then it should work just the same as it does at suspend.
>>>>>>> Well, this is not the only part that stopped working AFAICS.  I'l=
l
>>>>>>> queue up the revert.
>>>>>> I just tested the revert to see what happens to other drivers but =
it's
>>>>>> going to have more collateral damage.
>>>>>>
>>>>>> ERROR: modpost: "pm_debug_messages_on"
>>>>>> [drivers/platform/x86/amd/pmc/amd-pmc.ko] undefined!

The revert has simply removed the pm_debug_messages_should_print() func,=20
there is no reference to

this function anywhere else in the source code, and=20
drivers/platform/x86/amd/pmc/ path does not

reference pm_debug_messages_on or this function.

>>>>> What about removing the "pm_suspend_target_state !=3D PM_SUSPEND_ON=
"
>>>>> part from pm_debug_messages_should_print()?
>>>>>
>>>>> This should be as good as the revert from the POV of restoring the
>>>>> previous functionality.
>>>> That would probably help this reported issue but it's going to be RE=
ALLY
>>>> noisy for the pinctrl-amd driver for anyone that sets
>>>> /sys/power/pm_debug_messages.
>>>>
>>>> There is a message in that driver that is emitted whenever a GPIO is
>>>> active and pm_debug_messages is set.
>>>>
>>>> It's a really useful message for tracking down which GPIO woke the
>>>> system up as the IRQ that is active is the GPIO controller master IR=
Q
>>>> not an IRQ for the GPIO.
>>>>
>>>> But if that change is made anyone who sets /sys/power/pm_debug_messa=
ges
>>>> is going to see their kernel ring buffer flooded with every since
>>>> interrupt associated with an I2C touchpad attention pin (for example=
).
>>>>
>>>> So if the desire really is to back all this out, I think we need to =
also
>>>> back out other users of pm_pr_dbg() too.
>>> OK, so it needs to check hibernate_atomic in addition to
>>> pm_suspend_target_state.
>> Yeah, that sounds great to me.
> OK
>
>> Tangentially related to the discussion; how would you feel about a
>> /sys/power/pm_wakeup_gpio?  Or /sys/power/pm_wakeup_gpios?
>>
>> If we did the plural and used a comma separated list we could probably
>> axe the message I mentioned above from pinctrl-amd all together.
> That would be too specific IMV.
>
> The whole idea with pm_debug_messages is to switch them all on or off i=
n one go.




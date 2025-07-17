Return-Path: <linux-pm+bounces-30959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A420B0816D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 02:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D7356832B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 00:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F3C1419A9;
	Thu, 17 Jul 2025 00:37:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA41CD2C;
	Thu, 17 Jul 2025 00:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752712660; cv=none; b=HSP8jVDBwyCQfx6YTo06fOUC/szwCvvOM+9JYveihKHdBx5NBqFPBj9oL9P4xBKJHCSm+NX0GAmqLXZvoq9Eh0c/cJDyP4BXxiVG06BpViUCPet2kXL98X/J4hYqtG1632YL1ZCGY0p/Q4q5AADw8iiYkeF4ei0CduEfiCOww3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752712660; c=relaxed/simple;
	bh=J/TqCT0FKVsv8HqvbHkFpVKKpVXXUEP6U0RxNVgqKWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmbkpRo6lsKia0BkIBVHuYw26pK/rQ63zxurbrdgpECeoBGdMfwFGI2VDuSGYubEELPsTv4Jd4dYL/FO1ukcx1cNdqyKOtHYBgiWJBYzo+dCPeRFKn9SGn4/wH1hmK0KiZTHkiRFkGnxsk6eWM6IItmUZ28S199Vvkoahgxs1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 36ad82f862a611f0b29709d653e92f7d-20250717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:2a127a1d-334f-4182-84a8-be12336b1c03,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:dd1951e424efaf6d169bc2402947691a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 36ad82f862a611f0b29709d653e92f7d-20250717
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 646174271; Thu, 17 Jul 2025 08:37:26 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id C5984E008FA3;
	Thu, 17 Jul 2025 08:37:26 +0800 (CST)
X-ns-mid: postfix-687845C6-3333099
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id C3598E008FA2;
	Thu, 17 Jul 2025 08:37:25 +0800 (CST)
Message-ID: <65a378b2-887b-43f3-85d8-b689b4c92817@kylinos.cn>
Date: Thu, 17 Jul 2025 08:37:25 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: suspend: clean up redundant
 filesystems_freeze/thaw handling
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250712030824.81474-1-zhangzihuan@kylinos.cn>
 <9d35035d-c63e-4d11-a403-54c50e8b35c1@kylinos.cn>
 <CAJZ5v0g22fMDc21yV2svePf_4BWZRrcy+b3-efpbfAGLpa2=Lw@mail.gmail.com>
 <76a87abf-8fc9-445b-83d5-0daa33746014@kylinos.cn>
 <CAJZ5v0jKwHZUpsYLzUkcL4=FDnewXoTeJo5e+ccyHw2bZ+ghTg@mail.gmail.com>
 <79468a7f-061f-479a-9357-e48c69cadbb8@kylinos.cn>
 <CAJZ5v0j4biD2Jd5isUGFmwAva1RJsPDCHNpb1VEjM5vTBrk-jQ@mail.gmail.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <CAJZ5v0j4biD2Jd5isUGFmwAva1RJsPDCHNpb1VEjM5vTBrk-jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/7/16 20:23, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Wed, Jul 16, 2025 at 4:04=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylin=
os.cn> wrote:
>>
>> =E5=9C=A8 2025/7/15 20:48, Rafael J. Wysocki =E5=86=99=E9=81=93:
>>> On Tue, Jul 15, 2025 at 8:12=E2=80=AFAM Zihuan Zhang <zhangzihuan@kyl=
inos.cn> wrote:
>>>> Hi Rafael,
>>>>
>>>> =E5=9C=A8 2025/7/15 01:57, Rafael J. Wysocki =E5=86=99=E9=81=93:
>>>>> Hi,
>>>>>
>>>>> On Mon, Jul 14, 2025 at 10:44=E2=80=AFAM Zihuan Zhang <zhangzihuan@=
kylinos.cn> wrote:
>>>>>> Hi Rafael,
>>>>>>
>>>>>> Just a gentle ping on this patch.
>>>>> I've lost track of it for some reason, sorry.
>>>>>
>>>>>> I realized I forgot to mention an important motivation in the chan=
gelog:
>>>>>> calling filesystems_freeze() twice (from both suspend_prepare() an=
d
>>>>>> enter_state()) lead to a black screen and make the system unable t=
o resume..
>>>>>>
>>>>>> This patch avoids the duplicate call and resolves that issue.
>>>>> Now applied as a fix for 6.16-rc7, thank you!
>>>> Thanks for the reply!
>>>>
>>>> Just a quick follow-up question =E2=80=94 we noticed that even when =
the =E2=80=9Cfreeze
>>>> filesystems=E2=80=9D feature is not enabled, the current code still =
calls
>>>> filesystems_thaw().
>>>>
>>>> Do you think it would make sense to guard this with a static key (or
>>>> another mechanism) to avoid unnecessary overhead?
>>> Possibly, if this overhead is significant, but is it?
>> We've done some testing using ftrace to measure the overhead of
>> filesystems_thaw(). When freeze_filesystems is not enabled, the overhe=
ad
>> is typically around 15=E2=80=9340 microseconds.
> So this is the time that can be saved by adding a
> filesystem_freeze_enabled check before calling filesystems_thaw()
> IIUC.
>
> I'd say don't bother.
>

Understood, thanks!


>> However, when freeze is enabled, we observed that filesystems_thaw() c=
an
>> take over 3 seconds to complete (e.g., 3,450,644 us in one test case).
>>
>> freeze_filesystems  not enabled:
>>
>> # tracer: function_graph
>> #
>> # CPU  DURATION                  FUNCTION CALLS
>> # |     |   |                     |   |   |   |
>>     4) + 15.740 us   |  filesystems_thaw();
>>    11) + 16.894 us   |  filesystems_thaw();
>>    10) + 17.805 us   |  filesystems_thaw();
>>     8) + 37.762 us   |  filesystems_thaw();
>>    ------------------------------------------
>>    11) systemd-54512  =3D> systemd-66433
>>    ------------------------------------------
>>
>>    11) + 15.167 us   |  filesystems_thaw();
>>     6) + 16.760 us   |  filesystems_thaw();
>>     7) + 14.870 us   |  filesystems_thaw();
>>     3) + 16.171 us   |  filesystems_thaw();
>>     1) + 16.461 us   |  filesystems_thaw();
>>    ------------------------------------------
>>     3) systemd-71984  =3D> systemd-73036
>>    ------------------------------------------
>>
>>     3) + 28.314 us   |  filesystems_thaw();
>>
>> freeze_filesystems  enabled:
>>
>>    10)               |  filesystems_thaw() {
>>     2) $ 3450644 us  |  } /* filesystems_thaw */
>>    ------------------------------------------
>>     1) systemd-72561  =3D> systemd-99210
>>    ------------------------------------------
>>
>>     1)               |  filesystems_thaw() {
>>    ------------------------------------------
>>     7) systemd-71501  =3D> systemd-99210
>>    ------------------------------------------
>>
>>     7) $ 3429306 us  |  } /* filesystems_thaw */
>>    ------------------------------------------
>>     7) systemd-99210  =3D> systemd-100028
>>    ------------------------------------------
>>
>>     7)               |  filesystems_thaw() {
>>    ------------------------------------------
>>     4) systemd-53278  =3D> systemd-100028
>>    ------------------------------------------
>>
>>     4) $ 3270122 us  |  } /* filesystems_thaw */
>>    ------------------------------------------
>>     7) systemd-100028 =3D> systemd-100720
>>    ------------------------------------------
>>
>>     7) $ 3446496 us  |  filesystems_thaw();
>>    ------------------------------------------
>>     7) systemd-100720 =3D> systemd-112075
>>    ------------------------------------------
>>
>>     7)               |  filesystems_thaw() {
>>    ------------------------------------------
>>    11) systemd-66433  =3D> systemd-112075
>>    ------------------------------------------
>>
>>    11) $ 3454117 us  |  } /* filesystems_thaw */
>>
>>
>>


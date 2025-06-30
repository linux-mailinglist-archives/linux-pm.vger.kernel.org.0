Return-Path: <linux-pm+bounces-29847-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1994EAEE16D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 16:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D8B168D6A
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 14:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415B928B50E;
	Mon, 30 Jun 2025 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="GW3Evcul"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5350B10A3E;
	Mon, 30 Jun 2025 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295002; cv=none; b=rr3CnFzx3MITJS47N9SH1sHaQIadHJZtbw1pkMPtSKUpbxd1naoPqIRDfY+cGXKMbtV//UGVKL4qshuU/4qa/LCup0RWpw9U7yO7Cc3f/lJ0e4IaEHeZH7skYSe+BecCRMvwytI2yv0Zd3GiYF3s/aTXbzkpuwhPgMuGb4KWUGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295002; c=relaxed/simple;
	bh=FxJzuT/Ie0KmGDtCLqi5d8gF5PO4hL85KUuc3GSfOsk=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Tmb7VGTVDBo/Efi5D+ZsmUKrNxiUcWovRIwIEmPETzbhXPm7r1xsF/2mvD+AVgYWOh+MYhOCIzqZnU1kPqIK3iJlaLsF/Hb8BoET1L090r0eRa3DRy8OQ1FkZkhaosJv0n1isNEi02r/Ea8jXzleS1XJQfsgris8R9v4qpb/vmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=GW3Evcul; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751294990; x=1751899790; i=w_armin@gmx.de;
	bh=FxJzuT/Ie0KmGDtCLqi5d8gF5PO4hL85KUuc3GSfOsk=;
	h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:
	 Subject:To:Cc:References:From:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GW3EvculBOz3S3MUspThxVSdFu5B6ExtIf+lMdH09OSjKC8hDPNls1GNUAQ1LQBo
	 h+cE7Kb23AaS6OHl+IpIyQpoRh0c0mf+embXWyAPvGDZEqHRPOUjRs4Dli+FRefWz
	 6DHIAPVN1RM1uzksu+34xi4g6HJcVU/CZpufm6uvRbx0rFig3Ge4Aymel36Q89hKN
	 NUFZmV3L79KgeP5iLuOQu07RIGHjjBVkxj3MEXGrhVh1w7+0FK3BaKmL9j8K52f3n
	 xkaoafGIJNmTtCTrQn/ByOcpHPKZYMU2QZfqJrnLvMFzqg/CnLn7v/RrghFndhBz/
	 oLIXleq954QChAnjhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof9F-1v3Nnb1Epl-00hBlX; Mon, 30
 Jun 2025 16:49:50 +0200
Content-Type: multipart/mixed; boundary="------------H9CjNd1mJj2wCGY6Id3i0aU7"
Message-ID: <77c78beb-84c6-4113-8a32-ba09ab22f098@gmx.de>
Date: Mon, 30 Jun 2025 16:49:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
To: =?UTF-8?Q?Benjamin_Hasselgren-Hall=C3=A9n?= <benjamin@benis.se>
Cc: Kurt Borja <kuurtb@gmail.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Linux PM <linux-pm@vger.kernel.org>
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se>
 <de8321ce-e595-460a-81d7-f7dae8a7b790@gmx.de>
 <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se>
 <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de>
 <DAXK1634VYQI.1PEUCTQIYAF3Y@gmail.com>
 <jCZyBwYNgVSM_Qk2XkfweZRlZNiSh06WVUBqya9leWoWXAmNFL9fdbgBX038OzfQUEaGE5PU8yhtJL2zq_PRW67FmLYTnoK_SPUPmzoTdco=@benis.se>
 <DAXR1M1W2XFZ.3H2AWUO3N1X5E@gmail.com>
 <oZxsMVf4IphclLjVLbrpp1rHYXlgWYV7BXDzgP40QKiHSOUtVDtDwP_s2uKFel3aLTZyIh-KepV7MjdSN_MkRWpn1_v55BEs0MEVyhKK0fU=@benis.se>
 <bf9475d3-9131-4d4f-af05-411fdd4f032f@gmx.de>
 <j_p1hHcOXyva0UEpg4sTPqgLids8s32HxY2oYcpt1rX32spMMOhufyHwscBnt0HqL4ERznsS92ob9KViB1WWEk8wg7VHwNyRV5PO-3ssHOk=@benis.se>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <j_p1hHcOXyva0UEpg4sTPqgLids8s32HxY2oYcpt1rX32spMMOhufyHwscBnt0HqL4ERznsS92ob9KViB1WWEk8wg7VHwNyRV5PO-3ssHOk=@benis.se>
X-Provags-ID: V03:K1:EhmC9P2+GWuuMEQuZPhKWpuOb/uWD0BP9zfunR4jsTGGO6WiA5D
 kzmJbPplhSY9BYTNtCsiIHoMkDFgSyUYBtTub65DuwX8HlTazW5yd+zoq5weiB60M3u+efb
 fpDUgGzFvQd+cMGtgWkY8wGkOwUwflXsfelopy6wLI3d5R1wFIjwRSwau18y1CDcv2/AxRl
 GHoVi4iScGNdIP6t6m/BA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xBgX/mpC0Ug=;cskioTjUYhaCKWgdgyNeQJVP3Ob
 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

This is a multi-part message in MIME format.
--------------H9CjNd1mJj2wCGY6Id3i0aU7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Am 30.06.25 um 14:46 schrieb Benjamin Hasselgren-Hall=C3=A9n:

>
> On Monday, 30 June 2025 at 14:39, Armin Wolf <W_Armin@gmx.de> wrote:
>
>> Am 30.06.25 um 14:32 schrieb Benjamin Hasselgren-Hall=C3=A9n:
>>
>>> Best regards,
>>> Benjamin Hasselgren-Hall=C3=A9n
>>>
>>> On Saturday, 28 June 2025 at 02:45, Kurt Borja kuurtb@gmail.com wrote:
>>>
>>>> On Fri Jun 27, 2025 at 5:49 PM -03, Benjamin Hasselgren-Hall=C3=A9n w=
rote:
>>>>
>>>>> Hi Kurt,
>>>>>
>>>>> I do not experience the same error messages as in the bug report - n=
o error message at all. It respons to changing power profile without any e=
rrors.
>>>>> I also tried 6.12 but same behaviour as 6.15.3 (just getting some gp=
u glitches - problably because of Lunar Lake).
>>>> Can you paste the output of `cat /sys/firmware/acpi/platform_profile`=
 on
>>>> Linux v6.12?
>>>> cat /sys/firmware/acpi/platform_profile_choices
>>>> cool quiet balanced performance
>>> cat /sys/firmware/acpi/platform_profile
>>> cat: /sys/firmware/acpi/platform_profile: Invalid argument
>>
>> Good, it seems that the firmware returns additional data when querying =
the current platform profile.
>> As the driver does not mask-out this data, he cannot determine what kin=
d of platform profile is currently
>> selected and thus returns -EINVAL.+
>>
>> I can provide you with an experimental patch, could you test that?
> Yes! I am trying to compile 6.16-rc3 atm and the first time I am doing t=
his, but I will happily test a patch.

Alright, i attach the experimental patch. Please note that this might not =
fully solve the problem, because the
driver also needs support for the additional platform profiles available o=
n your machine.

However after setting the platform profile the driver should be able to re=
ad the current platform profile setting
without any errors.

Thanks,
Armin Wolf

>> Thanks,
>> Armin Wolf
>>
>>>>> I am trying to understand how power profiles work - I guess on a hig=
h level it's controlled by uefi and the profile is set by the OS? Or is it=
 more complicated than that?
>>>> Yes, as quick overview. Power profiles are usually a capability of
>>>> individual devices. Drivers of these devices expose this profiles to
>>>> userspace through some predefined interfaces. Then your DE enviroment
>>>> exposes this to you.
>>>>
>>>> KDE and Gnome use power-profiles-daemon. This program controlls mainl=
y
>>>> two kernel interfaces: CPUFreq and platform-profile (there may be mor=
e).
>>>>
>>>> You can read about CPUFreq here [1], although I don't know much about
>>>> it. The platform-profile interface may be used by any platform driver=
 -
>>>> in your case this is the hp-wmi driver.
>>>>
>>>> This driver exposes some firmware defined profiles to sysfs trough th=
e
>>>> following paths.
>>>>
>>>> /sys/firmware/acpi/
>>>> /sys/class/platform-profile/
>>>>
>>>> You won't find the latter in the Linux LTS version though. You will f=
ind
>>>> documentation on these paths here [2] and [3] respectively.
>>>>
>>>> PD: Please, avoid top-posting in kernel mailing lists, interleaved st=
yle
>>>> is very much preferred [4].
>>>>
>>>> [1] https://docs.kernel.org/admin-guide/pm/cpufreq.html
>>>> [2] https://docs.kernel.org/admin-guide/abi-testing-files.html#abi-fi=
le-testing-sysfs-platform-profile
>>>> [3] https://docs.kernel.org/admin-guide/abi-testing-files.html#abi-fi=
le-testing-sysfs-class-platform-profile
>>>> [4] https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
>>>>
>>>> --
>>>> ~ Kurt

--------------H9CjNd1mJj2wCGY6Id3i0aU7
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-platform-x86-hp-wmi-Use-bitmask-when-accessing-the-t.patch"
Content-Disposition: attachment;
 filename*0="0001-platform-x86-hp-wmi-Use-bitmask-when-accessing-the-t.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBhZWQ1MDNlNGRlYjRiMTJlMDVhN2Y5NDNkZWVhNjgxNjk1YzkzY2EzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBcm1pbiBXb2xmIDxXX0FybWluQGdteC5kZT4KRGF0
ZTogTW9uLCAzMCBKdW4gMjAyNSAxNjozNToxNiArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIHBs
YXRmb3JtL3g4NjogaHAtd21pOiBVc2UgYml0bWFzayB3aGVuIGFjY2Vzc2luZyB0aGUgdGhl
cm1hbAogcHJvZmlsZQpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxh
aW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKT24g
dGhlIEhQIE9tbmlib29rIFVsdHJhIEZsaXAgMTQgdGhlIHNlY29uZCBhbmQgdGhpcmQgYnl0
ZSBpbnNpZGUKdGhlIHJlc3VsdCBvZiBIUFdNSV9USEVSTUFMX1BST0ZJTEVfUVVFUlkgY29u
dGFpbnMgYWRkaXRpb25hbCBkYXRhLgpDdXJyZW50bHkgdGhpcyBhZGRpdGlvbmFsIGRhdGEg
aXMgbm90IHByb3Blcmx5IG1hc2tlZCBvdXQsIG1ha2luZyBpdAppbXBvc3NpYmxlIHRvIHJl
YWQgdGhlIHRoZXJtYWwgcHJvZmlsZSBvbiBzdWNoIG1hY2hpbmVzLgoKRml4IHRoaXMgYnkg
dXNpbmcgYSBiaXRtYXNrIHRvIG1hc2stb3V0IGV2ZXJ5dGhpbmcgYnV0IHRoZSBmaXJzdCBi
eXRlCndoZW4gcmVhZGluZyB0aGUgdGhlcm1hbCBwcm9maWxlLiBUaGUgc2FtZSBpcyBkb25l
IHdoZW4gd3JpdGluZyB0aGUKdGhlcm1hbCBwcm9maWxlIGZvciB0aGUgc2FrZSBvZiBzeW1t
ZXRyeS4KClJlcG9ydGVkLWJ5OiBCZW5qYW1pbiBIYXNzZWxncmVuLUhhbGzDqW4gPGJlbmph
bWluQGJlbmlzLnNlPgpDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BsYXRmb3Jt
LWRyaXZlci14ODYvWC00MEFxWGZkbVF3NXNoVU9rM1ZTYUhTWG13SllXSFBtRERNTHlHVUg2
R3BNdDU2dHk1U2JOZzhFVmZ5SV91QzlKMDd1cVoyVHRHSm1tcEJfeDgteHBjVk93Mjlmbkt6
Slo0bjlMMHg3OEE9QGJlbmlzLnNlLwpTaWduZWQtb2ZmLWJ5OiBBcm1pbiBXb2xmIDxXX0Fy
bWluQGdteC5kZT4KLS0tCiBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9ocC9ocC13bWkuYyB8IDE5
ICsrKysrKysrKysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2hw
L2hwLXdtaS5jIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvaHAvaHAtd21pLmMKaW5kZXggZGI1
ZmRlZTIxMDljLi4yOTBkOGQ0YzZmMWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGxhdGZvcm0v
eDg2L2hwL2hwLXdtaS5jCisrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2hwL2hwLXdtaS5j
CkBAIC0xMyw2ICsxMyw4IEBACiAKICNkZWZpbmUgcHJfZm10KGZtdCkgS0JVSUxEX01PRE5B
TUUgIjogIiBmbXQKIAorI2luY2x1ZGUgPGxpbnV4L2JpdHMuaD4KKyNpbmNsdWRlIDxsaW51
eC9iaXRmaWVsZC5oPgogI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgogI2luY2x1ZGUgPGxp
bnV4L21vZHVsZS5oPgogI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KQEAgLTI1Miw2ICsyNTQs
OSBAQCBlbnVtIGhwX3RoZXJtYWxfcHJvZmlsZSB7CiAJSFBfVEhFUk1BTF9QUk9GSUxFX1FV
SUVUCQk9IDB4MDMsCiB9OwogCisvKiBUaGUgc2Vjb25kIGFuZCB0aGlyZCBieXRlIGNvbnRh
aW5zIHVua25vd24gZGF0YSwgc28gYm90aCBuZWVkIHRvIGJlIG1hc2tlZCBvdXQuICovCisj
ZGVmaW5lIEhQX1RIRVJNQUxfUFJPRklMRV9NQVNLIEdFTk1BU0soNywgMCkKKwogI2RlZmlu
ZSBJU19IV0JMT0NLRUQoeCkgKCh4ICYgSFBXTUlfUE9XRVJfRldfT1JfSFcpICE9IEhQV01J
X1BPV0VSX0ZXX09SX0hXKQogI2RlZmluZSBJU19TV0JMT0NLRUQoeCkgISh4ICYgSFBXTUlf
UE9XRVJfU09GVCkKIApAQCAtMTQzMSwxMyArMTQzNiwyMSBAQCBzdGF0aWMgaW50IHBsYXRm
b3JtX3Byb2ZpbGVfb21lbl9zZXQoc3RydWN0IGRldmljZSAqZGV2LAogCiBzdGF0aWMgaW50
IHRoZXJtYWxfcHJvZmlsZV9nZXQodm9pZCkKIHsKLQlyZXR1cm4gaHBfd21pX3JlYWRfaW50
KEhQV01JX1RIRVJNQUxfUFJPRklMRV9RVUVSWSk7CisJaW50IHJldDsKKworCXJldCA9IGhw
X3dtaV9yZWFkX2ludChIUFdNSV9USEVSTUFMX1BST0ZJTEVfUVVFUlkpOworCWlmIChyZXQg
PCAwKQorCQlyZXR1cm4gcmV0OworCisJcmV0dXJuIEZJRUxEX0dFVChIUF9USEVSTUFMX1BS
T0ZJTEVfTUFTSywgcmV0KTsKIH0KIAogc3RhdGljIGludCB0aGVybWFsX3Byb2ZpbGVfc2V0
KGludCB0aGVybWFsX3Byb2ZpbGUpCiB7Ci0JcmV0dXJuIGhwX3dtaV9wZXJmb3JtX3F1ZXJ5
KEhQV01JX1RIRVJNQUxfUFJPRklMRV9RVUVSWSwgSFBXTUlfV1JJVEUsICZ0aGVybWFsX3By
b2ZpbGUsCi0JCQkJCQkJICAgc2l6ZW9mKHRoZXJtYWxfcHJvZmlsZSksIDApOworCWludCB2
YWx1ZSA9IEZJRUxEX1BSRVAoSFBfVEhFUk1BTF9QUk9GSUxFX01BU0ssIHRoZXJtYWxfcHJv
ZmlsZSk7CisKKwlyZXR1cm4gaHBfd21pX3BlcmZvcm1fcXVlcnkoSFBXTUlfVEhFUk1BTF9Q
Uk9GSUxFX1FVRVJZLCBIUFdNSV9XUklURSwgJnZhbHVlLAorCQkJCSAgICBzaXplb2YodGhl
cm1hbF9wcm9maWxlKSwgMCk7CiB9CiAKIHN0YXRpYyBpbnQgaHBfd21pX3BsYXRmb3JtX3By
b2ZpbGVfZ2V0KHN0cnVjdCBkZXZpY2UgKmRldiwKLS0gCjIuMzkuNQoK

--------------H9CjNd1mJj2wCGY6Id3i0aU7--


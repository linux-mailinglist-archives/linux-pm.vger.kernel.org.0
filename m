Return-Path: <linux-pm+bounces-22796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCED4A41DB7
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 12:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCE419C0E4A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 11:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B66264F9F;
	Mon, 24 Feb 2025 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="hSbtqKpZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D318625D534
	for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2025 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396456; cv=none; b=Ar/2heJoO1U9GAxgo9FuY3wM8KlecnF7Vm+M81XF+FetyZOVgoUnyVIfiVqk3ZRpZAk84NNVR7TD+nTNgWnXflR8p67NevZFiOkR73+wZLgSOFQmkhV3ZXwURfrZoxwtlKA+X8D65AEEiMSYcsW4WmN1SZOmFMdkgHEFsYROSiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396456; c=relaxed/simple;
	bh=92UtT6fHiTt6I/peYlCjRe3NBTfzK6bGmA4JrPDrr8k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UVAgBr5D8KHc4z6T6hblcdG2uIjK81jGfmPGcnrtjHTDxMNsY7kQ9NjENqKhBy9EqHQSZSni1+5swAw48SCBaqt0SqyhxmqCRcCLxEgNzhJfvu9eFraVG1mxTPQcmhs5JcwQrynLLx8Y1nz0eGs41HiTvltXOHpNHewZPxLrZNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=hSbtqKpZ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id DE55B206BC;
	Mon, 24 Feb 2025 12:27:24 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XPRWfl1L0BkV; Mon, 24 Feb 2025 12:27:24 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id F031E205ED;
	Mon, 24 Feb 2025 12:27:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com F031E205ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1740396444;
	bh=92UtT6fHiTt6I/peYlCjRe3NBTfzK6bGmA4JrPDrr8k=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=hSbtqKpZ8cvDzNLBq9PSq6RXbrddKRfQ7uxDdIFO1YrEoAlAWx4TC48uOiXc8fcMG
	 aaZlU44JmUl93lenmiqGUAUEB+qg7KCpSgDadOpccGiGUXo8DvxsdiIFlOXqt6V0bJ
	 VhKUvH7mYsg4Krm9oFyPTHHEzHPP3ClkxycBXev+IMquWu0BfUt9IdPR9PZUChASMA
	 PPDkT9xHvf0hOtKM/UuWCU4LCd0lT8O3jQA5b7tk5p9xSbCE7rkGYg3aIohTMkgUg7
	 yWI2FQZZpG5TNUh67iSPzegBmeGDciy7i4R/IcIKOkvA1Xd3wdEPWzwhxAnI4kj3vS
	 A7BwvDQtVMWGg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Feb 2025 12:27:23 +0100
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Feb 2025 12:27:23 +0100
Received: from mbx-essen-02.secunet.de ([fe80::fcaf:ee74:71ad:4eff]) by
 mbx-essen-02.secunet.de ([fe80::fcaf:ee74:71ad:4eff%8]) with mapi id
 15.01.2507.039; Mon, 24 Feb 2025 12:27:23 +0100
From: "Gwara, Mateusz" <mateusz.gwara@secunet.com>
To: "rafael@kernel.org" <rafael@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Wassenberg,
 Dennis" <Dennis.Wassenberg@secunet.com>
Subject: TCC cooling on Meteorlake
Thread-Topic: TCC cooling on Meteorlake
Thread-Index: AduDlx+iplinHwBpQQWp3a/rqpECPwDF4Jbw
Date: Mon, 24 Feb 2025 11:27:22 +0000
Message-ID: <163ff391dc6d4f828ecff95e87f5003d@secunet.com>
References: <f733005155e64d489ae18d7d357bada9@secunet.com>
In-Reply-To: <f733005155e64d489ae18d7d357bada9@secunet.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hi,

Sorry, my first mail was sent as HTML due to a corporate policy preset.
So here's my initial mail:


Hello dear maintainers!

I was comparing the behavior of the Intel TCC cooling driver on a kernel we=
 develop and also on regular Ubuntu kernel releases(based on Linux kernel u=
p to 6.13).
On a Raptorlake CPU you=92ll see the TCC node with e.g.:

/sys/class/thermal/cooling_device8/type
/sys/class/thermal/cooling_device8/cur_state

Endpoints

This allows reading/setting the offsets as expected.

This was made possible in
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
drivers?h=3Dnext-20250212&id=3Dbe6bfb29c55e48567983e24aba7b6bf9a66a45ab/htt=
ps://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/dri=
vers/thermal?h=3Dnext-20250212&id=3Dbe6bfb29c55e48567983e24aba7b6bf9a66a45a=
b/https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/drivers/thermal/intel?h=3Dnext-20250212&id=3Dbe6bfb29c55e48567983e24aba7b=
6bf9a66a45ab/https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-nex=
t.git/commit/drivers/thermal/intel/intel_tcc_cooling.c?h=3Dnext-20250212&id=
=3Dbe6bfb29c55e48567983e24aba7b6bf9a66a45ab

with a patch that added=20
> +=A0=A0=A0=A0=A0=A0 X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 &temp_tigerlake),
> +=A0=A0=A0=A0=A0=A0 X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,=A0=A0=A0=A0=
=A0=A0=A0=A0 &temp_tigerlake),
> +=A0=A0=A0=A0=A0=A0 X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 &temp_tigerlake),
> +=A0=A0=A0=A0=A0=A0 X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,=A0=A0=A0=A0=
=A0=A0=A0 &temp_tigerlake),
> +=A0=A0=A0=A0=A0=A0 X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,=A0=A0=A0=A0=
=A0=A0=A0 &temp_tigerlake),

Among other changes, where intel_tcc_get_offset_mask would get the correct =
Tjunction offset for each CPU.

I was trying to add a similar entry corresponding to the Meteorlake Model n=
ames but this did not have the same effect and there was no TCC node presen=
t like on a Raptorlake device.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
As I see in
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/dr=
ivers/thermal/intel/intel_tcc_cooling.c?h=3Dnext-20250219
the last CPU added here still is the Raptorlake model.

I checked the repositories where Intel maintains their CPU patches but ther=
e was also no mention of Meteorlake (and later models)regarding TCC support=
.
As there have been several ARROW&LUNAR-lake patches handling different issu=
es regarding clocking the different core variants.

I=92d like to know if there is something I=92m missing(maybe NO TCC support=
 since Meteorlake?) or if there is TCC support planned?
I=92d be willing to help test anything regarding this issue.


Sorry for the lengthy mail and thank you for you work on the Linux Kernel s=
o far :)



Mateusz=20


--=20
Mateusz Gwara
Senior Software Developer
Department Network & Client Security
Division Public Authorities
secunet Security Networks AG

Tel.: +49 201 54 54-2934
E-Mail: mailto:mateusz.gwara@secunet.com
Alt-Moabit 96, 10559 Berlin
http://www.secunet.com
______________________________________________________________________

secunet Security Networks AG
Sitz: Kurf=FCrstenstra=DFe 58, 45138 Essen, Deutschland
Amtsgericht Essen HRB 13615
Vorstand: Axel Deininger (Vors.), Torsten Henn, Dr. Kai Martius, Jessica No=
spers
Aufsichtsratsvorsitzender: Dr. Ralf Wintergerst
______________________________________________________________________



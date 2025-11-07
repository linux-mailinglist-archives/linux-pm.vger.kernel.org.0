Return-Path: <linux-pm+bounces-37578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CEFC3E0FD
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 01:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 310C94E4EA6
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 00:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585D12EC553;
	Fri,  7 Nov 2025 00:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AnGgNMws"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353D22DF6F7
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762477097; cv=none; b=fnMtnmEUt6dyEW7BtJAUlcA8WfBshwXSMxgyBYADou/xOhhX0SPuLoa0l+fEQG9jQVtSEBVfr3kmGIGsI7luBtCK5Ovnhl2693S04iY3MwNaYkh75dPuTRnb9vSLotfaUlWj7X+AjR6Ih1c+VukIWQSr1/CRDbfop57LWqW4668=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762477097; c=relaxed/simple;
	bh=0QDWG7L4IHnws8vr5T7KCPG6YnvPkOmtAbSSWotGpM4=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=RP8WlP6Sqi9cpYgQ0rPTm+DxuUiHBeC/R2WqnIWvvA6OJH0pKsN+vPzoTS+b6WuBvTMpGMHDRt801pLVo97dkO21SeiCwWrjpkdtASHdxbOijE5KHI7kBp+Xly5kRS3fIMr2y/u4moDyxLEeqR8lm3Fzonq7zC8XJiGcW5p1h3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AnGgNMws; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251107005810epoutp041a98f14873e85b14e6a9c214d0eda357~1k5OE9UFR3122931229epoutp04G
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 00:58:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251107005810epoutp041a98f14873e85b14e6a9c214d0eda357~1k5OE9UFR3122931229epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1762477091;
	bh=0QDWG7L4IHnws8vr5T7KCPG6YnvPkOmtAbSSWotGpM4=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=AnGgNMwsCRROBqQ+pa12Aylpy66jyVvBR81xlnysslq39rGqzhPh4ZQDxnSxo/zS8
	 XG5nypBcHlrYVqRlLHG2T4PeOSMccE4DTOCkrP3YhfcHqwbTiVqMwyAU9BE6ZmKuiM
	 fuQgVncYnNc+5E179LJ+t2AVNAn11LSxyCKUtfOs=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPS id
	20251107005810epcas1p425fd0fb429a10655df7cfc40010696a9~1k5Nmg-i31202112021epcas1p4T;
	Fri,  7 Nov 2025 00:58:10 +0000 (GMT)
Received: from epcas1p3.samsung.com (unknown [182.195.38.98]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4d2gf96HZXz2SSKk; Fri,  7 Nov
	2025 00:58:09 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH RESEND v2] devfreq: move governor.h to a public header
 location
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Kyungmin Park
	<kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Dmitry
	Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Robie Basak
	<robibasa@qti.qualcomm.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20251030-governor-public-v2-1-432a11a9975a@oss.qualcomm.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20251107005809epcms1p5f33e9560755367f0ba4b7df82c87fc85@epcms1p5>
Date: Fri, 07 Nov 2025 09:58:09 +0900
X-CMS-MailID: 20251107005809epcms1p5f33e9560755367f0ba4b7df82c87fc85
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-361,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251030182636epcas1p2b332b417c1c42fb559a6f34e9e9f408c
References: <20251030-governor-public-v2-1-432a11a9975a@oss.qualcomm.com>
	<CGME20251030182636epcas1p2b332b417c1c42fb559a6f34e9e9f408c@epcms1p5>

>Sender: Dmitry Baryshkov <dmitry.baryshkov=40oss.qualcomm.com>=C2=A0=0D=0A=
>Date:=202025-10-31=2003:26=20(GMT+9)=0D=0A>Title:=20=5BPATCH=20RESEND=20v2=
=5D=20devfreq:=20move=20governor.h=20to=20a=20public=20header=20location=0D=
=0A>=0D=0A>Some=20device=20drivers=20(and=20out-of-tree=20modules)=20might=
=20want=20to=20define=0D=0A>device-specific=20device=20governors.=20Rather=
=20than=20restricting=20all=20of=20them=20to=0D=0A>be=20a=20part=20of=20dri=
vers/devfreq/=20(which=20is=20not=20possible=20for=20out-of-tree=0D=0A>driv=
ers=20anyway)=20move=20governor.h=20to=20include/linux/devfreq-governor.h=
=20and=0D=0A>update=20all=20drivers=20to=20use=20it.=0D=0A>=0D=0A>The=20dev=
freq_cpu_data=20is=20only=20used=20internally,=20by=20the=20passive=20gover=
nor,=0D=0A>so=20it=20is=20moved=20to=20the=20driver=20source=20rather=20tha=
n=20being=20a=20part=20of=20the=0D=0A>public=20interface.=0D=0A=0D=0AHi=21=
=0D=0A=0D=0ACould=20you=20please=20direct=20me=20to=20the=20governors=20or=
=20drivers=20needing=20this?=0D=0A(Qualcomm=20drivers?)=0D=0A=0D=0ACheers,=
=0D=0AMyungJoo=0D=0A=0D=0A>=0D=0A>Reported-by:=20Robie=20Basak=20<robibasa=
=40qti.qualcomm.com>=0D=0A>Acked-by:=20Jon=20Hunter=20<jonathanh=40nvidia.c=
om>=0D=0A>Signed-off-by:=20Dmitry=20Baryshkov=20<dmitry.baryshkov=40oss.qua=
lcomm.com>=0D=0A>---=0D=0A>Changes=20in=20v2:=0D=0A>-=20Fixed=20typo=20in=
=20commit=20subject=20(Mikko=20Perttunen)=0D=0A>-=20Link=20to=20v1:=20https=
://lore.kernel.org/r/20250903-governor-public-v1-1-111abd89a89a=40oss.qualc=
omm.com=0D=0A>---=0D=0A>drivers/devfreq/devfreq.c=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=202=20+-=0D=0A>drivers/devfreq/governor_passive.c=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=2027=
=20+++++++++++++++++-=0D=0A>drivers/devfreq/governor_performance.c=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=202=20+-=0D=0A>drivers/=
devfreq/governor_powersave.c=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=202=20+-=0D=0A>drivers/devfreq/governor_simpleonde=
mand.c=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=202=20+-=0D=0A>dr=
ivers/devfreq/governor_userspace.c=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=202=20+-=0D=0A>drivers/devfreq/hisi_uncore_f=
req.c=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=203=20+-=0D=0A>drivers/devfreq/tegra30-devfreq.c=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
3=20+-=0D=0A>.../governor.h=20=3D>=20include/linux/devfreq-governor.h=2033=
=20+++-------------------=0D=0A>9=20files=20changed,=2037=20insertions(+),=
=2039=20deletions(-)=0D=0A>=0D=0A>=0D=0A


Return-Path: <linux-pm+bounces-20402-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D89A10316
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 10:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C343A7944
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 09:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B70D24022B;
	Tue, 14 Jan 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MzHTDSZS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E75922DC5D;
	Tue, 14 Jan 2025 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736847422; cv=none; b=oB/aktqZug03DAAoNWSUuluhgL3IcTYgk2pZZlG35YNWxoXf4LBc+kkPHs+ptfyvXwtuVKynk2sPGUP+P+YhyrHK5vgj1dFWgxQLqb+fCzXQe4ZKufWfRc3Jy1o3oo1pDqjzDLg38DMUgSU6qnCmyyAFZzyPbPZ0iGHpuwwvXao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736847422; c=relaxed/simple;
	bh=aEHfS9NOn4dw70JfggUmYvKT8u4xG2BPT3tE/Wc//go=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EElfggPRxG2evV1KGKS5dqHxzW1xBBCG/vh44GJYECfYivXAkHg9/cIfv9Xoey5nlIkVEIbrIwDgyjYlTisyn3++oGizJHtQre5bPCGrPn+vGka755HedHgyo076aSswIoeWyPmIXo/5CHH+sLE3xsrzkzh8rcHduCR1QViBOpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MzHTDSZS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50E25i7r019939;
	Tue, 14 Jan 2025 09:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=njf12d
	QUQxsxqC/FQJPwNc+LJpENatjRic/jsHe/6KQ=; b=MzHTDSZSQ9rAyAOCr3i93C
	WX0+d9QrAVsoym/eYpt2BZZAVGmEazsiawKG1PyvEaFPpQBYVtddlB+bkagQGycl
	fIx4q5pO9/53uAYbhEFEqsoaxhoUzF3dw2v0ok7lZheZFEpk2js8fx8Ck7o0pEIk
	XCMWfnRWN/Nuhiaq1NAmPsThb1h2/2WmaNtSgO0uUEBoTdfTLZhpp6rMeEusco5G
	7r+LmY+vCpZusCgW25Y+O+YooRFUajlpXNiIfxM21CbnNd7NiklV1OCwTqp2IfoO
	8JSIPpzGhYZZ28WCyvj37gnGBx+Kp+uAlesn4L3eFYwHspcNgzh2oa349IUonexA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4454a5c72p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 09:36:25 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50E9YI93005487;
	Tue, 14 Jan 2025 09:36:24 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4454a5c72k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 09:36:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50E92uFc002734;
	Tue, 14 Jan 2025 09:36:23 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443by2p6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 09:36:23 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50E9aNOX17629712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 09:36:23 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30E3958043;
	Tue, 14 Jan 2025 09:36:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77C4A58055;
	Tue, 14 Jan 2025 09:36:19 +0000 (GMT)
Received: from [9.171.92.251] (unknown [9.171.92.251])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jan 2025 09:36:19 +0000 (GMT)
Message-ID: <0a053cef86001953b34fd199b551b96100fcca70.camel@linux.ibm.com>
Subject: Re: [PATCH v2] PCI/portdrv: Disable bwctrl service if port is fixed
 at 2.5 GT/s
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Schnelle
 <niks@kernel.org>
Cc: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn
 Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
        linux-pci@vger.kernel.org, Rob Herring	 <robh@kernel.org>,
        Krzysztof
 Wilczy??ski <kw@linux.com>,
        "Maciej W . Rozycki"	 <macro@orcam.me.uk>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Gagniuc
 <mr.nuke.me@gmail.com>,
        Krishna chaitanya chundru
 <quic_krichai@quicinc.com>,
        Srinivas Pandruvada	
 <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Smita Koralahalli	
 <Smita.KoralahalliChannabasappa@amd.com>,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria
 <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>,
        Mika Westerberg
 <mika.westerberg@linux.intel.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 14 Jan 2025 10:36:18 +0100
In-Reply-To: <CAMuHMdVtpVTtUEX=hF+r+rt_awk=w8iYWHd5yzZYGUpKoyYcgA@mail.gmail.com>
References: <20241213-fix_bwctrl_thunderbolt-v2-1-b52fef641dfc@kernel.org>
	 <CAMuHMdVtpVTtUEX=hF+r+rt_awk=w8iYWHd5yzZYGUpKoyYcgA@mail.gmail.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b9Ti87pIYGEnZ9YqfjVBaz9dVA8pjzQ6
X-Proofpoint-ORIG-GUID: -Fowpbzi03tjFWChVdDAx2dbZAx9FdmR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501140078

On Tue, 2025-01-14 at 09:50 +0100, Geert Uytterhoeven wrote:
> On Fri, Dec 13, 2024 at 9:56=E2=80=AFPM Niklas Schnelle <niks@kernel.org>=
 wrote:
> > Trying to enable bwctrl on an Intel JHL7540 (Titan Ridge) based
> > Thunderbolt port causes a boot hang on at least some systems though the
> > exact reason is not yet understood. As per the spec Thunderbolt PCIe
> > Downstream Ports have a fake Max Link Speed of 2.5 GT/s (USB4 v2 sec
> > 11.2.1):
> >=20
> >    "Max Link Speed field in the Link Capabilities Register set to 0001b
> >     (data rate of 2.5 GT/s only).
> >     Note: These settings do not represent actual throughput.
> >     Throughput is implementation specific and based on the USB4 Fabric
> >     performance."
> >=20
> > More generally if 2.5 GT/s is the only supported link speed there is no
> > point in throtteling as this is already the lowest possible PCIe speed
> > so don't advertise the capability stopping bwctrl from being probed on
> > these ports.
> >=20
> > The PCIe r6.2 specification section 7.5.3.18 recommends to primarily
> > utilize the Supported Link Speeds Vector instead of the Max Link Speeds
> > field to prevent confusion if future specifications allow devices not
> > to support lower speeds. This concern does not apply however when
> > specifically targeting devices claiming support only for 2.5 GT/s.
> >=20
> > Link: https://lore.kernel.org/linux-pci/Z1R4VNwCOlh9Sg9n@wunner.de/
> > Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCI=
e BW controller")
> > Tested-by: Niklas Schnelle <niks@kernel.org>
> > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Niklas Schnelle <niks@kernel.org>
> > ---
> > Note: This issue causes a boot hang on my personal workstation.
> >=20
> > While there is an ongoing discussion about generalizing this to all
> > devices with a single supported speed. It turns out however that in my
> > case dev->supported_speeds incorrectly claims 2.5-8 GT/s requiring
> > a seperate second fix. So in the interest of simplicity and because I'l=
l
> > be out from the 19th until January, I'd like to propose to do this simp=
le
> > fix to the boot hang now and take the time to figure out a more general
> > approach afterwards.
> > ---
> > Changes in v2:
> > - Improve commit message to mention the specific controller and
> >   why using the Max Link Speeds field should be fine here.
> > - Add a comment (Lukas)
> > - Add R-b's (no change to logic).
> > - Link to v1: https://lore.kernel.org/r/20241207-fix_bwctrl_thunderbolt=
-v1-1-b711f572a705@kernel.org
>=20
> This is now commit e50e27a613db6f18 ("PCI/portdrv: Disable bwctrl
> service if port is fixed at 2.5 GT/s") in pci/next, which conflicts
> with  commit 774c71c52aa48700 ("PCI/bwctrl: Enable only if more than
> one speed is supported") in v6.13-rc4.
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert

Oh, that's not right, good catch. This patch is superseded by
"PCI/bwctrl: Enable only if more than one speed is supported" and
should be dropped. Sorry if that wasn't clear from the the limited
context of this patch discussion. @Bjorn I think this needs to be taken
care of by you?

Thanks,
Niklas



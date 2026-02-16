Return-Path: <linux-pm+bounces-42718-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDBnIvVok2m64QEAu9opvQ
	(envelope-from <linux-pm+bounces-42718-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 19:59:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B46E114724F
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 19:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CF4E3002D1A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 18:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3419F2E7BD2;
	Mon, 16 Feb 2026 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SHzQK7CE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4C51E3DE5;
	Mon, 16 Feb 2026 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771268337; cv=none; b=HjoGgrMcXz6rOB+g4mCdXaha0b5kMZ+jNz60GpGEdUF02v0JQ6SSpk4GjOIf26Tu1blAGr6YBuZsPeuxrlVVyDtF/hrnc3e82OOUvQePRpQEEr0QJniGJViIl+KdLrRzcLO6SVPJ8N4CfMb3ir/jY/5egHpX8oM6gsDEmffcXII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771268337; c=relaxed/simple;
	bh=Z5BBdke29xYldl/rIpaHBrv7p/C9SN1OKMaEUHWf/nk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Geo1qQUL1oBilJU2jKn+4fpwClGN/jy+i+wy7rDR4qDRY5zqvANNN2NVP3/3bTP1+KWWX/iMMkI3tB2BjSYPcVLNaFWQ9K+qyrRZdp0PCPOyNRGljXcwbNExP+yeh5g4/8dnFQhbOS3on3BbvWcjpyb6gskXCXWxyZBZhwHgOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SHzQK7CE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GFK9c83669128;
	Mon, 16 Feb 2026 18:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Z5BBdk
	e29xYldl/rIpaHBrv7p/C9SN1OKMaEUHWf/nk=; b=SHzQK7CEytzV59Q0l3yA1m
	vVmEp5KnhyYFV2wUQzhW0JSrmDwrjGIS/GFMdI1tsaBi8lfWDIOpJRJkCarEnp+V
	edMPeNsIdKsSVgacMAvuJgTDL/7x6a4/3vX9TPKGFs83RS2h9ljcsEH5XD/bkXD7
	NN6ObrW7NFnxDuMKDLg+/6XORsli28JOiG3DECxDjHvSIw0Gmn+/EmsvRw4uTRp+
	vOFxzALDKwUnhJL0Qnpy3FJv3eDVlAvHScqUPdQwPjekcymugAwTqQRzNrJdH4gi
	wRy3xkMM2WdHjbeO1Soz5c55Otf6QEdX61yC87J8uEMZMoFcBG63QOI7heGUJ8DQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcj8dj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 18:58:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61GH997W003762;
	Mon, 16 Feb 2026 18:58:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cb4cmxgag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 18:58:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GIwl6U53019096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 18:58:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 860292004B;
	Mon, 16 Feb 2026 18:58:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03A4A20040;
	Mon, 16 Feb 2026 18:58:46 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.36.7.180])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 18:58:45 +0000 (GMT)
Message-ID: <ef7f49b999b20bc3629b99f7ba260eee813d7fcc.camel@linux.ibm.com>
Subject: Re: [PATCH] cpuidle: ladder: Fix state index when only one idle
 state is registered
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 17 Feb 2026 00:28:44 +0530
In-Reply-To: <398c6f07-d964-4dc0-9fa6-bf7d89442da1@arm.com>
References: <20260211053552.739337-1-aboorvad@linux.ibm.com>
	 <c3d670cd-fc54-49a8-b640-fb16f9bd0487@arm.com>
	 <7297173684f500e006a2997b92c927262221336f.camel@linux.ibm.com>
	 <aa4e56dc-d74b-44dc-b628-c7573159de99@arm.com>
	 <398c6f07-d964-4dc0-9fa6-bf7d89442da1@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pKmnIVXPhWpcM5thfTAqTcZEFsSdFhD7
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=699368ea cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=e9NWw3J2MQ3JWS89RHgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDE1OSBTYWx0ZWRfX6Qorp43hDXmf
 3Sg+gfaEAXeRxeuyfd4iah0e6lihFC8ej1mav0V97pHfNTQpFFUUgYjeiX/LJJyAW3MvJeEXyp5
 1iOB+FM1BrsBzfKET14kniJRAQEHBWJH+ZWCXduo7EN5RYBmKhF17U10LX/8BtNMnoit4fG0feU
 rIiXlAXvqmDTswD7bzztvltidVNJznj2OOPLiYsbhZ6Vl6FkKzy1jQFYIXZu1a1ZcMD6B1VCShi
 uPuKbobmyXpaCvOJLXZl8gtUSXOgmUb00pZfeNI4tyrVzwBMEVLmK6jyuPOkkhtou0unibm9DMr
 Om1uFJIYTTz0/IHTKzkXxD0/GZxWM+acMACNr+BUs9XaGfIOPthriol0xxn2lDSvNqC9sFPRioo
 HQRlJpJ+UNbtChGjN1luEIO4Gb1gBsTaAjR93aPhhkztnQ+saOfQ2VBZct4l1iOMbHWHNVPAB2y
 b0Ek/CRWVpVdN2il//A==
X-Proofpoint-GUID: pKmnIVXPhWpcM5thfTAqTcZEFsSdFhD7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_06,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160159
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aboorvad@linux.ibm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42718-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+]
X-Rspamd-Queue-Id: B46E114724F
X-Rspamd-Action: no action

On Mon, 2026-02-16 at 11:05 +0000, Christian Loehle wrote:
> On 2/13/26 13:44, Christian Loehle wrote:
> > On 2/13/26 08:29, Aboorva Devarajan wrote:
> > > On Wed, 2026-02-11 at 15:00 +0000, Christian Loehle wrote:
> > > > On 2/11/26 05:35, Aboorva Devarajan wrote:
> > > > > On certain platforms (PowerNV systems without a power-mgt DT node=
),
> > > > > cpuidle may register only a single idle state. In cases where tha=
t
> > > > > single state is a polling state (state 0), the ladder governor ma=
y
> > > > > incorrectly treat state 1 as the first usable state and pass an
> > > > > out-of-bounds index. This can lead to a NULL enter callback being
> > > > > invoked, ultimately resulting in a system crash.
> > > > >=20
> > > > > [=C2=A0=C2=A0 13.342636] cpuidle-powernv : Only Snooze is availab=
le
> > > > > [=C2=A0=C2=A0 13.351854] Faulting instruction address: 0x00000000
> > > > > [=C2=A0=C2=A0 13.376489] NIP [0000000000000000] 0x0
> > > > > [=C2=A0=C2=A0 13.378351] LR=C2=A0 [c000000001e01974] cpuidle_ente=
r_state+0x2c4/0x668
> > > > >=20
> > > > > Fix this by determining the first non-polling state index based o=
n
> > > > > the number of registered states, and by returning state 0 when on=
ly
> > > > > one state is registered.
> > > > >=20
> > > > > Fixes: dc2251bf98c6 ("cpuidle: Eliminate the CPUIDLE_DRIVER_STATE=
_START symbol")
> > > > > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > > >=20
> > > > Agreed that the current behavior is a bug, but is there really much=
 value
> > > > in using a cpuidle governor with just a polling state?
> > > > It's dead code and trivial to bail out of in cpuidle, right?
> > > >=20
> > >=20
> > > Hi Christian,
> > >=20
> > > Thanks for the review.
> > >=20
> > > Other governors (teo, menu) already handle this single-state scenario
> > > correctly. Fixing ladder's first_idx calculation seemed like the most
> > > targeted fix, however since ladder is not widely used this is likely
> > > to go unnoticed, it only popped up during testing with a missing
> > > power-mgt device tree node.
> > >=20
> > > yes, adding a bail-out in the core cpuidle_select() is also trivial a=
nd
> > > would benefit all governors uniformly. Setting stop_tick to false kee=
ps
> > > the tick running, which is correct for a single state configuration.
> > >=20
> > > Please let me know if you'd prefer this approach instead.
> > >=20
> > > ---
> > >=20
> > > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > > index c7876e9e024f..ea082419f7db 100644
> > > --- a/drivers/cpuidle/cpuidle.c
> > > +++ b/drivers/cpuidle/cpuidle.c
> > > @@ -359,6 +359,16 @@ noinstr int cpuidle_enter_state(struct
> > > cpuidle_device *dev,
> > > =C2=A0int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_d=
evice
> > > *dev,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool *stop_tick)
> > > =C2=A0{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If there is only a sing=
le idle state (or none), there is
> > > nothing
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * meaningful for the gove=
rnor to choose. Skip the governor and
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * always use state 0 with=
 the tick running.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(drv->state_count <=
=3D 1)) {
> >=20
> > I think the unlikely isn't helping here, this just let the branch predi=
ctor
> > handle this as it won't change anyway.
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 *stop_tick =3D false;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return cpuidle_curr_govern=
or->select(drv, dev, stop_tick);
> > > =C2=A0}
> > >=20
> >=20
> > I prefer this, additionally of course:
>=20
> I've attached them as patches with a sign-off, feel free to pick them up =
as a series
> or if you provide your signoff I can do that as well.

Hi Christian,

Thanks, I've included your patches and sent them as a series:
https://lore.kernel.org/all/20260216185005.1131593-1-aboorvad@linux.ibm.com=
/

Regards,
Aboorva


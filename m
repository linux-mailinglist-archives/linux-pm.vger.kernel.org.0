Return-Path: <linux-pm+bounces-34444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AC9B52B4A
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 10:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D2C7B2CFC
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 08:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10AD2D94A9;
	Thu, 11 Sep 2025 08:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mRxMV0Hs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137C52D8DCA;
	Thu, 11 Sep 2025 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578465; cv=none; b=J9elyUi9tL8fztY/FvOsAnnaDmFpByNGjHCaKovgESyF+AnPDdjqQGOm27hpR9pY7+wUoefr3FO4CAn4PxfNpYuYfTSQ1kpO+0M4nr1yC2DA4m226hiD291tp1bwGl7QQQLIL7uucP9bMNIiXjT0C/MxQZ1rnFoFUFXzRXfRvdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578465; c=relaxed/simple;
	bh=VbEhs9ZnAQDRP+xllvtAJk7Ut1ZPm+69gJnJ5GoCIi0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CTg9XmN6qFde7uEzHBi4j/9W30HduemxRA0dUlOGRZBQL9299AmlucWX14nfDiKIK2fM9890a50M7TVKclq3rlyTI76fa3zKJwCc+Yqajeis7XDfbxFkxN2KsHY8yjitXTurXYCmKgsZtSYkQLDtHnTO0tbxgB+k/G8FquORHtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mRxMV0Hs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B82xSZ022621;
	Thu, 11 Sep 2025 08:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XljEHL
	CHgr1ogBrdIljQtHScO6BIMbWIU0l+4/pmoD8=; b=mRxMV0HsgjsF9oolXibIsS
	u1KjNrP8aV4FrLJmBatZIwS+aH0qUrbXvbr01AwSmZyp6/306qUnNurZy6AWW8oS
	mEyLY1XAz8II1wCKjmcAxaLmx0L+33tOe3dqHYY1M/eVsoKMnI0KHGnv1Gin7bLU
	y2gf/iQkv7/BWbtD8gYq4hMH8DOdq15vFE7jLDzQFmmTflQEDvXeSEkwDI0hVtE5
	zZWrfBRzD3Z+Bq6C6TCY+Fs500jI9n+4b0B1wHt2Y9Z/OwYsqJ9fLVvB0Ba9zzg0
	ulGZnyaOp4nKoe+nZh3trAOikUMMnLU62LrnjJxwYb/Vba9LIlyNp5RgYchQyXPA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx3bs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 08:14:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58B4lmWe011457;
	Thu, 11 Sep 2025 08:14:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9un2dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 08:14:15 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58B8EE0j17826128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 08:14:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4896220043;
	Thu, 11 Sep 2025 08:14:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF37F20040;
	Thu, 11 Sep 2025 08:14:12 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.109.247.181])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Sep 2025 08:14:12 +0000 (GMT)
Message-ID: <e4fe86ee4a00e100f5cba550c69d28520ad52d42.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] cpuidle: menu: Add residency threshold for
 non-polling state selection
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: christian.loehle@arm.com, daniel.lezcano@linaro.org, gautam@linux.ibm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 11 Sep 2025 13:44:11 +0530
In-Reply-To: <CAJZ5v0hLYkeStuZqUsjSphXmBovAxCvvzx4JJJw=3AmDYjdCtQ@mail.gmail.com>
References: <20250908075443.208570-1-aboorvad@linux.ibm.com>
	 <CAJZ5v0hLYkeStuZqUsjSphXmBovAxCvvzx4JJJw=3AmDYjdCtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZopotVTvwN27Yy0DKT1EFqie0LmuVADm
X-Proofpoint-ORIG-GUID: ZopotVTvwN27Yy0DKT1EFqie0LmuVADm
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c284d9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=M63XDdRkY7QlEbYjXLMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX+CbYuzKEJ8H8
 +tT+pynkUu/EWUPO4BvrC4luWPiuxywTISlAQEbEZCIwFFp8RNg7rMkyLfQMvkamuchlFUk7Hzx
 3gybFw3eYKLA9iNU5mr5dSO9g1xRtfA5S7vIkcyzyQdHeQW5wIGt5OGJI7zFasDhPcY59jnYTbU
 RIXk4PUiSlJAghDx2Pc3S7Ll/Rda4NokRCVLSfYSRqMRsbFEXn1XMNmDgUEy6wQIqUguGGqO/Ri
 yreuwmvuupTgRL8fmkT3MrwapE33bYVl0pyJ+bJ6DR7TUhbVNMRRSfEo3p7L1aczmhZnHV+MTvm
 7LsVli6YCYJuLQyqEgahV9wocYxCOHu4pKtqzTGrQaCJBRSwLpGmppTBnQzMiDMs1uaGAtPeA7+
 t4m1ty5P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

On Wed, 2025-09-10 at 12:47 +0200, Rafael J. Wysocki wrote:

Hi Rafael,

> Please change the subject of the patch to something like "cpuidle:
> menu: Use residency threshold in polling state override decisions"
> which more precisely reflects the patch purpose IMV.

Sure, I will change this.

>=20
> On Mon, Sep 8, 2025 at 9:54=E2=80=AFAM Aboorva Devarajan <aboorvad@linux.=
ibm.com> wrote:
> >=20
> > On virtualized PowerPC (pseries) systems, where only one polling state
> > (Snooze) and one deep state (CEDE) are available, selecting CEDE when
> > the predicted idle duration exceeds the target residency of the CEDE
>=20
> If the target residency is exceeded by the predicted idle duration, it
> should be fine to select the given state.
>=20
> Did you really mean "less than" here?=C2=A0 That would be consistent with
> the code change.
>=20

yes, I meant "less than" here, will change it.

> > state can hurt performance. In such cases, the entry/exit overhead of
> > CEDE outweighs the power savings, leading to unnecessary state transiti=
ons
> > and higher latency.
> >=20
> > Menu governor currently contains a special-case rule that prioritizes
> > the first non-polling state over polling, even when its target residenc=
y
> > is much longer than the predicted idle duration. On PowerPC/pseries,
> > where the gap between the polling state (Snooze) and the first non-poll=
ing
> > state (CEDE) is large, this behavior causes performance regressions.
> >=20
> > This patch refines the special case by adding an extra requirement:
> > the first non-polling state may only be chosen if its
> > target_residency_ns is below the defined RESIDENCY_THRESHOLD_NS. If thi=
s
> > condition is not met, the non-polling state is not selected, and pollin=
g
> > state is retained instead.
> >=20
> > This change is limited to the single special-case condition for the fir=
st
> > non-polling state. The general state selection logic in the menu govern=
or
> > remains unchanged.
> >=20
> > Performance improvement observed with pgbench on PowerPC (pseries)
> > system:
> > +---------------------------+------------+------------+------------+
> > > Metric=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Baseline=C2=A0=C2=A0 =
| Patched=C2=A0=C2=A0=C2=A0 | Change (%) |
> > +---------------------------+------------+------------+------------+
> > > Transactions/sec (TPS)=C2=A0=C2=A0=C2=A0 | 495,210=C2=A0=C2=A0=C2=A0 =
| 536,982=C2=A0=C2=A0=C2=A0 | +8.45%=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > Avg latency (ms)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 0.163=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 0.150=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | -7.98%=C2=A0=C2=A0=C2=A0=C2=A0 |
> > +---------------------------+------------+------------+------------+
> > CPUIdle state usage:
> > +--------------+--------------+-------------+
> > > Metric=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Baseline=C2=A0=C2=A0=C2=
=A0=C2=A0 | Patched=C2=A0=C2=A0=C2=A0=C2=A0 |
> > +--------------+--------------+-------------+
> > > Total usage=C2=A0 | 12,735,820=C2=A0=C2=A0 | 13,918,442=C2=A0 |
> > > Above usage=C2=A0 | 11,401,520=C2=A0=C2=A0 | 1,598,210=C2=A0=C2=A0 |
> > > Below usage=C2=A0 | 20,145=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 702,=
395=C2=A0=C2=A0=C2=A0=C2=A0 |
> > +--------------+--------------+-------------+
> >=20
> > Above/Total and Below/Total usage percentages which indicates
> > mispredictions:
> > +------------------------+-----------+---------+
> > > Metric=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Baseline=C2=A0 | Patched |
> > +------------------------+-----------+---------+
> > > Above % (Above/Total)=C2=A0 | 89.56%=C2=A0=C2=A0=C2=A0 | 11.49%=C2=A0=
 |
> > > Below % (Below/Total)=C2=A0 | 0.16%=C2=A0=C2=A0=C2=A0=C2=A0 | 5.05%=
=C2=A0=C2=A0 |
> > > Total cpuidle miss (%) | 89.72%=C2=A0=C2=A0=C2=A0 | 16.54%=C2=A0 |
> > +------------------------+-----------+---------+
> >=20
> > The results show that restricting non-polling state selection to
> > cases where its residency is within the threshold reduces misprediction=
s,
> > lowers unnecessary state transitions, and improves overall throughput.
> >=20
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > ---
> >=20
> > v2: https://lore.kernel.org/all/20250317060357.29451-1-aboorvad@linux.i=
bm.com/
> >=20
> > Changes in v2 -> v3:
> > =C2=A0 - Modifed the patch following Rafael's feedback, incorporated a =
residency threshold check
> > =C2=A0=C2=A0=C2=A0 (s->target_residency_ns < RESIDENCY_THRESHOLD_NS) as=
 suggested.
> > =C2=A0 - Updated commit message accordingly.
> > ---
> > =C2=A0drivers/cpuidle/governors/menu.c | 8 +++++---
> > =C2=A01 file changed, 5 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governo=
rs/menu.c
> > index b2e3d0b0a116..d25b04539109 100644
> > --- a/drivers/cpuidle/governors/menu.c
> > +++ b/drivers/cpuidle/governors/menu.c
> > @@ -316,11 +316,13 @@ static int menu_select(struct cpuidle_driver *drv=
, struct cpuidle_device *dev,
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (s->target_residency_ns > predicted_ns) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Use=
 a physical idle state, not busy polling, unless
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * a t=
imer is going to trigger soon enough.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Use=
 a physical idle state instead of busy polling
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if =
the next timer doesn't expire soon and its
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * tar=
get residency is below the residency threshold.
>=20
> I would rephrase this somewhat, like this:
>=20
> * Use a physical idle state instead of busy polling so long as
> * its target residency is below the residency threshold and the
> * next timer doesn't expire soon.

Sure, will change this.

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((=
drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 s->target_residency_ns <=3D data->next_timer_ns) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 s->target_residency_ns <=3D data->next_timer_ns &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 s->target_residency_ns < RESIDENCY_THRESHOLD_NS) {
>=20
> And maybe adjust the checks ordering here.
>=20
> The point is that on the example platform in question
> s->target_residency_ns is always above RESIDENCY_THRESHOLD_NS, so it
> is never really necessary to check data->next_timer_ns in which case
> the HW should be able to optimize this.


That's right, I will change the condition as follows:

                        if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING)=
 &&
                           s->target_residency_ns < RESIDENCY_THRESHOLD_NS =
&&
                           s->target_residency_ns <=3D data->next_timer_ns)=
 {            =20

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 predicted_ns =3D s->target_resid=
ency_ns;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idx =3D i;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > --

Thanks for your comments.

I will post the next version with the suggested changes.


Regards,
Aboorva


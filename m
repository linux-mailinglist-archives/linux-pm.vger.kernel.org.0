Return-Path: <linux-pm+bounces-25342-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5135FA877A3
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 08:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5401A16F98D
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 06:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16C519DF5B;
	Mon, 14 Apr 2025 06:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eNecHrcs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE28B28F4;
	Mon, 14 Apr 2025 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610475; cv=none; b=bjGbeIO1hohwAQtkUMNFoc+oLj+sNgHp4cn8B0ajB6yB9J+/SgzCGdoYm8MjBVXmBsRsmFHNoZnm2/28mrFUU4pQb2sTXowMbs07B0UoyeFQy0opJIBG+LAS+7hew4kShVAJtF30aqkwTICOY1K/UtEKq6QeLFsVE4BS/P7Bj+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610475; c=relaxed/simple;
	bh=mSAY3a+fSWoE+a40aq6TToaWfWJC62cAV9qkF6Bc0kQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vv/lXYXkcv92nGbDyKW2Au3yWA4Agdm0LYzpaplw/E6KA5L/8K8JCcK8vwX3f7EIq3CPu7jb2dHGXF9tU5xsqQovwFQZzLICZl4Cln0WuyIq05SPGDozpsZcbnybnMTfY1rA1T2a9X/C+QboHvdh1XYw+yTKVUeSCy94MATZlK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eNecHrcs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DMeTOQ003355;
	Mon, 14 Apr 2025 06:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R3UXd/
	FoEzDEZ/l6o/aqQq+UWAbcKTgnnD42YUOJCY8=; b=eNecHrcsrS1a/y7znP+A0k
	GGRMP0NWewHBde4wToXNIz6IxU/TG7b4ojMJrmtc8pEJgibO8MTR5jI1MvEHl54x
	Izut+aw+czZ1u5kRuLvIM/3ZnPDsxS6rjSuKPJD/AMP71y6Mq6wV/2x1lvbFc3hh
	x4GnecjoiJsAiuvMGE76kQo/HEkJlcTqeetb6RFOJj5Vs3VvXbmvEhwWklTgqcSg
	nFjTSpCZC9ZzfyEYY23gue8VmwDF/IVPspRgw7UGapWwbKEozHyUo5CYU+LqHX9r
	6NmHOz3qcYWHYD954vIHuDvwQ3c7avVSAUtrjsCBOgtYN/5hFHFSjMaZL6J20E1A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460ndssctj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 06:01:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53E4tTYs016407;
	Mon, 14 Apr 2025 06:01:06 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 460571vj4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 06:01:06 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53E615g031982248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 06:01:05 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 473FB58063;
	Mon, 14 Apr 2025 06:01:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55C6C5805A;
	Mon, 14 Apr 2025 06:01:02 +0000 (GMT)
Received: from li-c18b6acc-24ee-11b2-a85c-81492619bda1.ibm.com (unknown [9.43.55.58])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Apr 2025 06:01:01 +0000 (GMT)
Message-ID: <ceb2759f3bdcebc4be99d8967b9292a9b85fadc7.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] cpuidle: menu: Prefer polling state for short
 idle durations
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Christian Loehle
	 <christian.loehle@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Gautam Menghani	
 <gautam@linux.ibm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Mon, 14 Apr 2025 11:31:00 +0530
In-Reply-To: <CAJZ5v0js=Ca4MtcTa2zO2B_fCZNJrOAJzRKAPWSD6fFzn88z_w@mail.gmail.com>
References: <20250317060357.29451-1-aboorvad@linux.ibm.com>
	 <525a2352-dc57-45ca-adb2-f7039c37145e@arm.com>
	 <CAJZ5v0js=Ca4MtcTa2zO2B_fCZNJrOAJzRKAPWSD6fFzn88z_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B9HCfGWrE8rNVFWt8NdnCucvliKio5zo
X-Proofpoint-ORIG-GUID: B9HCfGWrE8rNVFWt8NdnCucvliKio5zo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140042

On Tue, 2025-04-01 at 18:58 +0200, Rafael J. Wysocki wrote:
> On Mon, Mar 17, 2025 at 9:35=E2=80=AFAM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >=20
> > On 3/17/25 06:03, Aboorva Devarajan wrote:
> > > Avoid selecting deep idle state when the predicted idle duration is
> > > shorter than its target residency, as this leads to unnecessary state
> > > transitions without energy savings.
> > >=20
> > > On virtualized PowerPC (pseries) systems, where only one polling stat=
e
> > > (Snooze) and one deep state (CEDE) are available, selecting CEDE when
> > > its target residency exceeds the predicted idle duration hurts
> > > performance.
> > >=20
> > > For example, if the predicted idle duration is 15 us and the first
> > > non-polling state has a target residency of 120 us, selecting it
> > > would be suboptimal.
> > >=20
> > > Remove the condition introduced in commit 69d25870f20c
> > > ("cpuidle: fix the menu governor to boost IO performance") that
> > > prioritized non-polling states even when their target residency
> > > exceeded the predicted idle duration and allow polling states to
> > > be selected when appropriate.
> > >=20
> > > Performance improvement observed with pgbench on PowerPC (pseries)
> > > system:
> > > +---------------------------+------------+------------+------------+
> > > > Metric=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Baseline=C2=A0=C2=
=A0 | Patched=C2=A0=C2=A0=C2=A0 | Change (%) |
> > > +---------------------------+------------+------------+------------+
> > > > Transactions/sec (TPS)=C2=A0=C2=A0=C2=A0 | 494,834=C2=A0=C2=A0=C2=
=A0 | 538,707=C2=A0=C2=A0=C2=A0 | +8.85%=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > > Avg latency (ms)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 0.162=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 0.149=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | -8.02%=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > +---------------------------+------------+------------+------------+
> > >=20
> > > CPUIdle state usage:
> > > +--------------+--------------+-------------+
> > > > Metric=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Baseline=C2=A0=C2=A0=
=C2=A0=C2=A0 | Patched=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > +--------------+--------------+-------------+
> > > > Total usage=C2=A0 | 12,703,630=C2=A0=C2=A0 | 13,941,966=C2=A0 |
> > > > Above usage=C2=A0 | 11,388,990=C2=A0=C2=A0 | 1,620,474=C2=A0=C2=A0 =
|
> > > > Below usage=C2=A0 | 19,973=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 68=
4,708=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > +--------------+--------------+-------------+
> > >=20
> > > Above/Total and Below/Total usage percentages:
> > > +------------------------+-----------+---------+
> > > > Metric=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Baseline=C2=A0 | Patched |
> > > +------------------------+-----------+---------+
> > > > Above % (Above/Total)=C2=A0 | 89.67%=C2=A0=C2=A0=C2=A0 | 11.63%=C2=
=A0 |
> > > > Below % (Below/Total)=C2=A0 | 0.16%=C2=A0=C2=A0=C2=A0=C2=A0 | 4.91%=
=C2=A0=C2=A0 |
> > > > Total cpuidle miss (%) | 89.83%=C2=A0=C2=A0=C2=A0 | 16.54%=C2=A0 |
> > > +------------------------+-----------+---------+
> > >=20
> > > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > >=20
> > > ---
> > >=20
> > > v1: https://lore.kernel.org/all/20240809073120.250974-1-aboorvad@linu=
x.ibm.com/
> > >=20
> > > v1 -> v2:
> > >=20
> > > - Drop cover letter and improve commit message.
> > > ---
> > > =C2=A0drivers/cpuidle/governors/menu.c | 11 -----------
> > > =C2=A01 file changed, 11 deletions(-)
> > >=20
> > > diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/gover=
nors/menu.c
> > > index 28363bfa3e4c..4b199377e4be 100644
> > > --- a/drivers/cpuidle/governors/menu.c
> > > +++ b/drivers/cpuidle/governors/menu.c
> > > @@ -296,17 +296,6 @@ static int menu_select(struct cpuidle_driver *dr=
v, struct cpuidle_device *dev,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idx =3D i; /* fir=
st enabled state */
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (s->target_residency_ns > predicted_ns) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Use a physic=
al idle state, not busy polling, unless
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * a timer is g=
oing to trigger soon enough.
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((drv->states[idx=
].flags & CPUIDLE_FLAG_POLLING) &&
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 s->exit_latency_ns <=3D latency_req &&
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 s->target_residency_ns <=3D data->next_timer_ns) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 predicted_ns =3D s->target_residency_ns;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 idx =3D i;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (predicted_ns =
< TICK_NSEC)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > >=20
> >=20
> > I'm still fine with this and don't see a better way to solve the report=
ed
> > issue generally, see the discussion on v1.
> > Rafael, do you have any objections?
>=20
> The behavior change on x86 would be rather unacceptable I'm afraid.
>=20
> As already stated in a different thread today, on x86 the polling
> state turns out to be overly shallow most of the time even before this
> patch.
>=20
> > We could make this conditional on there being a high latency difference=
 between
> > polling and non-polling to keep x86 behavior.
>=20
> If I'm not mistaken, to address the issue at hand, it would be
> sufficient to add an "s->target_residency_ns < RESIDENCY_THRESHOLD_NS"
> condition to the if () statement removed by this patch, wouldn't it?

Hi Rafael,

Thanks for your response. Since the first physical state for the pseries sy=
stem
(PowerVM) has a target residency of is 120 us, adding the condition
`s->target_residency_ns < RESIDENCY_THRESHOLD_NS` will indeed resolve the i=
ssue.

This change will ensure we only switch if the target residency of the physi=
cal polling
state is below 15 us which should be good.


Basic CPU Idle test: (1) carried out on a PowerVM (Power10) system.

Base Kernel:  =20
 CPU Wakee  CPU Waker  Sleep Interval (us)  Total Usage Diff  Total Time Di=
ff (ns)  Total Above Diff  Total Below Diff  Above %  Below %
        10         39                2.585            302245               =
 463259                 5                 0     0.00     0.00
        10         39                4.735           1023429               =
2449157                 7                 2     0.00     0.00
        10         39                7.339           1321973               =
2542391                 6                 0     0.00     0.00
        10         39               12.376            798039               =
5429695                 5                 0     0.00     0.00
        10         39               22.373            443568               =
7677710            232439                 0    52.40     0.00
        10         39               32.472            306655               =
8514874            306552                 0    99.97     0.00
        10         39               42.385            235004               =
8800135            231795                 1    98.63     0.00
        10         39               52.461            190079               =
9029907            187694                 1    98.75     0.00
        10         39               62.473            159704               =
9182151            157656                 0    98.72     0.00
        10         39               72.442            137826               =
9282009            136055                 1    98.72     0.00
        10         39               82.462            120114               =
9308294            118640                 1    98.77     0.00
        10         39               92.464            106081               =
9278734            104725                 2    98.72     0.00
        10         39              102.477             96663               =
9422966             95415                 2    98.71     0.00
        10         39              112.413             88117               =
9459074             86972                 1    98.70     0.00
        10         39              122.465             80942               =
9497520             79064                10    97.68     0.01
        10         39              132.430             75825               =
9544063              1035               913     1.36     1.20
        10         39              142.442             70511               =
9561624               969               843     1.37     1.20
        10         39              152.449             65929               =
9586042               936               762     1.42     1.16
        10         39              202.425             49782               =
9636037               960               591     1.93     1.19
        10         39              302.405             33770               =
9749277               415               392     1.23     1.16
        10         39              402.443             25403               =
9701667               306               292     1.20     1.15
        10         39              502.433             20751               =
9826491               245               236     1.18     1.14
        10         39              602.451             17468               =
9832612               208               203     1.19     1.16
        10         39              702.492             15135               =
9847269               193               168     1.28     1.11
        10         39              802.501             13369               =
9856279               159               151     1.19     1.13
        10         39              902.507             12007               =
9862544               147               138     1.22     1.15
        10         39             1002.499             10906               =
9865485               132               135     1.21     1.24
       =20
With suggested change:    =20
 CPU Wakee  CPU Waker  Sleep Interval (us)  Total Usage Diff  Total Time Di=
ff (ns)  Total Above Diff  Total Below Diff  Above %  Below %
        10         39                2.682            247169               =
 433222                 1                 0     0.00     0.00
        10         39                4.803           1007178               =
2560799                 6                 0     0.00     0.00
        10         39                7.357           1327004               =
2754768                 6                 1     0.00     0.00
        10         39               12.362            799098               =
5556114                 6                 0     0.00     0.00
        10         39               22.380            443901               =
7402339                 6                 2     0.00     0.00
        10         39               32.388            307357               =
8190282                 6                 1     0.00     0.00
        10         39               42.423            234908               =
8625490                 6                 0     0.00     0.00
        10         39               52.425            190224               =
8882797                 0                 0     0.00     0.00
        10         39               62.354            159019               =
9000032                 6                 0     0.00     0.00
        10         39               72.380            137887               =
9182585                11                 4     0.01     0.00
        10         39               82.412            121129               =
9285328                 2                 1     0.00     0.00
        10         39               92.398            107844               =
9326098                 3                15     0.00     0.01
        10         39              102.456             97320               =
9408519                 3                 1     0.00     0.00
        10         39              112.358             88884               =
9468555                 6                 4     0.01     0.00
        10         39              122.402             81630               =
9517007                 6                42     0.01     0.05
        10         39              132.359            111082               =
9528254             38190             37018    34.38    33.32
        10         39              142.368             71612               =
9636036              1309              1318     1.83     1.84
        10         39              152.466             66791               =
9663690              1152              1086     1.72     1.63
        10         39              202.453             50412               =
9745668               999               707     1.98     1.40
        10         39              302.454             34045               =
9828326               429               427     1.26     1.25
        10         39              402.480             25851               =
9868703               319               328     1.23     1.27
        10         39              502.407             20931               =
9877533               273               271     1.30     1.29
        10         39              602.440             17602               =
9878219               224               225     1.27     1.28
        10         39              702.465             15254               =
9915818               192               196     1.26     1.28
        10         39              802.452             13462               =
9930026               161               158     1.20     1.17
        10         39              902.461             12089               =
9933506               144               138     1.19     1.14
        10         39             1002.483             10988               =
9942937               130               130     1.18     1.18
       =20



I'm a bit curious on why RESIDENCY_THRESHOLD_NS is hardcoded to 15 us? Woul=
d it make sense to make this value tunable instead?

I actually have a patch that makes it configurable via sysfs to include it =
along with this change if you think that would be useful.=20

Looking forward for your comments on this.

Thanks and regards,
Aboorva

[1]: https://github.com/AboorvaDevarajan/linux-utils/tree/main/cpuidle/cpui=
dle_wakeup


Return-Path: <linux-pm+bounces-42605-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ILIOU7hjmluFgEAu9opvQ
	(envelope-from <linux-pm+bounces-42605-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 09:31:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DFF134108
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 09:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF5AF3059825
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 08:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4FD32D0E8;
	Fri, 13 Feb 2026 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jtmHJeME"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0BA32D0E6;
	Fri, 13 Feb 2026 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770971382; cv=none; b=JAkWpv96uSYalceiZcFkM6IaLfTLF7XH8RjwopU6LyyVAtMupShiu1MwgpcBTGn+oYSLICFZTukuQ5qISbybYXrf/3nFiEJgDntZYu6le/4GZt9SYvu52+dSi1ItUtf5yMISXS3A/rR13ynERW4wc4VaRW5gUDnX7FDtaeYz/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770971382; c=relaxed/simple;
	bh=YaH/5F3iNwlx2Opbq+ZUKO6LkJvff7MT8NpfTtT4d5E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BmwaUaJLsk0EyoikThQewIB2w4VPG5xacrirjuvsA9YO5SqotJsYKFNIFVylcEciIZOifTByWQPL9lH0YaD5f+GH05nYHw4DM5g2EQTLr8fgwvKPcxcP+XgCEdTKpm87cGgdw3o95vnW/mV1OFvnhEY7flnjm+AWouscxZS4q4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jtmHJeME; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D63ACs2871415;
	Fri, 13 Feb 2026 08:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NYDzRY
	Wd7wm30LvT4KPDUsEbpAx+LuYEi5hkyFNioDU=; b=jtmHJeMExs0A+cvVLWAcgj
	r3jW9mKO48edxz7YfcQWcz4WvCV1PyLC51gPj2n6CTra1kIWiHZleGNeQWtd3K1Y
	RtpkInKdVCEOcoqSnV/GtCIVYgKdVeIM8VtlNbdN4shRSkyr+HyUA/B4djaNP2oy
	qDmpFQHHPnUM+BMWk2KEic6KsTeZkd2VRQ7JVYjI9XLc83TvbYkmy6zaOFIgHNpo
	jh9GW7ZmP/UbWI3d70/czauKuXt9Z7T+UUpxyZvfKyKWxgFPMUB7QpRfW0TXXg77
	xEdhfkcW60yLO50IkUEg2GuMD7wXyoE+SQbd4lloEfBEPgHf72N77CYmAy2luCwQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696ut65p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 08:29:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61D4IbIZ019258;
	Fri, 13 Feb 2026 08:29:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxkdw0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 08:29:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61D8TRMV49217930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 08:29:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0D822005A;
	Fri, 13 Feb 2026 08:29:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C3C12004D;
	Fri, 13 Feb 2026 08:29:26 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.150.24.48])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Feb 2026 08:29:25 +0000 (GMT)
Message-ID: <7297173684f500e006a2997b92c927262221336f.camel@linux.ibm.com>
Subject: Re: [PATCH] cpuidle: ladder: Fix state index when only one idle
 state is registered
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Fri, 13 Feb 2026 13:59:24 +0530
In-Reply-To: <c3d670cd-fc54-49a8-b640-fb16f9bd0487@arm.com>
References: <20260211053552.739337-1-aboorvad@linux.ibm.com>
	 <c3d670cd-fc54-49a8-b640-fb16f9bd0487@arm.com>
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
X-Authority-Analysis: v=2.4 cv=KZnfcAYD c=1 sm=1 tr=0 ts=698ee0ea cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=i_DVQUyr433w5YP_lWcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA2MyBTYWx0ZWRfX2WNnG2+FM5b+
 BWDO8nBU65sYO7nuc2xFef+MNIsKqAEcpDfczY8DcTBjxqTy0EIDpzDLM83iYK35cYZn3cp0TNS
 tiIPHyYTwo3fxG8I3ejkbLr5ckpehChtY+IA3uXhBWhkL9JuVxl5234GxrGxic+JFhKFnPmw7BA
 7GmxqC3qFXBosXBr+auX1hbXtPVBcGi+5wE3KRfsrySwP8cWhLYS4UEypcOQm9deiu2gXdP124Y
 xrZmVLxNMHa96cFu7QqntfOaapmJileavbdRqgEKiyb1WFG8zO527Zb+Jhq00KLkT+RKxK697r4
 rsjn3elJ9AbTaLpb9hBuII3MRTmqTdylqw4wsO7gMMCDm3hoThVKEWqORK72NBJGvlaeP1B+bCS
 0TocTfnY1DXOya565AfHwl39Mo76p0Spc/3IknYmjGw4shtPVaSp7iOK+vtUGVvysIy1mPPYj48
 AYfUKCLLz8OCDmBHbxA==
X-Proofpoint-ORIG-GUID: ZPNxT_0Ar4pgTfLQfrKptcZ9qjI2hxnk
X-Proofpoint-GUID: ZPNxT_0Ar4pgTfLQfrKptcZ9qjI2hxnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130063
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aboorvad@linux.ibm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42605-lists,linux-pm=lfdr.de];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 46DFF134108
X-Rspamd-Action: no action

On Wed, 2026-02-11 at 15:00 +0000, Christian Loehle wrote:
> On 2/11/26 05:35, Aboorva Devarajan wrote:
> > On certain platforms (PowerNV systems without a power-mgt DT node),
> > cpuidle may register only a single idle state. In cases where that
> > single state is a polling state (state 0), the ladder governor may
> > incorrectly treat state 1 as the first usable state and pass an
> > out-of-bounds index. This can lead to a NULL enter callback being
> > invoked, ultimately resulting in a system crash.
> >=20
> > [=C2=A0=C2=A0 13.342636] cpuidle-powernv : Only Snooze is available
> > [=C2=A0=C2=A0 13.351854] Faulting instruction address: 0x00000000
> > [=C2=A0=C2=A0 13.376489] NIP [0000000000000000] 0x0
> > [=C2=A0=C2=A0 13.378351] LR=C2=A0 [c000000001e01974] cpuidle_enter_stat=
e+0x2c4/0x668
> >=20
> > Fix this by determining the first non-polling state index based on
> > the number of registered states, and by returning state 0 when only
> > one state is registered.
> >=20
> > Fixes: dc2251bf98c6 ("cpuidle: Eliminate the CPUIDLE_DRIVER_STATE_START=
 symbol")
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>=20
> Agreed that the current behavior is a bug, but is there really much value
> in using a cpuidle governor with just a polling state?
> It's dead code and trivial to bail out of in cpuidle, right?
>=20

Hi Christian,

Thanks for the review.

Other governors (teo, menu) already handle this single-state scenario
correctly. Fixing ladder's first_idx calculation seemed like the most
targeted fix, however since ladder is not widely used this is likely
to go unnoticed, it only popped up during testing with a missing
power-mgt device tree node.

yes, adding a bail-out in the core cpuidle_select() is also trivial and
would benefit all governors uniformly. Setting stop_tick to false keeps
the tick running, which is correct for a single state configuration.

Please let me know if you'd prefer this approach instead.

---

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index c7876e9e024f..ea082419f7db 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -359,6 +359,16 @@ noinstr int cpuidle_enter_state(struct
cpuidle_device *dev,
 int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device
*dev,
                   bool *stop_tick)
 {
+       /*
+        * If there is only a single idle state (or none), there is
nothing
+        * meaningful for the governor to choose. Skip the governor and
+        * always use state 0 with the tick running.
+        */
+       if (unlikely(drv->state_count <=3D 1)) {
+               *stop_tick =3D false;
+               return 0;
+       }
+
        return cpuidle_curr_governor->select(drv, dev, stop_tick);
 }

---


Regards,
Aboorva


> > ---
> > =C2=A0drivers/cpuidle/governors/ladder.c | 24 ++++++++++++++++++++----
> > =C2=A01 file changed, 20 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/gover=
nors/ladder.c
> > index 6617eb494a11..294a688ed0bb 100644
> > --- a/drivers/cpuidle/governors/ladder.c
> > +++ b/drivers/cpuidle/governors/ladder.c
> > @@ -42,6 +42,21 @@ struct ladder_device {
> > =C2=A0
> > =C2=A0static DEFINE_PER_CPU(struct ladder_device, ladder_devices);
> > =C2=A0
> > +/**
> > + * ladder_get_first_idx - get the first non-polling state index
> > + * @drv: cpuidle driver
> > + *
> > + * Returns the index of the first non-polling state, or 0 if state 0 i=
s not
> > + * polling or if there's only one state available.
> > + */
> > +static inline int ladder_get_first_idx(struct cpuidle_driver *drv)
> > +{
> > +	if (drv->state_count > 1 &&
> > +	=C2=A0=C2=A0=C2=A0 drv->states[0].flags & CPUIDLE_FLAG_POLLING)
> > +		return 1;
> > +	return 0;
> > +}
> > +
> > =C2=A0/**
> > =C2=A0 * ladder_do_selection - prepares private data for a state change
> > =C2=A0 * @dev: the CPU
> > @@ -70,16 +85,17 @@ static int ladder_select_state(struct cpuidle_drive=
r *drv,
> > =C2=A0	struct ladder_device *ldev =3D this_cpu_ptr(&ladder_devices);
> > =C2=A0	struct ladder_device_state *last_state;
> > =C2=A0	int last_idx =3D dev->last_state_idx;
> > -	int first_idx =3D drv->states[0].flags & CPUIDLE_FLAG_POLLING ? 1 : 0=
;
> > +	int first_idx;
> > =C2=A0	s64 latency_req =3D cpuidle_governor_latency_req(dev->cpu);
> > =C2=A0	s64 last_residency;
> > =C2=A0
> > -	/* Special case when user has set very strict latency requirement */
> > -	if (unlikely(latency_req =3D=3D 0)) {
> > +	/* Special case when there's only one state or strict latency require=
ment */
> > +	if (unlikely(drv->state_count <=3D 1 || latency_req =3D=3D 0)) {
> > =C2=A0		ladder_do_selection(dev, ldev, last_idx, 0);
> > =C2=A0		return 0;
> > =C2=A0	}
> > =C2=A0
> > +	first_idx =3D ladder_get_first_idx(drv);
> > =C2=A0	last_state =3D &ldev->states[last_idx];
> > =C2=A0
> > =C2=A0	last_residency =3D dev->last_residency_ns - drv->states[last_idx=
].exit_latency_ns;
> > @@ -134,7 +150,7 @@ static int ladder_enable_device(struct cpuidle_driv=
er *drv,
> > =C2=A0				struct cpuidle_device *dev)
> > =C2=A0{
> > =C2=A0	int i;
> > -	int first_idx =3D drv->states[0].flags & CPUIDLE_FLAG_POLLING ? 1 : 0=
;
> > +	int first_idx =3D ladder_get_first_idx(drv);
> > =C2=A0	struct ladder_device *ldev =3D &per_cpu(ladder_devices, dev->cpu=
);
> > =C2=A0	struct ladder_device_state *lstate;
> > =C2=A0	struct cpuidle_state *state;


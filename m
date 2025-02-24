Return-Path: <linux-pm+bounces-22774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CEDA4154F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 07:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6E1E7A4BBB
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 06:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCCB1C878E;
	Mon, 24 Feb 2025 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XrW4Ti7T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061028DB3;
	Mon, 24 Feb 2025 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740378458; cv=none; b=BCgsgiVTwu45X+belMd/tpD0rPr1KIXEFyTSSGs1j2gyC9JRMEX+jSkWyYdNjnzgh36sFon5hr56NyqqdHGeVBn3M/+Ll81cv/K5f//pNmQ+p+cSFY5aOiLCy0JGgjmNMtHTW4FXh3QIUF47EkfStkssg6HBD3LbYeTex0lxzHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740378458; c=relaxed/simple;
	bh=luPlw6uwbaq/7gttQwvm4oCUu0EG/WckusfarGsw1I8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q2gm5LSnjK3R9xYEOTSEVjWm6L87cLnHn9QrP1iJTFGB29pS/SpBtTQwWnIqBRbZDcRxZWDu6ySi93CNtvKwWaM0k9hPQE55rTj/yOgJnAD/UWOGG9xaaFYHJH25/VEynIc4j0m4hScOUlxoHtIq9KK94K8tXVq1Wweg49i+O88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XrW4Ti7T; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O5NmZA011957;
	Mon, 24 Feb 2025 06:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1nXoVE
	0UB0GLW1u3WgotYD7FVu4PILf/V4ZbHWaldLA=; b=XrW4Ti7TyhXmVUIsKESvd2
	4p2AzSzR0DKF1dWtU5JWE0vvJBXDgZ5Yv9Oy+XHHHxTQ0XgGOzGCX40wq0UcIj5P
	YJQlH0gm9V2dp82MjrlybbiQO5EYIWATMGs5+Ihg/oEH2yFdKxDsQ//hzFKNBou1
	d1ChO1m9bu0WZdOGkAgk8b3MwjdStFBB3N9lPIMcral0fhzkGEIGWgms+fxZ9OWY
	ljt3wC+/qDSRWOahuaT171Ibjf4+fO1LvILD3P6fZ5yA4qaHBSLrf3dxCx4JjmRp
	BOaJghXVzkxL1T28HcRbzrIaxaAzQdy9t1SebU1RaBAtkJFMgaJ4XgIIsuK4hqkg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450jk806uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 06:27:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51O5LLUL002578;
	Mon, 24 Feb 2025 06:27:28 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4jdet1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 06:27:28 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51O6RR9j7537324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 06:27:27 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7563758058;
	Mon, 24 Feb 2025 06:27:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72D9D58059;
	Mon, 24 Feb 2025 06:27:24 +0000 (GMT)
Received: from li-c18b6acc-24ee-11b2-a85c-81492619bda1.ibm.com (unknown [9.124.212.4])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Feb 2025 06:27:24 +0000 (GMT)
Message-ID: <d0c013d5d2a9251d5dc468446f2a08ae8a7a8953.camel@linux.ibm.com>
Subject: Re: [RFT][PATCH v1 0/5] cpuidle: menu: Avoid discarding useful
 information when processing recent idle intervals
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano
	 <daniel.lezcano@linaro.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        aboorvad@linux.ibm.com
Date: Mon, 24 Feb 2025 11:57:22 +0530
In-Reply-To: <1916668.tdWV9SEqCh@rjwysocki.net>
References: <1916668.tdWV9SEqCh@rjwysocki.net>
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
X-Proofpoint-ORIG-GUID: Uckhm6RFHnYCRBn_txdFdsxeodHsm10N
X-Proofpoint-GUID: Uckhm6RFHnYCRBn_txdFdsxeodHsm10N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_02,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240042

On Thu, 2025-02-06 at 15:21 +0100, Rafael J. Wysocki wrote:

> Hi Everyone,
>=20
> This work had been triggered by a report that commit 0611a640e60a ("event=
poll:
> prefer kfree_rcu() in __ep_remove()") had caused the critical-jOPS metric=
 of
> the SPECjbb 2015 benchmark [1] to drop by around 50% even though it gener=
ally
> reduced kernel overhead.=C2=A0 Indeed, it was found during further invest=
igation
> that the total interrupt rate while running the SPECjbb workload had fall=
en as
> a result of that commit by 55% and the local timer interrupt rate had fal=
len by
> almost 80%.
>=20
> That turned out to cause the menu cpuidle governor to select the deepest =
idle
> state supplied by the cpuidle driver (intel_idle) much more often which a=
dded
> significantly more idle state latency to the workload and that led to the
> decrease of the critical-jOPS score.
>=20
> Interestingly enough, this problem was not visible when the teo cpuidle
> governor was used instead of menu, so it appeared to be specific to the
> latter.=C2=A0 CPU wakeup event statistics collected while running the wor=
kload
> indicated that the menu governor was effectively ignoring non-timer wakeu=
p
> information and all of its idle state selection decisions appeared to be
> based on timer wakeups only.=C2=A0 Thus, it appeared that the reduction o=
f the
> local timer interrupt rate caused the governor to predict a idle duration
> much more often while running the workload and the deepest idle state was
> selected significantly more often as a result of that.
>=20
> A subsequent inspection of the get_typical_interval() function in the men=
u
> governor indicated that it might return UINT_MAX too often which then cau=
sed
> the governor's decisions to be based entirely on information related to t=
imers.
>=20
> Generally speaking, UINT_MAX is returned by get_typical_interval() if it
> cannot make a prediction based on the most recent idle intervals data wit=
h
> sufficiently high confidence, but at least in some cases this means that
> useful information is not taken into account at all which may lead to
> significant idle state selection mistakes.=C2=A0 Moreover, this is not re=
ally
> unlikely to happen.
>=20
> One issue with get_typical_interval() is that, when it eliminates outlier=
s from
> the sample set in an attempt to reduce the standard deviation (and so imp=
rove
> the prediction confidence), it does that by dropping high-end samples onl=
y,
> while samples at the low end of the set are retained.=C2=A0 However, the =
samples
> at the low end very well may be the outliers and they should be eliminate=
d
> from the sample set instead of the high-end samples.=C2=A0 Accordingly, t=
he
> likelihood of making a meaningful idle duration prediction can be improve=
d
> by making it also eliminate low-end samples if they are farther from the
> average than high-end samples.=C2=A0 This is done in patch [4/5].
>=20
> Another issue is that get_typical_interval() gives up after eliminating 1=
/4
> of the samples if the standard deviation is still not as low as desired (=
within
> 1/6 of the average or within 20 us if the average is close to 0), but the
> remaining samples in the set still represent useful information at that p=
oint
> and discarding them altogether may lead to suboptimal idle state selectio=
n.
>=20
> For instance, the largest idle duration value in the get_typical_interval=
()
> data set is the maximum idle duration observed recently and it is likely =
that
> the upcoming idle duration will not exceed it.=C2=A0 Therefore, in the ab=
sence of
> a better choice, this value can be used as an upper bound on the target
> residency of the idle state to select.=C2=A0 Patch [5/5] works along thes=
e lines,
> but it takes the maximum data point remaining after the elimination of
> outliers.
>=20
> The first two patches in the series are straightforward cleanups (in fact=
,
> the first patch is kind of reversed by patch [4/5], but it is there becau=
se
> it can be applied without the latter) and patch [3/5] is a cosmetic chang=
e
> made in preparation for the subsequent ones.
>=20
> This series turns out to restore the SPECjbb critical-jOPS metric on affe=
cted
> systems to the level from before commit 0611a640e60a and it also happens =
to
> increase its max-jOPS metric by around 3%.
>=20
> For easier reference/testing it is present in the git branch at
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?=
h=3Dexperimental/menu
>=20
> based on the cpuidle material that went into 6.14-rc1.
>=20
> If possible, please let me know if it works for you.
>=20
> Thanks!
>=20
>=20
> [1] Link: https://www.spec.org/jbb2015/
>=20
>=20
>=20

Hi Rafael,

I ran some tests using a cpuidle microbenchmark that I have [1]:

The test does a uniform distribution of idle durations, which means the pas=
t eight idle intervals approximately match=20
the sleep duration. So as anticipated, this change-set does not impact this=
 case, and the behavior remains mostly
consistent even after applying the patch.

 Pipe based wakeup - Above %
 ----------------------------------------------------------------------
| Sleep time (s)  | Menu No Patch(%) | Menu Patch(%)| Teo No Patch (%) |
|---------------- |------------------|--------------|------------------|
| 5               | 0.00%            | 0.00%        | 0.00%            |
| 10              | 0.00%            | 0.00%        | 0.00%            |
------------------------------------------------------------------------
| 30              | 99.97%           | 99.96%       | 0.00%            |
| 100             | 98.61%           | 98.67%       | 0.00%            |
| 120             | 97.88%           | 98.42%       | 1.03%            | ->=
 (*)
------------------------------------------------------------------------
| 130             | 2.82%            | 1.26%        | 0.22%            |
| 150             | 1.68%            | 1.43%        | 0.32%            |
| 200             | 2.09%            | 1.91%        | 0.15%            |
| 300             | 1.22%            | 1.22%        | 0.19%            |
| 400             | 1.20%            | 1.21%        | 0.19%            |
| 500             | 1.16%            | 1.12%        | 0.12%            |
------------------------------------------------------------------------

 Pipe based wakeup - Below %
 -----------------------------------------------------------------------
| Sleep time (s)  | Menu No Patch(%) | Menu Patch(%)| Teo No Patch (%) |
|---------------- |------------------|--------------|------------------|
| 5               | 0.00%            | 0.00%        | 0.00%            |
| 10              | 0.00%            | 0.00%        | 0.00%            |
| 30              | 0.00%            | 0.00%        | 0.00%            |
| 100             | 0.00%            | 0.00%        | 0.00%            |
| 120             | 2.76%            | 1.14%        | 0.93%            |
| 130             | 3.11%            | 1.13%        | 0.12%            |
| 150             | 1.34%            | 1.16%        | 0.18%            |
| 200             | 1.38%            | 1.15%        | 0.09%            |
| 300             | 1.33%            | 1.21%        | 0.11%            |
| 400             | 1.36%            | 1.25%        | 0.10%            |
| 500             | 1.25%            | 1.22%        | 0.10%            |
|---------------- |------------------|--------------|------------------|

 Time based wakeup - Above %
 -----------------------------------------------------------------------
| Sleep time (s)  | Menu No Patch(%) | Menu Patch(%)| Teo No Patch (%) |
|---------------- |------------------|--------------|------------------|
| 5               | 0.00%            | 0.00%        | 0.00%            |
| 10              | 0.00%            | 0.00%        | 0.00%            |
| 30              | 0.00%            | 0.00%        | 0.00%            |
| 100             | 0.01%            | 0.00%        | 0.00%            |
| 120             | 0.00%            | 0.00%        | 0.15%            |
| 130             | 15.84%           | 0.14%        | 0.23%            |
| 150             | 0.39%            | 0.23%        | 0.48%            |
| 200             | 0.95%            | 0.87%        | 0.10%            |
| 300             | 0.20%            | 0.17%        | 0.15%            |
| 400             | 0.14%            | 0.12%        | 0.17%            |
| 500             | 0.10%            | 0.20%        | 0.11%            |
|---------------- |------------------|--------------|------------------|

 Time based wakeup - Below %
 -----------------------------------------------------------------------
| Sleep time (s)  | Menu No Patch(%) | Menu Patch(%)| Teo No Patch (%) |
|---------------- |------------------|--------------|------------------|
| 5               | 0.00%            | 0.00%        | 0.00%            |
| 10              | 0.00%            | 0.00%        | 0.00%            |
| 30              | 0.00%            | 0.00%        | 0.00%            |
| 100             | 0.00%            | 0.00%        | 0.00%            |
| 120             | 1.85%            | 1.66%        | 2.67%            |
| 130             | 16.71%           | 1.13%        | 1.11%            |
| 150             | 1.36%            | 1.16%        | 1.13%            |
| 200             | 1.33%            | 1.14%        | 1.19%            |
| 300             | 1.44%            | 1.20%        | 1.17%            |
| 400             | 1.51%            | 1.21%        | 1.21%            |
| 500             | 1.42%            | 1.24%        | 1.25%            |
|---------------- |------------------|--------------|------------------|


(*) - Above and below values are higher even without the patch with menu go=
vernor,
      this issue still persists, as previously reported in [2]. I will inve=
stigate
      further and submit a revision to get additional feedback.

I also carried out some benchmarks using pgbench:

pgbench Results

Without Patch:
---------------------------------------------------------------------------=
--
| Run  | Transactions Processed | Latency Avg (ms) | TPS (without init time=
) |
---------------------------------------------------------------------------=
--
|  1   |  11,936,327            |  0.050           |  198,946.141025       =
  |
|  2   |  11,899,540            |  0.050           |  198,333.097547       =
  |
|  3   |  11,870,792            |  0.051           |  197,853.728614       =
  |
|  4   |  11,901,670            |  0.050           |  198,368.526139       =
  |
|  5   |  11,922,046            |  0.050           |  198,708.112243       =
  |
---------------------------------------------------------------------------=
--
| Avg  |  11,906,075            |  0.0502          |  198,441.921114       =
  |
---------------------------------------------------------------------------=
--

With Patch:
---------------------------------------------------------------------------=
--
| Run  | Transactions Processed | Latency Avg (ms) | TPS (without init time=
) |
---------------------------------------------------------------------------=
--
|  1   |  12,052,865            |  0.050           |  200,888.492771       =
  |
|  2   |  12,058,359            |  0.050           |  200,979.895325       =
  |
|  3   |  12,071,012            |  0.050           |  201,190.809734       =
  |
|  4   |  12,054,646            |  0.050           |  200,918.076736       =
  |
|  5   |  12,053,087            |  0.050           |  200,892.045581       =
  |
---------------------------------------------------------------------------=
--
| Avg  |  12,058,394            |  0.0500          |  200,973.464029       =
  |
---------------------------------------------------------------------------=
---

Performance Improvement After Patch:
---------------------------------------------------------------------------=
-----------
| Metric                  | Without Patch (Avg.)| With Patch (Avg.)  | % Im=
provement |
---------------------------------------------------------------------------=
-----------
| Transactions Processed  |  11,906,075         |  12,058,394        |  +1.=
28%       |=20
| Latency Avg (ms)        |  0.0502             |  0.0500            |  -0.=
40%       |
| TPS (without init time) |  198,441.921114     |  200,973.464029    |  +1.=
28%       |
---------------------------------------------------------------------------=
-----------

So with the patch pgbench's "Transactions Processed" improves by ~1.28%, an=
d I did not observe
any major variations on other benchmarks with the patch.

So for the entire series:

Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

I'm also trying a minimal unit fuzz-test with the pre- and post- patched ve=
rsion of the get_typical_interval=C2=A0
function to understand this better, will post the results soon.

[1] -=C2=A0https://github.com/AboorvaDevarajan/linux-utils/tree/main/cpuidl=
e/cpuidle_wakeup
[2] - https://lore.kernel.org/all/20240809073120.250974-1-aboorvad@linux.ib=
m.com/


Thanks,
Aboorva


Return-Path: <linux-pm+bounces-22950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B64A454B0
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 05:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C6A3A62E6
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 04:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB7B191F84;
	Wed, 26 Feb 2025 04:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iegQ+A7N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE828EB;
	Wed, 26 Feb 2025 04:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740545371; cv=none; b=T2fzcI+6C7mnZUY2AQrYa/FsH1UKrcREsfI6O2egHntaibVA6B9p7ZQV0jobiGSYBviawl8AyaNdKlas/69nQk0h23C89t5mn40R3ndKRpI/2XhkifoTcfgNw40jtD3ezKCy3elVVzFh6szL1sP4poYENfZO1vFwRgZhRyhmWEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740545371; c=relaxed/simple;
	bh=hmYiMPo7oS0DG52c6LMJIaEcn4lsA2RwU65kc+OxC4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l0sRMHGSA0nC1cW9SkxwbrM5kO95m6YCMUbI8S0u2OBmBuDU7Qy8J+vsYCXU7OKFqvS9ZVzpoBdW9aehfEhEPdQJgVw7F5ZUzxWBhqYWRpL2bEwljipLZ+ejORgI3EsridMomHlTEyXc7XqzmQiJnrz4IZ2Cg++ZexJNKRgIwWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iegQ+A7N; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q1krww012248;
	Wed, 26 Feb 2025 04:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ANXq9x
	MWl++0/nmoFVD3Ih/uAbeST/64803+pDppwJ8=; b=iegQ+A7NG1FXBzIYncBYZX
	bgknZEZ9Fb/F7SLo94Ws8zq7R8Dn4S27DZlLqrvckE6uwxXtsfjdaT85R9lm25S1
	ihoyMBl2VgcFMEQzHvlMJUAP/ts4gKqlthL+/0cTJWctjSfdTtb1iYmGUD7a0sDo
	KxDTCPDyMUFc3pRzLuqeSFwh9DkoUnxNJNwpgu37GrTL+UgqpCqm+2XP2p4DxSHc
	Tkgc7NVzNB0fIafQDzfpSw0yW6dB1oZ8Vab041XSWTm3dHfU47G5jvcM3Wd+hXJO
	A6aSKwcr0krBWYqNblGAeS0VtmvXTS7ZIWckbNgnp2EfuTHx8BEeM+00BbNdnZqA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451q5ms5mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 04:49:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q4h4M2027396;
	Wed, 26 Feb 2025 04:49:20 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdkgqav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 04:49:20 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51Q4nJBm27919042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 04:49:19 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51B1B5805E;
	Wed, 26 Feb 2025 04:49:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72CC45805A;
	Wed, 26 Feb 2025 04:49:16 +0000 (GMT)
Received: from li-c18b6acc-24ee-11b2-a85c-81492619bda1.ibm.com (unknown [9.124.212.187])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 04:49:16 +0000 (GMT)
Message-ID: <f949565ef1f256a1641cea3fa1d01d126bcc32e8.camel@linux.ibm.com>
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
Date: Wed, 26 Feb 2025 10:19:14 +0530
In-Reply-To: <d0c013d5d2a9251d5dc468446f2a08ae8a7a8953.camel@linux.ibm.com>
References: <1916668.tdWV9SEqCh@rjwysocki.net>
	 <d0c013d5d2a9251d5dc468446f2a08ae8a7a8953.camel@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: uj5-40n9YXUe1HMMSpwPJ5oKjlHeZ0PF
X-Proofpoint-GUID: uj5-40n9YXUe1HMMSpwPJ5oKjlHeZ0PF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260033

On Mon, 2025-02-24 at 11:57 +0530, Aboorva Devarajan wrote:
> On Thu, 2025-02-06 at 15:21 +0100, Rafael J. Wysocki wrote:
>=20
>=20
>=20
>=20
> So for the entire series:
>=20
> Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>=20
> I'm also trying a minimal unit fuzz-test with the pre- and post- patched =
version of the get_typical_interval=C2=A0
> function to understand this better, will post the results soon.
>=20
>=20
In addition to the previous tests, I also reviewed and tested how get_typic=
al_interval
predicts the idle duration before and after the patch by mimicking the func=
tion in
userspace for better unit fuzz testing [1].

With the patch get_typical_interval function now produces more predictable =
values, whereas
in the previous implementation it frequently returned UINT_MAX. The behavio=
r with the patch
seems to be more reasonable compared to before. =20

Here are the test results =20

1. Low Variance:

When the history of CPU idle durations (8 intervals) is relatively uniform =
with low variance,
the predicted idle duration is unchanged between the patched and unpatched =
versions: =20

| Test Case | Intervals                                    | Before | After=
 | Difference |
|-----------|----------------------------------------------|--------|------=
-|------------|
| 1         | 100,105,110,115,120,125,130,135              | 117    | 117  =
 | 0          |
| 2         | 200,205,210,215,220,225,230,235              | 217    | 217  =
 | 0          |
| 3         | 500,505,510,515,520,525,530,535              | 517    | 517  =
 | 0          |
| 4         | 1000,1005,1010,1015,1020,1025,1030,1035      | 1017   | 1017 =
 | 0          |

 2. High Variance
=20
For cases with high variance, the nonpatched function returned UINT_MAX,

After the patch, the function now returns reasonable values: =20

| Test Case | Intervals                                  | Before      | Af=
ter | Difference       |
|-----------|--------------------------------------------|-------------|---=
----|------------------|
| 5         | 99,198,297,396,495,594,693,792             | 4294967295  | 59=
4   | -4294966701      |
| 6         | 1000,2000,3000,4000,5000,6000,7000,8000    | 4294967295  | 60=
00  | -4294961295      |
| 7         | 40,140,240,340,440,540,640,740             | 4294967295  | 54=
0   | -4294966755      |
| 8         | 90,590,1090,1590,2090,2590,3090,3590       | 4294967295  | 25=
90  | -4294964705      |
| 9         | 42,142,242,342,442,542,642,742             | 4294967295  | 54=
2   | -4294966753      |
| 10        | 70,570,1070,1570,2070,2570,3070,3570       | 4294967295  | 25=
70  | -4294964725      |
| 11        | 44,144,244,344,444,544,644,744             | 4294967295  | 54=
4   | -4294966751      |

 3. Low-end Outliers=20

The patch removes variance from low-end values as well,
Without the patch, the function only filtered high-end outliers, but now it=
 correctly eliminates both
high and low ends.

| Test Case | Intervals                                 | Before      | Aft=
er | Difference  |
|-----------|-------------------------------------------|-------------|----=
---|-------------|
| 12        | 1,200,200,250,250,230,220,260             | 4294967295  | 230=
   | -4294967065 |
| 13        | 100000,200,200,250,250,230,220,260        | 230         | 230=
   | 0           |


 4. As far as I understand, the function only returns UINT_MAX when all val=
ues are 0, negative, or the
computed average itself is UINT_MAX. =20

| Test Case | Intervals                                   | Before      | A=
fter       | Difference |
|-----------|---------------------------------------------|-------------|--=
-----------|------------|
| 14        | 4294967295,4294967295,4294967295,4294967295 | 4294967295  | 4=
294967295  | 0          |
| 15        | 0,0,0,0,0,0,0,0                             | 4294967295  | 4=
294967295  | 0          |

The updated get_typical_interval function avoids unnecessary UINT_MAX retur=
ns, handles both low and high end
outliers, and gives more reliable predictions in high-variance cases. It on=
ly returns UINT_MAX when absolutely
necessary, and this will help in not selecting deeper idle state unless it =
is needed. So, I'm good with
the patch.=20

Refer [2] for more test results.

[1] - https://github.com/AboorvaDevarajan/linux-utils/blob/main/cpuidle/cpu=
idle-predict-duration/predict_cpuidle_interval.c
[2] - https://github.com/AboorvaDevarajan/linux-utils/blob/main/cpuidle/cpu=
idle-predict-duration/out.predict.csv


Thanks,
Aboorva


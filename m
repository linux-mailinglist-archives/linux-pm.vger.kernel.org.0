Return-Path: <linux-pm+bounces-39039-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A5DC9A65C
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 08:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6983A533B
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 07:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97678238C15;
	Tue,  2 Dec 2025 07:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZD9IfqIZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T5ypth/H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206C22A7F9
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 07:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764659601; cv=none; b=D2bKbCqpvzxDOx/+5Sdb+nWwxSjpZVnngkdyBDFXnE9AY11UpTHLitS8ew80tY1sqaFNbn5QdBvLXDmmnu2EwWl9AAAFbg42pjI/oh9ZOkw+H1dFy78FnkyYLGQ86oRKc+jzzEMub635gAWgzHAxhqCuxnDSGyzThtETL6UHgEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764659601; c=relaxed/simple;
	bh=5x0U6TJ/uk/Fa7eQkXCOkVXa1W7ieyVH0Pco5C2egN4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BSouSivOcAtKQTw5gNZBk1p4npriSdp8bFGXX6By1elgad378G0jyGGaMvE/HMvmpwhJ/syEB7SjaeyaKOX0lUrwLSpJvczZiyNfGJg7wohJebAKnEvZJPyYzP0RRmO6p+DEjj8WdT351ekmYTbaWPrM/D4mLkvdfqkoa7JJdj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZD9IfqIZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T5ypth/H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B22vGEx1090857
	for <linux-pm@vger.kernel.org>; Tue, 2 Dec 2025 07:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hewxWIB3R5yRqjpdL8Ute0
	t9X5WK4bF7onrLh9soNKE=; b=ZD9IfqIZEe2dmAZzchYfrlineXHxdnSZmcxv9z
	5kHN7OYt8dvXM8pnWhXSTcd6Hj6OmPSyGrrJSz2IdLU+ycGlpInAr+pDlo0TAA+v
	1P9S5ycscaVXME8Uh8HEBEeSwen03uhsMvpiCiZLQMH6nMbBKFZFWyg682DcDEqx
	OGMdK+s8vVr/w/61c1fuxoWk3028wjAS40S5c8ig64yBCK/U4FDenI98Y0vRrSbO
	3BC1cJvpBZTlUTyrtlLTPE9aiia9BsU6OJojeLV6zuJg9xCK1H1p0rh6tWWwADMn
	VgHDdyyeADsgiNpQpOiD2Pd+2nc8f3h7liZO4strvqWwvDIw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4asfu129kw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 07:13:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-343d73e159aso9626211a91.3
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 23:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764659598; x=1765264398; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hewxWIB3R5yRqjpdL8Ute0t9X5WK4bF7onrLh9soNKE=;
        b=T5ypth/H7dR1oWKSd4E2PbvjKJrYEKKqfHKI5plfBcwSHlwP4FHt7m8S2b3xi5Cwhj
         GT7qqNxPtNUMPRTASeXREZGIUvk7N1oaLJv8kPeHdZfN0c6Mx1lcyCjblM11nPMmKWEm
         Wxrg+/I68x/LithgRj9/AIxDr73TJ6vaBJjG+/6pgkgiwLilpIyd3C/8etT6NW8dQaQj
         izfwCKyj4vStYZsFz4RY49pTe9n0VV/ZH5IVXLHxG8zBTzUQauWjIxPfifPwTSEcMBNs
         MhmrPS7ZzcbMjxZHs5Gtk4QGSB5KUZdjiupltqlJVzzHCRyHWYoMBL6FTFoiAEORJoir
         Cgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764659598; x=1765264398;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hewxWIB3R5yRqjpdL8Ute0t9X5WK4bF7onrLh9soNKE=;
        b=a0Tu8ARtMRGRlr1fs8WhHczwbc77hoqtZ9QRosul3sQ6zx/Hk5fYW3aL/NEUaXScoi
         Ultnc9v6KjGtqB8BgDuFjtWmAkp34jcGDg01PfWUGCamqYfnJUuS58dzpOssPSsCsugw
         ShgCXxe2gu8QYx3P0/zphTQWfVuc7sfYOHRVQHkobAaxVdSJzbaMxeXZ4l2AQyLwlkjZ
         tVunYZ1kNprr+kT69Kitmz3hRRL75+YtP2S+oCUIPV/yVo+78bfvVB7JhgTC4syuKjbe
         8y+LtIhoQrc8UG2KX6B3ST2oc11C/p1ETK5Mf6K46NOD1Tu4ZmGGLq8N0H5p6qG398N8
         s9+Q==
X-Gm-Message-State: AOJu0YwmxxlCdvF86glEwvaPYiTZO3zZrMV/TWulLkNS4I0B4qZUq9TE
	XPQc7d/hM/wU1jXBdQGsZlWniSa5OsSMPhAqUygxlPfe7Q/nzYJeqRkwhvJSd1nd53+2LKrC1p/
	yOgIdjhM7p07tsuyYVNx5dD32DFbfkj76wl5BTiKRFTEL32+SzxfCOSqZDq7yaQ==
X-Gm-Gg: ASbGncsDwrM4HlgkZjEcRIP7SSrKf4InaOrJU6WvtDzKyrBRf5qGnKUdJI+txUdNJb1
	HeNDZy/sy0tpXzaj8h4csff56WoR1qcnxQ1Hc1V1fgGbad+HbO39P3Jyy2wGQak7pwRPT031Mfk
	3wwthmo4/Zc0V3xnHu0ky6JL4PklsPTUJwNuuTydQNDAVSQtgeovFfqaAWuXTXUeTPnnwZjopHt
	2y5k0wCY3gK12g/Z3+D86pubWgNZgsm31tSUDlGhZHFYrH3k439zQMdxZ/BMIW5cKBWv66xMFFB
	r1eyrkj195iqDNyL9KLpWJ8wFxPR8Su4Qe3IpMxLx/tSR1lDgnJpV7D82NWT643zCyeSeHMJuvE
	CEHsCYmuiUYWNUyLlLtMfBK/8JGcQrtvBJbDAaw9yBFoSm0FZhuD/0AUkEn+r932DvgO0WEZ+0g
	==
X-Received: by 2002:a17:90b:388a:b0:340:cb18:922 with SMTP id 98e67ed59e1d1-3475ebe8306mr30703944a91.14.1764659597713;
        Mon, 01 Dec 2025 23:13:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDuozONxBMeTBW+jcOSVoCypye7xFKYbz8aNGS3md16rvW5c1nNMygoRo4d7+TmHsfTDKKVw==
X-Received: by 2002:a17:90b:388a:b0:340:cb18:922 with SMTP id 98e67ed59e1d1-3475ebe8306mr30703919a91.14.1764659597240;
        Mon, 01 Dec 2025 23:13:17 -0800 (PST)
Received: from [10.133.33.100] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3477b20c00asm15183228a91.8.2025.12.01.23.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 23:13:16 -0800 (PST)
Message-ID: <62eb142e-329b-4faa-8750-2d92d4a37d3c@oss.qualcomm.com>
Date: Tue, 2 Dec 2025 15:13:12 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yin.li@oss.qualcomm.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_okukatla@quicinc.com
From: Yin Li <yin.li@oss.qualcomm.com>
Subject: test-by-test
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDA1NiBTYWx0ZWRfX7LFIiADPcN/b
 i5A9/a2HDLE/W7+yLP0aPA4lQLJRfLLFiU/FdGNClAfcW9m3SwWS85Y5NZZa9GU9I8MvGKbNGpZ
 FgX1IfAcZdE74UmBSBZGo1VizJzbrOyy1AsOZhLrsbIaeYXqesn7MeGTyqZXPgccXyUZ39z4dKB
 JkGje6fTi8SwsN/wDlODBnqAUJG6CJIbR2WHhbah+H9RXwO615zxPlOyCFBF94A+63nsZSqSgX8
 rNvIX/+FHSQRORQya653wmYWdn4F+Skj3FeY6EYjCUmbDjezrlD+5EUYWFlOwjzTM7nxfu8a8qQ
 eXyxFQoJWS9IYhbbavWf6zHhOlyxiG0FmTYCDyUsli9JSFSvLsGfZPKDA9R11CC8zq/at2S1+CV
 nWWrIXHl74nX9nUlHZLULNfigUdQyQ==
X-Authority-Analysis: v=2.4 cv=BJW+bVQG c=1 sm=1 tr=0 ts=692e918e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=WJEcxuyqiWSRgSB5JEoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: VliH5TrS0lT_EgdD9wlLHIMCz6R9EnPL
X-Proofpoint-ORIG-GUID: VliH5TrS0lT_EgdD9wlLHIMCz6R9EnPL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 malwarescore=0 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512020056

Hi Georgi,

on 16 May 2025 18:50:15 +0300, Georgi Djakov wrote:
 >Hi Mike,
 >...
 >
 >> To prevent this priority inversion, switch to using rt_mutex for
 >> icc_bw_lock. This isn't needed for icc_lock since that's not used in the
 >> critical, latency-sensitive voting paths.
 >
 >If the issue does not occur anymore with this patch, then this is a good
 >sign, but we still need to get some numbers and put them in the commit
 >message.


We constructed a priority inversion test scenario, which included 
multiple real-time threads with different priorities and CFS threads 
with different nice values ​​competing for a mutex, to verify the 
overhead of the RT thread acquiring the lock mutex.

The maximum, minimum, and average of overhead were determined through 
100 iterations of testing.

Then replace the mutex with an rt-mutex and perform the same test, 
obtaining the overhead's max, min, and average through 100 loops. 
Calculate the change in average.

Finally we can draw the conclusion:
1) In a scenario where the overhead of threads competing for a mutex is 
set to 5ms, using a mutex will result in an average overhead of 
4127687ns for the tested rt threads to acquire the mutex.

2) After replacing the mutex with rt-mutex, the latency can be reduced 
to 2010555ns, which greatly improves the mutex overhead brought by 
priority inversion and reduces latency by about 50%.

3) Furthermore, to align with the user's given overhead of 40ms, the 
test case was modified to have a competing mutex thread overhead of
40ms, and the experiment was repeated, yielding similar results.



 >The RT mutexes add some overhead and complexity that could
 >increase latency for both uncontended and contended paths. I am curious
 >if there is any regression for the non-priority scenarios. Also if >there
 >are many threads, the mutex cost itself could become a bottleneck.

After testing, the overhead of a single rt-mutex is approximately 937ns, 
and the overhead of a single mutex is approximately 520ns. The overhead 
of a single rt-mutex does indeed lead to more latency.

However, in scenarios where multiple clients frequently access the 
interconnect API, the latency of using mutexes far outweighs the 
overhead added by rt-mutexes themselves.

Compared to the performance improvement of rt-mutex in a 
thread-contention environment, the latency itself is perfectly acceptable.


 >This pulls in unconditionally all the RT-mutex stuff, which some people
 >might not want (although today it's also selected by the I2C subsystem
 >for example). I am wondering if we should make it configurable with the
 >normal mutex being the default or just follow the i2c example... but
 >maybe we can decide this when we have some numbers.

Making locks configurable is not a common practice. We do not intend to 
make changes in this patch.



on 7 Sep 2022 08:15:21 +0000, David Laigh wrote:
 >From: Georgi Djakov
 > ...
 >I can't see why the RT kernel doesn't have exactly the same issues.
 >Given how long a process switch takes I really suspect that most
 >spinlocks should remain spinlocks.

It was proposed that serializing with a spinlock might be a simpler 
solution, but we cannot do that as holding the lock we call 
wait_for_completion_timeout in the RPM/RPMh which takes a mutex and 
could sleep in the atomic context.



-- 
Thx and BRs,
Yin



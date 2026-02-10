Return-Path: <linux-pm+bounces-42451-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MczLPYki2mTQQAAu9opvQ
	(envelope-from <linux-pm+bounces-42451-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 13:30:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAF811AD6E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 13:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 124CF3044B8B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 12:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773C9329378;
	Tue, 10 Feb 2026 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WXJNpCgy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TPSKj3tg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9EE328B4D
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770726504; cv=none; b=upf2RmooIpYcm+Ws1SrHvEFg9nI4vacnEZQTv/9GJUJn/48TyRoryA9q9AgL7cv3R83bqDYHhcfkw+hhnTeyKAK/dL7JmvHoggvljO88klZPRF42Co6haTK2hc/sT5Io2XIfJRFPqdwavYznaUWXe7CDI5O+Jy5Q0GrLdv5y90o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770726504; c=relaxed/simple;
	bh=zxhUhNgv7CtiGH7T3I0KNBO9nYAMyN992iOeA9QvK7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzkRsZPGuhFSShaGh78fwT7S4lA3LYFaUaE6AJyMOCV+RGNFAb523VP1Swqpc8uiCozuXHf5Cosd8WXTIuTvj6kR/+n06E2UhBcTqVtq+/oEH3RGuCcibq790M8MLCKGF3tdCCBuzc9yXagm0Wzerja7i2C4JSzd3Jrvmn7JOSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WXJNpCgy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TPSKj3tg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A76rDC1151603
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 12:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UnhTlIxjfW62WTGpA1O6/UmB
	2s6nfZk9LsddcK1nh7k=; b=WXJNpCgykuagDnnhuTP3Gm+DwatGml2mgURUXd1G
	setFKTrBOD0fVMVYVrdSvVvIn1rQPyOB2m5q1wTyAOD54gs7XzGd6qG2SOwFnw3+
	SxmMytqxzK63DC324E2IXaW/+89CHYn2WT/mwvc5jcnaixoV1HrvKwgu6eSe4n6t
	J/J9Imguzacda/ECNoJ4qnBXnGLeYP2sQy/e3v25b5aSZuS6t3GDblNFhwb0CZpM
	ISolmqRpCouXoz2XpAoFzdocQYn10wHtPj6wCW4JpbcE+uEw6ooOu28aYZQhByVC
	zid/Dj5YUpPvX4pO5wycwFfqdiwimYyjXx/t7P7HGMSWHg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c800j91c6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 12:28:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c52d3be24cso113588685a.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 04:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770726502; x=1771331302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UnhTlIxjfW62WTGpA1O6/UmB2s6nfZk9LsddcK1nh7k=;
        b=TPSKj3tg4CwBa5o3DCsgqleyCY/1dFX+1dMpQEXI3ENt3xyMuIJdQUEozYZpNN0qsn
         ATFxnS7hC/h3ld9Kj4vWs02DFvy30QL6t0/sipwIVMVlTP32JhHhxMe6nOwUm+d4yqlB
         GzYaOmYldLXA2EkUHbZ6VMuTLcTyxwLeE2lzlkGlXemLcZ6ZDR9MCJ+qrE/Br8qnM6wk
         7tdsIOvr5dG+4Vnt9++OQDYJkbSXRhK5mXT68LnNC9D+/MmdYSBZzLVrEEXD/dvL7Xgj
         rap4eCDHelWycGWKqO/xZZb2lq0LwDpMdRtK8lErLy+H98AUslDNi7iFQ8EgUHKc8SYz
         oc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770726502; x=1771331302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnhTlIxjfW62WTGpA1O6/UmB2s6nfZk9LsddcK1nh7k=;
        b=HVbSnC31GB38AHlrJdNfOyhLUDgndvpkzjoZH2YOE150ntpF9RGCS72Wk3lGFZcZuq
         tlOzGFVKJY8CtEIAlq4sUiQXk/gzGy88IzT2aMo4cSCu1vhZgLL0oJ62Vr12WYj/o9EO
         J3M/qxE+N6WGKL2hDScXpWkzWpICbjDFB3pZpuhGo+rVvtwku90k6rbQ5dH0Mwt4AeCO
         KuxjIavjAlioF/ihNJA10snjJW0HMRF+nguRqGc/9p2kDBn1DCQgpf3eh8lPOOMSL5rX
         gJ2YAh67cFH+AmA6UNQ9SmOKAWmg8PLVVZdmOclP75Strk4HW8pbgj7QUDPil/zpY7M+
         Y1HQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9oy7hMjbIOJRQ09haOvvuwiwJVNqZFKtmEUfZz07Q10LQe14VGvRVfxx2PbuEGnLXn4NZbW0LQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHIDi99O6GY/ckc4B296xqVmlSSob9exav+BrQc600RpSa7lw7
	T1ztXlzKDChnT/jNB6dV6YkvBHahLE12DqKh+c4BGwdIixbIdYnzvskksqb9KLPP+EfVRHlVKUE
	fMcvtP0+Le8E/k+c/NwJey2Rz2KeT+R68kmelxyuqyIqJO8FyFCGBOmHEO4WG4Q==
X-Gm-Gg: AZuq6aLZZaYX1GgkQcBQwCjm7SG5Yc+hUI8Y7m0t1OgoazEf7jMLdYRacfO6YcfrJ0z
	e6eaBE4GJGGs+tjg9mC9w9ZQOFaBwa2Zvlxpt0vMM9P2KlC9Y+b8j9dcOuGi+u5I2yCCPEk+iIr
	E2X0SDmqxERXg5WH++kOwB6qj5benavUAjdVezGJ/OqRARoTtzhXxE8bsC1CGTrXQYMPndDvq19
	t6F6UqZmxHpwH3fAjMmoocJbywCId/xUU93bCdHTOOk9Ei5cXbES3OWlYoVgvNbabbYO4eT13qB
	rW2767u2R42WBv+o7GouMNGbf2SFEBX8nNzWDcJcAb41/PkE4ZgCtk1spNmKMUxhOzO9ETkri2p
	Jr2K59+kbPdzKO+jhr5HNg7+iQS7VL5RWD4rh7hKcsIC+UhL3cyL8hB/GNGx4QUHH0LjA32+f/q
	UPZxjcshqGedvbCHkxgPrN75cNsrWPCUOwYnc=
X-Received: by 2002:a05:620a:448c:b0:8c6:af59:5e1b with SMTP id af79cd13be357-8caf16ec082mr1824413685a.77.1770726501732;
        Tue, 10 Feb 2026 04:28:21 -0800 (PST)
X-Received: by 2002:a05:620a:448c:b0:8c6:af59:5e1b with SMTP id af79cd13be357-8caf16ec082mr1824409685a.77.1770726501187;
        Tue, 10 Feb 2026 04:28:21 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-386b63e8483sm34431931fa.34.2026.02.10.04.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 04:28:19 -0800 (PST)
Date: Tue, 10 Feb 2026 14:28:17 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 5/5] power: supply: qcom_battmgr: Add support for
 Glymur and Kaanapali
Message-ID: <esvr4ytgtdrgjg4c47c3adnq7iowzbnoxvlhio2s43dkiuiq5t@l74rp5smkbno>
References: <20260209204915.1983997-1-anjelique.melendez@oss.qualcomm.com>
 <20260209204915.1983997-6-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209204915.1983997-6-anjelique.melendez@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEwNCBTYWx0ZWRfX31Z0HMV+NVG/
 Jh9q173ldvXzXlpoqFXEHadw/6J1cCWgN0y2LeslDLO4/ut2mjtzs12f56lZbtBFt7FNc8tR/FG
 BUHTnNeG6diB22Q9wx3j8pEmx5ageIf03MuF2SW62GKtPXwRhzCWYl8FiPKsO/hVndODWY+XXw8
 vBgXx8YUrE6TUj1aesv/qMyVGF8pzDgfEAviwnJiM9p5n6M99/CzSETayaU+a9XAeZHL1JEt1um
 vbzkD8T8kuZ8VAmI9QSk43THuFrIva1zIdWk2qPugEu4SGq3IT8JJotNozRdzAUZ8NemYG4c9z+
 bYhfC2x5PMoKcoIUvoxjsXrsfSfkWrB9tQCrXVXFgWw5Phtcli/BaQrXICpiP6YF3gVeWUpRZqH
 qYdLZ792/LHz/KN/w+FYybQ9MQNo9G23fednbbO6FFCQwrswczloxf+aTAKF2Gp15etrvF1j/Zs
 vUD0RU3o8aAZPa/i9Yg==
X-Proofpoint-GUID: 5LJgVJKuvWZyoPC6-XrYRQog-z1A3UH0
X-Proofpoint-ORIG-GUID: 5LJgVJKuvWZyoPC6-XrYRQog-z1A3UH0
X-Authority-Analysis: v=2.4 cv=b9u/I9Gx c=1 sm=1 tr=0 ts=698b2466 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=kEueVoIVdGDzn9jpcCgA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42451-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0CAF811AD6E
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 12:49:15PM -0800, Anjelique Melendez wrote:
> Glymur is a compute platform which has the same power supply properties
> as X1E80100 and Kaanapali is a mobile platform which has the same power
> supply properties as SM8550. Add support for the Glymur and Kaanapali
> compatible strings.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  drivers/power/supply/qcom_battmgr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


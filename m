Return-Path: <linux-pm+bounces-43840-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANodA1bqqmmOYAEAu9opvQ
	(envelope-from <linux-pm+bounces-43840-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:53:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 030B1223208
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E95853038EDB
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 14:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2405D2848B2;
	Fri,  6 Mar 2026 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jsoVwVZu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LRdFh48R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E3723D7FF
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808121; cv=none; b=jQOCm9Lb2I4WchWAXLjuzFl2gfeMZ6lWVT5QiEt4fRxbS7C/EfrALhSlNnY37paFKvfKLs4w8y5klN7MzSG9mx7zq7nwNFI1IFp4rrypVWmu7F6mQzafzeJQgmIm5cVWv7VT89xOrrqukZspcN4jlMSFa/J0zIo7jd+jNNU80so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808121; c=relaxed/simple;
	bh=NASy0VPSUsHb2GFPIz3x+oGvB4G714E0Cj11R1ZvjRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILX/18UstrEyvS3PbXMOUJf2Cwpvkc99OqdUQ8GbnfbJLAR0/+JQR5SDAuQ1iW5cDgSo4qmIFYuYheQ6xeebpQRD17NF0Gyg9AvaBxbMElTEHEK3WWpjqx9uHpkvT9j5JT8n+aVl1rCmKwmUuzLn0nGGaQ+0dgnFYkZdGLqIfEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jsoVwVZu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LRdFh48R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626Batov4186265
	for <linux-pm@vger.kernel.org>; Fri, 6 Mar 2026 14:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wqW8LfZjZqKXW43E0Rm88HD2JcpKlLgf6d/w8bXLSpk=; b=jsoVwVZu6gjD09UO
	kW53T9sVN7XfI0sAPqshnOkjKc7MCWPsz3253Q0t90mhJe2Bgg4Z+ucvCs3mo0cw
	6eqJfZR9Pa5VETGOfZP68O2Xkdt3ckFd9/JH0NlkGfOIBuAAT4JkgqmrxZ013jaM
	PNnye7UddahXIUvNKzjn47gp1STvfTAvOQwqYI1Fn+bGQrrrT1NFmvydKsLdkZJj
	IRFyBjXv46LEVzGIcqUwZhNdr19OCxAqRmywWHnSZZEOesnrAmM1ECnH36xYBkz9
	fpYebJneXoQ7p6oGdHN2WHQ7r4hhh4URHMiKXGYVc6Fv7cHSQbUZKqq8Np/u+KUE
	Cy3PIg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqruk9r2w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 14:41:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c71304beb4so1516915885a.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 06:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772808117; x=1773412917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wqW8LfZjZqKXW43E0Rm88HD2JcpKlLgf6d/w8bXLSpk=;
        b=LRdFh48RwwLpAnC1L0Zz8hK/dgcQ3FfISzmv6HudI1Q3BIF79k04uyzzN+H7bP+TkV
         2vInngd/oOjgkrK2aRN+RBsa8uw8YiqsOjw5k2V9PSJcIRRPxOxOYFiEfgdc6/fBtyEM
         xkFB5s9rwU84Ri8V1zehtiknIw5tTzpXcc75L4ekzBrx/KGFrpcGGrbtdnk8iRAjLlQ3
         6wJSNV3cHZtWje1jcTH6qr+Rb7K7O2590kRFhKSnyojsBDOLKN9arTGU5M1oGqHLSOcs
         c/xxp4mhpOlpmTONoVccxxaMDomO+r1Ms7cwSZBhNDV0VwYNKSIWT6gVCy71M31nduL1
         fbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772808117; x=1773412917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqW8LfZjZqKXW43E0Rm88HD2JcpKlLgf6d/w8bXLSpk=;
        b=HxfEZDgOXLzc/7IbADOVVqz3pJrtScnbhju1gOqyhXtJiuMzZNOVMjsvTOZg86w8dr
         fhsM5mtfVE/CkkKp/RL1IZ8FAQ7+ruJxsuJ/yLw4lEQFL8mGI32HNKgE4bw47SpjtNHj
         /YF/PuxFELGA3I82DDgIF088Adg9EZfe50ZTESxguNoWFlSCipwmIu5aQ0l2tVx1kzjP
         2rxDW1kbxjEOO1oKNhpRKay+FJm/ZI5zD/+pmL9v+Bm+6IR2Uz97xpAIw0pvTp6F6dOG
         rc18asZABLZPk/wPF8IIFEvQZ2S5w0CqCCXj8d3UaO28kEHJSMc83dWBmnDSd0e2uX9l
         5bfw==
X-Gm-Message-State: AOJu0YxzvnzyiDjcpLLnNmzpyQiRIyCDPrnSTRzlltciQyqXE8hGedXn
	GPa3uaZqx1EufoL8PVRnS90EXGnAdMIx//84TP5bjvTGhs9vStISqiNOnTiuuxztU9GJw35Fafo
	bwuK0FX9T1/FEV/NfbyZ5l8zTwZfmgQbMoKSqzU7eRh+dnXPCXo2Y1HWeQTGfBQ==
X-Gm-Gg: ATEYQzzBgLNJDnk8ntLFYkUiV1gkIurmim39NFkuqfYVqPgJBM+4wX/mGBnjfyi04pa
	N40twvXvGFkEkVFPUfBtd89meDEcIvzFuzTaKN00Akrwb/7p+CfnaFgHN7kUwiurUOxSLu0NDNX
	cV4dZxL/ImeIxABAX3bd017CGtcCrSVHNC4Z3vQGEfuy6waDdPQUFxeqHm6bSmH8KHPnIP9bDjL
	igz8axFVI/s09PGMUH4o+NpeDzUC3uKWrypD5ovJ7KTB++jZC0qTQtIcwdQ1YbmfnbpLmb1Qddj
	GsfznRNk2mQhnIHGs/QlpWbtVGE6TmJTvv0e8geCoVYS1rLWt7RFNuTPOKaBJUiQKVSoVGcgb4W
	5SrQwzkfc8KoieyAUrnOCvqwt1HqRe8nWmnTdKibtA/LX4T9tFH4gI0ib/z1Ne99z3sRlxg==
X-Received: by 2002:a05:620a:4482:b0:8b2:37ff:de74 with SMTP id af79cd13be357-8cd6d3ab314mr304071085a.34.1772808117437;
        Fri, 06 Mar 2026 06:41:57 -0800 (PST)
X-Received: by 2002:a05:620a:4482:b0:8b2:37ff:de74 with SMTP id af79cd13be357-8cd6d3ab314mr304067685a.34.1772808117060;
        Fri, 06 Mar 2026 06:41:57 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:1265:158c:17d1:c76e? ([2a05:6e02:1041:c10:1265:158c:17d1:c76e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae56300sm4086478f8f.37.2026.03.06.06.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 06:41:56 -0800 (PST)
Message-ID: <8700398d-5038-4f2e-b90b-6bb2474fa3ae@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 15:41:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] thermal/of: Add OF node address to output message
To: Lukasz Luba <lukasz.luba@arm.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20260305163508.2643106-1-alexander.stein@ew.tq-group.com>
 <245c2251-9661-4d49-b2a7-df3027059df5@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <245c2251-9661-4d49-b2a7-df3027059df5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE0MSBTYWx0ZWRfX9EmYeVKucmrC
 SIOqEJf9l0DQD/Y4j/SmfOjxRjt4dsa0DH40+4339fpHxJa4HXXpgiCkPWcUOIjcvPYUlxEfBVg
 YkUaTE/oNi6RA1oZJwmGgp3JhcpoagGEOayQuUy465hpwhHuWnp6qreA3tAv56e/gDWY1/0B+Pv
 zg9QDvgI+4zMXUt9MpYmhQL29n/N4hMQIs0/KQzrGO0UZ8J3x23XmvDERtZ5/JtsU0f8fTNFOGw
 CypAFw+jg4olHjiQJN7pJqJq8MVEZoG0itasSDXHM04Mbu9gHJPprR2BXBNz4y/OIQfFvHBjjRC
 uT/ptv+d6LkD7m1h72gj9egs3uCpEA70EY/MFB104Yn+j8ZLpLDvdQX2YPHoq/GqTNqTHnYJsoX
 /xkfdcBrU3EyHWZjuLAoPYW/L36IOSK88kyDJii0wXqdzkEJmhthFr042bBW6dhPlSxxl6HF4PZ
 sPdV7T5Uz4xYB/678ug==
X-Proofpoint-ORIG-GUID: HO-2x3bOiydlIoboTZvxu8QTZ3IDHOjN
X-Authority-Analysis: v=2.4 cv=DvZbOW/+ c=1 sm=1 tr=0 ts=69aae7b6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=8f9FM25-AAAA:8
 a=7CQSdrXTAAAA:8 a=K6kIHia4eJZNSrA5Si8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=uSNRK0Bqq4PXrUp6LDpb:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: HO-2x3bOiydlIoboTZvxu8QTZ3IDHOjN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060141
X-Rspamd-Queue-Id: 030B1223208
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,tq-group.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43840-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/6/26 14:49, Lukasz Luba wrote:
> 
> 
> On 3/5/26 16:35, Alexander Stein wrote:
>> Temperature sensors are supposed to have the DT node name
>> temperature-sensors. Having multiple ones the node name alone isn't very
>> helpful. Add the node address to make them more distinguishable.
>>
>> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>> ---

[ ... ]

> Thank you for the patch, LGTM.
> Please add the tag and send the v2

No need to send a v2 for a tag, I'll take care of collecting them

> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> 



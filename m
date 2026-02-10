Return-Path: <linux-pm+bounces-42424-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ4pNdj+imnJPAAAu9opvQ
	(envelope-from <linux-pm+bounces-42424-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:48:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3560A119136
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63A8B306B4ED
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 09:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE7B342510;
	Tue, 10 Feb 2026 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jr53nrQx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RFmbKYY/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A5A34217C
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716739; cv=none; b=JWE++zE9ct9jTZv1phGywFTkSph/kj7cPOdya4jz2DTVQRb/DyRcDyqN9s2YW0FoGwtDbgo5kEq3Tt/4iF2+DrIuNZxfkcF4d0dOOFi1gd9DOvB4umNwSN1JaIWp/sHAqJ/k4MiidnzKe/crHJp/JHlWUvAJKftObDxrty2ncp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716739; c=relaxed/simple;
	bh=lv7KlrnCejay2buvdXi6pnHH0RiwuflO/iJK5ExEMzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKSpL8jAFsxIjmSmxQzx8bcPQdmZnABPLx8STnpIGmOM3gk47KblXpqgEsZb/g2CDqgBDLZ8uH9Z8p/AOzrVyT1ecjrS2YxQafvytjfe8aeNeMLPj3lKRs/MRdtgzIb2wSZtmu4g2iUUJz5DrNU1NYYQfUfa7oYgjVmQ3393EQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jr53nrQx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RFmbKYY/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A3AmVA4101763
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zaPD6PuzL4nHx/o54FgD3qxJFfF5Wy40l1l5k2oP6og=; b=jr53nrQxD5aBHtMj
	/j5r+VaKik/6bwjXcsaM4fboRJfkX6MzePBAX+6/Ty1K8EWWB4nIyKMo0Ghicfkk
	7cYc+TTDzGc1ua2TM0vUXQDz8xIFGY+5P8sAzPuGZR9rssLy4w1GH8AeQkSRu+oe
	lJ6BuXrUnsanD5XifHhw8zqGpFF3rfAhQkf2wWnjsOo5YDNktEk6Vj1e37S0zVIf
	KYPxrCvHMkaOV16trPA2mdz+2+RT7uhkMRALSJS67J5S3f6IATiOpFLJ4tayQpfc
	A2XZ8coM9xHCxeKhT1gsfCn9DYtJ6NUGPLbqIKbeY8Te8CkDDH3STL3B6gaFSGZ4
	d0Sv9w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7k61k30u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:45:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70cb31bcdso105796985a.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 01:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770716737; x=1771321537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zaPD6PuzL4nHx/o54FgD3qxJFfF5Wy40l1l5k2oP6og=;
        b=RFmbKYY/F2JsUKRMdv4QmESyukFsMUdGYaqP/uYEfNexsBEo37hj+jROba7aqML7CF
         jnQopQK45atcNJpvKfodyRLnlxRiMbGNQ7xftcBHNzsONfgpG5ycPGgzkYYM/LZIoLZU
         i7O2CsQJhU95M4EpTzTJyG1tL9aiJLqU82thFQFeE7eGvBxXT11EzfKWkHtQSu4Vu98j
         m92y+UPT8EQbiOTjp6JqV3ePHHNl16JS8dt04gcNG6LN4PpgfJZ2VIt7tpE9QBrQaC9T
         JjFtW41jzKySOgVcCTzesnRrvFBD5YYan4rMZieFhx6CRoT4gjtrImkRGqgpYuABbABw
         PdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770716737; x=1771321537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zaPD6PuzL4nHx/o54FgD3qxJFfF5Wy40l1l5k2oP6og=;
        b=volfho8p30CU2RJhtfR2JFnqcuWJlAJa4+Vz/T5o63v8kLU5wW4yD1yRyFfvm48NWf
         lltCwkq7Bd5RaOMD66f6iaY4xGNAKA19zk8JaEckZdOO4drqvW5J1RTRP0Y5wPyHypS/
         QZxrE3G/XF7DqNmrpSw7t/hxJt8/dmVF8ivKDySLE/JFvdHcM1wAW0PRkmzz8xx2CkbK
         aMVB/txRCX2tvwbN07Z/QwWMc/OqMjCVGIurVwBLXQ/eVjAcGpzyUDwBXavEZM7RcLk3
         veSE2d0YvKpaHqYtNWs2Omvzrq3QmOK1YquVfaWHe3Ekeb4KOn9xsE2IGTZ8ccITbyVq
         tSeg==
X-Forwarded-Encrypted: i=1; AJvYcCV4avJ9L8qwEn7dtLEKjJhHflSwgyyAvu4YpXNfeKmIemPUIaFiZEbydltWxMoHr2H2sKOUIGoq8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ingDfRi9xtsdZ4qPP2VO0wBCiEDmlt7hPktRDScTEuMEkrTe
	YQHQVp3l9oOMV6OoynEtgnwoLpPQeQdw4vjBeUySo3tOnGFl+W/pB9FH7P15yQHGVeli6WBZpyb
	SsQD6YABEtqoDMzo7WxIzSNJ1DSOs0Z8aYJbVbyrSbUXHJKpMDN+HzkY0tuGL5g==
X-Gm-Gg: AZuq6aLoGDJ2IT3FQUjsFnghSaGsadDkp2MlPFeS4ORw2Tm4tcJ/D2arbrNd7wcLczd
	tfFE7tUiWqiawhXlwE4WpW6a6rIXK0P5dZA9pZ71xEnQ0lrKb2YYgj6035TW51IokNcgvkXG7Ox
	K0zqDCcULcNjakVvT7bdR7Zz5ioaJwjcVZbYPN8n9gY64Pb0jK+SAjL+QIUoor9dpVLpTf39o7M
	9Bai71Mx2cJ7Zm3AHXC1T/7J5L9E0CUFDN3Dwp36zPAcH2jhZwbAyKF3/6lWUOgbGS4B5MlZ01W
	eI6nwEnmLJZ0/z2UU3//BZxgl7MmNwxWldS4GqH0ixBpQSBT0p+vNny2qG4FvOihrzSskBOuHNV
	fy714kE/b9kggpueDHHFR/fel4gVbnhc6ewAz8SC1gZ9Lr0Ac7WcaqTzi3u3Xd2hh4uK6XQ6S1n
	+Wg6k=
X-Received: by 2002:a05:620a:29d0:b0:8c6:a719:d16f with SMTP id af79cd13be357-8cb1fee43f8mr114784885a.4.1770716736762;
        Tue, 10 Feb 2026 01:45:36 -0800 (PST)
X-Received: by 2002:a05:620a:29d0:b0:8c6:a719:d16f with SMTP id af79cd13be357-8cb1fee43f8mr114782585a.4.1770716736336;
        Tue, 10 Feb 2026 01:45:36 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8edae6f7edsm502779166b.66.2026.02.10.01.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 01:45:35 -0800 (PST)
Message-ID: <4d76a2dd-6ccc-4918-9e6e-0152af57c917@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 10:45:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] soc: qcom: pmic_glink: Add support for Glymur and
 Kaanapali
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20260209204915.1983997-1-anjelique.melendez@oss.qualcomm.com>
 <20260209204915.1983997-4-anjelique.melendez@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260209204915.1983997-4-anjelique.melendez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=M8lA6iws c=1 sm=1 tr=0 ts=698afe41 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=8hPSHKJayuMM37MLa0YA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA4MSBTYWx0ZWRfX2Z/jwVYagpKh
 LsLdK0Ve2dvwY/GW1Ijm+Z4k+/PLPT7B9rDsJGu0x2l0ibJaEqwmClmq/Rh1fWwwqQ0vcLCl/ll
 l9Iqwt5GfaKYpw4S6h89mPrJCiHZPYKJ0tJ1oD3YZEvUDj3US5vSmPk5FM/tRWqLDKIW0HvwBYP
 WQ80OfmIOF4Xk4FwA/pc1M4xOrQNQAk7b+hT/aRTpDkVoygvhJxMyYjL6zAYwnecBKqtbxRknCw
 LJ5Zf8IFsZyWYe2WNW6LFNWILu7y3O+bhexVWC4h4vlzQnaeCG0WLObvENUs98zUCtgZDwXDb/m
 WdkQZpwMO0jKr5q/3MujMQtdC4hfOTV2ZeNlml+yBG7oLxxGRL5HVfWB59whODTQ2FRup6D8Ly7
 mIV9/6aYKgVtuJ9WAcb33jonIqG2nGXaHTJ88+ZCU0TGYDG+LxdyczZnisFLAx7rKE2XG75yBG3
 osiTIQr/OnwgFG+151g==
X-Proofpoint-GUID: _OFwVaDL2iwVILrCO5AdB9LNZMPnEyBQ
X-Proofpoint-ORIG-GUID: _OFwVaDL2iwVILrCO5AdB9LNZMPnEyBQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100081
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42424-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3560A119136
X-Rspamd-Action: no action

On 2/9/26 9:49 PM, Anjelique Melendez wrote:
> On Glymur, a compute platform, and Kaanapali, a mobile platform, charger
> FW runs on SOCCP (another subsystem). SOCCP does not have any specific
> charger PDs defined. So, add support for Glymur and Kaanapali compatible
> strings.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


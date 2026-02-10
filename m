Return-Path: <linux-pm+bounces-42427-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEaSJMH/imnJPAAAu9opvQ
	(envelope-from <linux-pm+bounces-42427-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:52:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E704011925B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D5B1307EEA0
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 09:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B329B342517;
	Tue, 10 Feb 2026 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h+XCIrJz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XbZk722+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBBE2DB7A8
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716960; cv=none; b=tdIqHUhTaGyamCv1ziOuVYervTLgi4tsgI8aW+5V6zHui9N2bLkEZwuENUdzftr8wBlqB+QU+x/QDZDX6vxLWX0ElcmDz1NE91ZnkLXU3ia+bxQ8xtQqzhh49rWoywTyJcXtYlezy85YR1+Rn/9rvP40xhlhSlxgXxdJjgB8OQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716960; c=relaxed/simple;
	bh=VOyKj+x+EF9ytp2h/AeDDqViNOHSWGswmkyGJWPK4xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hy0/sHlIqCF/+AYtFnUxRuXZN0JUWVlJ9E2DnFF9LFZeB5Xje43SP0ogx0abtkmNXlq7cBXXnxyru+NHHNfanvh/NvNM4pYGb4ppXLrEdVIDgLsxKpeqCdRpWM+bC69Y1MAbyjKlQratqWRPOi1A4+EVqc7QszEOCEJv7uwr9rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h+XCIrJz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XbZk722+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A3lwJb4102801
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B6o6n9g1es6JXwo4ZfXOysqdCRuWXP7Xh3RFhzD83M8=; b=h+XCIrJziNpDpgml
	BxIWl914yIE11YaPabnEHrSf7RCersfHp8SsbBF8iQu2kNMMjFG6pHuCP+9N7Xgh
	9yC2hMhJ2ZzHqKnPVn2zM4LFI0zVT55IgvWFV/jbg45OIIAS5TDAAC9zLneEYzWf
	Z4e8IC08poXzG6Q1xQddPBj4deu/Irpt0+xI5A4hlv7aWxzbzXetxsueyi1Qsoor
	Aa9VQmWB6IdSFlajYDyltTEJmFsoAJaavGtlv2sEGGsQANQp1w75d9vkNSyre4R/
	3wLcHthEHt5BWaG/32OqJKmt63ALjRH0LN7Regq8kszmp0Atze2/QvTCW/iZ5zNo
	0zz/CA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7k61k3ds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:49:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c52de12a65so94878685a.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 01:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770716958; x=1771321758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B6o6n9g1es6JXwo4ZfXOysqdCRuWXP7Xh3RFhzD83M8=;
        b=XbZk722+/TMZQrMgJzQkdV/JcHXaTzXbJHnCw96AiAD9lFwuK8+MGBoY84CTxoJIbH
         MmrVIXCVRQVVnoJ1l5F5zWCIu2uAyjjHR6rvyUjnY2jsyamEs7iOXCuKyFKABkvkfPqK
         NmCO/pSdS50jmWjhWAYVKJG1iZt11OjAynVJYSxzbAnsXwZE2lL5pREyi9efu/YEzDyU
         Y4B9V3YJI8wQANypEOmc8aJmL7fY7GQADN94pRyyUkmsviQXApvfPnNyR7ff7d5omjiF
         ndiRM6M+/KHGjQXlN/blrNLiF+vVwX+Zoke4S1irl9lFpnHAVM76g4J2QAggYYs6pPRs
         rOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770716958; x=1771321758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B6o6n9g1es6JXwo4ZfXOysqdCRuWXP7Xh3RFhzD83M8=;
        b=PkLXJYCIvc/WPahTK85I3e+IxDiewjUPSTLOXgtjnYfNycBwclUc/7u/rIAKaSM8Fg
         cxL7AWW3UEVbayqfhkLPst9mfK5zF7kwKclExPw1Gud7d2qTnACZ/MWP5sZFmF4fekkt
         0Sbo4p3gCqMZoh57V1Cv7eZzt1zmVtjHCT0+YU6dhhFYQOlXRkKN9WD5UcPnk8Zi8grd
         jltXm0R+ma36frNAH6izIn9cxsGtlyN+2jJ+96jO3OnEWoDnSaCP6uvk9Z4Z5xGRTb0k
         c3D0DHqPliml8elH/OC748b+XfxchtNJhz4w+Z/svHPd5TWXwrKKfay5iImAq4l3DoD2
         oG1A==
X-Forwarded-Encrypted: i=1; AJvYcCUyNY9igAOOorPcVfJ6CodWtvbrUWRj2TGrbRamDuhdIrM2lwhWTjNyPTAKjOsvk6eQl45BTACklg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUbMf5LUJJ2RgNFc41fIuqGJnDygCfm7oAX2C84E76A6ORTIqu
	DQY4TQ/02Mzhtc++EatNjmoDuXvkzyj33/r3QOLa00SXtqpsZZ0xLMXgCXffut+QqP2MHEP2LKH
	jJ6tRuzx6qNGGtWFdHpCpIgIZDTHyMqBFaAB5QLMuIElsfXRAq4LxWMzX39sWUw==
X-Gm-Gg: AZuq6aLkoKX3ekUXrCyEg9hKx2P9RtWmHo1IgX9oLcsdRLHLQ/HUULh/qhOXhr0XIgB
	piCfz8S30ftpaxJPH2zdnTn6ukGBE4KLoi3msK6BInSkvENGDQ8IeOl5XieRCXpzW5auG6RRBRr
	/Tmd91u4D+MSwg06QPBs4+90RcftjFYIvj7ci54PHxDW9qS8DtGaha2U5TeuM0QIF1JrhCradKe
	Mak3s8TxQQLBHl9Zf/w42dR8rrttlD0VZfeVk8fwM2WUWzlqw3PCSsYIcReMweWJMeoSzI5DOa7
	lzZwnNfI9DTJ1JavsXymgkt1LOt8LSbKnaHyiSTC3eDfLhkdHPmMMGmT716wqN1B+qRKxOoW9Oq
	97HH9ir7I55tFe1w9U4TghapcJ3opSKZSF7BVGYskN3Bb2BpNLrFoWAqmqkKVHi/fJrZeYUrYXN
	tlJL8=
X-Received: by 2002:a05:620a:1a20:b0:8c9:ea8e:c55a with SMTP id af79cd13be357-8cb1fed996bmr111451685a.3.1770716958021;
        Tue, 10 Feb 2026 01:49:18 -0800 (PST)
X-Received: by 2002:a05:620a:1a20:b0:8c9:ea8e:c55a with SMTP id af79cd13be357-8cb1fed996bmr111450885a.3.1770716957634;
        Tue, 10 Feb 2026 01:49:17 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda7a6d09sm499807366b.25.2026.02.10.01.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 01:49:17 -0800 (PST)
Message-ID: <fca576de-6454-446b-9470-ff71fddbc7fd@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 10:49:14 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] power: supply: qcom_battmgr: Add support for
 Glymur and Kaanapali
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20260209204915.1983997-1-anjelique.melendez@oss.qualcomm.com>
 <20260209204915.1983997-6-anjelique.melendez@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260209204915.1983997-6-anjelique.melendez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=M8lA6iws c=1 sm=1 tr=0 ts=698aff1e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=kEueVoIVdGDzn9jpcCgA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA4MSBTYWx0ZWRfX+jAlqVJ22Z+V
 dvb2jU8V+cmXyIdeh2xfybulX5EvT3nRcdu0HCVl0pECuyPPB0w6+hF3bicSULT3HV6oIrH22IZ
 uW0QYrwwinN9O6OWDuwBwQJ2UquogiiTHSI9yt7kDn/ni4P1FOUYc/t4lZiVSpQ0P4WjWUqjSGQ
 3EJuWMl0dhBbGgnaSQyr3s5RIfaFlITceGUzRlC5Kdh1hxeW/COMlh2pchVi6r8/RFkKu5iy0+M
 rocC0fowpPg2UK8rXvVjvRRQugt7oE5UUmffLGKxujGzPKiB9VBSqJbZ/NKsa/wc2T4Zrcp9fl/
 XwaYU4IXRN7KuRqXLqrmaPXVdlD4Vlr1OGNXDR5vPrhhfEOfTvkaE8/1ubZaB3AeOUJjovVw9Gi
 htOz7Bb/+XMAtvwGpZc+Bkunv8ALUgKybU2R4D+G/ShKaSAmjTqtkQ3z0b9MA7bVhSNdf+9hVI2
 JZ+3OWI9Nqq+LoG22YA==
X-Proofpoint-GUID: -rOU7-lhXwBgoBkQH6DVVrVKnOgc78PA
X-Proofpoint-ORIG-GUID: -rOU7-lhXwBgoBkQH6DVVrVKnOgc78PA
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
	TAGGED_FROM(0.00)[bounces-42427-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: E704011925B
X-Rspamd-Action: no action

On 2/9/26 9:49 PM, Anjelique Melendez wrote:
> Glymur is a compute platform which has the same power supply properties
> as X1E80100 and Kaanapali is a mobile platform which has the same power
> supply properties as SM8550. Add support for the Glymur and Kaanapali
> compatible strings.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


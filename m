Return-Path: <linux-pm+bounces-42617-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBuXODxVj2lqQQEAu9opvQ
	(envelope-from <linux-pm+bounces-42617-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 17:45:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F96138585
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 17:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C05363036731
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 16:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12C33644AF;
	Fri, 13 Feb 2026 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YJPBi3KU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R3NE5fTo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ACB26D4C7
	for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2026 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000981; cv=none; b=Om8Owr/i2tCeNgSrBo9Y/x+lqNubm6KXMhbnP2EBXlQR1MmbQ9VPkaMWa//NqJDQmPg/dMbazRf8+LPsbk9REUC7IEjBS6CVl4/nSVRB4tcpfCCY3uBiu0vnWRZLrKkjxCMrU63Nwg97SNpxHZZie83qOO9OKAAyBFzIc8QNIVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000981; c=relaxed/simple;
	bh=RzlTtwDWjrDJzZilWWFNg7OXghugjWlOh3M9/Ztxbvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYGuRZfgKmwlo4LRF0WRw22cpA4+tsrgblmKqQk52H8pYXP84xdXEYirS+G5AIO9X6+OySHMZhudeQOv3OiNVyhoieuK4gyFJWUB/Bu1AkBJyXsa+6xcUsNH9zGg36uwfRxSpZpeEdxyBAGdOViWe8jGsRWhft8ZcuVD00U9BxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YJPBi3KU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R3NE5fTo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DFMSNr1642023
	for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2026 16:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lewca8eB4Pjse1/UPMFuP0dK
	n9xZNN2Qlj2RLnTN4sY=; b=YJPBi3KUdNNsDWljJriezMxxq5TZIMx4buD8/6Cb
	bl3ZUfde6HIAscRjsgEQz4GmSBrypTKVIcTgONW1L2wQLPX0yuGyVIGDBd2brR2K
	IBaNnyOxFZ2GvOCKU84IxYXMekk1ILMj8abFhQSYDpt7PflzxdM6AkozFtsfF+Cd
	V/knKSbNfx5jhu5MAWtxhZA3ISLxWhXS2mOfjuPfbtDXjQcUug7EzWX95BMDPTAh
	Y/PtnYl3qLIQu1+PPDW/I/qih+6r0PoRlVK5UzA53osRLlnCx6NXyW21+/jG2alQ
	4u7vkjDHa0XMbJjimz5rhJcsjg0vptXxmP8nOJHSFwoT9w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9ptv3ps6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2026 16:42:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb403842b6so400536985a.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2026 08:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771000978; x=1771605778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lewca8eB4Pjse1/UPMFuP0dKn9xZNN2Qlj2RLnTN4sY=;
        b=R3NE5fTo0ZFDh9CGeIumsSt1rX8qIaH+tsUe+rsgaIy+l9rDfXcn+SrYnaWv4nhBn1
         6Ys7zEzzcuwBWj43aiFGdFzYxxpaK/qDq3k8y8GWR1BTu8PlrVt/X+d/di3dvYAZBw2Y
         1ZX5I5LPIV30MJkwyK6R3GScmcXEnoold95M0PzrGzuNPMcxxnHus3PnwzIGeSn+gFIB
         NnHJEIoSn2DTcsXoH0mJDEsZewcULvRzx5RBNbVw2+iODaHE+DXXTezrrfX5+3ybh6g6
         XTIPzxTULqO30QVKV+OdvwzYoZ6wKouTw+LvA0iv2Bq7kcOG0a1s74mhTw+2RD0zLZY0
         Wd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771000978; x=1771605778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lewca8eB4Pjse1/UPMFuP0dKn9xZNN2Qlj2RLnTN4sY=;
        b=GmPQ65X32dfzvUlUPTf0HFt2Dx+UGfSpXUtShHO43+TQz2Az8KMJkbmeuGYnwTk/wV
         2kRt/X6yOmTQocPDq70OdTASXVtdhnhKdXAczBUEDhbYPva2uj+UnW5RDmTXjgtS/VMM
         XvlsqlWG7z3aCsmICjr7QZPr9swp0MAnT5LtuXYfsc8r6MQCg+NETGXLxi8OqHq55/AS
         DRtV4MANNjQdClarDI92l6c02PjXy0fT1epEsfL5E1SeWdlR/fMlYLunVHlXLl1s2mDf
         A/BTPl9DNcJLznDMqZlEV0t5WSThdet95/8Q36p2NBZol59lio/9QJ/Otq9TRuOu8i0P
         zSng==
X-Forwarded-Encrypted: i=1; AJvYcCWPFU3qkYPE3fov7jScdsThHyFmH45R68iQf1Q6RUDmMMulO8zLFg6XcbTREkYC0jeMZ0O4+drjMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh1AN4GGcTr9fB6POvewu/PxxFyOZrXqr0V3XqDDjWZOYNRI3i
	yYoqF1YHdnXxZ+HxU4qIXvN7gvDSj4G4kmpkSqf9SExiLNZ3pNUovzkIgoBQyVqA/0TsZRd3KQg
	dT7U1wBw7gr74Q5xmzlpUbrtA0HPhSvSdYAO5xf0LCuJHMC605CxBKM5YZ6i7Gg==
X-Gm-Gg: AZuq6aIjZiUsqWmjfz7/+z3ztOCNkxoYMO6cn4JvHu1lE4PnPagZbVE7R5mytx05Rd4
	U2BlJE+3FdL0DVWQMUrNhuSDTJrSgJy8oEsiWq/aB62pAAhnRzOYKJB+o0rhMSYW9Ms3Ybb/eHt
	JYHy5YugE+AuKi1tMGfm5PmnwVSCb1T6HlmX1RjvvxIohYOLx1jy+hSVgzYTvjbncaajj98jQhn
	8RbOfHTw+qO+6BZpqAE0DpqwB+HJoLTPHFdfA+xg7Ci2fNhel8flrgsfqe6tdqSYRFVvta+Duiy
	F39gL+t5rIUbQGFMdKSTQ5N9q1r2gHBTEaE5NzXABRFoolZq2z6ZhuF65gKpI0hd3/6WS+h7WHC
	gpfnjRG/SxIxnfiQzyui9r+V1rNRsQ7yxPCB9YtOxIMwusGH0ekMBHdD6ZctfyypydDp4DRyzCs
	+tQMBC1cM5OtOnJ38TPQPjGDB9aFcFyHGy+f4=
X-Received: by 2002:a05:620a:1725:b0:8cb:395e:2b3b with SMTP id af79cd13be357-8cb4229e84bmr285192485a.35.1771000977980;
        Fri, 13 Feb 2026 08:42:57 -0800 (PST)
X-Received: by 2002:a05:620a:1725:b0:8cb:395e:2b3b with SMTP id af79cd13be357-8cb4229e84bmr285188285a.35.1771000977496;
        Fri, 13 Feb 2026 08:42:57 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38706928d9esm15367641fa.42.2026.02.13.08.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 08:42:56 -0800 (PST)
Date: Fri, 13 Feb 2026 18:42:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/3] interconnect: qcom: qcs615: enable QoS
 configuration
Message-ID: <3uk4bsce7lnxmd3ryhutatzgprwze27d7zspaqybxc732asezz@uescff3ohule>
References: <20260211091112.3285626-1-odelu.kukatla@oss.qualcomm.com>
 <20260211091112.3285626-3-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211091112.3285626-3-odelu.kukatla@oss.qualcomm.com>
X-Proofpoint-GUID: 7vGwA2PKN_3twX7bk90WN83YPGdydaF5
X-Authority-Analysis: v=2.4 cv=eaowvrEH c=1 sm=1 tr=0 ts=698f5493 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=Np_ZfMqjrSSXuD8GcM4A:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDEyOCBTYWx0ZWRfX45GB06UXOYVZ
 t1EsPWIVSsiBlhvkhZtlOo3hsiwg5E88voGH0lhHpUKPHKHM4oNfpPyExpgLI+7b7f2xZhuMQxu
 Fo5VhVemyeKoX/3X3o0BeXsUHSJnymgfgBuBTE2x5BWrLZWpQb4UvJGl6U0FlOu7fsAWHhWBaru
 CDuznO0oT4ne5A0xesbp7RK9cnFwF5qjuKA7cab0X6mcLA1WxqrvdHUQgJQSRzeY5L/xi3S3ykf
 U/ML4tAWqFyp0SJZflM3bh0C5eQBc3bPexzUs1Cmj5SmxgbJL/bgMeudgAz/RAU1+KPvKEfrIZP
 FqBmvHGSIHLOvZW2NU+K169T7jqPCCceg0W1YaPgzdrqHGH4BQM0mNgrl646/hVnYXuYgFbED2T
 LlSeHkDceUyBy5Dycmpn/IsDn3Sb2E06uJ15oRAPfiudqOiZxGRmlRPq+XcBlGt5honQa8hXlRk
 cfZ6RTAsX9UKC9hJGeA==
X-Proofpoint-ORIG-GUID: 7vGwA2PKN_3twX7bk90WN83YPGdydaF5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130128
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42617-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F3F96138585
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 02:41:11PM +0530, Odelu Kukatla wrote:
> Enable QoS configuration for master ports with predefined priority
> and urgency forwarding.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/qcs615.c | 247 +++++++++++++++++++++++++++++
>  1 file changed, 247 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


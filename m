Return-Path: <linux-pm+bounces-42330-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A2JJcqpiWnfAQUAu9opvQ
	(envelope-from <linux-pm+bounces-42330-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 10:32:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A2710D96A
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 10:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 133493005A89
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 09:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9946F3033F4;
	Mon,  9 Feb 2026 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JG1NVmS6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b1zs4mCX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F31258CDF
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629572; cv=none; b=hKkkKsZn0akkpslqyFB6oSAYZ88NxY9uvd5l3sXJyPx08f6rS9ucC5ikNmYwSHjQyDSCvvTFnu0JTH6vdcvsUsZHVmTQra0GAT7SBvGJcAzfh2S2X/wKrgQ612/I9Yq8cb6c/vGISyfgguQyiuBmEVWC/YJALDkCcDAD2N7wq6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629572; c=relaxed/simple;
	bh=Hdi910HFqleyho/0LNxF5bHKE9axhmJlEnJbblZMVWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gG46tsw5DJgMd6ITbPbUCdsU8JkXhBXKDyrwqMktDeI3xXR/V/d/2VFna5aGERniiXPOFs/KzLdQpPMH5005AmvFBF6w5dHbytoXepxGsOlFyhxIft8qmBfqSLuTfME5wk4jayDUyuOS88nTGoHL6ZXgVtkJq1zBtW8gvpjhN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JG1NVmS6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b1zs4mCX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61952pXU2587029
	for <linux-pm@vger.kernel.org>; Mon, 9 Feb 2026 09:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I6YucMfrpRJ7vgjPDMumqARQsX01lNiuJz7+AKjcNAE=; b=JG1NVmS6R5ZjDs2e
	M9k5uBXIQfv910kcmfB5rM7uqrIeCs0j3sg2aDYfZTdU1X61cB2w7ZgGQ5EwO0x2
	GQQ0RtgJECofrmXXHs0OBpfhzr95un9UWivtGQ4qHARZSj+LTQlTvBO1wWRcxRl1
	ywMOCmORkcie/eILKLnCwffI8t4j1IQou8xMmDvWJQXHhB9cfQPrS9j5bcxTOfWV
	KuyhVKY1O7gYCzU60sDU8eE7CX5doop30sB9ypZRWYI8mnIIwb4BZRif4AcACInt
	qI8KXw+0RpMXjDMYmL9lfL8Lo43rZ2224UTt5Ckzfp3Ruv36lW0DBotDytLW3fMB
	1QgJOg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c793bgw1j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 09:32:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6b315185aso1335657385a.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 01:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770629571; x=1771234371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6YucMfrpRJ7vgjPDMumqARQsX01lNiuJz7+AKjcNAE=;
        b=b1zs4mCXJtDY++w6CcWCM916TM/DqAHr+v09/sgopPatPNMoNjeBqJyUl40nYW9wdT
         C7olDE9NAmzsGtXJV4IHn1DQEk00APxlmKN/9uCJVNX0uRa6pPRCXn13gUJjha43DQOb
         AqHt+IVz6kK2A8W90SA4qFLsuy7AVQVWhUyRubcji7lVho3urKyeTW9D5R/L7xeDlJeM
         BY6BHgP3NsGjB1n2pn7yG9CE46ooMnislC2eFNFoTgxo2PoX3/EK+CmqRkLw6tbBh6Pk
         GdVgkcYfDPTicDlk2dLJVvxme29InMxeVCGq7JYUEN6B0QekJXV6xAiqmk3mY23+ipNz
         lvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770629571; x=1771234371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I6YucMfrpRJ7vgjPDMumqARQsX01lNiuJz7+AKjcNAE=;
        b=glk2AEahAYxMzVkdQhz3q0HjHB8jvESr4ueaVBcw/DKD7San5Fg4CrjXNjl9G8uHvk
         952SIEUTrHfh5SKsqSi+vr+o/Ms53N/SuelcoW3OH/qO8a+Bgrc6JkAYq2g0h0EBMeLw
         r6V1Zp+/gysthPi1ZQY9PuJ2vOZzANjQrHYYZC44g/YF+pkjBpgpG8740vpHqRhUKQjp
         gdt0ICtQK9PrRw24MikPp2si4+JHNLdIgo9y2BPPtPmMJVTYyw0tl89jNFfq6t2idRA6
         5W/3CTSLTZjsvanOxaN6XfOzug1zDdCvipS0O63EspE8sq8r2NoC/iO430Gt3ysHrNb9
         df5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXf1czHdyceR0864zzHH3X0lVHDTHVvbZzBU0zRlNPwvnifEvyKkvyHluc8dINiAAGaX8eUssleQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxvpmp01JelZK59gjpI3+l7PG5most4AMr6OtbSNpSJYNEn2oh
	rFeN9beVLbFITGIsIzS7LkO9mN2OnRlCtqVBu1RBS6F/naCBJTJ9WGzdnHMClEqSafqKJccXR5E
	mFfKJLvBW/WkMO+nP3LMI8l3xiDYK+Oj5pksLivCleLCnT5QYoIRckBIDJV8twF9w33WBiA==
X-Gm-Gg: AZuq6aIHuM6KLRboUBqKpS9Lv2LSL5fBLFWjw0Ox3XZ9tM5qG4OduIngIpZq8CHBrUe
	MB/PE5Rxcs43DiZyxhyYXolRpk+WBo02cOpeCLZtkRAKL/tMpYd4IKf2RF/Jx0yrCZ78WeAKGRM
	F1NifOzKL+oIhWpAry9xVwgaTIV+L08ngqhhsT6IE/0X+vRhuF/vMuCJLL5ECBjRHORnJkS0XMI
	uW33tYjC0XteLSPijtZ+RuV+Y9ApddtniXYBZW+06z0v8aWildHkoDYE5cHgjS+HZqmcRrwGRhh
	oCj5kVuiVnJ5XmUx49fi0PW3eIV6n+hcxPjeVWGpojv3fK/PRtMUquRnZ0q2Q30TmDwR8kEJgAB
	kbhG5QjQIfB1gwnM9XuY2xvYKCao21aDN4d1oci4=
X-Received: by 2002:a05:620a:46a0:b0:8ca:90de:43f6 with SMTP id af79cd13be357-8caf1bc49b2mr1335433385a.89.1770629570638;
        Mon, 09 Feb 2026 01:32:50 -0800 (PST)
X-Received: by 2002:a05:620a:46a0:b0:8ca:90de:43f6 with SMTP id af79cd13be357-8caf1bc49b2mr1335431885a.89.1770629570175;
        Mon, 09 Feb 2026 01:32:50 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:c35d:84fe:aff5:40d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483206ced0dsm223582165e9.6.2026.02.09.01.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 01:32:49 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] power: sequencing: qcom-wcn: fix error path for VDDIO handling
Date: Mon,  9 Feb 2026 10:32:47 +0100
Message-ID: <177062956416.16057.7079862738537090047.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260207-fix-wcn39xx-v1-1-df0606108ce2@oss.qualcomm.com>
References: <20260207-fix-wcn39xx-v1-1-df0606108ce2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ctOWUl4i c=1 sm=1 tr=0 ts=6989a9c3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=H8NWqUDLa-eB6nUYIgQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: G-f7iWTF_oIwo-QLHFENfeBdlH_SvzRB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA3OSBTYWx0ZWRfX94jrObYss7nD
 Rn1bnvNCSG6gl3YfSx6vqvnTsGFvImlCAdgXgQ64Mt4ftguEvuB5bZGM6Outj6UxQE5YSq6Fgj7
 LGit970GZqcBiX/MQXE3ghSIWD4KezIzWvIW/LcYrBbgxUFDDg7DsXfZiiOE31GTl1uMk39pIe/
 ay7KmyOmnxW3fuL8jL3zOYWoEwPVKl6jVqlubJRQeiU1EVu5rFam1QAeWzP87HPWkh2lTnRVXwU
 GW3n5V7YJ120/MVcP0968XITeDIBorFSBC2dMaiUDqwVDp+Iq/nQcKDPPKTlP9WD85RwyZkwXdp
 Pc1APZaDZzEnDGyAM4eYwAAeyk0d/G0QZFDA/5mg9pRumrPO4MlLnMRmCWaZ2H8uBFkWVkV6XGZ
 Nauz0zukJIUfSvwh43MR2cBczLWVq3UN7ZJ16cKoPdMliOcaLBNKhtQzUNPWQIQKBeZJQvBo3tJ
 sWcGry9R1o0BSSp941A==
X-Proofpoint-GUID: G-f7iWTF_oIwo-QLHFENfeBdlH_SvzRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090079
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-42330-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 25A2710D96A
X-Rspamd-Action: no action


On Sat, 07 Feb 2026 12:28:52 +0200, Dmitry Baryshkov wrote:
> In case getting VDDIO regulator returned an error, WCN power sequencing
> driver passes ret to dev_err_probe() as the error code, however it is
> known that ret is 0 at this point. Pass PTR_ERR(ctx->vddio) instead.
> 
> 

Applied, thanks!

[1/1] power: sequencing: qcom-wcn: fix error path for VDDIO handling
      https://git.kernel.org/brgl/c/ecfcae7885f105b29898ff71d3cb70abd56ef96e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


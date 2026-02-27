Return-Path: <linux-pm+bounces-43342-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IKQBnnMoWnowQQAu9opvQ
	(envelope-from <linux-pm+bounces-43342-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 17:55:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AD31BB120
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 17:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76CF731AF000
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 16:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728FE3491CD;
	Fri, 27 Feb 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Aywd3cfh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="idRTVBm/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D6A34DB4E
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211021; cv=none; b=aqc4UlpQJkvCIpFaoIBv0PeQE3kGn9iS3djCHd5lNRMiz+eH10Vu7tGQuFFkkkK8KfU/rbN+XNB4aJ5ulrnlIfS1GA0w7buc6XO8aTGn13RhXpiia+U1r9RuXJFln7kCzrwyFU75ktekisn8jmqM6bmqTXncMtzkf638oZTGUAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211021; c=relaxed/simple;
	bh=I1zDqyPuqDldOvtN2RqZkVgdgLAy/AoArdg7wkVIbQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDwJQdeTd2icDjSMwUbUzMYbeWuUh4064UBHHyLRf+MDy537A2U7T5oQcLmLb2tBo6Ly+P1/9JI0wqEj1IMFvWP12C+0s1i9XoS5xDYl1T5atvcQep/mtLnKq3vVydfp+eTf1sDcsGh+eQYAeZgutqu3+g7wpefQMxcmWWjJLvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Aywd3cfh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=idRTVBm/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RGio6Z2133851
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 16:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I24GMf7D5q0mlpnV6IQx2GHc/w3/CJuovqa3QQtDtu0=; b=Aywd3cfhB68F0txm
	zNjS282AypQBTrBn71dyn4Dv020xfhI3w7ujsBxW2e+SFIAPGHuVkr2k0SDf3XP4
	AINyd0bQA7WyRmbFhnSOv2gUzVTSm8eghV5u8A6/E/73iA5MA5OtwuZL1ft9NiXX
	Y6CLG4vEn8bNO2rG66uA4LbUbXSck4v9KXgOOO5ZiVy40mYrtANvlqjbSdjX5PQr
	PMFWrJsuYM8o/uD4fEEJ0QEtvqY/gtkrFUQcttwCPm7AXs36wM8jyJT3AMLM2IzX
	HZSJ/1i7thH/TcqxK0oRKid1l2Hx7/ZYam/bY0euWBkrlW9QVoVnj6IvPQKlpEn3
	hOAlhA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjx1xuceg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 16:50:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb50fb0abdso228331185a.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 08:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772211017; x=1772815817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I24GMf7D5q0mlpnV6IQx2GHc/w3/CJuovqa3QQtDtu0=;
        b=idRTVBm/tjNfecAUD79mwvSQ0yTavN0AK2Eor7R+P14TudYxYpyZL+TPCXNGNwiMck
         L/b7hIRr9drA8hWZvrJiMKD5ZUnth1FtBDuLSORhxJx7YHhZOy83gaEa0mTFo/M+f0g2
         t9Jddd01sTeYrljEz8keMxhJz9D4qYqAhtlIZPXL9eY43lv81cibgyTT5GujhdGj1ZGN
         nCMEDLvYBVtFeZzGtZ2N2QrH1XsLA8bkB57grLdwTWeAX0hbuJgtw199Jy0KApoY2vS/
         NlQOXK8ezl8QJMV5ECWmgR3a9cWEwJMsw22UwhoRS4xPVliKulXMrIb8DIy5Ej/6cM0+
         sNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772211017; x=1772815817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I24GMf7D5q0mlpnV6IQx2GHc/w3/CJuovqa3QQtDtu0=;
        b=PMXp6dI/GSvOsx4AhneawVvj4rWRF8qJRu2E2tUkMAy0XjoSXCm31fUxZ+xlkWA8lm
         Eihm2U39TLGpS7KteaC074cthMFqR6xtk8aR9CkWdbn7z2dCgicPSOFxDKuuGDZd8oji
         ZS2L+Ob51Wuo2ydRZMT+v/nfa8U4y7ofLRWY+9VvaqeiwNwtdSVFT10sur41vKrBoZAb
         p3pkp7TZohbD1DlrA8DACWV4CI/SoFd7h6/WWNPx59Cp20gCihXEi9iO8yAws1cSVsbS
         HWKeAsPeqb4q0gxab0A2uEpwELgeoEOeFboMyPbvVxs8PZddnHOpOv8EZvRHNcfPUmMk
         MpNA==
X-Gm-Message-State: AOJu0YzvCAk3KyKt7mhtmLOaTz0sEwxtJLOadawKktbqmg7pcd++0ARY
	EXpkTEdoVYB/x2daEpmKLRT6D8r4ZulT0JbsBkKv7Emz2zbtAov0Sg20ff5LNXjK+TCZwltCsT8
	BI7ZipJY+IoCC8N03cmhTzOC/xXbkmGaGxuxFqpHOQDVWUk7cvmOhYJqgrO23Vw==
X-Gm-Gg: ATEYQzzM6893jyNdjeqVRiwbpnazQsbKyrWXLOxSNTSJ0pugvgKsUopBMX9JhnOeEi+
	lA8JCeropzh4fB+ehu8XsjhkPMAXxiCIVpRlrl4EhSrjFSIH38yRBn2JvnQrWmYXJLqopD6xWCy
	7L29+Tt6WEcEUn3cYqGCb12Cy7YrsSLVbh84i846+brvXDdMUsfY9ZM+gmpLrp8Na2iS3pQeGh9
	gZFzzUaxLRkIDKz8+2uwcBbwtkyxig+yifdSV5q622omiR7G4sfsUfISA8Dh8QiXJV0fbXin+js
	myG3LS9dlrn72SZWOksZcFIlLS6fi7zgzB5+skwlk8SOrhSOIgobXakZUb+SAoC9r7SYuo5Y+eO
	5HxsUU5amy1eEEeXEXc9a9rW7c6kc8oYQpUcVkmhxly+kDg+em/auXMrZZ/ITaSLj4q6HmyWXc6
	QwuX8=
X-Received: by 2002:a05:620a:280d:b0:8b2:ec2f:cb3d with SMTP id af79cd13be357-8cbc8e970f7mr305786285a.10.1772211017527;
        Fri, 27 Feb 2026 08:50:17 -0800 (PST)
X-Received: by 2002:a05:620a:280d:b0:8b2:ec2f:cb3d with SMTP id af79cd13be357-8cbc8e970f7mr305781885a.10.1772211016764;
        Fri, 27 Feb 2026 08:50:16 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ae612f7sm167054666b.36.2026.02.27.08.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 08:50:16 -0800 (PST)
Message-ID: <b79982a1-a0ab-40d2-a03d-606280c3a3b3@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 17:50:13 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: monaco-pmics: Add PON power key
 and reset inputs
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260227-b4-add_pwrkey_and_resin-v3-0-61c5bb2cdda9@oss.qualcomm.com>
 <20260227-b4-add_pwrkey_and_resin-v3-2-61c5bb2cdda9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260227-b4-add_pwrkey_and_resin-v3-2-61c5bb2cdda9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zsdz0IQ64z-jS4psF3M5Zt3KRiyGbXTP
X-Authority-Analysis: v=2.4 cv=Vtouwu2n c=1 sm=1 tr=0 ts=69a1cb4a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=J_uYMOLApeVIcPsgZk0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE1MCBTYWx0ZWRfXy08ZrvLEBgyL
 8L6NKpHGsG1sMcRUBL6zf8Py6CSvQSWsq/JkDx7CvBxy6N7pUjHQIcwU+tdO1yLb8OT8L/RXl/4
 1a0w7tqswiiKIzTj+MpFAkm1h1SwPokT5eJ4HvrD4SyvYgxlwCbFiRMB3aR+agwK0iifTZ0inCQ
 NEbZZ5Jvh1nuSnRX6L28ViHEgLeG0+44DqcOU9sjAtTBzfpfuScpBM5aCJ/pLXEMM5gMCHihJA1
 npxUBniXXIrbmlF9ie6YCKa4c/+B4znvQ/FFjQjk4in9IZC9r6ll/BrDoAEyjdmNndNQt2g943M
 GCA1ThBH2ARKzSEzO/3ikrDpZ2o9k0MQuURdsRU49pnrvW/XS6v9UWmvuJrsPGwHBt8uExDNAgT
 j6wpRS9S2IZTxsUzw3I6jKDmyK8hv7oP4Fgzd5n+jSnAMZ8yJE9aiZdYMzUNDrUiKEueOVbEp2t
 Dxd5fDg+CtkfJmDQgqg==
X-Proofpoint-GUID: zsdz0IQ64z-jS4psF3M5Zt3KRiyGbXTP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270150
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-43342-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 99AD31BB120
X-Rspamd-Action: no action

On 2/27/26 1:32 PM, Rakesh Kota wrote:
> Add the Power On (PON) peripheral with power key and reset input
> support for the PMM8654AU PMIC on Monaco platforms.
> 
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> ---
> Changes in v3:
>  - Disable the resin as suggested by the Konrad.
> 
> Changes in v2:
>  - Add new PMM8654AU compatible strings as suggested by the Konrad.
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


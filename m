Return-Path: <linux-pm+bounces-43480-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPsSDlezpmn9SgAAu9opvQ
	(envelope-from <linux-pm+bounces-43480-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 11:09:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 841FE1EC685
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 11:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23820301BFBC
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 10:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11461391853;
	Tue,  3 Mar 2026 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DFMZi/qu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TtEb7TWO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF34B391835
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532462; cv=none; b=MQaN1vYH34YjeCX648gv1T4y2nTzjTaKgLeRA7v3qKye6ng1jzqnAJaK9WZ8u7gCWJwCEa2OyBi6phw8bdn+0rXcjPq8Z9IX1Ttm+0qS7Jz+VzmaSRofMTps7lgRnl5H5XilsxvpiYtzO6Xovf+2QBuZHM96K/zUPxee43mgITM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532462; c=relaxed/simple;
	bh=2QgGw+VLl538AxK4NH+SulIRIdtltjIFPi+D9n3D+pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AllVnxP2R7uLV5y7LWjSkOq9sZFX9cnvNU4a+WJd26uL7lBJfL/RQqzzkSa1DQVi3h4aQAm8L13G1UZRQkdGvd4RK+aZ6ba7m5hhcT1BGkYbcM7g1eRvIsip2jE+HJf58c9QKdNWhnSwu7NY9cvyIIE/AU0xj5mN+uKzcrG7RQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DFMZi/qu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TtEb7TWO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239mlSC2614192
	for <linux-pm@vger.kernel.org>; Tue, 3 Mar 2026 10:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CZGGj/Cq43q5ATiRBFYGEftySIRuSNWf8OfummFnl00=; b=DFMZi/quVv2iY5j2
	CsQ1gxfK8ODtli7gAgMSA6d7fHusooOICd3XkfdE0GtLRyF3OzKlW9eSozKfBUO4
	Yh6zLGtVWSYIhO27m3IOOeK0Q3j9rGJx8vwqjza74j7a7BApu14unY/QNnV6LmuA
	amX/d5quVf88qxQOLWVNSjBW29N/elpkcX/Sx2/oLfBL1a4b9sbnY/jR+43Py5hC
	ME/fM6NKtkHAg+xg4xi4njiacE3M3eFb+HMIt/Gov16PWzbTtrRFmHX91m/y63so
	QQIVgrnbpEH6Q+NIwG7ry1LcVJGkq7GefsI65xVswW/Go53CKWA9KUEViI3Cqe+N
	s3lX/g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnvxf85r0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 10:07:39 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb39de5c54so463495485a.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 02:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772532459; x=1773137259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZGGj/Cq43q5ATiRBFYGEftySIRuSNWf8OfummFnl00=;
        b=TtEb7TWO7qdTjx6M4oUW22UQ8LAU3YaRpdggOsOfcKa2KCfyTpwlhakL3gOLCCBUHd
         HigtBtrEKpKlVbgjS7LlRI9KAe2cjzksdSqqhjPj2C9HE5zsu4focYt2EDfPThTmDXsQ
         wMz0xr59+HHrHRaWF6g6+An4FVa6qF0yeowqQH0TI5V8r7Itr+uf4hP4LH5XqjO/KzvQ
         YjAc+gNj2se0J4WqaSqEEDHwLXrHu8xRNTIPjYHRDUJo7Xm3f1UKdjn3mWiP9RJxbv3S
         LNIG27KUbmdc6v2OfzCxBgaJ6izKgU34LYndww9AsN4sVdTg3UzQMDOLddyG979LbhDz
         b6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772532459; x=1773137259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZGGj/Cq43q5ATiRBFYGEftySIRuSNWf8OfummFnl00=;
        b=ulr/kXZhwNfEbyMV//LiFE8m+jmE3CgieqGZ8JM3Ozp0Gs+P5W4pG9Eh3d+wa2B7sP
         NbD0ng+9Y+uYs6nkQrVryoOhOIQcC7YqVmMrhLAH05705XOStUw+d33R6cVzWc++Tf4g
         6KjxHOcwuvpLL+5ihisFnfsOGRvPRvDq5vM9IyzbxlNtCq9CAzWqDYGHj9p+9WW6d9ul
         gkMvhYHXpysOECOk5Zqlos6bOvvzxy23qp+Ycfzip6ERReTkjCn3Bc2hrFXfPG5PDcEh
         SqgJwQAYEf9QszeXhq1T4kN1QBxetsWIsHj3dV3yHWctACnyx921b3oGAN/aw75VkYMb
         JaJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsBS/5nrPCtKWhFh+PFNqteEk1eObCSMC5WhZ96UXuh7VjcidIRbL+FUFC4PQQ4WFYVqaMyXF10g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy46UKR6wEAoLq1GZGHBnHEnaH0iw7O6Zb8XA7+TF/FWIo6l4aa
	kZPufzVO8VU7zjDgckWva9Ca/M4XBLa48bU/pE7vlXdaISEetra1i46AQPGYgAWlmIgEDKBlekZ
	EmC3afi/u8xgysUr4qo4VWTVCbnXkwMt6gPvzVg+lQAa0IarhqQ5WhfweyR7Png==
X-Gm-Gg: ATEYQzz1d6OqYXHEqTd3Rz0m2oObLwejLInk39qBs1sNk9kYbUMND8CVO9lZZc/3ICF
	4VQKNuTIgsmQBZYkXKGinGfQ2bOhb2MARa/hW+plua3JcyBW2c1lfmHQ/PLhJKMZiXjCJ9U015G
	9sebH6uugsGda4NkPKmGhAmuFekDxgIUiixrapnZUNV3Q2nI4JrLacEX22OqiWbKFrne4Sx7Nsj
	0meIvJBaJqIQ/4rMjFACc0GYPJJlDiwf9RCJsNxCEYKyT7A25GXL4VL6kTwtIiPOzu9wEfDInwF
	mlR1m4hqWhB2/yeFwObqAKMO5pSULSZiyqixn/xX76k65d5nn1cObMwBP4vXRXbYOIHq0oYVqaM
	IcGz+9KRcyWW7sxEwNNxVvFnJRIeoQKCA5rNBEsY+7YIIfGp0z2H9Tri326BsowjgiDlB4Fx7Xx
	AiWWs=
X-Received: by 2002:a05:620a:7007:b0:8cb:3fa7:c4f0 with SMTP id af79cd13be357-8cbc8ee5ac8mr1679032285a.5.1772532459061;
        Tue, 03 Mar 2026 02:07:39 -0800 (PST)
X-Received: by 2002:a05:620a:7007:b0:8cb:3fa7:c4f0 with SMTP id af79cd13be357-8cbc8ee5ac8mr1679030485a.5.1772532458530;
        Tue, 03 Mar 2026 02:07:38 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9383397fcasm444054166b.60.2026.03.03.02.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 02:07:37 -0800 (PST)
Message-ID: <aef4305e-3965-4f55-8eb5-3bbabd63bd18@oss.qualcomm.com>
Date: Tue, 3 Mar 2026 11:07:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] soc: qcom: pd-mapper: Convert to
 of_machine_get_match()
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Ilia Lin <ilia.lin@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1772468323.git.geert+renesas@glider.be>
 <0d23a449e62ac85f04ff07bc2758efbaa709c9d1.1772468323.git.geert+renesas@glider.be>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <0d23a449e62ac85f04ff07bc2758efbaa709c9d1.1772468323.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3NiBTYWx0ZWRfX/kSzodf8jTSG
 Okh+ZW9Ox1HX+poM0HpfhgkXbZH1q7rq6yvZfeuGe9dDNkwC4ZdUwxhCZ4eY2gzw/q96KZFtQSY
 iGvVsRnwsp9ELmLPnf+bCaC5soNWUTUJ8I0tX8ZFkxKzUx/IEv0MpD22CXRPcSqDLtSPs9n/pDt
 OO8sgCw4iIxysc7Ij09Kkp7NoDsR9HgU03nvSULlt6AGjff9L+U8dNDP92HvnTfMwFY26+k5LYs
 3jxk9LAYq5oB3My73Hb/bS4yqJXSkoXeSvBXlcn+90ISTyhTp0mcg232oPsSZSMnWzkOO0Eqjzy
 +VaV1FypNlMiZ2nXsKAuFhlGWOzb6y5nLrVD47X5twikts5Aum3pByKUeZpItib2X/pSOBzX57l
 /G8G5xabxtWNg25WDixbKKUEBstv/inQ8TLBZVqGkw7QIQJQ/ztDhIYuKxjZgm31jxgVjc5HSaG
 M1ms7QgWdsxP4M7UTzw==
X-Proofpoint-ORIG-GUID: kkEEpSCAK3ViLOGNQVmNtFm-RTMwTXac
X-Authority-Analysis: v=2.4 cv=S+HUAYsP c=1 sm=1 tr=0 ts=69a6b2eb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=O2ICF3MwSKB_Mz4s5DoA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: kkEEpSCAK3ViLOGNQVmNtFm-RTMwTXac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030076
X-Rspamd-Queue-Id: 841FE1EC685
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-43480-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/2/26 5:29 PM, Geert Uytterhoeven wrote:
> Use the of_machine_get_match() helper instead of open-coding the same
> operation.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


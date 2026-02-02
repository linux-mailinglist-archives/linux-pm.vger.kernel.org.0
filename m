Return-Path: <linux-pm+bounces-41887-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCytBCZ0gGnU8QIAu9opvQ
	(envelope-from <linux-pm+bounces-41887-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 10:53:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB1FCA4FC
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 10:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 595CD3015878
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 09:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280992DC349;
	Mon,  2 Feb 2026 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S6O+ryPc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bquqx+Ez"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D042DC333
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026019; cv=none; b=U5Dp/glnNtbKlH9Lo39Jmpcx2/FOJKv9uIBLiO6iYoQgnia3Mu8aa1Ftn8tk56efc2bfbq8kyqbeHE9eIUH2B+6fsayZIlaPcEGMfszhIk7HSy9jL9ULTzPseFuviyfh8IYzxoU6GxP5+/N0oXNe+J5qi38pd4e1psoQL9CaI1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026019; c=relaxed/simple;
	bh=SfNn4S+1U6Mx728Fu5fmHhagWzpAOe3rlokRF7duqr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J2o9mKxHi+xH9qUs4KSAuzlAi7SeDpNrg4WXD7Z8aT2X83AHw5mAkWRYbSkwW36sprBSd4vWmjcXgHrl0raC87oY7m9sR3V+nWlUofSGNXNyatK1kht8MRXBCV9vqEuhwWQ0VsJHChXd+grFDzZkVLTFDrU8TYDoim0dFMVKadk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S6O+ryPc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bquqx+Ez; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61280Vth1558674
	for <linux-pm@vger.kernel.org>; Mon, 2 Feb 2026 09:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jr6u6qi5uXkZE9bqbzYiknJF27AP0in+O3Qpto1prqc=; b=S6O+ryPcHpLqzBz1
	9mBJ7CfK9B1v/A6nqHnbmseqtL01HhZVNTsXTDaWnebfNPu4eNPqg1yOEyANHd/L
	q74b0odFqI2Iicouceflwl2H844MgSYh/jUZu8aNjoVBRpDvTg+H3hwoEP/yFqvH
	VqbSz/FKQoDYEmR5QID5KzGWucfHMi4Nxd4rly4TAhlAVWvEwA7NTCCcar3pZ2JZ
	kgdLfdwoCcykEYE6ubBJobEv/Gnf3WBqjuX07yq1Wz9+/2oMjT+6ss8NX5ILcuVz
	Kqn6D2XEuayeuk3bZOO+CmUFuFoV+A5hH2c3ACdtNpoJKxjFHJ3FiwSfuxRUc8LP
	D629og==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1au2mwvu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 09:53:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70c91c8b0so111556285a.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 01:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770026016; x=1770630816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jr6u6qi5uXkZE9bqbzYiknJF27AP0in+O3Qpto1prqc=;
        b=bquqx+EzOYrJ/K2I77bd7lvqHsHBJ8aLEdOU0YXge0S43rW8z69A+azRgw63/dnh0M
         U57MmuphsWcXrnTJDcgvCsn5HAswbCU7Zmwm0cH1zUbyiiLXmgdEjec/CwjYzBG8if6+
         UQkgFbB5sylB3UcK7jSjkmJCNhh2DTaFUq6Ba3FkS1a6S6XBPPYOXOGx6KybnEbCs1/Q
         7JjiircFKIiYhj3H5oFRH98v1dySm3rD9JYsYGwHBe6lIBNvh5EjMHmnnXVOmwxnPK52
         4BBSqr/7Irk+5/ekukE12zgmUba6Nh2M9UsJDwvZG7bqjumXgNsW2ayQ+6GkDgXL9gg0
         Tmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770026016; x=1770630816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jr6u6qi5uXkZE9bqbzYiknJF27AP0in+O3Qpto1prqc=;
        b=Sr/DIwhMvtxnb1iocMDytGEi3PR7WPW5oDs8U5RAb+Gdk2fwgKrnsKASe1ZgxW0GMM
         x0WXnpmVANlMh8UA8RHQo5ZscJCgXK0mMS+Z1xxW3ks81VvdVblgMMdq9pk1OlfN4REd
         J6a1529nJ9mLZs6hbRpJGOTquZlqDWpSBpQ6R+8LEnRcVlIrEkGuxLFEEyZ9MrfYeyY6
         DM1nH8VmexShJfIvbf5Vxl3OvZPzDB9noJ0TJ0rtqoRBg0iLBVIjMV8hUp4q1lItZ3T2
         yMvErbgBz/lgaI+R04QcLD11A2RCl1S18/Wbzc+p98zmID6CLttoopIaEn0VwSVWxkhI
         87tg==
X-Forwarded-Encrypted: i=1; AJvYcCWdUb3THMLZXgwE+dpxzEFN0DvC5Fj2/g5Ol8drxyXcbv6LMyO+20b0F75LYeUxJvFgbCEIDon97w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSiWkH02f5QwQFwBu3kFWGXqypNkoBvFwvHYWeRlDR9iJmIdJd
	SjIIKGmsC9k843c10FZzgKhMbcbnGx4Bgw9936/4Q4y6P0ItB09gK79m1guPwjn2XUR8uaK/0aE
	PU+gYh0cwK26Qh0e3fQRm9tPR6nC2F6D1hsswvP7/4CEROSWOpBhZIt1gl1fpDw==
X-Gm-Gg: AZuq6aIn5cfHY0Y6CRQNicVI5KxE0AVMSXBFpDsyUZEQkxG4ZSnJrKqriaih9aErG9A
	fvXmDlvLjx56hMC7MjIDgp+oz4Z7YkfLetJmzf0K1NO7vmhwcbcdvlKZmw5kwK/x4PKGyNpplrc
	vtuap2NTPv07z94EhKePmMGLQ6HWzn15N8wP6sWS7H2DPUpcLyUwz6Cdwnqk4Q9UY2Ri0l+COIy
	Jn+jdvSa1XTQlauzDWVIFRcA37jEUY8FxyZ/ybHzU2J/PzWTrfGOtWVgKUG3uISPRpHwHVt0YF3
	Veq/o4vx/u0ONI+uoQ3gIAJrKfkIwa/kX/KRjD8bUELdUKfrf7bfUjmy4P8mE7JOi2K1odMv3jD
	3fEmoayWI75Inys2ApnRTvIsKK1j3fYxug/MgnykJeWYZCWypINIFa+3+Xa6aqM0ee5c=
X-Received: by 2002:a05:620a:25d2:b0:8c6:e2a7:ad1c with SMTP id af79cd13be357-8c9eb29d9b8mr1161842085a.5.1770026015861;
        Mon, 02 Feb 2026 01:53:35 -0800 (PST)
X-Received: by 2002:a05:620a:25d2:b0:8c6:e2a7:ad1c with SMTP id af79cd13be357-8c9eb29d9b8mr1161840885a.5.1770026015450;
        Mon, 02 Feb 2026 01:53:35 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8ddcf8aa7csm723665066b.9.2026.02.02.01.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 01:53:34 -0800 (PST)
Message-ID: <f36e3878-70d9-48e7-9e98-796cbccb47e0@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 10:53:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/8] Add RemoteProc cooling support
To: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Casey Connolly <casey.connolly@linaro.org>, andersson@kernel.org,
        mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org,
        amitk@kernel.org, mani@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <2a39719e-e73b-4558-95fa-d54f94c43220@linaro.org>
 <6ae95761-6428-4a01-8c60-54df5e54b71f@oss.qualcomm.com>
 <cca414ad-0a98-467a-af31-72d40c43e27a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <cca414ad-0a98-467a-af31-72d40c43e27a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SanEPeNtVnChm4jqo2Tm7JlXFjDjnZXL
X-Authority-Analysis: v=2.4 cv=TtfrRTXh c=1 sm=1 tr=0 ts=69807420 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=8BWbUoxn-aILMCT19TQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: SanEPeNtVnChm4jqo2Tm7JlXFjDjnZXL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA4NCBTYWx0ZWRfX7gS2zzzcZ4RX
 LiDunBrxxxT24nXX5VCqblkHzrY4J4NGgMjwKpjXMAR1XvhYdztrSvpiUsQ98cnLukFdKF+o6LK
 fTsGBhki2xZvRqnxL0GqfnbWwgPEJjdu1tKIPnTMaHqTqTtxYMHI+Tevwtc16hKfsAInOgA/rAl
 FY2TA9CnHWt+TATib6TRmpvBl7/vxpiTDQYvoM8PvYK4vgbvuGMTtbdFUiNLh1X/C1Tl3N5YHVL
 D7eCfzUt9lg72+2IMjr80MyvQOtXBAefJQY1sZLDJdwiDeFuEyoSwHHyKkm2f8rImk+8+5qjmdq
 Qgax8eDisUwCjSQ6O9YGcPop8aT5e9iPGXGMBQX+XMhDtKSbH8ATI+fT4OhZuk3j1UxM9nhd/jf
 tkj84EjIprsROR1rsx5VfUphjjsEdZOtyw7GKgOLbRgh8VP8Tk/bJAFhuQlgfvnsevFszo0i1AW
 rIVrEuK80/XndaMqlmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020084
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41887-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7AB1FCA4FC
X-Rspamd-Action: no action

On 2/1/26 9:20 PM, Trilok Soni wrote:
> On 1/13/2026 1:33 AM, Gaurav Kohli wrote:
>>
>> On 1/10/2026 9:43 PM, Casey Connolly wrote:
>>>
>>>
>>> On 12/23/25 13:32, Gaurav Kohli wrote:
>>>> This series introduces a generic remote proc cooling framework to control
>>>> thermal sensors located on remote subsystem like modem, dsp etc.
>>>> Communications with these subsystems occurs through various channels, for example,
>>>> QMI interface for Qualcomm.
>>>>   The Framework provides an abstraction layer between thermal subsytem and vendor
>>>> specific remote subsystem. Vendor drivers are expected to implement callback
>>>> and registration mechanisms with cooling framework to control cooling
>>>> devices.
>>>>
>>>> This patchset also revives earlier discussions of QMI based TMD cooling
>>>> devices discussion posted on below series by Casey:
>>>> https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org/
>>>>
>>>> That series introduced Qualcomm QMI-based TMD cooling devices which used
>>>> to mitigate thermal conditions across multiple remote subsystems. These
>>>> devices operate based on junction temperature sensors (TSENS) associated
>>>> with thermal zones for each subsystem and registering with remoteproc
>>>> cooling framework for cooling registration.
>>>>
>>>> This patch series has a compilation/runtime dependency on another series [1].
>>>>
>>>> [1] https://lore.kernel.org/linux-devicetree/20250822042316.1762153-1-quic_gkohli@quicinc.com/
>>>>
>>>> Casey Connolly (2):
>>>>    remoteproc: qcom: probe all child devices
>>>>    thermal: qcom: add qmi-cooling driver
>>>
>>> I'm glad this series is getting revived. It would be good if you could explain what changes you made to my patches somewhere.
>>>
>>> I also remember one of my patches adding the DT parts for SDM845, would you be willing to pick that up for the next revision? I'd be happy to provide my Tested-by.
>>>
>>> Kind regards,
>>>
>> Hi Casey,
>>
>> With this remoeproc cooling abstraction layer, we have integrated your patches for subsystem cooling. As lot of comments came for qmi-cooling driver, so need to send v2 with cleanup.
> 
> Gaurav - the question somewhere in the series was that why you had marked your patch series 
> to v1, when you had revived the original (v1?) series from Casey? Should we consider
> current patch series as v2 then? I don't know if that comment was concluded. 

Because we have effectively 2 'v1's, there's already a certain mess, but
the msgid is different between them so the tools won't be confused
(i.e. just go with v2 for the next revision)

The outstanding request is to include a high-level changelog of what is
different as compared to the original series (as well as picking up the
original 845 DT commit if still relevant)

Konrad


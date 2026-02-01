Return-Path: <linux-pm+bounces-41872-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMByO5m1f2mSwQIAu9opvQ
	(envelope-from <linux-pm+bounces-41872-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 21:20:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91524C7292
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 21:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE4493005D39
	for <lists+linux-pm@lfdr.de>; Sun,  1 Feb 2026 20:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA3B261593;
	Sun,  1 Feb 2026 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A65rwLSm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KbApePUo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97C822AE65
	for <linux-pm@vger.kernel.org>; Sun,  1 Feb 2026 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769977231; cv=none; b=dbhRt8SPhx/1PsoX/VTRjnqc7z8+RmFRLXK9bbsNrhF+aBy9munsIg5VVY/Oi9pLKkc3wXzCD/m0AK0pXtWY77DNKk/Bme+kyFgMHXKMpY4JOYmvgmG6IlUPNIWEHxF47ls77s1p8u+xCCnmQcjifu4T5WDbD0/GCwBZ2USTasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769977231; c=relaxed/simple;
	bh=OIwoWXiFyC4ULbEkm8Z715O0KwhxMfmbna7ccRPLc3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0rJpUVFFQrxPwD1TIIsxIjyrRMqmJPBR0XbtlAFzxzoA/bJ5A6qpmEWOQHnRkNZvvQfVH9olOgHsJrEMoj0FaGgLavsxldcjrd24gYQ+o5iVIqLpmVhvCNwdcyI2SUIIsZ8vC++bwsNyzVSHf9Oop1NDSKecCQZzjd47bcSIpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A65rwLSm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KbApePUo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 611IUTmQ623842
	for <linux-pm@vger.kernel.org>; Sun, 1 Feb 2026 20:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zronmJQSd8FY6RvRET9WRiBavlgCQX2GQk0QoWt8vrE=; b=A65rwLSmF+XOJGFJ
	WdqlmHISMspfBnwOH6U0CPfCEeWYcUli8on0ahWGsNDOg0HIjbt1EtTw1rRDFYgg
	t1ShA/akbcjXz5g1hpxtlzJkjATJtpRu8X4j8wYBbreppB+MKIP0VEPY+1EFfMU6
	Lwo4E95GXFS4dabOsEYMOHQFBVD2dn86vxKZftqNf/kOVag9Mks7bJHbI7wq71lS
	rNR0HXRpLi7mCQqv4cXFr5NIe7jHfV8yeND+mBXjcln4Wee0ZAumDtGxnzSR3v/G
	7SrtPfJhraaOsRsOwJwPxwZ0jKrLeGYQ3Upe5QYQjBONk+iknftZUxRCmv+dK/dB
	WcSguw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1as4u5s5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 20:20:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b713fa927dso3008022eec.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 12:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769977229; x=1770582029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zronmJQSd8FY6RvRET9WRiBavlgCQX2GQk0QoWt8vrE=;
        b=KbApePUoK3X0eUXrhw3xYxFfVWdSbqCKEHrpFQ9xKLl5x1D9n0y+2mt5Ng4fF2w3z3
         e/ppiScw+HbiER5KCuFjOBvJ5A7dwlAmpybFzGsoiv7lHszBUGD8P+WF+2u2igfGEeO7
         E2JiyRYEbkWGOpGn5vPAlDaMGX0qFsgBs0SKcDfyOt6ieUgcfMZoXmj0m4E8SyyJnHwf
         vwrfJ7iTX2uX/67Le6Y7Bvb/hV9euZT9A5fpVcETvtCu39bk4Kb5NEJZS9/TADpiySpy
         yyKUwRMkQeVUPfmvzPgMXFAN5Kosyml2pejfGl8fRch8/iLcNOkDyIraIa+a6x6edigB
         NyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769977229; x=1770582029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zronmJQSd8FY6RvRET9WRiBavlgCQX2GQk0QoWt8vrE=;
        b=ncBCfx8VgS4xangVISd6b+kShh62j+Q+Ua5++HbV7vGk7RJu0hEG+cynfijQ2DYyN/
         YsYVXUngsuGUA/LF3npQ9xWsl38b7Y+qqUl1s5lpjpujipyV5pLkaTKKEvqbrL9Gx/+8
         D0XAcnThGtJMXZf6n4p1YlNtToyRKqyHql9IZiQ4Fq7+EWV87Euoc8hl+Q3qMZ29i2mk
         cK1svMCKpZsKaF1jWICjr1QKRxMDT2YxOmCAT6GUA10jLk4oP1CQ0DF4NLgoINEAoQnW
         VxLlsDXqlgdbuCMnZZ8t1RDbwgxkc9l65iKf3u1G1wLssICEDo/eXU35mCJmmGTBxMbY
         CMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwDNfgMBNoWaiz/DmR4GoeChbZpGhGkdHLUj8fH9ywXoafmI3bmUwv+sdZKvLbG0vCGXVN1sqmIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2fVraqnRd+JK5COlBLLcSkiuxe924gj8ZHYQxJNXgpob5ihmB
	neUOV7JTsOOaAqOqvQjUMytjfLkId9BFtgNgRz+TvE9xfRQMd9clWs3C0Z7XLLCSaKIRqDUZvXF
	zVV9bho0//tK3WEx+mkZEB6P8vxcjXLrmLwp6EnaoyLU/34MGittVn//Wgi+uDg==
X-Gm-Gg: AZuq6aJwbHNcMTjzE2vgcyMMx7OfBUvWW6Ltr9RSO+Z3zr8uJDBvL+c9nZ+kjM8P+OX
	sbBKTOQiGpQmG5p1W0dCkDtHYy3KCLjrj8rI0tp5frBD1s0r19zO1PnW7YNvMe6TNyHj8zDi9cR
	Y2qFs4AK8L0Eqy1DbQYicNM32YUfbW+o/zYbKkppF1TqwnY93qe0j+30wPJptyBrj9KUeFQy4iX
	IAgFaWXUlI8HEbhhoDHLOQr/pKQ8AAupHnhHWlcFg53Sxiu7r1NMh0vVzoPBRK94CkJ5RH+iLvJ
	x5o57WguxKN0OsTFLXcEHVPwcCkTd7/VT3+pvEq7z2W6aN4CIV4M5ApBtX/BlkFSn+aUCoaobjn
	GAdOLoh3Kw8oIGsEb3l8gR37k04bj9X/Ik3evNzsedL4=
X-Received: by 2002:a05:7301:e8d:b0:2b7:c285:837d with SMTP id 5a478bee46e88-2b7c9124fc4mr3817739eec.4.1769977228913;
        Sun, 01 Feb 2026 12:20:28 -0800 (PST)
X-Received: by 2002:a05:7301:e8d:b0:2b7:c285:837d with SMTP id 5a478bee46e88-2b7c9124fc4mr3817718eec.4.1769977228383;
        Sun, 01 Feb 2026 12:20:28 -0800 (PST)
Received: from [192.168.86.148] ([76.176.48.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7eddf72e3sm4665656eec.28.2026.02.01.12.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 12:20:27 -0800 (PST)
Message-ID: <cca414ad-0a98-467a-af31-72d40c43e27a@oss.qualcomm.com>
Date: Sun, 1 Feb 2026 12:20:23 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/8] Add RemoteProc cooling support
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
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
Content-Language: en-US
From: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
In-Reply-To: <6ae95761-6428-4a01-8c60-54df5e54b71f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xunVcRFmB4fyKWgfteygZEelfedWvICz
X-Proofpoint-GUID: xunVcRFmB4fyKWgfteygZEelfedWvICz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAxMDE3NCBTYWx0ZWRfX8x3QGGFz6pB4
 T1wJBNY7HuwbZICd0Ome+f8Fze4gsfl/qtWrz14+vy51GvQRMj39k2fYduxvqSongJ7b4BFeQyN
 sA8X29z6DvhTcs19AMflBBVESsv6q6/LrIYU21I/YeG0QQEJEexnVrJB2D1WxjP1E6bcJnj3VBR
 k/z8pq7qSz8qjaNBkEDwudBktwlD2435Jk4HYJEdaHPurzh2EncY5+17yUjawg6AZB6TSyMZq0e
 vSYHbvqrhlDOfDpTYy6uQU+YNEu3i9VOO5EA2CJMKkIRpImmhHCfWLQDYM8RvT6kwlF+/jj4qUl
 8QC+fadg5/jTuFWnc3gth64l8kxgdFRYpSH37WvvyZs+x+mT9G3LRlS2hyoIQD+pDXq1HnGsOY5
 daIsn9Wul8n6LhCDFBbdPzLUSkX18kRdagdXtLEZ0Oo3ocwxEd2lIfli+hwVnb2aoFSXJ+Ph7NI
 3bptJ8VTVc9OM8uHcpw==
X-Authority-Analysis: v=2.4 cv=bIEb4f+Z c=1 sm=1 tr=0 ts=697fb58d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=lsoD3MMNObdLvy1227ExmA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=H6DjUutsPqjzIdRAL8QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-01_07,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 clxscore=1011 suspectscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602010174
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41872-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trilokkumar.soni@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 91524C7292
X-Rspamd-Action: no action

On 1/13/2026 1:33 AM, Gaurav Kohli wrote:
> 
> On 1/10/2026 9:43 PM, Casey Connolly wrote:
>>
>>
>> On 12/23/25 13:32, Gaurav Kohli wrote:
>>> This series introduces a generic remote proc cooling framework to control
>>> thermal sensors located on remote subsystem like modem, dsp etc.
>>> Communications with these subsystems occurs through various channels, for example,
>>> QMI interface for Qualcomm.
>>>   The Framework provides an abstraction layer between thermal subsytem and vendor
>>> specific remote subsystem. Vendor drivers are expected to implement callback
>>> and registration mechanisms with cooling framework to control cooling
>>> devices.
>>>
>>> This patchset also revives earlier discussions of QMI based TMD cooling
>>> devices discussion posted on below series by Casey:
>>> https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org/
>>>
>>> That series introduced Qualcomm QMI-based TMD cooling devices which used
>>> to mitigate thermal conditions across multiple remote subsystems. These
>>> devices operate based on junction temperature sensors (TSENS) associated
>>> with thermal zones for each subsystem and registering with remoteproc
>>> cooling framework for cooling registration.
>>>
>>> This patch series has a compilation/runtime dependency on another series [1].
>>>
>>> [1] https://lore.kernel.org/linux-devicetree/20250822042316.1762153-1-quic_gkohli@quicinc.com/
>>>
>>> Casey Connolly (2):
>>>    remoteproc: qcom: probe all child devices
>>>    thermal: qcom: add qmi-cooling driver
>>
>> I'm glad this series is getting revived. It would be good if you could explain what changes you made to my patches somewhere.
>>
>> I also remember one of my patches adding the DT parts for SDM845, would you be willing to pick that up for the next revision? I'd be happy to provide my Tested-by.
>>
>> Kind regards,
>>
> Hi Casey,
> 
> With this remoeproc cooling abstraction layer, we have integrated your patches for subsystem cooling. As lot of comments came for qmi-cooling driver, so need to send v2 with cleanup.

Gaurav - the question somewhere in the series was that why you had marked your patch series 
to v1, when you had revived the original (v1?) series from Casey? Should we consider
current patch series as v2 then? I don't know if that comment was concluded. 

---Trilok Soni


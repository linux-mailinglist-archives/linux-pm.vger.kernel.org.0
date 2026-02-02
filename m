Return-Path: <linux-pm+bounces-41888-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DQvK5d3gGmo8gIAu9opvQ
	(envelope-from <linux-pm+bounces-41888-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 11:08:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A994CA912
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 11:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7EC53027363
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 10:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08917356A08;
	Mon,  2 Feb 2026 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G93WKS+A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RelfcC7/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6732E6CA5
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026559; cv=none; b=hmHu/GPV5ccB4KryVEQ8kHeC0puAkI1Bg9JGxDWH6KE8hIE9CR8CYPw3oadvG/Zk9MHt6stUwIVMTgfe40kyx1sFpAMiBpRXfNb1KS+p3yp8C7xd7ZYzxQbdR6R+Y8fZjv9LjaJeFrZ6FcY3Fm9XrU9McmbgxMH37ZRjdqauzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026559; c=relaxed/simple;
	bh=JDSeexC0+JEFNCPV/nFoAtVuXSlVMpI6OdGFK/M9k6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJRgDt/k/tFKzw9h/dyEhHc9XscHymCSFn8VhDVfN0IscX4XCi9GRdN2g0PB2JbSezDYzjANJdH6vl+mZhi5moSOaKp8dUw5gEfXVEcg9W9MwVcIvaTfZCI1QzvGEH7oLRI+uHNf5dZHJgUs1EXTfBdRVDTdIRtfwc8xNs46SMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G93WKS+A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RelfcC7/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612857eF593872
	for <linux-pm@vger.kernel.org>; Mon, 2 Feb 2026 10:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jCAadpfJgT9dXEEIgywaUL4bC6A8NzSXrVe0HfftFtA=; b=G93WKS+AhHzdPX1h
	z3wSHCpza4u4nh5QC9t9MYGDXmNpzeM5weAn/OFUK4H3V5tY+YemhR/u+yxEJB+3
	AE5hc8QSiJLHu1T8Augtvt6kAnkBkN1F3WafhhJ0W1JSpNCshs2ifiIqROdeci+w
	ut8N75TQ0zvBDOB5q3PPZjuklNMW7hamV8FwNslmuDEfyNuC/llZn7GzE2j4ng15
	1HOit32Mf7BW8eSE+CnN0DXFCCAru4qeZJsVjABhvciolM9sGVZWeww1CVNOM5hy
	QL03uzyZC02tDlaehPzUkNEyZau+vAk0ypLGgno1aIMvrIagwPgA8zmfLWGXUl9Z
	mQb2YQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1avx4wbw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 10:02:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6b48c08deso69185885a.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 02:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770026555; x=1770631355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jCAadpfJgT9dXEEIgywaUL4bC6A8NzSXrVe0HfftFtA=;
        b=RelfcC7/uNfcNbB0mQGG/KoTcKCOpdbUfFtSlkMlqDIBV4VHqt5R4lmpttq8PNz9P1
         T3WIPDeRhLnUvuZ22W4qa6GqbZ0rUbDJMXs1cwDQ/sBiP1b+BcSJ3J7+8stwR55F9FD5
         y8Ekt1UNyDx36CglR5TOyClUJu5XJ6CYry0FMzk5RamkBvrLYtW0FkDHQeP8ugX0/hJB
         8T8UtRBkj2C25Bkv+V4/ICxBpeT76JC+YPB+C4BMH0hwKir7S/+izgnH9cLp4uAf4TVY
         mokOAjLpr7J7Aepln3wl76zrCLlEeXk9qjLicuqH86ZeJ1m9RZEa8PqhjFV8XpXNAUNr
         f1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770026555; x=1770631355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCAadpfJgT9dXEEIgywaUL4bC6A8NzSXrVe0HfftFtA=;
        b=XS1HWpHgUhfT/JCoidEwHelxK6Me6oPCERKyOAonyS+HU3GtVqvdrHblnifRXnKrvk
         bpe+sHTLqrwyPB/zJsknMQucySIgxJQT5vMbrTFFbtzp3DtXiNe6zKxubrYZk9w8aZfg
         0qrhaiEQbYUDE10/OsRTmH0vhIq8xv7OJgFcqhvnOuxHpvrW3JZIVE46iWcjD9lfnU1E
         0UCezJvzzdTRWDC75dumbUbdu7J8um8KUHfEpy+Du0GtGXtWD02pM4B3+hz+lcOyEY2M
         u4Uc3nuE2F6tDDINsSjLOCQxobJoo+mOnI4nZaaQPBJofPoBhJ5yW7SqllFWit87Adfw
         cjiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+zmkCwE9nzn0EkueZtwhazbMEPjQbn3QPERYhhjH5XQClGPoLyGz4c1CyEL+sJHu6cKYBp1MPtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3UhVG/ls7o8tP2vgjwC1ClVcJBc66HLUC8tx1Yp7sQWDqfSrV
	AWMofVlWYo2pwfAJxhLmRmBeiyIqtjTzhmMUQu3LUhUIdIB/stskpx6BcxQtrRT2YScPcJ4X7oi
	vrH2dzCA2LZ6mlANy1rv0OcxsQPfj8oGQPNwChdFJ9ohkTxXflOw/6gvSyN6YRw==
X-Gm-Gg: AZuq6aLMJnJqfoMGGATQRukuinGvqZH91MFJeQNv5vTrrZFgk5j/UpN89yZyc8c5Jop
	S8uY+0JwVZ5RCvzpVrlTDT2vPgdl1qITGnccVclY70Tu86oZxd6SxfZ27KsjvehqhkFS9tgL8WR
	BAtzs41Xt78D6Z+uP41RtkfV77Qr+c8du//JpIGFmaESeLMliotRD91LItv0Io59j3cIpUKbo1Q
	YBbWN5hXTSek6/UfQzTusletzkV6JWNHsbL3eS0R1U5cBIjWaLPoLkOmxYCtN6rZ8shjSgju3jz
	6772MAVdgRUd8saB8Kyy7blFUJnlBtZAntz0bIIChd9KlG5YC4seVeRb9+mG79UWmznStSLYZK8
	+2plFYN48gYg5YEezJ+RpgHHCGPSW0NqFLu0kw9MRbx4viFu8dolcbJGX+xnj79TY/oI=
X-Received: by 2002:a05:620a:4009:b0:8c7:9e6:3a4e with SMTP id af79cd13be357-8c9eb10f0a2mr1033781785a.0.1770026555473;
        Mon, 02 Feb 2026 02:02:35 -0800 (PST)
X-Received: by 2002:a05:620a:4009:b0:8c7:9e6:3a4e with SMTP id af79cd13be357-8c9eb10f0a2mr1033779985a.0.1770026555002;
        Mon, 02 Feb 2026 02:02:35 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf1c500bsm837501866b.54.2026.02.02.02.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 02:02:34 -0800 (PST)
Message-ID: <231ae9c2-bb3b-430c-990c-deab6a8a0d0b@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 11:02:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] media: venus: scale MMCX power domain on SM8250
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, Jonathan Marek <jonathan@marek.ca>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
 <20260201-iris-venus-fix-sm8250-v2-5-6f40d2605c89@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260201-iris-venus-fix-sm8250-v2-5-6f40d2605c89@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: O3D1DzkooXZPYK9wMQFAWsXfUMwkPilz
X-Proofpoint-GUID: O3D1DzkooXZPYK9wMQFAWsXfUMwkPilz
X-Authority-Analysis: v=2.4 cv=P4w3RyAu c=1 sm=1 tr=0 ts=6980763c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=v07b0KzaqYqj_yNn1HoA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA4NSBTYWx0ZWRfX91/h9H02t4jN
 q6F2ea7V7yOmEQFm5o3XrtUcDEfRWBU31EgB8w1yuF+yx20P1qIL6hSxyfrFdzgqEPYjTRovoyg
 bI/nYf6o3+uP4agbFijRh883vj+qIpQVkJAZJHJHaTnnaYIZcJ9R+XevrMa7Ceab+fh+aGLtsm7
 IlfpCnql9wcGWTQP9SWmICSDxEbN7pfgbp0r8/IamN2Y6+ndP71RhoOkAAKyhbU+3LBZNLgwf4t
 aQd1PrUzNAb8FklGmuPrIKEW+MCaPPBI1NlAA1BSsHOLj7+1t3vp5mqy9GKg8KxSzY/+46WyCVO
 QDxV+G+dlA16y8jaYdw1ibsiyZUrJIU2oGwi88cvU7j3UYbJuih1son/yxK4GLTxz2C2/wRaXFp
 Ex0fiZpaNHlPmtN9pnAMFfJ67lD+0a1kOfOH8XGMLzLbMydY/aVa0N2XAkbaj72i1CPADBC+7kM
 /IaSqMEEZ3R6bZelClw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020085
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41888-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2A994CA912
X-Rspamd-Action: no action

On 2/1/26 11:49 AM, Dmitry Baryshkov wrote:
> On SM8250 most of the video clocks are powered by the MMCX domain, while
> the PLL it powered on by the MX domain. Extend the driver to support
> scaling both power domains, while keeping compatibitility with the
> existing DTs, which define only the MX domain.
> 
> Fixes: 0aeabfa29a9c ("media: venus: core: add sm8250 DT compatible and resource data")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

> @@ -904,6 +904,12 @@ static int vcodec_domains_get(struct venus_core *core)
>  
>  	/* Attach the power domain for setting performance state */
>  	ret = devm_pm_domain_attach_list(dev, &opp_pd_data, &core->opp_pmdomain);
> +	/* backwards compatibility for incomplete ABI SM8250 */

"eeeh", I'd rather error out since it can't guarantee to have its
power fully on

Konrad

> +	if (ret == -ENODEV &&
> +	    of_device_is_compatible(dev->of_node, "qcom,sm8250-venus")) {
> +		opp_pd_data.num_pd_names--;
> +		ret = devm_pm_domain_attach_list(dev, &opp_pd_data, &core->opp_pmdomain);
> +	}
>  	if (ret < 0)
>  		return ret;
>  
> 


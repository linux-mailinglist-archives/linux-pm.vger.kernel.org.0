Return-Path: <linux-pm+bounces-41158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E04D3C556
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 11:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2768C5A66C9
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 10:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305763ECBF9;
	Tue, 20 Jan 2026 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HV7azG+m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fkVhLE8f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BBB3B5307
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904631; cv=none; b=I3AVVVqHgdA7H7ImvNRYlnW6yMur8kI6On/bw4qME9c+KPlnDG1QEANs8us8FPU8qnhM6+n1RPTTUT6b1VbVsi4vqQTIx0gahw2l8i4doYEtH0Zpg+bG5WrJjUVf+YFDyRwXT3lfYWU5gSLqUWVZzpJH7jhYS+lljW8hvVffz8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904631; c=relaxed/simple;
	bh=hUp2AUFNUq93Bp6ppatsRqlcT3ZnCeBVLF6I3MRu1r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hODgzN/i6GJRGe6SoFHPasN20H0cn0L9XAG2e8OZ89yNacvzpaxPDj7Ks0Bi7RDub5tYnAc0RM0cHKmcZps58AKQeFeYUg31bNZPT9sDDwN56bZeLo+TrqLP7y/HmtV0jg4JofTaU9WB3/1k3HpOtJLgqSs6yRkBAmbwkDHFkWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HV7azG+m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fkVhLE8f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K99mSj3176740
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 10:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tVmh/T3w1mec8s2O1R8qTBALfgWud0ml2aH8x0oKQrY=; b=HV7azG+mVcn19f60
	U+vBdHLDoXUj608hHCZZp7FCmwb4qaSt96KsBpeQysrhyhvfUY7QxvDhbQowOOHc
	K4QD73Qs2KfCTR2xMxXU88PwjJwKnibj2hpnpcJQkRGXAZ4B7/PyjuZKbBQcXUTl
	XwzvS9T3cBNoP2e6cfzN94UP5SkyVhqJEc5sboBftmZ/zCkPRkBE8AH22GZ/j4U9
	jCN6omWMkgnoetyzqBjYjoh9piTNdxiQSiRzPcCv4eefqt6YSrMeNRBlyQaqXvyW
	kT/VTGtL8FpCZRRxzDAHSOl2mm4HZbq9DtFFP8k1nqcdPKBtOv9uO44ac2vHwMl9
	/Uemew==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt0p2hcaq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 10:23:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6a182d4e1so126592085a.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 02:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768904626; x=1769509426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVmh/T3w1mec8s2O1R8qTBALfgWud0ml2aH8x0oKQrY=;
        b=fkVhLE8fCMsCINnPsAF0whyTnCaqWj/2RHcX1OKv6rCADoRi5bq/MIpSF1x+qmLme7
         DocWDmjaPFr/nO2Yn05JsTUC1nhrz461fLtOr5EepnkwNd4/yr6Bff43FU4BwdWvgx0B
         EFEf8v1E8AaAnveuv7bTdakA3AENjFIyVdMjDcToSskX6oS0w1JRCf+g22449rZWv8v/
         AMG1mh+yZlPPLPkurL4U9s7rNn6PWVF+9h++z3uxUvrThrm04lvBeRJMETvKDZc+UsDZ
         eRRB+odUt6amq0HmgT+VCGrC/6Hx4wIXmSdpk2zXhTY1CScFdwxXumsJPFSbYyVX9V1H
         +Zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768904626; x=1769509426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVmh/T3w1mec8s2O1R8qTBALfgWud0ml2aH8x0oKQrY=;
        b=PgbRwcUBaRTK5OlCtgumBV9YoCfVnLkO6d/xolFKQwTSv8Qw0aNRtJLldZOLOCHwRm
         q9y2z2ha6YQBJRPdOubpK2Q0mCJB257+4KqRyLNhr3CTJ/8skdd6LuXsGD71WIGMYtlX
         GN1ZdkTFspOH/SpOz5GdYwr2T7CeS8l3lBR1njyhXjDJinzb1pot/gOn1KkeTYZPU1ee
         TyG4kdJ5LrKJD1D6z1K6+YjNFXGID9TMC1Lehgcnu7EDYTNwsIxvumprbPjAEwLCFU8y
         e2Qsa4W604DGkhL9KyUOimtQW1mxi38BPACVifDZRfKutNBHE/jgGtas2BqySYZQ0wHg
         aArg==
X-Forwarded-Encrypted: i=1; AJvYcCWifhj8MxGIs5KcDCzIH/Ln+ZWRPq7jWzQoH9SoZJ+FRXnnVfImQHIDGx3z9QsiG8V/w2+4FW/QjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNot2TT18kFIAuUHPgZykISLb6Vffdq5Dp+pybklfkRobvEQby
	fVZRz6TnkfzfzlgITJ+2N8gqYxtRYAyjThuAAmd65qZ1uJqBr2g5QH/G+OwImZRBE57kKGVc3+N
	vk1wcQdweQ3nYBDJt7Qmu/0dbvSG2jH9JJHMYQ+sKvx981MJmQu3mTJ21BakCPQ==
X-Gm-Gg: AY/fxX5H9ZT7mTZGpZw//zbHP24ptp2qj+Y6z2eOYbWubDQiuz5JmwLbtAwpw8hF3NT
	f/3zjnbv/se0Wz7sq6eJ8ikyqkVUOKFusZQwkmHN2cRB816nbEi4yolDKn8nTXOoyti0aUej1He
	8hzK7sHiXPHi8apjeEiwRKTMxPTM40fAF166P/yD7jsBajIoYMQy3VyzyH30FsLCGh4DJxBAjlU
	tBIE9wxqWKAdYxnbgKN6hsvZWqMGc3QjcAThcISCied0qhGLz8xfVlcC39at4wtLNeRi6x7WW79
	pJFJ6WxqNmkkLf2QjBS+jdUxX7IVhPToMErr03zSHt/JnvppDsIiU65DfFjZUk+61KIbMcUPBoH
	rNXafMHngnuu/V9osj0RFniwZ8KAPEN/NGwXin+87rN0MlxLv4SppF6T6k2l/aYxIs2Q=
X-Received: by 2002:a05:620a:4511:b0:8b2:ddd3:adae with SMTP id af79cd13be357-8c6ca2dd593mr233690085a.0.1768904626362;
        Tue, 20 Jan 2026 02:23:46 -0800 (PST)
X-Received: by 2002:a05:620a:4511:b0:8b2:ddd3:adae with SMTP id af79cd13be357-8c6ca2dd593mr233687485a.0.1768904625908;
        Tue, 20 Jan 2026 02:23:45 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87ed991b75sm389366366b.1.2026.01.20.02.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 02:23:45 -0800 (PST)
Message-ID: <723487fb-c7b2-4538-84a9-4e9b332d8bd4@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 11:23:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] interconnect: qcom: qcs8300: fix the num_links for nsp
 icc node
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260120-monaco_num_links_fix_nsp_ebi_path-v3-1-536be21ce3ff@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260120-monaco_num_links_fix_nsp_ebi_path-v3-1-536be21ce3ff@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: spRE3Q2KEupdWiICkrpmfHJBJfqgxxOC
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=696f57b4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=6vwwWfy6E0AWDsUvRZ4A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: spRE3Q2KEupdWiICkrpmfHJBJfqgxxOC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA4NiBTYWx0ZWRfX1n25GukewbNb
 xIxACm+TI4SP65mv7II5LhxAU2qhX58f1p/TJSurNAo/MLr4ZW3UEIu1fWiRQi+7n+Zog772V6L
 mwNKsVJLRmxMn8vGhUBDPmnpgR+s1fulBpeCso8QTzABEHycGFstCX3WhYUe1e8Y8PSCGTduPYO
 F0JoSG5s6bq0mf2pthi1zvG1yZzO6BTGyUui5nv+Qiqu96uUOJePXOQo0NK+SU3ullZdnCTztly
 2X6n0t4TE2iLAATIely99R+uPFBaTUnZ9KlO1JRxiXsYhToyTIZgbUUhQu/i7lqrB0gwRFbemX3
 xmSImdxyGsywRo//LE4gNKuBda5m2s5Fi6YKbBPedUddhHj60woMxy/jwiyOBI72fsqCr3frYYy
 4OafFO1KhBsvBr9jsiQy3U0n2aNotfMjG3s+7g9ySfw3FbnNIouszG03aUuDc/pjADOyy2Vzylq
 vFaCzriNstoz56MDlJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200086

On 1/20/26 10:30 AM, Raviteja Laggyshetty wrote:
> The qxm_nsp node is configured with an incorrect num_links value,
> causing remoteproc driver to fail probing because it cannot acquire the
> interconnect path for qxm_nsp -> ebi. This results in the following
> error in dmesg:
> 
>   platform 26300000.remoteproc: deferred probe pending:
>   qcom_q6v5_pas: failed to acquire interconnect path
> 
> Set num_links to 2 to match the two link_nodes, allowing remoteproc
> clients to obtain the correct path handle and vote on qxm_nsp -> ebi.
> 
> Fixes: 874be3339c85 ("interconnect: qcom: qcs8300: convert to dynamic IDs")
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad



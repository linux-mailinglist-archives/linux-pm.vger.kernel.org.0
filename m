Return-Path: <linux-pm+bounces-39391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8770ACB1DA4
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 05:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 095C0306DCAA
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 04:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDB830DEAD;
	Wed, 10 Dec 2025 04:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fLNkKbDK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NGDR3mlF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3B6225390
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 04:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765339233; cv=none; b=oI77gATJTIUw1fkrUciRSh6CraUIMC3F6vDzH5zqSOYn7HjBMP5MiOhCIBS2QUoRf6FUC6uc3r7Jm4x2m4yMKHIDBTwBPK/8viqdhdPev0lmfb61JkWnpaZvhE2GxXZ3RTu5NP6kbKIybRroOPY2hjkXvp63wnYvbQH9SNCP/m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765339233; c=relaxed/simple;
	bh=k6u1C8Qj3YHkNv034/IKfYniHPKbmkjXD6jqdtosiRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3S3kY52smkvDuYKd5+rxsnG4g3qGigGzmwJIDuIAJPtaerWNJeB2vm045d1q4wC9DEFP/i69L6jdapnHB93lyk3ClPf55HfSviXvGVMQKmF+RImk+HA53YjzQHlEJtpZdc+whl/YCAqXqLgA9BF1rW5F5S2trmRa8iJGI2nTpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fLNkKbDK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NGDR3mlF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BA3MjME882071
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 04:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6numdDDWlOF4BEoGQaJktoTO
	bWSx4NQ6AWfsAvI5qTE=; b=fLNkKbDKcPDCwsl547vCG16XT8vWJAx/DHewJIkC
	fF00JaEC4Ywf0H6ksO1/2vxoOr5Dug1biqsM+PPoNFTPI92Vb95/LOuWfF3gLcy8
	x+9XHeHMRNoVFXpTHwnP7S6WFonEUcC3rjvBZfWnx7+xKhwtSEJxiiE4Cmjm8VwQ
	C2WtWns3DmG/ro+UNlPmEDG03CXc4WpoCDqZDrzg5qjHkMJYNryfnGN0lDMQ+ASc
	cfeqI3Ax6c2JXoLEF3ysIsIAQ41EVxdK16YsMCCyk4D14B8gpp8NTxvt75ZRbL37
	gjdOs1QBg4p7xY8ap2/TlVt3aXveE85br/sQK9+XKrjn2Q==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axp4vtbxt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 04:00:29 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5595bbdbf49so3107795e0c.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2025 20:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765339228; x=1765944028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6numdDDWlOF4BEoGQaJktoTObWSx4NQ6AWfsAvI5qTE=;
        b=NGDR3mlFpy1logJ/JjIO3yN6iSUb/JCl6hhIUKfersicltbivxBX+eh6Qdhl5lOlEA
         T82P/7gV16pTSfptvuGrJo87onEM6IX13DJ92wUhlFyQ1FtifQeQUQwMQQ6oYlj5Us7v
         UbyhvUPx4iXmZk2h+BTew6kaHDFvLKRPXVhQovV65TcaymVLOr7HrjGOqC2NuBeBVpEL
         V23sE14HW5PGbRN+cSzFyEL+rFFpnhca0zWehTeMwBINAeSXzECaHfKZZMNOcSuDAznj
         BO6gSIEgK7k8EdVqDv93BYNSVEfmMRcZvTwW5PT/ZHR1aI6lbwN3h7LGXaMekkhNHDK8
         r5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765339228; x=1765944028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6numdDDWlOF4BEoGQaJktoTObWSx4NQ6AWfsAvI5qTE=;
        b=hx+Lin1dShotIFWhklUq7RUyaZX1QuIoVIYyMxX6L0G3ljSuqbHj55DirIH7Xat4hi
         7GRga/sUwkBSoOcCEQ6fI9KBzBsBBmo7osyc0AweQgu0YcVzPpcC1VdShoMDwTET6+L5
         7Lrbw3HcbP+nPh0fPjlN4xpKjUNHmdTJMJZTZ7x5I4B30Jz1zAQnmhz5DUmr5DLmbjGz
         1LJuvwHDMcfs6/b0FN4TE5U49O1zzubtnKsq2g1rOWvwd8IC3mYIAxiaj4iXPYl3dFNP
         jwRGSqw84CavRF3pfE35qVZ+7p9f8rmjwb8FQypTB1v8f5YCwuxgounvlZhxp4oS9cuy
         iNQw==
X-Forwarded-Encrypted: i=1; AJvYcCU4/aJhWxwibk6jiGBv/aR+3a9xN1MKjJDacAzZSepSOcQiRnMogfcfla/+rxmSFk4EsSTTT3lTxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/+PG3mD4K6s3jHPJFGliDhDN8t8X5ldgCNqjOOzbY066/eTCT
	HlzhWy34bNBDUbynfZgP/GYtqFPjryW6IiyOT0IsXSW/mTX9m36uEDmPX601nkTTtjZUzs9zWuY
	Skr1pwadtpM92uOP846Ujxive8R3qois+n7+9cetzfDX+e73fSmAYerNUxVdxzQ==
X-Gm-Gg: AY/fxX5LzzqGQo+br9/kPVjZHicoZaoQ3HMGe4uFt+wmiGUlKcBrWTTpvZaVI7VO92o
	99dquAwFTJaSxcRvvPAftyt7vyK0Hgs09iMncbMfEQf82kwwwuF2fOBJpgeGAnkdiJrEua18fUP
	fO0S8KZ6T2jUFNW1dylMLnu4KM5gboyiIyRad42TmdA4aOQPujcYSsGTKvdJsLpU/z06LnComHw
	uYNlOlOBFG8UZN0Ht9hjFW8iQT33MmFmT9uJHC5tP4D5Ikmwc8ExfHvawn75k4UK2Pvr/oZaDtE
	WCZl7mfC4JE9EZ93bBjrhcLGnPgd+SUvL5xukOzvwjHgufGNeQ3oFDlBZKO4ksn98XCI8/Svxjk
	6oLVYXBlOefnu14I2g9p6IGI4VsGgjvWo9hf+DSMRyJa98glMObOQHLy+EUqdkGRdRJVazHizG1
	O80BHIYnz9NUUlN6bY4ctXeqM=
X-Received: by 2002:a05:6122:8286:b0:552:2c5a:c057 with SMTP id 71dfb90a1353d-55fcfc1369amr338189e0c.13.1765339228571;
        Tue, 09 Dec 2025 20:00:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjTjEp1NQ8eIsuOt0q0tQ1yjMV7eA0kBY/m32fSx6Pcjv+vj2YCZ6S/QaxPkjRnXLROkpk6w==
X-Received: by 2002:a05:6122:8286:b0:552:2c5a:c057 with SMTP id 71dfb90a1353d-55fcfc1369amr338178e0c.13.1765339228116;
        Tue, 09 Dec 2025 20:00:28 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37faa888507sm10765051fa.28.2025.12.09.20.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 20:00:27 -0800 (PST)
Date: Wed, 10 Dec 2025 06:00:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v4 8/9] arm64: dts: qcom: Add initial Milos dtsi
Message-ID: <bv2ojys2zgnd7bx4e6yunyjewqtkobxanpzd63bxrus6373vru@r7rsfbeh46cj>
References: <20251210-sm7635-fp6-initial-v4-0-b05fddd8b45c@fairphone.com>
 <20251210-sm7635-fp6-initial-v4-8-b05fddd8b45c@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210-sm7635-fp6-initial-v4-8-b05fddd8b45c@fairphone.com>
X-Proofpoint-GUID: jh2DHHeSpabOhKcyllDzJHEUXbBemmMO
X-Proofpoint-ORIG-GUID: jh2DHHeSpabOhKcyllDzJHEUXbBemmMO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDAzMiBTYWx0ZWRfX6R4krTpNhqeY
 P0dhGdRjf2Ys3/jqFffgOZi1LcQlAw58IzbGR9Md3nuTpJrz2S5HckGMFKucHGC5+DVZVejdn53
 1b8xJwPKty5niZpok3ZEH8/2XuXaaPuHsHbza3/8rwbxt87ahtdNXI7mPInpTLZC0j+DBhAvR8E
 R5iCW/HI6/FyKe9/1+wsNtTGeN8t8IeUUp3j4hJZ7ORJHyAKeYwpTaMeZm1ytGZ1qogK203y6xi
 hBdr8PFQj+5I+1XHQPMyzKByNbN3+5m7JaJgRMA4vY/b69Qq6nOfdwckJxvIDSd3DIhcsPGVBG/
 qaN2rWzaB4JQG+LbuvuRWXKW8WUA20/2ORIw5huIshCqjkF+WY/bnIgEbtIoKINampU+S1PPh3p
 xbNdkjqj+hFBQhKvoD0fHhdNE0oEig==
X-Authority-Analysis: v=2.4 cv=IoYTsb/g c=1 sm=1 tr=0 ts=6938f05d cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=WSIVeowOIUgBBEAWWbIA:9 a=CjuIK1q_8ugA:10
 a=XD7yVLdPMpWraOa8Un9W:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512100032

On Wed, Dec 10, 2025 at 10:43:32AM +0900, Luca Weiss wrote:
> Add a devicetree description for the Milos SoC, which is for example
> Snapdragon 7s Gen 3 (SM7635).
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/milos.dtsi | 2633 +++++++++++++++++++++++++++++++++++
>  1 file changed, 2633 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


Return-Path: <linux-pm+bounces-42032-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIAIDTi2gmnwYgMAu9opvQ
	(envelope-from <linux-pm+bounces-42032-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 04:00:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E50E1176
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 04:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2047A30CAC64
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 02:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195CF2DC781;
	Wed,  4 Feb 2026 02:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SmRFepmt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bHLdGiJ5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D9B2D8DC2
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770173950; cv=none; b=mU4a3GMsX9KUyAF8a2T3ompHixCDpLH/IPN2KEsUpZ4Qp+KhJ5WxTs3ztZQWd1W680w5h4kH17Y2Kv4QrWyKfbXJ7C4iBLLomf2dTljnIeWj6WvriAy3wLcmpA3bkkE3RgYTAcpPBQ3K4wX1auPJm9F3PAjAUUIYmNJd1jSkUes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770173950; c=relaxed/simple;
	bh=MDUhv9kPW/KDT4F7QnvbtIkelI9+ZR22YQ76HoD+Hfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cu8llku4sCXnAoYN4pOUVKetpm2WlznuxQwcw/P9K4viGHWgc9gvWD8D0z+Jq6LrhrD/Csy8TOyKcEme7Q4L16JbE/F1nLnPRMuQ/0M6mkSPC5Nm/4CatAKDiwAnG/v8zIL0BGG5xpG5zJjPJf0tQoyYJpzts98/vmRrzJnxwB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SmRFepmt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bHLdGiJ5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613ImQvq3824358
	for <linux-pm@vger.kernel.org>; Wed, 4 Feb 2026 02:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5La6/aWRLYj3GgrIklIllWJb
	pV2bq/VzjvPBl/F5s0E=; b=SmRFepmtmhPEjQU82HCChM21IAxQjxOFgbQ2uq00
	OQpmtkKzpeDqeNkTupqJr4CeiSFG5oIYqiy8fdskvQPRkKPWPm3CLPMPI8y4qbOb
	bixGSCOyM8jw/zqQH98mMVSbQETfoDGgXDk6Pa+8ehF34O45XHGDwf4909h34kMQ
	PtBzHMy/RthL85BRhpOyOY2nPJm+poM+ZugaMlFqOohcoZrC3wOgqtAi+H8UcHp+
	M38iUbuNqSjnQ2jUfQJiFLuvxSZfZ+jJYveWKHoVMNHQfMGNyspB2Zvp9SdRb1SL
	rq9CBzDRhDsSnFqA9twA4GQ2m49vRzzYWh+p1n7DeDuVbQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3g33jtqb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 02:59:06 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70ed6c849so1653937185a.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 18:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770173946; x=1770778746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5La6/aWRLYj3GgrIklIllWJbpV2bq/VzjvPBl/F5s0E=;
        b=bHLdGiJ5gDeArA5eohK0bYITSo52TgHJmbm2m4CBIEZ0Ekjyq/1YmOlK9+o3BYwVD5
         zOllIZ+P5U8yOpRLxQZm5cBzF7JZFbTnExiJie2pn27VPMwpcdbs+5XcnGJGR5kx6hnq
         s4gow/y8ahXTSxzhaX+5uEE+XiPbvkBEIRNMGZ79Tk12eDOv1Yt3epaFVf4zMvtg93cF
         U+/ttIJlLtkIJmTkDPqVjyONI5+TQf35NTKnyWMKlx/2xx399L4i09NStr38gSDSErUg
         A3E7mxZ6UwSozGFmsj1x9CONa+sH1a9NMOsclwEA4rtHoEdW1HTsh5fTYKTvLakgA0V8
         T5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770173946; x=1770778746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5La6/aWRLYj3GgrIklIllWJbpV2bq/VzjvPBl/F5s0E=;
        b=CNY/aAXz+VdezScLthVQFwSHStjmTtlzuhcDn1gdHKXYdqFDOo5oXRAzwnnGKabLTS
         N8sgP0dYHu18FbFyaD6a4DAww90Cf1sDc+emh26bhQ3IcF6lFzAa1O5LOaAJpNDGkimx
         +rhG2+UKeTVNn+adhjCh4K9OZJ82gOaXfei11YjkdVShOSAtcRBHZNYuo17Q3+oR3lkk
         1AFXvGmbp5lHHoh+X9BhKTauFjwA0TnayQoJJbcqQnJiVWaw8wF36CVty5FTxXBEYV2C
         2xtNdbuSfP9BogWDW6u1++Y6K/cYk0PeAlgb74vwpG5jXN6Gmym15flJxb/pDnOKNJGe
         Zpmw==
X-Forwarded-Encrypted: i=1; AJvYcCVRuIlp19Aw0Fc3CyLCynoUP68IvkUqvGFvQPhaeDTD0VL2NEdQoGe466C9nqUteVKug2zWNXuJ/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwE4fXSLRwzS4Ad5C2EljzbppreLErPBrgbnSeCyr82DnO2WUtH
	eKzVpElbhhGKP8a/zvxXQ7aBCzLUKVHSQtzROD4wNM26sMJeqi4E0n2WTeoVZHK52yxmKH/M51p
	dklukfwE52F4CET3UgTp0JL2bCSk92xeiBwTg3aEOmPjBxpRNZjAFy9gLiiDDTw==
X-Gm-Gg: AZuq6aLvqD5yByboK3tits+hPUaePowuKbb/48KTT0Ur2muzYa15T4DsrR8ryrTKYXb
	unF6kJ29JbCXLGui5qJ0s1ww1JYvOqaJI4jIcq0WXdeMA27akaqbJf2+TjfAH3Y03xp7OYuvfJ5
	q4+XkkU1LaH9z4Z0OCwikExmyJMEAcOhAhPlc8d1iQiyPmNFlzMLdoQeMB4/VmFQN1DEpw/vWEi
	RTHjh8CjnUU9Tmf2EtkEqNSOVN6sROKhgGlBhTgBkXAltVjts9cE0svJuAnlGMiDPWbDMEw1w5o
	xZmPY/P9osZONCaVo6b7YlVou3AOO7P1Zf8hEv15ZzBOwqsf2BNNszyVU+6qDpJ3ioXcNdgSCJX
	Nsk7mBRp0FhxWJwEG8qguy6DVWvJflwO7UGrLr+wkYCLvZycylR9omMMNtESmBunBZzU9EikojQ
	C6JGA5uLtFskLDzC+FNPbInRE=
X-Received: by 2002:a05:620a:1914:b0:8c6:a213:8fe0 with SMTP id af79cd13be357-8ca2f849f34mr212284785a.23.1770173945894;
        Tue, 03 Feb 2026 18:59:05 -0800 (PST)
X-Received: by 2002:a05:620a:1914:b0:8c6:a213:8fe0 with SMTP id af79cd13be357-8ca2f849f34mr212282585a.23.1770173945477;
        Tue, 03 Feb 2026 18:59:05 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3869204003esm2227891fa.28.2026.02.03.18.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 18:59:03 -0800 (PST)
Date: Wed, 4 Feb 2026 04:59:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: qcs8300: Add clocks for QoS
 configuration
Message-ID: <daiw46t6nxxrmut7epilnu5cunhli5wgeqv2om6sfk4ejwfmmf@uucjs32ce3wk>
References: <20260127090116.1438780-1-odelu.kukatla@oss.qualcomm.com>
 <20260127090116.1438780-4-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127090116.1438780-4-odelu.kukatla@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=afVsXBot c=1 sm=1 tr=0 ts=6982b5fa cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=sc4ExDOf6ksMT09hswsA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: GB0CoQInKQilRLY9gkEGVvonOgzBH8dA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAxOCBTYWx0ZWRfX0gFKHmVbqYaT
 XQbF3KEJGkKWEuvkx1+zFxUwsPPcfLVaFRXuwGj3fpHgdERtO1CFwaZZ67KCPJOSK2azKVFfuye
 ALWAqZ0s3MV8+0QvsPyO/VCi+r1khzg0ggMFCspfvjSl3qDF4uMgZSG/Zu0wSralH4+x0Z9RzqW
 OwxRNNkgmHWlgVcOUTGjdNoKtM6Mmr2pQclLxN3jhM2Lh3E0rgGWaCduhcx9+qjgHoOhTgg5Y05
 HvKYLYWwLhjyOTHq1XRup/GHzuGHinL13RAqHkDYEVPA+3yseIHbkyfatNx9+Zod/PTrMlEFxZE
 uVklkw9y9lYK4Z4Jopqb/kok9+gvCohyEB0A9TvSAEDvKVUF0tqgkEfrit9QcpDzCPM/TcwuZog
 mLV8HOk0ub+u+oOQFrU9X48p8SYTQ7rIpLqs+0ovOffR2k8vgkKRWMZqwhrIBG6R6e6oXriXDKU
 NMPXfVKP9TwRzoq4XiQ==
X-Proofpoint-GUID: GB0CoQInKQilRLY9gkEGVvonOgzBH8dA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040018
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42032-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 94E50E1176
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 02:31:16PM +0530, Odelu Kukatla wrote:
> Add clocks which need to be enabled for configuring QoS on
> qcs8300 SoC.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


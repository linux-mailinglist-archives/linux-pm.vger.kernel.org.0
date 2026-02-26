Return-Path: <linux-pm+bounces-43225-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OHMG6evn2kAdQQAu9opvQ
	(envelope-from <linux-pm+bounces-43225-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 03:27:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 151741A0195
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 03:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C8BC3026AB8
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 02:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0444374733;
	Thu, 26 Feb 2026 02:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MY352vsT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aZWUpUo+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615D2374720
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 02:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772072867; cv=none; b=iP3JtRnwPSauFLMIJAsJIGTIn79iRSF2hqC7kiroolU9YLUuJjm/fjjaWOiAizPyqUE03BB4QPa+w66yA1WpM97IfOrVzUl1S06d2fgaLdo1hhcvAvtM6WqmE0o+LE2PFJ0CW++Qgh0tXxVXQTGzq+JM8eImi+vnDxxVkrJC3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772072867; c=relaxed/simple;
	bh=0afPbzTRb3UPGydEkttEYkJyawIuXJ1ku2cfpqMLNy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PD8nMCUfknWrC6bwTuXauiZsXACcyLFeadHZwMWd6OmXlpu+YpunaueGhJubyV3WptWO8waRLytX8eZkeUPDS1sWEGOMvgjYxjjII6JpuYwGbwjAWMuaB+IZNCHkg5c7FBXiz8t/X880SsWzWnAOiPmolvzIpHrjbVcf+XDfm3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MY352vsT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aZWUpUo+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PHa49T3056486
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 02:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yRgG+FSy5Tv9HXEJSby1T5Gf
	NUrd7SZUPbnRQ5PAy5U=; b=MY352vsTQhdJvcTEh6Eh/mzsrHY39PG/NyHIAolm
	K4I6y/8tRwhHatN9zH1LB+NFfKmi11z8ggdpkMQdZGQBDgfKRm/01FB+HxwmRBsr
	HBamh4dGt+dK5qT34cmpseMbvA9Ake7DdqHamUx4We640yAR3NZNqjCqZllEbOS6
	NI2uBzdGBpHD5Gu5l1A/YTa9CJwAdKa4m/zSav8QIUGNrMxzlsW3m7cxbrtcCqTG
	Y5LCOfN9KLSB5rQbVL507UQzi9ls6fwKpBvDwE7JoGb+WHX1/Ul8GV6y9EvBUCtc
	bkSOTqzYmqP/u9+u3Y2PWqxlNgr/rOLYWLuySs6lOX3chw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chx39jwvt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 02:27:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb4e37a796so209024985a.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 18:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772072864; x=1772677664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yRgG+FSy5Tv9HXEJSby1T5GfNUrd7SZUPbnRQ5PAy5U=;
        b=aZWUpUo+pNQVq/6lHLzI457l3cNosA6Sc4/9UUZo/Grf8THKAJ5786m9Adj0MzeQLH
         Xuu0dQeKzg3f2VLx220GKnDDnHRTk2kkiTePUDBxrWc6f07wpqlxhicOKj8Z3kh/msqw
         I8sYkUG/AVPU/qnvAkQe44NQtZDtzqYfQOkAj1qQjxmzg1n8UoJVip5rvI/0nGvF72xl
         QerftDx3HVzeBEVP0mC0gdh37SxVLdrelhTQjF+Ty52IsKDsH+JMkxQBKDiEowt1+gF0
         SKyvrKIYGM8Balk2sNVobJIUUMAb0xokfsNRgZjcye99+F+qK7qCntBdgrHQKuzbsVc2
         IECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772072864; x=1772677664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRgG+FSy5Tv9HXEJSby1T5GfNUrd7SZUPbnRQ5PAy5U=;
        b=RyM+im+iYc2VyPBdRwrGO9BN8ga2rOjaz8QrDGVTVauT/TeA2i3jl5tTswPzVaXZS3
         TXg5Bz4tstyqtPpaC3I8tTUUbJ1RiVdIja7iy98+JwG4pi9NTOodVoOKp3KGSRi2qRTt
         R3TTQoivuK7oxewRx7yC1FbaIMF9ddwDvFT2+Qef6eBsqXhtJv6GDGzTu7H6NBmXoZHf
         h4Rkai4sBp0gvGsQUeq/gQndosP33F7KiGfJqy/q8ta/GVz0QgZPFnO86zY1r4P7y4/I
         jdU/pcNKh9Qba99nTxKGyEQihKCgQpAUHBP2QdSMimNBTmbZcEZw3FvNLSSKGboEbZjR
         1sIw==
X-Forwarded-Encrypted: i=1; AJvYcCVPfcYrywpRSz2d7WcBVcj01ni9mIemIVNJHVp2stNq7sy0VserAc30lUqKJzkfBoOkBDBeysCVPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpufPtJbvwd9DjzRI3eH0xOuwTQwLVPcud6z5YQGIlz43row+H
	lEf1dh3MOYtT/UM8Bs7EPhqaWhIVhC19QEOm8/h68hA+Ppukb96FXGW3OC/sKqd+oPJm0MMvoXm
	OPIpBDDDngAKvZhlFvLwNYamc6eyvnaIjgRi+4sI3xPJf7xqdHSWtH8gycbxSHA==
X-Gm-Gg: ATEYQzy5s7woClhFe1J7NB12HyNZTmtdN4W/NxnfdN51TYvwH2khwNBXN5yS6T/GUPt
	u/Oqye6n20ruJxsjwgcRFmLY6A8ncoVXbmbC0S9Z9e/S9DskOPL4PxCrVtz/l6W+eP/fTRXlSSU
	MJ3I9ybitFESYF8UcfJh/Z99b4RKJsacncPaEYyyN4Uh8h2OKJMz2ZInpxoUBHdokw3nrGvRmm3
	hnOXhLywq1vmvQsNapc8Os9PnTc+yoYMWFvyyTdg1A+rqbkU301IC3HMZzZfKGfUriTQMXLYOxj
	vkG1l1neV+jmjX7QA4gL95amAUlGR0KdHhCN0WQ9mPWNAZ61f74B4k3z5FaSTV+Bw8waXax9hWk
	zld8V91ioVGmID+At+JZ4sukkjdKGWSxDO6j9pzOM8rzgmfc4Z/FabUJ+Ftt2RWqaiuKbLnbY6a
	YKuZCfYp9870LbjMShfHHdbceV8o28UOEE0yU=
X-Received: by 2002:a05:620a:1904:b0:8ca:110b:38cc with SMTP id af79cd13be357-8cb8ca0df13mr2240587285a.27.1772072864463;
        Wed, 25 Feb 2026 18:27:44 -0800 (PST)
X-Received: by 2002:a05:620a:1904:b0:8ca:110b:38cc with SMTP id af79cd13be357-8cb8ca0df13mr2240584685a.27.1772072863966;
        Wed, 25 Feb 2026 18:27:43 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389f2f640f8sm1429571fa.18.2026.02.25.18.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 18:27:42 -0800 (PST)
Date: Thu, 26 Feb 2026 04:27:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-pm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com
Subject: Re: [PATCH V3] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth
 support
Message-ID: <xuhr6wicgyvc6f3ejq2qnhpb4wk25larvr5frivkwojkq5o3ny@pruh4twsloiu>
References: <20260225091700.286108-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225091700.286108-1-wei.deng@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDAxOSBTYWx0ZWRfX32/oHcYbrxs/
 Y/q/LK2hveHu9yJNruJ7cjalQZlkfzERBYHsElD+3K3IHhimGvjvU2nLjmAHFD7YDxjAvFbtdNR
 EZN4ksml10LFNr4ifZsAAcvhYwBONVvRZdSrGf/72x8VrpI6Z4jxScr0i26fjKw2obJnRweh7wh
 7ie50Rouhw2I7hHpNMDtSUzNJrt4iCRlHkbEo51lzLhiJxfwE9U1uxcNr1S6g7eKSDu7O57p2AL
 DfQjK10lo8ylLKg4VOCJrpMeD3YTxVoiJHUYC5PuOQdiu4d6GbuQADM/5pwSWqxoDmWBOcJVyyK
 scBmSKMSxwncwAeOWAxLBmJYnj6schAmYuzNXejq4xQWcZSIb3LsibcSz7w11xU0ftZY1XOkwLK
 DouJMZ1cU2fNFUJDlHnqL5PP+mFgxrBmuQnxHA9oPYf+qjDkVVZGPOKOtc+HVi7rhk6SzdejG0G
 VY9L/ruu7ilEHYa49ag==
X-Authority-Analysis: v=2.4 cv=FvoIPmrq c=1 sm=1 tr=0 ts=699fafa1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=xdtaErPNZdlPjHlDlRYA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: uu8_wIo8ELnlJJOUAejbBkfBndSbnqdp
X-Proofpoint-ORIG-GUID: uu8_wIo8ELnlJJOUAejbBkfBndSbnqdp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260019
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43225-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,holtmann.org,gmail.com,vger.kernel.org,oss.qualcomm.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 151741A0195
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 02:47:00PM +0530, Wei Deng wrote:
> Enable BT on qcs8300-ride by adding a BT device tree node.
> 
> Since the platform uses the QCA6698 Bluetooth chip. While
> the QCA6698 shares the same IP core as the WCN6855, it has
> different RF components and RAM sizes, requiring new firmware
> files. Use the firmware-name property to specify the NVM and
> rampatch firmware to load.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---
> This patch depends on:
> - WLAN
> https://lore.kernel.org/all/20260122053624.4068718-1-wei.zhang@oss.qualcomm.com/
> 
> Changes in v3:
> - Rebase patches
> - Remove unintended 'output-low' from bt-en-state pinctrl
> - Use prerequisite-message-id to replace prerequisite-patch-id (Konrad)
> - Link to v2: https://lore.kernel.org/all/20251118140406.1551669-2-wei.deng@oss.qualcomm.com/
> 
> Changes for v2
> - Update commit message, add firmware name detail
> - Reorganize patchset
> - Link to v1: https://lore.kernel.org/all/20251113130942.2661069-1-wei.deng@oss.qualcomm.com/
> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 26 +++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> index 2ede6efd1afd..03c01ae630b4 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> @@ -18,6 +18,7 @@ / {
>  	aliases {
>  		serial0 = &uart7;
>  		mmc0 = &sdhc_1;
> +		serial1 = &uart2;
>  	};
>  
>  	chosen {
> @@ -107,6 +108,7 @@ wcn6855-pmu {
>  		vddpcie1p3-supply = <&vreg_conn_1p35>;
>  		vddpcie1p9-supply = <&vreg_conn_1p95>;
>  
> +		bt-enable-gpios = <&tlmm 55 GPIO_ACTIVE_HIGH>;
>  		wlan-enable-gpios = <&tlmm 54 GPIO_ACTIVE_HIGH>;
>  
>  		regulators {
> @@ -559,6 +561,12 @@ &sdhc_1 {
>  };
>  
>  &tlmm {
> +	bt_en_state: bt-en-state {
> +		pins = "gpio55";
> +		function = "gpio";
> +		bias-pull-down;
> +	};
> +
>  	pcie0_default_state: pcie0-default-state {
>  		wake-pins {
>  			pins = "gpio0";
> @@ -633,6 +641,24 @@ wlan_en_state: wlan-en-state {
>  	};
>  };
>  
> +&uart2 {
> +	status = "okay";
> +	bluetooth: bluetooth {

Please add an empty line before the subnode.

> +		compatible = "qcom,wcn6855-bt";
> +		firmware-name = "QCA6698/hpnv21", "QCA6698/hpbtfw21.tlv";
> +		max-speed = <3200000>;
> +
> +		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
> +		vddaon-supply = <&vreg_pmu_aon_0p59>;
> +		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
> +		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
> +		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
> +		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
> +		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
> +		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
> +	};
> +};
> +
>  &uart7 {
>  	status = "okay";
>  };
> 
> base-commit: 7dff99b354601dd01829e1511711846e04340a69
> prerequisite-message-id: 20260122053624.4068718-1-wei.zhang@oss.qualcomm.com
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry


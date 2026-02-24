Return-Path: <linux-pm+bounces-43143-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKBdEyWfnWnwQgQAu9opvQ
	(envelope-from <linux-pm+bounces-43143-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 13:52:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F85B187400
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 13:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9F3C3047EA1
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 12:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCC939B488;
	Tue, 24 Feb 2026 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c5JxUtrV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UqPikd77"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC83F39A81D
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937534; cv=none; b=ai8XySxq+3MRrvCj6aa3JsLSj8HCRt9s9xvwnOScxovcv/keQ4fsZpKgH6GvRzmsDtVk+/wGFShQndYKU9FfDd8GXAzsX1GBvizrjiUlohLk5kL1muH21903OiBUsQiwHolipNbm6dZxs1AkDqGVRo5nJ1WOubZWkjz1G+VZBB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937534; c=relaxed/simple;
	bh=e0fsvBudio5HxLSOZQn3Lec8MEFgfZUG6+VnErYT7Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tojRtLnr7QU9cL5gpiXpd7frnMLzm22TMSvYmbkbLKwLkxYTYpZHGdCX/Je4t9K8tUQjV/6EiYmhW8UJt09O3s8eeYUWy3q9sfI9Yli1vNkOyfbgQZaAwPvWg/IkZZwrP/GbG0XDShs6ixt+fHz/jV5NHOI+WgmAulqZOHnAl6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c5JxUtrV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UqPikd77; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFVbt2512755
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 12:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5wXaaTE0K44G/RbHIlQ72sYS58NboIdqrv/MSBFut+8=; b=c5JxUtrVcZEDo9ID
	D5H2A1zsOq6PZk7Ug+kb5p7ROmb0FJ4NRyxf0RPvP46w5cYV1AxcIrS8GG4Qc1ys
	S+qyyAF1eIcMSTJivZ9byI0FOk6gUj26cykCJIQLQJFUj98FIWdcVEphYPGSF4nm
	7D26hogcZFafj2RZHapmFmGjRQEmTaWNbKHvN9tyIZgjs6HIN/7vs6Mk45ZAmT4s
	nZwa8zt0kPzZhZYQuSOMfq8UWrQwaZgZYmJzLD5uJzw3xraE2j+dU9JUDT0Gxn6e
	qaRyi7dvf1KlZFHDwZ9mIvprbkyMn7yfmAUB6uDn4eqR0l4HSGnURKoEPnKh6wd+
	xAnknw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn81c8vs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 12:52:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb706313beso764782185a.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 04:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771937531; x=1772542331; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5wXaaTE0K44G/RbHIlQ72sYS58NboIdqrv/MSBFut+8=;
        b=UqPikd77mEgUDF8Bp5MxMRCR5Y1o6vGVnZuYJoYYmPQz8LBvZEA9ldLHi063r/9dmn
         wMul0W/7gWwd3TH5yykb/ylUdLdI5feUkJ9LLdvSHtXyOunTzXCViCu7zBnstNJI6MUV
         VFLoWB5lk0jy4tnwT05OXYXkSnpQR3gubxb43MyqZZUHuYG0g97OMzJDxWkCIGbMbKoA
         nRYZTLzqNFHL10WbaxtPES8IfwG+8Zo4wUav73ITvIBYyYLnehOdKb7pguXi5RZ/vCDH
         oLlydco8ppZW8s7bINo4Spn4oLb6KJTlJHLfb/lKppXfbO1gSv3y1yWfKas39SuSJooO
         BV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771937531; x=1772542331;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wXaaTE0K44G/RbHIlQ72sYS58NboIdqrv/MSBFut+8=;
        b=vz1SnBjYx9c9qk5OuGx2S4oiNLmijg8R4KriOZX+6ckcQuuv/H6HoP4YYJHGRndWV2
         k/fG2nkg7vWXfibRucEEGsdEQlel91gf9IjoxUBXpYrBt0lc6rLlzFj8oBWXGJ0wc5zf
         U2I6bYPChvJ5qVObZp3TEAUg+TRuzyUtu86B2comcjyPn69kiwzOWWwfWcrknhKy2ToQ
         yWYev+J6ESFrmZIwafVOR+3q/GOWX+EErMUmF0eFxT5lIkZL7GcXavD16JmBPgePcWEP
         q8WcBodaaHLhtHKhH35iFtGIr3HCfmhYZZXpF6ArVRuL1EHDwczqQtYtxgf/gn4RtVLN
         OKcg==
X-Forwarded-Encrypted: i=1; AJvYcCVY/rP2zPii9WOU9b9TgyNWQ2aK3D0YA6hDk2x1WJ85rzfcIOutgCfx1xdaMoLyRCHZpex/N8jiAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC2p1DxTzl4WqXAccjxgj2h/STw/RTbEUNNeYchlmeOXM/WFFi
	08Mt/Hdifbm400dLqE1QdnfxsjWYaeu+XFC5k9IKSHkEu6ry7JVmO1SH1SIhsv8g9vRHcyjfixD
	oOfufolcRJSu0kTp1KHgiI3lgQpIRgbtG0iB9CnV5OKWfOBFjk0YES3+/OJkKBw==
X-Gm-Gg: AZuq6aILDYv+5gPUopy9mVNxXET59ytIsh1L9k2qiHAPiOFuwaiEJ1pcgO2YMgbdkPe
	dcJDKmxI59S1NjWNpA0kvAtJ88IQ43vdqoduTb8lJO4LXhX9Jov3ChuTi5c9X5ujK7GebyR45CQ
	EUEgqeLUCu62Xehb69yMAdrvUR9NwB34xkYwxVKnQFOtqUbEVExkuxBSrFDQOJzavg+iynapTw3
	Kx8hOfF+jJa0QYGJDBVCkD8xRxfJa5F5Ql4iUZKwbcrCTGt+vnXswkagqNPM5hBxfA5EMEXsosR
	JLpNATdNLV5zhvDWbs86EVAbfLcRENdNp3dyQTE9Yf/y+iuI44OCYdGDvA2S2E+Yh5t+UBhmJEM
	xT9rXU2xBi+FuOQm8q80V5YCwyV3RP6ATrmzu3R4Chy7+6oBTYPJfJQnZf60/adi382UDXGF6Dh
	tLAIDgUP9C/AelDmdg3DLTIkHCSHRf6pmpBmA=
X-Received: by 2002:a05:620a:1aa6:b0:8c1:ab1c:f2da with SMTP id af79cd13be357-8cb8ca89d86mr1550575885a.70.1771937530707;
        Tue, 24 Feb 2026 04:52:10 -0800 (PST)
X-Received: by 2002:a05:620a:1aa6:b0:8c1:ab1c:f2da with SMTP id af79cd13be357-8cb8ca89d86mr1550571685a.70.1771937530095;
        Tue, 24 Feb 2026 04:52:10 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb0b8f0sm2143851e87.14.2026.02.24.04.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 04:52:09 -0800 (PST)
Date: Tue, 24 Feb 2026 14:52:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, andersson@kernel.org,
        mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        konradybcio@kernel.org, mani@kernel.org, casey.connolly@linaro.org,
        amit.kucheria@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v2 2/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
Message-ID: <wuwwacgunqbtjcgj3ai3bznewc3ejijve7wjonen2j2kgsokse@v4uchehtz6sf>
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
 <20260127155722.2797783-3-gaurav.kohli@oss.qualcomm.com>
 <20260128-whispering-caracal-of-respect-a26638@quoll>
 <36706481-2549-4716-8e6d-0e4db42591a2@oss.qualcomm.com>
 <546faeda-d896-403c-a449-5c9b0cd7159e@kernel.org>
 <17474333-bb82-49d7-bc04-45ab21095c38@oss.qualcomm.com>
 <ae4c1f7e-8f4c-4ce0-a6b8-bab29984e693@kernel.org>
 <c6136314-5bdf-466b-b19e-43062fb11150@oss.qualcomm.com>
 <e6679f94-2648-4d35-80cf-d3f823f9dad3@kernel.org>
 <4f815a0f-a815-4b77-a4cf-a4b18e776eab@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f815a0f-a815-4b77-a4cf-a4b18e776eab@oss.qualcomm.com>
X-Proofpoint-GUID: YjG4TdtQu1EFqCnXyIZVA40GGfmpxQ9h
X-Proofpoint-ORIG-GUID: YjG4TdtQu1EFqCnXyIZVA40GGfmpxQ9h
X-Authority-Analysis: v=2.4 cv=CbsFJbrl c=1 sm=1 tr=0 ts=699d9efb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=lDahQbM-NyokND_-sVEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDEwNCBTYWx0ZWRfXxBUaXyR6iFpx
 pb9N5VbrMQDDLarIThqRRFu4p0+PwlVpMHUAgQclBE9HmkNBG6tEtmAwPdJ3KgOIjjJ9ym0bA0t
 c9J4Pi6f0SuSSW9li+lAEGC81/rOZLkMl2HHq0ynaTgW01/qQbF0b00BhAerd5VG8WchJlGFZRo
 BO7Eee81Cb9MB/mTkyR0GBcJL7bvf+zPACIa8fvbA7YsvLpeoNuOn+wA5lhT+22m57AFznMHlFD
 gOieGu773pOQGL843+PqUPlz92sJcTQzDqD0NKNe2gcpizAZt+7PG5fZkEcOQnx9RX7gwmiNjKZ
 xOy+47Dk2xoVGpa59/VfOannbY6zqQI6R4QTY1QvYhSEoduZWbvkt1gB17pfXWJGLdo5a/YTEln
 NVfQYlqZp0S32D184RZD6nXsArA8NwBzjBHiUzgxqdfE/waPrSqvrXbgJAQ7nhWPa4QQyGliFTy
 Q1Yg24+v+qwsQ8Mu3RA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602240104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43143-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6F85B187400
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 05:39:42PM +0530, Gaurav Kohli wrote:
> 
> 
> On 2/20/2026 1:14 PM, Krzysztof Kozlowski wrote:
> > On 20/02/2026 08:29, Gaurav Kohli wrote:
> > > 
> > > 
> > > On 2/11/2026 1:43 PM, Krzysztof Kozlowski wrote:
> > > > On 11/02/2026 08:37, Gaurav Kohli wrote:
> > > > > 
> > > > > 
> > > > > On 2/8/2026 3:36 PM, Krzysztof Kozlowski wrote:
> > > > > > On 29/01/2026 13:06, Gaurav Kohli wrote:
> > > > > > > 
> > > > > > > On 1/28/2026 4:57 PM, Krzysztof Kozlowski wrote:
> > > > > > > > On Tue, Jan 27, 2026 at 09:27:16PM +0530, Gaurav Kohli wrote:
> > > > > > > > > The cooling subnode of a remoteproc represents a client of the Thermal
> > > > > > > > > Mitigation Device QMI service running on it. Each subnode of the cooling
> > > > > > > > > node represents a single control exposed by the service.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > > > > > > > ---
> > > > > > > > >      .../bindings/remoteproc/qcom,pas-common.yaml  |  6 ++
> > > > > > > > >      .../bindings/thermal/qcom,qmi-cooling.yaml    | 72 +++++++++++++++++++
> > > > > > > > >      2 files changed, 78 insertions(+)
> > > > > > > > >      create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
> > > > > > > > > 
> > > > > > > > > diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> > > > > > > > > index 68c17bf18987..6a736161d5ae 100644
> > > > > > > > > --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> > > > > > > > > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> > > > > > > > > @@ -80,6 +80,12 @@ properties:
> > > > > > > > >            and devices related to the ADSP.
> > > > > > > > >          unevaluatedProperties: false
> > > > > > > > > +  cooling:
> > > > > > > > > +    $ref: /schemas/thermal/qcom,qmi-cooling.yaml#
> > > > > > > > > +    description:
> > > > > > > > > +      Cooling subnode which represents the cooling devices exposed by the Modem.
> > > > > > > > I do not see the reason why you need 3 (!!!) children here. Everything
> > > > > > > > should be folded here.
> > > > > > > 
> > > > > > > 
> > > > > > > Thanks Krzysztof for review.
> > > > > > > 
> > > > > > > Each subsystem may support multiple thermal mitigation devices through
> > > > > > > remote TMD service.
> > > > > > > 
> > > > > > > Because of this multiplicity, introduced separate binding file.
> > > > > > 
> > > > > > This explains nothing. Subsystem does not matter for the binding. My
> > > > > > comment stays.
> > > > > > 
> > > > > 
> > > > > thanks for this suggestion, we will use qcom,pas-common.yaml to define
> > > > > bindings and avoid creating new file.
> > > > 
> > > > I asked not to create any children nodes.
> > > > 
> > > 
> > > We have multiple cores within a subsystem(cdsp) and each core has its
> > > own independent DCVS. And also we have dedicated TSENS sensor placed on
> > > each core within the subsystem.
> > 
> > Your own example in this patch had only one device, so how do you
> > imagine to convince us with incomplete or half baked code?
> > 
> 
> Target of this series supports one tmd per remoteproc, due to which we have
> not posted examples of multiple tmd. Can i use dt binding example sections
> to describe all tmd's per remoteproc?

I think you have spent more time arguing that you this series is limited
to CDSP than would have been spent on adding ADSP/ SLPI / MDSP support.

> 
> > > As a result, each core requires its own cooling device, which must be
> > > linked to its TSENS thermal zone. Because of this, we introduced
> > > multiple child nodes—one for each cooling device.
> > 
> > So you have one device with cooling cells=1+2, no?
> > 
> 
> This will be a bigger framework change which is not supported, i can see
> other drivers are also using something like this multiple cooling device
> under device node, below are few examples :
> 
> ->Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
>   In this multiple fan child nodes are present.
> 
> -> Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
>   In this multiple child nodes are present, like heavy and light.
> 
> Please suggest if our current approach is fine or you want us to implement
> in some other way.
> 
> > > 
> > Best regards,
> > Krzysztof
> 

-- 
With best wishes
Dmitry


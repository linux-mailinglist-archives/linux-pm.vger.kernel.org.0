Return-Path: <linux-pm+bounces-37877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C952C546A3
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 21:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6FFF4E6838
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 20:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990E22BE7BA;
	Wed, 12 Nov 2025 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KuvedS6s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JnQQzngu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E839329ACD7
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978364; cv=none; b=gop90FWetz/+37qxOrvJzGam8NnzAI8NfV+GAfNT/5TMhvZ/qixjLagZNgUpFjia2uoH48Hlr1Dwa0IE55A1H8pbAvF6OXZwPAMTRiifW0h0RAx9KwLrNLNHqXyZY4ShRzEBGktsZwTtBqv6UHfvHt+KqOoXU9UWn34saH9V0j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978364; c=relaxed/simple;
	bh=lVGujtlqfVWRh/du2kdLAb9QAmZfya8jXNxRCsqWxOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgkHHkp/STLWDyLO1R5XH5k1F8PnAhSNYv5zPuF49Elx1EOsSqeUOLTD3pGoU+biMX91DyL0oUmgzYGmJTV8AdDNbrRrW204dvKMabdG5BV/OTuUKoOw8vzd7SXsUfNTjsRQZ36mwqdv8Hcql2E3nVE5MD/u6s9Gv5meEN4a+ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KuvedS6s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JnQQzngu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACDsCvr1314293
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 20:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6mzY8BUhWbOwRUbggWIJEjuI
	i2pIxh5Z3FRRwS4qIpo=; b=KuvedS6smF8mnGpNwsw33JGI5dl0AoMsIm+6K9EQ
	NOQ2uFuZbEoOvdEdiEOFQyNPby0EGZz2MMNd5JzqPrsf5loby3Oz6EWJcEHM3NMr
	/HsGdscjil2x+JgzpnSaiwvDOMAaI8apQxHQZGN7heZRvhlEQeE+F61zZ4OpFNy2
	lOtLSQIzJ/neqcVLFPm9wETf0yUb0QXRnXJ2DDK5fR/waZQHy8QwFY8vqxaCEQ2t
	PATur5PtWNRWMucSZbh3pQjZZNidGefFeZFryK5far0GgkgqPzn72FTRznCKrigQ
	4gUUluV9jIeqi97PYwxZ+fkGQJbYXiLLTRpLuz2fqd13/g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acuhg1795-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 20:12:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed6ff3de05so1030271cf.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 12:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762978361; x=1763583161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mzY8BUhWbOwRUbggWIJEjuIi2pIxh5Z3FRRwS4qIpo=;
        b=JnQQznguOpcPacgZ+RKYdqxhzBu7PoLhgwb4nyF8CyDq4Op19jbBNH+LaAFN3ooDFx
         coTu/aRRJgTJYiIp5OXcWYxdbvBApUXALtBJVauLYyb4PB7HVKnQG0k1JetNgktDWq7z
         C1B2iUuzQZZ9jj1EePO3VHaKgArfH3CsFTI8pIr+dOzehKYIFUN/1SAncf1wjzerGSgX
         n4HcuphKKepRU6K+JAUbyhOF1+hd5kI8cgcAr9QGOVucwq7Zc7TuQOokaxrHxTCMru1j
         nEAUxMJhRL2W2jJicbhnjVVV5XrosTHqrRSVl5KLPfoFQHRHa/CA+bqsZJJAdIQGOLlp
         WqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978361; x=1763583161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mzY8BUhWbOwRUbggWIJEjuIi2pIxh5Z3FRRwS4qIpo=;
        b=Bxn5tkk8Ie8HWrLt34URF2A97Ha2VnxcO6GJMWHGnLScEPyc4/aVQPsvm3+clze7WD
         U2HNrx7lbpufTy3OuRYADsQb67dQl9EcZraEw6zU2CVqridsKvqWC+xy57OpbaqTvkdF
         ZbQWe7JMT8dCQzDDU8bnqS/ObXfFkPeQ94R4YSlK2MtD2yPUo077QbuZZlwx/uWtMM+u
         pASt42QB1yHVzX3nGXVnbMmJvOHF2zIMDZ0NMRjYGYoFLr1SCXMQBVfQijy7mnYA3uo7
         Y0SC9R1r5lyrRgSSKbVB2XPEOVzaiNKsPfWZzcoxIB/Fn9CeUb30/mCE6RZ+YsIkA9V8
         37sA==
X-Forwarded-Encrypted: i=1; AJvYcCXV8lzoFDrpc27apoh5Tcf/TV7c+zROHIHl01CgKvuvEQYtNyBKn9UEScFfL4tkLFryf47OuSYDVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwewDEOrHxeeOLCVjIXIuxynBiuQO9v4Zta9LaA1gi0ojqSFftH
	V52TgzbTjoOYdIjkOwcet3N/eKkmbHUUpygOu0fbmHShKLVxQqsKMRToJ/jmjVSxlTf3jhdd+ZJ
	rnWBc0OwgBw+e5ivnfe7+6dMAcFpVLy7iB2i2hxcowf8HN3cfsowyUOxAidA7FQ==
X-Gm-Gg: ASbGnct2Y79q/mDKRF06jx7H/mOpO88kZsfpFMfjjHn4txU8+ODccYJuzmczehihlA5
	EkPm5BmrSlXhgq4jQBGmpcgwQC1TQgk2eKltuHK+nKzURG87XJQgpqbwr89ojSWA4NtrHZcKaMN
	uYzBlavrH2gMbvY6QbOe2LNmD+2zH6FBZY2FcEGYZ+u6Qs/2cWPWzylvahz4BqgZJUj/2F4cnKL
	+PRdgv5bCSQo0TtZn0en6SwkrF5v7PPqvGwgGAkur7+NlvnKVHoKcwZJIZKlGhIr2joG1Clm7pW
	6mx14jZoNEkAeXCzHS/tRecywlS+1neYM8BhCklvQZifZw3P+Lhj2NHGOMMu6YDGkYqJYVKv4eg
	9ymq6baTyfjtS/p732C1BHeoJdDLENKdKbJei39B+UKDq13c7QsW8Syw3jYk0bJpkKAY4yyBp1D
	1O54W7F8Fj+kx6
X-Received: by 2002:a05:622a:14cc:b0:4ec:f86f:9239 with SMTP id d75a77b69052e-4eddbc935a3mr58887001cf.6.1762978360970;
        Wed, 12 Nov 2025 12:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3eqFCZmuP88ngdNGfQvO2MPUOn88l3YBT2gvHlOKJlS4q8OcQpDN12FTzVO6RhY2Xao9OVg==
X-Received: by 2002:a05:622a:14cc:b0:4ec:f86f:9239 with SMTP id d75a77b69052e-4eddbc935a3mr58885391cf.6.1762978359235;
        Wed, 12 Nov 2025 12:12:39 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a0b75dasm6037506e87.59.2025.11.12.12.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:12:38 -0800 (PST)
Date: Wed, 12 Nov 2025 22:12:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key M connector
Message-ID: <zjwuk4mg6n5wm7yecsjv6lrwb42rpmpdtoyh2dnh23h6kr57d6@iqxvrrdgs7vn>
References: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com>
 <20251108-pci-m2-v2-1-e8bc4d7bf42d@oss.qualcomm.com>
 <gmwg46c3za5z2ev34mms44gpq3sq7sb4jaozbdn5cejwbejbpo@wwr2j7dkjov4>
 <qrgaulegz2tb7yzklyl7rpkgbf6ysx44bxtyn6n3tcyq4an4e5@bzngutkvfno3>
 <5kedk7c6kc2e5j4kqeyik6i7ju54sdn6etjhpwl2vt4nq6c6ug@2yld4hpvbuzg>
 <n3efko3q7i64qmipgxz5yjeqvgmw26b4dvwofe6qnx7xqsjtx5@bbbpxmfioxrj>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n3efko3q7i64qmipgxz5yjeqvgmw26b4dvwofe6qnx7xqsjtx5@bbbpxmfioxrj>
X-Authority-Analysis: v=2.4 cv=NbnrFmD4 c=1 sm=1 tr=0 ts=6914ea3a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=gGdc6YTi3Ko-D-QsUB4A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: n9Cx7Kpa7uVKma3YgC0Rt6l2Q1DyHC0j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE2MyBTYWx0ZWRfXzNI79DTPu1YC
 /4V+7PQNM12jZ6Hx+8i7hspL638eAnVi06t1V/sk4NhUyCU89bW7Ui+GBogMcZbaqhYsZKpcTlf
 IFXR1gNorAmelgHFpG1XriyIpj6zmTdBZRJw9HfcbVtgd9XLYFCRH1lQEXOlcpdXcCzsMUP2RrX
 bLnqRq2nV3M/R710iJRAD6isfvhqfxxteFWaCnj2ggvQNJmWcnIdwUcRA+OQcbEg7pgmx0xrAsd
 aG0OkwXlKqA7u0en7XIlwWM9CR6GQwLqOdS3wMQZHmvK3b1A1fXSMU8sVgZWgXJ4r49pQFkG8fa
 S1XBAWZIXjeTB4lwKHZ5ZGqivo5dU8YKPPm/q70vbP5uu1ks1o931zXFTaCGq9yKgmXdQTZCjyv
 yKtHb1Z0VPvlI17GKwBeYsOyu2+pJQ==
X-Proofpoint-ORIG-GUID: n9Cx7Kpa7uVKma3YgC0Rt6l2Q1DyHC0j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120163

On Tue, Nov 11, 2025 at 07:19:45PM +0530, Manivannan Sadhasivam wrote:
> On Sun, Nov 09, 2025 at 10:13:59PM +0200, Dmitry Baryshkov wrote:
> > On Sun, Nov 09, 2025 at 09:48:02PM +0530, Manivannan Sadhasivam wrote:
> > > On Sat, Nov 08, 2025 at 08:10:54PM +0200, Dmitry Baryshkov wrote:
> > > > On Sat, Nov 08, 2025 at 08:53:19AM +0530, Manivannan Sadhasivam wrote:
> > > > > Add the devicetree binding for PCIe M.2 Mechanical Key M connector defined
> > > > > in the PCI Express M.2 Specification, r4.0, sec 5.3. This connector
> > > > > provides interfaces like PCIe and SATA to attach the Solid State Drives
> > > > > (SSDs) to the host machine along with additional interfaces like USB, and
> > > > > SMB for debugging and supplementary features. At any point of time, the
> > > > > connector can only support either PCIe or SATA as the primary host
> > > > > interface.
> > > > > 
> > > > > The connector provides a primary power supply of 3.3v, along with an
> > > > > optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> > > > > 1.8v sideband signaling.
> > > > > 
> > > > > The connector also supplies optional signals in the form of GPIOs for fine
> > > > > grained power management.
> > > > > 
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > > ---
> > > > >  .../bindings/connector/pcie-m2-m-connector.yaml    | 122 +++++++++++++++++++++
> > > > >  1 file changed, 122 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> > > > > new file mode 100644
> > > > > index 0000000000000000000000000000000000000000..be0a3b43e8fd2a2a3b76cad4808ddde79dceaa21
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> > > > > @@ -0,0 +1,122 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/connector/pcie-m2-m-connector.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: PCIe M.2 Mechanical Key M Connector
> > > > > +
> > > > > +maintainers:
> > > > > +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > > +
> > > > > +description:
> > > > > +  A PCIe M.2 M connector node represents a physical PCIe M.2 Mechanical Key M
> > > > > +  connector. The Mechanical Key M connectors are used to connect SSDs to the
> > > > > +  host system over PCIe/SATA interfaces. These connectors also offer optional
> > > > > +  interfaces like USB, SMB.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: pcie-m2-m-connector
> > > > 
> > > > Is a generic compatible enough here? Compare this to the USB connectors,
> > > > which, in case of an independent USB-B connector controlled/ing GPIOs,
> > > > gets additional gpio-usb-b-connector?
> > > > 
> > > 
> > > I can't comment on it as I've not seen such usecases as of now. But I do think
> > > that this generic compatible should satisfy most of the design requirements. If
> > > necessity arises, a custom compatible could be introduced with this generic one
> > > as a fallback.
> > 
> > Ack
> > 
> > > 
> > > > > +
> > > > > +  vpcie3v3-supply:
> > > > > +    description: A phandle to the regulator for 3.3v supply.
> > > > > +
> > > > > +  vio1v8-supply:
> > > > > +    description: A phandle to the regulator for VIO 1.8v supply.
> > > > > +
> > > > > +  ports:
> > > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > > +    description: OF graph bindings modeling the interfaces exposed on the
> > > > > +      connector. Since a single connector can have multiple interfaces, every
> > > > > +      interface has an assigned OF graph port number as described below.
> > > > > +
> > > > > +    properties:
> > > > > +      port@0:
> > > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > > +        description: PCIe/SATA interface
> > > > 
> > > > Should it be defined as having two endpoints: one for PCIe, one for
> > > > SATA?
> > > > 
> > > 
> > > I'm not sure. From the dtschema of the connector node:
> > > 
> > > "If a single port is connected to more than one remote device, an 'endpoint'
> > > child node must be provided for each link"
> > > 
> > > Here, a single port is atmost connected to only one endpoint and that endpoint
> > > could PCIe/SATA. So IMO, defining two endpoint nodes doesn't fit here.
> > 
> > I think this needs to be better defined. E.g. there should be either one
> > endpoint going to the shared SATA / PCIe MUX, which should then be
> > controlled somehow, in a platform-specific way (how?) or there should be
> > two endpoints defined, e.g. @0 for SATA and @1 for PCIe (should we
> > prevent powering up M.2 if PEDET points out the unsupported function?).
> > (Note: these questions might be the definitive point for the bare
> > m2-m-connector vs gpio-m2-m-connector: the former one defines just the
> > M.2 signals, letting e.g. UEFI or PCIe controller to react to them, the
> > latter one defines how to control MUXes, the behaviour wrt PEDET, etc.,
> > performing all those actions in OS driver).
> > 
> 
> In the case of an external GPIO controlled MUX for PCIe/SATA interface, I would
> assume that the MUX will be controlled by the PEDET itself. PEDET will be driven
> low by the card if it uses SATA, pulled high (NC) if it uses PCIe. Then that
> signal will help the MUX to route the proper interface to the connector.
> 
> Even in that case, there should be a single endpoint coming from the MUX to the
> connector.

How would you model this in the actual DT? We don't have separate
PCIe/SATA muxes in DT, do we?

> 
> > Likewise, for USB you specify just the port, but is it just USB 2.0 or
> > USB 3.0 port? In the latter case we should have two endpoints defined,
> > one for DP/DM and another one for SS singnals.
> > 
> 
> The M.2 spec limits the USB interface to 2.0 for Key M. I missed mentioning it.

-- 
With best wishes
Dmitry


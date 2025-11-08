Return-Path: <linux-pm+bounces-37675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D6CC432F2
	for <lists+linux-pm@lfdr.de>; Sat, 08 Nov 2025 19:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F06F64E825E
	for <lists+linux-pm@lfdr.de>; Sat,  8 Nov 2025 18:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191F3264617;
	Sat,  8 Nov 2025 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ML3sUk6A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aCb2V+O/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F5274641
	for <linux-pm@vger.kernel.org>; Sat,  8 Nov 2025 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762625471; cv=none; b=NYPq4DZ/I3oI1oSGhZi9xh2+LW1gL/7++4nK3EERD/xstoXpbLIpwxGOinRrnNWVwaSG67uqUVmciOP2/FOtVItOCc4M/XL3e6/ZUSZ9c9ph8MOTd6InmStzK/VM+oP9FJ7F6lxlWyRe3MbJ1eGwTTiImQVpvCWOdi7ES/StMFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762625471; c=relaxed/simple;
	bh=fOsRuEG19Rm3C05snWo9jA5gpWqRYP4hAH53HLRrD/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVa8vPTiC2HJEWCboEchZztOjqdo7vf+y9V9DZKAnsMe469R2ao/tPbsBYrBsMnGlIkrMEF4nfAacwUIPolctapxz8zQVR3UJ6FDS3vD8gOaHxdpKjkIdVVY0kJ7rv/xVRMuzcFKk/clyXesAsVrYBQdwzEYZKuMU/xX9z1AThw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ML3sUk6A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aCb2V+O/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A8CKnP01949956
	for <linux-pm@vger.kernel.org>; Sat, 8 Nov 2025 18:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=r6FePatGCvy+ETtTkeEM3vn/
	9lE+wgGoRAkcvzm/jgE=; b=ML3sUk6ACc2NmDqhPQ4doplG60TbEkxIuGnrtpwM
	bMd+Y5iSfoc9sw2DaeEjtvwJgjYEVA+7Vvuch2/bfK9NJLzoENfLtE2PNVvUzO0Z
	yDmF7xCVhh0tEzeCq+Ss59uMVFcDF/YjK9VD7JcbVR1czc+WFmNqnv1lrkcQg6TA
	IJ3DEI++iN35i+FJ/E60q+XeivmKITQOh/gOkWhiH8jwsJI9/Yo5TbAkGZTsqHqu
	ID5mcvkK80231t5Y18lPOpa2RoNkVRBa6HvFGTXiV8gJswsYs7kWzOKnPcPyw1Fz
	uH1m1ITMdOrzRo/cMabY0jdpxaj9vHdzSHDrEejHcAMqKg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xuegyqf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 08 Nov 2025 18:10:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e89f4a502cso50837071cf.2
        for <linux-pm@vger.kernel.org>; Sat, 08 Nov 2025 10:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762625459; x=1763230259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6FePatGCvy+ETtTkeEM3vn/9lE+wgGoRAkcvzm/jgE=;
        b=aCb2V+O/EZQq/YoB3rPa6cnoWLgHERXTyAYPKSgvxoR7BoKBXSDNTVGWI01N1kjlb0
         89hUiXOqIS/XP3CcHsQ6zN09z6ixDFLdLwGhGIBDnhCD9GYUqTqoh/nzHQU7ghL1p9lj
         bfNcDSUQ4TcQ818nc+AenuwO3RjXlJgvEoa9ReBwTUjkkNidsXum8HCZWkU0JCkImAH+
         /sFRVK9+abP85Yi2mTdJYLe7zRKjSCZKmGNjnKZEPojMnGf/6R0iUjHIyaXoyvbXRI1L
         /zPbmxA430Z1f0VoVpsGbn/9J1FHx6166+5ukTNZSkqAAH5tFBBJlIwM15/h+8mOKHcI
         zMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762625459; x=1763230259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6FePatGCvy+ETtTkeEM3vn/9lE+wgGoRAkcvzm/jgE=;
        b=pX6r3gyXWvMu2cYMdD5AV6Ozx/K6FW5HG50jjcXUgVb9UReMm9fuoPBs04UeoKBFiE
         dXxl+SaQrTehVCpJNLcPJ4+dgGx3VCd8DVrIuA4SYs4+kuVRNM21bL1CzC10AxmG9XPv
         BNCy26y4ozExCQJXXZOiOcBwQGPb/LC+jDGZ9rvudQ5pLol4yHN9B16jhFsh3S3aHoaG
         1/yyt2PBe2htG8kphoGbScr6iVZlRVHUU14clkvYngkWskGZy85RtfNTKgryo3rHarP6
         gxWvLoM4Ht5Nq6zXQvGHB+jIq2u/Nxl7K3q2q9jz88yuGrdDlbtp+CCZ0xnsTIGH7LLO
         cBpg==
X-Forwarded-Encrypted: i=1; AJvYcCVnfcBczCeB6UOhH3xPUlGbRS+5YczCSnL38loEGGTpiCK0AhQhjxUORdSBerC8tNRFSbESNInISg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx32IO2Ld5aa+hNW761FZDKSkHaY/ft5jui8IBrwUOqKRCrR0bN
	M5PhNZXITYtyrXCs/6QjClSmPqt5dlCwEhaCcF/caNdrFkwA9qy+p5PnC3K+cExC+gg89R6UZDZ
	Xl9ay+eeOjz9zvAJPpL7azWASnmtNBt8CGakgra77B4tm+KDtFipHBSSB3IiTJA==
X-Gm-Gg: ASbGncuc6WIdvcJv3blBt+wTGSB1kNUHRf3zBoFTDsX3QTQqOVT85spHtNF8omcdjNo
	wWGs0wvgAGC7oooRs7qIQHn1Os2HcQPbTkclYYFydHNjfqbMZUECUdxOGDjJnD3+JT6JfVU3Di2
	aIs6uywG5UWrV/bHExHAyVcGCIu36ADIAuGghPlhUbbBV6VZPsYOC49Kj21Wt23Iv5qfODHS2xV
	1wbv9ac+4IZ65FkfZQCfibGt4BggsrCw/auMxBSiBa0h3WHbSM1kUKbwIVdVGGGnAC0ejlPKYTc
	id1mWPMIsi/Ic2Ze/WR3qLpeb+AcGR0Qzu6Wkr70VT/uJzeNSP0g99wbSoVg/Taylphfhz0E9R6
	khpT/mCEBBdJavYLFBWNTZcKlHwZtF+FgBxnetI0K88C07ib7VhkOlvHuuUQWN+37Qv0bSK9+6L
	o0Cs2HLEBrk3Vn
X-Received: by 2002:ac8:7e94:0:b0:4ed:18dd:fd4 with SMTP id d75a77b69052e-4eda4eb97ebmr35129051cf.19.1762625459213;
        Sat, 08 Nov 2025 10:10:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4i3GOQJbaFJJVYsZ0kR4yNKniHd76KAyDxpBZc6xL37rUmvj2LHwuC7290RKXWl1F0SzPcQ==
X-Received: by 2002:ac8:7e94:0:b0:4ed:18dd:fd4 with SMTP id d75a77b69052e-4eda4eb97ebmr35128891cf.19.1762625458771;
        Sat, 08 Nov 2025 10:10:58 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a013bcdsm2342727e87.17.2025.11.08.10.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 10:10:56 -0800 (PST)
Date: Sat, 8 Nov 2025 20:10:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key M connector
Message-ID: <gmwg46c3za5z2ev34mms44gpq3sq7sb4jaozbdn5cejwbejbpo@wwr2j7dkjov4>
References: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com>
 <20251108-pci-m2-v2-1-e8bc4d7bf42d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108-pci-m2-v2-1-e8bc4d7bf42d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDE0NyBTYWx0ZWRfX4HIJJ9CIQ0tK
 y1MpXY9oYbnUU7AEqeavt7Kx1YZ9TIBs6PNSQsAr0GGgkWipNad/dQgU2N5wu6d6QOd9D3Kut0R
 d9vSOgELEp9nkOeBY3UqoPRNou2kbjIrx9QprxM2/G49MJwR8h5cqQRTufP8ZIEditY4Xvy/MAX
 TOHtPpLn8d9SeHFgUchlIzf8Dqr0HUSO/S+ucEAaYhCNn8GOjlqL9VRWY+RiZGGgToIYV6rjn6/
 dXGvp+HOFBV1klJ2M1LWezYAmcStKXiZlHkeGQeZ1CBM7do/yOQE477vQfq+bPDQqaC1t8i8QMs
 kl9NauQIN6PbLfdPTf6C7Lo8zxEACdcIM7NOQNk4BA+9avoR+4prPnixvZw7QzeisjcPvrmV37B
 nCuT2iVUWEpS1aYToqg+mLHfXp7uVA==
X-Proofpoint-GUID: xrI4xtkh4wMLmLoqfFBe_J8u093QmY-G
X-Proofpoint-ORIG-GUID: xrI4xtkh4wMLmLoqfFBe_J8u093QmY-G
X-Authority-Analysis: v=2.4 cv=BOK+bVQG c=1 sm=1 tr=0 ts=690f87b3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=i2rTrvYXNPCTwSvIQ-0A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511080147

On Sat, Nov 08, 2025 at 08:53:19AM +0530, Manivannan Sadhasivam wrote:
> Add the devicetree binding for PCIe M.2 Mechanical Key M connector defined
> in the PCI Express M.2 Specification, r4.0, sec 5.3. This connector
> provides interfaces like PCIe and SATA to attach the Solid State Drives
> (SSDs) to the host machine along with additional interfaces like USB, and
> SMB for debugging and supplementary features. At any point of time, the
> connector can only support either PCIe or SATA as the primary host
> interface.
> 
> The connector provides a primary power supply of 3.3v, along with an
> optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> 1.8v sideband signaling.
> 
> The connector also supplies optional signals in the form of GPIOs for fine
> grained power management.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  .../bindings/connector/pcie-m2-m-connector.yaml    | 122 +++++++++++++++++++++
>  1 file changed, 122 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..be0a3b43e8fd2a2a3b76cad4808ddde79dceaa21
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/pcie-m2-m-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe M.2 Mechanical Key M Connector
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> +
> +description:
> +  A PCIe M.2 M connector node represents a physical PCIe M.2 Mechanical Key M
> +  connector. The Mechanical Key M connectors are used to connect SSDs to the
> +  host system over PCIe/SATA interfaces. These connectors also offer optional
> +  interfaces like USB, SMB.
> +
> +properties:
> +  compatible:
> +    const: pcie-m2-m-connector

Is a generic compatible enough here? Compare this to the USB connectors,
which, in case of an independent USB-B connector controlled/ing GPIOs,
gets additional gpio-usb-b-connector?

> +
> +  vpcie3v3-supply:
> +    description: A phandle to the regulator for 3.3v supply.
> +
> +  vio1v8-supply:
> +    description: A phandle to the regulator for VIO 1.8v supply.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description: OF graph bindings modeling the interfaces exposed on the
> +      connector. Since a single connector can have multiple interfaces, every
> +      interface has an assigned OF graph port number as described below.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: PCIe/SATA interface

Should it be defined as having two endpoints: one for PCIe, one for
SATA?

> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: USB interface
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: SMB interface
> +
> +    required:
> +      - port@0
> +
> +  clocks:
> +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
> +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
> +      more details.
> +    maxItems: 1
> +
> +  pedet-gpios:
> +    description: GPIO controlled connection to PEDET signal. This signal is used
> +      by the host systems to determine the communication protocol that the M.2
> +      card uses; SATA signaling (low) or PCIe signaling (high). Refer, PCI
> +      Express M.2 Specification r4.0, sec 3.3.4.2 for more details.
> +    maxItems: 1
> +
> +  led1-gpios:
> +    description: GPIO controlled connection to LED_1# signal. This signal is
> +      used by the M.2 card to indicate the card status via the system mounted
> +      LED. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.2 for more
> +      details.
> +    maxItems: 1
> +
> +  viocfg-gpios:
> +    description: GPIO controlled connection to IO voltage configuration
> +      (VIO_CFG) signal. This signal is used by the M.2 card to indicate to the
> +      host system that the card supports an independent IO voltage domain for
> +      the sideband signals. Refer, PCI Express M.2 Specification r4.0, sec
> +      3.1.15.1 for more details.
> +    maxItems: 1
> +
> +  pwrdis-gpios:
> +    description: GPIO controlled connection to Power Disable (PWRDIS) signal.
> +      This signal is used by the host system to disable power on the M.2 card.
> +      Refer, PCI Express M.2 Specification r4.0, sec 3.3.5.2 for more details.
> +    maxItems: 1
> +
> +  pln-gpios:
> +    description: GPIO controlled connection to Power Loss Notification (PLN#)
> +      signal. This signal is use to notify the M.2 card by the host system that
> +      the power loss event is expected to occur. Refer, PCI Express M.2
> +      Specification r4.0, sec 3.2.17.1 for more details.
> +    maxItems: 1
> +
> +  plas3-gpios:
> +    description: GPIO controlled connection to Power Loss Acknowledge (PLA_S3#)
> +      signal. This signal is used by the M.2 card to notify the host system, the
> +      status of the M.2 card's preparation for power loss.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - vpcie3v3-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  # PCI M.2 Key M connector for SSDs with PCIe interface
> +  - |
> +    connector {
> +        compatible = "pcie-m2-m-connector";
> +        vpcie3v3-supply = <&vreg_nvme>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +
> +                endpoint {
> +                    remote-endpoint = <&pcie6_port0_ep>;
> +                };
> +            };
> +        };
> +    };
> 
> -- 
> 2.48.1
> 

-- 
With best wishes
Dmitry


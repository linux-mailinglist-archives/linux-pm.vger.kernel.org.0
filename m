Return-Path: <linux-pm+bounces-41356-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGkYGLBBc2mWtwAAu9opvQ
	(envelope-from <linux-pm+bounces-41356-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 10:38:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E99737F4
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 10:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E554A3058BA6
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 09:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9683364E9C;
	Fri, 23 Jan 2026 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GUyuQBKB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cRt+xBbm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D8F34405B
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160714; cv=none; b=GwMvp3cppIHRulHAJD5xleJHoSzsuGg2NyBXsCVeijI+seq59V21F0/2rIntCufrmVFZheh6lFUmCpcwdx6aU+IAWNxg95V+khRflhjnr2ohSNr/gW9PS4m9H97iE8TqM6si5UD9jba5cEXfsSXmqJLwSa+LwuSj8xG7Oxt0BNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160714; c=relaxed/simple;
	bh=LAdtpN1rCikqAOAR5EK+0Wp5HeQ/8qzoaZ/iaXhGfFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COKgk2g1+ff/rjh5BeBmMTBRFN+DC1z5L22MwAWi3urce/Avz0QhxZT63XxPZL5tfNFHxv9fk/mi/C+6ZoCohLNi7IRNdd0dyvbs7fmGJF0XaNJljv+rglN3zgJT3vGvedjnCvoRDKi1sU/hBTDHdzomhD0fHruGKZPkotSFcV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GUyuQBKB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cRt+xBbm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N7ilbP1267992
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 09:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	26CDK72HEOnmUsZ1CXy1/05/oLpi5raMr9WBDPBMZ7k=; b=GUyuQBKBtsywwiSU
	R1OwPXA81vidDquGqqc28No1zzt67cVhsgBYp2pCqS9pfqgkULNner+r+hB817tG
	EYcSBfrlnwB49/42tOhjioOI+F64teuAOEUVcNI10lgBcw3D2oAxFfdxtxgz7SfN
	uYKcMGab6GlKl9wD5NgmD58lb179KAkvVMcLRX1gTjkK9+3PNUVzcs7z/J3jaIZg
	sjxjwF3FLLRhGB/vjiCA0YFJzM3cXV4xxATTVthnybzHIySwKD0LPRdYuzNwnLVM
	V2nR/ELYU3+1GXzsarPhdbq++Q0Cy1lWqFZYsgEJEIBRTD5ihz5rPOaSoAVge8ge
	6qs6Qg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bv4v98cv3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 09:31:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6a0ec2496so429706885a.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 01:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769160702; x=1769765502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26CDK72HEOnmUsZ1CXy1/05/oLpi5raMr9WBDPBMZ7k=;
        b=cRt+xBbm3pM1SRIk9kYNM1W9X/WSF/Ury95PMCX1O1OCV+EW1M5h+A1QoRBlYstQGQ
         9yL7USz/IdZvi+wn70+of4uApJdIt7zF1ceKWh30fbo3PDjotcW60BPo3/wShGvq3GGR
         n6exb+hpXk59oJCu3SJBAlzyw3nZVcUkjcDSH/AsQk/CfT7V0De17OuCA4plNOeKTWVb
         gHo3Fl9CXetlsymKsQQUP6CbTx3EuuOr/7ciJfUh2t6+KBtwPPq4PxzihtZJNJVX/dW5
         W2OPr65bk0YKbxuefxv3VmxfuyDwem3eVrqu7z3pTRIbWCMSPwCSdpR2yofD4UvEnhwE
         EELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769160702; x=1769765502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=26CDK72HEOnmUsZ1CXy1/05/oLpi5raMr9WBDPBMZ7k=;
        b=lNwKXtSkYF2M527aGeoD/iUB0hlhQWQsno05SHTU4GwT3PP0pRJqajZut7WK1ClAws
         5M1OAqz22EeuOjwL169rS4GSX9zYMtgVfVSA68CuKd0WOU/wsde00NNmTU6ug5kgzAUv
         yxCNVGR/UJsj1+n7rpwbJfqPoxvVOqfi7xH1dJnGKrfz9kOcx3JSrW+DcxXOMg3r1zFN
         pHMEL9nyxpOIpiAEDmbRpjyMbERZoN/UP1EQnnMJgVL2BuKHgx/7qwD4bO1NlqsdTN//
         AgtyZ4UOvK6Bk0kBZ4rwt1BRT2KTbHwlTIB3ETzPpQIDwLIs/E6R8PAQFl81HAnm08CQ
         Vpsw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9sC9zPdtIbwNbMn8Ugf5UScZSbDkLRkckoD0NPrMX6LzIBHVY70XbdW/FxK4sEnmSdtLTSYP0g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0fzkI5sqgGdIijJDpUBSo1qWW1SsdyAhNrTA112aL3ba+kYoN
	xMwqzVLSMS5IaJVRFeQurfWVs82n5z6ev9QRmMpxozvYFqChp2WNkvwewGtGkybE6z3UCtSpzCD
	tYQAThbifEytuTcJNoIyjAB3HaWh0JueCUsDwdogirw1ZPl03Utepa2nZcNotww==
X-Gm-Gg: AZuq6aII0VZXQofHDDzDmq4H5qAn3L2BGSqet4nElhYQ0OariDG6ueo/obPd7FD6Aub
	cAhg8876hwBMc0oITqNo/2MO3qIOCle5Mymw7BNWceEySgSwMtMXD3FoJKu43RoqQL1l5Tg2vAf
	d5I9v8bE9RBnQyH518+3H1yvCnyeIsNssG5Et/VycukN+N05D3hHPsybKZ+qLh5bb7HKJi3Ua7C
	qibRjTdcuml0QKvBpq4u6pmtVxQ9vEWi/QgPfVR9gYTD+sD4M9G2AWn3haPeBcGlvq0wMhsY+S9
	Jk92VU+cliCmk3hiDxsiC4o9tTH/QsoF8o9AzFJdaGbSd5519fUwI0P8uixtU8993jKaHKrDg+M
	vdR8vtnr1sjtUVCkmH0swsQGsaPG+N3Dqqa0gwMk=
X-Received: by 2002:a05:620a:2a01:b0:8c6:b001:c1d5 with SMTP id af79cd13be357-8c6e910a7dcmr53105585a.5.1769160701649;
        Fri, 23 Jan 2026 01:31:41 -0800 (PST)
X-Received: by 2002:a05:620a:2a01:b0:8c6:b001:c1d5 with SMTP id af79cd13be357-8c6e910a7dcmr53103085a.5.1769160701228;
        Fri, 23 Jan 2026 01:31:41 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:1c86:c19d:d843:dd83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c30293sm5717115f8f.19.2026.01.23.01.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 01:31:40 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
        Frank Li <Frank.Li@nxp.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: (subset) [PATCH v6 0/4] PCI: Add initial support for handling PCIe M.2 connectors in devicetree
Date: Fri, 23 Jan 2026 10:31:38 +0100
Message-ID: <176916069326.12678.16550242235025273411.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122-pci-m2-v6-0-575da9f97239@oss.qualcomm.com>
References: <20260122-pci-m2-v6-0-575da9f97239@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ctu8sLlV4n9LsAIeTMWJkHaed8_1c6_S
X-Proofpoint-ORIG-GUID: ctu8sLlV4n9LsAIeTMWJkHaed8_1c6_S
X-Authority-Analysis: v=2.4 cv=H7TWAuYi c=1 sm=1 tr=0 ts=69733ffe cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JrKmLYXSX60uSqAbQrQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA3NSBTYWx0ZWRfX9GeV+tAjtjji
 opbIcRb2k8aqmhtB9/GasMH/dmQvujcVoC193vcpf46kpBErm7GvzeHymDGj6scZ3IEfJkvkg9X
 1+AL93wYAgRGTncMMIH1/mKiZ6lS3upuseIh+7eu/SRF9VMVvwHwSdvFG+0cie8Yro66wcGrP8A
 uuu+01flA8OqxN4v8Im2cECPhSSZZJ1jkaWeI4X6zLhE3ErKb0fu0JtXazNNuYAbTHsYEXqTBR2
 1HfhmZgbY1gRPPOqYojmTb+Hut15HU+hWugQlrI9nhxKc9b7fk4tUppWPRdIMNe3RFdXLEnfmxN
 8wEe7mKLQtUYJwDGQLuc2s2MpmTdT6BD3gzU0Miw8UwHgw89dEjHMieSx6sKRL2TtPNjWqWbO9h
 +5xg/t5TmST6swpoTwHAyuj7fQolWrUAA4tEUw2c5pEH+ur0W9oy768gi1qSs+UcADisi3zphNF
 w/yvqNrL1VbkNEgQzaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230075
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41356-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B1E99737F4
X-Rspamd-Action: no action


On Thu, 22 Jan 2026 22:46:50 +0530, Manivannan Sadhasivam wrote:
> This series is an initial attempt to support the PCIe M.2 connectors in the
> kernel and devicetree binding. The PCIe M.2 connectors as defined in the PCI
> Express M.2 Specification are widely used in Notebooks/Tablet form factors (even
> in PCs). On the ACPI platforms, power to these connectors are mostly handled by
> the firmware/BIOS and the kernel never bothered to directly power manage them as
> like other PCIe connectors. But on the devicetree platforms, the kernel needs to
> power manage these connectors with the help of the devicetree description. But
> so far, there is no proper representation of the M.2 connectors in devicetree
> binding. This forced the developers to fake the M.2 connectors as PMU nodes [1]
> and fixed regulators in devicetree.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: connector: Add PCIe M.2 Mechanical Key M connector
      commit: 926194a6675a9cd5943f85820508648b74669fc6
[4/4] power: sequencing: Add the Power Sequencing driver for the PCIe M.2 connectors
      commit: 52e7b5bd62bab3851f25d8b70ad7eae9e94aba60

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


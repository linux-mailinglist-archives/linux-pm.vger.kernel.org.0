Return-Path: <linux-pm+bounces-35531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43277BA7FA1
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 07:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC1817F959
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 05:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A5721D3E4;
	Mon, 29 Sep 2025 05:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hANj6aDH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E1A218AAF;
	Mon, 29 Sep 2025 05:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759122481; cv=none; b=AEBR6jUHq20O63xFuPot62xfOL8h4jIEmt6Nb4n4t22Qus7/TJZd+B3+HSUxRHufij5zwSVaYmjpBlnOr6dy9pfJFXZ17yeetwMuvdpiGyQOMeZGWmf7CU0+4nB2SFYayxZGVF+sXg4fk6IpJHsf4V+NYKE2DiO02Nxsj5h9M5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759122481; c=relaxed/simple;
	bh=vfFY6Fgg0uQYZhD+JpV5baaijLk+GlYbbJkWNTXbTG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ecuLMQkfGhIF9ChOqwk4smo/jVuXOV1eNfREL8TQOMJx080CDysTumyEgmZ8Hl5AX6f4Z0LYyMc/xpIixaT+1nTFangkPvRMcrt2j9Efl9MY3gWGJaDoc0sSdNGR9/9uvh7Kixp7HBO4NoRl5gZpVyhJS/W0Q2lvdVz/oasGT4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hANj6aDH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SNhIdm030750;
	Mon, 29 Sep 2025 05:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vfFY6Fgg0uQYZhD+JpV5baaijLk+GlYbbJkWNTXbTG4=; b=hANj6aDHSZkHZZnq
	X9zopu7lOu/tpAxJM0/SwkZj0unISuxhaDJFw8cLGHhM3kwAhNAEzcesqDquRyVv
	LceJioRALe0tj1bUzsMg1cF3Twz6SgQWkxGJ68VTUftDpX/Fb5G5OFD9t4zkgOOT
	4T4H4KFU5CSABFx6DV9zL6EyPIPoqblps8kPPxyZf2XHY/xCIRWtD70shJZe7Zgf
	sCDxvqXURLIDrzI6JThLO8+fpLb3QfvBRPBB1m43dimh7Zdt6Oii1sgMlX/q8Pay
	BRpsSFKbQ6DYTVIDQsQBpkaSopy/+CyoJ73NYNmTzS8Oz8KlRrm+APyAY8NYr5B2
	wjtBig==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e977kq7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 05:07:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58T57tG4032454
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 05:07:55 GMT
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Sun, 28 Sep 2025 22:07:55 -0700
Received: from nalasex01c.na.qualcomm.com ([fe80::fbb2:6e42:b3:9ade]) by
 nalasex01c.na.qualcomm.com ([fe80::fbb2:6e42:b3:9ade%11]) with mapi id
 15.02.1748.024; Sun, 28 Sep 2025 22:07:55 -0700
From: "Lakshmi Sowjanya D (QUIC)" <quic_laksd@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "manivannan.sadhasivam@oss.qualcomm.com"
	<manivannan.sadhasivam@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Konrad Dybcio
	<konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "Raviteja Laggyshetty (QUIC)" <quic_rlaggysh@quicinc.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] interconnect: qcom: sdx75: Drop QPIC interconnect
 and BCM nodes
Thread-Topic: [PATCH v2 1/2] interconnect: qcom: sdx75: Drop QPIC interconnect
 and BCM nodes
Thread-Index: AQHcLrC5pSAvhVWPmUGPuho09nRr2LSl7+qAgAOwVzA=
Date: Mon, 29 Sep 2025 05:07:54 +0000
Message-ID: <410402ca56434110956c802aa760a893@quicinc.com>
References: <20250926-sdx75-icc-v2-0-20d6820e455c@oss.qualcomm.com>
 <20250926-sdx75-icc-v2-1-20d6820e455c@oss.qualcomm.com>
 <e1427bcc-0502-4cfe-9cb2-bae5bb10208e@oss.qualcomm.com>
In-Reply-To: <e1427bcc-0502-4cfe-9cb2-bae5bb10208e@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zaiCoWpwBqGzPEMyFsPTv2hB9hZ-ENaM
X-Proofpoint-ORIG-GUID: zaiCoWpwBqGzPEMyFsPTv2hB9hZ-ENaM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfX+WcXjzE27Xkd
 W4kmxp09K5zWdqJ+Zent3coSumUC4yeTjFNdIscdmwYLx/yl2mb1rGZjR2nV9not4wBzGSLbmFg
 Hg5og38WWJCwCaZNNdU4eUtkRVq8l899danVdQpVtZR385k4wCVsHKqPZVJNuXqAMQ5Mo06gWTO
 /m52rRiqIfMk21n4KfFje6tvfBcD9FkR/q/pZXHtwnQ1WgA+zcQp2ng0e/OP1nYQGennv42w9q+
 sf9f5U2q4R3tro9YcLG1M3NGkhuJsr+Gv7uNW5LODpWMqFZb/Cjfh1oe3/vlMUJyOFpASkJHKgA
 avDjQjfWctT80hlS0/FMLr03sshVV1gyEsiy1FX+OMWIOfAW5lRwrz/SLr0IjZb+X0k94vywm4C
 ceGulyivmMZXrUpwGJuWen/opVpLXA==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68da142c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=xqWC_Br6kY4A:10 a=z-ZphTX21k8A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=CAalGqBDv7JL3bErN0AA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS29ucmFkIER5YmNpbyA8
a29ucmFkLmR5YmNpb0Bvc3MucXVhbGNvbW0uY29tPg0KPiBTZW50OiBGcmlkYXksIFNlcHRlbWJl
ciAyNiwgMjAyNSA3OjE3IFBNDQo+IFRvOiBtYW5pdmFubmFuLnNhZGhhc2l2YW1Ab3NzLnF1YWxj
b21tLmNvbTsgR2VvcmdpIERqYWtvdg0KPiA8ZGpha292QGtlcm5lbC5vcmc+OyBSb2hpdCBBZ2Fy
d2FsIDxxdWljX3JvaGlhZ2FyQHF1aWNpbmMuY29tPjsgS29ucmFkDQo+IER5YmNpbyA8a29ucmFk
eWJjaW9Aa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0
b2YNCj4gS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9y
K2R0QGtlcm5lbC5vcmc+DQo+IENjOiBsaW51eC1hcm0tbXNtQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsg
S3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPjsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IE1hbml2YW5uYW4NCj4gU2FkaGFzaXZhbSA8bWFu
aUBrZXJuZWwub3JnPjsgUmF2aXRlamEgTGFnZ3lzaGV0dHkgKFFVSUMpDQo+IDxxdWljX3JsYWdn
eXNoQHF1aWNpbmMuY29tPjsgTGFrc2htaSBTb3dqYW55YSBEIChRVUlDKQ0KPiA8cXVpY19sYWtz
ZEBxdWljaW5jLmNvbT47IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MiAxLzJdIGludGVyY29ubmVjdDogcWNvbTogc2R4NzU6IERyb3AgUVBJQw0KPiBpbnRl
cmNvbm5lY3QgYW5kIEJDTSBub2Rlcw0KPiANCj4gT24gOS8yNi8yNSA4OjQyIEFNLCBNYW5pdmFu
bmFuIFNhZGhhc2l2YW0gdmlhIEI0IFJlbGF5IHdyb3RlOg0KPiA+IEZyb206IFJhdml0ZWphIExh
Z2d5c2hldHR5IDxxdWljX3JsYWdneXNoQHF1aWNpbmMuY29tPg0KPiA+DQo+ID4gQXMgbGlrZSBv
dGhlciBTRFggU29DcywgU0RYNzUgU29DJ3MgUVBJQyBCQ00gcmVzb3VyY2Ugd2FzIG1vZGVsZWQg
YXMgYQ0KPiA+IFJQTWggY2xvY2sgaW4gY2xrLXJwbWggZHJpdmVyLiBIb3dldmVyLCBmb3IgU0RY
NzUsIHRoaXMgcmVzb3VyY2Ugd2FzDQo+ID4gYWxzbyBkZXNjcmliZWQgYXMgYW4gaW50ZXJjb25u
ZWN0IGFuZCBCQ00gbm9kZSBtaXN0YWtlbmx5LiBJdCBpcw0KPiA+IGluY29ycmVjdCB0byBkZXNj
cmliZSB0aGUgc2FtZSByZXNvdXJjZSBpbiB0d28gZGlmZmVyZW50IHByb3ZpZGVycywgYXMNCj4g
PiBpdCB3aWxsIGxlYWQgdG8gdm90ZXMgZnJvbSBjbGllbnRzIG92ZXJyaWRpbmcgZWFjaCBvdGhl
ci4NCj4gPg0KPiA+IEhlbmNlLCBkcm9wIHRoZSBRUElDIGludGVyY29ubmVjdCBhbmQgQkNNIG5v
ZGVzIGFuZCBsZXQgdGhlIGNsaWVudHMNCj4gPiB1c2UgY2xrLXJwbWggZHJpdmVyIHRvIHZvdGUg
Zm9yIHRoaXMgcmVzb3VyY2UuDQo+ID4NCj4gPiBXaXRob3V0IHRoaXMgY2hhbmdlLCB0aGUgTkFO
RCBkcml2ZXIgZmFpbHMgdG8gcHJvYmUgb24gU0RYNzUsIGFzIHRoZQ0KPiA+IGludGVyY29ubmVj
dCBzeW5jIHN0YXRlIGRpc2FibGVzIHRoZSBRUElDIG5vZGVzIGFzIHRoZXJlIHdlcmUgbm8NCj4g
PiBjbGllbnRzIHZvdGluZyBmb3IgdGhpcyBJQ0MgcmVzb3VyY2UuIEhvd2V2ZXIsIHRoZSBOQU5E
IGRyaXZlciBoYWQNCj4gPiBhbHJlYWR5IHZvdGVkIGZvciB0aGlzIEJDTSByZXNvdXJjZSB0aHJv
dWdoIHRoZSBjbGstcnBtaCBkcml2ZXIuIFNpbmNlDQo+ID4gYm90aCB2b3RlcyBjb21lIGZyb20g
TGludXgsIFJQTWggd2FzIHVuYWJsZSB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuDQo+ID4gdGhlc2Ug
dHdvIGFuZCBlbmRzIHVwIGRpc2FibGluZyB0aGUgUVBJQyByZXNvdXJjZSBkdXJpbmcgc3luYyBz
dGF0ZS4NCj4gPg0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gRml4ZXM6IDM2
NDJiNGU1Y2JmZSAoImludGVyY29ubmVjdDogcWNvbTogQWRkIFNEWDc1IGludGVyY29ubmVjdA0K
PiA+IHByb3ZpZGVyIGRyaXZlciIpDQo+ID4gU2lnbmVkLW9mZi1ieTogUmF2aXRlamEgTGFnZ3lz
aGV0dHkgPHF1aWNfcmxhZ2d5c2hAcXVpY2luYy5jb20+DQo+ID4gW21hbmk6IGRyb3BwZWQgdGhl
IHJlZmVyZW5jZSB0byBiY21fcXAwLCByZXdvcmRlZCBkZXNjcmlwdGlvbl0NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0NCj4gPiA8bWFuaXZhbm5hbi5zYWRoYXNpdmFt
QG9zcy5xdWFsY29tbS5jb20+DQo+ID4gLS0tDQo+IA0KPiBUb28gYmFkIG5vIG9uZSBub3RpY2Vk
IGZvciB0aGUgMiB5ZWFycyB0aGUgcGxhdGZvcm0gaGFzIGJlZW4gdXBzdHJlYW0uLg0KPiANCj4g
UmV2aWV3ZWQtYnk6IEtvbnJhZCBEeWJjaW8gPGtvbnJhZC5keWJjaW9Ab3NzLnF1YWxjb21tLmNv
bT4NCj4gDQo+IEtvbnJhZA0KDQpUZXN0ZWQtYnk6IExha3NobWkgU293amFueWEgRCA8cXVpY19s
YWtzZEBxdWljaW5jLmNvbT4gICMgb24gU0RYNzUNCg0KUmVnYXJkcywNCkxha3NobWkgU293amFu
eWEgRA0KDQoNCg==


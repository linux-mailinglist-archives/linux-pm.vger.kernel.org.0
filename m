Return-Path: <linux-pm+bounces-38716-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A61E8C89F0E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 14:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32218346F5F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 13:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1057F257844;
	Wed, 26 Nov 2025 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KJjVi5mk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34755223323;
	Wed, 26 Nov 2025 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764162422; cv=none; b=UsOLsxIJgHVzLs9TrCBABN/brseKx0Mt0PPrn6UeX5EOoFy7rTYRbbDvDReeebNFuvoOxnn0g3YyHgD8yjys+0SjN9H3WkGdH30MB/lAltl5rQBZwbW+Fi0b0n2fwIM3HoWOEmhGonQyRKkFsQhmt/K+yCQKaU+vhzQXvafHac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764162422; c=relaxed/simple;
	bh=OsXXqanu7Fc/FHJFr7chkM7XN9rTUJzf+nvZFgq1t7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H60/LMeQiRUFJerz6pEKdQ+RPIwzs1pH/d79IijJT0mHq4sJ8m4os/jFNtRbLs4s2FUjooR4nPeIcJeXQfpRRDhJIg+OOW+6twvn29akc1z6Gq68hDH0DJxWCI3drotQIwxLWDCnjw+oDRTD2vFLSEeINBmX6dWl7SlIE99qwD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KJjVi5mk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQ8pr3R3666525;
	Wed, 26 Nov 2025 13:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vvKX8i297Jsnq7FNSqSVlGZBYZd6BsBEVL7m2QqBuC8=; b=KJjVi5mk76Kqv8Mv
	yjvY1qXYlHLU6FIgnW0rb88FGCu8IFF7QM99lIbqIG+8TDjspvbQxmGAmOGNDlQx
	UeXGL3m6f9Bb5AsPYgvNl1x5ltlMwsRi5TiVRxJCfsNgCPlCIowgRtDIwr7g9Z8Z
	xnXVTII0XDDh+zzi4C/FS4LuOj4kEa80mdlctxVTKutiDAcwbEXy026NWTnp+UAh
	SZCxoVth3gksweve9N4L7ttt4ETNb+h16hzpe6unEzIEUVE8VB03zdCtwcO1o3Mc
	+RIYDbDXEzhbFywq1gS7m2DeYJQnr+s5LL39Xl0WpDwPVV5hnAgmQEWmQIrBsBrP
	t0FarQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4anmemt6pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 13:06:57 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQD3ZCS010632;
	Wed, 26 Nov 2025 13:06:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4anw4svhrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 13:06:53 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AQD6rMR014356;
	Wed, 26 Nov 2025 13:06:53 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-kotarake-hyd.qualcomm.com [10.213.97.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 5AQD6rDN014355
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 13:06:53 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2389607)
	id C994DAF3; Wed, 26 Nov 2025 18:36:52 +0530 (+0530)
Date: Wed, 26 Nov 2025 18:36:52 +0530
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kamal.wadhwa@oss.qualcomm.com, fenglin.wu@oss.qualcomm.com
Subject: Re: [PATCH 1/2] dt-bindings: battery: Add SiLION battery bindings
 technology
Message-ID: <20251126130652.mnsy5s3a2ymh33nw@hu-kotarake-hyd.qualcomm.com>
References: <20251124-add_silion_battery-v1-0-3c86b70d2543@oss.qualcomm.com>
 <20251124-add_silion_battery-v1-1-3c86b70d2543@oss.qualcomm.com>
 <2deb7496-3094-4d03-b4d0-fb15cfdc6f0e@kernel.org>
 <20251125145929.p4sl43qim4oiyspa@hu-kotarake-hyd.qualcomm.com>
 <953f2e57-77a5-42c7-ba3a-9fa40be9d7af@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <953f2e57-77a5-42c7-ba3a-9fa40be9d7af@kernel.org>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9OMI_9o8990BxgXwFoLbftD_kKkbOVaO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDEwOCBTYWx0ZWRfXyogUEVeYaYs/
 px6w8qF68luQwQuxxJAnAFuif6xkIZcFrxXlDixRipMBhHd/rgGaWB3d5Dh42mkWVNZhSucMfMP
 VOw1XDL6T6VMjYUnNFDJgwGD8nOHSRqObehYVaJzIoc5do1wbHQdiM97vTjEB2XFEfV71+/keGa
 1qyQjn4tSFYnRzA05wxA+k+3TiL16xXKG7eus0wNQTt1hICukvMB7OR+qBd9ik/zHbs22JyoByf
 R26mUHZyIjquBRtwjXWxTt+bs1I8SnIt5v4iXUpZmfWkI1ResORna1OJhPvW110MLDUTdzYO0aJ
 zqlV/w3Wd7qk+1GONk6ZisRe1Ug4qhy92J4pwJI48WGKYM5WEsj6Mqmis9UmfKS1PVY7aqMm5/p
 PgVNBSHPMH+2PKy101ManBbDHLJyxA==
X-Proofpoint-GUID: 9OMI_9o8990BxgXwFoLbftD_kKkbOVaO
X-Authority-Analysis: v=2.4 cv=bZBmkePB c=1 sm=1 tr=0 ts=6926fb71 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=tbCVdtF1PW6lmFMJIDkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511260108

On Wed, Nov 26, 2025 at 09:14:23AM +0100, Krzysztof Kozlowski wrote:
> On 25/11/2025 15:59, Rakesh Kota wrote:
> > On Mon, Nov 24, 2025 at 12:37:01PM +0100, Krzysztof Kozlowski wrote:
> >> On 24/11/2025 12:12, Rakesh Kota wrote:
> >>> Document a new battery chemistry for silicon-anode lithium-ion
> >>> cells.
> >>>
> >>> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/power/supply/battery.yaml | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/Documentation/devicetree/bindings/power/supply/battery.yaml
> >>> index 491488e7b970397b409c248fb0c2a524301686a9..49cbd03956eeb9fc8be72540d8bf35840ccd7156 100644
> >>> --- a/Documentation/devicetree/bindings/power/supply/battery.yaml
> >>> +++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
> >>> @@ -44,6 +44,7 @@ properties:
> >>>        - const: lithium-ion-polymer
> >>>        - const: lithium-ion-iron-phosphate
> >>>        - const: lithium-ion-manganese-oxide
> >>> +      - const: lithium-ion-silicon-anode
> >>
> >>
> >> Where is any DTS user of this? You have entire cover letter to explain
> >> the background WHY you are doing this.
> > This new lithium-ion-silicon-anode chemistry is intended for the
> > Kaanapali platform, where we validate the silicon-anode Li-ion cells.
> > The bindings and driver changes were tested with the Kaanapali device.
> Again: DTS. Please answer that part.
>
Actually, the device-chemistry property (lithium-ion-silicon-anode) is
not added in Kaanapali DT because this battery chemistry and other
information is obtained from the charger firmware, which runs on
the remote processor.

I added this change mainly for completeness. If you feel it isn’t
necessary, I’m fine with dropping it and proceeding without this change.

Best regards,
Rakesh

> Best regards,
> Krzysztof


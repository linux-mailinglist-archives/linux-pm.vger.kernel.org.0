Return-Path: <linux-pm+bounces-38613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE6EC859B3
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 16:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAE03A395D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692D53271FE;
	Tue, 25 Nov 2025 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cl7OEsPf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832933271FB;
	Tue, 25 Nov 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082779; cv=none; b=oLOvetQ7PKk/BXJFj6n53pJDiI9kCzgxNlfvInwlQgNzghxxJaaZ4qMiiWeQwoxIDJStCn0Z04EsTQfSmmkCrsPX+I3wFVmC+It3h7bFx2wEJgrkanht4uR2Q9MjK7DbdeRyVipPx0CV3JkzYwj9yMwZT3hSIZpDd2izBik/nyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082779; c=relaxed/simple;
	bh=ieY1eN4kZPvcQNx7vL8ig9KQt6l5tVqarni7mHD49aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+E1auFnKBbIb735nTQDd3goaGmcA3nAg44uPfBDu7MGN9hgug8QIe12mIrYOVMUuvzepkfogH9EMhiAlX5z2hg5h/oq5BESIisB3d1749UN/pjxoBlvBcYEd6lYxMPFiA2z5plBdRBB8MJWQdx9wFnJVBXu7x5mXDh+eOhep5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cl7OEsPf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APA9GQ71979152;
	Tue, 25 Nov 2025 14:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=CCAaIfma8+JYAceDg7SZheey
	8BYBmWZG5MfSmMQEDXo=; b=cl7OEsPf6utYTiAYLiM9wk5NgIk7qigxGqiFocts
	EteQLE4dv1xez3hUlNiWLvYIQ+nBhtkx/h3JJCNW+MIUUILkAT0nIBkn3qnUzzzv
	NIz3X/YNw/PT/RFLdE7NrRxpGzQ5KhLonwMOruTf3WLO66wfNz/cJxRJuQBdZaV3
	IB9Y86NHd7nJWA+T9reFx34cazUsqZDzvCx1pTND/SnR8Qc2vKnwKZY0H3P7yfAq
	i4YSWDqlmftHobqJjxSOrxLf3hPFRddUUKta20yu1VToKEQ+WVhW6FfEELvXOqKF
	+b2A6mqUqKsqu6R5PObkNthcz5EtSKNdqq1VlTnDN6HpAA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amw9gu10n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 14:59:34 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5APExV0L027961;
	Tue, 25 Nov 2025 14:59:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4ak68n9n1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 14:59:31 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5APExUUB027943;
	Tue, 25 Nov 2025 14:59:30 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-kotarake-hyd.qualcomm.com [10.213.97.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 5APExUrG027942
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 14:59:30 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2389607)
	id B9A4BAEC; Tue, 25 Nov 2025 20:29:29 +0530 (+0530)
Date: Tue, 25 Nov 2025 20:29:29 +0530
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kamal.wadhwa@oss.qualcomm.com, fenglin.wu@oss.qualcomm.com
Subject: Re: [PATCH 1/2] dt-bindings: battery: Add SiLION battery bindings
 technology
Message-ID: <20251125145929.p4sl43qim4oiyspa@hu-kotarake-hyd.qualcomm.com>
References: <20251124-add_silion_battery-v1-0-3c86b70d2543@oss.qualcomm.com>
 <20251124-add_silion_battery-v1-1-3c86b70d2543@oss.qualcomm.com>
 <2deb7496-3094-4d03-b4d0-fb15cfdc6f0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2deb7496-3094-4d03-b4d0-fb15cfdc6f0e@kernel.org>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDEyNCBTYWx0ZWRfX7mhtagwIgDK9
 qIEt2/Ridc2pgwN9nPY8Ogd3i9KvxaMNaRZi2ekLLjsuQkoieh8Qt/rdJjPn0s3x+X831aEx20I
 P6JILjtdex5qCqD1BzFSkhohzyxPVaVOZP04OA2DpnZLyDef6XD/RZZFnG+UNk5wmnrqHdXj9R1
 nxWuaB9j2mVKWerdP4v0Tm9rGPxpCb/2M9Ra+T3TnRDNNhhoPkvnSOKNlaVdMgS2xyzdIKjq1xH
 rgQbBisC7V3ttFKRk/6zEaFk/kNs8IWJ+vb+G4XqJyWe7GZQ9ruIIuBGaqV9lUx35cunsRHdIl1
 7n3eKrC/0pXJZb75SWYNlhMMKZxtLGukO9OWyy336eYWhNfMRMvohaPRhyKztpKVyDJHM5d2ypL
 qDMza0JoJCQ8UM96qhAyzJ+podgf0A==
X-Authority-Analysis: v=2.4 cv=H53WAuYi c=1 sm=1 tr=0 ts=6925c456 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=LrSAaqx36FtREgGPrTMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 2ZkMXad8tZM3qfLapTc3BDEAzOxjpuH1
X-Proofpoint-GUID: 2ZkMXad8tZM3qfLapTc3BDEAzOxjpuH1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250124

On Mon, Nov 24, 2025 at 12:37:01PM +0100, Krzysztof Kozlowski wrote:
> On 24/11/2025 12:12, Rakesh Kota wrote:
> > Document a new battery chemistry for silicon-anode lithium-ion
> > cells.
> > 
> > Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/power/supply/battery.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/Documentation/devicetree/bindings/power/supply/battery.yaml
> > index 491488e7b970397b409c248fb0c2a524301686a9..49cbd03956eeb9fc8be72540d8bf35840ccd7156 100644
> > --- a/Documentation/devicetree/bindings/power/supply/battery.yaml
> > +++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
> > @@ -44,6 +44,7 @@ properties:
> >        - const: lithium-ion-polymer
> >        - const: lithium-ion-iron-phosphate
> >        - const: lithium-ion-manganese-oxide
> > +      - const: lithium-ion-silicon-anode
> 
> 
> Where is any DTS user of this? You have entire cover letter to explain
> the background WHY you are doing this.
This new lithium-ion-silicon-anode chemistry is intended for the
Kaanapali platform, where we validate the silicon-anode Li-ion cells.
The bindings and driver changes were tested with the Kaanapali device.

I will update the background in the cover-letter in the next revision.

Best regards
Rakesh
> 
> Best regards,
> Krzysztof


Return-Path: <linux-pm+bounces-27889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F48AC9356
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 18:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEFA4A636A
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 16:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD591B3925;
	Fri, 30 May 2025 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="er40mdai"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E574019F464;
	Fri, 30 May 2025 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621888; cv=none; b=T4aifpozcPVZwhgHJFemJipB/KAxnDTVenF6kargivf8bEKRGt/Nygzbjn0QMpOioa97792cxL5iZ/fhg1EHGc53GmKLF5YHcdXYojG1oat6aR3jV2PZWNJK2IrD6OgwnMiWHMX72/6knzaiweDnhTbvRNL3VnIW4jUrc3SwNm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621888; c=relaxed/simple;
	bh=vAWQYCTr0g8Jj++jwDJUlJObUMnqSdMEUMM/7GkCThc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GRMOyXC9XXYYTb+PB6amUzaT8+IQbr+381Z7/9BGmnDxqkiSAF1DFG5EviFOoslipk+XXDNYdBLOyvcyEx439I4ZG+8Cyijig/S/y2dssfcDO3+byq1r24QFpIsqb0xoERVXMz7rQ9QX5ecUtCfxoOxyGfeIde7eXN7fb0Ve4jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=er40mdai; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
	by mxout4.routing.net (Postfix) with ESMTP id 8CDB410087D;
	Fri, 30 May 2025 16:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1748621519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXpZtq+duYw8Ga6sy20MCkY0YEpeKd2cv2ExbMjZY+M=;
	b=er40mdaiLOUvmyVyf76eknKyl/pvXGbzBX7kZ9adIUywsTU0M4OjaKuiAZm0ePve2h8i4Q
	63/CHlvoWvLJpSG+B+iGhoxbHTOvcgyeXcengqxPOFGp3X3YwDWAXgrgVhyVOARp2GmvlB
	qUanoQM/pect+XWh1w9ZXgL2y/LbKgM=
Received: from [IPv6:::1] (unknown [IPv6:2a01:599:211:5368:40c2:8021:ae8a:bf1c])
	by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 4CBF940112;
	Fri, 30 May 2025 16:11:58 +0000 (UTC)
Date: Fri, 30 May 2025 18:11:58 +0200
From: Frank Wunderlich <linux@fw-web.de>
To: Conor Dooley <conor@kernel.org>
CC: MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jia-Wei Chang <jia-wei.chang@mediatek.com>,
 Johnson Wang <johnson.wang@mediatek.com>,
 Frank Wunderlich <frank-w@public-files.de>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [RFC v1] dt-bindings: interconnect: add mt7988-cci compatible
User-Agent: K-9 Mail for Android
In-Reply-To: <20250530-naturist-swept-973a1f8f4b08@spud>
References: <20250528135251.6492-1-linux@fw-web.de> <20250530-naturist-swept-973a1f8f4b08@spud>
Message-ID: <C75720B1-AD09-4A48-98FD-7FD8116934F7@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: f6b9ed74-8c20-42fa-80f7-3ad1dd003abb

Hi

Thank you for review=2E

Am 30=2E Mai 2025 17:57:20 MESZ schrieb Conor Dooley <conor@kernel=2Eorg>:
>On Wed, May 28, 2025 at 03:52:49PM +0200, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Add compatible for Mediatek MT7988 SoC with mediatek,mt8183-cci fallbac=
k
>> which is taken by driver=2E
>
>What's RFC about the patch?

We have merge window,but maybe this rule is
net(-next) only=2E And i was unsure if enum for
new compatible is right or if i should use 2
const=2E

>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>>  =2E=2E=2E/bindings/interconnect/mediatek,cci=2Eyaml          | 12 ++++=
+++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/interconnect/mediatek,cc=
i=2Eyaml b/Documentation/devicetree/bindings/interconnect/mediatek,cci=2Eya=
ml
>> index 58611ba2a0f4=2E=2E2c6785c588e9 100644
>> --- a/Documentation/devicetree/bindings/interconnect/mediatek,cci=2Eyam=
l
>> +++ b/Documentation/devicetree/bindings/interconnect/mediatek,cci=2Eyam=
l
>> @@ -17,9 +17,15 @@ description: |
>> =20
>>  properties:
>>    compatible:
>> -    enum:
>> -      - mediatek,mt8183-cci
>> -      - mediatek,mt8186-cci
>> +    oneOf:
>> +      - items:
>
>This "- items:" is redundant=2E

Ok,i try without it=2E

>> +          - enum:
>> +              - mediatek,mt8183-cci
>> +              - mediatek,mt8186-cci
>> +      - items:
>> +          - enum:
>> +              - mediatek,mt7988-cci
>> +          - const: mediatek,mt8183-cci
>> =20
>>    clocks:
>>      items:
>> --=20
>> 2=2E43=2E0
>>=20


regards Frank


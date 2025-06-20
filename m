Return-Path: <linux-pm+bounces-29156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A88A4AE190D
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 12:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521353AFD3B
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 10:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85066285CA7;
	Fri, 20 Jun 2025 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="BWZHLfWL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE5C101EE;
	Fri, 20 Jun 2025 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415786; cv=none; b=d3f35O/ajYfZj3muyuYCbc99W5Q6dhf8QGhzt99bFq6nxUUdQ65g8c7fU03MDJL6h73LX640Cy+hqg9IJ3d8nGqYrNwcffWdX3K6Wz0cUrf1nKTkj7oB7Ae6K/EPc186duveUHjnE5OEVXtVsyr6Yx3qs5RYEV0kBRm+pEkLy4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415786; c=relaxed/simple;
	bh=YA/8455JNBiRGiG5LU/OFauBMfI9puQ8K3N/nTN5QUU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pSSl3EvDgATnjMV+a5RZgki+LXMV0PAgpFdeeVudiIQ+Ts9/p4mfaBmFQ6/DuilO301I62cGX3RWXIOgaqZGx/0viaLvJHVZraQrvhFO9OCH+jciE3/WmtpjjdbBiS0OzeHkVs/ISbbFhX3+D0Rz8IIlvSX0WZhs6IZq/N5dPaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=BWZHLfWL; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
	by mxout1.routing.net (Postfix) with ESMTP id CFE9440265;
	Fri, 20 Jun 2025 10:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750415782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymGnUSpkRYHimfXYhbTcSoJdcHrDDRnjSW4Hs85r/BU=;
	b=BWZHLfWL6yztxVhkUvb6zkqvR+EVMfS3EFL+phNtPF05FcCJtKkzgV+XzVTyfpvhF6uzgl
	WfjlMArQzLuwmI7YLZLPOPD4hE21LQJBmbVArjo8W4rd1hNEGz/6lECib4SZGX1vD0w0u8
	hVxlUDd2Rdd8DARtsQCVbfb3HBqu6Hk=
Received: from [127.0.0.1] (fttx-pool-157.180.225.81.bambit.de [157.180.225.81])
	by mxbox4.masterlogin.de (Postfix) with ESMTPSA id 12D1580238;
	Fri, 20 Jun 2025 10:36:20 +0000 (UTC)
Date: Fri, 20 Jun 2025 12:36:22 +0200
From: Frank Wunderlich <linux@fw-web.de>
To: Daniel Golle <daniel@makrotopia.org>
CC: MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Jia-Wei Chang <jia-wei.chang@mediatek.com>,
 Johnson Wang <johnson.wang@mediatek.com>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Felix Fietkau <nbd@nbd.name>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_01/13=5D_dt-bindings=3A_n?=
 =?US-ASCII?Q?et=3A_mediatek=2Cnet=3A_update_for_mt7988?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aFU4jSUFjWJlJCWJ@pidgin.makrotopia.org>
References: <20250620083555.6886-1-linux@fw-web.de> <20250620083555.6886-2-linux@fw-web.de> <aFU4jSUFjWJlJCWJ@pidgin.makrotopia.org>
Message-ID: <8EFC68B9-E560-4BB0-AD16-98A847D2F084@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: 2c931364-7c27-4fb5-b79b-85688067c00d

Am 20=2E Juni 2025 12:31:41 MESZ schrieb Daniel Golle <daniel@makrotopia=2E=
org>:
>On Fri, Jun 20, 2025 at 10:35:32AM +0200, Frank Wunderlich wrote:
>> @@ -40,7 +43,11 @@ properties:
>> =20
>>    interrupts:
>>      minItems: 1
>> -    maxItems: 4
>> +    maxItems: 8
>> +
>> +  interrupt-names:
>> +    minItems: 1
>> +    maxItems: 8
>
>Shouldn't interrupt-names only be required for MT7988 (and future SoCs)?
>Like this at least one entry in interrupt-names is now always required=2E

No,this section only allows this property and it
 is not listed in required section and so an
 optional property=2E But if it is defined in
 devicetree it needs 1 to 8 items=2E


regards Frank


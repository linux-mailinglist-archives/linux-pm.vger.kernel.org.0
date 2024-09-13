Return-Path: <linux-pm+bounces-14149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428B79780E2
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 15:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052F92882C7
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 13:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578371DB556;
	Fri, 13 Sep 2024 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dQgqPPdb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C071DB522;
	Fri, 13 Sep 2024 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233415; cv=none; b=ap+EW0zEUb6OMIwG6sQEb4Sc5LDDUPabzPtq5+9G0E/fJauSJTNF/NNxnXI4/2yKvL775n5qcPGIcHsx49b+99FAwHjBVyAkrinHMsRJIAP4BaQPVPuLYn+ZFXVI0F1Scnv627U8aBNOGkAFEGpKIncKx5VFETE/TGdK7cNROBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233415; c=relaxed/simple;
	bh=nbZRQ5VfiGPJOUcj1BhoToeRLsOwqy/4ntRWm+FnBVU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Z6QIAI3APoRkwKS73+h0JdJSi2qnAv3ghetQ+JZfMLti5bg3jTz2VWxj/0lHHBq5xd99CYbQoMjTIuREwFRWGiIGmBzBv5yDsGdONoXFV21MAe9U27g0BBToLkTX//TRGByzDamCiv3KBmswSiRTyCuLNTHRcMRbkmc2a7MbDu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dQgqPPdb; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726233381; x=1726838181; i=markus.elfring@web.de;
	bh=8LFZzyCZ81TZMkUL3zNXl93k6bEo5DfK2Ms9KdHmW5o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dQgqPPdb0UNlX80mTu0/7knW1GjbII001Q7PMngwMx8yVkzAAw2bxKemvdEVkmII
	 3tpR2vTs2lSThFuQoFKjUzG1LSjs8Ftqn8nyjALngNSAp8Gh+//vcT4D2cff1c226
	 arnM1Mh6YFoUiYnmDAKtDOgfTKEjsPJ6N5lZrLbhFC21Tf4I9sifJAWw9RmTSiqx8
	 7Z4ZZl7St/fKNKpHx0azBq7iSnu5J2hgr97xWhDR2VlObkMtAtStZ4CJw01hb6JJD
	 1FHPp4MR4yjy0fLbFzcPXiwBDoMXRS0olaeVM9SnqUg+Zr/hhq0okpGS7cxwnWaJb
	 cWIgpUaVaFOczXDw3g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MY5bT-1sUUEi1uhx-00JwqP; Fri, 13
 Sep 2024 15:16:21 +0200
Message-ID: <186de981-7a3c-4fdb-8911-8dfee597c759@web.de>
Date: Fri, 13 Sep 2024 15:16:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 cocci@inria.fr, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240825183116.102953-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] pmdomain: rockchip: Simplify dropping OF node reference
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240825183116.102953-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lSxIoQdC+s9CRKUItPCu1XcxxG4YbA4iSVgECTs4ptBWwKgy6yg
 3cBXw7xtPULueXwfcZJo+Jq+PBr6OmaCRiU/x4Yk8rlsidhuDvJbpTr0dstBpHsd8ysLR+E
 7yu59zCw63BverAZYGnwstXWXAYdGY+L88Mlg4kOiY2aF7bkm0LKrHdy86MCnf0rVrJjLf8
 CrSw63uxpFefauF1uqWjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nWtRG0sGK6I=;wDB3ikrhfP6m2ODBCoYTUaGaS8H
 fMZzMZC4QJhtXwjyhKrTHseO+JjtqAyHDNMIewHvd2FbIgsPfeIomTB3sjGk6fd3HqAuTKWzL
 mKusbLgaBqRMSEKTCsFpVOE7WZg5qhnQMnFPakRrM+p2rgq1StJXOCWBnu177R1hBTgPZNs9x
 S4OJVWxip7Ko/8VT4ImOaTrKQ1L7l0xrKDftm14raSbd4XNbaK4kQosFmEK0V3sQK7KvED1Yg
 LXR7mvNc+C4x4+IteYYcJ8n9ahbC+YiGcAB425zBVHrwgXetXQRF3fgQwFKXqh3nA1HcgEiRJ
 Pc+t0kILVeIDFCSjFrAb6iLfIoyCAV25k7UhJ/iFD+csOksY90yzlCIJUZMnFsYSwlTDCWn1m
 OY+iBr8A/sT/CFxTTXvTbxERAe17IB+4WxFmPV6aM5vIJsegx+iFpEMW5TmypFOGXSGDbw5kR
 5TpzcozuMIRE9G5a90mPqo7OSHr97Q4n02uN6oYOi9v5+eCSNvc7J3sBW4HjyLpNgK+SVPXHa
 ZopbqrtRTuVgsLCyXKnuML+Twp4XCdLa5xJxSq18Ny2fQ9RwvAiJi126iddPJfZOoM/F6eumQ
 DUeQ++omb11+Uzv7H2IJ1rusQ6+C0A7JErFp5C4n2qeO6sJU6pFJpdbNCKBzb1gfxYlBXNu7C
 CLIZXE2U7Pw4ByU/ROmhQpa33eM2BXZcvsFI9CwSxEorv7TXAwcf5xPgM1LBl0+0Bk4tpcsau
 mhq+obtBjfz2y76y6idIOcuDaYfP9E5av4odxR/2dMGJLJ5xZeIa3nGK2DnzWJFYhtKql5j++
 /xs6aDc9FcgiZ3Kc+Zc+aPVg==

> Drop OF node reference immediately after using it in
> syscon_node_to_regmap(), which is both simpler and typical/expected
> code pattern.

Dear Krzysztof,

I noticed also this contribution.
I found it easy to convert it also into the following small script variant
for the semantic patch language (Coccinelle software).


@adjustment@
expression e, x;
@@
+of_node_put(e);
 if (...)
 {
 <+... when !=3D e =3D x
-   of_node_put(e);
 ...+>
 }
-of_node_put(e);


58 patches were accordingly generated for source files of the software =E2=
=80=9CLinux next-20240913=E2=80=9D.
How would we like to tackle remaining update candidates according to simil=
ar transformation patterns?

Regards,
Markus


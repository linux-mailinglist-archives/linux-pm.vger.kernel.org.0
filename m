Return-Path: <linux-pm+bounces-30271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4C3AFB179
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 12:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFB53AB97D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D71B2957DE;
	Mon,  7 Jul 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="E37ud7G+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1151293C72;
	Mon,  7 Jul 2025 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751885011; cv=none; b=OSkS9tX2HRmnA+FbQ1NHfbeE8ki02NLQ3VkRDlfKQuwqRfNUKTwjBtS/RwDKO0vAtQHE/8szQ/kQnRVG+P1bf45AlJXWv0p13Qrrb15E8ghkRIZuVvDiNeLr8NG9y5vXlogpTMDxKtUiiJCNzOgZPmW66WlhjuGryEXwatxdmvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751885011; c=relaxed/simple;
	bh=siStwAWYKo6n77k71GRZdgIZ15JPl5J741/byKkZ9eQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ukKypJyGSifXRXStQuM+QmNSU8k11lnOK83H0tqW4xNBMh7l3f6BPYHsoHd5xf9dxwziaZUsR0B90ZUY1eU03G3anYKb7ffAwK6Cc/wrj2eLNF+PyvBLd5+yjluXgOMjNzw6GeDwLy561Evm27QixsSD0A+gHHWUt6zS7gebmxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=E37ud7G+; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1751885003; x=1752489803; i=frank-w@public-files.de;
	bh=siStwAWYKo6n77k71GRZdgIZ15JPl5J741/byKkZ9eQ=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=E37ud7G+9g2YlM9xpGfUF179tz6T8rWvjTuWCcwKDVo2X3fdYe+tcOm4oAXdX9vh
	 tHiL6PUWzBtAg9kjm8WumPYioZ2hziSPebOqacz6CdmIkvpQpQWTeF+wwqwHEYLTk
	 jVnUrIpzilHurw+T6F5SOKaZXO9W+H7Zw3zB/Vjr2lGXXwW5irEg4J66r1J84gbiG
	 9Dbo3OlkKG9TDEK1mSbQ1B2RVv7a542XYqdCYRN9OyF0FkRXW1DhdD+j4L+s65/i+
	 TEbTBC2CVP5QaCrthqUbYg48qe4PMDbUa+9Jk/HBSC6Iy47l7R2l0HQOlZjOQ1Kzu
	 Qlu09EVPT68xt5MuUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [IPv6:::1] ([80.187.119.38]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiacH-1vCTr21Vbj-00h8za; Mon, 07
 Jul 2025 12:43:23 +0200
Date: Mon, 07 Jul 2025 12:43:10 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <linux@fw-web.de>, Krzysztof Kozlowski <krzk@kernel.org>
CC: MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Johnson Wang <johnson.wang@mediatek.com>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v8_02/16=5D_dt-bindings=3A_n?=
 =?US-ASCII?Q?et=3A_mediatek=2Cnet=3A_allow_up_to_8_IRQs?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <90a3191f-882d-4302-afd5-e73e751b5b95@collabora.com>
References: <20250706132213.20412-1-linux@fw-web.de> <20250706132213.20412-3-linux@fw-web.de> <20250707-modest-awesome-baboon-aec601@krzk-bin> <B875B8FF-FEDB-4BBD-8843-9BA6E4E89A45@fw-web.de> <90a3191f-882d-4302-afd5-e73e751b5b95@collabora.com>
Message-ID: <9696BB13-9D1E-48D3-B323-03AD23110CF5@public-files.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eEibhPpTc+nC0XwVozeDH6Yqv088RssljOwOdpNQnoC32fPtW0g
 Sr7vV3t9w1E+Np5DiYmAwyVE8y5aFxvvDHff0VIzxOArLdeSfBoCXCKnWrG+uiSMBxA47MM
 wLzCwrUEP0hVXQgBJ95DKrfxc8QEh+87c5QiRiDk9jpO/YFYZIJu3lNRiYCYGMv8B3iZt+2
 UX8ZEuKRiU3pzy7mdja5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YbRdyvRp4tc=;YgJxQ77T+oektOhqNJA0CRFV95z
 buYk/ZeWNWYh4rnI7JzcSLtR2ThFGCSf/zE04L4BmCwXFG9CL9nj5peQ+w88SLkXCXxEts4NQ
 eZ9ARo6Pfqb6+FmZ9aRrw5Lln1IlrZJjqw3xYx/1aBXLYPQVLskQTPCPasRgC6rD3zMd5dUiv
 GbjNBRftF+PD06zO+iF6ReY0gGvcMUkjwKI0VF55zYAXK+3KA2mJvHPR1EdeQY6q+hocdJ8sE
 rXK76glzulPQcljIANTAvBHjqNu66DlvFvfBaO5bpfU6bxjcIO9oshCg/6qF0yhAiHPLiWdiO
 wAEd8SQjxkdl/MPETL7OdqFtjdTFtvu4LV+odDK5iGhDsbCfDZaZsrKS1VxQx6D7RdrvSTvmq
 lfObgZS24bXmBj1761EO00ts1QwU48su7Q+6X/CDCZTEH3YaLs5M0KTnhgWSCfWqEZXfg9tEp
 CdgHpr1BLdWiDTZ0J40coqdp+xKchKEylELO/EsWTrScTIMdEoJ6h3WWIvvmh3rpj+ZLSVfsy
 /V5yWdIwk89FphlcxQtJ/LowMlhNppxEfUN8mZ13nCbrbNEx0vnXhGNvjU6l7BWMIBai4Esjl
 JQ+gAIaIFVbtrB9ZMNRpRfjWW4r22itjDJ+8J1U+UxZCgBOLLe2YgsbrknFlT8vD4fFl5qCyo
 ih75TNBsDYsGI7wezdbwWSsYeg+iYJEcrdMAcjDFEl/Qly1LrAMii/Ll5941knH8NVOO+1qwN
 W0g/2KmrwU7YSuH9u8AU+vs9e9pqO67E2bKOxFxkmiIK+/NYSAXfaxzLpT6HVGgBWF3fMg5tG
 wLoc7FzgsXU9b00CbdDevO/q+RtmbxyOnNiX1oawEWA6jJofZt2tduR5dfNST0FsS/aV5GvhT
 FSIPfGwP9fDm9yzejsvJLBueGsSKTAjVC+mTvvBjeF4uQewMB0hYEClcCM49/qmZUlxI+QnWu
 XbdaeCwJhvfgVK4BPvA0faAXPZhRDAn24VSf/7Wt8BIT3E3bhZvPlFfG7Fkf6RsFoN6UvAA5X
 B8NweUJ/d/jO5OXuHu5mTLWpPzbNEe24R5iybzqXnvm/CBXWq3BcLP/fzjrw9h48Z7x91B1UT
 dRns9hVrduNrsdKdXkDJ2+d2Yy0/RbUW5j8K6Pl72yKJP5WpDTKoC6giYXRAMaAH9lGdSWcPe
 7TluOmuSnRfj2NTlKkEC85t35LYEt/zkyk4P6eyd2uud/AYenm8OaZRsa1BEbLFhkbngA5qZm
 OXLDqpnlGEavjIvmxo8ZuOEqzozy+hzGXkFN8sSi1xlhStsYZmGPMBhizuPZTl4BzsCL/AjTL
 k3OedjAy+LP/USqKpJpSo4RcsEdY76WqcJsIkHOzZ0oTG2ozsTBCond9R9cAQmhU+nlCbx+xY
 Z/EMdpN6RPNaLB3bp9BXCm0paMmJTQoER3W3jPvrPg7+pDk9vODLO1fVuhcsLldaCMXkNbYSW
 SBokcOKKhsBZcpemWvvBRTPSR6kNL15mDCQD4Q8umSvff3SPsOs0VKslvuiW+QC1jYhfoqJeo
 o3tQY4uv5KdClOaVt55PPQXqJwYwefpOcMXfYf+bJsBISDcR1QLjqEh4VCaN66vt+Obsam0uc
 U7i8tyrv7UzAAJJnuICN6/CxZYrxCQel3ht+04AYzM5Z1uWvaEV2WZxF2ewA/1UQX7unukQhv
 wteDQLaLH7aXT0mO2Jx4z8JFjrEuKliJTFqX/nTj14XbuRoLsTFnPThamPd9pQpy6ru3J6w55
 LA5VhUcc5yYGHIma7qAG/Q6mg+s+lpKG1xHbqsovW0K0zEd+yPGN7tdvMTOdlRpzSF6yKQHch
 yT3mmGDwp4HLeomk5nJ1+amlbMMpHIFnJWzKIEtkX7IFPLMRTZH8gYRS4b1SCjnbHzqPMR8Ph
 k9BEIyBEvwOdgbWtwS2mFaWS2W51CJwFDbhPO3YDaUy+0dvrYjTNHkz349kM4EPQCikQWZQvS
 WA1300/xuRUDEX+szRcqCT+wRfLfLdoTDYA62DS3A0PX2XoFtvpxg6LyQdsngUXqPqEvaOuFx
 vIbKUKRVWk9PvQYZe7EDOCLKwPYzTR5E9ES0+6RiD2ozWDqE+kFYX/yNja9wIhCNJSSrcRVSu
 x7mVix5mUnJtoM08GCDFw6AaDE6wkMRMs+hvtEmNvzUtW4ANLL5RlUu8GvH3RkyZkof+UM4W6
 do5vJcQaHhEWqLPXPSHzRb/zHTl08M7pwU/YZTyP4a+kQv3UAQ8wdrz8oHlBm9VKxE21KG2th
 ZvI/SlrRzkNpTXH8uJjN3jkUSs45lEk2vO3buQuC5vJcsEupdp6on6R6pELBy/S3R/f7CD7eZ
 WpfsNQji9DZHDBRlhysu+Nfg4AkXEWUAIQ5V1sFLMu34I63C6sprzZD5ZrykhuSiwhPdr9OmL
 XJakqUyyQF0nWDXjqaBW0SVW/bx71YMRapZ1DAEUjhU55YllMpXOG8l4i7BpQaIEyxyThIj6y
 xcbQ0WQTTf71PQniCFRSnIKKGkUqDqFfB5i+R+ZB1sjBR3EJh+bK1g3vhjhC+J41vyWQx+nO/
 2Jpywtm23JVO+dNBNgnf+QWtu3CBoRBW3zTm4uuvzMcg9XWpErfvVs3d5UaNp8s0ZMTqmJCbG
 /tidgCTf2RvHap3KfcCVVrzfAQupYrTn/lfmuKjz29bQYQ2YIwtPV6O7FuKDQ53iSd+by7ZJ0
 Skao0c6f3gvDWk/I/wujEpx9fn0QF5T3X8yOyNR0Qy8/aGdtNsy+yOn2pIAF5VYaOrvgoiYFp
 qtrAMquIPvK/N0xDujb9wg+xabSMN9iQGLjmgTxkQTZMbRqF2jcLTRoS4sYl+DEGdqDogP1gZ
 f6/qgzYfivfAmwk3vYEMpZHX1Gaj0fN+z175EDvcBnTkyqh8JiFn6cRQXpYdCpp5Mg78AZUCC
 5b2WVRPskC0AdeQmcXzVmZE0R2XVOyjCUVxH+wkx4EHWCvwfSA476lGyj+7xLBhD6Jj2dPxJ8
 5tQzIoaZX0uNOgi0z5/BWWoxOrX/HkRYOehG5LOHc9KOPuth5yNphFEiaveflIFirsXfSoZcb
 7f897caGS8Fv9oIZX9UcxFGXGOuwnnuGB6Dlapun+ixY80EJBAAKNeDW3KGkHi1BqEuJ8/Az+
 zvBEa4LeGLGxlNndrqOPAxr+3vFJLoSlZsXA5K3tIKtJzrd7oeKFyihn7ubzzDGEg01muAj38
 4V8LnF0+rpfpAOJrn9Mgn6a+zfUN7Lsl74cZl5/pOTd/7ZqHNOdZaP8JZsZghv71AYqNk1OQo
 p+YCdhcvMne/8Eah3gK/X/V9CmNb7wwPKpQBFKDSMtxLgvZzzvTlbLVUJeYlqoHaE3TKS6op8
 WSRLWPKuwINFgFtDmlJWlzt3LllAE00b4yCUd+sXNLayrR5CNPYEMNyz68014oWDk1vuRB+2/
 gmvI387ouHh8KWoaA9IplnsZqIyrO37S+2fsabiu6DluOIz4z58erut4qyIUisOPYXKKiCjYk
 LWz385600IgUDDSoEbKRLNlUAF2AU+UAqwnWkrqL2tRWCaw9qGEGsfBCDeTw4xmDSL5EACcNc
 P7bnOr0H3wJu7oqSs10drVc=

Hi Angelo,

Am 7=2E Juli 2025 12:06:02 MESZ schrieb AngeloGioacchino Del Regno <angelo=
gioacchino=2Edelregno@collabora=2Ecom>:
>Il 07/07/25 09:30, Frank Wunderlich ha scritto:
>> Am 7=2E Juli 2025 08:31:11 MESZ schrieb Krzysztof Kozlowski <krzk@kerne=
l=2Eorg>:
>>> On Sun, Jul 06, 2025 at 03:21:57PM +0200, Frank Wunderlich wrote:
>>>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>>>=20
>>>> Increase the maximum IRQ count to 8 (4 FE + 4 RSS/LRO)=2E
>>>=20
>>> Because? Hardware was updated? It was missing before?
>>=20
>> There is no RSS support in driver yet,so IRQs were not added to existin=
g DTS yet=2E
>>=20
>
>That's the problem=2E It's the hardware that you should've described, not=
 the driver=2E
>
>In short, you should've allowed the interrupts from the get-go, and you w=
ouldn't
>be in this situation now :-)

I have not upstreamed MT7981 or MT7986=2E I also do not want to say anybod=
y else did this wrong=2E
I'm happy that MT7986 is working in mainline=2E It was basicly not taken i=
nto account that these IRQs may be needed in future=2E

The technical documents are often not complete and we get some information=
 step-by-step while testing=2E
Or it was not seen when documents are too large :) many reasons why it was=
 "forgotten to add"=2E
We use what we get from sdk and docs and try to make it compatible with ma=
inline=2E=2E=2E=2Eno optimal process,but it is like it is=2E

We are all humans :)

>Again, it's not the driver but the hardware that you're describing=2E

Frame engine works with 4,but we wanted to do better than mt798[16] and ad=
d all known IRQs
for MT7988 and update the older SoCs in next step=2E

>As long as you are fixing the description of the hardware, even for all t=
hree,
>I am personally even fine with breaking the ABI, because the hardware des=
cription
>has been wrong for all that time=2E

As some patches now are applied i can add the missing IRQs for MT798[16] i=
n next round and=20
maybe the sram too to not having the binding errors long time=2E

>Just don't send those as Fixes commits, but next time you upstream someth=
ing you
>must keep in mind that in bindings/dts you're describing hardware - the d=
river is
>something that should not drive any decision in what you write in binding=
s=2E
>
>We're humans, so stuff like this happens - I'm not saying that you shall =
not make
>mistakes - but again please, for the next time, please please please keep=
 in mind
>what I just said :-)
>
>Now the options are two:
> - Break the ABI; or
> - Allow 4 or 8 interrupts (not 5, not 6, not 7)
>
>and that - not just on MT7988 but also on 81 and 86 in one go=2E

I would add dts patches for MT798[16] in next version adding the RSS/LRO I=
RQs,
interrupt-names and the sram node and set the interrupt minItems to 8 for =
these=2E

>Not sure if the second one is feasible, and I'm considering the first opt=
ion only
>because of that; if the second option can be done, act like I never ever =
considered
>the first=2E

Maybe the cleanest way is like i described above? Afaik second is not poss=
ible=2E

My intention is that RSS/LRO is ONLY working with interrupt-names so drive=
r can handle also=20
old dtb (skip function if irqs are not found via name)=2E

I hope this is a good way to go=2E=2E=2E

>Cheers,
>Angelo


regards Frank


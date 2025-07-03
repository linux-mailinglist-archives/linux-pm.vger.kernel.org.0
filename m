Return-Path: <linux-pm+bounces-30010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC87BAF6C0C
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 09:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 187227B647F
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 07:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2023299AA3;
	Thu,  3 Jul 2025 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="JzhbKh2S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15086298CB7;
	Thu,  3 Jul 2025 07:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751529125; cv=none; b=i7fiHj1lSfbBv/9Bw2a2BUMqBxF84reZ64ARq5M5qTDZ8xXUWJCMvoqOyYXviEtA+n0pvYGS5lW4mw7wLs0Xt1yYPzd8GonS+dKRr6WXUNPOoRjcbgXQA+Ne+Ru/yr9r8+PyMrA9yaZ9PsqxTBUS9Y/70ikGRe0lrzOXuxF7YYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751529125; c=relaxed/simple;
	bh=TIb8Vu1zmttjZ1M0dwM7ar8hOBslW93Xl1m9iCYHcQs=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=GIXcxRWvqNmii5c+KNkcXVdI8dbun5jRCQWhMdR54uB/q+11w9eNOZxJOcqn1jBm5oDalgjYit67TaLIn74FOFR3buSakexgB8kFamJunLgXObVeCGy1blsa1xRpvKG3m+C9JcRzx/n8qtmIYJge4AP+q2uye3twzUzKRh0PRro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=JzhbKh2S; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1751529104; x=1752133904; i=frank-w@public-files.de;
	bh=TIb8Vu1zmttjZ1M0dwM7ar8hOBslW93Xl1m9iCYHcQs=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JzhbKh2SwdXzZM9Ks4J8reStpKuZOQyBvGxhiTwZ+W3Aa9k5MrNrl715l3LP1jjW
	 jfUV9h2zU860mQOZb3G5mX45+EL/53v4p3Gh0ubCwIuBvpz1S/xtOBTU3FYNJGlLq
	 FFUF0RNHktl39DIfrn0V5MY9TuGH+T0GAIdT5dCU9d/pd3zsKHPHjBEP2GGUAm+HB
	 ZghZmcrKZYwhV3wKwcyIYnGdglBdTL8TlUoe9/wqfbIIf+D4dCic3vs2cSYeRDcWo
	 AE+QUIe8FuVAgkvI9HHCsOrK5jLturcTrmgFfpa29bkNOq8dEybT40sJbnfb+ALAI
	 g6T8CbzZNNczXvk28w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [100.71.3.167] ([100.71.3.167]) by
 trinity-msg-rest-gmx-gmx-live-847b5f5c86-wpb8f (via HTTP); Thu, 3 Jul 2025
 07:51:44 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-112cc1ce-74d3-4fd8-a800-e302916dde33-1751529104009@trinity-msg-rest-gmx-gmx-live-847b5f5c86-wpb8f>
From: frank-w@public-files.de
To: krzk@kernel.org, linux@fw-web.de
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
 cw00.choi@samsung.com, djakov@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, johnson.wang@mediatek.com,
 arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, daniel@makrotopia.org, lorenzo@kernel.org,
 nbd@nbd.name, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Aw: Re: [PATCH v7 02/14] dt-bindings: net: mediatek,net: update for
 mt7988
Content-Type: text/plain; charset=UTF-8
Date: Thu, 3 Jul 2025 07:51:44 +0000
In-Reply-To: <24081402-4690-4a1b-a6d0-adab803d0049@kernel.org>
References: <20250628165451.85884-1-linux@fw-web.de>
 <20250628165451.85884-3-linux@fw-web.de>
 <20250701-rebel-mellow-parrot-fda216@krzk-bin>
 <8C311FDD-094A-4F1C-AE26-7E3ABB337C14@public-files.de>
 <24081402-4690-4a1b-a6d0-adab803d0049@kernel.org>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:Y5ZQ8Y1C/j8ZgyHcUkGFJFXJlcCBeb2rydmw7I1JcmLTb5aoJmKZa/IEDJj1c37Qi5y5f
 CdmV/21E99vlXJVPNGgppFsjOEBqrmZnjdXOeecSli/Ktb2cb0So+H9d2MG/b6mJlEi/VCo0w3hC
 5h7V5tCJzvWG+0fGtsqlHu/sRR0kKL90/VbvCmL5p20oS6GCjb93AHx4kPPUBy9MqaRhKASxrj2y
 +tBrYRB3BjvCGL4VbSyPitzOO6WyqHBei0SfyKkLh4vZkPpZSm+udN+KyvVsuMsjDdSaKpuv8UXt
 YU2mZydqBntLo1TNjKeKPesXQ4rzsPf2PtPRUaHPS44Ws3ExTuaiAX+fr3+Cg9Du3w=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5IGurp4wuy4=;61DYLIahmylHpOzMtce5fa0vxtC
 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
 3meBAARWEA==
Content-Transfer-Encoding: quoted-printable

> Gesendet: Mittwoch, 2. Juli 2025 um 08:29
> Von: "Krzysztof Kozlowski" <krzk@kernel.org>
> Betreff: Re: [PATCH v7 02/14] dt-bindings: net: mediatek,net: update for=
 mt7988
>
> On 01/07/2025 12:33, Frank Wunderlich wrote:
> > Am 1. Juli 2025 08:41:42 MESZ schrieb Krzysztof Kozlowski <krzk@kernel=
.org>:
> >> On Sat, Jun 28, 2025 at 06:54:37PM +0200, Frank Wunderlich wrote:
> >>> From: Frank Wunderlich <frank-w@public-files.de>
> >>>
> >>> Update binding for mt7988 which has 3 gmac and a sram for dma
> >>> operations.
> >>
> >> I asked why you are updating. You claim you update because it has 3
> >> GMAC... but that's irrelevant, because it is easy to answer with: it =
did
> >> not have 3 GMAC before?
> >>
> >> So same question: Provide real reason why you are making updates. Tha=
t's
> >> why you have commit msg.
> >=20
> > MT7988 had always 3 gmac,but no dts with ethernet
> > node till now.
> > As i try to upstream the dts,i fell over this.
>=20
> What does it mean? Are you adding new device or not? Nothing explains
> that something was missing.

The binding already exists, but was incomplete. It was added while changin=
g ethernet driver but was not used
because i'm the first person adding mt7988 Ethernet node to devicetree in =
this series.

> >=20
> > Imho changing the regex for the mac subnodes was
> > simply forgotten to be updated on initial mt7988
> > support patch.
>=20
> Fix
> your
> wrapping because
> it is
> difficult
> to follow
> such
> style.

i understand that it is not the best, but i have to manually wrap lines be=
cause neither my webmail nor
my Android Mail-App (K9Mail) supports automatic wrapping (created a featur=
e-request some years ago which
got rejected). I try to wrap it as good as possible, but still manually (o=
n phone it is not that easy).

> >=20
> > I try to rephrase it like this:
> >=20
> > Binding was not aware for 3 MAC subnodes because
> > previous mediatek SoC had only 2. Change this to allow
> > 3 GMAC in mt7988 devicetree.
>=20
> So a fix for existing? Than add Fixes tag, describe the issue and fix
> ONLY that issue.

Yes, binding for mt7988 already exists withing the mediatek,net binding, b=
ut the pattern for mac subnodes
was not updated while adding. So i had to do it before adding the ethernet=
 node to dts in same series.

But yes, i can separate this change again and add Fixes Tag. So just the s=
ram-Property is added in this patch
and i repharse it like this.

> Best regards,
> Krzysztof

regards Frank


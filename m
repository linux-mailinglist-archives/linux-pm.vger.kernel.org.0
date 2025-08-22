Return-Path: <linux-pm+bounces-32923-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CB3B323E0
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 22:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F07580169
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 20:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B69303CAF;
	Fri, 22 Aug 2025 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="Fb/QHsdN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FE928726F;
	Fri, 22 Aug 2025 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755896372; cv=none; b=VTgEbaK5NH+mk/UgDu3XX/F9JUoVI4B8XnVJ2MY5QjTThbKO9wDXGuBosxehL9MlchhIRMFRIJwGIJDNT8TV6xAcBsBfNjZomeEEB7joQc7AyPJCgNzmjkHTvgkFJlEXK2RmUTgMOVozZ94N6qwHCU7ASIjYm8LB+Gc/xt9ER44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755896372; c=relaxed/simple;
	bh=ZO1xB19sLASKZGiZeAMZAeh5CkOBEqS1C10uFP87I88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFXSr9hYooZ9tN6aUunEldxPfpUiNwLAX2VdfX3NWwfwo6DrFTA/tPY4ac/aab6TXBYG682gM59tKMisMjasMUMYYQOT+pbHgERpae8SbZtgTxTs6BgYz8HiT+4FBltzhdLowoGrysapzuBlsR18dH+RWLcyn10bE5LRB1/k7sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=Fb/QHsdN; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=VE6qGcpOBptbfyWtsDbPdbSi5iQYynI3yhAWfcylssU=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1755896360; v=1; x=1756328360;
 b=Fb/QHsdNqricuj3bK2V+FKhmpwu4jcDsV2yXmFGeltNEurS1jCPTBcPPwaC9TlikZNxye+NC
 87pJCNNEelNcsu77cJXshgdZEtBN+t30qGUijM3vjo9jKpPbfiiFHvaGejuKRtP7plDXfs9MOsD
 jHZ0BgPLAqvuaqk+p8RgObq4yJHzPKuJ3pd3K6AUI2EWB6UR0x8oKKdJcbjPwzuIw/qOt+/DM7C
 lC/mpaQyujSqaaDKilZUdqEy+LTEjwjCGq4ZIVEWNMIHVUDBCsa9Sj7duz+lzJM3P7OroO/MU0w
 GsoQ/ECyheEOc8nosjC2Vxh7Y0BRYb09lsHUzjXUNWcoA==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 17a16cd0; Fri, 22 Aug 2025 22:59:20 +0200
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: Rob Herring <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: power: Add Marvell PXA1908 domains
Date: Fri, 22 Aug 2025 22:59:19 +0200
Message-ID: <5013342.GXAFRqVoOG@radijator>
In-Reply-To: <20250822193624.GA187008-robh@kernel.org>
References:
 <20250821-pxa1908-genpd-v2-0-eba413edd526@dujemihanovic.xyz>
 <20250821-pxa1908-genpd-v2-2-eba413edd526@dujemihanovic.xyz>
 <20250822193624.GA187008-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, 22 August 2025 21:36:24 Central European Summer Time Rob Herring=
 wrote:
> On Thu, Aug 21, 2025 at 01:17:44PM +0200, Duje Mihanovi=C4=87 wrote:
> > Add device tree bindings for Marvell PXA1908's power domains.
> >=20
> > Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
> > ---
> > v2:
> > - Drop schema
> > ---
> >=20
> >  include/dt-bindings/power/marvell,pxa1908-power.h | 17 +++++++++++++++=
++
> >  1 file changed, 17 insertions(+)
>=20
> This should be squashed into the previous patch. The Reviewed-by stands
> with that.

Should the resulting patch have a 'dt-bindings: power:' title prefix?

Regards,
=2D-
Duje




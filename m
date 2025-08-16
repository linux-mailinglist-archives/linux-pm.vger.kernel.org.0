Return-Path: <linux-pm+bounces-32467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08899B28ED4
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 17:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3736A7B5F3D
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 15:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8739E2F39BB;
	Sat, 16 Aug 2025 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="TXqIFPiu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43BE22D7A5;
	Sat, 16 Aug 2025 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755357289; cv=none; b=uTqgPwP8uur6mmnDjNn1eG7Ag6gb3/4DrDG35izSJ7kz4pbZFdX2BwNTrrmG10aSV/QN/f1mGi1StLlPJk/8wmr95/dAXo3YnfLngOId2VhnHnxOBRvE+pEtC6SpIjDFnx0ACxsO9bMu0sHujIdbTykpmH0/JaLkq5BkGE3Pkm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755357289; c=relaxed/simple;
	bh=OSQDEVYojpqUsVcDydeFyzVEZCVIa8DW4oEeyDGqo8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myBsYPMH/4jFu07OogdKvXDNXiH68sY1D/VqlBhAEEhkCu9zGfGMbD7XqpFjIgY8+QAmmuZzs0UQNHVu/2wdMJNzNE1k1oR1fdW6qdYACt0EvqfaTGAA44ICDLdo8mzu0/+2+rg14jiSajKFlR3PEnJg+Kec1hll0h4wKRXPiws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=TXqIFPiu; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=OSQDEVYojpqUsVcDydeFyzVEZCVIa8DW4oEeyDGqo8E=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1755357181; v=1; x=1755789181;
 b=TXqIFPiu6ruM8+TZCP7ahhsw6qYop9K/l1fCNrrqliT1uZk7vu1AzGR1/A19LlPkTANLZoEu
 aOhte95klePHknLPz9jeiQ1J8m8KWcUc1qD3YANM04M4R+5VWBwv408nNHpSfhvZqD3o1IudYE/
 5oy/nQtqAeBqojkzXAH6V2Uzy5kvJVOMRVPBenkGd6eL1JY6MgHZftTadmQ3EnqrCFIgt44XpiP
 WI2rJgMDlEz3yd8Nyje075Ns+6LtDmlpKQeXihPAM2dZ/vuzDXp5BH70FaW+orF8e0etwUYrkk4
 Zk4pf5s0w+ttb0XY7QjBJfHZK+MBrwqHddhw9+/QhPdvg==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 12f6888e; Sat, 16 Aug 2025 17:13:01 +0200
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, David Wronek <david@mainlining.org>,
 Karel Balej <balejk@matfyz.cz>, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH RFC 2/5] dt-bindings: power: Add Marvell PXA1908 domains
Date: Sat, 16 Aug 2025 17:13:00 +0200
Message-ID: <6196438.lOV4Wx5bFT@radijator>
In-Reply-To: <5e79b123-b29a-4edb-8e70-3b7fa6cd3674@kernel.org>
References:
 <20250806-pxa1908-genpd-v1-0-16409309fc72@dujemihanovic.xyz>
 <1950265.tdWV9SEqCh@radijator>
 <5e79b123-b29a-4edb-8e70-3b7fa6cd3674@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, 15 August 2025 08:08:24 Central European Summer Time Krzysztof K=
ozlowski wrote:
> On 15/08/2025 00:08, Duje Mihanovi=C4=87 wrote:
> > > I am asking to see complete binding with complete DTS in example and
> > > submitted to SoC maintainer.
> >=20
> > Hm, so if in the example (and the actual DTS) each domain is assigned a
> > clock, can I then keep the domain and domain controller nodes like Medi=
atek
> > and Rockchip have?
>=20
> You would need to point me to specific files or show some code.

Sure, mediatek,power-controller.yaml and rockchip,power-controller.yaml
in Documentation/devicetree/bindings/power.

Regards,
=2D-
Duje





Return-Path: <linux-pm+bounces-12001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE0F94C2F4
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 18:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CABF61F263B2
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 16:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B133190660;
	Thu,  8 Aug 2024 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="eiGqp1bD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C2819046B;
	Thu,  8 Aug 2024 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723135436; cv=none; b=KbVxrzLyb45aZmjVqP19pecA1c0J5l1K66DMjvfWAc7M8yg9aXkW1DpCDwbXsHhTDUKNTR5BnnDixFalHQoM0iJL3Gil+QLItIp43q8Cx3xy4TIjiSdkzz3E5Q+u5RFPB5Wnza2ne7YkGcybzWcVOGqhQPkippdbKuIX/oiRyc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723135436; c=relaxed/simple;
	bh=Wxr9f4h3raHHU0YNiznDsGYPCAwzrA+FuIi8s/SFkmc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MkJ0/4N5yMEY6m4DZoHicgwegWpzIHOpHGQz1Ep/NEnlWwv3v2mTxmMQ8lgX7oeO3QICZxAf1Hu/dUddUYQ6v+4a2uGSzzP3S30rJuvVjD/YXkFvUPkeMXwCr5Si7ef6Ih/slGp03qSBZlkbMIC0aD/eWVzbZ0ZoeRij39w5nbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=eiGqp1bD; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723135425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKlIGGPj13gK8yKpbp3U+LvRWbJSc5NnOp+pssl/vnc=;
	b=eiGqp1bDO1iRcXfgByn26YpBoXRBjhUz/evQL5MbuhNC3NEPvW6e2awJdeHjD6c9Cmcli5
	T22v+igIm4LWS/Z0vzPi7qQpr+zOODRAI8FQzeX/VoTuJpX2TorePmcpkvVClT+T1zTLXt
	Jmc9oz666xX/v+8UVdfNgAJkVoTgFP9yEL3zSt3idBaho/C0gzOADiV0lnv5d4YS6qJF3i
	R5VJ1CeLWlY07jRDRLe5ypFjhOCmmr9lU5SmK5BOCiFtD9P4kCHHANWYBs7FuGELQVbOJj
	Li4dJGA5VMfv3ZUNx6EFcmNHLnGeR6Sm45FR1VFnGq/PiBD8a9z2uW+wfD4WTw==
Date: Thu, 08 Aug 2024 18:43:42 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Detlev Casanova <detlev.casanova@collabora.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Finley Xiao <finley.xiao@rock-chips.com>, Jagan Teki
 <jagan@edgeble.ai>, Elaine Zhang <zhangqing@rock-chips.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: Add power-domain header for RK3576 SoCs
In-Reply-To: <10908017.3WhfQktd6Z@diego>
References: <20240802151647.294307-1-detlev.casanova@collabora.com>
 <e04258dc-07c4-45c7-90d4-bc1ed9eb100b@kernel.org>
 <3310992.44csPzL39Z@trenzalore> <10908017.3WhfQktd6Z@diego>
Message-ID: <0c66dbf97fc5a5adc3831b1ed01e1188@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2024-08-08 09:54, Heiko Stübner wrote:
> Am Dienstag, 6. August 2024, 18:34:41 CEST schrieb Detlev Casanova:
>> On Sunday, 4 August 2024 05:56:39 EDT Krzysztof Kozlowski wrote:
>> > On 02/08/2024 17:14, Detlev Casanova wrote:
>> > > From: Finley Xiao <finley.xiao@rock-chips.com>
>> > >
>> > > Define power domain IDs as described in the TRM.
>> >
>> > Please use subject prefixes matching the subsystem. You can get them for
>> > example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> > your patch is touching. For bindings, the preferred subjects are
>> > explained here:
>> > https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patche
>> > s.html#i-for-patch-submitters
>> > > Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
>> > > [reword]
>> > > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
>> > > ---
>> > >
>> > >  include/dt-bindings/power/rk3576-power.h | 30 ++++++++++++++++++++++++
>> > >  1 file changed, 30 insertions(+)
>> > >  create mode 100644 include/dt-bindings/power/rk3576-power.h
>> >
>> > This is part of bindings.
>> >
>> > > diff --git a/include/dt-bindings/power/rk3576-power.h
>> > > b/include/dt-bindings/power/rk3576-power.h
>> > Missing vendor prefix. This should be named after compatible.
>> 
>> Looks like all other rockchip power bindings use the 
>> include/dt-bindings/
>> power/rkXXXX.h format. Should I keep that way ?
> 
> there is also rockchip,rv1126-power.h , so please follow Krzysztof's
> suggestion. Older header namings need to stay the same of course
> but that shouldn't keep us from updating naming schemes to better
> work in new additions.

Actually, why don't we rename the old headers to follow the new naming 
rules?
Is there something preventing us from doing that, which I'm missing?


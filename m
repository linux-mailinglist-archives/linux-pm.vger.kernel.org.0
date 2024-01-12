Return-Path: <linux-pm+bounces-2170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2EB82C404
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 17:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7B71C21F37
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 16:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D63F7763C;
	Fri, 12 Jan 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DFJ8pldc";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="CnRBQnsS"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4447C7762B
	for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2024 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 81FB6203DE;
	Fri, 12 Jan 2024 11:53:05 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=EQ2JPt5nHh72VPbzX1LWY1iNNn+gGDuBvwvTi9
	aDvpo=; b=DFJ8pldcvCA5UYE1VJQhRhlLe1bX2385MUdMrYOQe0thKf8KyTtXfI
	2CPmftZVvXnjwX6c+bijmKnhh51kIEZCpTEiXaYLuBSrIx3dNC0UGzkOdwHO6kC0
	ki+DjESUUsAqyBkGsysAgUIR5SG9sVPG0Q/yBLlw4VIuS5fE2Xw6Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6B5EA203DC;
	Fri, 12 Jan 2024 11:53:05 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=EQ2JPt5nHh72VPbzX1LWY1iNNn+gGDuBvwvTi9aDvpo=; b=CnRBQnsSAb4IRJou6kjGeDnPo3BJEPk6P7CZceqIAKEmRR1KzhQikH+rEjB8kJeu6/h6kGC9kRa4HP/Ce1ss0y8a9sYRF0rWUTzXFRgyTp9k3hLi86w3elpiPgBnY1Z8Vr3NdZcAJsqN6J4k5tvlm2l3EiI/05pEEMk3enkNOVU=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F168C203DA;
	Fri, 12 Jan 2024 11:53:00 -0500 (EST)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 99327AD7A8C;
	Fri, 12 Jan 2024 11:52:58 -0500 (EST)
Date: Fri, 12 Jan 2024 11:52:58 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 6/9] arm64: dts: mediatek: mt8186: add default thermal
 zones
In-Reply-To: <d11047b4-2a7b-4007-801d-dd9d2955fe02@kernel.org>
Message-ID: <7p9369o6-o5o9-95ps-3126-o761r1qq6s73@syhkavp.arg>
References: <20240111223020.3593558-1-nico@fluxnic.net> <20240111223020.3593558-7-nico@fluxnic.net> <d11047b4-2a7b-4007-801d-dd9d2955fe02@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 0BA51A0A-B16B-11EE-B898-A19503B9AAD1-78420484!pb-smtp21.pobox.com

On Fri, 12 Jan 2024, Krzysztof Kozlowski wrote:

> On 11/01/2024 23:30, Nicolas Pitre wrote:
> > From: Nicolas Pitre <npitre@baylibre.com>
> > 
> > Inspired by the vendor kernel but adapted to the upstream thermal
> > driver version.
> 
> DTS should not go via PM tree, so you need to Cc Mediatek SoC
> maintainers. b4 would do this automatically. Other way is using
> get_maintainers.pl.

Sure. But I'd prefer to have reviews making sure those patches are sane 
enough before spamming more people with this.


Nicolas


Return-Path: <linux-pm+bounces-6251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C1C8A0140
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 22:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801EA1F27A5A
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 20:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD78F181BB5;
	Wed, 10 Apr 2024 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/Jidtmb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF98181BAB;
	Wed, 10 Apr 2024 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780641; cv=none; b=lwcG5fKAp9Npv7480abDI26ke+YdLVVh8N8CT7bInuJnyA8YcHTeZrXgsY5JQQTIHQo2iM9m4fBPDbHLeG00OLuxHGQvrs7aKdBGG4Bep7Q0d6+C9rC8Xt7X0tojxEOwUSlfq5jbXb96PPixQAAW2ILEkIDyMWifcZp1T63Qbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780641; c=relaxed/simple;
	bh=sWg/KbJxC90lruB1AIuChQK3GO6zYnkej0/XpbiRfcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f03nOKHNxoyhl8TiGIQxp8eTVjUqpmbRY5c/e8MuBOnGs1Xa49+d4mR12Gydmmyjs3ACdd7bwZHMsTk0JlpbTXJ52szMcnRObHhWz5eqhq8pzNuK43mukJgxMTN/SPzrCHskJTvs/sjLzLqAsxl0vOHem9wVtB4pveuyhcCU3yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/Jidtmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE937C433F1;
	Wed, 10 Apr 2024 20:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712780641;
	bh=sWg/KbJxC90lruB1AIuChQK3GO6zYnkej0/XpbiRfcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/JidtmbhgDCPRrt4YMse9xoD2smjvZqowOsjvxo836/beLksi7HKo+Sr+mwKtb1a
	 eFZz92n0BSYMyLQVJnDIiBC8mgxw7FInK+k87kgaPVboQNhM3DeTXRYucxn8Swr3n1
	 MnbDN+LCgTd5zalHKDY7QUua4Snu0rByMWMznfE0GWutTeawFnQKChbc36MrtLUI8z
	 13/jzbFJcrVVn/5/FdKqjSpcXCOJKQBnqNhWcJ+hdMuniRYTTU7KwzkRDAYEoc9H91
	 /BqKoSmA6Db58s94pGW/XHrJkgVKJaxPHzPncceVc9DASxprMayu7zCzbnJRln82RF
	 /J0D7ADEUZXlQ==
Date: Wed, 10 Apr 2024 15:23:58 -0500
From: Rob Herring <robh@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	loongson-kernel@lists.loongnix.cn, linux-pm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Binbin Zhou <zhoubb.aaron@gmail.com>,
	Yinbo Zhu <zhuyinbo@loongson.cn>, Amit Kucheria <amitk@kernel.org>,
	loongarch@lists.linux.dev, Huacai Chen <chenhuacai@loongson.cn>,
	WANG Xuerui <git@xen0n.name>, Huacai Chen <chenhuacai@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: thermal: loongson,ls2k-thermal: Add
 Loongson-2K0500 compaible
Message-ID: <171278063662.1282741.14842048022599311146.robh@kernel.org>
References: <cover.1712733065.git.zhoubinbin@loongson.cn>
 <7f6a9ea7ad32584d3d3aa1553e5cc033870fb02c.1712733065.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f6a9ea7ad32584d3d3aa1553e5cc033870fb02c.1712733065.git.zhoubinbin@loongson.cn>


On Wed, 10 Apr 2024 17:49:01 +0800, Binbin Zhou wrote:
> The thermal on the Loongson-2K0500 shares the design with the
> Loongson-2K1000. Define corresponding compatible string, having the
> loongson,ls2k1000-thermal as a fallback.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../devicetree/bindings/thermal/loongson,ls2k-thermal.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>



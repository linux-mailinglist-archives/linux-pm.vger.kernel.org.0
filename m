Return-Path: <linux-pm+bounces-34693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969BEB58651
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 23:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254A91B23A6C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 21:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B366296BDF;
	Mon, 15 Sep 2025 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LD/cGwjr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B3F1E9B1C;
	Mon, 15 Sep 2025 21:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757970273; cv=none; b=o+SsIab8PIEeC3rawbnivfxF0QCrtfdOfnxKVredH3F57tHHuWDG7k4lUkRULiMJ7nZJz+KMAR0i5viP1xi/r7f3kF6BE2GqEBbBbteGjis7vnhEz0QfRRlhPLdeEh8uoXNj6BjDvrNO5C/ciIB1EuFXMNq5z/yDYMNe3C+fULA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757970273; c=relaxed/simple;
	bh=UmLiIB8qN0/00eqy8FuM9tN3FFds3XAu9YaFW+EzaPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeGCEvp3ALEN3YBvc4QAo3QmX/pRTwaIYSXvaHjgl/ubOdn69/NTjLeljnEJJv1paMOJxxQ8TaqnYXELxJvqNtd2+FLsGK2/BkicK5scs84PbjG8PYwcuhMsgGFGVX/1fHI2a75bll9/gIi5TBNgZzbAOnBSqSWDrESzj9ccwMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LD/cGwjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C68C4CEF1;
	Mon, 15 Sep 2025 21:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757970272;
	bh=UmLiIB8qN0/00eqy8FuM9tN3FFds3XAu9YaFW+EzaPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LD/cGwjrGAVqC+iA4IkDrKh5dsnvRF5zsSX2oNAx2xfxEUVnKzTHDbCDrd1ljonRi
	 IvPmqeWtIh6YSUeYsTxYiBngGUJEAx4li4v1O/+G2KgmzsvT/gFQSGMxgh0nvbftK7
	 1l8uiO8KWCwMnphUCXI00ZRtDW9scvuG0+AgqA4IfnvBsslRJNIspB+KODnS0kzpui
	 YcGlUmj2oS9FKwoAoz167+8ev67tPVAHBbYpjV1Sy7t/GUTdOC+5wJ5fufo66gv9yd
	 5kROWpWM6SKEP+gyJ8IXYr1W8veRbE0EwGXPLQ/vpQL9wRfLCT90ZmA6bMfA5D5SbK
	 GvbgZMgas2Zmg==
Date: Mon, 15 Sep 2025 16:04:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 1/1] dt-bindings: power: supply: bq24190: document
 charge enable pin
Message-ID: <175797027095.3390698.12269460822380409041.robh@kernel.org>
References: <20250912065146.28059-1-clamor95@gmail.com>
 <20250912065146.28059-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912065146.28059-2-clamor95@gmail.com>


On Fri, 12 Sep 2025 09:51:46 +0300, Svyatoslav Ryhel wrote:
> Document active low Charge Enable pin. Battery charging is enabled when
> REG01[5:4] = 01 and CE pin = Low. CE pin must be pulled high or low.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  Documentation/devicetree/bindings/power/supply/bq24190.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



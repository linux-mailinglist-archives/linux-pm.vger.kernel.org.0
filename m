Return-Path: <linux-pm+bounces-20266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB02A0A305
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 11:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D52B16B5C8
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 10:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8835191F91;
	Sat, 11 Jan 2025 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnl2GkCd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E58514E2C2;
	Sat, 11 Jan 2025 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736592828; cv=none; b=TK+qIWE2VXJC9nDyfOyxVXJPB43GlnXWXathbxc3e73OKDgY+eK6lpL+F1oLWw7i/QEXno3mWy935d6gOk7MgGE8q4h/7TK4LGb807LcJQyfCa0LrD7NVdwj/BPRqwsxno/0oTVIUtFZ2HdHP4IfI4hPTICILyRmAgb3FQtLTIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736592828; c=relaxed/simple;
	bh=aqIVbF3SBzkWZBzKcKhyzQbX0QdrwHSu4fNE0AfSonY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Euonj/VZDMn5iKl7Ch4bDIKguC64FQ4+PTFw9pQWC5K0wSf54TgLjXm8uHt+DxBaamNbB8xIP2ir+C9whVmKEXvmHalv+Y6cdExy+er1S2kNZCTyOOef0aaf0xuBa9OhaFaEktqVRmCSvMuiFgMmqEX+hLduF70HuEzdAlS5lOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnl2GkCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE30C4CED2;
	Sat, 11 Jan 2025 10:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736592828;
	bh=aqIVbF3SBzkWZBzKcKhyzQbX0QdrwHSu4fNE0AfSonY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qnl2GkCdOf7weqN7aJYpWWkeSOTIxaD9zERYme36XLlOENVZ2SMX+33B6WaHej/c3
	 ynX0pkQUZ3bnGqMdGb1EMdir1FLHgytGC9QnoZ6Dzydei5fgjXRxhI5IZC/W9J5Z8t
	 0ZDy03yb/H0UJ+wd2P/1qAVXojITrMPcDnO1qh9CuJz11o7l5dg4aA54fJ1U0B99gX
	 X4lown6j/ZcRdzgELMJNQD9/00iPeKIpMCN6IKxLs8U5VqxXeFAn7FkP9LuQV3iGfg
	 tYKMvCthRHOMcI6MEHUeWJQdlK2Mx6OspIcphVNSwRP8Q6ZOUFhGrDiyBpUGn3XWwM
	 bBfbRoXVoYJYg==
Date: Sat, 11 Jan 2025 11:53:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sibi Sankar <quic_sibis@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: interconnect: OSM L3: Document sm8650
 OSM L3 compatible
Message-ID: <rbli5mbu6mnkkxku2iy6px22kcc5fuc37s2fzydokxho5irilq@ozucrwzgrs4t>
References: <20250110-topic-sm8650-ddr-bw-scaling-v1-0-041d836b084c@linaro.org>
 <20250110-topic-sm8650-ddr-bw-scaling-v1-1-041d836b084c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250110-topic-sm8650-ddr-bw-scaling-v1-1-041d836b084c@linaro.org>

On Fri, Jan 10, 2025 at 04:21:18PM +0100, Neil Armstrong wrote:
> Document the OSM L3 found in the Qualcomm SM8650 platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


